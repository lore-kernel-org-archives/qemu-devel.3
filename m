Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3C8CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIyrb-0006LR-Jy; Tue, 11 Nov 2025 19:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIyrV-0006JX-LY
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:37:26 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vIyrT-0003AS-Rp
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:37:25 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b64cdbb949cso58145766b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762907841; x=1763512641; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=suvugzczrCxFJUjcdNp2A2QB7aIzdPrpCEpkrukVpTw=;
 b=AZDQ5eatwPz6NR03JiR6Ohd4PKugB7AaC5bos46rBBHTS1eylslIN4bnzZnzJXS3XD
 /M7jT9Ct0chsJtbTTklJqj3YRHp8OVmyeWlWoi3h/u6i619kqlDxOKe2cj7F+In2zIpy
 pslevQAM83UO15/rLsIitzuB8OVuAVafd+s2a5QWfO2vWnQ4tZI1vBRJTf/JVJrYiO+u
 hDUUCjUTNaJQBUbE+i1ElFQUQq8cZgbspTfsqowxRuO82RIM1fMt92QSyTctQ/VYnFXb
 eb7/Sr+bwoMMRrkIorzqNj1i/jT0v/n0o67nOXV9OU7eDX4crdwEoIW846x47pczcQkU
 LCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762907841; x=1763512641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=suvugzczrCxFJUjcdNp2A2QB7aIzdPrpCEpkrukVpTw=;
 b=hjZOmJYNIpzrZ0HzsPttEICiiUGHbcBP/lQf3u8AKzZVOe4EbJ7rsaMzDokvu2fFMS
 6CSIBPEZpZie40u11pRDIm+9yFT6kLNlJH4s3Tm9PWJIeHCLXjEiOtmwgzRKpvel0tDA
 2E3y4ZCnIikLY3pyCUcj9x2TOv05sfmvpgd78/nRQtka3bf3UagcyRkbJkF1bRRkc2oM
 HCBZXPvmqYG0c2cvDoEfE+1j0sSI1ZOjT6BQenhJhronH1M+NBHqAbwsVIxOKTAvnL/9
 CUbBQLPpEnNexRO4Dl966Sv1uuWazxDDbG2/01T4hoZEiZh9TUICtLPMeyVULlL9HakK
 yh+Q==
X-Gm-Message-State: AOJu0Yw78ClFZb5OZOJldmVcf+F9CuqQmoQ7kRb2/NafIUHcoJGQTuV9
 0uRWXzXcOmb4/s7n9JC2lZAIvmBmzKMohpxrBM68cP0vqiI8GX9R/2l9XPSawswRyRe6KKPl6IL
 0fAoRdWxkbR29mIhjDZ04bw9pwNcdRY88Cw==
X-Gm-Gg: ASbGncum/XTp1nMAtbTP1AcUbQBWNJ0DFqthbOQT2wEexiL6AXI31alql6zQeKl+izx
 4zwDzNrzSMXUypf1Q/y5HW1WvaRi3R0WqYsh8MLF9N+lmz17HuSm09nTEO7E6G4nUNXgi5hxQEq
 m9i77vURHFFfMDFZ61ElLZCB/AfVIsLYF1J4TJpSiCx+km9PWB840Z+ruB96k38U+WKLmNOUJeu
 53gB12xi7/fDboOhZHbK1iqn4gQYhvrZDdqskNrnlFZWqhTMoNijPVgAUG5dBRgQDI6q7Tq3Vvq
 6wIn282rV3w5wkA=
X-Google-Smtp-Source: AGHT+IGktKgWaFc/uClqXOAva7tWGvLsI2/1p/H9GZWFSVtgseO2dCeJ555THIwsiWW8xbYS8cE9+XJsZEIZEUGMgY8=
X-Received: by 2002:a17:907:d23:b0:b73:22a9:8989 with SMTP id
 a640c23a62f3a-b7331aac300mr100308666b.34.1762907841215; Tue, 11 Nov 2025
 16:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20251103033713.904455-1-alistair.francis@wdc.com>
In-Reply-To: <20251103033713.904455-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 10:36:54 +1000
X-Gm-Features: AWmQ_bnxh-ijAoRYOPelzgZaXUZRwYYbdT7RHKk2EM5yTO0u4xeWyOzZfsWwGb4
Message-ID: <CAKmqyKP5_wLNK=jgbyx2utZZR9YyGO=TxSd68ECRRKD=yu28kQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] single-binary: Make riscv cpu.h target partially
 independent
To: qemu-devel@nongnu.org, anjo@rev.ng, philmd@linaro.org, palmer@dabbelt.com, 
 dbarboza@ventanamicro.com, atishp@rivosinc.com
Cc: liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Mon, Nov 3, 2025 at 1:37=E2=80=AFPM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> This is the first 8 patches (one of which has been removed) from Anton's
> series [1], plus an extra cleanup patch at the end.
>
> This addresses the comments I had about Anton's changes to
> riscv_pmu_ctr_get_fixed_counters_val().
>
> Besides my new patch and removing a patch the actual changes are
> limited, so I have kept all of the Reviewed-by tags.
>
> 1: https://patchew.org/QEMU/20251027181831.27016-1-anjo@rev.ng/
>
> Alistair Francis (1):
>   target/riscv: Remove upper_half from
>     riscv_pmu_ctr_get_fixed_counters_val
>
> Anton Johansson (7):
>   target/riscv: Fix size of trivial CPUArchState fields
>   target/riscv: Fix size of mhartid
>   target/riscv: Bugfix make bit 62 read-only 0 for sireg* cfg CSR read
>   target/riscv: Combine mhpmevent and mhpmeventh
>   target/riscv: Combine mcyclecfg and mcyclecfgh
>   target/riscv: Combine minstretcfg and minstretcfgh
>   target/riscv: Combine mhpmcounter and mhpmcounterh

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.h         | 106 +++++++++---------
>  target/riscv/cpu_helper.c  |   2 +-
>  target/riscv/csr.c         | 221 ++++++++++++++++---------------------
>  target/riscv/machine.c     |  99 ++++++++---------
>  target/riscv/pmu.c         | 150 ++++++-------------------
>  target/riscv/tcg/tcg-cpu.c |   2 +-
>  6 files changed, 227 insertions(+), 353 deletions(-)
>
> --
> 2.51.1
>

