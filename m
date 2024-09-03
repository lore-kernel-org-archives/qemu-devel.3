Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6B9CD342A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slV3O-00072n-KB; Tue, 03 Sep 2024 11:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slV3I-0006fS-Rx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:02:43 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1slV3B-0008M7-Bx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:02:35 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7cd8d2731d1so3492135a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725375752; x=1725980552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CrvRkeWjaYkDZSVPda8844TkzOU8UzyPCCGFck7ar+w=;
 b=J2pHreOSQNY2U/YAOisoY0p1eB5Bi2J44oUzcBknNG6LRfdWX6m5rZu9xCfBMd+HQg
 W5+fqA8RnQtDelufn8s8UVoQRtFQF8wIRNzEcZGx11e3rt7y7z/XSRVGm+F3+a0ZsfC1
 EDH0lQ9egdT435Y8WiW8l3gIVhAqlZSPetXzTzHPxrvPumpaynPnLhJkHVdiyKm9P8Lo
 7OOi6ebAl491mguPCvl0bUvOZnnkzmMiMgOn8lk8UEzJZFHLPKQDk7lb5vlXfvw7PSHi
 1//f7wlEiK2rD6xMl2/gbKmx2PajuWB1GUj4MnUnc5W4hjcBNqtu67l6aCYFEM/0wSa1
 0tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725375752; x=1725980552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CrvRkeWjaYkDZSVPda8844TkzOU8UzyPCCGFck7ar+w=;
 b=n7bm6tHX7VeVBcuqQw02Hi73xOfJ2AojS2H5FDKfIv8U7lXg1fB4fLIus5Gzgn8n8J
 znphg4N6Zl2Vm964tUjiSTZDb2VKbsAmnOBSuVrjRmaqCLqJyq4mlRszde5e58yIyp4+
 Xj9pkAJdcdywSAViHhSoqJksVjY2vq6lZJ+qGSW8LAuWd2L3hMh/Ozal785JeabjvKXF
 VrB9yf5pRNbYR3d6y0Z8YMpacdI2UQYMTY6D5hz+buM2ZY/HkPf5f+WZCHkVb5qMe3z5
 5PSLImJG/iF9WopA3/AdudAWUs+I26H9vTgVM3M7grh2kTUrVVi0sXmtqfMJEHdntLap
 doNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWdyLOuDwiGLUwclGbvo6De5OBDlsUo6Ia6zwVqMUj6uursRth8gPC9sudQ7QS4+xXIpVly9HYL1lP@nongnu.org
X-Gm-Message-State: AOJu0Yx05Q5imiiF/QWdDFFWeAgYCieu9U5ek2RszdWBB543e3zY6o7J
 l+PJ5rK8VvYuz8kGKn58k5sgLl6fmu7tvSGZWiCIe05ZZAwVJwDx4JsD9/aO/PU=
X-Google-Smtp-Source: AGHT+IG/K1lGNsay/ftX97sNQ0My+HPQukF6ID/7jO16CNg8T3FSI9v8E8zboTUkEu1PCACj4qLJng==
X-Received: by 2002:a17:90a:1109:b0:2cf:eaec:d74c with SMTP id
 98e67ed59e1d1-2d89728e55amr8979114a91.16.1725375751693; 
 Tue, 03 Sep 2024 08:02:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b119b3dsm11562568a91.13.2024.09.03.08.02.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 08:02:31 -0700 (PDT)
Message-ID: <66bd5e96-aac9-47ae-a1de-28808e4cc109@linaro.org>
Date: Tue, 3 Sep 2024 08:02:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] tcg/riscv: Enable native vector support for TCG
 host
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-15-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240830061607.1940-15-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/29/24 23:16, LIU Zhiwei wrote:
> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> 
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target.h | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

