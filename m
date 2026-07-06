Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9142C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 02:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgZNL-0004CD-Lr; Sun, 05 Jul 2026 22:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZNK-0004Bl-7y
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:48:02 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgZNI-0000oz-Eo
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 22:48:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so4623199a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 19:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783306078; cv=none;
 d=google.com; s=arc-20260327;
 b=jsw8ggQ7rzNmPzfBUGEcywcHmZ8QUC5JwpbqRN/M2ECGEqZiIrzkdmMDHTlKh7dgE7
 SjpVWfGwMRrY4z3bQpR++MmahpQh/SJdHmiw/ZZzrfAK6S6rqp0+bdvtRlZ/kWnVG18x
 rFYEK6nd8kYO60j4Cfrdgu1edyeuTZb4oMBWvno0TPzIZ+RrEnAcrUUVAWbqX39lQ1Gg
 eE9OSz8J41vC/HSUDh7+Tz6bOcjnJtJJfQIOTxCUoMY++rWrgajbhxeK0CE2xoBPD0VY
 37A5JFMbOIgZAIHsXBT2Qs2uYthydXck/wYOUN0Q+fq2iBp/2YaDbqBgd8QhyGEqhNEy
 aSUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w5/0NXa9HSugiv6hw4tHhtMykE/NIFThL0bmySBOzx4=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=ZB7OK+pnL9eqb6E58mJ7cEkU/TWjOpvPOhWQHSDeLBcshiFx+cZ3HrJ6xIkdk0tvT9
 RLuknSvqcj0rArDT2ZOKWwTZUKQfYkLRuBLRL9EvtOBufUaoIDqOL4ScS7xBR6s05vaX
 wc3+QGXiZCmHWzachMn9iW7wB+9FuLOfR5FLyW6xJ//dl03KUxppghI7l1N7jUjietNc
 H6vZCU94f98e7UIZ92T1pjd4bVlsq5rSx97UpVUbF/Ua+O6WwXhS5CES1BcSvPUqom1l
 THS44yS79fdq6YcMoC4HM88oygyh8acBlqXJLFJK4MJLiUWnaG1PhtiKwuAsvllgzw0o
 5xug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783306078; x=1783910878; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5/0NXa9HSugiv6hw4tHhtMykE/NIFThL0bmySBOzx4=;
 b=L/5kxqQjSBGhkaVbQ50tES3Oeq9kbew2eJV/9boABiN0FzR02vd0JyETU1kTgs5KsV
 4MbTCDBKjL0NSZCtT3RmdnzeBVAsUr47lX08CeAgV2mGuqbUL65opp8B57I05WJJIzkK
 UXw4UpPVO8NmWxJFGAMJ5S0/BqQmic7R81O4PjHNfkZbDG/uFlMC1yMhrZXU2VWOPqgI
 Ew+0hiboXBID7zVVyEU06B2Rrz3cWSGzXZZbh1zrbbKILL1Dp6HXP38cJAdINrHKv3hM
 b4MhzLFcWKBdWMdP+i6nbDkPKRRtKw1HFrc7uV1kM4K1orKQRihSuf7G7PlrK2TM50qF
 td6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783306078; x=1783910878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5/0NXa9HSugiv6hw4tHhtMykE/NIFThL0bmySBOzx4=;
 b=UjYJkMLpm0aRdsIaQf467W5ePmEs1UuFIMb8kvjC3Va19DBrh+ufrLEDj9m7douBWS
 IY6i+XXVquSkdoeV7n/7s43LmIpwzaV5t7TYPu4T4+GHl3BgC3kNJPHWA4xdebThDZZk
 xcEUN7fomdwuRpvHsxqsWs5zSS4dh60C9TybBqUwWmDdGyuU9T/kkYvoqPk12fhZFXJ7
 VXogIxKVR++w3MFwr7vd7gRo7fkpqpU6Rbe4uzQ4X7tDvid9Hh4Gzqzd79yAkfQKBlyG
 sW1PCKhP39Wfs1GO1h6YMLf2PzRg1Th73JkKC0p3suDK6cX8sZr2RXT07JI8MD383rE9
 0syg==
X-Gm-Message-State: AOJu0YxNqIEkUX9JJ9IYkCjoweNhLLLiZUAwayLkJM7ow5JD6ysUq4O1
 MFkBR5P8j3Z3RH25qUxRo43p2+9n/w4e70viOD7cTaCy21yCAvbpmUe9vvV3YiKAbtfAPVrGBDp
 bSGUBsQT71AjQ6EvdMY67B5NwPA9IsHU=
X-Gm-Gg: AfdE7ckOjb1Fzl7TQkhGWkQWi4m53BCAbnkN6MHlrIBmcM0jyH3e3PskpkY9nVcbPvz
 mYoEzc5pnS5TjGJMazyIIBN6ifkcvj0THo86BY3yTel6RJ58LXVVgyC550Yd3aW+w/M3R7cuVX7
 /i+50g9CUGec2RuVe0Jj9Dn2FzsKZoAByRZlPpgpS7e6cB2ndnF+a8MBTGmlGOUnmGPfke4Vhx8
 ksA4JeETxelj7f7aXsMFmHGu4+ly45brb71pJIsw+mOe8/x9V63GIK5m1JDNQehcvsgTLvidQaY
 x7Xuqw+nVEmmLhCsB43YoGWLURh9y7M6YeHBnA==
X-Received: by 2002:a05:6402:5418:b0:695:dcb2:7438 with SMTP id
 4fb4d7f45d1cf-69a1a3ad324mr2746611a12.28.1783306078115; Sun, 05 Jul 2026
 19:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260702171202.1322493-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260702171202.1322493-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 12:47:31 +1000
X-Gm-Features: AVVi8CeSQD-wtHPdO_Xaz7mlBZizzXcrD5iLwX8J7x7_xvAf5NhymDwj6IuEzqQ
Message-ID: <CAKmqyKNQ4k90C9viNJaArX7GgMhHXN_+PuZw1W6-6DJ+3jVWbA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: update ioval2 when faulting in
 spa_fetch()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Jul 3, 2026 at 3:12=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv_iommu_translate(), the only caller of riscv_iommu_spa_fetch(),
> will use riscv_iommu_report_fault() for all faults it detects.  And it
> will use iotlb->translated_addr as 'iotval2' every time.
>
> At this moment we're updating iotlb->translated_addr only after a
> translation step is completed, meaning any fault that occur before that
> will have a zeroed iotlb->translated_addr, and as a result iotval2 will
> also be zero later on.
>
> Keep iotlb->translated_addr updated with the latest translated addr we
> have.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3559
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 974042d017..6761b77f95 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -546,6 +546,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>          }
>      } while (1);
>
> +    /*
> +     * riscv_iommu_translate() will receive a fault and then call
> +     * riscv_iommu_report_fault() using iotlb->translated_addr
> +     * as iotval2.  Update translated_addr it with the latest
> +     * translated addr we have.
> +     */
> +    iotlb->translated_addr =3D addr;
> +
>      return (iotlb->perm & IOMMU_WO) ?
>                  (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
>                          RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
> --
> 2.43.0
>
>

