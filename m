Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87EEE77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 03:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUduY-0002LF-6f; Sun, 05 Jan 2025 22:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUduV-0002Kh-Rk; Sun, 05 Jan 2025 22:36:11 -0500
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUduT-0006UQ-Id; Sun, 05 Jan 2025 22:36:11 -0500
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-518799f2828so7164046e0c.0; 
 Sun, 05 Jan 2025 19:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736134568; x=1736739368; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdU390pOIrzfZRFwnsuY2kG/3vZgj8A2WxHhca/Nq4Q=;
 b=JEEoBxOGgqwAni0yRKakR3e5qPMuSZA1XquJzQnehejKCi3avGDfQWCovhbihZbt+0
 qEpXmogKYzu4rUMMSgV9PlBFmdNvGphI+9EObVPLJ71NwHpDsTJdDfnGN4uFFo+eI+4W
 +5IkUDCXidhiNC4MppXZLD8yYr0ul7xJwR4lughzE1Nbt8vVEh+QowKlqedMJVi5/Jh5
 P1dDa1tPi0RBbfPdcHNrNn/gnemF+V1CTf6orgVP2GfkKpCM8+yDMzyDQ7P2PLfc1tds
 obxZdRxVSLmCnBstyl3A0kZ9m+c5M7OZEzI7oLni0u+r0acPoHlLvf0y9Nu/epSjtOCd
 kM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736134568; x=1736739368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdU390pOIrzfZRFwnsuY2kG/3vZgj8A2WxHhca/Nq4Q=;
 b=TMXHVvsHbPnYbBvKkAtuIcJrNjYVfPeBcqmdaPGomvsmP0lS03eVtdXOB3y4vS7ENf
 rCI8x5xW9rMyfBps15dF0cZX8jJpFul+YoXzxs0bu/7QEQ9XZpstGnsWLK1Mkq8JbOhG
 RoKfOla2Y52w8AtQvJ9fzIvmupmKhcjt3W2gvZIHjftHJn5z2RzO9E23k5Wlvbklt48x
 Dyr5UC4mxsfnQOIRhn+erKTV/vXXISh8ax9wOcW6Vz2XL0bFk8XkN37hM/I9YdCgWc3Y
 X3PMNClNyrOvWrz7h36Kaz4RCopOCvxzQrQhztGYNCojuh0qOi3ZyL77Ii/2sF1As5IV
 GSig==
X-Forwarded-Encrypted: i=1;
 AJvYcCURCe4BRiCBZzcU4bW+AvVbfus5j2ZznUcKWi4bhKvzjtoenIf9WjdjbgBfo/jzi+F/GwkCZzc+1+3S@nongnu.org,
 AJvYcCXqRpH3GhazfTBHLKRP/0HTNDdDBTb1OEExk27GOpEK4laVTq6XOBb+MC6P28LaDb+avpFUO3is7W19SA==@nongnu.org
X-Gm-Message-State: AOJu0Yzb8C8o8i0pfrlgdYoDdimkbY2iM1oDG+uowTQXonS07geHb2k7
 QIlKBnff32iZOp2Ptemf3wzWZ4drUN/Qp7WAY4JEPVtOEl/0iiVElVvc2YcbuklTWfGAbkeeRSE
 ztLW59fu3g66A1R9haO2VkYZGfuo=
X-Gm-Gg: ASbGnctlGjixmDzhCXCtv81+6qXEgCkCcqKgCVqrCYANRxtkdDMmsj0QPFs+HcWubtO
 KatunI8+GD7/Px/LXlSmjLFUL8aOKR6E+hLAsYvidh/JnGW9haNeD/9sg5MRmxH7+oao=
X-Google-Smtp-Source: AGHT+IFSgpwx6Wc0ENTD/Z+RTPdT/t07qm2ukTeZjr6Ll+2At9bWP+2P4TZIFi9aMhTgCWDB0VuyThXmJgFg/+0gPRQ=
X-Received: by 2002:ac5:c3c3:0:b0:515:20e6:7861 with SMTP id
 71dfb90a1353d-51b64ab5d68mr35072411e0c.2.1736134568018; Sun, 05 Jan 2025
 19:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
In-Reply-To: <20241217085709.679823-1-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 13:35:42 +1000
Message-ID: <CAKmqyKM8F0ziHKCX9ZeQdqugGM=gesBHiX9sUCwoxVT2ZfMvVA@mail.gmail.com>
Subject: Re: [PATCH v14 0/7] Pointer Masking update for Zjpm v1.0
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com, 
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu, 
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Dec 17, 2024 at 6:57=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Hi,
>
> Rebased and addressed Alistair's comments on code style.
>
> Thanks
>
> [v13]:
> Rebased and addressed Daniel's comments about the return type of the help=
er.
>
> Thanks
>
> [v12]:
> Rebased and addressed Richard's comments about proper masking virtualized=
 accesses.
>
> Thanks
>
> [v11]:
> As suggested on the mailing list by Daniel, I'm resubmitting this series =
and keeping the original versioning number.
> So that makes this one v11 and previous - v10.
> Also I applied previously issues reviewed-by tags on some of the patches =
that were present in v9 series, but only for the code, that didn't change m=
uch.
> For the others I'd really like to have them reviewed as there were a lot =
of comments on v9 series.
> Also rebased on the current upstream.
>
> Thanks
>
> [v10]:
> I've rebased this patch series and addressed Richard's and Daniel's comme=
nts.
> Thanks
>
> [v0]:
> As Pointer Masking is finally ratified, these patches intend to update th=
e existing code to the final version.
> These patches have been submitted previously and I tried to address all t=
he suggestions, but I'd suggest to review them from the clean slate and the=
n finally push them to the repo.
> Thanks.
>
> Alexey Baturo (7):
>   target/riscv: Remove obsolete pointer masking extension code.
>   target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
>     of Zjpm v1.0
>   target/riscv: Add helper functions to calculate current number of
>     masked bits for pointer masking
>   target/riscv: Add pointer masking tb flags
>   target/riscv: Update address modify functions to take into account
>     pointer masking
>   target/riscv: Apply pointer masking for virtualized memory accesses
>   target/riscv: Enable updates for pointer masking variables and thus
>     enable pointer masking extension

This is all reviewed, but doesn't apply to
https://github.com/alistair23/qemu/tree/riscv-to-apply.next
unfortunatley. Do you mind rebasing and hopefully this should then be
merged :)

Alistair

>
>  target/riscv/cpu.c           |  19 +-
>  target/riscv/cpu.h           |  50 ++---
>  target/riscv/cpu_bits.h      |  91 +--------
>  target/riscv/cpu_cfg.h       |   3 +
>  target/riscv/cpu_helper.c    | 128 +++++++++----
>  target/riscv/csr.c           | 357 +++--------------------------------
>  target/riscv/internals.h     |  54 ++++++
>  target/riscv/machine.c       |  17 +-
>  target/riscv/op_helper.c     |  16 +-
>  target/riscv/pmp.c           |  14 +-
>  target/riscv/pmp.h           |   1 +
>  target/riscv/tcg/tcg-cpu.c   |   5 +-
>  target/riscv/translate.c     |  47 ++---
>  target/riscv/vector_helper.c |   5 -
>  14 files changed, 257 insertions(+), 550 deletions(-)
>
> --
> 2.39.5
>

