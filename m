Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCAEC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 05:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkH63-0006o2-Jh; Wed, 13 Mar 2024 01:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkH61-0006nt-6o
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:24:09 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkH5u-0000wY-Bj
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 01:24:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd81aee2b4so36243195ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710307441; x=1710912241; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LY2J4uZnvS38u85z52fqHUvPqNYN1HgO48/fDMx6Xu8=;
 b=le4Mp11G9SjFJG8p8iCoCMG+Qq/CPsTutgE/ZXIfXWt+x02uAJRjxdjQIHQ1DGZhbW
 GCizRSJlwiVeJiKcwCEnlUGoMHbyx+CnqYnTuWkhzSmx9OOF9QJHrM9sV6jYcjVGQSvX
 XuyojRfPY51nJ2snsIlbSMLyRX7ErTLlumeaEOhRyPI1l2PAP8jCnYhqGl4UUQb4FQZr
 Su/IYGoDC2okJNYmRkERp4OBoUVeZ1qA3D9QULrnjSuwY43Co6REKX78TFMpXoIFiFUI
 WlhUs9frVInEaX9r1AwwlimQPyBKGFtZ7H+fkmomUOeNVdlP1HFpFy5BkJQKmrRX1+CN
 OGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710307441; x=1710912241;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LY2J4uZnvS38u85z52fqHUvPqNYN1HgO48/fDMx6Xu8=;
 b=CPvpOG7XiKQT/i7M303P4ajwck43BUw4LThSBZ/QVb3H1rEtdWbvpxqY4xseJKRFeI
 KXZc5zwY/ToLdl44Eilw7/95GweflnmUIYvJgi2aEfXUm3Zr6fX9qtxYZmUNQ73veMOB
 sUh2Uc821qvLB1usjkCxzXQv0Fe7MTcJHDrVyE5nz4c4zpT5scTcz0/GCzZG32mO0cXt
 FYp37P33KOX5l8s62GPL4lD4Eu5F9sf3R1ZLkJvCMmCG0e4srHWMRUd6sec2hLkI/EuD
 9UY3rnUokCa5TrUoJFptD5C1jVbwVaQpfF01k45KfBKdYu1DHjptQ1tZDaVg7I0qf/Pi
 SANg==
X-Gm-Message-State: AOJu0YxM4mPmh9r/fe4VYCUpQqBtRz7jtNcaWioWmp4rj/ENVVi++xLQ
 ltmEbgFfIN+NKmUWsPHIW28iWwGPzE0lsvmGrzrWL0GHW5eiS/oW
X-Google-Smtp-Source: AGHT+IFLAcaph6umJSoo3uyuQ4nf8+cNJOUcD85YwLvZZaQOMCQ6S+ufiuhqAt+C5uC8l+OUsnqE7A==
X-Received: by 2002:a17:902:b104:b0:1dc:8eba:42c3 with SMTP id
 q4-20020a170902b10400b001dc8eba42c3mr11969319plr.23.1710307440948; 
 Tue, 12 Mar 2024 22:24:00 -0700 (PDT)
Received: from localhost ([1.146.20.17]) by smtp.gmail.com with ESMTPSA id
 ld12-20020a170902facc00b001dcfaf4db22sm7696577plb.2.2024.03.12.22.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 22:24:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 15:23:53 +1000
Message-Id: <CZSDDVZW4G3L.6CV89ZRMQK9G@wheely>
Cc: <qemu-devel@nongnu.org>, "David Hildenbrand" <david@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 0/3] system/physmem: Fix migration dirty
 bitmap coherency with TCG memory access
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Xu" <peterx@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240312201458.79532-1-philmd@linaro.org> <ZfDEmtLqviO1vMZk@x1n>
In-Reply-To: <ZfDEmtLqviO1vMZk@x1n>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed Mar 13, 2024 at 7:09 AM AEST, Peter Xu wrote:
> On Tue, Mar 12, 2024 at 09:14:55PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Respin of Nicholas patch, without introducing
> > tcg_cpu_physical_memory_dirty_bits_cleared(),
> > and split in more digestible parts.
> >=20
> > Nicholas Piggin (2):
> >   physmem: Factor cpu_physical_memory_dirty_bits_cleared() out
> >   physmem: Fix migration dirty bitmap coherency with TCG memory access
> >=20
> > Philippe Mathieu-Daud=C3=A9 (1):
> >   physmem: Expose tlb_reset_dirty_range_all()
> >=20
> >  include/exec/exec-all.h |  1 +
> >  include/exec/ram_addr.h | 12 ++++++++++++
> >  system/physmem.c        | 10 ++++------
> >  3 files changed, 17 insertions(+), 6 deletions(-)
>
> Yes agree a better split than the single patch.  Tentatively queued while
> waiting for any comments.

I've run into several other possible races / lost dirty tracking
when stressing this stuff, but this one was the easiest to hit and
most obvious and simple fix, so I think it's still good to go.

Also have a qtest test case that can reproduce this one so I'll
send that after this is merged. It's really just the migration
test case with value verification added in.

Thanks,
Nick

