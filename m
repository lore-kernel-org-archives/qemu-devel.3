Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734BEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC10G-0007iW-Qn; Mon, 05 May 2025 14:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC10E-0007hd-FE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:57:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC10C-0007oQ-OQ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:57:22 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2240b4de12bso77691205ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471439; x=1747076239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D3ND1SAC3lvQohdosheSraL5hqzXXgRa/d3DCKAxaiE=;
 b=zzTCBTL7KRjzpIUweBKZEdgtkRqiQiiucSmS82lm3aA644KhMI9yX+BX2GMuET4Ihk
 JrrcefR/HeJCt56OZJtY/9UebRbf4TA7EqX8dDwwxyPKYhSlSi3/UgVCSNcQIf0i0uII
 c0Cxzot2+Yyo/wn2CVscjhzRhTVd6x5GOBiUVy50C9OtNUCBfe79dpR0FQqOIh2btTwt
 /TOC0YnbnNUfqPGHaoZMA6Jy7yEMayaoUgGkYuXZx+5ip7Cgi1LX2Mzh5qFG/6fv1DlZ
 +QLtPUUhpQUsbOmCGZFsmV6KEmcwmmbeB6McfY8EqY6R/AjDMp3t8yuzLWeJCgRKXle3
 LxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471439; x=1747076239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D3ND1SAC3lvQohdosheSraL5hqzXXgRa/d3DCKAxaiE=;
 b=YWfDuKs1d9fOt8wB9VRLfh33ro4PCvxNKsU4oOguQ22KOxkLFCPpjRI4UV8N1L7wQP
 1Y/CyW20X9ArLTrEVHnHoRmkKDZ96O+ljOoYE9WtYcrOEtxhQfYOdiCwxGJ2PbFhtDI/
 A936NxtxfsIBJW5mCtDtskf7oeskO3fFYnsdLqfZ9jtpHZAlhKyVFbyLvayL6kTNggTu
 nzgEq0Pl8RQrnaEvbCJkgIjIHFk0R5rvewmE7igktVWiXMtFB7rkSa6QyLrY7q5vpr/M
 MouSF+EqTWXAx2+8PsY9gA0G6+g+2Eba0RSUtmAJry/az5V1J/WVHnatKuw2CM+Qmhrq
 Ar6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV49RqQxCQhl8Pbz+jTixN3oojaK+lSoGfc0vrYVrg26yaoT6OwhM0FvobvuMmxkvPNlDcT8VD4350t@nongnu.org
X-Gm-Message-State: AOJu0Yw1j3G1VlqqZEsAv/gHU1hBS943Vqs8bJy7TjS8dWiYoyv9h0Kt
 NanNUiFOUm0MqvzOdId+qOrlivTiXHnl8aMoZDieII+x9RsKY1ZRXiYtdFt7yqU=
X-Gm-Gg: ASbGncvzP+0EIzQVwCLfJ9l+7/KvZLkzDm4xyCoztN+C6a8TvCgZACn1koOxxdWe40K
 LrDRgJCULoghaaZTvqcDu4UyUPnsNOwlELlX6opZwYbR7ClMa3FaSqq0wynIUeWjQgPVRjd2HE3
 ZTAla8WKxyHV+ilXV/PxeMx5dbz8rDBtZ+M1MgfE/PvrNmye1NKSleGcCQvNt/YoDcMAqQrW3u0
 Uo7dQRarJk5+V7OHeZbJXa3MyojQTBHcTUwvREgTAqPO+m5eajBSFJQcGJ2B5PFMAWgaGB/Uht5
 KqJLecwni3mBGNxg4rO+XBSNrh6F0bUZIS15vT01mSdDcTP8sVZ2bUmYVgPtPYg5bJXZ7s1QWcw
 wAqdtE3M=
X-Google-Smtp-Source: AGHT+IHBbFfWMdx6MOF3TzOMnofsi47UUFpxhoxY+MWXgZWqBLVhK3hrsAlK0As0A+dkEZOmLelXjg==
X-Received: by 2002:a17:903:1d1:b0:22d:b305:e082 with SMTP id
 d9443c01a7336-22e3311e8c8mr6072235ad.47.1746471439131; 
 Mon, 05 May 2025 11:57:19 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dbb5a6sm7188920b3a.45.2025.05.05.11.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:57:18 -0700 (PDT)
Message-ID: <3e69a6c2-f759-41f0-87f2-1eb88844e19e@linaro.org>
Date: Mon, 5 May 2025 11:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 48/48] target/arm/tcg/vfp_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-49-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-49-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/vfp_helper.c | 4 +++-
>   target/arm/tcg/meson.build  | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

