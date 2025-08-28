Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE224C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEa-0007jy-QH; Thu, 28 Aug 2025 13:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdT4-0000di-Ox
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:19:12 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdT1-0005qg-Ow
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:19:10 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d603cebd9so8840137b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390745; x=1756995545; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXFG1JkXkzW0uGQyQjURN1rhGkj6mCN/lZi5jQeyg3Q=;
 b=mZRMjFexlq4MfHSNdViIgk7zCrLzAtnchPcLSjcxr77xuUfE4NUytf2hDOAPq6CAGS
 sPZA8H68JQN3tA5Hy9O9M8697AYq7nRvl7tsQjmxvBxw6LiA/CAU7/04vKTcPnoolkO+
 YPn/sXe+hNY3gdbG3Tb0LSN3pRKw2mLhBu3WBlnrdMuDM4YyPIFscZ4TWSa5V9Kd8RBy
 mWMA4kF+9BWPi1n9gLO1BMsu62mPsFSseOgDQLeeKI4rDI56kVDNvnueLlcqVuxlci7g
 OVdt23K7HPg1sPYu2/3Mo7XLu+oVYiRpzihe5eDE/dBW/Txy7lT0uK7NImtZsNBjQqa+
 I6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390745; x=1756995545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXFG1JkXkzW0uGQyQjURN1rhGkj6mCN/lZi5jQeyg3Q=;
 b=ZeMsmER/FT+6kuOVBHWGLwVK9tGaN6q9GltPQbclNHq7zLQCcBTWjOc3xREI6DJ8qe
 ufw4hQVYCe8xsDmQU0IRILN3lRBNGYGyMxsUzL8kwb+H3EHG3ibFdHxBOQfOydFRVuok
 KZgKE/J3ZemOWOsHV4BAX+k/yx5Gt4aOv+pfDEYlSUSENy2Zh6K8cNKX/BLNd5Mxr9LA
 H2GBGSpBRRZMt+SBlKn33/e4GT8B2ZSSPhGXrN+siyO+tY7HIUmFFgNAPlOsAevOtCQp
 MxPxRWqgOAqruhcN6BuBWoOTRPqkxscrsIo7V8OSkxEgqjE+mxKPUJu3urKve4xn8OYF
 MJNw==
X-Gm-Message-State: AOJu0YzrzQqioclDQAVgPNbCQ2UI+w30sckR/7eB8me5KkpXB9f/hHjT
 zVkZ77eMg536ulWaO85o3I11i63kdwyovYf0kjQ+nitAuspVNrDyDOsORiGjt6abRlNC3WjFrrQ
 KnqDheV80lnln/FzXG70MNYeKHjUrjCJT8cCgsCTENyZWt+LBO+dh
X-Gm-Gg: ASbGncvuxmS3uQNoJVKs8vUlmHtoVP1Dvzn+7FJgKHZz9/uLEYQ4obDPo+iePrkM5+a
 kbog9Ekb/KrWbUDgOAdgx1E5V+EYHQzD4TdJ+IEHPdcrOFbc2FXPR/hG35a+UZ/N3XvoEMuYvdU
 PsoZsSEw1sDk+KADQbjCYsD7J7RFCFhg4ZPccyq5dQ7sDMqz8jCpb0W4t+K6O4resU0aFpZqvj+
 zkv/WADEzrVfrVGNEF3EyOLrjmVMg==
X-Google-Smtp-Source: AGHT+IFN9Nw4GOpORy08UkbgyBr0/2JJR8EXhwu5o7MZsaJR/0rNPoE+s+qBUslSamSaVG8xHsNVBv0nDmyAEXHLiZc=
X-Received: by 2002:a05:690c:5511:20b0:71f:e6cb:3f8b with SMTP id
 00721157ae682-71fe6cb405emr226185207b3.48.1756390745238; Thu, 28 Aug 2025
 07:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-7-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:18:50 +0100
X-Gm-Features: Ac12FXxkQ82jCqTeYjJIdkkrlp9PGN6g5bsOrcC8NZS1XJ5LwS1GcKfKfbQb7Kc
Message-ID: <CAFEAcA8BUbEStGfzLNjWCUU4wtadK9pX9yiUJfdON_b=V3jgbA@mail.gmail.com>
Subject: Re: [PATCH v3 06/87] linux-user/loongarch64: Convert
 target_elf_gregset_t to a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 28 Aug 2025 at 13:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

