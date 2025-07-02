Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA11FC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyoV-0000HS-Jr; Wed, 02 Jul 2025 10:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyoA-0008Pk-NX
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:51:34 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyo4-00010L-PO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:51:34 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-72c13802133so1476361a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467883; x=1752072683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K6NyxPH1BMa5VGjsBHOrcZKnCYFYqUmbRgAoEZ9PAlA=;
 b=fTHAh/AlITsuI/YlvHyNQ6dtw4B54EA3FgRvg4pW5aJTuLNRMDc3loeiha0rG8/9wB
 oKPm+YOmcuqTb+/jX4yMJtKX+y/LZQyNsSjgQf/0npx3mO27V3IcdtCTABaVIv96+aj5
 x7pYQQaytn6/rCr+BVFqpXPnSthnkqlQr0JG5XYJxvV1ABEYKCm00TghOkhDekSVyVxM
 IGrX0rwXgKSEAY89mrVYRyxVjIkroKrNpCkG9/MBvL2U8udkMANilfIBsKeWLxU7lTpf
 EZaMkKSQloqVtv4d25T5jJ3lFuUvnw92noST751DxiGgk1KT1v90AyCWWYcLzRI/qG9B
 mptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467883; x=1752072683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K6NyxPH1BMa5VGjsBHOrcZKnCYFYqUmbRgAoEZ9PAlA=;
 b=S1GhidtHNDRmgu+TPtvRTcnUUkwYuAJRzTM2INnXgta28KH276m0+fpOjNbEJqEgbh
 a05lgaU46idL2yn7Wnj88ZBjBI6nhpvZ/iNzQYteaQUliksMlWTZNWj6pSF77IRQlxzn
 pJ5zoXe7Yz4SFLacAmfjz4NSO8ThIVur+53AXhgmtI/7WhIzLsqqwbExPSUr1wKBXIpR
 eH2yjCEe9UAvwJy1m4OPfLrHytjhV229O4BCWUmOApeGaqlPAkjNMqsR20RHzmCpuDL9
 wHPkUquxxzxX8Ny/qsIifngUWGFpSkjsSZ/xEFBvjJI1QtfqwYpR6IU9atByO5YsRggA
 12ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSLfj9rQaMAxB1CjMjo66xldjIz12LL0EkD2QVyc/LQIU5YLgN4knj8yH0i/Vwk0io49udN8ePx1fv@nongnu.org
X-Gm-Message-State: AOJu0YyyAqzQztceX5MM0i5iG1D18xPVkhgyP1OORgAoTsJL4kWTR/ZF
 Lcl+FiDB7csAreOYL/3aet3sMGS5mJRX3O0vLWCkuHk/IQ+JALRO395zAl6ndAo9fJU=
X-Gm-Gg: ASbGncsB971PBluURtlPJBPQuBOcDnudjZYyOp9sBtLCBwiQ2NtFdNaXcAxx/EflOj7
 yoOEbRMYcwmF7BWyDz3Ou6eBMAAKzA+/Ny0ya4JDhORKeuI8dyZ1gTzspR/VgZVzqL0dA3l7wbA
 RsJd5fepanrhEi4p9ZYsw+I/N238NKFyEVHnzZ43SLaUduixtycJ7VpxOUaiJAnAUd96oxSSQbR
 tdvoHKrHzgyBdkiEGsmEPWxK7CcrcKlugVOh5VUGNFuM8YK2aeNGAbJn3hWuY6uOm3/OoMUVYVR
 96FXh2+kPY/zZWJnvSAkGPiv2/cBImuZxTvU6dtYVsfIQEaM7JYr5s2Olp0LBCvFcxM3LNrH6kG
 Y
X-Google-Smtp-Source: AGHT+IHxuhRSwLhlk6OzKX7vSD/sxBST8oLvxl3BE71aAC69EcGil6wPlYr8PsRlxLXRKR+gBH0Rgg==
X-Received: by 2002:a05:6830:808a:b0:72b:b8d8:3995 with SMTP id
 46e09a7af769-73b4cc83ba6mr1862573a34.19.1751467883263; 
 Wed, 02 Jul 2025 07:51:23 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f852bsm3938286fac.33.2025.07.02.07.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:51:22 -0700 (PDT)
Message-ID: <0ff03f6d-4632-4b5a-b044-1ccb7ce715f5@linaro.org>
Date: Wed, 2 Jul 2025 08:51:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] target/arm: Fix VST2 helper store alignment
 checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-12-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-12-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the store operations in the VST2
> instruction.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

