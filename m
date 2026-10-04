Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09F5CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOHj-0000vX-Vg; Sun, 04 Oct 2026 11:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOHh-0000vB-Pq
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:37:53 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOHg-0006mQ-71
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:37:53 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8a08bb1eda2so7388867b3.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791128271; cv=none;
 d=google.com; s=arc-20260327;
 b=W9/2+cN0PC8pcVhF3G+7IYLWhJqZBEPz9AtbkCv2UW5Q0YalfwtMZNFE5zR6edZnAD
 bgStqyrZDqp6KAPlBJ845VYsKfLQXUo2BxevCuM6D6HzrjpeOTWoWZz3Sc8/ds0DJxIM
 vNOtw4K1j/PtEONBiJghBmBmMZ7XFJ7iHvxRDZB7g9X3SjVAZSQ56vJFprXabCz6rRNa
 U+F4yLYzetVwAbZLQKcT3Ay0IrYKBkHj9szmCiVgiK0C1z8+AmqxcFXjr9NDCaMkRpNN
 BU22kpit690v8MaIhSMREz7JD2WPJMZNHs9IIrNFTvbn59lMKdAVeaFySxe6EzBVj+Fi
 w9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RcVUgNfznVI0SNePmkcCKBmBEyIQj+7JsvQtdgF8L8w=;
 fh=neH261pZ7GvcFoAxa/oY9CYswz2OEra+Zz2BVm/bjzI=;
 b=SDlc2cvnUHlbwdMv57kNEDl7axaA1yWYrHIqrTRFIjXvX7Obshacv7NjyvplVdIFx7
 rpcDklvEAxPHkLASgpRr7bJW5FQGruUfMg+Sai7kDYxSQsllKFbXnFV/Dc5H+eXPUcY5
 llQGmLxD7pwWg+Vq2aXCoBymbYCady6GPdQeYNUZu0ZSVUprGtztF+4aGE9UmZSnKiZK
 F7/S4UCJAYAZ2Hozk5V/2+SuARU6xrmmVLIZp2yFAr1AFWj4BIJLMs0xjh9Gop6oDI2u
 Dc2W+BDN5RMJw/1tDmtpsipITvlk9XbhpOv7+rvsz7oqIIXVQTInhcLCi/9JfULJdAwa
 x51A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791128271; x=1791733071; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RcVUgNfznVI0SNePmkcCKBmBEyIQj+7JsvQtdgF8L8w=;
 b=GqIJBZqJI6hglFrCbSX2eOGd4Cy8fI8cBDgktp+6EKC8ChaZje5oRDmIHWhqm95jxZ
 Uw7dJN1HPYfg74MnHPn4EWAab6WqbB05duYXhOqD4d5h5NFBvw2SPJhcaYY0QYJr4IdQ
 95UkDRAcCfaAtVWb69eTCcQx6UpbLQjIqcZqNXk4dWf2qMCCQmmvnFxVQsjVTyV7xolC
 TH+2qy/kGIFFvXaNq0sacOYQGxfPSJniXl7UD2imyCMscgNHqLL/DBOLUg3a5OaoaGUZ
 E++8aH2ORq/KvG0YBIOAkaTX4abGW6yDwLCtK4J7zEi/TVqQv/jDJ/sM6P7MdeshSusZ
 N+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791128271; x=1791733071;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RcVUgNfznVI0SNePmkcCKBmBEyIQj+7JsvQtdgF8L8w=;
 b=lD4ngB/FXgwEMFobBS2TDhGonHa7Ejtf/sZKP+7AEai1t40ffywGuD4cTKYo/Xry1m
 jo9CqvCu0D6JfaSnJ9u7BqRI8kfIjULf5t82AMPeAN/YoVR6miSyRddG71ovAYs4Cwh4
 xo1Unfa7aIIyI/SwWhDI10GFhMRE7g7SqVn0qlFSDSaQeubnPRBoGaZahm3v2q6BTXi0
 R/yirBSZv7t/lR1gcgARAsEYEcZnvaslc5Txqphqzh9V6tci8Aou/FkPv/Zi5yTKEmfj
 T24MqBuhXI0wXAne1QmfcCVbJyOQzyD93Kl1tbpbsfZz8nOwITnohCxrKFksPUowgBPL
 Py5Q==
X-Gm-Message-State: AFq9FYLwXlLIk1lrx5dxodqwmjoNTx4RV98bZ1OLH7bGgD9CyLWjqNNe
 3s8BNCbkYv6BRoAKlDbEpDw/oJwNjAdy2uI9Aa66B+haRhl9iqTs/zz4oKZH7j0hqY+MyYR3Hke
 qV1p4oKvuNWGD4LJMhW28hiZhh9aftdA=
X-Gm-Gg: AYBFou120KlpxYt5RjfVBgjJWlnMG2/lhjGG2TAFldmqMkDRz571eESZk4rgx2nAlJn
 LIrxF5jCs9l3alR+tWpcd3i+sL5MdWh9br5GNQe1tBVAuBKyncVCf4VOA4VDVejCpwqPJsyCXBs
 OxnbK0+2kDoDsKR1LSOCYk59paxIN5tt/4WuCvyMI9r6WZbQv5f9AUqOKMZc/DQ4yg9fX4itgQR
 /IYAZEZP7cnTB7bTx1y5tkY6EyIpfLS2vYnB4BPeQRiIfsJFiwox4Hd373iFr0K/E8N2lTr5W5/
 0OtMldaZKgepIeEh0zB8bxSHLhLGVoPyLHh3a9mnE12xjf/1f9TjIcqIk6bIw0Ayq0cF1lf35e+
 kajW87jI9V47vbdtEe4gt5+mWJ6c=
X-Received: by 2002:a05:690c:10:b0:8ad:c78c:2555 with SMTP id
 00721157ae682-8ae951f3fc1mr15292367b3.24.1791128270908; Sun, 04 Oct 2026
 08:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261004151855.201300-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261004151855.201300-1-tanchi25@mails.ucas.ac.cn>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:37:39 +0800
X-Gm-Features: AclHuK-5lptRo7y_hBtVSt2FnOmlFGodLLy8ZefqpvUId3gQT3WUGntomTAkbCg
Message-ID: <CAEUhbmXi+d-Dfc-VtkmwxMU421DQ=eth0WGSPQa-p4Yp+_grPQ@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: fix entry leak with ioatc-limit=0
To: Tan Chi <tanchi25@mails.ucas.ac.cn>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1136.google.com
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

On Sun, Oct 4, 2026 at 11:27=E2=80=AFPM Tan Chi <tanchi25@mails.ucas.ac.cn>=
 wrote:
>
> riscv_iommu_translate() allocates an IOATC entry before passing it to
> riscv_iommu_iot_update(). The update helper normally transfers ownership
> to the hash table.
>
> When ioatc-limit is zero, however, the helper returns without inserting o=
r
> freeing the entry. Every cacheable non-identity translation therefore lea=
ks
> one RISCVIOMMUEntry.
>
> Free the entry on the disabled-cache path so that
> riscv_iommu_iot_update() consistently consumes the entry passed to it.
>
> Fixes: 9d085a1c3cb2 ("hw/riscv/riscv-iommu: add Address Translation Cache=
 (IOATC)")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---
>  hw/riscv/riscv-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

