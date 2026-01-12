Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A3CF45AE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfLCX-00028B-MP; Mon, 12 Jan 2026 11:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLBK-0001mu-5b
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:54:21 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfLBG-0004nn-U8
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:54:16 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7927261a3acso21938567b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768236854; x=1768841654; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A4QqGRGEFz2bTy25mma4Z+BsY0RvKLDT+NOVxKIrXf8=;
 b=rrJrg4hUPvfnRBjRWsagduyi0lN0SgLWjGhGNAxoP+Yl81T0FFbyjil+eimV7YC4fh
 9rhyDVLxU9wD09qUihiz6XQbCzA+IC9PDxzki8Ci3vdYymMQCUzLfKNc3N2HsWPtiG6y
 7D9OJ3nEe+2grDnDQHr6z6QXr/J4NHMMf91x1uxpZ1ET0U4rt5cAqYqbD/kWYr6U32ae
 YyrrMPRudQGZMjAEjcc2o2npt2wqxKR7el6KBNz5m/g81zk1CnjsP0nzv/EV39WuU8RE
 svKnt4jPTg1coZ9FTD6nXdkAGm5OB51oFE3aRm8RWYEpp2z3Dh1rNxVdLBRh2FjG5jY1
 m22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768236854; x=1768841654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4QqGRGEFz2bTy25mma4Z+BsY0RvKLDT+NOVxKIrXf8=;
 b=NdYA6SlVV/dD3Dy5HdLuHuQIgdqF92Hl6hhdILAIYkMyE3uEsl3lh0tbr/1dD4e52S
 zoWuKUcJDl4iNmNWVlJuFJXskvuimOK7pqKzUFZZS9W2oBh/0IqMup3DILHwzQyAbrVl
 E1oscjguKG7rrFa1QbNeg6dAL7ZImKIgvt7v5/YBOhTtNywsYQsrWQahtOG7SRl+fPfi
 48tkDxlnOPB/NopMMmPAG94ycIG5gJGozVvPA4BMIxtL4kW9AXkBtwdEFZjTclueqts8
 8Vo4YqDQkBiEgL+sgC3xnpDwtJTv6HbOPdXmW5ip2zLwomBaruV66p9B01zX5PLtHNma
 hoQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy92HdZh143g6uoE5k/d6lzJGQEYUYutbXo7e9JP2p6qQZm88YZObeuvNutmJ0svRC23fbM6m5KsZu@nongnu.org
X-Gm-Message-State: AOJu0YzlB2amONLYDpL+hf7tPMqS+FAAj22ZZkKB6M0lQCmAG5kBUrkK
 TU6Q98S9GmrBdHjwJCEBAIQdOcv4u3qrJk/5OKNXhGQnpDiVLMSmbmha3KrJFq41jGX7kiZSTPX
 chyxsX9Unk/IPcHAAvP4ul2qnk6GiGDneCv64DJYPjw==
X-Gm-Gg: AY/fxX7iQx6O8+ceCtnWGIPBX2odQgyA9ysZl68LWGMn7UF9PMOtOSXR+vVBJx35upE
 FbKHL2CQNJ5r8KH2WLomTh4p0OB4Wed3x0Asi1Gjsga7DU4lcr9hbZTrsMPahOKAfNut3fay+Z/
 j5Nhg1nWLE8wzpjOsuEyUSz3sF1HScnjz0Ze640MbUvoE5fpRABJBPZL13q1rPQOA4llcvjS7Bi
 Iytrs/ho+5G/I30J9PKWVSTgOTGqcz7oL9Xu/vy57lGWB+/nkCq10xgPIP1QffZlT2hbjUSsqwW
 Wj4lG2QG3eZiKxN7MzYLd3hAyx2nKJcetA==
X-Google-Smtp-Source: AGHT+IFk/e8qSjIjGkCsR/wdJHTg2HSEkYFy1vX4bCFLl7KS6C0/Wt9ZWAyGFnJjJs2aq0MnOn7uTidixusipd51NrI=
X-Received: by 2002:a05:690e:24c1:b0:641:f5bc:6995 with SMTP id
 956f58d0204a3-64716c79edamr11500942d50.81.1768236853517; Mon, 12 Jan 2026
 08:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20260107145220.18047-1-pruiz@clavium.io>
In-Reply-To: <20260107145220.18047-1-pruiz@clavium.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 16:54:02 +0000
X-Gm-Features: AZwV_Qjwh3wrfHjTTriQw3ucyiEyKB8sfTMlbcLCEFls2TN6Vyc-fdibHULQWrA
Message-ID: <CAFEAcA8bW_8PqAdhCdthG84MTj8ZDtc9e72n5Qv3PSaYX5fY-w@mail.gmail.com>
Subject: Re: [PATCH] fdc: Don't set FD_SR0_SEEK during automatic track crossing
To: "Pedro J. Ruiz" <pruiz@clavium.io>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 7 Jan 2026 at 15:31, Pedro J. Ruiz <pruiz@clavium.io> wrote:
>
> The floppy disk controller was incorrectly setting the FD_SR0_SEEK
> (Seek End) status bit during automatic track crossing in multi-track
> read/write operations. This caused legacy operating systems like Minix 2
> to interpret successful read operations as errors, resulting in
> "Unrecoverable disk error" messages for blocks that crossed track
> boundaries.
>
> When executing multi-sector READ/WRITE commands with the MT (multi-track)
> flag set, the FDC would correctly advance to the next track when needed
> to continue the transfer. However, it was incorrectly setting the SE
> (Seek End) bit in Status Register 0 (ST0) during this automatic track
> advancement.

Hi; thanks for this patch. I'm going to prefix my review by saying
that I'm not an expert on this floppy controller, so I am going
by what I can make out from the datasheet, which is not super
clear on this.

> According to the Intel 82078 datasheet and related documentation, the
> SE bit (bit 5, value 0x20) in ST0 should only be set:
> 1. After explicit SEEK or RECALIBRATE commands
> 2. After READ/WRITE commands that perform an "implied seek" (when the
>    command specifies a different cylinder/head/sector than the current
>    position and EIS flag is not set)
>
> The SE bit should NOT be set during automatic track crossing that occurs
> as part of an ongoing multi-track data transfer. This automatic track
> advancement is part of the normal multi-track operation, not a seek.
>
> This bug prevented Minix 2 and potentially other legacy operating systems
> from booting. The OS floppy driver would detect the unexpected SE bit and
> interpret it as a read error, even though the data was transferred
> successfully. This particularly affected 1024-byte filesystem blocks that
> spanned track boundaries.
>
> Modified fdctrl_seek_to_next_sect() to remove the line that set
> FD_SR0_SEEK when advancing to the next track during multi-track
> operations. The function now:
> - In multi-track mode: advances tracks/heads as needed WITHOUT setting
>   the SE bit
> - In non-multi-track mode: stops at end of track without seeking (also
>   without setting SE bit, as no seek occurs)
>
> The SE bit is still correctly set by explicit SEEK and RECALIBRATE
> commands elsewhere in the code.
>
> Fixes: c5139bd9 (fdc: fix FD_SR0_SEEK for non-DMA transfers and multi
> sectors transfers)
> Signed-off-by: Pedro J. Ruiz <pruiz@clavium.io>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1522


> ---
>  hw/block/fdc.c         | 9 ++++++---
>  tests/qtest/fdc-test.c | 2 +-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 4585640af9..21713c9c41 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -1403,14 +1403,17 @@ static int fdctrl_seek_to_next_sect(FDCtrl *fdctrl, FDrive *cur_drv)
>              } else {
>                  new_head = 0;
>                  new_track++;
> -                fdctrl->status0 |= FD_SR0_SEEK;
> +                /* Don't set FD_SR0_SEEK for implicit track crossing during

(minor style nit: multiline comments should start with the "/*" on
a line of its own. This file is very old code so it doesn't follow
our current style on this point.)

> +                 * multi-track transfers. SEEK bit must only be set for
> +                 * explicit SEEK commands, not automatic track advancement.
> +                 */

So this is the "we are multitrack, we are on head 1 and hit
the end of the disk" case. The datasheet
https://wiki.qemu.org/images/f/f0/29047403.pdf
describes the MT bit like this:

# MT: Multi-track selector
# When set, this flag selects the multi-track operating mode.
# In this mode, the 82078 treats a complete cylinder, under head 0
# and 1, as a single track. The 82078 operates as if this expanded
# track started at the first sector under head 0 and ended at the last
# sector under head 1. With this flag set, a multitrack read or write
# operation will automatically continue to the first sector under
# head 1 when the 82078 finishes operating on the last sector under
# head 0.

That all describes the behaviour for the "at end of head 0"
case (which is in the if() block before this), and looking at
the code we already do that correctly without claiming that
it is a seek.

What it doesn't say anything about is automatically rolling
from head 1 back to head 0 when we reach the end on head 1.
For that we need to look at the info about the read and write
commands:

Table 6-6 in the datasheet has the information about what the
track (C), head (H) and sector (R) should be after a transfer.
Summarizing that and numbering the cases:

(1) regardless of MT, if we didn't hit end-of-track we just
    increment the sector count

(2) For MT=0, if we did hit end-of-track, reset sector count to 1
    and increment track count; don't change the head

(3) For MT=1, at end-of-track on head 0, leave the track count alone,
    flip to head 1, reset sector count to 1

(4) For MT=1 at end-of-track on head 1, flip to head 0, increment the
    track count, and reset sector count to 1

The current code's handling of new_sect, new_track and
new_head seems to me to follow all of that. So maybe our
problem is only that we should not set the SEEK bit in
the status register...

>                  if ((cur_drv->flags & FDISK_DBL_SIDES) == 0) {
>                      ret = 0;
>                  }

>              }
>          } else {
> -            fdctrl->status0 |= FD_SR0_SEEK;
> -            new_track++;
> +            /* Not in multi-track mode: stop at end of track and don't seek. */
> +            FLOPPY_DPRINTF("end of track, stopping transfer\n");

Here we change the MT=0 "reached end of track"
behaviour from "go to next track, call it a seek" to
"stay at the end of the track".  I think that if my
reading of the datasheet above is correct, we do still
want to increment new_track, but we don't want to set
the SEEK bit in the status register.

Incidentally I find the 'ret = 0' vs 'ret = 1' handling
in this function confusing -- we return 0 for the "hit
end of track in MT=0" case, but in the MT=1 case we
return 0 only when we hit the end of the track and the disk
is not double-sided. This seems inconsistent and perhaps
wrong -- maybe the code should always do 'ret = 0;' without
the "((cur_drv->flags & FDISK_DBL_SIDES) == 0)" check ?

>              ret = 0;
>          }
>          if (ret == 1) {
> diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
> index 1b37a8a4d2..9edfbb5a40 100644
> --- a/tests/qtest/fdc-test.c
> +++ b/tests/qtest/fdc-test.c
> @@ -519,7 +519,7 @@ static void test_read_no_dma_19(void)
>
>      outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
>      send_seek(0);
> -    ret = send_read_no_dma_command(19, 0x20);
> +    ret = send_read_no_dma_command(19, 0x00);

Why do we need to change the test case? The commit message doesn't say.

>      g_assert(ret == 0);
>  }

Could we add some test cases for the multi-track cases ?

thanks
-- PMM

