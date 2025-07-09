Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B85C83F14
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 20:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZbSK-0000tC-L6; Wed, 09 Jul 2025 16:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbRg-0000Nb-4y
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:31:12 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZbRe-0008Pu-Jq
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 16:31:11 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso262399fac.3
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752093069; x=1752697869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rzavvfaVQGb9jqhok54sG5RRyj6EcxYrQTocJX4ceSM=;
 b=g2s9TNFcZKae5cHvWEkjoQexx4B0+wJbKWfA+RisFFpaNXvpVXOVP2gAx7IYQTFnGt
 nYC477OvrmTAp6z2MSMmy8lxoZEwnS9xqq2AWs8Ueo/bvD/doFtSPvjiaRgATjJjjItq
 XBwAL5xZTTtRlcuVgYDhPLsSDwEUxb8TAQdo+WMricIXOB1vgWtIQEZOqtX+mbOk52HS
 3qRhsCi/INte34pUWG1qyAZBRgx1xBDI5dama8gSuNlAOEW/APNLOKfjy3cr/k0TNMka
 CA6OAfMPpFQ0IeW0vBWJkvm6eNAos7CIp8fd8R/lchvbMEJBT1VwJarGSFY1KLOxoi16
 0OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752093069; x=1752697869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rzavvfaVQGb9jqhok54sG5RRyj6EcxYrQTocJX4ceSM=;
 b=cWlZ7hTjqOEq+uY8uIsOypP4uCj2Y/7yvNivqAhcG+ROJaGYIg2LicsmKNo75EvdTC
 +sOBM7gk/Y5kJX7/wot1dljlCswHTzMWMUAugo2KhIC2/WNL70ZpoLtvYocKAmVc0e14
 z6VePtJuYzFP9aqykRBcySQXO6uLJ/dnSZrJBqfB6mvG03AoyNtt1CVzqrpf866BFd4K
 6Xm113d2c6LjWnPrDhcYToxQcAP7MI4JiR36kXJsvzjdxj1X+Xj4qnmcgtBMCpI0mFHk
 d5S9qGvReMkKBnDTDAlko/TIhGVCJNmbg6D795klHEahTwLDW5+qdCQ1uN0RbqIXDTZp
 y92Q==
X-Gm-Message-State: AOJu0YyhS5eg/54rEBdD1MOA3w5VbrBxXnYbUBoA8pl0OqgAid1PlS7e
 dFrPrNeHGVbw6Q74q2uhTLCneKFH2wj3L5l5OMBlPWHPtTkpIunVfmDRfJxXtQtW13Y=
X-Gm-Gg: ASbGnctwa3LXmqMPk5+ArssK1bKAMN/+WLD4Tc9kTSmJHXBUOiWeR3L04NER6AgEBoA
 a+HSxM3EfvMedK4q2ll+rwI8LMcleIPo5uwgMHrBGBtw9SkDp6Ew0RyOltXQjjB5kPcfCKtkINN
 BSsAbZv8dM7lM2MsFsusW7uad1HvbpEu7rd6aHIMlB0qvKOySNxzzbmxwldbqWPOhZbp8w4kgmb
 11cxAsNY32NdgCH/WITtAEg5Bk1YEdVhPMqEMJSqvYVWwso5BlGpEJpe/j0/u9RVg+tdyvpdVrN
 qWQEWy8/cXd7u+mD/t08sL0n9aU+UNpCWvfIFrqSF4h0hHwdtKwZdIZ/TDWP1qNblCbUaAjhyFi
 msBs=
X-Google-Smtp-Source: AGHT+IGadVhhjFnNmggwywXQzF3OSv/OIWsl7VjQXYSVntI+ztmrFVEeLpxRP1YwuTVznj4Wd4CBzw==
X-Received: by 2002:a05:6870:e24b:b0:2d5:d5c:a851 with SMTP id
 586e51a60fabf-2fef848f00emr2789304fac.6.1752093069089; 
 Wed, 09 Jul 2025 13:31:09 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7901a35cesm3667267fac.32.2025.07.09.13.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 13:31:08 -0700 (PDT)
Message-ID: <463a3082-aa22-4298-a5e9-f54e6848b1f5@linaro.org>
Date: Wed, 9 Jul 2025 14:31:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] target/arm: Add FEAT_SCTLR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250709180326.1079826-1-gustavo.romero@linaro.org>
 <20250709180326.1079826-4-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250709180326.1079826-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 7/9/25 12:03, Gustavo Romero wrote:
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 552d8757b7..44d6b655a9 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -416,6 +416,11 @@ static inline bool isar_feature_aa64_rdm(const ARMISARegisters *id)
>       return FIELD_EX64_IDREG(id, ID_AA64ISAR0, RDM) != 0;
>   }
>   
> +static inline bool isar_feature_aa64_sctlr2(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, SCTLRX) != 0;
> +}

Should be sorted just below the ID_AA64MMFR2 tests.

r~

