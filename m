Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A4AC021BE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 02:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn7Hd-00038L-Tv; Tue, 25 Feb 2025 21:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tn7HZ-00037C-9g; Tue, 25 Feb 2025 21:36:21 -0500
Received: from mail-vs1-xe36.google.com ([2607:f8b0:4864:20::e36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tn7HX-0002tV-9J; Tue, 25 Feb 2025 21:36:21 -0500
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-4bd35d4407aso1975411137.0; 
 Tue, 25 Feb 2025 18:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740537375; x=1741142175; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQDMVifPtbDD4VK4+T2yVkMnTcQRN5bTGPPsrDRuZ1k=;
 b=HMlsTG+zumPZpPi47hLzga2sKMCcdMcRY3hmtdiGlNkTACR+LwIZwFVPUCaU7K++in
 oTviK0pFHRHM+UxcG4Shea9+wHauIrzh7UInkt75lNIZ/wCFv4fMpG/VD6uOOWDZgTPS
 r9MiG/rwR0AEogZS9xvMhL6HUnbaRhbpmG6ITEY2GriLpQnJ4Kp90a9Op4sOsrIiF3AX
 r6CZbTegXLC8c3QXHSHLW4tssvFRgjIryH3BKfkeuguVmTuASh/3iM5UNJzMy+EO4s6Q
 fV391HW/K5nOb519ZY2rld/qVERsydoQYmMvIeE7UIhviBA8zliTMBHQEx8F3T+bl0p7
 5xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740537375; x=1741142175;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQDMVifPtbDD4VK4+T2yVkMnTcQRN5bTGPPsrDRuZ1k=;
 b=Q9SynZVKQG1M99PvR75Rj1/u8Lj8pKycMUz/eB3E44DGFyp5bvpskepVcQjoymatWQ
 ZZyw3hMA0/JiJvZ6MgwxgZP0OMkWLaZz9vGby+A8OWezXJeG76r6Vjwrh4s13lUiIa7e
 pnpvJvlpAQ3aLzc0QhhxRW2CWL6eMjG3XcwkJaFaL9sUAZnKkYuL85THta62keuNOc3X
 jn+2SK3kcZPCQ65spKpSnKnRW6Om1GanilIglNnEk4vcMeOMQuSAgkEH/74PR2l3BGdg
 U9mJmTFDHJdEA1AvYE2uIMmv5eaMYjDSaAksK82kJOlIuBT4yO8nuyytDRQOYnLMY6gQ
 gaYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwx5Hk8cQfp26pJMqiUpk4efe8KQEXqy4+KB5r91Tf4ZLLHIl0X50+n23X8tEwVvBa4knlUFFXBpg5@nongnu.org
X-Gm-Message-State: AOJu0YzFZ118jczNwZKrABXKNtARzrJdkMNXRnuNbr17WNV55mOy7Wsc
 UDu0areZ81OVMfMMjQ4dsRSuIiX9CQ4GDKQXj/quOrlRaTTwe+E8lOgk/Q8L0SbR3ymLRJwv4zR
 FuKE6yC6DtjMuSj8Jhm8Q5YvV8JI=
X-Gm-Gg: ASbGncvvmdMPQjVMrVDPh5xrJ6Uzw9f/46pNbicEw97+07I3nIqtI8DGoXdMwN3vw64
 xU7VMq0bAf+J+onjkqjnji66+spYBThjL4uJUiJZhF2iqZnC82Z65wrct7RKdLlp9NqIwx+ySSr
 pk/ZNxasfymzdMhCArp5zNm242mjzOsblaj3CHDQ==
X-Google-Smtp-Source: AGHT+IGE1wDFsM2XUS+RzG2F34P80rvIB13D3fo9g/KxqUnTKcuFvbeqhxhYnKZEArgl5pjEkLSebUO9OMN4J23Fe1g=
X-Received: by 2002:a05:6102:c08:b0:4bd:3953:1b07 with SMTP id
 ada2fe7eead31-4c00acf3f36mr4090531137.3.1740537375065; Tue, 25 Feb 2025
 18:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2025 12:35:49 +1000
X-Gm-Features: AQ5f1JqFmgMkSGnv6MfZFUIv7RvncCZ0wErKBERVgGdt6mNQdoVMzJkS0t1R-Wg
Message-ID: <CAKmqyKMTgSOcB54G9hU3Se-YZXVUC=3wq9htyeGNxYiwba6U7g@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] riscv: IOMMU HPM support
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e36;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe36.google.com
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

On Tue, Feb 25, 2025 at 5:13=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this version no major changes were made. Just a rebase with
> alistair/riscv-to-apply.next and acks from Alistair.
>
> All patches acked.
>
> v1 link: https://lore.kernel.org/qemu-riscv/20241205133003.184581-1-dbarb=
oza@ventanamicro.com/
>
> Daniel Henrique Barboza (3):
>   hw/riscv/riscv-iommu.h: add missing headers
>   hw/riscv: add IOMMU HPM trace events
>   docs/specs/riscv-iommu.rst: add HPM support info
>
> Tomasz Jeznach (8):
>   hw/riscv/riscv-iommu-bits.h: HPM bits
>   hw/riscv/riscv-iommu: add riscv-iommu-hpm file
>   hw/riscv/riscv-iommu: add riscv_iommu_hpm_incr_ctr()
>   hw/riscv/riscv-iommu: instantiate hpm_timer
>   hw/riscv/riscv-iommu: add IOCOUNTINH mmio writes
>   hw/riscv/riscv-iommu: add IOHPMCYCLES mmio write
>   hw/riscv/riscv-iommu: add hpm events mmio write
>   hw/riscv/riscv-iommu.c: add RISCV_IOMMU_CAP_HPM cap

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  docs/specs/riscv-iommu.rst  |   2 +
>  hw/riscv/meson.build        |   3 +-
>  hw/riscv/riscv-iommu-bits.h |  47 +++++
>  hw/riscv/riscv-iommu-hpm.c  | 381 ++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h  |  33 ++++
>  hw/riscv/riscv-iommu.c      | 131 +++++++++++--
>  hw/riscv/riscv-iommu.h      |  27 +++
>  hw/riscv/trace-events       |   5 +
>  8 files changed, 612 insertions(+), 17 deletions(-)
>  create mode 100644 hw/riscv/riscv-iommu-hpm.c
>  create mode 100644 hw/riscv/riscv-iommu-hpm.h
>
> --
> 2.48.1
>
>

