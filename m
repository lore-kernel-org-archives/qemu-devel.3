Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98441C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thV4S-0003x0-MJ; Mon, 10 Feb 2025 09:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV4F-0003uL-CT
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:47:23 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thV4B-0002Qo-Pk
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:47:21 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4bbcbbd0bb9so648948137.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739198838; x=1739803638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSydp8Ua32lme5ETsF3+uK4SELdJXxjzWlXPfkQFvtU=;
 b=YcLLlJ+uhch3LB6Cw24vqMV32bFUvEEOZvWNYMfhoo1Wkr/PyaY9evD6hcTaAW/KqV
 vKGlJ/irk4xrQglMPbFQod11gZ13fOjAC3fAr1ONVOj56UACrgDGO669Tlx/2C/R62ja
 PWDwgr5Q0nNwFPDBPbx15XADM4A76RppQYBMeiDbtpbywy583pOt0Dsze7XXLlUKoxov
 JnTtSzirZPysHi63e/7yNGmGMB8B/4CUz2cxvt7V4QHY2wRGgcsotyJXWnEIJWcQSzo5
 uscHoIWE/QtzKe39A0tX3OX1kk1ynH0aAB+jwyMEIlPXZvlgnFazf0hxzDXjh3hjHFHD
 mdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739198838; x=1739803638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSydp8Ua32lme5ETsF3+uK4SELdJXxjzWlXPfkQFvtU=;
 b=w/izyg6skapS0n8Mi7czfS2ndHwLBN/Btm5Fr1tZfMhsvCMhXTSp5IS86Hgbs+nWTM
 kDwN682kGxO8RNBckqGjJOvcNCVQJovwdjMtVL3sB2hKxW5NQOndhHAsB7xTKFK4VrH6
 qIxWwRdTh61ctOTDtmmKPfAwtXWjrTVrwPB1TjqlvIdULESImURqa8MI6wPI2LY2d5Mt
 GY+aA0TZqqtaOHLIv/8NoG4qrc6odnjkZcpkL2LcGem2UPIBnqJ8YE1RvUR8dMi5VcYk
 hWfBAJGwXble968V17DHPy79w1b+syXh9ufkBE1HemhxFETdvR77CS4amOrqIoWCGvi9
 pbFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUucvHH8cmJcdGY8bjebEHSzVusDdrEIuf7NrvJzDYkVhnmRhD++2ru597ln2XSttnlMuF5QJuj3pR7@nongnu.org
X-Gm-Message-State: AOJu0YwExlutLa/DvMrv5V/AuQ4Ck3i5n6TW5mybimrfeVLp23UQ5yx/
 zWQrt4hYw4MVwvwe2OXoX6yFORIezlxa2aIotf6ll3IGvqj0akQN+mVXwb07GfA=
X-Gm-Gg: ASbGncsNWFQF/1qun5DADqCfbvPjmJVTf1C2AQmQ3M4IDXg2VDeFOok3PksIX5CQseU
 LJC7izMrIino49DEkaUzJ6AcfsnUDVG5pgh4PfDGn7wsHHMuo5QUdSYX75u56/fNYI/T1D0NWy8
 BFQ8doKzS1AkgrR6AKPUqxsQLuigUkFL+Wj2klwxRcxaxsE8tftSuGq+eBrIQFmMR8OVsPSaJGa
 NafSt27dsSNVfNp15AkJMar3icQFvn6gCXJyb72tVaytYOAPIvsxVBahxECP32MROe93qsGbzkx
 58z530iGcWTaRbQE8Egc9zB1R9KL8pedW1QAIkVWlWs3MHL/qKexhh5gXck=
X-Google-Smtp-Source: AGHT+IGlfDOPuxQa3IA8Z3AX29dVaL4BRVWJhCA3jUzavj3IUMRt0UpQxxtemHZeUWLnZBDnwRmNEQ==
X-Received: by 2002:a05:6102:c54:b0:4bb:c24b:b61a with SMTP id
 ada2fe7eead31-4bbc24bc268mr2889471137.19.1739198838312; 
 Mon, 10 Feb 2025 06:47:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4bbcd4c5f05sm409127137.7.2025.02.10.06.47.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 06:47:17 -0800 (PST)
Message-ID: <487c0413-4faf-4b8c-aaf6-fa96a9202b0d@linaro.org>
Date: Mon, 10 Feb 2025 15:47:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/17] hw/misc: Add support for NPCM8XX GCR
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com,
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me
References: <20250206221203.4187217-1-wuhaotsh@google.com>
 <20250206221203.4187217-8-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206221203.4187217-8-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=philmd@linaro.org; helo=mail-vs1-xe29.google.com
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

Hi,

On 6/2/25 23:11, Hao Wu wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_gcr.c         | 129 ++++++++++++++++++++++++++++++++++++-
>   include/hw/misc/npcm_gcr.h |   6 +-
>   2 files changed, 132 insertions(+), 3 deletions(-)


> diff --git a/include/hw/misc/npcm_gcr.h b/include/hw/misc/npcm_gcr.h
> index 9af24e5cdc..9ac76ca9ab 100644
> --- a/include/hw/misc/npcm_gcr.h
> +++ b/include/hw/misc/npcm_gcr.h
> @@ -1,5 +1,5 @@
>   /*
> - * Nuvoton NPCM7xx System Global Control Registers.
> + * Nuvoton NPCM7xx/8xx System Global Control Registers.
>    *
>    * Copyright 2020 Google LLC
>    *
> @@ -54,8 +54,9 @@
>    * Number of registers in our device state structure. Don't change this without
>    * incrementing the version_id in the vmstate.
>    */
> -#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS
> +#define NPCM_GCR_MAX_NR_REGS NPCM8XX_GCR_NR_REGS

This breaks vmstate_npcm_gcr.

If it isn't too important (I don't think so as not a versioned machine)
you can just bump the *version_ids.

>   #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
> +#define NPCM8XX_GCR_NR_REGS (0xf80 / sizeof(uint32_t))


