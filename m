Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B00CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSI3-0006L1-CR; Tue, 19 May 2026 17:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSI1-0006Ea-Tx
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:47:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSI0-0003Yo-7B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:47:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso35346295e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779227266; x=1779832066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FjpJu0sNPGdi8Yz+4GqZMAgusGAMTR0k19C32x/7CnM=;
 b=L9qJrEEeJJx1DlYibBUnIcppef9W2ZF374nbSLv9JLLVZy7BEaPO/GjIL4t/pUagh4
 BPizHqB8Ped1ntkg90ltP67NBcrAK9aGAIJx3gUFm/q25vrsfswoXVF0c17XgwoqXI6R
 7JDVNXRScU0FnUdhYwKCrhhMt04x2hHbn67QJRhz2Ypcx6K/bQhAPyaJb0PM3g042MeI
 2IoUT5TtKscK8yYsN50rHWcFJ5gYcOicmG246GGcSP6gol3UAHWxu1e89N7d8bDeIlIX
 jS4SxOmXd3kOzawawUCTtReG+aDCpVvVrnCBn8rA5ulJx1LQe7GEZPkPP+XF+ZoXRfQu
 y0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779227266; x=1779832066;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjpJu0sNPGdi8Yz+4GqZMAgusGAMTR0k19C32x/7CnM=;
 b=SxMsf6Ezen4hey//b8Ewtm3WoTh66JVPBopcj0uNloPstPQthW0b+KaYfFF5qJ2l26
 hu7r+uF5zx1B78dZzcAHsk+roQKVk/hO5R+E865VuFDy5URSYbDApNtWyBTiSdJ5yXGH
 A6Wbk3yMNhxi+kRZXRUU2Ni1o3X+97WzGw97g9fkb013XGi4G+PMkJswgvyIRnE87Zgc
 bKfa8ULSXSz1atoDE3W1GzHdjcdjOfQWa92vBPN5I6/pj25h3Z5PQk6VNbDL4M7r6NvT
 D6R397LFHYNHED6+S+EGMj2hyTUCDJJ2CdKN6hjajjqeLUnM2G9UX8JxHm7oDq9ci8si
 9A9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ87UkQ+L3acCjePqxizRShZ2zR3tDY5QhfCcpwBswQEQa7TCCkgiGYRRQHsRANTEFYoz15fDymmjyG3@nongnu.org
X-Gm-Message-State: AOJu0YwQmH1CI8ZjbIt5CuF2+HqCeeCk0ft6SPSp/Sv1feuUA4DHZhvp
 2+gmLHUpdCWlnpvwuJStiNH73WtRk/2S+jl+TX9mCXtkYSSXQe+1HTqwnkIcmI6D+Ho=
X-Gm-Gg: Acq92OEbTgLMNhl0D8eBaTXEwqehM/Rvl57MlPeo9MU8YsSrgwuhFWPxCzZ8JgA0Ge2
 rGBtrwbOA2YxMgvXaOkAiujjlUsbb3Ocv2rT6O9vyXNnwaQ85h0i2INY6ENIgApoGHFXh1eVgFH
 G+5BehA14wgOSG8PszOfyVsESrtx9wkzGQB78OEguH6fIxVhtbrBvNEYb3D97GDtKDHYNZ7Zbsk
 VJo2v3/krt061UMxPCWUxneH+Rz+3ErUVU/Des9lWgvPNNclE9KKDB/pdjSSuixVkAwdiLnJOJF
 ipCwUMniOF0uW27O8z4xGh/PMEE9nE+TROCKN6Bv56iDbbTj8GsBws7hjNB/JzzEIuqHxusiBiG
 opUl1RPhGjwR59QP/nL7H6230x5Zp/CBPt1+cK2DLpjWUKn0+6nt35FLuPEURZ+zY9Fo2AOiKVN
 2N5xEhnWsMh4rNbBXabjbX+r6HF3UnZoEEC+gzg8PkPgbXEz+KNlcfrPhJBbIsLqP7ig==
X-Received: by 2002:a05:600c:8592:b0:48a:7aad:4425 with SMTP id
 5b1f17b1804b1-48fe60e5235mr245168145e9.3.1779227266576; 
 Tue, 19 May 2026 14:47:46 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768acesm52107774f8f.7.2026.05.19.14.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 14:47:45 -0700 (PDT)
Message-ID: <2aaa4dfc-cf5d-4381-9c77-d78679819ba7@linaro.org>
Date: Tue, 19 May 2026 23:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv1 6/7] hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, shentey@gmail.com,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-7-gaurav.sharma_7@nxp.com>
 <28c31997-b4db-436c-bff7-12ead07254fd@linaro.org>
In-Reply-To: <28c31997-b4db-436c-bff7-12ead07254fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 19/5/26 23:45, Philippe Mathieu-Daudé wrote:
> Hi Gaurav,
> 
> On 19/5/26 19:56, Gaurav Sharma wrote:
>> Configure the i.MX8MP to boot the Cortex-M7 core alongside
>> the Cortex-A53 cores in an Asymmetric Multiprocessing (AMP)
>> configuration. The M7 firmware can be loaded and started from Linux
>> running on the A53 cores via the remoteproc framework.
>>
>> CM7 boot is made optional. A GPR IRQ is connected to a cpuwait handler.
>> The handler translates the CPUWAIT into STOP and RUN.It follows the
>> classic Cortex-M boot sequence: initial SP and reset vector taken from
>> the vector table.
>>
>> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
>> ---
>>   docs/system/arm/imx8m.rst   |  86 +++++++++++++++++++++-
>>   hw/arm/fsl-imx8mp.c         | 143 ++++++++++++++++++++++++++++++++++++
>>   include/hw/arm/fsl-imx8mp.h |  13 +++-
>>   3 files changed, 240 insertions(+), 2 deletions(-)
> 
> 
>> @@ -72,7 +155,8 @@ For i.MX 8M Plus EVK:
>>   .. code-block:: bash
>>     $ qemu-system-aarch64 -M imx8mp-evk \
>> -      -display none -serial null -serial stdio \
>> +      -display none -serial null -serial stdio -serial null -serial / 
>> tmp/imx8mp-uart4 \
>> +      -smp 4,maxcpus=5 -global fsl-imx8mp.enable-cm7=on \
> 
> Not a blocker; I wonder if this is a good use of the -smp/maxcpus
> (thinking about long term AMP modelling).
> 
> Maybe we could use a machine property for the M core, and keep the
> smp default value to the A core cluster:
> 
>    -M imx8mp-evk,enable_cm7=on -smp 4

I missed you already add a machine 'enable-cm7' property in this
very same patch :)

  static const Property fsl_imx8mp_properties[] = {
      DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
      DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, 
phy_connected, true),
+    DEFINE_PROP_BOOL("enable-cm7", FslImx8mpState, enable_cm7, false),
+    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpState,
+                       cm7_vector_base, 0x80000000),
  };

> 
> But IMHO even better is to always create all cores like on real
> hardware. If the M7 is not used it is just sitting here, created
> and halted, not disturbing anything. Personally I'd rather not
> accepting any -smp option for such machine, just reporting an
> error if used "Can not restrict this machine, it is always
> created with 4 Cortex A and 1 Cortex M".
> 
>>   static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>>   {
>>       MachineState *ms = MACHINE(qdev_get_machine());
>> @@ -277,6 +368,23 @@ static void fsl_imx8mp_realize(DeviceState *dev, 
>> Error **errp)
>>       const char *cpu_type = ms->cpu_type ?: 
>> ARM_CPU_TYPE_NAME("cortex-a53");
>>       int i;
>> +    if (!s->enable_cm7) {
>> +        object_unparent(OBJECT(&s->cm7));
>> +    } else {
>> +        /*
>> +         * When CM7 is enabled we need one additional vCPU
>> +         * slot. If the user does not specify maxcpus=,
>> +         * QEMU defaults maxcpus to the current -smp count.
>> +         */
>> +        unsigned int need = ms->smp.cpus + 1;
>> +        if (ms->smp.max_cpus < need) {
>> +            error_setg(errp,
>> +                       "CM7 enabled requires -smp %u,maxcpus=%u (one 
>> extra vCPU slot for CM7)",
>> +                       ms->smp.cpus, need);
>> +            return;
>> +        }
>> +    }


