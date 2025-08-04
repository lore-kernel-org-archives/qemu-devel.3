Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB96C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 10:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uisPw-00029W-7w; Mon, 04 Aug 2025 06:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uisNy-0001Nz-RW
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:25:49 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uisNe-0000Iy-Tq
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:25:41 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e8fe929b147so2105942276.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754303117; x=1754907917; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VxzOPyKntFPBkPGBTV5ZZJWRyXl45ZOvysNz0k+cXXw=;
 b=u6Qf00sbYgDjKyiimQvbKKqc3YIn5ImZD8kDrXiYoSeI+TJ+7UvFaXvT+3itl0Lfs7
 qmAzwALimGHaI3cfN73Q6x6u621jrtDGhpuvKubhZt6DTdCCU/yl2oi1mjtIkc+yqOMv
 JZl4E2S/OI2DPH6B72mM84AUYJjx3tbITftlqGSfUIFktcirMsOlQo7Q1sJrjbz2p2fG
 WDu4txYVWlMHD8bTltTQbIjQKVMHuXO4XkYACVT7obh2v1LX8bmKbQ86acb++cqjHTpv
 QS+7xZn2wTF7uvGtQyfpdfiHf3GYwQ+8l77owXZEy8qpigNHBlkXdIw8PweCmIY/URG3
 I5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754303117; x=1754907917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VxzOPyKntFPBkPGBTV5ZZJWRyXl45ZOvysNz0k+cXXw=;
 b=DFh28ZNmv5fPGDnP4EJoEr8TF+SZcws19rncNA5+CjSQ7iPPYa9z5AbCecYiOo42PD
 bFpOmTYzgktn81b/wEQkRnO08fiFgauQtCzCpwnrETR/SYvprwTg6jJSlTGmF9KeeLot
 o1qf1uWqmKxvYWkppkgGottaXjXHseJ0bB1Q1cRQOvWMFfZ02ztQ/AnTiTomqbQGyLm/
 rlO76OoethtdONKI8ctRauvCtvW0rk4stD7Yw0mcGEN2kAUh2s5XyU1zpI1uKIQe4MAG
 nTf7oUCT9aPhrag59i7u3cTCBPHDgZo1JdQhAWfcwMjqrOmrhFTL1DXt+Ep6S7/wgMI9
 3RdA==
X-Gm-Message-State: AOJu0YwgGNRIcyF8e1K5ypzET3pB10Nv0qto1XtXkMlu3aBIwiyb3JD9
 k9m1XjYHqcIs4qIOCqIQa+hZdcNjkb75CVCDZkdnThbar7WMj1ExJfvpK86+F9U1LhbUhN2npdt
 Q5pUkFTzBf4t2j+u+vARmbMHuaPekZFNflRGZy4UKjlPpl+L1jpg8
X-Gm-Gg: ASbGncsFA4OU8dY+AoQCl5/0vvUcDhvILH2GUYZFRdIfO0R7p0527AMVsAGcnYWcoqq
 9xBPquk3QlBspvkb2bwcelzkD+hqSXSISyS3fIIxH4zlQ5PvFxKxt4DCFopIaTbluHDzDYa3psX
 Uln19h0b/3AX9vtCv5O9W0HWGzANbQOLXQUXeI/gVFPoXdyzTk4/p5n1XMHmzCs6AuOxP5mm6SQ
 Ou3NkLg
X-Google-Smtp-Source: AGHT+IElfxs5rBgoto6QNe6y9gOgcqFSWvyjDB6aA10kOSV9ItAaDTGWRd8qdJlU6p8M4A8t4Vyuv41lq/YUzYs+Dgg=
X-Received: by 2002:a05:690c:11:b0:71a:407d:6a2c with SMTP id
 00721157ae682-71b7ed73e1amr108620947b3.14.1754303117649; Mon, 04 Aug 2025
 03:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250725230849.13026-1-richard.henderson@linaro.org>
 <20250725230849.13026-3-richard.henderson@linaro.org>
In-Reply-To: <20250725230849.13026-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Aug 2025 11:25:06 +0100
X-Gm-Features: Ac12FXy7L9iiMBjdc2t5e0e-BouCySNBC5OkgM6kZnTCBIkpZGrilYMvepGdwBE
Message-ID: <CAFEAcA-6vUEiV0_dQftMKieOSMdo=KgzXJGgttJik9tjVCekhg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] linux-user/aarch64: Check syndrome for EXCP_UDEF
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Sat, 26 Jul 2025 at 00:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Note that we have been passing the incorrect code for most
> exception codes: uncategorized (do_el0_undef),
> systemregistertrap (do_el0_sys), smetrap (do_sme_acc),
> btitrap (do_el0_bti) and illegalstate (bad_el0_sync).
> Only pacfail uses ILL_ILLOPN (do_el0_fpac).
>
> Note that EC_MOP (do_el0_mops) ought not signal at all.
> For now, preserve existing behavior signalling ILL_ILLOPN.

True, but you'll only get an EC_MOP exception in linux-user
if you're playing silly games (like manually setting the
carry flag and then executing a CPYE or CPYM). Still, it's
not particularly complicated to do the fixup so we might
as well implement it at some point.

I'm OK with leaving this as a FIXME with a comment like

         /*
          * FIXME: The kernel fixes up wrong-option exceptions.
          * For QEMU linux-user mode, you can only get these if
          * the process is doing something silly (not executing
          * the MOPS instructions in the required P/M/E sequence),
          * so it is not a problem in practice that we do not.
          *
          * We ought ideally to implement the same "rewind to the
          * start of the sequence" logic that the kernel does in
          * arm64_mops_reset_regs(). In the meantime, deliver
          * the guest a SIGILL, with the same ILLOPN si_code
          * we've always used for this.
          */

-- PMM

