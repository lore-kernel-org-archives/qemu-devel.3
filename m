Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC4CD68BD2
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 10:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCGDe-0007bj-Qq; Sat, 16 Nov 2024 05:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCGDc-0007bV-KL
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 05:39:56 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCGDb-0006GE-1P
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 05:39:56 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cb15b84544so431687a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 02:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731753593; x=1732358393; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wWJ0XcE4hl0R6xbdeo0xX0SnVB8ocXp3kpc6KuLJJvY=;
 b=LxF8XdcP4KS/uXPdJFgtllMLNik5vnjW14h0XKP+meYiF0yrbJm2YLTztETULvzYlo
 7RRqhRs07fB7cX4hTPpkCpXSo9MrQ9HhqolBaM7SvsotZxh4uRCkiMZgkI5YbXR19jBW
 GFXOnqoVYBJvg6+DlkGFt/jU8VcVS3HYe9HSqn8DHdrKqRtqj05GUT8fuMnZb0AGEpdO
 EnarvIZqQS0KP8H21mwNmQnIKBHUzk7EI4SWikFXrGEuzjN8T6+/TmX61whJtqfj05yn
 MFB3hOqXR7KGElxGdN+Q79MxnDozdzRh7Eex5rUdf9qwFbc9vmzDt0B5FXaa70qBJT+b
 YmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731753593; x=1732358393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWJ0XcE4hl0R6xbdeo0xX0SnVB8ocXp3kpc6KuLJJvY=;
 b=dtFMjFG9RqUvkYUIhaKx32qAZaXRdKDzSwM9c51wmJiaPnVASKXdKwxDt76Kh8UTc7
 VnVe345ucfp9xH9yMkSVaDaStIX3Yh7PyKhPlVDmWczE9VP0Q1bGylZMv+UgYN4MCf28
 wYmdWMN4N9n5FEbDoeO7TraNDvTszl3C8J/ICFApxsAP7vBLszubt0BwfXFYSOtS9w3a
 zSEKj+Q+VFhv0J0MeGxVwCGZ14h9qx4OETKCh4tACOs6mL6YKyRFA5YoqHfFp1DpS7zt
 8t3qxNPbzC1wjY0v0RLVqZOPMOhRJMti/I1/IWjh1zB0SZ5vLms5bBcsQcNUk1qqLaAA
 6njQ==
X-Gm-Message-State: AOJu0YyPl6/rsJmAzsPafEQ2yWR4viNLTJtftR+E1GgE0l85Y4CafLi0
 QhMh0AvnHc+YLAC9Mxud/uVJQHKSpyKJjWMSEZZ6m+BEJN2SxP/DyROQTYKLnS+YPmVsHyJLVr0
 njzcUyLXb432XXH+mjjMMJgDBsXzuI11FWRAJMw==
X-Google-Smtp-Source: AGHT+IG7bTTAb1ZzLx8ACKNvZWl+JPn71V32Nj7HUtvphLOJidvVEFSqWWap7G1MRdP3CdYJGtkst5+OIKrHDZHwQbM=
X-Received: by 2002:a05:6402:84f:b0:5ce:fa13:2630 with SMTP id
 4fb4d7f45d1cf-5cf8fd655aamr3765101a12.33.1731753593086; Sat, 16 Nov 2024
 02:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20241115205849.266094-1-richard.henderson@linaro.org>
In-Reply-To: <20241115205849.266094-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Nov 2024 10:39:42 +0000
Message-ID: <CAFEAcA-Og4proAP_LR60B__V-KvSLLaNwE5xO=mF8Qi+W1jPdQ@mail.gmail.com>
Subject: Re: [PULL 00/14] tcg + linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 15 Nov 2024 at 20:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:
>
>   Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241115
>
> for you to fetch changes up to a020e0a807a6e34890d1f2ca02e49f814fd0b64f:
>
>   tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc() (2024-11-15 12:51:27 -0800)
>
> ----------------------------------------------------------------
> cpu: ensure we don't call start_exclusive from cpu_exec
> tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc()
> accel/tcg: Fix user-only probe_access_internal plugin check
> linux-user: Fix setreuid and setregid to use direct syscalls
> linux-user: Tolerate CONFIG_LSM_MMAP_MIN_ADDR
> linux-user: Honor elf alignment when placing images
> linux-user/*: Reduce vdso alignment to 4k
> linux-user/arm: Select vdso for be8 and be32 modes

This asserts on the user-mode tcg tests:

https://gitlab.com/qemu-project/qemu/-/jobs/8388145379
https://gitlab.com/qemu-project/qemu/-/jobs/8388145391

TEST catch-syscalls-with-libinline.so on aarch64
**
ERROR:../target/arm/tcg/sve_helper.c:6321:sve_stN_r: code should not be reached
timeout: the monitored command dumped core
Aborted
make[1]: *** [Makefile:185:
run-plugin-catch-syscalls-with-libinline.so] Error 134

Does this need "target/arm: Drop user-only special case in sve_stN_r"
now? (I'd picked that up into target-arm.next but feel free to slot it
in here if something in this series depends on it.)

thanks
-- PMM

