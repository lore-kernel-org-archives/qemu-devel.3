Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF61CA0FF9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgC2-0002ew-76; Thu, 28 Aug 2025 13:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdg0-000610-FV
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:32 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdfu-0007xb-7l
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:32:31 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d60157747so7156327b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391543; x=1756996343; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gD+6GICgRh0MgCOw7LSfx6njVb3um4eKPqU/4VJ1teA=;
 b=vrz2ZN8Jy1KIUBoP/WUPwPHcCR7IQ6RtDbvMo7NUP8GGDIvV8B6Igr65ZHu9/IZyyU
 wlikz/WqWkfp3MoW4htZSpG+kbKWzFJlAizBkwgyGGq3f+txcoYGIRnL7LbVJ/cUzodK
 5SKdQCXRRNA05oT0O8g5SMF0oVlbpCR/QEvaxGLxtbMeFwHBaAGrUdit/p+cVYtl3Aiy
 kfL8HNNpUJwcXZjHjbiTAcMFNJzpyyMym9JLSYivLFyjla9ZuQZ4qVpr6VjmJhfBFvUy
 6xqLO9bmrGCn+TeMx3EZ2GxiJegRd9EvAWixX9XZDBp3+c/UrB3sQmIkSRMZHs8CqSzm
 k8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391543; x=1756996343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gD+6GICgRh0MgCOw7LSfx6njVb3um4eKPqU/4VJ1teA=;
 b=wMYDq68K7YUe78x+qTpbCB+TXXjFaYCGjqIeGa+wElswx3xNZniPk3zTkQHpLcbNqI
 YbhARVq3JsTCAkQsgNYy2qVM8y2xFGV2lJlq59uOLpAS96wzRYD0Vkay1DkkqtMVE5YB
 iw79I48ZOoFQ/eKwJaYiPTr7wczIDQskzMRpwy8Q3k/bcXHjAscmKxiTaORcnQWY4C08
 Rf1uGte/PZ+HfZD6Co3Dd1UkFx69hfHx7dPlUpG352FsklWQg7taoASiOZ6NkIVTYa2B
 IyXFQK4MEsrDtCYnlB3oe9ic2R6QgI7PJSz6q3HN2lB9TO/gMYbywC4iI/7fEjhhFott
 GJCw==
X-Gm-Message-State: AOJu0Yyycj4KFaTrs6efeFUMrqr78lNwUYl1SxB+lpf4/aad6/J715BU
 jOFE+7uT6X6e4/LYqSL7zWXMNNJ05r+l95T0/zvbM011Kc0V/P8YGJoxBttgtQfFgsnGu+HHHid
 oi7YS4CbIaQog31O7txW9xg4lyG8y2qBV+oF/nLylVIayQ0xpgvDR
X-Gm-Gg: ASbGncu7e0mo75A+N5TnvUMkB18qDm8UCrwiOiHKPF1zNh/ijcTwY7j1Zkba5iOvwH9
 PNRNSgtVeliwtYNA1XoRVSYGcTI8WVIDp0byZWI/A97mwZH9Vs+CHbsTZhbZCNrwHzCbVAxUxCq
 rhqgSq3aiNzIlExZ7hALKtzVWHMrNn33gVEs8QBR4byJ3eRzSZi9IShbpsnCU4sQPUgG02bj0aq
 atLKvpU
X-Google-Smtp-Source: AGHT+IHVlRbtDeHUvvZb32l2IPVrxNMfL4UeJzLHBCFjfB6NYPL8bzoMvEcpghm5RpyO/hzaSO2lsaVdpSRf9wt7QF4=
X-Received: by 2002:a05:690c:7208:b0:721:369e:44ee with SMTP id
 00721157ae682-721369e66c6mr110155197b3.31.1756391543301; Thu, 28 Aug 2025
 07:32:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-25-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-25-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:32:10 +0100
X-Gm-Features: Ac12FXyiqP6mCnvbq2r4miKJwcwDkclaBYnkFntn2AvCryCFqA92b_3eE9ik1Sk
Message-ID: <CAFEAcA-GKY9GRyRPVRyUNqr6zLS4gh1EXtwU0tWgf1OEuGpA6g@mail.gmail.com>
Subject: Re: [PATCH v3 24/87] linux-user: Move elf_core_copy_regs to
 openrisc/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/openrisc/target_elf.h | 10 ++++++++++
>  linux-user/elfload.c             | 16 ----------------
>  linux-user/openrisc/elfload.c    | 12 ++++++++++++
>  3 files changed, 22 insertions(+), 16 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

