Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E77CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc5Mf-0006oy-Tj; Tue, 23 Jun 2026 13:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5Mb-0006oh-RF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:56:46 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc5Ma-00038j-6y
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:56:45 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-845369f60faso172176b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782237402; x=1782842202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G27w4/HW98E1d6bCFYsEGZIH2rHjsO52gwE++GCsu6A=;
 b=TfPlADo2aD9taExPWYyZR/4TDwsFM9x8nbOU23GyGt9sdKsoZz7WpF69RnR993By4s
 JSRUGfg4Zxe1OJvwz952mRCmpDePJjcUh7WjryBTMPBO4ILo2g7BVEp0y5CUVt10Ot+Z
 1nbClGo9eqs8NsR7xwrRlGB5PbKm184TA8Zlabet3n4fS50vH7JfdGFj5G8PYqs+BWET
 QTATcD0eADPK67ZUCiauQn/xjzUxnG+hs0SYbFoSovmnZTO/A4S95NWCdTFR6AU3yi65
 ZAla9Ua/bDuwTRgX0x5wue06iXc+f3yS2MrRAe42I6lfAm0cY4qUa7LqYwovJ6lXIE8R
 vZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782237402; x=1782842202;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G27w4/HW98E1d6bCFYsEGZIH2rHjsO52gwE++GCsu6A=;
 b=byeTJWBLPPMCnhfZdd+IQ2rn6bRKSXLQRt8bItfxxUWtgNSb40G7pKk9q3pYdLE3k1
 Ki1LJLUVYTSIsSuzoiafoDGWr8SlNaOjY+Z6sNhaoTC8URSvN+eC/pd0SMpXI6dW8BnK
 YX6oLCW8CIIKHepBtdCQcJK44ikoObkttkbR6R1WpxYFspkDsIOnS4/GjQ15CY0WLw75
 Y5ClEfPXJeVfcZiMFQ71tPzcng9tCFxlAfZ9I3NEp4UdmM+3O4rVcSuDA08wWj4E1wlG
 Jw3Cz/x7gHxuWncfTr2poGPhRUfDwhfdX5OULhOBXXVML9+q/YqDGw5FCtOhvrvNPRfX
 qXgA==
X-Gm-Message-State: AOJu0YwendQFDAFWVxJSy7P8aInr+3OsLegogzPIx8XrAh41dK+j5k7k
 fejlfocw9hpHuO65AesCel8E2x7/b1RF1urJtq/CTEgLI4TD1vopE9dS/+li4ccmrthWx2rwk2C
 XvrTu
X-Gm-Gg: AfdE7cll320sB0j+JEGgEdcok3zFO5JeT16Cgx2txwJA14xaXi5LmNeXIWyFssVQETI
 4fzOJp+VkcRo1+N3y4tu5QloQACGhJIVUBKmT8Ees5mGb9kU0Kg2CIoGoZxTRFur5w+adxN96PH
 Xe7wnPTgUjVmZl4zKEh5bU2jslFpJKOYuonYMNFskgVuf2mrCtEAx6BnrHgtp/kFRgLfu6+rXQo
 c33ubm8oxKSgWa0Lc4aap+eaUE0vgIdrUasLKCBo99mGqfzMVDP6uguOy+MhD8xYDbiY83776nK
 z36ZiIf7PFFkwsBv3kl1piTkmPfR9whUxd//nWzXu4hW89gUfJNg5YxZHMQX+9L4oc246+gwLfB
 r1OJpbC1xJ8dBvte99V2t+jYkAF5wAUoK/XJ8qOgtgJXrt8Y5EHZkfyszOkdR7FYS7+OL5X41aX
 ovg6LDxqHs+MlQ2yZVMPZkCEUlM+y8D9bukk1SNWlVrHL8cFw0eOLTUtBI/Q==
X-Received: by 2002:a05:6a00:f0c:b0:845:3d4b:8f79 with SMTP id
 d2e1a72fcca58-845a2c4aae7mr64455b3a.26.1782237402009; 
 Tue, 23 Jun 2026 10:56:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564ee3dc2sm10898137b3a.58.2026.06.23.10.56.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:56:41 -0700 (PDT)
Message-ID: <4719589d-f439-4b9c-a727-3035ea8f9d14@linaro.org>
Date: Tue, 23 Jun 2026 10:56:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/40] bsd-user: Rename cpu_env to env throughout
 bsd-user
To: qemu-devel@nongnu.org
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
 <20260620-misc-2026q2-v3-2-f6ce23ad8dda@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260620-misc-2026q2-v3-2-f6ce23ad8dda@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/20/26 21:19, Warner Losh wrote:
> Replace 'void *cpu_env' parameters with 'CPUArchState *env' across all
> bsd-user source files. This improves type safety and aligns with the
> convention used in the rest of the codebase.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Assisted-by: Claude Opus 4.6 (1M context)
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/aarch64/target.h     |  2 +-
>   bsd-user/arm/target.h         |  2 +-
>   bsd-user/bsd-file.h           | 28 +++++++++++++--------------
>   bsd-user/bsd-mem.h            |  4 ++--
>   bsd-user/bsd-proc.h           |  8 ++++----
>   bsd-user/freebsd/os-proc.c    |  4 ++--
>   bsd-user/freebsd/os-proc.h    | 26 ++++++++++++-------------
>   bsd-user/freebsd/os-sys.c     |  4 ++--
>   bsd-user/freebsd/os-syscall.c | 44 +++++++++++++++++++++----------------------
>   bsd-user/i386/target.h        |  2 +-
>   bsd-user/qemu.h               |  6 +++---
>   bsd-user/riscv/target.h       |  2 +-
>   bsd-user/x86_64/target.h      |  2 +-
>   13 files changed, 67 insertions(+), 67 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

