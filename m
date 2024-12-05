Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FFBE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 22:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJK5v-00019H-0v; Thu, 05 Dec 2024 17:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJK5s-00017c-GQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:13:08 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJK5q-0002Lg-FH
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:13:08 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso1329587f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733436784; x=1734041584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vHmmfy7MY/nxP0JFjq1JP8jgOvU9Pbqs9DUdVUT7J2k=;
 b=vfge5ewSAdSu+4qSQj59ULNHdTnPhnbAI+4FZlmcXUmtPliRGyy7ng7ISI3V83LvVJ
 JBaVy7OqRaOcZqnG9Z9h8O6u9quzToN2PNROsItgZ6ZFU1Rn/WmIGhESAIGlCEg6cgqr
 yxkRWbsz6e0mTf5gQQH/4zjL9nZ4GPRPMxDUQXiYIdELTnzggtKo1YYkuBnxcyaCmasJ
 AWKsIzHYLtm4WGMhPuwWK6gCnKdHm6jgEPaHjjGxxJwBrcyOIiP75HynfDTjlkO2G/Mu
 7wYSAj3HkgSeVy+5U2LXcGWPAV08D3wHCmvqAUlYke6gcf3Wav9n9fVs4fKoEjC/EvrY
 WGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733436784; x=1734041584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vHmmfy7MY/nxP0JFjq1JP8jgOvU9Pbqs9DUdVUT7J2k=;
 b=NsP0JWWFEx8BHLTP1qep9J4LXqLGLVtO+NBbVedGeShgv7KkJEpK52TEFJA6CeH8gu
 N+dkU3+LcLN35FXmWxQWJcehjLx1NuBXF45MPfT3UFBZ2zRvTQLM1U0wuwrOQAhcoU0S
 FgCInaiDOejgakBuroTu8LAmD5gTwgE7SYrG7+HxoFmWs5FfTiMMw0Sa1T1X3WDvYKuX
 sDuKXfjia3V75mdxXRC3xG/3TudSder8tutZXhvAcx4FBtyX2a44jIay7PXZjQG55mw6
 bK0nPfIgcMbZroeBKJCXdaIp3sddw5HeZtMbWuQwQX0qD0Cr81rZLVXyY342WC/dRkJq
 t0ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmTSdaFP6Yew1t3sUtuXM6GHOfKhIZqidphPoQTl4FRMcOVlxooqvIIHH3qJQY8fcSvHE2+H52+HLh@nongnu.org
X-Gm-Message-State: AOJu0YzNEKhwe9Z+djr5VzeoDELZU48CQzpUn2mjPFOO1NTqb8OCmZPw
 rBirUgBQQum9Fwo/ZIbkJJIKfKcv6PBLRtXvJ5A80jB4CZ07d/U1noyfbTPOQR4=
X-Gm-Gg: ASbGncusMIZb/+Ix6HJxK156xIbr3MnkTBlgckFASibBa+18FrGnSDQ0RpgRulzjsrA
 UGLjLMwVoE3julipiQXHkP/8tQNEovBiOdrfgNcG4K8MuMytEGy+VE5vhfF7lbBAnzsjd15zquP
 WbVWu18LxhKAi02qPwlSjXZLrSw4mwujFo2Tu0mJS03bM5kscyQl8Q1+3RV2Lf6V7wHlLDYotRM
 3InMMjYsGb6JM9ziafWnNqVEBZIw6m+J9/cFV/HiSLntn/Ihd6yj4IUQFfoTx/DE9gGKL6vw+9E
 a/2GroMeGaBwOr9V5Q==
X-Google-Smtp-Source: AGHT+IFeIKnQ8ZbnWENTbu03WGnI/TH668TtvXlQuDf/jS8X++X0fypC63/il0OHLvviE1J7v3bDIQ==
X-Received: by 2002:a5d:5f8c:0:b0:385:fd24:3317 with SMTP id
 ffacd0b85a97d-3862b33cfbemr538072f8f.1.1733436784368; 
 Thu, 05 Dec 2024 14:13:04 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862c611242sm191319f8f.36.2024.12.05.14.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 14:13:03 -0800 (PST)
Message-ID: <9823e0e8-3d91-46db-969d-42344cefa301@linaro.org>
Date: Thu, 5 Dec 2024 23:13:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 23/26] hw/tpm: Add TPM event log
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-25-jean-philippe@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125195626.856992-25-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> Provide a library allowing the VMM to create an event log that describes
> what is loaded into memory. During remote attestation in confidential
> computing this helps an independent verifier reconstruct the initial
> measurements of a VM, which contain the initial state of memory and
> CPUs.
> 
> We provide some definitions and structures described by the Trusted
> Computing Group (TCG) in "TCG PC Client Platform Firmware Profile
> Specification" Level 00 Version 1.06 Revision 52 [1]. This is the same
> format used by UEFI, and UEFI could reuse this log after finding it in
> DT or ACPI tables, but can also copy its content into a new one.
> 
> [1] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/
> 
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: New
> ---
>   qapi/tpm.json            |  14 ++
>   include/hw/tpm/tpm_log.h |  89 +++++++++++
>   hw/tpm/tpm_log.c         | 325 +++++++++++++++++++++++++++++++++++++++
>   hw/tpm/Kconfig           |   4 +
>   hw/tpm/meson.build       |   1 +
>   5 files changed, 433 insertions(+)
>   create mode 100644 include/hw/tpm/tpm_log.h
>   create mode 100644 hw/tpm/tpm_log.c


> +/*
> + * Defined in: TCG PC Client Platform Firmware Profile Specification
> + * Version 1.06 revision 52
> + */
> +#define TCG_EV_NO_ACTION                        0x00000003
> +#define TCG_EV_EVENT_TAG                        0x00000006
> +#define TCG_EV_POST_CODE2                       0x00000013
> +#define TCG_EV_EFI_PLATFORM_FIRMWARE_BLOB2      0x8000000A
> +
> +struct UefiPlatformFirmwareBlob2Head {
> +        uint8_t blob_description_size;
> +        uint8_t blob_description[];
> +} __attribute__((packed));

We use QEMU_PACKED.

