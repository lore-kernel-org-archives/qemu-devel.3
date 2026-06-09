Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F85CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 06:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWqMP-0001Ho-EG; Tue, 09 Jun 2026 02:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wWqMN-0001HE-JR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 02:54:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wWqML-0001Gh-4I
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 02:54:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6593wlAl1064949
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 06:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=Q7lYy+PFax0YtPhprTkGNuknYlHwLujD9zPWMYpQ3+k=; b=L8
 VZ6hDNrGmIa5hGUkoYokrxtFgnmm176hNRatMjWU3BC6uyAGoz5AMKAfHZdlal3T
 e/GUzVVXRWcPBrM/GjXuGxDTIzpPueHiHj/B7CPJaTeh8RdfD0G4mig+ZFmh9Sof
 Hst7tCqFqzWBeumiEkAuO0TYPeO4DjBUJIA48VwiFk2uy+qJTFXLWwz8cJHJHznA
 pAjVupj0yfXCd/cIC8E4bn2QLR52+tfGCUBHe8mtmFwxNbh6zGFlA23TFg8tRVGB
 gF0XPmYeoXpQ71Pwt50JuHhNMncOZLy2j6/CtsdUn6frCNarzQgq2V+vjK0QiGZq
 olt8akoR9RaiHEqADP5A==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m4fpy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 06:54:45 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7efcf6f25bfso40047537b3.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 23:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780988085; cv=none;
 d=google.com; s=arc-20240605;
 b=No5THQwVbkSdyprdhiGgIUbl299SWSs6c9wrgEWRWek6YZE2Y/qbojXQBP9A9yj/nI
 JbG50CG5DYQVbmY+DDy5/vxW1yQmifGtnISXMorBA31+AC9ZhtIwPGjKmcWBRXCM+KUk
 DKe/MD+oPWhT4b2NgDLvzydwcST2o4Td+jwK2sqs54Ed3sfAS6anI5/9DuxBumM2FPXH
 9VUUUPrRBvjgFy/3Hd9XJB8CQgPq7AnWl4Mdkk1sOLY2QIsLxjwSHQYbLSNPrxwmCe86
 YLeoJzIZ94mFzMZAY6VimC9FI/Ka2izugl2DalsWIUhkyTOCrfn+5eMJufWYAlXZfYXC
 mhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=Q7lYy+PFax0YtPhprTkGNuknYlHwLujD9zPWMYpQ3+k=;
 fh=M8a7lnvwUIhzfmVXoF9CbZI/0WMj9cykP7fp5FCiUsU=;
 b=BnGbh6rQVojhxFgTKVGtNOMQRh4X9vYTbckIxvnkNZEQ/o4p1Wk4RJmow34pDiNcil
 NaEYoXeD1LDq1JwbJOeO+7ZnxN16hC1pFegxCuqHH6loPrjyezs9UnmJ6XtAAw2qbEYb
 P0zLsDK6VtZOmMABM0i3IOumFnnDbDbPPH/nEF0NZIn+aV4qRbBNGWCBQK0cXhRO1AEv
 z8xlQlOFkwQsbuCElQaEuM1iu5ke8qS3VqemszKJ+JTVdrJQ+YCiTj6C6EXWaNfKUQcN
 HGi5EYrPCtaqDPGxtwmgLf3xJexHub/Xtqkpx6/GxBPbnhR6W4z1//nIKV5t5lOOgFTb
 zI2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780988085; x=1781592885; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q7lYy+PFax0YtPhprTkGNuknYlHwLujD9zPWMYpQ3+k=;
 b=Gs+zuq4xkmBus/oWDcoUG5ec6G8+EmzrWukSjF24tA4pupW9Hsr7njJABsDdAXTwWK
 gw2rOaGRaSAQYyotMnMaaehQDs4ti0kD/S2kxPSOsOYjhkAcxa2WY4tWIMR5Op3RlCHN
 DEajrF9Eo3LCa4L2Ofj3u4m2pJGJH987m+DyBSvQ0QaSnDAi9Ep5qc6epBtkIMBGT+1i
 aAxgiR9wTIDmbmc6tf+kLkllFPxSx4ritkGLSXbpMUznJNSxq4q+ByJgyhkCMloHPavR
 LSu1umkPPNWVKkR/yuYol6NeCu+dlHdAF71NeLa3JGlIYpw0Wb6Zg3ZZTZwqv8M0yz7U
 mvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780988085; x=1781592885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7lYy+PFax0YtPhprTkGNuknYlHwLujD9zPWMYpQ3+k=;
 b=Gd5Le1KdblVTR3z+fgzglQRBdNg6Myq9lx1kUdZTB/FHr8g4JSydkF1Qvd6CG5S1Ll
 YhScZf//bccr8AWtKGpl+0hHCe/Ax9vxR0dFXv1XiS/yh0AaRWo2cOefSJvIXOXlz90i
 UqEaeU8JqxSEzmGG0ifpEax5u3/VrqLxbUtBaOaKFT/EYzpEkxtdJwPQ3wRuUthZP42g
 WaiosOhU5rvNeMSCDODnwgI/onHkGJInpy0fCBCK3dhhZaGTpBfnjshJR8FyWY5ifEue
 wna/tyqG+UveTtNx2QulD/cYengKcIrI/CbDTeIQknHJQau2Qzrla6dtX+aojklw/R5j
 MOcg==
X-Gm-Message-State: AOJu0YzJpqYEh2ea1Qy0nFXNvnuHzkHqI7Wrcv+nJ25df158Bs2Y2FE3
 pFAd8sXeb+Bg7NeEvtUnJu+8TYrfiE8GPV9kVs4IzkaLD2Dz5Ip97zJZ71Wc86+ghDEKgA7/9xy
 Or2gRr7yNFWfrtJ4/YtkDGGLgjmeHajNZPIBfjbHnpmA/R4zu63F9xuugnzjSG0mhnPa/n96CkK
 Rr4kyYIAUqgzuWZNolEvfpKPokQCf9XRER
X-Gm-Gg: Acq92OFAvOHuKawMdZbkpybV3zzyyY92CVK1YIIjNHdmIW4u+eFvZnvsXImzWOy2XwZ
 JnlUyi1XQT/+xOstK6gU/eFJmrOsX9ExzlCEWM6e6fAJ9ymd5Mu0J21Nlkp0EMYkNWCIZFuDUQ0
 cGprTR7tnAsv1qgzhAl0vhR7wfPCDPbzJ0oopG0UCeMFMukgRXVyrL0oYuBCWVhy9wIisoQhQIt
 vurvRfHYVw7pFjx/Q==
X-Received: by 2002:a05:690c:7648:b0:7ef:dfa0:c6ac with SMTP id
 00721157ae682-7efdfa0d347mr80056567b3.2.1780988084666; 
 Mon, 08 Jun 2026 23:54:44 -0700 (PDT)
X-Received: by 2002:a05:690c:7648:b0:7ef:dfa0:c6ac with SMTP id
 00721157ae682-7efdfa0d347mr80056437b3.2.1780988084255; Mon, 08 Jun 2026
 23:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260604120017.398890-1-qingwei.hu@bytedance.com>
In-Reply-To: <20260604120017.398890-1-qingwei.hu@bytedance.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 12:24:33 +0530
X-Gm-Features: AVVi8CdPiHv0BKKk7wTIrjDjopcoA7oip53qUT0EuNV6sQoDEYhKmFxQU_syScs
Message-ID: <CAB19ukHpaUSJ_qMrO4DiUX6rioeoOT4h_=UHUgjsgecK7F1+7A@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/virt-acpi-build: Fix RINTC PLIC context ID for
 KVM
To: Qingwei Hu <qingwei.hu@bytedance.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2MyBTYWx0ZWRfX3TpogJzq9krT
 hM33eshOxnA12UpUyL4RH7j13Q5nTfnBwfiTyKw07n5xjJAoVALnKj27wxxPFjKA47iRVKoaIMx
 il3IlANlIZK371Z2TVnuiiZQub9iBovv/nJ0xTlRZGiv/6JV9W3c/QSxBV7UzgSOxVZzBygrcgm
 ucGxLd/lZfTf51cW8+3kl1boXAYdEP5ELfNhu9G6vDWzh/O3WyUVvsmlA1w9ClX44uP/dS7u3sV
 4/Au7rkPP9PMus70W/cGODbVnbdCbVI8XkLxO4Z8mq0I2rWbbIbBO+d9H29a+XHzogAqptxBd+s
 mB4cGc0Cvvu7tIwt+NdhubxW2EAVb612XbBqTsbfDtWzPqHeAXCrA+I4LG5NuFu3SYRpEwyE3bI
 HAXFacgapo9PQW1z0WnEHp79SaXN6lEk2PeCVP+VBDkjA2TNGlSwnunVZodeUjaSlgmBj+3BKRZ
 wFaVjSBJhCbfXpEYsDg==
X-Proofpoint-ORIG-GUID: p0nIuz07ulz8dU7fRv9bFflV_APu0c9q
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a27b8b5 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=968KyxNXAAAA:8 a=EUspDBNiAAAA:8
 a=UUqIJvGwmf8YkP_u_ZAA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: p0nIuz07ulz8dU7fRv9bFflV_APu0c9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 4, 2026 at 6:14=E2=80=AFPM Qingwei Hu <qingwei.hu@bytedance.com=
> wrote:
>
> Each RISC-V MADT RINTC entry contains an External Interrupt Controller
> ID field. On the virt machine without AIA, this field identifies the
> S-mode PLIC context associated with the hart.
>
> TCG virt has both M-mode and S-mode PLIC contexts, so the S-mode context
> ID is odd and 2 * local_cpu_id + 1 is correct. KVM virt exposes only
> S-mode PLIC contexts, and those contexts are numbered contiguously from
> 0. Reporting the TCG context ID for KVM makes the guest enable a
> different PLIC context from the one used by QEMU.
>
> With ACPI enabled, this can leave PCI INTx interrupts pending in QEMU
> while the guest-programmed PLIC context remains disabled. A virtio-blk
> root disk can then stall during boot because its first interrupt is never
> delivered.
>
> Use local_cpu_id for KVM and keep the existing odd S-mode context ID for
> TCG.
>
> Fixes: d641da6ed43 ("hw/riscv/virt-acpi-build.c: Add PLIC in MADT")
> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
> ---
>  hw/riscv/virt-acpi-build.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 413d47d70e..6b06d9aa87 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -100,6 +100,8 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
>          build_append_int_noprefix(entry,
>                                    ACPI_BUILD_INTC_ID(
>                                        arch_ids->cpus[uid].props.node_id,
> +                                      kvm_enabled() ?
> +                                      local_cpu_id :
>                                        2 * local_cpu_id + 1),
>                                    4);
>      } else {
> --
>
LGTM.

Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

