Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413FC28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfL9-0001Dz-D9; Thu, 13 Mar 2025 05:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfL7-0001Dp-Ak
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:58:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfL5-0007XJ-OF
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:58:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43948021a45so6155075e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741859934; x=1742464734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dV9hsJCpskUOw8Cn1h7Bos4uiEf9kDHJ2k8wIsN/VOs=;
 b=mMlFUgY/l2DyVhGRrTEFVAot+i0Fv+YecLDs1/SzWDuCQrsJeWjcKZxciFsExU2ioB
 yvtH+P1siD0OHVJwwUaUnxdjkCOsi4CYW1YAxQ11Quqm8i6EfL5+jrY+YWLTTEsqds+1
 BRISLkvTsO5cEjc17Rju5GndZhp8QLEJ1O/mIBfx1A5EVwnFoshIInjum3AlvbHC6h6U
 iI5xLtOPymC9vKvXzRgD6FSSgOj0yZ8Khk2upjA3yX75vDOdiMy8jIbnpr4bbhgk8azO
 xCEnPCBAk18rCRcNLCQDccAJsJVOkSvRbuvoDUrmBATd+WPtbOcvtMazcL05BawhMrkq
 tCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741859934; x=1742464734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dV9hsJCpskUOw8Cn1h7Bos4uiEf9kDHJ2k8wIsN/VOs=;
 b=skrOfcGmQH+XFA6Wy5QYgFjKe6+3WIx2KoncDW4pDAHIdxs+WIVOOnsRVHNnmpXtiG
 1g88cKoO+/LXXwiC3+1za/PShWClMXGsX4uVdTcavmm8k0f+GbW5+zI1ZlxppsZQqgHx
 UmtN831KY60Y8MEktW5A/EkALnbyG9VE8UplznAnTLtFJ1swXcu5HTHlS1g7mfE2c+KL
 2aliZVwBliAEv7OWerH5DFiIJy24k3oNFV6tK64sKEk7H6XuPb5zS5oL/6yo+vl62lio
 JdXieL52yKfr7RJwM7q4/9t1nUzEUALclEt+4+CKd52bGOcrUja+EQiCEIgoZTC+Ktsz
 t5jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUBwYzLcetE5TSzuEny1GizLGxywu/i3/uQch++tKnAt2an7BQZW0nLKT1S9UUU1roXAoAvQxm34UR@nongnu.org
X-Gm-Message-State: AOJu0YxteIJRApx9RYSrSo7El4xUC+9a/Db/QMTCUzqeskBa/rTX208x
 UbTa0pvY3OmW1JB2l0tGrX9xhVuLoZMZz2FWmNjYmK0COrHR/TeYsdlk8+tYhccq7VojK5cIiwY
 Zh3Y=
X-Gm-Gg: ASbGncs/i17AYJBUmWu7saYgmUy+3QPmJvpBG8X4gK7lv9pvlKgp8p9Bo9g1YgUTZVz
 42ZQiWSjDsuf2lSmgpm9ERqdWayOhAWSDpC54D98NKlEKf42WeQfBFshlhZlYqpmAyHcjJAzdiH
 cnP298I73HuvHVcTdg4hzenEsE5lyFxOrXwK4V7mkQF+xhU2e33O2vL7j7KiiOzaQBL8wLn6wzM
 NrNNJy49M3ZvSXCKufkRPeWeuYFEZiiKuAf502i8PUeTteHL5QqZCNMVWgYKLeZYktmSmxVnGog
 VTI2xdzVOYUvlbiaJML6q+kdg2Goff9ucPSjP98WYoO/1F5c8TQevZHqda1Gx9OIinzRQ4mLha3
 hjnU7WrnEVqSrDFc=
X-Google-Smtp-Source: AGHT+IEr9zPQy6JGCbZv8N3jQzeJHp/H8mQbqdCXnQ5/cVfI7BO26/L4RNCme6srrGxgR3+fzDErmg==
X-Received: by 2002:a05:600c:510c:b0:43d:1b95:6d0e with SMTP id
 5b1f17b1804b1-43d1b957027mr3900925e9.23.1741859933795; 
 Thu, 13 Mar 2025 02:58:53 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a12sm1551702f8f.75.2025.03.13.02.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 02:58:53 -0700 (PDT)
Message-ID: <0272cb13-e973-40f3-9659-dbc8c8ccbff5@linaro.org>
Date: Thu, 13 Mar 2025 10:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/37] include/exec: Split out mmap-lock.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-14-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 13/3/25 04:44, Richard Henderson wrote:
> Split out mmap_lock, et al from page-protection.h
> to a new header.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/internal-target.h    |  1 +
>   include/exec/mmap-lock.h       | 33 +++++++++++++++++++++++++++++++++

What about include/accel/tcg/mmap-lock.h?

>   include/exec/page-protection.h | 22 ----------------------
>   accel/tcg/cpu-exec.c           |  1 +
>   accel/tcg/tb-maint.c           |  1 +
>   accel/tcg/translate-all.c      |  1 +
>   linux-user/arm/cpu_loop.c      |  1 +
>   linux-user/elfload.c           |  1 +
>   linux-user/flatload.c          |  1 +
>   linux-user/mmap.c              |  1 +
>   linux-user/syscall.c           |  1 +
>   target/arm/helper.c            |  1 +
>   12 files changed, 43 insertions(+), 22 deletions(-)
>   create mode 100644 include/exec/mmap-lock.h


