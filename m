Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812BECD342C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 02:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK566-0007xT-Sd; Mon, 04 May 2026 22:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK55q-0007ty-2t
 for qemu-devel@nongnu.org; Mon, 04 May 2026 22:01:03 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK55l-0004T0-Vc
 for qemu-devel@nongnu.org; Mon, 04 May 2026 22:00:59 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b9ea536877so17384945ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 19:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777946456; x=1778551256; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NoiNadYVmI8J/NztZI1ukZWpwrODVQ4vGWgRiTK8EzY=;
 b=W897xvpNnS//Bu72SJsSOF0Kz9HZSkSlLsq2QYMfP5hmskIAorMy5yWewownaytBMW
 XwCm89+Ngd1Okp+Ea+Bn+d/eEn0eY6qwoKzismICLIK4SGu/9p4KeQ4OQsTik4vEj0Xv
 tXdgJXDzR4JhGJ9Xpjq3bqNAYuDnNkUL+YRr+HV6ETMmWGMHY2CnXBbXt3baVqXAFZ2t
 hvXz+M2sHxWYDjHDTmwqAtyhB2AonybHG9rGtkeFhwH11dfjh5MxzKp3xD0y4Di8iXmB
 wDt6LMzUkFZVTYzmo/e1OJMl01PSO955a2dFlnohtU17KTPmV0/6eHH+fVU/3uNmWWDK
 CXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777946456; x=1778551256;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NoiNadYVmI8J/NztZI1ukZWpwrODVQ4vGWgRiTK8EzY=;
 b=qqJBd4OPzursWAdls1J1bh5fl3o7zi9Z5YOn6pmvN9zABjVrGTxzEPqYSyuea/by2n
 UbzSOOxp0aw5pw3y3SrmGjyalAFwNDUEP4qyGh1XydWlQeagaEHsj9O0Ca7xrFFhjkwR
 +VlSbyLFS6TupjqIFGeWpg98Y6qa6nW9fOa7frpE29h66fV+1zdMRtZdRgUIRHfMpV85
 xAMQHAZVZd4ZSf7KAInv4dYxI6ci4mg0wrstmS2u8BmrUAhDy4PagFoGP/xSeJer7Qz2
 Km2GOqeVhMqbnLO2ZDvqHiHgb9KjJfp0zE8VnOgSVXPzzsIGH8ZmYxyLrv9Kq8V07kRx
 K59w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8/kL1HmvUE+sH6bZDgsXUbOArYbbi7b8YpYXc7Kl7HK0UAz96eqvGe8YRLXVRM3/fsC7FtzCl0YI5@nongnu.org
X-Gm-Message-State: AOJu0YxszvUw3Mrt6+YfxUaXRqirgPhzu2exaY0bD4DBfNHYah1RVjuY
 l9sKA7cyWVLbRgn3Yh2+1klbaJFWBp7bpGUQ7C911eQFIBfWZiOExQ6X
X-Gm-Gg: AeBDievDea+u8hYsNopzxDmBT2HPipL50u4d2lTBtDogOfM5RNDFt+XzhAQt3xxbSGg
 GweIbMhr9mYpYU5/bUARKAgaXMjxzaHsCOFJD9AfvWf+Wlt8GQfHdFl5YLdfcws/FV/bc885Q8+
 ak4enQR1A5Lso5CJhpvbp+tDYm/1bSqFeqUoLFqoJzzL28/KUMmru06I4xO+MZyw+XbzFvvxOZ3
 JYsOio/+oIQaTWMhP1PZME35Dc+stF4y80zs6NazfWsNV0Lq7tCwkuBJT07WRB7x6rwFMSQotTa
 RgrnzL9hxkA6Ov765suK7Qeq1bJTx/n5h2aYuaF7ra5twwxWh4pfu4DJtj5NLHAlINN0VpoY9pA
 XK0NLACHw7buJfF8ALMfAT3AV7s36/KU3oaC4pyzyjilhSBYh/aqzH8uoceSIRDnsTo7n1ujD/V
 XWFgZ4kZPXmvWuymGRdRb0hmYwPUKq4QK07egPiyg/V9V2iC2/2L/Q2Q==
X-Received: by 2002:a17:903:1acf:b0:2b2:5168:2f82 with SMTP id
 d9443c01a7336-2ba4e4d4497mr14043295ad.24.1777946456314; 
 Mon, 04 May 2026 19:00:56 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae54860sm113682305ad.72.2026.05.04.19.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 19:00:55 -0700 (PDT)
Date: Tue, 5 May 2026 12:00:51 +1000
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
Message-ID: <aflOIW3v5FQMwfGA@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e1942a86eba5..635a380945fd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1760,6 +1760,17 @@ F: hw/*/*sifive*.c
> >  F: include/hw/*/*sifive*.h
> >  F: tests/functional/test_riscv64_sifive_u.py
> >
> > +Tenstorrent Machines
> > +M: Joel Stanley <joel@jms.id.au>
> > +R: Nicholas Piggin <npiggin@gmail.com>
> > +R: Michael Ellerman <mpe@kernel.org>
> > +L: qemu-riscv@nongnu.org
> > +S: Supported
> > +F: docs/system/riscv/tt_*.rst
> > +F: hw/riscv/tt_*.c
> > +F: hw/riscv/aia.[ch]
> 
> AIA?

Oh it must be because checkpatch complained about patch 5.

It is covered by RISC-V TCG CPUs though, so no change needed to
MAINTAINERS for AIA AFAIKS?

Thanks,
Nick

