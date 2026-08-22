Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E0FC5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 11:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxk9q-0002NG-PB; Sat, 22 Aug 2026 07:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wxk9p-0002MF-4g
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 07:45:05 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wxk9n-0001Le-Ju
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 07:45:04 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7dbcb505578so23545387b3.3
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 04:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787399102; cv=none;
 d=google.com; s=arc-20260327;
 b=qfdNj7xDsdZiDkYCqFZkBqJqHQa1fWTPrqo6+wlAJwz+kdoq6NgK/LGtvbBQwlApY7
 uPshZcBzF2xYb06zCkNwLP2nveAW/UcLYnOn+fJW9CmvvtyJ/a+2go0bu8G6VvndFVC9
 /4ZRbfG6nrOH6aPXzktQ8F+hUg0O4SJlxGzmXwYeO0+kjpG0Dny01+IoeUXc7XKVgkCN
 hpJIHm3LEsxh1bl93qSoNFh0OaRkCRjOYu/rf8coxy1RSQ/0Um9v1Apc4debTajmLSRz
 6rVTx+z/OwqkE9NbrMq3kounThdF1MngiG3mkx2e4W3QIeGqaRLXJh10JUJhd5ZniEcV
 OIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jBzV9P1UTdI1U0NWqEwCZMjn3FmzBkuEn/EfV7c0WCI=;
 fh=weeZ+I/k7h7EVcDy63vo1ai172Vh7g4N1CNTsRAlT80=;
 b=eijQQ6knFeqjaOlyroKfM6jpguh8POfEnah5KHMOwhmbz9nBwESwN+kIUssRLLYOzf
 d2y9ea/8oE2qBkImzVzDE54gKGuxlgcP6cuusCTmnPZ57/ndiGZ7L4EHBwqQ6QQbGhKY
 dGNdW0eOTcf/jPaDZGZhdEkr851liDEnne876112RmBingyaj1nMNSX+p8GAYC6MPxus
 kABCUfWOC2lJO65OudNr+ORwl0tiMboPlSzIASS8ZqOLgs2M6N/MjjUCmVjI9MYuf4H0
 R33h9Bsk1m2jwNk4Z/88ZBQ8DuS4vB6aB3Dx87g52yROQLb5rbfVzQYrTrr5Q939n8YU
 U7Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787399102; x=1788003902; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jBzV9P1UTdI1U0NWqEwCZMjn3FmzBkuEn/EfV7c0WCI=;
 b=o7KUGc+rRgsQkk2kPhlY7tH7VAL2DnxPZm9N9ueuBamv4ENUEpuPXE+L0hBAbWAtw8
 Fof+P6WeUo7f6jeYNsa/3D6hYMMJv2wi0Ig1EkP50eKDqA13e79XT+J8aH24fb98JBxZ
 gSsufL1FjLD7mHuG+5oi5aI8fLrq24Hqbg2WY+4F5rWQaVbLB4o/at/rVxEPE3at5B3Z
 w8vOm4H0rxd4duVFwyBwTuCs3w5KXNFKPiLWrm1yhrM9/GceT/qWyqq4XzSQiYpeR7YD
 eFYG1p14eAtETreRfSgRKhSYhJoLj6yZY5BX7O4w2EySCCwYUJkY5Mw25DJ4U/uI0XTA
 EJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787399102; x=1788003902;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jBzV9P1UTdI1U0NWqEwCZMjn3FmzBkuEn/EfV7c0WCI=;
 b=rviS3cOSWqv4vw5ePVz84GIF2hnCTUuLksCfLMw2zeZa6lU1jGV2JiadZUwFoPfwSh
 /4Fh+vVNQpKKY9hvJ3ldxEErEHRebSfF1rDmvJAvdS69Ihk8D/7l3QFfv7h2xb/j6CEs
 pW9MwT7kQ7QTD33ntxJMAJ/QHVH4+VKL4DF7CNH5GIwe/aLnIhFx6/4tHlY9Fs7z8phf
 akqaz0utQz4yaOMavx35zlBFYuHmMiKs3h998AVUymJTKuu/Q7Vw1s8ruI5YkngIDZ5Y
 sDWYY7IN3uig3TU5yWU/ONXdkYxHkksSv97tiV1WWZo5fR6/UdvXvFvyEj5Jc+m5uCl4
 2mQg==
X-Gm-Message-State: AFuF++m63Wkc1Mitcc2zr9Kat7BXiwxdw6JfQsVVmRLorPuJlWX5UMso
 YSwY3j8Ht2BpBUvsUbaF6oOaTXcAicdiESyxkuBHbUgW1IVEf3BrDyxfWTWtbb5bCgub7INcJPE
 3vF7tToCYpyC8EKej6CBfeFRS2o8XGyQ=
X-Gm-Gg: AR+sD10fB9gNrw2m5T+MEOmY9DDYdokPlKcrEcRCpLmbf7qaO1Pk5Js17X6J1FVOr/+
 8CSGf4zDK1jGLnuJf87rtpbk5iVZvm5NenHiMBBF4PgeJkRSybbx+DtJbCWuq8UzkzJ7EX3HUQ5
 VbGwM2m4B0hjgXavJqyBxJWR3GZj8Dfr5ByaX/YN5SKT/hnzehkxqBpIQ/wF4L6u1FqBXBqKiFP
 3jWLs1/SpW3BnCBHG8pPzgJZpIObf5DlwzeD7+UQzNQg/TL+WeSSmkYKxUxpq1/BsoRF1YF5hpn
 SoXYhhvTz2ij5Fy+uRqwXGZqxT6a8gjH1R3Q1vg3uWgboQPn/shd
X-Received: by 2002:a05:690e:4183:b0:667:a0f5:345d with SMTP id
 956f58d0204a3-66ce4a0fe73mr4585323d50.10.1787399102210; Sat, 22 Aug 2026
 04:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260627154225.863984-1-bin.meng@processmission.com>
 <20260627154225.863984-2-bin.meng@processmission.com>
 <CAEUhbmXe=aJ+K8isdCpdFn9Y4LLTf9SARY7VaZoMo39SeYJAcQ@mail.gmail.com>
 <CAEUhbmXchynHnz1Zrh=WZC4RrmamRGcUm7uGda45kUUVSrzBjA@mail.gmail.com>
In-Reply-To: <CAEUhbmXchynHnz1Zrh=WZC4RrmamRGcUm7uGda45kUUVSrzBjA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sat, 22 Aug 2026 19:44:49 +0800
X-Gm-Features: AcwNN1V0yO3IigO7wJUoT3YAbZ9Pf7lTTKlu6pI-qFkIiTsq8U8G27df-gx5uGg
Message-ID: <CAEUhbmWrx=hJb++2KVn2kqJdKd_gDYpEygDNMri5T8cmvNkAMw@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm: xlnx-zcu102: Fix up DTB for direct Linux boot
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jul 30, 2026 at 9:51=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wrote=
:
>
> On Wed, Jul 8, 2026 at 11:50=E2=80=AFPM Bin Meng <bmeng.cn@gmail.com> wro=
te:
> >
> > On Sat, Jun 27, 2026 at 11:44=E2=80=AFPM Bin Meng <bin.meng@processmiss=
ion.com> wrote:
> > >
> > > Real-board ZCU102 DTBs describe the UART, SDHCI and GQSPI nodes
> > > in terms of ZynqMP PM firmware providers for clocks, resets, power
> > > domains and pin control. QEMU does not model those runtime firmware
> > > providers, so using such a DTB with -kernel currently requires users
> > > to edit the DTB before Linux can probe the boot-critical devices.
> > >
> > > Add a board DTB fix-up for direct kernel boot that removes those
> > > provider-only properties from the boot-critical nodes and rewrites
> > > their clocks to fixed reference clocks already present in the DTB.
> > > This keeps the user command line using the Buildroot-generated DTB
> > > while limiting the compatibility adjustment to devices modeled by
> > > QEMU.
> > >
> > > Document the direct boot flow, the SD and QSPI image layout details,
> > > and the remaining firmware and real-board peripheral limitations.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > >
> > > ---
> > >
> > >  docs/system/arm/xlnx-zcu102.rst | 139 ++++++++++++++++++++++++++++++=
+-
> > >  hw/arm/xlnx-zcu102.c            | 109 +++++++++++++++++++++++++
> > >  2 files changed, 247 insertions(+), 1 deletion(-)
> > >
> >
> > Ping?
>
> Ping for review?

Ping?

