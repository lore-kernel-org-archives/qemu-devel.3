Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFF4C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KTt-000338-Jv; Tue, 22 Apr 2025 16:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KTq-0002yw-9Z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:44:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7KTo-0005zI-Ji
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:44:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so59970595ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745354670; x=1745959470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KkEZmCpCC7C/HBqdvssxkRlTdh4w+ygT6C85BzLbacU=;
 b=j3iEM7gahjZ0jWB+CAMhUlT53K7+bPWOkZOi0utXXd5uOPJZZKolHioRhVys++S7ON
 IoFjCV/XXmz1oLhWaveeNkEMujg4kH07ig3HGan3ZE30gfQVO3jrzQxGgEZh//JXOXfx
 Ttme4DTHKorKgrOB6j109SR9YH78b4QMavQgyISmAZW81l07mulLck3kemRJ8FfIani+
 7ilJlTzAEWHp7alo66BVZTMV1gU46yzSET8JNKQg4osvgsjmw67ecVCsLTzCk57hsSAk
 wRQ2WKI+vr82Qv+YEOO9/SIpzOjGZPeOVso2FnfShwLQ/O+NjBc4HDBGRmdR2ufx09ZH
 Cm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745354670; x=1745959470;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KkEZmCpCC7C/HBqdvssxkRlTdh4w+ygT6C85BzLbacU=;
 b=CdUIxQqXCeQ3Ds0Ifhu2o3mrMfmtKDhogrXsRlr3lGsgGjdBscSwxChGaX1/mE/TT4
 nBygd0B3G1sXYtuw2thOzjt3YVd2d7ZR8UKaBiP3zbwg/IMvz/fE58gp2Cuiw1QCkVKM
 Fs47Yw2clvkXe4I6gLW7I8PLVwHnZqGmBdKHUuyoL3TBpeanjMX0/xnu+83SC4K/mCDi
 ZdtOgd3iwUUGVkOnyKcIIHWm4F+7o2vUHG5pW+1fRlYYLmmjzj8rIP94zqZKUGLBEYi3
 gyCaErXi9qPJR/dokiLYbnlfAA7PLR7nO3phdWEOx6KkH6lFcg3M/oOPszDVGbqxgpnZ
 7KkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjjW1zWTBdOtvfaYa/fec3rTE9c9HCK7B3n0B8axTr5ikqpbac84zKxzMyePrRUfHWvKyW2HE6wyeO@nongnu.org
X-Gm-Message-State: AOJu0Yx9oBGsv2mANIHcjXHMvThd9GoGyCL+SMEh773eSiJtCBpafAoG
 PHQ6IyTiu5svLJ9nYeYWKWndnVNAMwRH2GI3CfQ01bZkW48+DiqGIZZU4qms+5w=
X-Gm-Gg: ASbGnct8lVOoOenVXWdHrPWc8Atpv9tGPIoE2f5PbfDArAJl6z/Yi4Y1+/5wj3wk2Ie
 eAc+UzFzpyVKIvnTaPbY4ILe0cXXKcpsDyxGxQTTqLKs0dVGlD6PEKzXTMK0aqfu4L01n2I72YH
 hQqCfZ2D5M1sF3AUnPTPE3TvVufrLhOVlOOezWUTs5dHKcnUICughrzjsFpDsxmMP0dW/wFrOaQ
 4sbpggK2JtBL99cFy7Z77Zdv+Ic/WU/2nChwXMbHmwrZsfOYLRWkubWDQ9zM1pZQ0KOF9oLalfi
 2PGKzos0ilntMuVpc1B2JTaolLLOwzPrUdfuL/3a6J0Ppf1I4JmHri1yBQL3V8XO
X-Google-Smtp-Source: AGHT+IHgbPAQVBCQYjkIJMvJGsSWv8GPsQZcGE38lv5Q/GkKLrVTOn24Rz+Dg5lW1XmWLb2vDotmzQ==
X-Received: by 2002:a17:902:ce82:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-22c5362f4a2mr229799745ad.47.1745354670713; 
 Tue, 22 Apr 2025 13:44:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm89665405ad.237.2025.04.22.13.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:44:30 -0700 (PDT)
Message-ID: <f8937396-430d-447b-bc58-56b22fc17a56@linaro.org>
Date: Tue, 22 Apr 2025 13:44:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 056/147] include/exec: Split out icount.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-57-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-57-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/22/25 12:26, Richard Henderson wrote:
> Split icount stuff from system/cpu-timers.h.
> There are 17 files which only require icount.h, 7 that only
> require cpu-timers.h, and 7 that require both.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/icount.h            | 68 ++++++++++++++++++++++++++++++++
>   include/system/cpu-timers.h      | 58 ---------------------------
>   accel/tcg/cpu-exec.c             |  2 +-
>   accel/tcg/icount-common.c        |  2 +-
>   accel/tcg/monitor.c              |  1 +
>   accel/tcg/tcg-accel-ops-icount.c |  2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c  |  2 +-
>   accel/tcg/tcg-accel-ops-rr.c     |  2 +-
>   accel/tcg/tcg-accel-ops.c        |  2 +-
>   accel/tcg/tcg-all.c              |  2 +-
>   accel/tcg/translate-all.c        |  2 +-
>   hw/core/ptimer.c                 |  2 +-
>   replay/replay.c                  |  2 +-
>   stubs/icount.c                   |  2 +-
>   system/cpu-timers.c              |  1 +
>   system/dma-helpers.c             |  2 +-
>   system/vl.c                      |  1 +
>   target/arm/helper.c              |  1 +
>   target/riscv/cpu_helper.c        |  2 +-
>   target/riscv/csr.c               |  2 +-
>   target/riscv/debug.c             |  1 +
>   target/riscv/machine.c           |  2 +-
>   target/riscv/pmu.c               |  2 +-
>   util/async.c                     |  2 +-
>   util/main-loop.c                 |  1 +
>   util/qemu-timer.c                |  1 +
>   26 files changed, 92 insertions(+), 75 deletions(-)
>   create mode 100644 include/exec/icount.h
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


