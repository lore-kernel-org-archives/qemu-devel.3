Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B275AC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNB36-0001rd-M2; Fri, 28 Jun 2024 08:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNB34-0001pl-6t
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:49:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sNB32-0007E8-D8
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:49:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-356c4e926a3so371313f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578990; x=1720183790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P8BaP+7nqFlH03qBMhxvA4z+lqmB3hanzM6OJ+o95CE=;
 b=c5AzK5YlvefANH2HgkHfeun7ic5zADo7y+9KjdRDRpkkrm4bgTsbgEUByHQZB3BbKG
 a6pABEjNQZ+iK6vwIIUoTUA6jXsV2N19gT0JNQgjn87rvlkjuC0ebIH6Z3fmGnycEBP5
 D8mr9GDXMDKGsS3S9HaV5nuSEGYUxa8THM2e/zCuK8IU66PFaAQgurH84C8MQkFSsBvv
 Dn4Skyj+Qa4d2yQ4vbWzvaK0ZCFJ0rDPPdPNLXO3n3p3HMqCmPDsAaqGTERgJ6hK52+j
 qGeGuJITfFK5sodA3eSNH59nHvyU3f2OMG+jfNvBCSMcqXXHo4Gvi7tGMFCKdqWG9KBX
 wvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578990; x=1720183790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8BaP+7nqFlH03qBMhxvA4z+lqmB3hanzM6OJ+o95CE=;
 b=afZRAwhZn0VEgzHzseUg6zneqG7ZJd6Jx/PP+0s+qCbKpnkYr/jXzPHRRJGLbYBhiD
 wtObvpvXzwXfkt5vgCVawY2NwI9ByXqyaeZrtB0ntWLxOUN/mj1WivYN4J3S4Xk4U8x3
 fZbVFzWEPCrgHLnT2jTBI5/bjNsThLfuPuTYyjZtLaSgqINfgieu2L5HVCdoH5DxuRuR
 eQx7u3SkdBlqnRqO6qJirU8f4QUxtHFcI/iEiPvMeZdCXKBjL6Bd5rvUegQmzNFth5Ch
 DbQWLwdgzyGsxJVZFR2toMGAxxWYz1z5G0Sbm02kbfNofSZ/RqA/xWIbxw4Y1Zz0jrA5
 eIGA==
X-Gm-Message-State: AOJu0YxT1EVNiwixvdWR4+Kljp87cwiucI6xV4PbFxUWxf57c/oMHB13
 VKBdUiZEiNoT1IfWY0PhmATiwPW3xx9WupsUXr4ebRzmb5atCsBnmOSMLv2hgZE=
X-Google-Smtp-Source: AGHT+IH/MRKjifK+NeO79sc2aDl/u+O+BTfGN+K2sKo4PcHeAXDfbDWjIsgGCnPJPPok12q11OKSog==
X-Received: by 2002:a5d:5f8f:0:b0:366:f41f:8cc7 with SMTP id
 ffacd0b85a97d-366f41f8d56mr13028392f8f.46.1719578990436; 
 Fri, 28 Jun 2024 05:49:50 -0700 (PDT)
Received: from [192.168.69.100] (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e12fcsm2226535f8f.48.2024.06.28.05.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 05:49:50 -0700 (PDT)
Message-ID: <5d469a3e-bd09-4f8b-bea9-55dd6d07cb0b@linaro.org>
Date: Fri, 28 Jun 2024 14:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 02/98] hw/sd/sdcard: Use spec v3.01 by default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-3-philmd@linaro.org> <Zn5w6A20UVkrP3ca@redhat.com>
 <6908ca71-6df8-4aff-b1d0-39e35aad7a1e@linaro.org>
 <Zn6EQ39Q57KtmKPU@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zn6EQ39Q57KtmKPU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 28/6/24 11:37, Daniel P. Berrangé wrote:
> On Fri, Jun 28, 2024 at 11:19:52AM +0200, Philippe Mathieu-Daudé wrote:
>> On 28/6/24 10:14, Daniel P. Berrangé wrote:
>>> On Fri, Jun 28, 2024 at 09:00:38AM +0200, Philippe Mathieu-Daudé wrote:
>>>> Recent SDHCI expect cards to support the v3.01 spec
>>>> to negociate lower I/O voltage. Select it by default.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>    hw/sd/sd.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>> index a48010cfc1..d0a1d5db18 100644
>>>> --- a/hw/sd/sd.c
>>>> +++ b/hw/sd/sd.c
>>>> @@ -2280,7 +2280,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>>>>    static Property sd_properties[] = {
>>>>        DEFINE_PROP_UINT8("spec_version", SDState,
>>>> -                      spec_version, SD_PHY_SPECv2_00_VERS),
>>>> +                      spec_version, SD_PHY_SPECv3_01_VERS),
>>>
>>> Shouldn't such a change be tied to machine type versions ?
>>
>> I don't think so, SD cards are external to machines (like
>> CDROM you can use any brand). IOW machines only provide a
>> SD card reader, user can insert any card there.
> 
> Consider we release this in QEMU 9.1.0, and the user starts a VM with the
> 8.0 machine type. The guest will see an SD card supporting v3.
> 
> Now live migrate that guest to a host with QEMU 9.0.0, still using the 8.0
> machine type. The guest will expect the SD card to still be v3, but QEMU
> will internally be set to v2, and will return illegal cmd errors if the
> guest tries to run v3 only cmds. Versioned machine types exist to prevent
> this kind of problem.

I guess I get it. So (besides rewording the commit description)
what is missing is:

-- >8 --
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c21f..4377f943d5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,7 +37,8 @@
  GlobalProperty hw_compat_9_0[] = {
      {"arm-cpu", "backcompat-cntfrq", "true" },
      {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
      {"vfio-pci", "skip-vsc-check", "false" },
+    {"sd-card", "spec_version", "2" },
  };
  const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
---

?


