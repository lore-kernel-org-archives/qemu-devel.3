Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EBBCED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxz2D-0001rm-Ay; Mon, 07 Oct 2024 21:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxz2B-0001rX-Pd; Mon, 07 Oct 2024 21:29:07 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxz2A-0001Qu-AY; Mon, 07 Oct 2024 21:29:07 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-507904d0800so1858993e0c.2; 
 Mon, 07 Oct 2024 18:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728350945; x=1728955745; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXluBs+iVXc6KdOSe3VOOCiiod9pTBKFvC+tyqg4brc=;
 b=ih0c4mZzYSfcINIPRznAZARdNuHjVnnnaJ9VRQJHoAK7MQWNssHgYmXfMvCkx6bSG0
 MOd4hbmgqJhtBoc+nVcWR+2nnsSv+W+0EQogepdGsfLj3G1/3HZ8hOcoZjeQ+Uty5E6i
 56WDYsK4dHDLXx1kSDshfQC2wSjQTx+eloRfKsaZFJOkM+yeDU3lQR6HV+AZSbuwTlYw
 CV6CZffzwWOn9V861gKM3y8/+ZTgP1+m5bPb7QFV99PP5epH0o6ZGBmEb3LbOs215buu
 Z6anSzyzKFyWzvjbz0faWq7CgviXibW2sAqdNZrWeGSfypIxV9K5NrDwFw43kcaTYc9N
 Tycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350945; x=1728955745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXluBs+iVXc6KdOSe3VOOCiiod9pTBKFvC+tyqg4brc=;
 b=GdgPK5wj4y/TkLMwoGbOYmK86zE6TofQ+ozhpirGFE6rBJuKIoiXd3RH7AbpBH+0DK
 LIjzD4ZbPgfK1rmequCvDH4YOrhIGcdO3PfIYMbXr0TSX3+kVR9ItV60Xm+ZecXCnjNX
 MpsVaeL9C03SoKC7psZxTo4rKBXSO+7i2I9R6F53jy/JSEsvtKu7hqoBukYg3MCZkDPm
 9WHSe4iMHu9uAbxryvIaJjoyXkErEDEVzSLGpXM1F44zcpiCFPvkhsntAMLBkehc1PVd
 vdq8Dmr3gLBQzGInEwrq/HOL92xz+SheW32Ai8eSK2hEQ5XxeinzShHT29LlXGfjCW5Y
 BYHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxi3y3sz4uio8TeldJwQj69Gq+V9h9z1ImxeJO2BNLW1futC4XuWMXAeWxguZ33XgfiJW80ymllw9f@nongnu.org,
 AJvYcCVyg1x9wSfKCCROk3IJrKLSwyAcxhgCnTHxsgYHvDLE66pxB3iBNAZBpY3YSP+dP6Zq2mEj6+OWDBpZRQ==@nongnu.org
X-Gm-Message-State: AOJu0YwSuKde6aFhMf0mDLDR5J66j7ff/AkptlMJsb+V8Yq3VqUVOhY0
 WgCm5y2b69T11EQzGtiT40WjCL74/s+JPYefFKof1yEbtoZeVVq4VeL8ghECaU6gcmVNkDf1f+F
 2J9AxLJOlSGdBAhp16Dsfj0PXNY0=
X-Google-Smtp-Source: AGHT+IFyxNOKd3aF8hhf9v77gPUZPc8+MWR46KBa3HdUFy40XJlFBdbpUM/h2hz3CjeG4CGiAwgBaATaBtuMSABidE0=
X-Received: by 2002:a05:6122:1dac:b0:50a:cb38:31c7 with SMTP id
 71dfb90a1353d-50c8545b23cmr10990793e0c.3.1728350944737; Mon, 07 Oct 2024
 18:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240918140229.124329-1-s.makarov@syntacore.com>
In-Reply-To: <20240918140229.124329-1-s.makarov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 11:28:38 +1000
Message-ID: <CAKmqyKMaEiHAPGhyBJKSKrLKSYqfosD4Px=BZFCORubd28zT=g@mail.gmail.com>
Subject: Re: [PATCH 0/2] riscv: hw/intc: Fixes for standard conformance
To: Sergey Makarov <s.makarov@syntacore.com>
Cc: Alistar.Francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Thu, Sep 19, 2024 at 12:04=E2=80=AFAM Sergey Makarov <s.makarov@syntacor=
e.com> wrote:
>
> *** Patchset goal ***
>
> This patchset aims to improve standard conformance for SiFive PLIC
> implementation.
>
> *** Testing cases ***
>
> Currently there are no automated tests for these changes, but there
> are several test cases, with which these changes may be checked:
> 1. Zeroth priority register can be checked by reading it after
>    writing to it. Without patch its value would be the same which
>    is written there, but with it it would be zero;
> 2. Trigger call of `sifive_plic_irq_request` with level 0.
>    Without second patch it will clear pending bit, but with it
>    pending bit won't be cleared.
> If anyone knows how this can be turned into automated test, help
> would be appreciated.
>
> Sergey Makarov (2):
>   hw/intc: Make zeroth priority register read-only
>   hw/intc: Don't clear pending bits on IRQ lowering

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/intc/sifive_plic.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> --
> 2.34.1
>
>

