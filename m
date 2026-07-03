Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17662C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfUt6-0002ml-MN; Thu, 02 Jul 2026 23:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfUt2-0002kY-PG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:48:20 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wfUt0-0006pd-Ns
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:48:20 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso128968a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 20:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783050497; cv=none;
 d=google.com; s=arc-20260327;
 b=JGpoqFKcfliY35LhFm90NFpoo2/d6YH/7suHeo4EueQMeyiw3ZFAOKJIjkG9/15eap
 CDvJLZFnFi/IGiVOJ1P8owZ1W3SnySAyRSZF41x8Xs8IfywLuWsH4bj/4b2qyymHsaVs
 zksKV73eJcoNGayYekykWg+S3pz0LolrR7EcRzsYDmxIJuLXzC/MwotxfT/1/MlGNq83
 SnNasDiBoPG+ies3S9+BOMusWdd07XMm7hpC/V/RKaiVE6Vo0J47cF8cLthdmsToIa/C
 zjt+vJALDFNnxtsoEhxnXwvRHmp/WSOnCw/fqpCap7nQz2ZJRNKxWQ/gUyunl6vFVl5S
 rNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UI99xHHgi+w+Z+hIKQ0d4vDLJ7Dbhg073B36V10ZKRE=;
 fh=/ysHjd8n+TX7ATgBz7O/qDhF+ftt+rgvaZMHS+3Emq4=;
 b=XflUf6Ih88Y1z/BsANBba986IU0xkl23LWFF+Tk4BYRPaUnfPTIZYF3xUn+6Soxt89
 HSxosFYTdMHjq5gDoNTbMv5VgklgNObHNUtoPd6Jy5pj+YXcQMaYyBwbV1UzbtYcPX/d
 mXD9L1USweQkDTrThoDwEz1syP4jvCj7sp7MyP+1bFUAwr7XvzoSzVPrvqzfHWFlZSdA
 b8m8GnIeRHzuXVmOB9R29GlY3o9Pi2GYDroPrSrAiLxbxevcTClV/o0MDy+AM1YHIKEl
 rUktN03hzDxfzBCbQMLNbgpltzA5jbcSz/VO6cu+XN9q/Kn3zNDMraT81j2X3EyjtK+W
 dZ1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783050497; x=1783655297; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UI99xHHgi+w+Z+hIKQ0d4vDLJ7Dbhg073B36V10ZKRE=;
 b=ZeXH+Imbphp7rdX5yP6DbJxXQ4kZ+pL3zGDNnPPETozPAnhCaHoqlivGTzNIRMe7Yb
 Rr+iFDQVUfOHNvi8gxZdVW4s0lKslXHqtseQDp+DvbGSTQzSxPlPl0zSSXuNWt8UR015
 XQtb0l4FLRifOVtmBaeqnzmfQ4ZFwSWYcsSVwukAt92FSNL8V1dKeihcyMEd2Ce0W0d4
 ZGeGVfOnpKrlIlo3WufcloMLKcGVpcYWn0HXNQiUdMJWvFhu5OYXxd+RU/lCKHxJh75b
 4M0hSjPWADl7OOn8nyvyNUqxlmV2FUHYJNMUEHq+6h+rD1yfRLDM+WKq4zQZSQyV5TKi
 0nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783050497; x=1783655297;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UI99xHHgi+w+Z+hIKQ0d4vDLJ7Dbhg073B36V10ZKRE=;
 b=p1BbiOWZHPmSJYf2yjlg8QBimCYavfByZHhfnAdtfgQzGElqNzhWksQ0f0xw6ntiWi
 XhmJGFtj0SeLAauktrUerreaWzTzErMtaEvuvIsnYdT1GmvcRP2FqQF5ZECj1xmfREUn
 jZjxkXQUujELH4SWNMjH9SGrCD95xOLuqmScIrdl8JT88W0h2H+6jfkWKUefFHJXQVK0
 t0uRxTRZsaJgDvkv+zQa5v7zz27x3aNN0hu9wmvtpZDhZdyxJY1G61XxFXbidX7P8OEs
 Vm73yTslwN2VepM2GYuFGTNtCIMoPUSL/r5tQqMVMPxJooh9ZSOIrTTcwps3UXcO0IGj
 2bMQ==
X-Gm-Message-State: AOJu0Yyny3qc93rPRvWjGeeyUp0jOeAy2GJJbd+ZvJGkr3oahZpLTOBq
 Hrm1q7A+GWuQNkhRFATQrS9CrjDDdnFf9ls47AZICWeC872DhcYK/VSC7xzUuCYd9XpWr3+au3d
 QMOQNzGOgA8ffkS0riwAIb9J5ASnMiFw=
X-Gm-Gg: AfdE7cnkutKOyqwem8MRTKMI/rswm1LMo8N4ft67TPtuzLvgvzplHBoKSCT4qcDRTUu
 TrQUOSfkIfS75A7Ky5g2yOIw+7Wi1hkiMjmPH0uwEaX6WmmcfGxwdcgmewPkAQzhod/EbHKtzEK
 gGWvBgfdKtuaI+bsn/K/YpGChm+7gEle/L9osYYXUHux1C6GwBQcqT0qkEW8beQBMFFBMqLiaFe
 MbHQf/NtsftIdFKI9YvIPM+IsV2rr4Fbcg6d25voCJfPZ85Yt8a2jwwDCHYjBG3MeVHZZDVEJN0
 9uia6RbcRf5knY8/na31LelVyuQ=
X-Received: by 2002:a05:6402:3595:b0:698:b23a:e54a with SMTP id
 4fb4d7f45d1cf-698b23ae605mr2224720a12.31.1783050496444; Thu, 02 Jul 2026
 20:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260701121111.537654-1-daniel.barboza@oss.qualcomm.com>
 <20260701121111.537654-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260701121111.537654-4-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Jul 2026 13:47:50 +1000
X-Gm-Features: AVVi8Cflko2skZwxol2pEVZgVLb_QZfuaOuSzvYgV6yEbkE-jlBH4DGh0OS1rMw
Message-ID: <CAKmqyKNGb4pst-hmaSc6SXG1HV2T8ErZhNYn8JdzyeY40yM-Tg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/riscv/riscv-iommu.c: fault for non-user PTE in
 G_STAGE
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, nutty.liu@hotmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Wed, Jul 1, 2026 at 10:12=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> riscv-iommu spec 1.0 says:
>
> "When checking the U bit in a second-stage PTE, the transaction
>  is treated as not requesting supervisor privilege."
>
> We need to *always* fault in case we're on G_STAGE and PTE_U is cleared
> since we can't be on supervisor mode at this point.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3555
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 3b165348ca..29eec3133e 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -494,6 +494,16 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s,=
 RISCVIOMMUContext *ctx,
>              break;                /* Access bit not set */
>          } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
>              break;                /* Dirty bit not set */
> +        } else if (pass =3D=3D G_STAGE && !(pte & PTE_U)) {
> +            /*
> +             * riscv-iommu spec 1.0: "When checking the U bit in a
> +             * second-stage PTE, the transaction is treated as
> +             * not requesting supervisor privilege."
> +             *
> +             * I.e. we need to fault if this is a non-user PTE since
> +             * we are always in user mode at this point.
> +             */
> +            break;
>          } else {
>              /* Leaf PTE, translation completed. */
>              sc[pass].step =3D sc[pass].levels;
> --
> 2.43.0
>
>

