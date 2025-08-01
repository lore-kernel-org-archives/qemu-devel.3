Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F0EC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uht0i-0007WP-To; Fri, 01 Aug 2025 12:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrf1-00082h-LK
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:27:08 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrez-0005Nc-Rc
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:27:07 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7086dcab64bso10573687b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062022; x=1754666822; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9e5wZD1bvA5UAE6+guKG9hcWvO0/CkiIe14zzJcdVoM=;
 b=y++AFMl6s2fOAI3SIhMQPmUEpHBjfst1ORowMuWFy3lihGUGGFufmPaHmyR2AwHF4f
 zOxipRfWoo46ASdMy60K8X7DsriPeObvGhcGswVyWVAMsO+EFEXtTmPrBPnYfhvrLkAu
 sP4QCXq+php0coQi24Kkzfd995zKqt9baq7r81gcRSDCcqQ9bFu8LKF8lNNcB0rDIUQ8
 eLc6w81dZVfVV0L1/cuXJZcr0y1KyhBmflsGPqBJH+VSiBnjeqCj7+VxoUAEd7LlUkqB
 wES6lE7Wm2AnGHNoh4Js9ONKixAeOLd2TQrHiY2woYNZg9+yyqeA6yetCdD933VQmIyK
 34NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062022; x=1754666822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9e5wZD1bvA5UAE6+guKG9hcWvO0/CkiIe14zzJcdVoM=;
 b=bBgLO9SyIxPnVDL24Y9exoqVQqKWDuneelZDdh4yIUL4/HtDjkk16HpgwWIbPAanOJ
 1ponAS5qRh18xaLXzGM7JguWAxNMQfAeeJTMH1eKDKPoQfqJLjrYRysoTKlp6cAZbUqc
 wIaZhRvJaO56fjxdw+pKvQ/5UGSYCDD4Rc9ndo2+0NFkg9qfYvDHASVOiB3NxHep8wZH
 8TxVLzX6TKuNbvUZDLuK6Zw4QGMsyRxOcxE793Enfe5f2J5h3MbA1FUnshIQwIyukHrE
 0TXDMMjS2Zu3EMScWoDcvacoZtN4sGZndNlbSz65/6tVYclxv6ewJDdzxSsdAz8nB/xF
 fblw==
X-Gm-Message-State: AOJu0YwOTAGu3FN163Qc2JvfiNN2VjZCoQcT0Nb0hXIwwNQgWtpRr+qW
 ExRWLhzXamRKypoA3SLuLuoU1XeLOHStZT74P8LnhKA7W78sQcfRRs8dc773kE4Fg0ro66TuSO/
 /Mczm4TdkaGmY/N81hz4v/wzclZ6wGoTu2/OD+B5E7w==
X-Gm-Gg: ASbGncvxdIKx3JI6JYeJ9Vb1YUwzMqa677qLp9Q+vNrHpKlmvtOmBNMFBu3XejiFRVx
 ojNt9II6Z7I1GyPhjACWJS2I3AbU5YEnaBrlqFqU7dp3ChonDdrsg27l+DCXK36U8fIeB44u2X9
 Gp/XOXdLOPWNgrlMBismza70+JPOgfkQNe9X7LX/VmIMj+J8bq58FTfgINn0eD3oH2rYR4YQ1LN
 jJ/7FjPx5pYoN4yBck=
X-Google-Smtp-Source: AGHT+IEhelGTkxQ+IWn0zVFOI33jdlQim+UQeM7jr3kXRpjIkqq3v15bjF5NG4IT8bnqx4gG+ex6/DNJJ98LZw4njww=
X-Received: by 2002:a05:690c:d93:b0:71a:8c1:fc8 with SMTP id
 00721157ae682-71b7ecdab07mr1499537b3.2.1754062022112; Fri, 01 Aug 2025
 08:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-14-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:26:48 +0100
X-Gm-Features: Ac12FXwLfNxDA7ph7ey5umttP8VriV1qAUItt-YlZOcWFAXi5xZcxI3WhMR6r_w
Message-ID: <CAFEAcA_8TimxsXg5wQonOjpp1Q2ROE7ngXNYAgt-L30rTkhQ1w@mail.gmail.com>
Subject: Re: [PATCH 13/89] linux-user: Move get_elf_platform to {i386,
 x86_64}/elfload.c
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

On Wed, 30 Jul 2025 at 01:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move get_elf_platform to i386/elfload.c; pass in CPUState.
> Create a simple get_elf_platform for x86_64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loader.h         |  3 +++
>  linux-user/elfload.c        | 18 ++----------------
>  linux-user/i386/elfload.c   | 13 +++++++++++++
>  linux-user/x86_64/elfload.c |  5 +++++
>  4 files changed, 23 insertions(+), 16 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

