Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC531C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 11:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOxNb-0007B0-7b; Tue, 10 Jun 2025 07:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxNW-000787-1B; Tue, 10 Jun 2025 07:42:54 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOxNN-0001U2-KV; Tue, 10 Jun 2025 07:42:52 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-87ed98a23easo500590241.0; 
 Tue, 10 Jun 2025 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749555761; x=1750160561; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhYIIVZv7ePO3lqnGBfS1WXHqsZYT44EfoArc5Bwch8=;
 b=DuIALdigQmZ2KGO9JB2tt0XofuqILieYPRJwfvWLq4KxXA8uie9i5kdvauiaN2Q6P9
 VxFoLx8IseX3MeGk1uqipn9Cql3xR1zv2KQ8H59zPOUebNMGoeAbzD1QQ0A7hoHvUKZg
 XD7GPCPZmKkZ7cPf4ttfkSoirma6yAKuVjyNOtEpj8/69CaTRSW3BQw0y3V7xPhVaANS
 oK745gGresW0Lj6NQAQrcDyMPmDNPDJP7X92G0k53e+rWPSd1xlluAtxqM1y95qCTGp8
 69lImTDbQQ6Vj7lWK3p6mpXAuD4fVOGe+DKAROueMNGSp3hOydKL0c0UpPWp9WuBYEuH
 8edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749555761; x=1750160561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhYIIVZv7ePO3lqnGBfS1WXHqsZYT44EfoArc5Bwch8=;
 b=kMJhTxL7NtN+GOs3ulb06Q6vYG0SZaLk7mq5bxhTQm9EMU567/ZjLmVejcJf+aH9au
 6U4EFGhqPJW3/IisnGX7Bepzqwj3pDLn6rPPECshHqOPAJk/WGuPybqcLDcj4Y/pw1z7
 ImNzbwg/0V16dsaMQinnB1UrsCLyGyDr6e4RJ1ZtXBRZTH64McwTzmGUzE3SBFo6nIIN
 Q4YmYINbFRXCZ3XqPpzQ8f4A7whzimM2KXosHW0OR3uYuNXPJCnRGxtt4UQFxPh9z3KD
 Uw28w2o5k7iRNVpVwlANeZ0SA16U/ANi37exi5NmQNTgizBeZqLBvI7MUe/reTjxQ3mv
 eV4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ0W2tWOjB8p5vvvsrXrCQt6tGovWzxSlbDb13of53Ntxs8JcD9/2A9/yaJpsRu4gB0ZfGnlYM7rey@nongnu.org
X-Gm-Message-State: AOJu0Yyg3vZUpR2L5XVlqt0fvDObykEenTMB1Kqcj0x04rX4uqj/7heV
 04aDsoQIYapWNST7OpcP4pgdUWIGFX69bpJTaK3wSlpb/g5Px2jDU7Y8rnt3qHlQnXNAaui+2DS
 3gGfsaRT177/37Kq1BHJ2oIniSA5D3Ik7lg==
X-Gm-Gg: ASbGnctWqLn5VsEeMhk4BuL/p1jIbO9jtqRKZymb9cy4Z1Dtherf8uIQusFT9E5stVj
 E8xGgU4KMdacZ0OG4421SxRbI18Y5ui89et8nVVrO0XKZ0AxSCHNo+VQ5EkaQDFNyHsm3s4CbZj
 novC+sFSOO4M0UooxEFuhhp+/1F2GfskL9yH2onn/+wgT3jrPKHnAGQkozr6N3LU2nSwgO15ddq
 eTztNGwG9ZO
X-Google-Smtp-Source: AGHT+IHTyOJFUqm0y9KGgGmOBRAjs+dp7D9G9lYn7HJsxqallqwlrTk/vNbYcGXSUaeEWIGwZFkMIRjWmctPczndTAo=
X-Received: by 2002:a05:6102:3e93:b0:4e5:abd3:626c with SMTP id
 ada2fe7eead31-4e7728ce2f3mr12867904137.1.1749555761457; Tue, 10 Jun 2025
 04:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 21:42:15 +1000
X-Gm-Features: AX0GCFsvwaKQzx8EL_89nhNpNdaWeBN6-UeuTlYAmS-M1GNTcns9ASfcCauRLZM
Message-ID: <CAKmqyKOPahax+3EYvrsV1_+S22exmt2JmctU_wtKSJShwABBwA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] riscv: Add support for MIPS P8700 CPU
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Mon, Jun 2, 2025 at 11:14=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Several things implemented in v2:
>   - Addressing review comments
>     - Simplify `target/riscv/xmips.decode`
>   - Rebase on top of latest master
>   - Fix code format
>
> Djordje Todorovic (9):
>   hw/intc: Allow gaps in hartids for aclint and aplic
>   target/riscv: Add cpu_set_exception_base
>   target/riscv: Add MIPS P8700 CPU
>   target/riscv: Add MIPS P8700 CSRs
>   target/riscv: Add mips.ccmov instruction
>   target/riscv: Add mips.pref instruction
>   target/riscv: Add Xmipslsp instructions
>   configs/devices: Add MIPS Boston-aia board model to RISC-V
>   hw/riscv: Add a network device e1000e to the boston-aia

Thanks for the patches! There are now some review comments (sorry for
the delay), please send a v3 once they have been addressed

Alistair

>
>  configs/devices/riscv64-softmmu/default.mak |   1 +
>  hw/intc/riscv_aclint.c                      |  33 +-
>  hw/intc/riscv_aplic.c                       |  10 +-
>  hw/misc/Kconfig                             |   5 +
>  hw/misc/meson.build                         |   1 +
>  hw/misc/riscv_cmgcr.c                       | 204 ++++++++
>  hw/misc/riscv_cpc.c                         | 225 +++++++++
>  hw/pci/pci.c                                |  15 +-
>  hw/riscv/Kconfig                            |   6 +
>  hw/riscv/boston-aia.c                       | 489 ++++++++++++++++++++
>  hw/riscv/cps.c                              | 187 ++++++++
>  hw/riscv/meson.build                        |   1 +
>  include/hw/misc/riscv_cmgcr.h               |  77 +++
>  include/hw/misc/riscv_cpc.h                 |  69 +++
>  include/hw/riscv/cps.h                      |  75 +++
>  target/riscv/cpu-qom.h                      |   1 +
>  target/riscv/cpu.c                          |  28 ++
>  target/riscv/cpu.h                          |   9 +
>  target/riscv/cpu_cfg.h                      |   5 +
>  target/riscv/cpu_cfg_fields.h.inc           |   3 +
>  target/riscv/insn_trans/trans_xmips.c.inc   | 137 ++++++
>  target/riscv/meson.build                    |   2 +
>  target/riscv/mips_csr.c                     | 219 +++++++++
>  target/riscv/translate.c                    |  11 +
>  target/riscv/xmips.decode                   |  35 ++
>  25 files changed, 1837 insertions(+), 11 deletions(-)
>  create mode 100644 hw/misc/riscv_cmgcr.c
>  create mode 100644 hw/misc/riscv_cpc.c
>  create mode 100644 hw/riscv/boston-aia.c
>  create mode 100644 hw/riscv/cps.c
>  create mode 100644 include/hw/misc/riscv_cmgcr.h
>  create mode 100644 include/hw/misc/riscv_cpc.h
>  create mode 100644 include/hw/riscv/cps.h
>  create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
>  create mode 100644 target/riscv/mips_csr.c
>  create mode 100644 target/riscv/xmips.decode
>
> --
> 2.34.1
>

