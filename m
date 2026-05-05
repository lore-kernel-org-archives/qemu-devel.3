Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16428FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 06:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK8rS-0006KO-Up; Tue, 05 May 2026 02:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK8qr-00063g-PJ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:01:50 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK8qp-0003pJ-6T
 for qemu-devel@nongnu.org; Tue, 05 May 2026 02:01:48 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so3513445a91.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777960904; x=1778565704; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wa8D4xOsgM/ItWD3mVZFZu8VyrUya/ZgmaHk2QiMr8g=;
 b=comZx68tAHv8M2pEgsfS/IQ5x6eqLLmbAsDEa25cPFN2zldp/pBx6d9mOxFmvUY+6g
 2B9r3vMI91aoGbKisHM1lB9Ndxb8T6fAUgT7PHJHvydMKev7Ih1hHv0dv3qtYVa8AQJ1
 FA1VBWseQnPUHt0hGzNZq6Z3BETvDEqIhNJs7jznTI0rWuHpzMxtu/n2iaPl5zNjxRni
 JUxqLqQy9GoRy4pKwkvThUnoLqaponP/vu4AzUuhW+ckUFnMD4TsWNOzYTNNL2/7xCHm
 14g/+9/d/mMome3o2fTOX+ni9uYYis+/u4aBoSb5ozTqWpusC/UnEpejSz+sfX8jCp9o
 TDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777960904; x=1778565704;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wa8D4xOsgM/ItWD3mVZFZu8VyrUya/ZgmaHk2QiMr8g=;
 b=QPPkufE9n5I6p9/USYVqordr4rLmJsYrbHWQNXm3rGaV5R3R3MXuuFzK9u5T7RiczZ
 r9jQVmsyjIUp+EJ+g1qUvWBXVteOE/o3YQScwwQFn54vbv5Pzxu+J+VtfbnHL3cw30bF
 jy5i1r6/k6R/6nsBdQe/kLhXE9l3cbsreiX93d2D5FU/A6A163r8DOrZBS2GkNhZg6Yy
 mqkdmHoAamZFs2t6wm/SIaheTo8jduvISZxF2a+4PrJ6P/3uuz9qMTGfJ421A98kzfwR
 vHFds3Ltekn0EEvBIhQiJ3LcaOkLQHQP5frxu8xDH4Z2UtKtDYqoDmzGPOk9VoohBljN
 pW8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XGaTeOOgqnaoAS3JiE/BansVDcGJztP+YB2R68qN4Q9ilgnVuy2dgWlv/Aaye2tK3P6SLNYwI3fHN@nongnu.org
X-Gm-Message-State: AOJu0YzoPDp3isX3tSCXPOtfT/smBIuJH9bndP+fMDaHjc7Geh12pL7C
 hVZ3aRQwJ8Pljd04fyU45lL9IAPpSpNI8qTeumpzyXEzj1VMP0Q4ayex
X-Gm-Gg: AeBDietP1XlnQnenoCcEf0y3CGTh6xq2lno7BEhx3Pbf/Pg2fCW6aPyKMbCfD1UaYyN
 qyT6IVkbwfadEBkYzT2PhAOxTpPliur2uNfLlus4DNLZQMeS2URWPXOAbWz/erHFUlMxbNRn9h6
 lKFbi+IIa9RkZ01Zg65twCHgF7tEMC6OBrU+xaqswh7katTkVG9mNMqnYFz25xrR87UezHJWkEm
 Ef18g1omTwlktL6Ql/9DEkEiHMkCf8KnIlSu5cF5viGW8NaQa5XYwNvwx4uzUC15t0CmWJ9q8aa
 zHZcxVCL4G0hRgrWo2m2OsSW0oMTxEd/7AgIaOaYnTLPlQDXgda3C9EuGmrw9DX/AKGHAd9k33a
 Gczb2IAVQyvZFTAaFb0Y/udsLJueuZaKfTVCYwlsXB12tvHWhE5vUpv6nI3OzjgSHF3dSHyN3TK
 8yKdQpOhzJTWFB9OcoEuT0r5cKze/YShn9shWHnvxvaEk=
X-Received: by 2002:a17:90b:5830:b0:354:a57c:65db with SMTP id
 98e67ed59e1d1-3650ce71f60mr13531346a91.20.1777960904556; 
 Mon, 04 May 2026 23:01:44 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf2aa41sm22104297a91.4.2026.05.04.23.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 23:01:43 -0700 (PDT)
Date: Tue, 5 May 2026 16:01:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
Message-ID: <afmHm536v_gM9FL-@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
 <aflOIW3v5FQMwfGA@lima-default>
 <CAKmqyKNUJMOuq5jujJQrSvnrvCYfxuB_jUrxFcFAQie6PosgAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNUJMOuq5jujJQrSvnrvCYfxuB_jUrxFcFAQie6PosgAg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 05, 2026 at 02:36:23PM +1000, Alistair Francis wrote:
> On Tue, May 5, 2026 at 12:00 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> > > On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index e1942a86eba5..635a380945fd 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -1760,6 +1760,17 @@ F: hw/*/*sifive*.c
> > > >  F: include/hw/*/*sifive*.h
> > > >  F: tests/functional/test_riscv64_sifive_u.py
> > > >
> > > > +Tenstorrent Machines
> > > > +M: Joel Stanley <joel@jms.id.au>
> > > > +R: Nicholas Piggin <npiggin@gmail.com>
> > > > +R: Michael Ellerman <mpe@kernel.org>
> > > > +L: qemu-riscv@nongnu.org
> > > > +S: Supported
> > > > +F: docs/system/riscv/tt_*.rst
> > > > +F: hw/riscv/tt_*.c
> > > > +F: hw/riscv/aia.[ch]
> > >
> > > AIA?
> >
> > Oh it must be because checkpatch complained about patch 5.
> >
> > It is covered by RISC-V TCG CPUs though, so no change needed to
> > MAINTAINERS for AIA AFAIKS?
> 
> If it's already covered then that should be fine. Also, if you are
> covering it, MAINTAINERS should be updated with patch 5 and not here

Agree on both counts. I think it was in the wrong patch, but also
unnecessary. I've just dropped it.

Thanks,
Nick

