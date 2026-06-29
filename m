Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA4EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 01:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we0Lz-0003LC-R7; Sun, 28 Jun 2026 21:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0Lv-0003GQ-HQ
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:59:59 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we0Lt-0007ar-OM
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:59:59 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-697ce8cfe65so4466097a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782694796; cv=none;
 d=google.com; s=arc-20260327;
 b=F7YMOPOg3VmX6RVVFMoquatBvI5LSq1O5oCaVqDDOsSOxVOqVeOXQikjmrlS3rmmcl
 +VCQfWLIs0b1HoyN8iz23jjUxvIff3uidXgaI/lQvEL9PVgovFZsYq3dDmYC+L2HWCox
 YvTrWmt1wHjvabeaL4bW2AMZb0TIB21jaiHI3y+AKf8Ph8Q831d3CokXmqS1PunmG9PH
 yVOd6MoKuj7eBYTVZ0pSYV3NFJqjb66rQlx97XstORm5muLjDa1vJ7ezbjgsSeDjIBNr
 DVYEusG0VDoHcDI+UDzFaKwXLT5CxocudE06aoqwwkjaC9fDgFWowGvKT4S3i9DXsx4E
 9p2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fswDypsmaUpnX9gRc/EeXf+M7ydl21C44MDky4xyUmg=;
 fh=AQ+B1C/Ki1LsjQfI7ecoZ1cDQAgTcAikhrW+ydcERKI=;
 b=bStkOOcUJa73IFEOp0AGBfT0vnXJ5zOL8CmTfM633noYtEdNsL7vVSPdswwd7c9+iv
 UK0MqU/vZ1EAaposeLhVujn4/QdDRfFljAtzDL90aTvBH6x0qbDg/hVV5pdC+7hZEomD
 zqUX1zLvDAgtVJFMh0Na/rdLWwJD3MA63k0p14s1UWDcaGvCw2+tPmyi/O2DmB/6CGpv
 pOHB+ncRX+JLsyf+ka5ce8vwhJfFfFxgjA2VTZIIFSyuyeiaBtCFmLpjBgrdx7jM5mcj
 yn9dAwZG1KFhPiz6g0RCEWjNCDSDWdJzp1NkfA1/8C8MpcTzOrlp0C2QOfwqocp9zu1r
 W27A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782694796; x=1783299596; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fswDypsmaUpnX9gRc/EeXf+M7ydl21C44MDky4xyUmg=;
 b=hYeK7/oQKfARluNyF/34WM1MqXQf3YG/VEaifsSUy+Cbd5yO/kYeXDx6lBmrdpHeJW
 KCoYOhqQUs9yTTuAKf8bO9RVMHFCHAvJDxw/SxKw3smktwS34V3NPn5i8Cn+SFBUA9JQ
 +6M0A8I4s3786xx4auUDavRWLAX13vGz4rhXVmDgseOzUWCSS6fFGOW9kOVdNerVv0rg
 iN9fMbPETHZKbWaQM6lPK+UBDFHt0MMrL34UMZ+ZE4mV3JkBPuNO0vfa1BPS5h0ucgN2
 jyIRqEya/Zx16z3aILE4QdA3v4CugaF8csg2dHjytvHDml5bO5Uaoq3bu6tX9ekoXQfn
 ba1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782694796; x=1783299596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fswDypsmaUpnX9gRc/EeXf+M7ydl21C44MDky4xyUmg=;
 b=GsM3nPttsh+eC3gHNEwTQbBl3KLykMd0U0dSqVbfx2rqOYqGZ4fGdoBYGCWHr0yLNE
 m9S5icnnRj4XYMyycVxlxlngd2FGW6KSsWcVXCQpkc5VV83u4xdft8arI33vNaS+z3Rn
 0/zZvfDOGE8l7wMfWaZdY2V5H8rY5/7gUTXTnT5Ic4PCwEWcY6G2JUopIxLrFXHkItS/
 miyAaC0KwdgsoSp2Ud8C1luQCIC3H97/noKKF/NHM5/rKk6K2ZPJLkEt+DZu9vK6Xkoi
 fmxB9Yr41macvgOZigAMUUAm59QflWUs9FZOwRgLrmLyMCecTis5YDArRo1yl8e+Jsru
 v5uA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc5dUMW1NzaFAm3Vnjazb8hloO+Dud31XFgYKchnh8TQxIJb5+iEN8D6W5gob+xJ+F0C89z4fwF1nu@nongnu.org
X-Gm-Message-State: AOJu0YzUTE2xn6X4Sx2Ugub5+YlwifoMcvtfTXqT+zWX62oMSMl01IPo
 zn3bIy6kT3NVJ1I4hIjFzdAhhAjHIH44smbYumR5ziif+MHPAlM0zkz7y4Ro4wbE+pf6ELjtVgQ
 NToXr6wi7m1iWQM/6lhmiw6hA+nlTdJM=
X-Gm-Gg: AfdE7clvFI8nE/fno1ZtvGUjjCfDnzsnJFmLG0DVvfZmBGqvC0MNu4RFgfGwvcOb7vi
 9Xd+NAXXyW3X4RZElWFDCYf1xQ67qHudiYSLiIKNDFv2yp/dABGAR+LM97OUZZUlgiYj4dJbmc0
 NYJqAmZvrQwzvIG+S3ReK4CH+BAnBGJFE03oAbOxA24zUzyyk4iC484TkkB/Od7vLMP1n1QPlrl
 btFgAiQWFXBacE8ksXR6HieyEALQf9G7reepVYEJcsK9bdIQ2XPKhR54GUo2yz3Jiml0+R/6un7
 /PvcTmebWkolcq5gFwg/07IpGeY=
X-Received: by 2002:a05:6402:50cf:b0:698:4992:77e7 with SMTP id
 4fb4d7f45d1cf-69849927b2cmr2218816a12.7.1782694796102; Sun, 28 Jun 2026
 17:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260622113402.563196-1-inochiama@gmail.com>
In-Reply-To: <20260622113402.563196-1-inochiama@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:59:29 +1000
X-Gm-Features: AVVi8CcKB09sM2BM5GrxtazdBYawgGxN3XAGf7XXJD18gpx0MXGH2S3RDNdmr0Q
Message-ID: <CAKmqyKMpOiAuYm04BPGsMrfUd5y=kn-eJxQKds0gd+55yV5g7w@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Check PMP before updating PTE
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
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

On Mon, Jun 22, 2026 at 9:35=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> According to the RISC-V spec, the PTE update is a supervisor write
> operations, and it should also follow the CPU PMP configuration like
> the PTE read.
>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changed from v1:
> 1. Separate code statements and declarations.
> ---
>  target/riscv/cpu_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 59edcdd370..2db07f5dfb 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1655,10 +1655,18 @@ static int get_physical_address(CPURISCVState *en=
v, hwaddr *physical,
>
>      /* Page table updates need to be atomic with MTTCG enabled */
>      if (updated_pte !=3D pte && !is_debug) {
> +        int pmp_prot, pmp_ret;
> +
>          if (!adue) {
>              return TRANSLATE_FAIL;
>          }
>
> +        pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, pte_addr,
> +                                           sxlen_bytes, MMU_DATA_STORE, =
PRV_S);
> +        if (pmp_ret !=3D TRANSLATE_SUCCESS) {
> +            return TRANSLATE_PMP_FAIL;
> +        }
> +
>          /*
>           * - if accessed or dirty bits need updating, and the PTE is
>           *   in RAM, then we do so atomically with a compare and swap.
> --
> 2.54.0
>
>

