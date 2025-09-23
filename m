Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD4BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10Yk-0008Tk-MN; Tue, 23 Sep 2025 06:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10Ye-0008SY-Jd
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:47:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10YX-00071p-Ig
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:47:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso3362346f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758624450; x=1759229250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=asyMX6RGarJwtYqKiU05VkUrWICDnMI/IdEa60s8inU=;
 b=mxDlCkHKHnE693sJJkv6S5hjFpvTVQm94J6tVAOnsvb5fesQUUVRe+EDyxWkmXUkEB
 ftJbGp6CJtmhRNVXxcpwpM0CJGl0NROyFLl0BlkYcheB4NU3OZFxCC7rgfUx2p1Wz7nE
 P9es/bD+tByH0gR7v6qiTHSvFsvT6SB8aa8Q27QbP/xP4KcuO/eUGguvlg6/wnHDS2vV
 hurr0+uxKKjV9Bj6nZkv+AqFOg6u05dGFXIvDDJ83szMATUCgA6+37vkId+Aq1ror38L
 auaCCDu2ttEMi0zAOXzTOG0TiYoetKJEm1/t6XErx9yq8zpO9e/TLCnClj2+f1UrMN76
 HPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758624450; x=1759229250;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=asyMX6RGarJwtYqKiU05VkUrWICDnMI/IdEa60s8inU=;
 b=C1FS1EOi6XvzWfHgnLpHW2k47nte9b2XU9OiDDuhok1J/+1Wa/4r8xd9VQAlB3Xub+
 njIV72j9uP/15QuZtjGQ6v1QPTxi0meFoaZl/ptub06q7eLMLsZqRdGRplpQRp59bF5b
 WoDN9z1v8FkUJXWqXRVadNFJlPUXawD4DgrFFF7eTZJBXyd20NwOUtam2E+djgcq9iXv
 qualgpj26BSI3QgcvPdRlCI9hKC4qOAZOcJPPI8ot7oaoSHt46NEUO8tG7q5jrIHrsSv
 SkulZlRyjxYyA/d9arOL6Oj2lAiq5UncX6I5b+f4PbBwflfF96DhF0j+FRKR6LDKHd3/
 W1Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo958EdNDHMpJYOsnfENhTt1Nk6uPn2cpKUIE2vLpCAzhr9K58qQB1Q+lON6fUadowJKmux/Yqlsz7@nongnu.org
X-Gm-Message-State: AOJu0Yxolo70bG6LvtwtnIhj3Bv1Spc2GMK6ffvbe/YZx6scifEvQ9bq
 ka4BaQcxN0jGwMuPeD9K8MMvG7vEOFhy9HdFIRCaL885BOFg6YXPSdt0T0gRlJr993o=
X-Gm-Gg: ASbGncsuwXSudZ/CBijos/Qjqsf0lAgA/+9D4VDlI4sQd9PjpsaMHcYKOs+ysdS+oex
 HjAxo4A3y/tNlqdY42xyR1G7Efm8r3kRVxqrHb5l0Px/RmEqOPRmhxpkVDhtGz/kLTs3Cm3rIUh
 MHrbbF1nfvnFeNNSc/LPESTKr1+sD3a6DJtnJPilM+OlzrPlizNfrv1UwB7ftqeADVfwpv4+FTF
 SzC/QdgvzU7lf5M5ZQP68lXM2YUkDkTG/WWkMtSErwLjHux4DJrtz06swyMUdUFLh6FP3m/u3sN
 OEpVU82DF53ViBPlShYeqEQ5y0Ij6naa/ZoG4Kw7otnsxhvGXoHMXQGPYwqGOQF45sbNlCpb/VE
 1TJxZkMIUJlA2jOe53P93s53AmRXAk2HyXDBWhH3GVTsV8PjzKW+vbhtV9r9GCXnoWA==
X-Google-Smtp-Source: AGHT+IELJXo5w8pgpy0XVgbieWBdGazxRrNmS14OWZtggIGsBoFUox+Tw7VjPHdxtEHCp+15/bvdRg==
X-Received: by 2002:a05:6000:615:b0:3f4:ad3f:7c35 with SMTP id
 ffacd0b85a97d-405d2c7ea8cmr1691409f8f.27.1758624449960; 
 Tue, 23 Sep 2025 03:47:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1d4cfd57sm27781265e9.5.2025.09.23.03.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:47:29 -0700 (PDT)
Message-ID: <0f89784c-1562-4249-bfe1-82248fe676e3@linaro.org>
Date: Tue, 23 Sep 2025 12:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/36] target/arm: Reorder ENCODE_AA64_CP_REG arguments
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-20-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> The order of the parameters in the Arm ARM is
> 
>    op0, op1, crn, crm, op2
> 
> Reorder the arguments of ENCODE_AA64_CP_REG to match.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            | 2 +-
>   target/arm/helper.c            | 4 ++--
>   target/arm/hvf/hvf.c           | 6 +++---
>   target/arm/tcg/translate-a64.c | 4 ++--
>   4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


