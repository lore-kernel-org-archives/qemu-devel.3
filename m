Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B243CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQEAd-0008Pj-0F; Thu, 21 May 2026 20:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQEAb-0008Ot-8K
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:55:21 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQEAZ-0000Ff-IU
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:55:21 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso11726367a12.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779411318; cv=none;
 d=google.com; s=arc-20240605;
 b=fZcRXoaWbdx9xJLcpUgmogi7fv0ixfe2wCTC9qlVKEByBjvhKzslae/b0xJBlfD9dV
 tHdJOIznHEdwLsaQYqmzRtqWH19/jvYPwDUdP0dPWuFEFR11Q3rElo2go5OX6VMILyyH
 b3qJMG3HY+zzdWPf0NhE2bTcFMMgGewfxXccVNgm6P+BLFGhZvu7SO3qzuZYRV0PM9+2
 4jLxCTLj7RCfzIdQLb8iM4J8MClbRkSQbmWDToec8RmQ95mdgksLj7uxR5bg1Rhf+eL6
 Q09f6fcnvD6MVWV3UV1iHoBxuckkbwKYNDjwPOldSmMF9XG0i8KoVZ7Wjb9UITAtXVLa
 sFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Uay4Umbp+YGoKGaatPhY0ERwpHx863YwCMi7q80oGDM=;
 fh=O2eVX0dx021x8yEhrgIC0F4xHLJSk94EneMFKA7kjJ0=;
 b=MFp6z6Cmbl8ZtmloUtzE6H4orPonnaw1mCN7MPXz9rch3Hvr3C/fkz78Chc1X/dyio
 uLDvdbL+m7vsHj3Zy+uofx3yE0pMGK8GWR6/Y6ILvFBBWfww1T8VNIRyZZ2y5SC0aXY+
 jimc2OjpN4QM7tduc6/CC/fnaNZ/RK42NuJsBkYEmVmqGwgq088LLg5qDyxV+a333Efh
 ZS5Aw5aJBsgIKxxLjdFHt4xO3QoJPA2a/6//ueH/Hd34Hskva56fmwirIWGC+oKuyvyt
 oZNtBHSvrPLvNW/vikF04cj4SZXUra9PG/9N1crsM0dfhiMp3FILY3SeFbnv170BMP6r
 jDPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779411318; x=1780016118; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uay4Umbp+YGoKGaatPhY0ERwpHx863YwCMi7q80oGDM=;
 b=lR5xtcH9ku/gZb0rT5F45n/XATpp0yAXNISzWrTa91QC4SPsOODgPpDmRzcZgC0xaV
 jQsRHqZkF5Trf6fCXYOmVXvf4XwnPd8x+BJxEIoJUBo6a+nEtlYE/vAjSjII320fnrri
 5iB296eRLbtjG26a+JK7eyyvNY/9GUyYwTBThLqBykfKNOFfyvJYYxc8wV+fJBUY59as
 6wPKb9PqyNDnaFdoUiXDGVLt/AQ9fWyOsIgxs+yawWLV+irstaxBGIfHiQaO1A9+IKLz
 2BnxExvGhvuiMwFi5U1DFJ6NnFC3gLMz1UtND30fMDQs7qdqWvonElO+GTN0lpaCp3QL
 pVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779411318; x=1780016118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uay4Umbp+YGoKGaatPhY0ERwpHx863YwCMi7q80oGDM=;
 b=E2WPL5bcGyB5Vv9MZWrJFkXDw5eHnUC9HmvUMTNMA49jMzh06YWXamn2wU4fLXGFpi
 x16HtHA/8CzIUDKmFpBOootleHPnzw8LZ3nUp4S+hQkq4a1VF90FDD63SsTMdtgtvB7y
 G0hhoWOvFVQnRcOcnwKzM5thUslG6qeM06xUunbAjPJ0HNkweic0c/ZzTzQPNk6kTxzZ
 EHPeg9Qz/JrD+Bolscs6cv5l+q3RS79xdF8fSG5V+jwKzAlEIjwTKUgGx0EbrpTEPUAC
 +bUBkHkSw+Sap+JIn6Gs0715TTLx09SLsMMnNeQoLruPyaWjgKLpNjCLZN+QOIioEwgH
 SSdw==
X-Gm-Message-State: AOJu0YypQ/wlNIDa8OjRLKylMh4m0SnYFIDRZqJ/K4cyk+/yl1J2KWL4
 gfsurFaW+3ms2xpzMYZeXDHFNaBD4jkEsaAit/vjE9ta2Vh1Ac8n/iJOwKORWwmOg5DRzpygNyr
 rPHbywZu58eANFZxF1tBKTh5hQXsYRLs=
X-Gm-Gg: Acq92OE8zXZGSWwGYB70gOOQhBmRT9nTKJQUXHHIHapv5Oi/crcnrKKQxuDuoT6/w4k
 5vmQPhxO4MD/IlnBFAwkIHkqflOh82xmWuzw+rM+mFZdl6bfjHw8BDJ2AxKYqtOgAPgnwjRF9i3
 7yNcxheEjPJawzFGicq+yEjm1wsxOVeXSsYBiXzs5GmNt+MZxiu16nblOOXsIOy4BcaFKngmzxl
 ieAMnVEosgF4Z49jFBZUp+1h+hCfYV+/UI8uG7T5VhmpAkSSPsCTYRB27XM6GYgbKByb3duEDNw
 R2564jYxeJRq1GGIZOENCwguxWay6inPyMspWg==
X-Received: by 2002:a17:906:5a61:b0:bd1:d4e8:42a4 with SMTP id
 a640c23a62f3a-bdd22f29463mr59830766b.11.1779411317619; Thu, 21 May 2026
 17:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260519172621.98469-1-philmd@linaro.org>
In-Reply-To: <20260519172621.98469-1-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 May 2026 10:54:50 +1000
X-Gm-Features: AVHnY4IVnOjhWXDUj4bhcjPHtJixmklVRqIHVU2nH_EqYyMig4Jh7djTxlCRTeQ
Message-ID: <CAKmqyKPNfx0vKB9D=q8-VVAJj_J3K-GnbO9O3dD3hR7fpSrevw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Fix RISCV related paths
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

On Wed, May 20, 2026 at 3:28=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Host user-emulation headers were renamed in commits ba0e7333620
> ("configure: Merge riscv32 and riscv64 host architectures") and
> bbf15aaf7c7 ("common-user: Move safe-syscall.* from linux-user"),
> then covered in commit 355cdac7d86 ("MAINTAINERS: Add
> common-user/host/riscv to RISC-V section"). Remove the obsolete
> entries.
>
> test_riscv64_sifive_u.py was renamed in commit e1a8572a8d7
> ("tests/functional: Move riscv32/riscv64 tests into target-specific
> folders").
>
> Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73b7ebf1d7e..0a1cc0e51a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -361,8 +361,6 @@ F: hw/riscv/
>  F: hw/intc/riscv*
>  F: include/hw/char/riscv_htif.h
>  F: include/hw/riscv/
> -F: linux-user/host/riscv32/
> -F: linux-user/host/riscv64/
>  F: common-user/host/riscv*
>  F: tests/functional/riscv32
>  F: tests/functional/riscv64
> @@ -1783,7 +1781,7 @@ S: Supported
>  F: docs/system/riscv/sifive_u.rst
>  F: hw/*/*sifive*.c
>  F: include/hw/*/*sifive*.h
> -F: tests/functional/test_riscv64_sifive_u.py
> +F: tests/functional/riscv64/test_sifive_u.py
>
>  AMD Microblaze-V Generic Board
>  M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> --
> 2.53.0
>
>

