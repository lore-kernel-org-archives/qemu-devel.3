Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4F3C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRHO-0002gk-5i; Sun, 23 Mar 2025 15:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRHD-0002fq-EU
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:46:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRH8-0001F1-UJ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:46:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2264aefc45dso51164085ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742759185; x=1743363985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=73JOrMrH0Z6OmECYIAcKVMV0A81i86UDdhTtHjzTSVw=;
 b=RDu5T0fPar1n+W50FEdZ6Wiugzo4Ij0g7fTHnLGccXkAgA3Hr+UMsO0bmIasWTsvt3
 e32jL60uVKy49uYQZizvXj+nGoT+Lird13rxYWVhNk5U/3OQ2OJsZsPwiHGqCkMx0bTi
 /m06mYkmhFZccGIoMo/YWcHQuVv/jgG3xH7STg6+qZVH0d5aA1wcZDDsGProPSbL5gu/
 21pRONwxarejad2+65eFeYNhhXa/851/VYVRAWCG/mCkmdogv7RcXgDWAOJQShW4e3hA
 of0mUJedJxGtITX5zDInhrphw7jjbsvi6JqzjdMb+V5+D6IN1Ck7cE2DEa/pLVkTf5AI
 rZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759185; x=1743363985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73JOrMrH0Z6OmECYIAcKVMV0A81i86UDdhTtHjzTSVw=;
 b=r1j5zOPo8MR2eG31kqCozu8yy5g4eaXthSimAUI/ATNXAAq0deQ/UML9xI9CQgpIlT
 GDrebEo1gu4utXRMI0gdptDRrLze2ri5QlXq7HDC52/tYXULwI6C/7DpBxCFegXdxw8x
 1s2lJLWi9Le/w5LPid3oacuvJobY4YjvTf4wapP18aIQcqIGTW6oJJm7bxtn5rcjz0Nt
 M1ETZTOnm1SKVICinnM1IgGJ+/GbGdpo3xLvkpJBF6oKRR31afK0K/n86c59Wp7nK8K4
 hPxEaMBqXw2mdWC9uCuirCmvFdzFiY2QDu9kHMDefWTs63WZjT5C10WgZL8unBOdxtMp
 R34w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLxFc6oEZhB2PwfNOneAo7S0KvLlaU+Rd01pybNscnNsZjkDF/rguDzDZUtv+nfcIxqxlb80yAS3YK@nongnu.org
X-Gm-Message-State: AOJu0YzvpZpb1++23D3ZIupmM3nFZcX3hUrIYB/pLDdM19lgKYTAkC8F
 7FN7oN49CAyeqAmHCbp8roQhU+XCGaZRM3TKeSI8q37wlqMIwLtYo6cvLqY3LsQ=
X-Gm-Gg: ASbGncu3xlZTHt+ZXo3mb2Az04YbqBXzllWmDbDHxxkP6/DE0GZ6kdZmDqafo7ArlJm
 VUI/yNg/4Zxw4lVe+1Zt+sP/RRmoS6qGV4ntValNX2u2U4tkXYgQS4AxGuMfKD4/XfrksGYCcXD
 YFKX0WSHzCxTCcG8SlK1UWekQuUvtrT+IFqdm9P8uKmizi6/4DD5FRuka3vLp369R1fSmD1Z//v
 dK07WA1ghlExEwFYKF1iFspE32Qe0RgGgpDwelny1Q91vNV2dz0tfOp2cVwGti++cXnHJqL5IxG
 w9HLWoQfoge9sryJAOZiAsZrTCnPl2hLQpVTUlL86b8G8O1NTC32i9uBEjb1jyzsnAj347zdckV
 lkTbZSyLd
X-Google-Smtp-Source: AGHT+IEXe8eNk0NgU5CdcxMFcebpHj1eWStPLTJQqO2Dczl9u1LAA+GgRQQHbdld1zjwLLMjIng0og==
X-Received: by 2002:a05:6a00:84b:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-73905955da4mr17330953b3a.3.1742759185310; 
 Sun, 23 Mar 2025 12:46:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905faa5d3sm6441657b3a.15.2025.03.23.12.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:46:24 -0700 (PDT)
Message-ID: <279d069c-8bad-4cf5-b673-1237eabccade@linaro.org>
Date: Sun, 23 Mar 2025 12:46:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/30] hw/arm/boot: make compilation unit hw common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-26-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-26-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Now we eliminated poisoned identifiers from headers, this file can now
> be compiled once for all arm targets.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/arm/boot.c      | 1 +
>   hw/arm/meson.build | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

