Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E51C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 09:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhQ2h-0008Rm-BQ; Thu, 31 Jul 2025 05:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhQ2e-0008Mu-QQ
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 05:57:40 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhQ2Y-0001fN-Nx
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 05:57:40 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71b5af2b2e6so4035617b3.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753955852; x=1754560652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qORoCOQNnxBgMqUuwRNp2GcohRoORejFqelkzIBCvb4=;
 b=QsAxN6Yre7MUS9331aIiw3l1QVfXXmRvGaLYX7J7C4fpi3qpbOoJ5SxVuOwk9WBICT
 MRpybkre/AYM3Tft9UPvIyZEbCiTqx0gXGZqr5dz92gkaKr3+qnmixKinuBmpA6fa8x/
 3CvIbzxCPERgYrEPYJcmK+qpXOTkGf4NSDLZACeOxtGwjbGJ/VHd1aMbYkhxB+wZh6xs
 RPAMvWvwgS2qn1JC3s3tUHWXd4NMQy+eai3QaBj5yMPoGO0a5O6h1XE00JBkwFltlSzS
 yQPFr4DMrzvqwukLcqp8sxNVeo6eYOvBladjw5i+CzgjkBe/OM48NvQnyAn0NChRDFIy
 tW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955852; x=1754560652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qORoCOQNnxBgMqUuwRNp2GcohRoORejFqelkzIBCvb4=;
 b=YG/pfcNnyxNEX5Quy8crpt/Y5FZs6Yh3NtgxrUmlWvdBI3vFNa/Q594dwo8RW+3rjr
 Rk/e3Xl3RGOzUVTDGZGumbqxiFzWlNr/0OgbytuC0+Sw6hPFpSO8qQJev96p5iLUCwl2
 uoj37PwlPaHkBWU52gDGzWzRR/1LEHCFJrdcg8WNhvYEmabIfu/M8h3PFVceXRfc2fFG
 yewco09wzE1vbxjyol+mN/baeVMA87ITQMGGdC6eHLx6f1WzyYz0wAazGgrWxAZYwCpd
 ei+5tb/lmWt/iDGEpeBTzyqV+J8SKbMDo3CZtF1PqIE8Qq6WONH71hgkKT7gzs+IL0Yc
 Neiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlM6ItQpCObijfkYpoitIMXrsTup6JelpsREG6OlSqydaYt6fxJcauuBer+NcejoS499CwUl51sJuQ@nongnu.org
X-Gm-Message-State: AOJu0YzclDimZfpYl7ooKoDbr0JygY5tXjbw4u8ZzJQ4rq1XUgFMEBJx
 M5jTvxxMgZ/SYwlBYjVO06hXEcaqGROPu4KppAuwVSV4h6feRaRdIZP/yzBxWhkd/11ZOPP9zjN
 5Z75foQzBWmQYft4+BCMhzgpl8+tB+chm6sO4DIP9kA==
X-Gm-Gg: ASbGncvIjYlgte209vP5x9dp4tmI6Mqd9gt0DgoSg5wNZ9DFXXfIzlFOkHxI74cYcpJ
 RyXgKNqZC2pl8GSGlFS2OZAVMrDXmNjFc4T15vT3/9VQxEN3acyuml9JIaQ25x/iTz9qmNXUQ/7
 gk/0YRU3IPuHaXwiP0tKVddK/KxcyQ0TIeY1181GTE00iAeA/QqrzGyDfiFG1uPpKr2dRPCdmOI
 mjPTel6Z9l/VfDdtU0iy6Dfl9ITVQ==
X-Google-Smtp-Source: AGHT+IGd18sYjAtLzLeXZwPVR1ImIAe6YhJZ97BrhPImtbcjwG7Ope+w5o1pORKIy3+dkRGRjcpO0cAFWh4IuA+ltwE=
X-Received: by 2002:a05:690c:9c0c:b0:71a:3f7e:ff0c with SMTP id
 00721157ae682-71a466d4ed5mr91440737b3.32.1753955852537; Thu, 31 Jul 2025
 02:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250725175510.3864231-1-peter.maydell@linaro.org>
 <20250725175510.3864231-2-peter.maydell@linaro.org>
 <12d5df5f-7fb1-4665-aa10-621505a4a44b@tls.msk.ru>
In-Reply-To: <12d5df5f-7fb1-4665-aa10-621505a4a44b@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 10:57:21 +0100
X-Gm-Features: Ac12FXxXBGG6_yM2agN9m9sSvj3lWmFvg0gMT9aFw9vdlRVYcQXjCxiJ_AipzW8
Message-ID: <CAFEAcA9FZ3DUkOUv7XSDi4gp7ub+G5XyrUnK5uTbs0g5Z74uzQ@mail.gmail.com>
Subject: Re: [PATCH v2 for-10.1 1/3] linux-user/aarch64: Clear TPIDR2_EL0 when
 delivering signals
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 28 Jul 2025 at 17:10, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 25.07.2025 20:55, Peter Maydell wrote:
> > A recent change to the kernel (Linux commit b376108e1f88
> > "arm64/fpsimd: signal: Clear TPIDR2 when delivering signals") updated
> > the signal-handler entry code to always clear TPIDR2_EL0.
> >
> > This is necessary for the userspace ZA lazy saving scheme to work
> > correctly when unwinding exceptions across a signal boundary.
> > (For the essay-length description of the incorrect behaviour and
> > why this is the correct fix, see the commit message for the
> > kernel commit.)
> >
> > Make QEMU also clear TPIDR2_EL0 on signal entry, applying the
> > equivalent bugfix to our implementation.
> >
> > Note that getting this unwinding to work correctly also requires
> > changes to the userspace code, e.g.  as implemented in gcc in
> > https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=b5ffc8e75a8
> >
> > This change is technically an ABI change; from the kernel's
> > point of view SME was never enabled (it was hidden behind
> > CONFIG_BROKEN) before the change. From QEMU's point of view
> > our SME-related signal handling was broken anyway as we weren't
> > saving and restoring TPIDR2_EL0.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
>
> Is it worth the efforts to apply this one to qemu 7.2.x branch?

Well, it's an easy backport since it's a one-liner, and
it's not a complicated change so it's pretty safe. There's
no point unless you're also backporting patch 2 of this series,
though.

In the 7.2.x version of target_setup_frame() the "clear
SVCR bits" code is a little different, but it's still there;
the change should go after this part:

    if (env->svcr) {
        env->svcr = 0;
        arm_rebuild_hflags(env);
    }

(there isn't actually an ordering requirement, so it's
just neater to put it in the same logical place)

-- PMM

