Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF07C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxkj-0000uG-II; Mon, 17 Feb 2025 04:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tjxkh-0000tt-NF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:49:23 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tjxkg-0003X9-23
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:49:23 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so4158160276.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 01:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739785760; x=1740390560; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yeyfPRoMCd3CAM/mZuxouvxsYVmXxbr0WoHT5lqisMQ=;
 b=gOOm82ZeEZI6r1ApF1bM6mPBLs6OYgNu6TlMwjO6VXXsZllFCl7OQdeFdX6hRyaJOq
 D+0IHErNZ5j3KmvDpQvK78ALHtY5Fr0aFbzqqyoQm8QA/7KmZ9omSYBE3/QGzw8j6HO7
 0Bic73bO5tREJSSmiza9jQM1oeLuKdCl0aDoXw+8IqTAMrXamszll609pqw4iMBoVxbo
 c/nTXVMtKQWJ7UmP3S57n9VzFv3GDkskaSq9j8LjRl2ySZWUGxQhE38N1bU6/0HdB/97
 9Jtto8yYLAzuW+tWGvg4HLnMrxH0QVZkyKAsKKI0W8cMdxKiAAZGpwxKZmXeHsNFkiDF
 tjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739785760; x=1740390560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yeyfPRoMCd3CAM/mZuxouvxsYVmXxbr0WoHT5lqisMQ=;
 b=IzQcquAVw7s5SyH23nfj+wueh2gosmZ1IUKVB+KgpPVCBQ0yxj878/u4wQ65XGbiQN
 g9/vcm5c4k/J8tOkSXDC7Mflmwq3GXtxyGOp0c1An/DZG6tgXq2fvYtoVp3f1s1Up2zL
 98EyXrh8H9wDmtn2zVzTPJXRcn+xKpn709zYJ/MeMFI+ajN/9GScJWwrfoD9e0UOgAdA
 yVctWDEsBKtrEeXrzH/mo5Y2gAqaow3WBTkONTudcBX/fb76uk3YWsMFgmgUiBWI8/XE
 7x8XYkz5eSSuHAiSTEBALI61R92o0G/iJsZaILfz8jYcZAhAtfsaKNmYSN8p0LFI/fLP
 kctg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH/Y+g3hbe0Qt1BAYY0tRtmr2JRNcFVshSApv4vt7gEPofqtS9CxPI+arxRdXzm9JfjbHtL+4116rV@nongnu.org
X-Gm-Message-State: AOJu0YzR5oGyi9L5CQ1e10GisdhoLq05zcEYmOO8ktBLMeXhl6Id+bX3
 K5Ueu4lxSKwpwvNwodE83fOp64TmRQWR8k9ZelqelhX1+Ql7uK80pOCei9JcXfflClKG36vkWiD
 u5od1i6/W+72cLuBREga1fVclIV7JRDvAh1Kdew==
X-Gm-Gg: ASbGnctzfUuGLX2TP/yk/Ek9nKLomC4Vr0SoiUXPHA0bI8O7gcppRWBHupxfSAxTE5N
 EvId/PULXMWgqjm2PIfj6Hg6MUNl2seXl51r9HNRobOOtPkTEegXc42mC5kxAMzEU1h4NzxAq8A
 ==
X-Google-Smtp-Source: AGHT+IFFFGoUugvc0Y9IHWzaCNv3Xq74fZKTgWMC0jyMSfw8jvp6hanxr1Gfu3truY2ZH3nhk98kxwDs7S+FLDuLWUU=
X-Received: by 2002:a05:6902:707:b0:e58:14b:6f99 with SMTP id
 3f1490d57ef6-e5dc901f547mr6924885276.1.1739785760394; Mon, 17 Feb 2025
 01:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250215021654.1786679-5-keithp@keithp.com>
 <f7c1e671-f114-40a6-a02b-575bde2de4c4@linaro.org>
In-Reply-To: <f7c1e671-f114-40a6-a02b-575bde2de4c4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 09:49:08 +0000
X-Gm-Features: AWEUYZlejb0hgZHTgmbhgdce8dFeE_u53f_sm0HD9QbqRkYBQOBusbaNx5mAvSA
Message-ID: <CAFEAcA9uGeJoVGpHBU=830ZrNBojsVT6fER6OBkDw0vDfxXU8g@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/rx: Load reset vector from memory after first
 run
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Sat, 15 Feb 2025 at 18:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/14/25 18:16, Keith Packard via wrote:
> > The ROM images all get deleted as they've been loaded to memory, so we
> > can't go fetch the reset vector from there. Instead, fetch it from
> > memory. To make that work, we need to execute the delayed mmu setup
> > function tcg_commit_cpu as that wires up memory dispatching.
> >
> > Signed-off-by: Keith Packard <keithp@keithp.com>
> > ---
> >   target/rx/cpu.c | 24 +++++++++++++++++++-----
> >   1 file changed, 19 insertions(+), 5 deletions(-)
>
> IIRC this is where the cpu needs to be part of the 3-phase reset process.
> ROM gets reset too, but with unspecified ordering wrt the cpu itself.
> By delaying the load of the reset vector to the reset_exit phase,
> you can always load from rom.
>
> I believe Peter most recently handled a very similar situation with armv7m.

v7m still does the same thing this patch does, where you call
rom_ptr_for_as() and look at the return value to see what's
going on -- see the code and comments in
target/arm/cpu.c:arm_cpu_reset_hold() ("Load the initial SP and PC").

Now that we do a full three phase reset for everything, I
think this probably could be cleaned up, but there's a
fair chance that there's some unexpected issue in there
that I won't find out until I try it. So I'm definitely
not going to require that somebody else does that before
I've had a go at it on the v7m code.

So I'm OK with this patch doing this the way it does,
except that I have one question: what's that
process_queued_cpu_work() call doing? We don't need
that on the Arm equivalent...

Also, if() statements always have braces in QEMU, even
if the body of the if is a single statement. But since
if you don't set env->pc it is zero anyway, you don't
need the if() at all I think and can directly set
env->pc unconditionally.

thanks
-- PMM

