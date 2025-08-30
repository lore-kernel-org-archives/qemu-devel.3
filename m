Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259BDCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOui-0000pj-3G; Sat, 30 Aug 2025 12:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1usO9T-0003CT-4w
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 12:10:03 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1usO9R-00050h-D3
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 12:10:02 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e931c71a1baso4543730276.0
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756570200; x=1757175000; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKUq9aXBVNEFGXz2eJTobzHBSoZILgV4p48HE3fA75I=;
 b=guUxe9Vd12WUD7IO0Y4wqkYNnxhL6TueDaDfGvS6GFSnS0a0FYZF+KCm5e08O0O/Kp
 6lyDVViHGmuKAKdyuWTlMlClN5xtQuLcUzFlL8RgP8VgmDJNpUzkaRBjjJczK4mz2fw7
 YNYrqSjFszcni9PYvfkUai3Vq9sISXBW2+GDr/lR95vMw36I5Gq26mx6ajnaAtECSPaY
 e5Y82oMvJwuu4gYAfT/sxEuYzvnVja7nFgNdtjSfZ/HHyzmS0bW6VBNfMWPyaCw342sN
 fhwUZSPcVt2Ysn/bOeHiglfHmY4+xspb1OuW1AFpRV6B4/JC4tJSijXrBmYz1UonPfFR
 fHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756570200; x=1757175000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LKUq9aXBVNEFGXz2eJTobzHBSoZILgV4p48HE3fA75I=;
 b=nEr79jzW1G/1z9MsTeCAG4/UBAaY00lK4zBVrDsvWG6CjKYFVKSdANg47DApq44JFR
 J31Fps5u0OMF4ddYxgjQmn4BXwEroFBf+0SkoNcXfmbC7drLxJ7pO0WhOvdxiSEN7Nyn
 QEFbkgOwOZpNkRCllijbvPO9eGCWjBRgSdGGezhVYL0L/ageMeZLHWDcMmru2pnY424Q
 2+TCQn97Dj0yYh1MNRGSU+ztQ3aan8UPPe3lvVGlahALMUHV7aHX0yBJ/SrHgix8ajaC
 o/grIU8HiAgiqDiQW2t/BHPrlY3gUAz2juxA7vn70LiIWa+36Btf5bMx/6Uf+RDSEoQP
 bFow==
X-Gm-Message-State: AOJu0YxlPq2v12R5j89XPtZQw0psWRdxE33cEoCav8NstdyvUe0esdJL
 3/1VpL2cCZ3GPgEsjfcZ/okMK3gCo/KFJLuTiWeIwcAmQNvGmq87wyI69e6m2UaS4F0rvQueUpt
 XGAZleoq6pTzfmGdsYoPKYYm9FAVX+dk2fSCASBPpBA==
X-Gm-Gg: ASbGnctr0GAH+EsPc8/Qe8kfUfdsGTux0m2MXOFiLecvK5uBH+vVFXZCFn3UpvpuY8j
 o/wray40KJdb1YOl/FFCDSgGyYZ++6KCErRAM8YPLvk5B0ca3iey8D7TdS7NDsOffXBrvfDIjHk
 UczJ5hHN3R8E96EzJJ5Mx85rAkBulexFe2vKgmPVX9U4e/8Oj4z26nNHILQFzC7JKpcRF+FNTys
 6y3
X-Google-Smtp-Source: AGHT+IG3SV7XDcszrm1g8IEgUZygU4yw/FSn77uhPXW6H8TJga1pZaFibaLLe5IrZaUfJuUH5t8OpUjb2tiv1Gvy2T8=
X-Received: by 2002:a05:690c:4808:b0:721:21f7:e987 with SMTP id
 00721157ae682-7227658d458mr25290297b3.51.1756570199365; Sat, 30 Aug 2025
 09:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250830045006.380393-1-richard.henderson@linaro.org>
In-Reply-To: <20250830045006.380393-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Aug 2025 17:09:48 +0100
X-Gm-Features: Ac12FXw3v4WOi18q1Ue_ZyWyKgzD36Dl8Paw-_HttWhmBIxmuJ7mIaEUZyDDxmI
Message-ID: <CAFEAcA-Wb9G76uuN1UxjqZq0xJBtYWUCOT5nkXUV+8ZVZxed7w@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Rename isar_feature_aa64_atomics
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Sat, 30 Aug 2025 at 05:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is FEAT_LSE -- rename the predicate to match.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20250815122653.701782-6-richard.henderson@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>
> Hi Peter, this is to replace the version in your recent PR,
> updating bsd-user properly.  Sorry about that.

Thanks; I've just updated the PR and re-sent the cover letter.

-- PMM

