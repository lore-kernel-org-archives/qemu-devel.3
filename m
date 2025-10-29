Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243BFCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE686-00067T-Dc; Wed, 29 Oct 2025 09:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE683-000679-7p
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:22:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE67w-0007wj-II
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:22:18 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso91774555e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761744127; x=1762348927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ByU3/XTnS7lbXZFMAjEKE8yq7ebQ+6LYh9WRGoaNsZE=;
 b=zS98BUZES/gPOXxCZnI1WHaKgCrc9wwMw0f6n3fg1JePmA9Wqg/qHphjJyoHKsnbcE
 RwE0uCdFqMUgtPrJxaVJuFX11ESzqDMkmvCnXYbikDBaKn73MTC9XB56SXtUdS7lNa2R
 QNt/Kq6+EpJ758Xeo5Z6NGxDrk9/l1IB8UFO6S3UPg9p/cWPBldvynWjn7iCaM+lpZ/n
 /tlu/MIuJhXqmwedcwxZh3FiPCO56WzyDlqeBMAfeR7pvx4wP0Q6brGwuQ3Tj+J3ybSy
 oqQlyzVWTnjRWDJla38ucOTeIX8EkF1ewMZMCsjpDq2FuY+We0+dJbdpWwSOBP1s/K0u
 h28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761744127; x=1762348927;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ByU3/XTnS7lbXZFMAjEKE8yq7ebQ+6LYh9WRGoaNsZE=;
 b=cFRGRgoLp4pnmqBeANB+eiPNj3TD1ytUzJa3COPjhW2hydtsnB59mangjhcKkouIMF
 bMQpixaW7CHoCYetGJ+DkWsOla9t/p880SbxbMpolZ9PUGRZtmRGMo6ywMWMi7M+RFj9
 GGOW+7mFrQXt57bs8wpxr7XJLA70ABNu1JrS27EtOg1AtMe86pwU0b5oDZR1ytYjrV6g
 jBE/XMnCjRbycCi+jdKNRAITC7qGq3uJ/NtnvyveV5DbWXUkTpS4E/Ev+LsaGnaYamQ+
 ilpBLHdPh8aJyHa5FC4MhmsdbjW4kqOUJlNB8eVNPTbtV/z3n7mLRejRrz99G/jUkQYK
 o3YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEh7orUBAVVNWLo4B9jAZUOYTiwXAJezy6X/7czfkwCSKqYJCq6Aw7b+viO7iIg6rNpLualIWWSPZ8@nongnu.org
X-Gm-Message-State: AOJu0YzzvSLHNLQuQCrgtPywYJRYXVKBRgfiIzusMiPmw9L/4veztRiP
 FV99baSk4dM/5aTh6kKFkXWg0+Jhy0TspmrLUO90UmIHWvNF0dXt+ZqA5+I0cabGTwwIuePumoj
 2PtsrMvs=
X-Gm-Gg: ASbGncvmKvYx9VVPkZgQWBSbrWadf6abHvSh4YuIcomG1J1iyodIb0T/kPeF8sA/bX5
 m7RYMlHcHMKh9vQeZOW/I0TnItNjDygMCkuOiBb7L59v9gmUctDhyTkD03ZKZjS9qlVumZhYi4t
 6JUuYKKa9eQiCcgAwlFsb0sYCqlb4I/yvav4zjZoFLMCTNk0OcrK3XjQBA0e0EQkaQqrJFqFYZE
 edZmk8awge+gT+2ntsbpgxT7L5vNuaQadfJ4XDj1rUgVZCae8xl/S7vMsxXg/x7tK9yW1J41OXj
 N1ad/68QnE9p2ZTQMVSlUdNJXyYkvc7cZxo8zy6Ki5lQA5NNHTj/6xpcSbddRnu/s/lu4OY0Zpj
 2h9UR0SxmzE6mqihIzwAS04ZXFpRidMFZQPlgSYfvBRb9KLx32kwyu6eS0KSP6bBPbVjZ0wmU8W
 zKOkSBZSY5iuOzl2mvojpEtKSe9i1xaKoWAxn45VRFRSk=
X-Google-Smtp-Source: AGHT+IHC0G9bfcONBFeCHaLtdBovQBO3LyxtgaGIoxMRbIjIHvWVEXMxpgSBsryGeY2NUP7yYRCTAg==
X-Received: by 2002:a05:600c:608e:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-4771e3f0102mr31095105e9.19.1761744126754; 
 Wed, 29 Oct 2025 06:22:06 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e202182sm57369895e9.10.2025.10.29.06.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:22:06 -0700 (PDT)
Message-ID: <b258bd00-3c8b-4a6c-a9d5-86b7cb1227d7@linaro.org>
Date: Wed, 29 Oct 2025 14:22:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tcg: Simplify extract2 usage in tcg_gen_shifti_i64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
 <20250928163155.1472914-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250928163155.1472914-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 28/9/25 18:31, Richard Henderson wrote:
> The else after the TCG_TARGET_HAS_extract2 test is exactly
> the same as what tcg_gen_extract2_i32 would emit itself.

Not /exactly/, since tcg_gen_extract2_i32() even optimize
for ofs=={0, 32} or aL==aH, so this cleanup is even better.

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 22 ++++------------------
>   1 file changed, 4 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


