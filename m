Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2403AE77188
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 01:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUyWH-0000Sv-Hc; Mon, 06 Jan 2025 20:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyWF-0000Se-Ei; Mon, 06 Jan 2025 20:36:31 -0500
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUyWB-00034y-U0; Mon, 06 Jan 2025 20:36:31 -0500
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4afe4f1ce18so4311291137.3; 
 Mon, 06 Jan 2025 17:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736213786; x=1736818586; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+ZPa83ZpImKYA3B3hvSsn3nkX5F7jHRADyyCiCDSYw=;
 b=lmcWs8wa2aslxnFydr2qG9CU/qSuglXbO9JB5gVaNlgQbfI+2n8TSo8+FNrxeZwoiC
 hwSz7PO7zrdfPUZc8SdcxitPyBjhEmoLAr5teiodq/rGy5SqfxUoOs0smvvmIKWCjJDa
 eFX3sReHLh79aCzxdeX97DQUN4h9thUvsvW6fWN9r8oExOVCpxBWbDgIHqgsx9Hmch8v
 //N+3F3BPO2Izqq/j1Y+a5AULIyE2CW8LBijbHknkfJUPlS+tS45Uae2yrHktETHZf5s
 EloOTIqlCRbXg/Uyb+UwijcM/fYU5rtf3IUpjqCb4SBO3jWKfRf4DIP/puxTErV7q3RA
 q91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736213786; x=1736818586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+ZPa83ZpImKYA3B3hvSsn3nkX5F7jHRADyyCiCDSYw=;
 b=k0RvWyoZeJRNc+2GyjJ2/TedLHaicsGQ2yf8aDuxS2W0dpwEcrLsDeALUG5kLhMOwD
 PoF3q1Jrfzr+v1Eb1GLZSpfWi+BtWgxE9AfRDAWYWMQhStOgVENfeD+HES+Ul5iF0B3H
 2IDumtEPZnfiydEwqF8q0mlb8zHnf7wzvjjv6ghdTocLg2UskY5847xQ2HIvqo8dU2Lz
 ua+D7zjBgXIdnH1N+Fihnb3AUOK0A2IW9t+yDFvjnd4NVVFYnlQPegHszgA9oV6Jab71
 ZQdKykSlp7KIVagSHO/4peaezM/ND3ZoQBCAn667OL1REtXY5ArzdnYhl4Ew+/MTV2Ww
 BGVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBeLPOwvzo8v1vE0DV4aQG1UavIArJmEGG7cz1Ef98nDUCzMrKh844pZs9ndVfoRUGqO02vit/TfCVhg==@nongnu.org,
 AJvYcCXA7odufXXeY+uYxidMjYDvA09uWImDZpraKEoHazx22w26UjzhoAzOAvQJC1lcYxaf8ukwNoxBhgR8@nongnu.org
X-Gm-Message-State: AOJu0YwY877Udz7m86Rk3Kyr0KLDWelrLiSfNoG8snff+/uqTNLtzjKR
 uMosJ7MA6horisJ8b/8pJJyi6fn8ORebHsRzilwrLf+s4wrYA2gy1sbqgvhZH5BUXKGHx2kS+PL
 4Mg1wdAEK6MIM8BkICKxfx7qhbzc=
X-Gm-Gg: ASbGncvNTMxwnScE3wAVZuLfQWjUgmNZwCIh4QKzbU5z+zwBriLYZJoDtE42Qo8yAGG
 IQ2hf/zn44I5Bjq/hDixDh5V8vXLr7PLsswkj7L8=
X-Google-Smtp-Source: AGHT+IHkmGU+imwdSzRyh5iHMswDjWc6HRsu5b4MBpNV9a6KGfRjSxG40GttIohYnLmuw+uknnlyfWwzIOMWXnBmmJ4=
X-Received: by 2002:a05:6102:6cf:b0:4b1:16f8:efc4 with SMTP id
 ada2fe7eead31-4b2cc36a2f3mr52253648137.12.1736213785978; Mon, 06 Jan 2025
 17:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20250106102346.1100149-1-baturo.alexey@gmail.com>
In-Reply-To: <20250106102346.1100149-1-baturo.alexey@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Jan 2025 11:36:00 +1000
X-Gm-Features: AbW1kvYVkSMjBFN8ippSYjOj0K2FyFVhIlJ9q9-No0NysMM6Z0lO62D8TXuxjhg
Message-ID: <CAKmqyKOeLJk=No+2fxAEsGaMic2bT92zpgAMd_6LNhhUnTDvtA@mail.gmail.com>
Subject: Re: [PATCH v15 0/7] Pointer Masking update for Zjpm v1.0
To: baturo.alexey@gmail.com
Cc: richard.henderson@linaro.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, 
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Mon, Jan 6, 2025 at 8:25=E2=80=AFPM <baturo.alexey@gmail.com> wrote:
>
> From: Alexey Baturo <baturo.alexey@gmail.com>
>
> Hi,
>
> Rebased against Alistair's riscv-to-apply.next
>
> Thanks
>
> [v14]:
> Rebased and addressed Alistair's comments on code style.
>
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

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c           |  19 +-
>  target/riscv/cpu.h           |  50 ++---
>  target/riscv/cpu_bits.h      |  91 +--------
>  target/riscv/cpu_cfg.h       |   3 +
>  target/riscv/cpu_helper.c    | 128 +++++++++----
>  target/riscv/csr.c           | 359 +++--------------------------------
>  target/riscv/internals.h     |  54 ++++++
>  target/riscv/machine.c       |  17 +-
>  target/riscv/op_helper.c     |  16 +-
>  target/riscv/pmp.c           |  14 +-
>  target/riscv/pmp.h           |   1 +
>  target/riscv/tcg/tcg-cpu.c   |   5 +-
>  target/riscv/translate.c     |  47 ++---
>  target/riscv/vector_helper.c |   5 -
>  14 files changed, 258 insertions(+), 551 deletions(-)
>
> --
> 2.39.5
>
>

