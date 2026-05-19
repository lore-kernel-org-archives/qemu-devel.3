Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCNz-0006kd-UX; Tue, 19 May 2026 00:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCNx-0006kJ-FN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:48:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCNv-0000kC-Tf
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:48:53 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd394f4a931so672911166b.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:48:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779166130; cv=none;
 d=google.com; s=arc-20240605;
 b=eepieQkHWFKgtbF/ZXAS48kNpPB9x6BNBNiesXZW7Z5hNHxxPyZ34mWnbKSo+5m+zA
 dvAKhduHspdqSMq33znbIjldj0aXu24ICHKk6t6a3qLC90jScttavDG5Dz4y9/8Q5TTx
 +mXFjsLmfYamiUMCUzQumw1nwFDigQ7cImVFJiSdvGKHrXab2PWrfpEe6xspMfL81mrc
 xp+f8X83hHLmd0VfQTQ3JUtaNd8E23qMGafMQ4AHKTfD4mmr7ekt1OwJh6ayYC7rszHw
 fQrWB/LP+xScPuktStQmzR56Pli8SOJ/pysEyN2I/8X77l7xrPKw87n2oZbDyJvQbdLh
 b8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=37msn/h76tZy7mtPLM4Qy08JA/Un2IRmRhlHQTmizKk=;
 fh=GDHgVZLUzfC/a9ecQHEKaPVt/uVGB5TWXR6UJeGYf+0=;
 b=ajLvmZZLvn2FjUG5hMbel1xoUB0SQC0Gloa+kq9pJeutqAGllxFF9Ikk8jsaJFUoeD
 c0UAfNrFeAyL2YRN4kGvpm7aGagzpOuXHpBXQkJ1oAdE3WWObKP0Y5sNGJzrF5lEeq0N
 JZWK/AOLdEpr55+eOFi7rQfi1brUg2sOBiLry9BEfM/yrLkE9bQDttlSwJYIdfTKC9QO
 8Y9fHnEEtH7GzB47p1wHH1H01S2DJTif2FEBj0NsnR+8V65jkoi4mTcx9A3ydxhhePnf
 5TEEyEKvigntYXXcV30BsiWIazxCKm/+pVxafkaanSiskOEVNYZk2hsSX9KxD1peg6hD
 bypg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779166130; x=1779770930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37msn/h76tZy7mtPLM4Qy08JA/Un2IRmRhlHQTmizKk=;
 b=WlEOlPHechD+1l2w9MQ8837K1rTEwfXgQfpvHUMfW4Z+/VMEVchtnB4nt8YURYPmdb
 fGBPkMHCDKUp/6fB1JRF59tz9PsB+KdIjOBdhQeyyiP21T3sHr1l+5l+Bo0SNbki1FLu
 ccgyvI2xNH9W0dJv9XXPFnPeTYSKpULjnvmLCKkAS3rGo5sLEoPw+8vb0DE40ZFH+Kiu
 c549kNKqgUWwyL4327G2nfQkRnKqpYyKPBDCk73kBSnIW38j4PCoGNCnEMmfQZ22747n
 haqe5d6PHsgX4/D3LmdwsH0CNA8JaYcX5unr0a8NwKT6o9S6Bag7qA476d05XABRFHgC
 ioGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779166130; x=1779770930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=37msn/h76tZy7mtPLM4Qy08JA/Un2IRmRhlHQTmizKk=;
 b=M9qrh+WlnHiTY4AXmcqusFhQSqnXxQ+SZ81gBvrFzcYr9QlYoXhpw+nwqjOG2Lv0fG
 hPdbNwdUYn4vuoqq37v5M//V7zsFIYgVG0cTA3U3xi1SSun3R5ROi0foq7jVf9QR+g6/
 4RlJY3E1TTWTsQE764TsU4fKgYvyd1UO/PrynlRdxQonh+G3YuTh7gTPm4oDZ0hZIptP
 uFbUYEEyYYoWTQevQhu0fphlES9qsjQAbygcyG2OvwOYUM7pi2yii8zhLvPwY1qrcsFV
 4JK0qpb/5h1bol+YmCpBpSeiDnGGUWx3w4+NjSfc0VTIzK7lKyyyWvVdJA7it8+yHtdP
 Vgdw==
X-Gm-Message-State: AOJu0YzYMWN92glHIPzjSQRQQ9e3fWLpawKdH42HWPS7NXhfqR8BY+nG
 r/WpRBqtRIz442K4csR6Aq1GCL3+0YaID2EAvjAci/VB4mK9Sgu5j6cGVg506m7QBvtX9CqcrCM
 T00vkDgBxgNi8nT6Ug4XzyH/earXQHr0=
X-Gm-Gg: Acq92OGHgDGUHX0jtrA+SFvpSabM2XikZmEDIQIf3kM2eJyrtAv4fE5mlVqfZLFiC2W
 SZ2N/iUjBBzrHFO4X2B3MOyFuifnVmLZBoMd/nPgA+J7EVP9zp9xidXk481D5IPHwLIxxmp7xtg
 gMpQl1qxDIKIEtmgh3xSpQFz3sh/yIBXLP/uXPfHlonz0yG2jnuc7SSbbRSFdjceBzcDZxpS9Rp
 wVqx9IzuGPk/2q53/5gbzhn+nXsK2hkBFKBB2ilUZMAoeQTgr+UnGyyUQ9yaR+L6mbKq7bG6VCn
 ou+E/JZd31oa/liQrqBAbrtxSPDiCb0Icjsx4g==
X-Received: by 2002:a17:907:ea8:b0:bd0:4f6e:9b2f with SMTP id
 a640c23a62f3a-bd51780c078mr1018033666b.1.1779166130017; Mon, 18 May 2026
 21:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260518070143.8405-1-jay.chang@sifive.com>
In-Reply-To: <20260518070143.8405-1-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:48:22 +1000
X-Gm-Features: AVHnY4K3s8qoRGMMXfp_mlsfHa1uy_pHEZGN5tZ1maNZUHX_7tcQkQBhr-907E8
Message-ID: <CAKmqyKNi=scF+fshvBWz3yL89UNM8J6LaVazKdKHy8q6R=bp3A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Mon, May 18, 2026 at 5:03=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
> the IOMMU should re-check the command queue and continue processing
> pending commands if head !=3D tail.
>
> Per RISC-V IOMMU specification :
> If command-queue access leads to a memory fault then the
> command-queue-memory-fault bit is set to 1 and the commandqueue
> stalls until this bit is cleared. To re-enable command
> processing, software should clear this bit by writing 1.
>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 5bc2472a83..1b8a8e9ef2 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2034,6 +2034,16 @@ static void riscv_iommu_process_cq_control(RISCVIO=
MMUState *s)
>      }
>
>      riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_clr);
> +
> +    /*
> +     * After clearing error bits (CMD_ILL, CQMF), if queue is still acti=
ve,
> +     * re-process pending command.
> +     */
> +    ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
> +    if ((ctrl_set & RISCV_IOMMU_CQCSR_CQON) &&
> +        !(ctrl_set & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CQMF=
))) {
> +        riscv_iommu_process_cq_tail(s);
> +    }
>  }
>
>  static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
> --
> 2.48.1
>
>

