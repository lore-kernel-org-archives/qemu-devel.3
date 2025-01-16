Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613CBC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 19:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYV8Z-0006Gt-VS; Thu, 16 Jan 2025 14:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYV8S-00068X-IC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:02:33 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYV8O-0006dm-Mx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 14:02:32 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862d161947so743700f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737054143; x=1737658943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fuRyw5EWWx6Yp+3IBCpdAz3q5PYO8xyuKBCIsOMef9E=;
 b=RMYzBDwwm3po1f1i0K3RYhwuzekPYE6LqZw3WgVj81Kf6VnA7VKUWHuC5WqIzNLm/p
 ZW5vNmt7mPHMAq6bN2VtT2iObw4SfLpAiaJ51V5caXjPa7mgRzXMNo4v3juPNTg44g39
 VeksL/syJSed4+eAE8XWV60ibv6xxXpzFEykXleaj+gdMP+cpLKP3V6xTPp5JN+k0xKx
 6gwgHXA29AooGieqyj+5/xC+7Axm66iTHHPix73f8fo5kLEn2T/IXx0v6Zqbnh/npcpd
 +wTMNyiOX7QWfgezEiOVr+PjR62Nsc4qrb4Xw1o9CR/lvOGRp1RFG2F+yKBKsAaSPotw
 J6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737054143; x=1737658943;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fuRyw5EWWx6Yp+3IBCpdAz3q5PYO8xyuKBCIsOMef9E=;
 b=wPwsZWeREe3Yp3vz3sszqCtgl4IZPHKTdAlbDFEvQBHjjrEw0PjvU7kNDkV7W2CIiE
 m0DGBhLPnSGbgncx1G4qBhmBXf9nxiK8y6TEhcDgsDivw2GqRIl6GuOTY8y81GO+L7+i
 KDXRvwd8FjPT5FbojIWSJ3BNRg37V8975cXxLfdzJYLXxUO6L93+kybZOSSxv06HPKeU
 7VlTEJ+wr/HcQnU9/sb7+EUw7lVWPWsClbAwzK5i1PT6DAhrSnL+orX8tCNq2L4luOyw
 qNK0iazoD7/NE3cLdDCb4ykaP1Tbgza5Jfr5XCUWhskzKuUKRxIkYnRAu/+yqA0wenjN
 UZxw==
X-Gm-Message-State: AOJu0YxLrHHJ0IbMmbyv0pXdDLBeD+BPfuG8Kca3r7Q7v6D+4F+Et+mM
 H72h4smywHwMilsQydOLuDHDcE3TDQWPdL3pL2W5wLY5sN5eZKIOOBV7jHnJXOI=
X-Gm-Gg: ASbGncucCx8MxbrvXig3o6Pxky/gHEMj6D1iqAUY/9vsvVGgtkJPYEzveC5S/+FDOij
 VRZz5VyWmZfkNRHAoNkNjRFPyBTUJ4pTrFu/4HOmzZB8CotcWAAicR3Eq7OQ4h0tF1+aBx6UlQ8
 2aa/TbL/JgG+OpDoONOk3iL0/W6uLA1SBZCP6L7jHlMmLSKdOvVWX2zqiZruZzVkF7IZMUstW7p
 4VmM+iY2FQdr4PLLDFzInr0lqMlX0OSAU4G0uc8PsemYob57UxSmZQwwBNr1z+T5fjfEfwfgGhu
 NLszd9tvPLSXrYuelQbIVpsl
X-Google-Smtp-Source: AGHT+IEcSQubzWb3CBuT1dMQ1/yjGUHi79uHcxM8wbngetpI0P1jFH07ZTZYoEfZXlXddWqceC+h5Q==
X-Received: by 2002:a5d:64a8:0:b0:385:e429:e591 with SMTP id
 ffacd0b85a97d-38a8730a6bdmr34444859f8f.23.1737054142828; 
 Thu, 16 Jan 2025 11:02:22 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890421fabsm7885525e9.24.2025.01.16.11.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 11:02:22 -0800 (PST)
Message-ID: <b55ea724-cdc7-4e8c-a954-b10a1cde9bdd@linaro.org>
Date: Thu, 16 Jan 2025 20:02:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] exec/cpu: Call cpu_remove_sync() once in
 cpu_common_unrealize()
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Marek Vasut <marex@denx.de>,
 David Gibson <david@gibson.dropbear.id.au>, Brian Cain <bcain@quicinc.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Claudio Fontana <cfontana@suse.de>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-ppc@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alessandro Di Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Chris Wulff <crwulff@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 Luc Michel <luc@lmichel.fr>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>, Stafford Horne <shorne@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>,
 Michael Rolnik <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-7-philmd@linaro.org>
 <20231128174215.32d2a350@imammedo.users.ipa.redhat.com>
 <5f25576c-598f-4fd7-8238-61edcff2c411@linaro.org>
Content-Language: en-US
In-Reply-To: <5f25576c-598f-4fd7-8238-61edcff2c411@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/1/25 19:05, Philippe Mathieu-Daudé wrote:
> On 28/11/23 17:42, Igor Mammedov wrote:
>> On Mon, 18 Sep 2023 18:02:39 +0200
>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>>> While create_vcpu_thread() creates a vCPU thread, its counterpart
>>> is cpu_remove_sync(), which join and destroy the thread.
>>>
>>> create_vcpu_thread() is called in qemu_init_vcpu(), itself called
>>> in cpu_common_realizefn(). Since we don't have qemu_deinit_vcpu()
>>> helper (we probably don't need any), simply destroy the thread in
>>> cpu_common_unrealizefn().
>>>
>>> Note: only the PPC and X86 targets were calling cpu_remove_sync(),
>>> meaning all other targets were leaking the thread when the vCPU
>>> was unrealized (mostly when vCPU are hot-unplugged).
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/core/cpu-common.c  | 3 +++
>>>   target/i386/cpu.c     | 1 -
>>>   target/ppc/cpu_init.c | 2 --
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
>>> index a3b8de7054..e5841c59df 100644
>>> --- a/hw/core/cpu-common.c
>>> +++ b/hw/core/cpu-common.c
>>> @@ -221,6 +221,9 @@ static void cpu_common_unrealizefn(DeviceState *dev)
>>>       /* NOTE: latest generic point before the cpu is fully 
>>> unrealized */
>>>       cpu_exec_unrealizefn(cpu);
>>> +
>>> +    /* Destroy vCPU thread */
>>> +    cpu_remove_sync(cpu);
>>>   }
>>>   static void cpu_common_initfn(Object *obj)
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index cb41d30aab..d79797d963 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -7470,7 +7470,6 @@ static void x86_cpu_unrealizefn(DeviceState *dev)
>>>       X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
>>>   #ifndef CONFIG_USER_ONLY
>>> -    cpu_remove_sync(CPU(dev));
>>>       qemu_unregister_reset(x86_cpu_machine_reset_cb, dev);
>>>   #endif
>>
>> missing  followup context:
>>      ...
>>      xcc->parent_unrealize(dev);
>>
>> Before the patch, vcpu thread is stopped and onnly then
>> clean up happens.
>>
>> After the patch we have cleanup while vcpu thread is still running.
>>
>> Even if it doesn't explode, such ordering still seems to be wrong.
> 
> OK.
> 
>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>> index e2c06c1f32..24d4e8fa7e 100644
>>> --- a/target/ppc/cpu_init.c
>>> +++ b/target/ppc/cpu_init.c
>>> @@ -6853,8 +6853,6 @@ static void ppc_cpu_unrealize(DeviceState *dev)
>>>       pcc->parent_unrealize(dev);
>>> -    cpu_remove_sync(CPU(cpu));
>>
>> bug in current code?
> 
> Plausibly. See:
> 
> commit f1023d21e81b7bf523ddf2ac91a48117f20ef9d7
> Author: Greg Kurz <groug@kaod.org>
> Date:   Thu Oct 15 23:18:32 2020 +0200
> 
>      spapr: Unrealize vCPUs with qdev_unrealize()
> 
>      Since we introduced CPU hot-unplug in sPAPR, we don't unrealize the
>      vCPU objects explicitly. Instead, we let QOM handle that for us
>      under object_property_del_all() when the CPU core object is
>      finalized. The only thing we do is calling cpu_remove_sync() to
>      tear the vCPU thread down.
> 
>      This happens to work but it is ugly because:
>      - we call qdev_realize() but the corresponding qdev_unrealize() is
>        buried deep in the QOM code
>      - we call cpu_remove_sync() to undo qemu_init_vcpu() called by
>        ppc_cpu_realize() in target/ppc/translate_init.c.inc
>      - the CPU init and teardown paths aren't really symmetrical
> 
>      The latter didn't bite us so far but a future patch that greatly
>      simplifies the CPU core realize path needs it to avoid a crash
>      in QOM.
> 
>      For all these reasons, have ppc_cpu_unrealize() to undo the changes
>      of ppc_cpu_realize() by calling cpu_remove_sync() at the right
>      place, and have the sPAPR CPU core code to call qdev_unrealize().
> 
>      This requires to add a missing stub because translate_init.c.inc is
>      also compiled for user mode.

See also:

commit 5e22e29201d80124bca0124f2034e72b698cbb6f
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Wed Jun 13 12:08:42 2018 +1000

     pnv: Add cpu unrealize path

     Currently we don't have any unrealize path for pnv cpu cores.
     We get away with this because we don't yet support cpu hotplug
     for pnv.

     However, we're going to want it eventually, and in the meantime,
     it makes it non-obvious why there are a bunch of allocations on
     the realize() path that don't have matching frees.

     So, implement the missing unrealize path.

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index f4c41d89d6d..f7cf33f547a 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -186,6 +186,26 @@ err:
      error_propagate(errp, local_err);
  }

+static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
+{
+    qemu_unregister_reset(pnv_cpu_reset, cpu);
+    object_unparent(cpu->intc);
+    cpu_remove_sync(CPU(cpu));
+    object_unparent(OBJECT(cpu));
+}


