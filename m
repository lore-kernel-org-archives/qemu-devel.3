Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFA7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 03:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ1tX-00025E-08; Tue, 11 Nov 2025 22:51:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ1tQ-0001uO-I5
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 22:51:37 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vJ1tO-0005Yv-SF
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 22:51:36 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b729a941e35so58188666b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 19:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762919492; x=1763524292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWmIFl2p3JmH5lLJKRpxSwj4K5BjNoadKE7MiwVKNs8=;
 b=E9tObukFdrL05cxQfdnQbW0P/8FHbinlcIgfKcdwPy22XcdarogZLzosVOcS38JfWP
 4Zw++QFcu/KA6qZJ83VOiQlI9j2UFSiVEXoEwxJlqcfnETk+3KSc3J+u5ObzU5Ci5gAD
 C27H0FA7jeTgqq0L2I3oLW/LVCXtFpogfB3M1ZnmNNTc3VQUBiFrfBd6bs8Lei0DtrIT
 s6R9fG4NGqTiE59xKefFRCcjOUoG/6w3FtPefyO0ekwQrfSGykp5njGVGLoLEvU0jE+I
 zExKL30PWsA9xpBIC7PHFWQx8olBx/0U8iJvIZiGBMt1SHtFnfraISWTbWyWOdv5d4nu
 /R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762919492; x=1763524292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qWmIFl2p3JmH5lLJKRpxSwj4K5BjNoadKE7MiwVKNs8=;
 b=NPTILkFCsMQ9V8E5qvFOHAB7I43C/sH7LEsG3UcDMXlQlOdyzXUHTC5d4VtrSzcxXp
 ZmqUAt5GDbUZa4z7+r0Ax27b9Yhf9KK8cRP1JUdtK8CcyUW45WegE+Wfihb/u5CIY3uy
 m9blouVxhWuBNhSxYNVpzOIOVliSMyn84q9Wmwd0R/aQ5Yxtq4kxAOcrTRVRWI7UZu2c
 9mEdzH2Y02u1ctBPaTaOF2ZH8IrggW+D4kjcUt+WF9hi3NbbAjRUb1Hfqzrd9HBKrUPg
 uJTiYa1xwls0Id6ErLS2VAqXJ5M26R3Qwzja9UhC4faDI8OYuXEwMoE0cEzTF1Pku7yc
 3COg==
X-Gm-Message-State: AOJu0YzLADanv+74dbXqJt4QrkyvGYadD0PaE9CDAETTWuUIi35xQtjr
 giw3Vec5IGj1lutLVBm5Cs4Qt5PLSWyCFWg0beZW9YSMPNrACiRCqGKXvMeuyNp3GEXxm394wg7
 4rdoxprkPjIvR5+DhSTn/5iAIz7NM3Jo=
X-Gm-Gg: ASbGncsBWDCHb8pVdPGmySySuQcTwL89tMPpHBtZArV/V28tXQkCbZHkpUSZfS5fnD+
 oWa3lcyuxSct4X49ND8EyGCeRu8uqEcsuBDH2EkhXi75sNwVmf5h7AsIp6pVhUimKmEfhLdBOhk
 r5kmTb8XhU+GaY24PeNoNRh8mLrFfGCOjmNFS2wvGGf0Vlwhv73X4ae76ls0XAh+3Itcvnysc5q
 57GiskIAsJPnxTcXauHq3AgfrnpRGMTkQ94vOjs8T1lsRJYRb9yaeZKkEgWqQNrqTPhxipgoYIV
 /weAj9/GGIBfg6JuD9qUXhaDhw==
X-Google-Smtp-Source: AGHT+IEPKki5sMlF5rKEC6UQU4jmuz/eE5cw2UPGz8+MrwdZzpD88tgp7MhyJFQBgokI3QtgSG7fqQcAO0QLPEBvI+s=
X-Received: by 2002:a17:907:da6:b0:b70:7d61:b8a5 with SMTP id
 a640c23a62f3a-b7331b331f7mr151240266b.62.1762919491437; Tue, 11 Nov 2025
 19:51:31 -0800 (PST)
MIME-Version: 1.0
References: <20250918061911.904-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20250918061911.904-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 13:51:05 +1000
X-Gm-Features: AWmQ_bkNNADSHjyRDUlKbor6n-ZaMPRgLnxcdJ8hTHOuxW9tgCotXsZZtWvTTe0
Message-ID: <CAKmqyKM+18jY2YZkeCtRvB=cUJK9VrRZu70DSNm2WYEaQUn63Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] target/riscv: Implement Smsdid and Smmpt extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Thu, Sep 18, 2025 at 4:20=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> This patch set introduces support for the RISC-V Smmpt (Supervisor
> Memory-tracking and Protection Table) extension. Smmpt provides a
> hardware mechanism for fine-grained memory protection, checked after
> address translation, which is particularly useful for supervisor-level
> sandboxing and security monitoring.
>
> The rfc patch set:
> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>
> rfc->v2:
>     1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>        CSR zero.
>     2. Add patch 5 to fix smrnmi ISA string order.
>     3. Fix patch 6 smmpt and smsdid ISA string order.
>     4. Make smmpt and smsdid experiment extensions.
>     5. Add review tags.
>
> LIU Zhiwei (6):
>   target/riscv: Add basic definitions and CSRs for SMMPT
>   target/riscv: Implement core SMMPT lookup logic
>   target/riscv: Integrate SMMPT checks into MMU and TLB fill
>   target/riscv: Implement SMMPT fence instructions
>   target/riscv: Fix smrnmi isa alphabetical order
>   target/riscv: Enable SMMPT extension

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c                            |   6 +-
>  target/riscv/cpu.h                            |   9 +-
>  target/riscv/cpu_bits.h                       |  27 ++
>  target/riscv/cpu_cfg_fields.h.inc             |   2 +
>  target/riscv/cpu_helper.c                     |  81 +++++-
>  target/riscv/csr.c                            |  95 ++++++
>  target/riscv/insn32.decode                    |   2 +
>  .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>  target/riscv/meson.build                      |   1 +
>  target/riscv/pmp.h                            |   3 +
>  target/riscv/riscv_smmpt.c                    | 274 ++++++++++++++++++
>  target/riscv/riscv_smmpt.h                    |  36 +++
>  12 files changed, 560 insertions(+), 6 deletions(-)
>  create mode 100644 target/riscv/riscv_smmpt.c
>  create mode 100644 target/riscv/riscv_smmpt.h
>
> --
> 2.25.1
>
>

