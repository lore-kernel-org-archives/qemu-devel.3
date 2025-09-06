Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA2DCA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 06:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumYA-0001Bp-Gd; Sat, 06 Sep 2025 02:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumY5-0001At-BG
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumY0-00054o-6o
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45cb6180b60so17537845e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 23:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757140630; x=1757745430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ri8ON67gkLPqgnqTdm7LR4KDRGqjQdFiShcuURoDY7Q=;
 b=uN/iTVu1zFAcEH2OfD88wv2NQ08vB5fiu0d/Xv/1MXtRSVhJIxR9F5oExiRToE/gQe
 4LmBsgCzKR4iPwqALpe7Q6mBqOBmOYfJnKHkCtJ7U8dTD0fpKMIFt+HGeSwjb3oCGH19
 sGWVcvL1peC+qrCMVYZ+E3Cps/gNcKx9D31YxAxKBthttA0p72HG51EtXeQL7AJ9/tpE
 mg8kYMGGvQ+tggj6lif7QwzgiLeo1Yf/khs/KNDobzrP2kTC7nagpmXuJkpYDUqBxjmD
 Xoykc/tGnoWYglmELQQfRseNZyUis+tpTD9sD8PJA8bx0o4A7EuTY1zzBqFdWEwHhZpB
 vghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757140630; x=1757745430;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ri8ON67gkLPqgnqTdm7LR4KDRGqjQdFiShcuURoDY7Q=;
 b=MWYrQgIH+P1SEapxuvpCKlzkdf3lf8qyXC4BPeRBrdacTm0vDbZmI+t70N8YjfOe9Z
 WS4mSGsOaMPQXY5moSvAqmcP+8FKKfnQSgLN0qbmkl5KOvqw7vywR8tb8qFc/5fAhcQl
 tTDbv5qojxNW0DjkByi/0uOVBLjNjP+GhpTS1E62BIoge2bSWRe3Ui395oeNBQyhJmk8
 tzHnu5C/03JKepQ0/cqn7G3O88FIzr+7eFZ6BRLVBkSGMmMmqod8AOyeRnWJCBm5e3Ly
 Th0O/V4E1c/Dn0Zq2O5KMudqpr31MSUotHcdq10tL+7WZG3mfPMkNDXjGhxgZVFbAsbH
 BWzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL4q5Cb/U/G4AA0spjbjb/QA8yieyae+KgLSHN9wldjNYxcqKeVw/AS8wVQKYKGE4R8x/GP2cvOgGL@nongnu.org
X-Gm-Message-State: AOJu0YzjQdICJnTTcwG0E8Fn1AiR/wpRJEFj++kDVNK6K14GITXM587x
 Go/Kw76x5ddkC3juWpIY9A+OnpLSGeSjtStJ2POpjMf5iN3R44mzrGLkkRiNVitMHfc/tkzHVT8
 LygvLAOD53AlC
X-Gm-Gg: ASbGnctt7FPzwUN9z7NGGUdq/3hDuJC9N3OanJs+wA5rcA7LXqaYBxEoajR0l7AJvOB
 UVJYT0UUBNRa9YGO8lZSM2V4IMnBuB1TYa6Clhz2DrSterjXRbpu0ytQ8mVVQL3LJn7Bvxg2FnU
 FukPmNjRToqcXVb2g3emmenYrsohId0UPnVorhqE9gvRmCKCq29wApQMk62J65KYS2eFBPvGWha
 DYjDAyAmTV0ez3Ns6W5IlbH9rNzUW+CUJCmu+e0cVRb7koVEpZVdQOZx6LEbJf+/Y03itwf4ptv
 Q9f8lIZ8JND36Uhg9oC/SoAxch8Ogmuj3v6RrGoOTzG8CFA7Q+MD4PEkkr8bwDUoRcw16i7rddN
 QlGIAC+2NO/3vac0VU4rhqFoU7jLn/vXBbIXQRbw=
X-Google-Smtp-Source: AGHT+IFTBPKJWTZUUtAAMu9m/ceWmU+ytngl7pIblLhVkMetUd46awg4iXNdpD+sZH9NNmfDPEgKVw==
X-Received: by 2002:a05:600c:1f13:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-45dddee8ec7mr11236185e9.18.1757140630400; 
 Fri, 05 Sep 2025 23:37:10 -0700 (PDT)
Received: from [192.168.104.251] ([217.65.133.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd60b381csm61111985e9.17.2025.09.05.23.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 23:37:10 -0700 (PDT)
Message-ID: <1ab2dbb5-cce0-4c3e-876e-5ffae803faf9@linaro.org>
Date: Sat, 6 Sep 2025 08:15:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] accel/tcg: Split out tb_flush__exclusive
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org
References: <20250906051820.160432-1-richard.henderson@linaro.org>
 <20250906051820.160432-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250906051820.160432-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x333.google.com
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

On 2025-09-06 07:18, Richard Henderson wrote:
> Expose a routine to be called when no cpus are running.
> Simplify the do_tb_flush run_on_cpu callback, because
> that is explicitly called with start_exclusive; there
> is no need for the mmap_lock as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tb-flush.h |  1 +
>   accel/tcg/tb-maint.c    | 28 ++++++++++++++--------------
>   2 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


