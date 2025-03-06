Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6ACC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 23:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqKEP-000093-Oq; Thu, 06 Mar 2025 18:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKEL-0008VZ-6E
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:02:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqKEJ-0007Wx-IB
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 18:02:16 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235189adaeso20888835ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 15:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741302134; x=1741906934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QcNv71ZCuoXXGbwQ+4M8hddCjN8+qXhq0EMORrnX4/o=;
 b=BHLvTDNZs1yX2hN9klfySupL84q6tAKqQlk28aF2HpxTZeGKDG1f9+ny0A5HFnD1Vl
 ZwUjgmf73FXz/DA7JH9e5EXfkeb1ZPJaxYTbtJEKK0XR7HOIX/zx4ClBa8QrHOt8Muf2
 IXp9fxSOZmYmGLpa+3fBaD7leXp3uFc+e52TxBIdIReX7x92V/ubc+as8/5i4IVu4wor
 pjk5DCqxNp8vwnaATniBDFkK2v33kgFOA3tqDk64H33Wsn2rVeB/JLobSeJDajBIyJ9G
 ziCXJsCSlAro2ZL171piHwdwXDRR6Y4BmKpfPOI1YYim+Yzj2CD8S6F6j7JbguCtgSTz
 EXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741302134; x=1741906934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QcNv71ZCuoXXGbwQ+4M8hddCjN8+qXhq0EMORrnX4/o=;
 b=vpNhh3Ytm8wkYyJ8CYhg382csjb7hzmNbegAZl2Enntw9OWsff96ZRbKCHMZe6QJ7g
 2Ko6VhAyhqgZPrF50+qm4GkKz2WSsDlNNClgiFXnwUORKRzrBXTZmRDxaDh9D7H2l4PI
 7C53e5D0ldN8oxHKSTqlSmIHlEYUI5qhJyQZbtC3rkdPC01uXWl5QkScby4Ki1boxwt8
 LEYOMXQn+20QZzDh49sE3A2TeS6kh0zCzocIYC+UW38r7UlySUyHYrK2e7Mx+xJo49hi
 WQQ5F2tH+V1CnklbWkPR5ZAwp6PNrE4D3JbOXq5sAF+ruF2a6A1e83/XFp/BNTFReHwg
 MHBw==
X-Gm-Message-State: AOJu0YzZ+9ogOitoxcdUuWaSLwuhyY2eiIafr8Rrb1FdXZkAPnDpdBzD
 pkhPwTWJLHoq+o+7b07yUZpxtulrdiD0f2wF0lvRcVsBLC31N0E+h43OfOA6ZhXj9IxppFMXSMj
 d
X-Gm-Gg: ASbGncukiMSlYjvS5eNIvYRZukrSajrnEYCAu92Rc0PCxYR3N/lBK03T6QgvWQLlPlZ
 mII1n0BZC09px8HXuHz6XR9KWQ8lJ1wkGZJSJqanVZE/5jyGZx7yQPANtmTsINbVHoSOeQ6Y8zP
 QoX1jnFjA+BcVq3OyrqhsU6jDK+LH1ty9BUr36Qb544FpwSdeAiRhAYZHZy84LCFstX+R9moOvy
 I71quNbgpkyJvhtZHLa6BpYq8Z2aMt/UQxvcA+nVjVFhCaoh9hA4ReX61eCgH2h1FFAiHBLbPqe
 0Apbz5EranBqdWHOg3CUPYQA3YQq3a9sp/R+7pHkkudW210jnfwSpnUpA3vYsck0+eqaoqmvFFf
 PR7sIE/qm
X-Google-Smtp-Source: AGHT+IGQD+F1d4ja2xBe6Xi8REehvYepWgjjuV2McF40ra4IQGpYxXaZC93yPTeLERVR7CPzk0JFtg==
X-Received: by 2002:a17:902:e807:b0:215:9eac:1857 with SMTP id
 d9443c01a7336-224091ea762mr74689405ad.5.1741302133849; 
 Thu, 06 Mar 2025 15:02:13 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa4bf2sm17808225ad.213.2025.03.06.15.02.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 15:02:13 -0800 (PST)
Message-ID: <56eb8724-1eda-455c-9101-3aa2a736ba30@linaro.org>
Date: Thu, 6 Mar 2025 15:02:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/arm: Add cpu local variable to
 exception_return helper
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/6/25 08:39, Peter Maydell wrote:
> We already call env_archcpu() multiple times within the
> exception_return helper function, and we're about to want to
> add another use of the ARMCPU pointer. Add a local variable
> cpu so we can call env_archcpu() just once.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

