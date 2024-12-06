Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA289E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTtW-0006Uv-Vy; Fri, 06 Dec 2024 03:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTtT-0006Tm-Eb
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:40:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJTtQ-0001Ha-AX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:40:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a099ba95so18574115e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733474454; x=1734079254; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L8lj204z9qcw8GDPqhFp8iGreEjATERZeqQPdzoIcbA=;
 b=LBrEHFsTD+nG9CDfmb5FysL/FPgVlxkCgbe4jFTwk/IelwCLAQ0WE1cCgHPXu0d971
 oVxEuUqztOT9nPwT9LlLkkmgI6R/AnG5WKVFxwnaoPgEIf6uE/eQT5fOO/Q3rPfDqMaD
 0z27ncQDP+EI6J7uyDmUs924QY0I7XJes7n41koFvSK7s6KuZhZVXmxcqNi9YLfHtR8W
 WZWKPEzvi6VhUk3YjZHzwqbpvr5KJdmfcpE3OMd1H6DbBpF3so3mCdu51U8xttfymxm8
 CvpnLYGWkMBlSSjj89JluGPPsKtC20aMlTL/tHA6kxFc6muD3dbidajZDnhTen6n9hnJ
 anjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733474454; x=1734079254;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8lj204z9qcw8GDPqhFp8iGreEjATERZeqQPdzoIcbA=;
 b=c6Gg6VbxzO78lBgeaxecv0iDzC1F3EK3KOmjL2LMO35uav/0noGshfpdTQ1MDiibGy
 iAxPx6Yfm8BepWP3lsDO0Q30484BUmeMblrdhzDxCQY2Zb9VQHVJHZFdwge19hdUkyY0
 ml0QU/e0FsJRWPIBNgqQ0lksCMS0OYjGoYnPwVEOft3uVBq8s9scPzvTP/vRBlHASPra
 bdiZFBRo0Z2sgMhGVk4BgsHwPqZwbeLjOOIewpmlJYRPN2HGKkWYLpZ1BMqV/sW0Sgg7
 leNpQ+8a+bKypLZQSNT/wMP9+VA9ZZNv0ERyiZn3wGzjwTKod38adr+ldtwnm7k0p3cy
 X+kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTUPR0+trx4LBnwiD8OG5SrjYg8iGGS+ms++oOFBbgv3tNOTI5bRXiKVc8D65DrJ6ZBAWIgwYL0bjp@nongnu.org
X-Gm-Message-State: AOJu0YyioJjABlVbVJGBlbOOLVZ9MUo7btPJqamkAM5eYGM9ackaChIU
 4SLYkTIeC1u14/wKS5HavU8X3WjGTJPbXdkNvVnvD+lQj/GLWq/YgU4rvUP7fJE=
X-Gm-Gg: ASbGnctSH1gcJqmZqBGzhnhOQVZOA7X2Fm+EFkcCD2AADhLxbANUo3bStYkI/e+Y5i6
 C4VEXmKOkgXd/mczVldSfU0LO+M/kSzCc4TgUpfWjxqcEhJhEbNqq08e+UsjGs/6PIhKCc3CYHW
 ASriR490ms83n7FhqVzUWUqR/PhjGzAPDQx2uy2VEj9rFDIrwkPqpctRjPxgT5nOBg5Eu0wCYy7
 8iLVNGnaHi2Wn30S2jvpbTk7Bjda84xcJltY2XjIpDLz+sd5FyXeWItI2jLIGKHR4Eu1JqOOywY
 AlKz/OspWBzuYX1VkQ==
X-Google-Smtp-Source: AGHT+IHQ/+o7Lwdp7I+u27a/uHl+JET8W/+AtcSjBnZMGgGDEFA3HnUTzo2FsI7JSNV31HGPTWtXkQ==
X-Received: by 2002:a05:600c:45cf:b0:431:1868:417f with SMTP id
 5b1f17b1804b1-434ddeadb1amr21125965e9.17.1733474454647; 
 Fri, 06 Dec 2024 00:40:54 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf4119sm4001407f8f.14.2024.12.06.00.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 00:40:54 -0800 (PST)
Message-ID: <d28cbf6e-eeda-4751-8226-0433975eb9e9@linaro.org>
Date: Fri, 6 Dec 2024 09:40:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/arm: Convert neon_helper.c to use env alias
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241206031224.78525-1-richard.henderson@linaro.org>
 <20241206031224.78525-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206031224.78525-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 6/12/24 04:12, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.h          | 56 ++++++++++++++++++------------------
>   target/arm/tcg/neon_helper.c |  6 ++--
>   2 files changed, 30 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


