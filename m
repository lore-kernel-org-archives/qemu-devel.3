Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A2E9A037
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 19:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsQVN-0006Mn-Cd; Tue, 17 Feb 2026 14:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vsQVG-0006M1-JZ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 14:12:58 -0500
Received: from k62.kb8c70eb.use4.send.mailgun.net ([204.220.184.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1vsQVB-0006P8-FU
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 14:12:54 -0500
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 47e0964333549dd0ef84bfdffdba1b26ce21007ec1f225a30a3990930689c101 with SMTP id
 6994bdb21ef92bcfe06d42a9; Tue, 17 Feb 2026 19:12:50 GMT
X-Mailgun-Sending-Ip: 204.220.184.62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1771355570;
 bh=mWaeqor9yCiQWAu2J7SvCCUNKzJ9776KqQLA/ABFPE8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=S9n398+IV2C0BPbUeM1/P6zwVE2lRi8FxmRm4myWSLLc0MIrZB4m9laJY+v5uq7ae
 dY6nitGcUiMQLVuP88t1PvMoVY008kQJbP0cZ0mq8aGki9mepRucAPbqfKKmFCKyyX
 KIVdIYr0XxCJkQDqaS/7QvXqlzzjr0epVCHes9fCVygD7fXbn6Wv4i6Q1RE8PzJEY4
 qQkJ2CrLhhcYaNnzhl94J05+cZAMfu4YpfPMgQON5O84i3cYBIAjTVhdlCcOuAyvMC
 6p1chvufF7Xs8o9UjdHWwBJuXT5ND06Kb5Cbvz6OYQh1kTajwumWoLUDX0vEqK8E/1
 89rCpAtFZBk3A==
Message-ID: <385d1a8e-c202-4d72-a24a-1e49478278b4@yodel.dev>
Date: Tue, 17 Feb 2026 13:12:48 -0600
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
To: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=204.220.184.62;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=k62.kb8c70eb.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+Philippe

Hi,

On 17/02/2026 03:21, Peter Maydell wrote:
> On Tue, 17 Feb 2026 at 06:35, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> alpha_cpu_realizefn() did not properly call cpu_reset(), which
>> corrupted icount. Add the missing function call to fix icount.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---

So, the real culprit was hiding in plain sight in Alpha-specific code
all along? Congrats on finding it!

>>   target/alpha/cpu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>> index 1780db7d1e29..74281ebdb367 100644
>> --- a/target/alpha/cpu.c
>> +++ b/target/alpha/cpu.c
>> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
>>       }
>>
>>       qemu_init_vcpu(cs);
>> +    cpu_reset(cs);
>>
>>       acc->parent_realize(dev, errp);
>>   }
> 
> Realize functions shouldn't call reset on themselves.
> For CPU objects it is currently the responsibility of the
> board code to arrange that the CPU objects get reset.
> 
> thanks
> -- PMM
> 

I think the following addresses Peter's remarks; it passed 100
repetitions of the Alpha replay test after reapplying the reverted
commit:

diff --git hw/alpha/dp264.c hw/alpha/dp264.c
index 5e64528431..091ffc0085 100644
--- hw/alpha/dp264.c
+++ hw/alpha/dp264.c
@@ -68,5 +68,7 @@ static void clipper_init(MachineState *machine)
      memset(cpus, 0, sizeof(cpus));
      for (i = 0; i < smp_cpus; ++i) {
-        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
+        CPUState *cpu = cpu_create(machine->cpu_type);
+        cpu_reset(cpu);
+        cpus[i] = ALPHA_CPU(cpu);
      }

I haven't tested Philippe's suggested code, yet, but will begin shortly,
although it may take me a while as it's more broadly scoped in terms of
affected code (and the problem it addresses).

Thanks,
Yodel


