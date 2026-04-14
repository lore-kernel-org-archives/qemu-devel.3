Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F7BED7B91
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCa2F-0003j3-VD; Tue, 14 Apr 2026 05:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCa2E-0003iu-Vz
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:26:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCa2C-0003O0-UG
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 05:26:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so5359196f8f.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776158773; x=1776763573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wg0GlMQGOvVBOcb3NEcGxnHstHUff6kWFznPEsSj80s=;
 b=kVDznVT1U8ZbPvy/IjvFDdNoa/KYPfOH5NBeGKEyggpXXSnoF64ma15YdQKFeDMjci
 WWksFmmUeKZ4g5GL0inwpeBBpWPxceCOGL5p1e066FCOrAtO2daOzaLN5LQBCAJFuG+/
 l5VhhScd8WOksoBNjvdURAaqsj6wR7AigFu3BH3fSQYlaUJpCwG1YuVPsHBXTs8cu2JT
 CbX6N6z7NEhyjIAq+ZgGgdVr1onWPtq7vfh77TmDn/wfMX3db4Q+9WyJO2EQuuRqUUAP
 xnc/lzMAxATMbacQYiyZvJJWriVCWrArla6aSnaIzJmu8JK36E/hh4Pa++Lm+URtYjBn
 gZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776158773; x=1776763573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wg0GlMQGOvVBOcb3NEcGxnHstHUff6kWFznPEsSj80s=;
 b=W6gnlu/+PBRcuGu4XRWvH+2t5VqEv2B7UMmy8MDEjkVaowZe94AM8mpfUqU+2OeZdz
 6KLfLYJYKOTPNYXsQ2F0mB97E9l3h9PrZXoomKQNOsl9nyGZwF4wHJCZOmIKZ8ou3uaa
 nQhtqvqXDaOyAUMNX76GPv0wJiEMvOoTl37fGkRkhhVqRHrakfOJPr39hJkssFRM3OyV
 X5M4sbxlMyIDBBupI54HF6LQR8CQuuz5d1DVL9jxyki8eJWdCZzMn2m/92A2yW23Igwh
 WvQDn/egqrIjkBIR01c16n6Ywiaj+yM5wM2AabBgd2lSMdx7D4tLCB/TUz0+kJgfQiry
 RIqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cr+SezPOS64+Rer3jC158YTA23460hyQtaAOmndguWxez3VRGZXSwMbCa7ZDirB6SUk0DLkGBZVYY@nongnu.org
X-Gm-Message-State: AOJu0Yx+24StDEnoYDG15a1sRmlfvlKLjuSVCI4C/YlRoy9KVZZ6a2zk
 N1ib9Slbh0nnOMG1LbD5c3z/1hiZE4wFcLCLY+DoeuGJHEKdzHW6hW3FAQjgYbIUYF4Hsl40Rdd
 sYGVy2hQ=
X-Gm-Gg: AeBDiesdzn1LcaGYeUUFZEWR7oUO0KR8QVdaP/QuXUw9S0ckcAdC4OdsMJgMK4Huryu
 VW2fw/gr/naNnvTyye47HjoFpvpDdnr2t1/xc5M03562Gl91r5sPgMOBjHlietF/TUgQxqwdjFq
 bvVQfwczw3WK4UgQpDhHUJXe8FdxdmkJHSQlhoEyQU+DPKWv2CcXriiITnAxznybPx6INnStBcE
 PzUjtLbJ09h7QcXKF4Su3wX+W30iGipTl2JEFzYZp+ZTB0dSvVkkKutaxu47Tl+18gY1P5o8CVs
 a2SqqIBaTZfH8ykB+wiedBgBKYWbbbZyOLaXsSY0yzwd07MLqmkTXnpJfzT9kTCmjeira972cSR
 Q88FIVGn6d8GK5GDn9KfDX/ff2KMJun0zR8fi2DJBRgAk7LyBCjmPBaC8Zy0RNmJCO0joFoeRvS
 9AdAVaLUTPGhE1hz8AusgGR7ISHlcnvlhpB6/1PZmKpfJWliJW4eIitn1eXIlXC19Q7A==
X-Received: by 2002:a5d:5d02:0:b0:43d:1df7:ed24 with SMTP id
 ffacd0b85a97d-43d642a64b1mr24141577f8f.21.1776158772653; 
 Tue, 14 Apr 2026 02:26:12 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7400708dsm21467285f8f.25.2026.04.14.02.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 02:26:11 -0700 (PDT)
Message-ID: <e9536f25-a027-4961-8bae-cb34c74c979a@linaro.org>
Date: Tue, 14 Apr 2026 11:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] hw: q35: fix VGA text console with SMM disabled
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260413170407.57574-1-mohamed@unpredictable.fr>
 <a55bac0f-dc63-4541-aad5-40214c6691a5@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a55bac0f-dc63-4541-aad5-40214c6691a5@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 14/4/26 09:31, Michael Tokarev wrote:
> On 13.04.2026 20:04, Mohamed Mediouni wrote:
>> Work around black screen in VGA mode with SMM disabled.
>>
>> Required by NVMM, HVF and WHPX backends.
>>
>> https://gnats.NetBSD.org/59721
>> https://gitlab.com/qemu-project/qemu/-/issues/2608
>> https://gitlab.com/qemu-project/qemu/-/work_items/3085
>>
>> Patch written by Taylor R Campbell <riastradh@NetBSD.org>
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Since this is effectively a reworked-for-later-qemu my patch from
> https://lore.kernel.org/qemu-devel/3458e5b7-b53e-4057- 
> baea-03a729452255@tls.msk.ru/,
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> Cc: qemu-stable@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Thanks,
> 
> /mjt
> 
>> ---
>>   hw/pci-host/q35.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>> index e85e4227b3..05ef5222f7 100644
>> --- a/hw/pci-host/q35.c
>> +++ b/hw/pci-host/q35.c
>> @@ -372,6 +372,10 @@ static void mch_update_smram(MCHPCIState *mch)
>>           memory_region_set_enabled(&mch->high_smram, false);
>>       }
>> +    if (!mch->has_smm_ranges) {
>> +        goto out;
>> +    }
>> +
>>       if ((pd->config[MCH_HOST_BRIDGE_ESMRAMC] & 
>> MCH_HOST_BRIDGE_ESMRAMC_T_EN) &&
>>           (pd->config[MCH_HOST_BRIDGE_SMRAM] & SMRAM_G_SMRAME)) {
>>           switch (pd->config[MCH_HOST_BRIDGE_ESMRAMC] &
>> @@ -405,7 +409,7 @@ static void mch_update_smram(MCHPCIState *mch)
>>                                 mch->below_4g_mem_size - tseg_size);
>>       memory_region_set_alias_offset(&mch->tseg_window,
>>                                      mch->below_4g_mem_size - tseg_size);
>> -
>> +out:
>>       memory_region_transaction_commit();
>>   }
>> @@ -474,15 +478,15 @@ static void mch_write_config(PCIDevice *d,
>>           mch_update_pciexbar(mch);
>>       }
>> -    if (!mch->has_smm_ranges) {
>> -        return;
>> -    }
>> -
>>       if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
>>                          MCH_HOST_BRIDGE_SMRAM_SIZE)) {
>>           mch_update_smram(mch);
>>       }
>> +    if (!mch->has_smm_ranges) {
>> +        return;
>> +    }
>> +
>>       if (ranges_overlap(address, len, MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
>>                          MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_SIZE)) {
>>           mch_update_ext_tseg_mbytes(mch);
>> @@ -585,10 +589,6 @@ static void mch_realize(PCIDevice *d, Error **errp)
>>                    PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
>>       }
>> -    if (!mch->has_smm_ranges) {
>> -        return;
>> -    }
>> -
>>       /* if *disabled* show SMRAM to all CPUs */
>>       memory_region_init_alias(&mch->smram_region, OBJECT(mch), 
>> "smram-region",
>>                                mch->pci_address_space, 
>> MCH_HOST_BRIDGE_SMRAM_C_BASE,
>> @@ -604,6 +604,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
>>                                           &mch->open_high_smram, 1);
>>       memory_region_set_enabled(&mch->open_high_smram, false);
>> +    if (!mch->has_smm_ranges) {
>> +        return;
>> +    }
>> +
>>       /* smram, as seen by SMM CPUs */
>>       memory_region_init(&mch->smram, OBJECT(mch), "smram", 4 * GiB);
>>       memory_region_set_enabled(&mch->smram, true);
> 
> 


