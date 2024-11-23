Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728D3D1BDC2
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 13:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEqOZ-0002ul-83; Sat, 23 Nov 2024 08:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqOB-0002rI-81
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:41:31 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqO9-00012z-Rw
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:41:31 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-29680f21217so1905700fac.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 05:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732369288; x=1732974088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XT355yEc3DG2reu9Z4YNqsEkVBss1U8LBmqNPFiCdg0=;
 b=RfYkH656c57CIzUhZo5GEwgo0U5qD9g8elAqiBQtCzjbO0zRsaLrexF3PkKwnlIaYN
 aILhSKFjpngGSYKV6f+14MtP2kJ2tTU4DonPAHF++USehCp+B4TasAs1zGGzaNbf63Cv
 U78CyNWCXsLMHxzAuW6fsHd8WBXqu+W7vsFsaHtVU55dCzDWhSCO3e1gshVIUBtmYc9g
 +aS5iflNAlN0zoFMj5MJHBwv+JxvbZ64+X3bMSaVKrzpFoush5abKxLDR83vGhvkzDy1
 BCs2An9AO5ClpbaRkgcmgQqatRCO5kRYIZ1/OWgwiISWUVvDCHkzBZ+OApnNvSsQtVWN
 maYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732369288; x=1732974088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XT355yEc3DG2reu9Z4YNqsEkVBss1U8LBmqNPFiCdg0=;
 b=U/mQNis+mTZRsJt+eNupPiIHENgW3bvPKEqLwbwyaq/+FaK2tJmG/6vdTRgECzQ9tI
 PANcQ/K8UG3GDw/7iowu/P4ZWDOidgGFy/qz7+VNUuA6oiA2OsdDyycMESSbPB4WQZ3m
 5UMujLxk61O0XwV8+/WGnjWrLfzT8FlLQANy0q/leeS9IxhypCckMaF6cMcfbRMv4uIy
 ZpROx05NKgnA7bAY0bsfnA3E7dPj/OinDkipqE8rK2LtDUuvMsSYBkwaK0byL/9657At
 0py3riRLWvAatOBRNCkKI4mGavVyabdSmd1XhRrsiY5GIwp7LdqYYGs5zqWfqJAmoUVD
 qYUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpNyG07VMvh8ysyehyELEXWskSISMVCBU5dyDtQbCROWPGvq40CdWK8QBqsXs/oQR2atDeb/2c5uur@nongnu.org
X-Gm-Message-State: AOJu0YzaTH21UaHPNN7dR0TjgruQjkpnNPMfJ/gu0SRhuf2YIRzQCZWs
 QmsDfH4AR7ncRzxjSsyygAwZHRF1wZV51J8NJ7YyvggQFo4JBoqh2UiVVCw8EFm3Nj/x5GLctOb
 bY6I=
X-Gm-Gg: ASbGncvLXCHhNUV0y8EtV3WycjWemfTCPk129Mlcr4PYkTW15tMm9dLGKaAzj+0TPIr
 j8U/bbRD71ihQIr09GAGrl4egNOm9P5EnSnQ0z9Qx//NZb7kaZnDpZj9xgglmDVd0oktXE6EJz8
 tr1ZF4C74FUgdkeXparNXoL2crzP22vY/TkDDg1CYCdGDItpu1U/A6xpJpudQOJnnl2STuGt9Og
 6Pq4nii8yxf2Mkt1/ZUVxF2YC6hPhw2AzJNpXneCVwG9eAAtLeZKZKBtV+rfbcnfQ==
X-Google-Smtp-Source: AGHT+IEiqmHS7YAKnuHDWTebe4lI4Jeoh5as2LOp5WLOrroP3HT7C1U/bu1RzJ3SpKZy9OSIsIzg6Q==
X-Received: by 2002:a05:6871:c715:b0:270:205a:4070 with SMTP id
 586e51a60fabf-29720b979f4mr5791131fac.14.1732369288637; 
 Sat, 23 Nov 2024 05:41:28 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71c0378d26esm996955a34.31.2024.11.23.05.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 05:41:28 -0800 (PST)
Message-ID: <0655469d-cc1b-4b31-a3bd-693966d7f06d@linaro.org>
Date: Sat, 23 Nov 2024 07:41:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] docs/system/arm/emulation: fix typo in feature name
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241122225049.1617774-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 11/22/24 16:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 2956c22a1b7..af613b9c8b8 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -88,7 +88,7 @@ the following architecture extensions:
>   - FEAT_LSE2 (Large System Extensions v2)
>   - FEAT_LVA (Large Virtual Address space)
>   - FEAT_MixedEnd (Mixed-endian support)
> -- FEAT_MixdEndEL0 (Mixed-endian support at EL0)
> +- FEAT_MixedEndEL0 (Mixed-endian support at EL0)
>   - FEAT_MOPS (Standardization of memory operations)
>   - FEAT_MTE (Memory Tagging Extension)
>   - FEAT_MTE2 (Memory Tagging Extension)


