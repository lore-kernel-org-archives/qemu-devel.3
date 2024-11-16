Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A151D68BF1
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2024 21:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCQC0-0006SS-Ut; Sat, 16 Nov 2024 16:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCQBt-0006S0-9o
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 16:18:50 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tCQBr-00022d-BM
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 16:18:49 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cfbaf3d88dso102200a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 13:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731791921; x=1732396721; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wRJs4n1HfM9bWPiBgGraVzDgStU3yevGXbH71ZWNNUY=;
 b=UwMHu97gbnlB1pperQ5HQ5ktGqJhNYLjVBcqFRN54NThY7x3NXWV76cpDshSs3WB0K
 cfi2GZ4VetlxzxUG99VCoK4ueUffxa8HYdLT3C+ob9kYBYDCzVCHRgN+jLGYrCmaE0Yq
 5s/63RNR4VvqoFhVGt3vjcAFicgwlNUYm8+zISkXLKumX7LOuhtaxo3TqGOSrf2gqP+n
 7hhNyKNLi9qoNaFtNiFzJrNmtJ9eS55iqDL6VBEdG1ACFe4uHrhcqO4V7TBXbkZi2mz3
 +ewA8wYQSvvAILGeALn8iGr2czn6Vr2KnbMcbF5YnYQAGT6eOY03w1DF3RjCBEDNEjc2
 h9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731791921; x=1732396721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wRJs4n1HfM9bWPiBgGraVzDgStU3yevGXbH71ZWNNUY=;
 b=IA5++WranLR+hraYRsZq0Q83lWGl2v8gDPfQ6a5aSFaLRF7QTy1meY1740A6Gs+9X5
 6Q4B+vTBYrGL+n+HoAh9UnBEw+ftUcpl2ER73CmndSzyELtCmnwQuRIE4Js9Z57eTXrR
 1xA4R41DIuDrZ3zS7XfJCT8lkVpLN0hc87CKYM+pFR7Sq4q+5R4OuRUrDOPkRUfizHoW
 jHgckR7/B3yGqSwn/Nkzcw5nID/5viSLGaGztyArpfPYvLU/n8KIuJigAI9/ep8m1fqX
 HYBqziVK3ZHXnQKa5Pp3HuzeINv7m+6Fzr4fy728OIIxEr7aLGNPNIpHMZjFGWHw8/u+
 1+tA==
X-Gm-Message-State: AOJu0YzllYf1iPPIbud8jiJE+m+DPulaqafXKSkB0F2hesHKu/axlF0g
 7nNztPL01GxKr95KNPZyCW0+scYt+S8Lxai/iJSfL/H2ctpR3SQwhS2hjpNMyZBHyM4AaE+2LKP
 eaHp+WI9mRKKBLdAWCvnu6q0908p6tcmd8JXIm9w+KQS2tYIu
X-Google-Smtp-Source: AGHT+IFFr7weL0OlB2Escgz/8c0jj4SDZ+Ay1LY3Km1Aw/AGZ3qH4GK2kwe3h192XG7icPffG/CzTtXMaAp/shOhvWI=
X-Received: by 2002:a05:6402:2789:b0:5cb:f1d7:56ac with SMTP id
 4fb4d7f45d1cf-5cf8fc63764mr7628734a12.2.1731791921397; Sat, 16 Nov 2024
 13:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20241116170555.461462-1-richard.henderson@linaro.org>
In-Reply-To: <20241116170555.461462-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 16 Nov 2024 21:18:30 +0000
Message-ID: <CAFEAcA-h5WhtDHS_8YtxuxXG0+guFfx3HS3Vr45nQbKezZKXgA@mail.gmail.com>
Subject: Re: [PULL v2 00/15] tcg + linux-user patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sat, 16 Nov 2024 at 17:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v2: Include
>   target/arm: Drop user-only special case in sve_stN_r
> as a prerequisite to
>   accel/tcg: Fix user-only probe_access_internal plugin check
>
>
> r~
>
>
> The following changes since commit 43f2def68476697deb0d119cbae51b20019c6c86:
>
>   Merge tag 'migration-20241113-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-11-15 14:53:36 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241116
>
> for you to fetch changes up to 8377e3fb854d126ba10e61cb6b60885af8443ad4:
>
>   tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc() (2024-11-16 08:42:25 -0800)
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
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

