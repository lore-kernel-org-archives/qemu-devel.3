Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7B9C36010
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 02:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LeJ-0005yp-AP; Tue, 08 Apr 2025 22:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LeH-0005yI-5a
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:58:45 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u2LeF-0001pN-Nd
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:58:44 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e60cfef9cfso10197413a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744167521; x=1744772321; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXjFx/jGcuIqmVfO7+/DDD5NXktS/IknziofVwmHkC8=;
 b=fU9d7m5oJmBnJOomKnIivzJANIQIa+8CkB3BiESvVwCMw1Y/sKs+2/VobXKhn3gJJN
 qSJxHsyC7N6rr17qQ23c2Ml0pWam1BgA3TnNA6QaEuZdTgk6lxhfqk2Cq/kQ0T/OS6BP
 W5sLL40xu8IV3Se6JyB2LnKrZce76RT2q1W5K4J2NrZA69xbuJvKPL2A81y8xAjys41g
 U87p+v5k/uXY5KmYbmDfFDeN1FqIVz+1u358PA4yX5i3thpTLLtJrHO48nxXyxaUtqMb
 gk9jQqrKX9ePedsUE1Ql6u7HBFZCY+czuJAO/RIQ0/4Cmzsmi8/9TRD+uSEW5VLDzobK
 UbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744167521; x=1744772321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXjFx/jGcuIqmVfO7+/DDD5NXktS/IknziofVwmHkC8=;
 b=JM9mmT0r4r9FBX9TTsGYjXQEmmec1kF8pKPR6AKSV8e0nQuZCgBplW/Jwc3vlbYSaD
 Dhj7swEAnantXIVE8Fav6QbrqBJZlEV6Ii2GC5mu9JVIUTtGvFZKf57a8exjKFeCPj+p
 QDbThPrcfiD6ByCGYdvtBDL6rRK8Le2XEW8/EExr5ZncSYwou9wsYePJHyCMhR+GniCX
 rzC9VZqD0DaMHLBdhibgLddFLT3NTfnOx430vX62S+s7B4O4wIrHKOAHhFQFbyPv/iUn
 BYDdp4lg0uORUWiDuoDKaqpNVO0zVUsZibvPXt+jyo6VbDTIg2K1NE8qHrzo7OA/3AQG
 D4Iw==
X-Gm-Message-State: AOJu0Yznsnu2LHiVr1ZOmJ+WfN+9VPhX901CbGmXzhVXCm/ILBnUcmPm
 DfbtkFXYcjz3BePLnqXX6HvrhbnFrQu5H7u1k8MeohGQfwFo8x0Y9hdvtb9XDuFa3keKNJj+qYe
 q8v/tZN85O5gkxcnioOSpWYC+JQ5PqjiTgGbJSL5G2AIbAE3YhnQ=
X-Gm-Gg: ASbGncu3ibLp7wkuK+Z6PjAgBZKQdwAX5H0WA7qlFKVMeOKC6ZVxkG/BT9icIw+d5D9
 H1D4GOrSYqGk70nzcH2TAOVhtziDBPU6dmXkVmQHNGa5W4gkPJs4efmInTplXR+SI0ORsJaZxeS
 NP8SgGtfNf4dmHgTGunf9HIP4FkgFm
X-Google-Smtp-Source: AGHT+IEtIk2AMfD71jHRzZfoi0YgCSgwKLKFFbyLd8cvtGpWuC6AzeyBhDDOYUPltnnPsWY3ho/OKcIFgcn+MjWiWIo=
X-Received: by 2002:a05:6402:4302:b0:5ee:486:9d4a with SMTP id
 4fb4d7f45d1cf-5f2f7756b63mr901996a12.33.1744167521151; Tue, 08 Apr 2025
 19:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250409025131.3670-1-jim.shu@sifive.com>
In-Reply-To: <20250409025131.3670-1-jim.shu@sifive.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 9 Apr 2025 10:58:30 +0800
X-Gm-Features: ATxdqUG6I0pH5Io3RP40psf69oAad_MgP-mqgxYNp2_6iNnEcqtv3dJ7eJICixw
Message-ID: <CALw707qbE1wRhPkWw3dXWj0gvtvzqhUH73m98LpfFPFgVhkaGw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Several sstc extension fixes
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=jim.shu@sifive.com; helo=mail-ed1-x52f.google.com
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

Sorry, I forgot to write v2 changes in cover-letter.

Changes in v2:
- Remove duplicated code in riscv_timer_stce_changed() function
- Add sstc spec description in the commit log


On Wed, Apr 9, 2025 at 10:51=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote:
>
> This patch series contains several sstc fixes:
>
> (1) Writing to ACLINT mtime should also update the period of S/VS-mode
>     timer, just like M-mode timer.
> (2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
> (3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
>     which should update the timer and IRQ pending bits.
>
>
> Jim Shu (4):
>   target/riscv: Add the checking into stimecmp write function.
>   hw/intc: riscv_aclint: Fix mtime write for sstc extension
>   target/riscv: Fix VSTIP bit in sstc extension.
>   target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed
>
>  hw/intc/riscv_aclint.c     |  5 +++
>  target/riscv/csr.c         | 53 ++++++++++++++++++++++++++++++-
>  target/riscv/time_helper.c | 65 ++++++++++++++++++++++++++++++++++++--
>  target/riscv/time_helper.h |  1 +
>  4 files changed, 121 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>

