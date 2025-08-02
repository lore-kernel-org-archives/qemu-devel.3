Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF174C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJCk-000135-Hl; Sat, 02 Aug 2025 16:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJCi-000117-L3
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:51:44 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJCh-0007u9-6A
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:51:44 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8fdbd45e10so2062801276.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167902; x=1754772702; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eWEPn9MvEFyW5GejOjujmyz6er7L0QAJwNpmlGpI+9E=;
 b=Pl7Qrh721rv61fjJ7Ubzmkrdwx7Yr6N77aG++iVJtvhnejCCb0EalsU06TI6wf6Pmx
 mOJu5GfJwmo5PCAAK2KnfWvtW/yXNs6DR5NzZPPuq3iQL8GER/XebEFy5+LYtbQTg7r8
 lHuZVsaxY42ag1f0zG+Il0eNydVWt6f1C/KANvItcloMb1OgJXIIqckUPhwdgL2TNMP6
 Fcug+5/qin3eY+KRIwfEVrrdTzVq/43RO9peRAbj62xe3yWDBl8sjPYtRGfsx9M9rabv
 v5yNmJDTzHizhZa6DWxmOb8qmiq/3FYZz8wBHjtT/kfdTH5smt3Pe1jtLhP7+iESwIAH
 WVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167902; x=1754772702;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eWEPn9MvEFyW5GejOjujmyz6er7L0QAJwNpmlGpI+9E=;
 b=SyUdBu4iA+FTo5JNghfzYpXWl9j+wP5+SFh0WFzKfIJrCer3hCqTNlSU5wbCq01WhR
 czRWgoWqRzQD99t2yeuFDqfxY6/Fjcm/0T9x6tGwSWNbMTBRSOUSXpVO7bgihoQnFIP2
 PoV0YCr+/altkPWX7yEFSaH2sH2q6yBI6DuAyc1D1IbeoaDl+ok6+dcDf3Uhsfgudnqk
 PbOQujqgC8A6N/+xENG8CpKZU7l6TvHaXaI4Ficrwhim7LKlW7tJdSi/nTNk2Ikc8LNQ
 ehBVOnYNtfafZOnA1pL9f629anGICmGYg0y2qFKnlL5FS7tiYKSozEiiEJNNOjolHFrT
 6Vng==
X-Gm-Message-State: AOJu0Yz7nWJjJFupOuHi1plE9BYH3a0MP0A/CGcS/dhjHtryt9fPOAXp
 ai9IqSW5pc5bjsqpF95qk6uxTIYgoJebdDBxRGSvYQHy6onJFA5me69gxfs+F80a+T7iaoko2m/
 ccCoAEjSoYSHqG8GTEO1X0S91UhdQruxdEUnrPoVexg==
X-Gm-Gg: ASbGnct6QVV6KJvvn0Be0PrQVZOa2yGRWt2yyqyNlNsjiLd1p50yKJ5F2ZmhNkGUQSX
 73BizEk/q3v2+79+wH2l2SDyROgxdtEXBb1JY85sbpILCUJjuho3liOCwJUJWwgiaH4i0PUVEl4
 HZd94KFuseHxbOXsn77dtKUXFGUf1Xqs3SnSPjFZzrAmw1JzxO5fCPj69am57aTM9lHsrNbpM0z
 kuC3/fl
X-Google-Smtp-Source: AGHT+IHvbYFk2EGn3jk9s0gN1cVvd00uzhCX3M4TuFWgKS72r1OcsaPVvsa44oLI8lWcRGaHd+by/wo0tK0vDoWAieU=
X-Received: by 2002:a05:690c:6d02:b0:71a:3276:d6e1 with SMTP id
 00721157ae682-71b7ef654admr57793807b3.26.1754167901686; Sat, 02 Aug 2025
 13:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:51:30 +0100
X-Gm-Features: Ac12FXwcMr6ZKjRyj9qXAgh7obG6DesQAKNOpsKaU_qbt5N2P2RUlQRSTAsVJfs
Message-ID: <CAFEAcA_WAAENjvMDPujw1Z5RvuY3F89i_-m++5YyWOvcBQnG4g@mail.gmail.com>
Subject: Re: [PATCH for-10.2 00/89] linux-user: Split up elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Wed, 30 Jul 2025 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The goal is to kill the massive target ifdef ladder in elfload.c.
>
> The functions get moved to linux-user/target/elfload.c.
> Define weak functions to provide a default value, or a
> weak reference to determine if the function is provided.
>
> The core dump types and functions are moved to
> linux-user/target/target_coredump.h.
>
> The macros get moved to linux-user/target/target_elf.h.
> These are mostly use to parameterize include/elf.h, but
> there are some other outliers.
>
> The init_thread functions, storing into target_pt_regs, have been
> merged with target_cpu_copy_regs, copying out of target_pt_regs
> into CPUArchState.  Merging these found a few bits of silliness
> where pt_regs fields were initialized but not used.  To encourage
> this never to return, remove most target_pt_regs and hide the rest
> within the relevant signal.c.

Thanks for doing this -- it's one of those cleanups that's
been lingering around not done for years. I think I've
reviewed (or commented on) all the patches in the series now.

A quick grep suggests that about the only remaining target ifdef
ladder we have in the codebase is in linux-user/syscall_defs.h
(where we have things like "struct target_stat for each architecture,
and some of them get to share the asm-generic version".)

-- PMM

