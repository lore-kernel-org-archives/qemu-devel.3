Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E87AC55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpROA-0006wS-I2; Thu, 30 Jul 2026 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpRO3-0006vk-9H
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:05:27 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wpRO0-0002dX-PH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:05:25 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664db84f074so3038639d50.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:05:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785420322; cv=none;
 d=google.com; s=arc-20260327;
 b=E6J+J68Bz99OG0Ek2pLsPnJg2FUcytSi9b4iJPvt8d93+hhP3h4dmF16dEUxJ/R6J2
 bkiyzeJ8WGxnG2QsqWXuJYjQ1O0Y+kS8Sas3kBB3vZpPG6KTeN+D6gg64i2aXIqFcRZg
 Vhk5Xbj1yZgkZL626KN7R2wROcsVnzsJjiaGgl+d7dvGuNrVguaHJRd8Fo90fliheqkP
 aei6PxOTifwQit20GbsJE8EPKW/Ir7dnj7srhUNWOHgOV6hgl/B4juZcpHTpz6hA7Mr1
 BUjAssAb3qdG9s99lJR0Hc4Ctf8qojW+1xFo8L4RHg9aI9GTPJYiInBrJ52o515N9P2/
 LBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ztBV9fK6s30mFcelzOXD2BxiXOeYvKlD95q+mLnvIkw=;
 fh=7nyRZyXOeOEeiwhpPcvysAdQRkUz+a6MlybkzsAVOq0=;
 b=q8duumLw+m2OovUUB9kPngLBpFnSTHxRtEsfsOU6rm8F54tJ5x2YORCeK/kFufgQVE
 Popu3av5rXpUFZUahFNp5Fm84bRJqtynk5WJKxwu33QGIChMtgPJrajSZAb1p8H1HtCw
 YQEISv0iJi+ADReWJVnlm9VHF7gM8Morwx9xzogZDbMk0Ty/V+8FdVQ++YZ0oiFrf/CQ
 AcHawyppnrzTn6eNwauk16eNnQzI21FQAwAmIeBRCL+Tr11oA0JJWtbYkdgohzwwCi/H
 vD0ueSD79HzizFhmWHhMdNBi9ThHwTz5uru9vDWJ/q8xyPUtPtTi349e5nSlqfyPvxkP
 Cmsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785420322; x=1786025122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ztBV9fK6s30mFcelzOXD2BxiXOeYvKlD95q+mLnvIkw=;
 b=KotCigtzMBOZEtF33pwTwDfFPM7cg+quDrUfiX3t9xPpCv7X82Yj31X+w5dRfiEdAD
 5JMz2HHrXXnKxQ37Ire4cblze3bEo8xHU5KbzzE1hVuOJqDWeo1PYWWFNNmAJb2a7Ytk
 GikEN+25xs+YXU5UwFQtMJfRwomeZ4FCdPCM7MjZHPPFFm8bO9qwBujql6+SENuiVof5
 DbPUqmJeHdP2ktVTkK4iXbAoR/w/yC4L4zREECBDxLXuf9CDd3pqikRT6cnnUksLS5hS
 vVJ81cSMfq0PUeakdBIjdzECsDoxJJ+MA94m4wuoHVY/vVHoNnfOVViz18LETpyJihPE
 bNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785420322; x=1786025122;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ztBV9fK6s30mFcelzOXD2BxiXOeYvKlD95q+mLnvIkw=;
 b=J4J3yDwz133wm+Fbr/AT5sIsvsTWO48Svv76Ikn0KqggX/1o+oagAYIuCldx4sEPr5
 Go3Uypkk5QPUHiwT7/Ibq5K4W8dtItLUfylhHagMRXzUMZ/I4hx0rXnLdt4Rw00q3dpQ
 66D3Yf86pZrWQCHat1HQayFUbU3dtTRYnMnualSd43E9dRafzui1Y9txFd1rg273NU3z
 6YxCK7Ks9w3bX8PpRMyfNhevzqyb5aTQ+xpt1BDtLQ8LW+CrYXzaezbku5cFgjifaS2g
 LdBlPU/2ByrGow1oQZrWFJGEziiYMNTYvvS9uQ09KMXsvamAigmfPI12SFazcVdkILON
 7GeQ==
X-Gm-Message-State: AOJu0YxiSdsqNSABa05bdIdfDocCRrqhQId5dQrvMMCpPGfKUE7EOj7u
 vNnNCIZaVmUFuBagzjCUmZmTXJTdOeDUNzSkvc+saXT7A8y6VZyYBPJMVxJsLBzmGCGZ4RB/XfL
 wSUScUqb4+kmwgJoNk8PEEPd8M5wv9N4=
X-Gm-Gg: AR+sD12qFpUwAryL367oodVGMa2agUojHIo0Yp7oKZaAmBsUFMMX0HooqzUC2vcql/M
 3gWA2xAXXebr3AJup4jnKFrSV/DMAZJHk+q3la6/fE7cofgZGRQvovUVBMJSqNCR8nO/fYtSjkg
 K7BIKwJUHUUJlD0nYZ4QuCdZ/yEIb3SSsX8tBJ6+OAEYAEEs+qc3gAEJXr9zKy62v1PusJklbpz
 UI5jjUofZeYEiAJoFl4VTyqBZqUFUpEUFifbN47ZsVbZlxfNpmDUUMxRHUrSbvXVHj9m662o0rL
 o2doTQFq6rlu9UKxOYTM/6ywMr6Ecx0SCz6pSFBJzoNx
X-Received: by 2002:a05:690e:4594:10b0:667:b314:aead with SMTP id
 956f58d0204a3-6692f514451mr1319734d50.6.1785420322284; Thu, 30 Jul 2026
 07:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260730133713.3253-1-rao232328@gmail.com>
In-Reply-To: <20260730133713.3253-1-rao232328@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 30 Jul 2026 22:05:11 +0800
X-Gm-Features: AUfX_myWdQ-Bu682AP3pd0NcXhlP03Tuy9zregw4JaLAB-3Egrc_BJwsQEdScYk
Message-ID: <CAEUhbmUCna18qnDgPk2=xHVq=77T7eaLNYBMSfdmYm3MSeQWsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/timer: add k230 dwapb timer
To: raoyi <rao232328@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com, 
 caojunze424@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 30, 2026 at 9:38=E2=80=AFPM raoyi <rao232328@gmail.com> wrote:
>
> Add DesignWare APB timer peripheral for K230 machine.
> The timer uses the Clock framework for frequency input,
> preparing for future CMU integration.
>
> Changes since v1:
> - Split into 3 patches: model, board integration, tests
> - Remove goto pattern from read/write handlers
> - Fix include order, add explicit bitops.h include
> - Add QOM <private>/<public> markers in struct
> - Fix copyright headers
>
> raoyi (3):
>   hw/timer: add k230 dwapb timer model
>   hw/riscv: integrate k230 dwapb timer into k230 board
>   tests/qtest: add k230 dwapb timer test
>
>  MAINTAINERS                         |   3 +
>  hw/riscv/Kconfig                    |   1 +
>  hw/riscv/k230.c                     |  23 +-
>  hw/timer/Kconfig                    |   4 +
>  hw/timer/k230_dwapb_timer.c         | 317 ++++++++++++++++++++++++++++

This one should be modeled as a generic DesignWare APB Timer, then
optionally a K230 customized wrapper model.

>  hw/timer/meson.build                |   1 +
>  hw/timer/trace-events               |   9 +
>  include/hw/riscv/k230.h             |   8 +
>  include/hw/timer/k230_dwapb_timer.h |  72 +++++++
>  tests/qtest/k230-dwapb-timer-test.c | 227 ++++++++++++++++++++
>  tests/qtest/meson.build             |   2 +-
>  11 files changed, 663 insertions(+), 4 deletions(-)
>  create mode 100644 hw/timer/k230_dwapb_timer.c
>  create mode 100644 include/hw/timer/k230_dwapb_timer.h
>  create mode 100644 tests/qtest/k230-dwapb-timer-test.c
>
> --

Regards,
Bin

