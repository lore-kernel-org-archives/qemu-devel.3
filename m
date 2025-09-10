Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255E9CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 13:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwKlW-00028l-VK; Wed, 10 Sep 2025 09:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwKlU-00027v-2A
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:21:36 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uwKlN-0005Ja-Pc
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 09:21:35 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-72ce9790ab3so12334667b3.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757510483; x=1758115283; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5b/Zxc+YPIuXfHUjWhDgw5lGLAQovkjnvzLajFb2YKc=;
 b=pRfZbY+Yj9Tm9nLmp7fd15jx72R1q88ohZ7giv+yXfxMoD9ELjQ6KXgFf3M3yU8n0+
 RosAmKmGmkchCO/lXsJAODsv8ZzZl3ozY6gN9FiBWka+RXV5GZPHftqJimvJbkbGhn8s
 386vRHIri56Xxhx6YUzRXZ9LxTQVSGlDpPW8rGjzAZkeDwO58E9+Fb2iMq3A70c/QSRV
 h3/deOtoH/6kHxvO+gTZqihj15xU+XLSteDIoi4/molcVHVSJMUhqo17ajbiTT46vi3G
 KDDGy0T2Qo1LB4i4juvmo6PkLn8FwcvKmaHueTLg9LJntkTvYYnuX7q7tV1U8HlQWzmw
 QKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757510483; x=1758115283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5b/Zxc+YPIuXfHUjWhDgw5lGLAQovkjnvzLajFb2YKc=;
 b=fQaQS/9V9I6Ob2VIqjPRMBURlDK8I/ceXJ8KDoPb6TAj88M6JegbJRNqnMS2dzVoyF
 nCuk5a/mliyVcxtFPkl+MzqlbUQIw9rjk1In4vI6J3xOs5Uyj6YI3d48JOOGSx7hZnHC
 vuhXx4aa2T1o3O06H7Ch3EvScepmZ50qFpvQUvC2yp6snn1oNm4125cqIKS1IABVH2wp
 YBsKa+S5jsY/a3VVCWqPDZUrdxlujf/cf4qS3z1S0SuDsx43Qyj59arHwQmcBGtNprGh
 5RziqlS97xmHn1IdFKQ3wP3YosfYvHnMZNgFRi5gpOsMugQg8rYxedSLOEPtp91oB7LS
 zEfQ==
X-Gm-Message-State: AOJu0YwFZ11C9hZeag6pA0teapWmkG6uaJzTWpL31bc3U7S2ZEQAxo5c
 Pgaeh1gLNV+6qWxJ3UwPi6irBK7bKiFhoK9sWc5IW4UlBVr4m4AcORGHK2lbqj0DmMIhNuinnhk
 /ur2fgXNjqrlS18CqBAbIcoigZHhbnJSxjtiOPuP4tg==
X-Gm-Gg: ASbGncsrvcpbOyyp4pFMZQWikwjzDV1LgKyxwAmqUanlogLYRc9Zg1RkUkQNOzdYbn5
 HgDgo8hUyubAQTgDEK8WaPaplMJDg4tDHCJu0Bpuz8Thy3t3DCo2sWzqrMgWB+Wx5kZVww3B4xr
 SHba9SNmOmBgZOMssxtjf8sDNmLQdOIJIUN08uRtanXRGJnYFvpIu2Hh2cVAFv86F3rKvNZ8vQu
 tMUuLN8VKSVtYo8BjpI3+C1OPiT6g==
X-Google-Smtp-Source: AGHT+IFkiuJ3eXLF6v3VJBWY+CYvr3WW1ws6o4nn0c4PBOF6vvKovWXQCMYSs6qG/BHIld8LKGcCmjT78fdrTfVyFN4=
X-Received: by 2002:a05:690c:6411:b0:721:5880:6b2 with SMTP id
 00721157ae682-727f5e3b124mr137363157b3.51.1757510483091; Wed, 10 Sep 2025
 06:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250910104836.449429-1-harshinimageswari@gmail.com>
In-Reply-To: <20250910104836.449429-1-harshinimageswari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Sep 2025 14:21:11 +0100
X-Gm-Features: Ac12FXz8afV3qgkBKcaFi5D7sXed3_DYy7dEWU-X24SoDhOaaGfh3yIw_MlR1bM
Message-ID: <CAFEAcA8tnPSeTLjs7BT5GqRWWgNpJXjvFUuZBsBA-mvpas+1Tg@mail.gmail.com>
Subject: Re: [PATCH v2] tree-wide: replace tabs with sapce and align code This
 patch updates by replacing the tabs with spaces and fixing alignment
 issues
 Signed-off-by: Harshini <harshinimageswari@gmail.com> Signed-off-by: Akshaya
 S <akshayasankarr@gmail.com> Signed-off-by: Sri Vishnu
 <108srivishnu1008@gmail.com>
To: Harshini <harshinimageswari@gmail.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Aleksandar Rikalo <arikalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 10 Sept 2025 at 11:48, Harshini <harshinimageswari@gmail.com> wrote:
>
> Signed-off-by: Harshini <harshinimageswari@gmail.com>
> ---
>  target/alpha/cpu.h               |   6 +-
>  target/i386/cpu.h                | 330 +++++++++----------
>  target/i386/svm.h                | 334 +++++++++----------
>  target/microblaze/cpu.h          |  20 +-
>  tests/tcg/alpha/test-cond.c      |  36 +-
>  tests/tcg/arm/hello-arm.c        | 160 ++++-----
>  tests/tcg/i386/test-i386-ssse3.c |  92 +++---
>  tests/tcg/i386/test-i386.c       |  52 +--
>  tests/tcg/mips/hello-mips.c      |  28 +-
>  tests/tcg/multiarch/sha1.c       |   5 +-
>  tests/tcg/multiarch/test-mmap.c  | 547 ++++++++++++++++---------------
>  11 files changed, 805 insertions(+), 805 deletions(-)

Please don't try to do this kind of thing as a single massive
tree-wide patch: it makes it unreviewable. More generally,
we usually don't try to fix up coding style or formatting in
older code unless we're touching that area of the code anyway.

thanks
-- PMM

