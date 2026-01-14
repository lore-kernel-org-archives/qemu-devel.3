Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBC6D31A03
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 02:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfqEQ-0002Jx-BP; Tue, 13 Jan 2026 21:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfqEK-0002J6-1O
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 21:03:28 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfqEH-0005CB-T3
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 21:03:27 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78fc0f33998so81072897b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 18:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1768356204; x=1768961004; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yZUnPwTaPkG8vF66YYrDzoqBzqKfjLEQKydW3esSTOU=;
 b=RNsqvF698pA6+BGPRzXSPCnRBHrbVpt5vmBRFZTMyyWZzLLlsHMOkovj/k2Sn6kcA8
 zAFF3YazUCIjog3Gu6WpRoLcgtUj4+WtTXvUgyISZ6AwZphiJkDvlMHnngFMkzUZsb9q
 AvuGLfZDOKDpdwyY9t2U/UPiNIRH28vESW/M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768356204; x=1768961004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yZUnPwTaPkG8vF66YYrDzoqBzqKfjLEQKydW3esSTOU=;
 b=c7EBSRzrMVSpPKuy9gL0OUgbbZjPC2dWn6bAUNNWSTA4t6uoo8WReXpUS4fEGFomBj
 6tRXql570yMA94TRlBoXuqfyqvVkALKncrthM4xSL+tXgAkr7e/aghFfdKrpfXTDqy4X
 umCyG4Mz4p1YxYxZCtQCg7yUJDF076g61IcgNEoWFZ+aXwoCJuLBoA/bpP/9ikItKsXI
 qlfNhhEKC/W9RLrIDu+3D8Ho/2PV7B/AKysRyS8whlpkS22Zi3VD1P8ZmUY1rFg+sOr2
 f6MklVrJuFUMG17HcfWbPZr2eNE4uD5vW+v2zVXgCx3VIjFqAapbTKKifWkKsIEHdXQR
 wGKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDMBopt9lh8BG2AXwsrjsObMRhEvFuFuQ3ccYaPEAtT6FSWD25YRHI+wzwRfcQFBKVSvW6Hfj3BKTh@nongnu.org
X-Gm-Message-State: AOJu0YzO/OYnVg2T1LYNNZxiNb6tTW7Wi+/WSZnlP0a/OUtBcWGbQp0f
 QUWFR+gklRyGnMGlBwjpGLBH9S1hSpjHq5o2CvnV58KK7rQnD4GimLBVoSK+yuonToFuMyMg1hE
 y/BZ/ZRj4VJeOBdsyw5hQGn/tlWQC3vo=
X-Gm-Gg: AY/fxX4ecSEyxtcXYT6RwBCQ8NJOqjO8QHz6ptJiVKZ2/iG4HAzvZsr1gMkmGghn74z
 Ln1fDXYommMudv8TGhkPo9kyoJdJdXZhnYuuWyeputmlETrRcW9dh+0UGek5CvTO8nnIZGxG4iV
 B5nXfWpIsvmi2mYtEmth6vXZUTiKWKbz+tIQBhiUYFd7c7bF8A00WodV6S4+DBD+QRsks2RXskq
 hGM2ZFWA2Yk5dtwVyZl8W4gYvLncb1Ce7L8T/95IhMGSoqCqwvdl7FXjIbFi9MQ9z3Jokg=
X-Received: by 2002:a05:690c:94:b0:78f:bc2b:83f5 with SMTP id
 00721157ae682-793a19b79c9mr20897217b3.20.1768356204383; Tue, 13 Jan 2026
 18:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20260114012846.981884-1-joel@jms.id.au>
In-Reply-To: <20260114012846.981884-1-joel@jms.id.au>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Jan 2026 12:33:13 +1030
X-Gm-Features: AZwV_QhB3ZnBd1wVzLsOXe3z3cl_1QZHcPSDEByxYyuxbNUf-E6nLbtyMJZwGvo
Message-ID: <CACPK8XcMLf_UtnMDTdD1xJnRE+-5hPamXWi9YWt5LfpPZk-T1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/riscv: Make virt AIA setup reusable
To: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

Alistair,

On Wed, 14 Jan 2026 at 11:59, Joel Stanley <joel@jms.id.au> wrote:
>
> v2: Add assert for number of irq sources

I forgot to set V2 in the subject when sending this series. My
apologies, it's been a while between patches.

Let me know if a re-send would help.

Cheers,

Joel

>
> Sharing the AIA setup code looked like a good idea when I was
> implementing a machine with AIA. It will be used by Atlantis initially.
>
> Atlantis will use 128 IRQ sources so the second patch makes that
> configurable as part of the setup. I initially changed it globally and
> that broke the virt acpi tests as the number is encoded in acpi
> blob.
>
> Joel Stanley (2):
>   hw/riscv/virt: Move AIA initialisation to helper file
>   hw/riscv/aia: Provide number of irq sources
>
>  hw/riscv/aia.h             | 59 ++++++++++++++++++++++++
>  include/hw/riscv/virt.h    | 30 +------------
>  hw/riscv/aia.c             | 92 ++++++++++++++++++++++++++++++++++++++
>  hw/riscv/virt-acpi-build.c | 27 +++++++----
>  hw/riscv/virt.c            | 87 +++++------------------------------
>  hw/riscv/meson.build       |  2 +-
>  6 files changed, 182 insertions(+), 115 deletions(-)
>  create mode 100644 hw/riscv/aia.h
>  create mode 100644 hw/riscv/aia.c
>
> --
> 2.47.3
>

