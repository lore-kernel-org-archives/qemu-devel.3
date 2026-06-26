Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222BDCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 02:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcwWo-00080N-89; Thu, 25 Jun 2026 22:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcwWk-0007zZ-1O
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 22:42:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcwWi-0006kS-6x
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 22:42:45 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6976b0b2c79so448594a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 19:42:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782441763; cv=none;
 d=google.com; s=arc-20260327;
 b=NCVfOWzgSn0G2leVhPjN/W+GxFVVRD/7qpKfuXlvU+9PzKC+cRE9ewMb+U/edbbNcr
 gfl3/V6GY62gMO8soliCOxmNebj6wsjKmabFctB6b2wMGpPEG/Jxon6b9GEjW0DW3kzS
 ffgZxg0176opgQ2HEG8RMnLHN44ca+2Su1vDG8RE/b/gXKYtiVYTn8BMcN7jykxqdpKt
 tGK4b8Qnp2JomgD2hHtpuENfCVOuQStSulqdC92JKm1UNKpj+uARo9jeNdJIf1/M6svN
 chnkBvTOi+sUEQr6M6Dy5AOeQwfFvcMG4ChaB2HVcxURRIKJ7lYTeVh8YJBhQmQ23Hpa
 9h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T2a8zslxJMFNeMrLeiKpQGxtzsvDdS7R2yRapoOAFJo=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=DUPRRKy7VslFoM+5xQ0L+Rd1CMsLJHGWKnLrSB/QEXiNwNROKpf9qItvyFT9xjbP91
 fI4HGExFPhtfUMTyG+iaAqqY7BB1OhnoItpx6AFxyM/hGZfpu6kcFw8JESywDN6jcd1Q
 +MbWFKc6BG8IGoGwOCa12GuUMkuHNw5k8j8SR0KRPShUIT56hPua5WcJWA2eECRe2oyz
 nRUzUK1ReCdTOUZ1PYVSKsWHQufYfC5r8CIebOgABreFy8GvXwCm5hfyvDOuBp/2D10J
 t3u4CAFpYHcDpb3Ju7PLRW+pEiFIEp2+QYRS5V65TGxNOktwEo2rve3hgLBcb/FqFqBr
 2OqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782441763; x=1783046563; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2a8zslxJMFNeMrLeiKpQGxtzsvDdS7R2yRapoOAFJo=;
 b=b5rO8ndyQMpUNZdWQtsmOZGVBwF5vAgvrwHIurfq/Sf2yPo6CX8Pse6rP6QGNDzMvW
 Cj93dnQxoNBsnGbzNtYlBiDVZukVIPuXKPtusuJUNWrYYTgFAHlbIBwDfTAZW2vTfbnh
 IBDKfb4C39Xg2MCTYd/uObZIyhQnDoWvdztIys34b80Z9NbCzqNa0INZXBsWMiyZAONh
 NO62mM12HmqzpG31cUbUtpgbMRFxoJJL3y//afefhMCJQHnVPSYdGgWBERg/NNG+c/wQ
 slTwfgoE2H/yQR9CDZZhsG5qA+uvIDTJDDo8cQaJCGrVKm57NGBQa2oO+xpenKON2b34
 oyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782441763; x=1783046563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T2a8zslxJMFNeMrLeiKpQGxtzsvDdS7R2yRapoOAFJo=;
 b=W0yqM5CLVZAuuq9rnM4Ugb93Jr0+Lbh98PDF+GGTb/SdhSgYqjn0vezCpl+8uAqIwE
 NnViEM+5C6gqI09LhiCxeW2rHeYEReOhQnE2JygVps4jXQAbeW99jdEvaVU5OHc5OgD6
 PhsqPVIoe9L0bJGJOpxkjCrUzb+tm9WZlr8BgmH/s6xpi2cTo45PIvvKdyl0pN3PmTrI
 T75kJ/bqzhCb28GJ4tHAiRT6W2oYh0I2z7xv9qM28EVhOWUGmdOk18A0WfTShEarYo0m
 zUI4Nfo9+mrHeJZnx92oZFqzFTCM7gDzRCqaEdk7OtASvL3ZhozC2vpSSCiS8sPNBBGM
 JX7Q==
X-Gm-Message-State: AOJu0Yz5nd3SldYMelDLaCQMOi+GQw99e96vqPegKTv7axUqyWjn5G3/
 QrIqUERuxQKhKjlmKUFPvJIJIEVDD/noDVcGDasG78iH7i2kYQ9Y72y+9RN+Slvn2vJ/CznB7VJ
 oSGpMK5hb5/uwqVtqNAJJ93cnykzHCb8=
X-Gm-Gg: AfdE7clO0jZBqOA1bul62Veb1OhHLDhfqdlJAea2chbc9jCVXg7jGOf4DlUUkuqe8nW
 tgUTetOsE/dBmnOw4l0IgEsnJgQ83MRrIN/x4L6o2O6jqWVhn1brgXHJa0SaIsqEy9HbwcvAe14
 CE124ZhNXvJsaStwg4UmFXqjSS5nWHNIPQMSgeAbVqDCcuXnWKF4U6XvWUxpgRdnJJCMk0W+qVP
 TBCLHhesoFLHXQxxNHLbjTf5O3UiD7cZnQi5eFUPV/MrSzNonWv+HdteV0aZTpy44EdB6Qa+YX2
 aFWl04Iq6kXJGbAaMR2nfaEWs00=
X-Received: by 2002:a05:6402:5408:b0:697:decc:7f89 with SMTP id
 4fb4d7f45d1cf-69810a47dc5mr948463a12.10.1782441762596; Thu, 25 Jun 2026
 19:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
 <20260625210833.3294437-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260625210833.3294437-3-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 12:42:14 +1000
X-Gm-Features: AVVi8CfHEigQZqs5IlhjS-tFT9qsNUIyzG3zG3RXNRB0I0u6k2UwpNOaAWrn720
Message-ID: <CAKmqyKPk1g=Owq1mm8t0H+XXUO3Wfrg239saE99RU=ky0WNbMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Fri, Jun 26, 2026 at 7:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We do not support FCTL.BE equal to 1 hence do not allow this bit to be
> set by software.
>
> While we're at it: the riscv-iommu spec allows FCTL.GXL to be set freely
> and we do not have hardcoded restrictions on it, so make it writable.
>
> Fixes: 0c54acb824 ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3576
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 30f16b999c..c9687e01a8 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2609,9 +2609,11 @@ static void riscv_iommu_realize(DeviceState *dev, =
Error **errp)
>
>      /* Set power-on register state */
>      stq_le_p(&s->regs[RISCV_IOMMU_REG_CAP], s->cap);
> +
>      stq_le_p(&s->regs[RISCV_IOMMU_REG_FCTL], 0);
>      stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
> -             ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
> +             ~(RISCV_IOMMU_FCTL_GXL | RISCV_IOMMU_FCTL_WSI));
> +
>      stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
>          ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
>      stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
> --
> 2.43.0
>
>

