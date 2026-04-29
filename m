Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0522FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEXh-0000oD-48; Wed, 29 Apr 2026 19:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIEXe-0000mz-1M
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:42:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIEXc-0003VM-IO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:42:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso42831266b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777506123; cv=none;
 d=google.com; s=arc-20240605;
 b=NuCMeOGZitWGLAQ4UbDoYzESYm71xmrzzMSzFredTaS+IHuVY43z4SWvCJrYSVu2Dp
 tXmMS2mgyuGKlexKT78RFsMfhEV7PNQNIgalkKrNVbBUzqLNHsvLCIt26iKaWokGVe9d
 JfvlY3VLFbRUYaefqgxd8PiwNvHajF0avh6lNH1dFSPy9BIos8AlHdaEuXMv5fBXy23g
 g9iQeOh0wNE6lUpUmdIIIDoHpB5FTNfMY8JA2trq/Qu/abA5Vxj588jg6teMbfwfV9h7
 GReKDs7xqypvdjIOimKziZbMzczrYbN9aDgQPbapfAL9FdP+E1vvlI2KTtZf6kiTAjuS
 eb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7nbWcpUZf934CmYnE6WRwIoecwMH210jpBLNgg83bUQ=;
 fh=Nu+pFxvxDPooevmcvd3pJ9T8kFTCBVKTNkj3JVtZpjk=;
 b=bVmX6b0UV40R4LETNhK1rRaaj/PZdvtegafGyXtpM2KV5zdwO93zmJMhAMANJoi2W1
 2igAflhfaGpJGCZg0MsABkXMBgZh+V8N6tFOA/dIFtTKUMCsT3gAsCSjc2p4bPLplVUV
 oyBj9D5wA4jmGBqBYvTLMXmLVXbxKGfynqXZfoIrL08xCSfB5ffUX+SOtndD3lAtvgqw
 46eEfNTet8rnJutuXnldZ00nBQvbqEpm/tyXErVW1P5/DoZgDeH7M74u+Em2sldKus94
 9aOwQ1ul+eTj3KtLez1LpwXUQ8mNHYFAT5Xy4plwSOjtwzRcZqS2m4izgiPUanTt9OMr
 aOAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777506123; x=1778110923; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nbWcpUZf934CmYnE6WRwIoecwMH210jpBLNgg83bUQ=;
 b=P9ZNlChOFDodOHthzpnCgeQM0vPZPuJKr3bkSNnwEvB4gdUAq7Dj3v0fbAcQ9tB4xt
 M1rJf5JtGOK11JfDFiDi7fJF920ZfECNKEyE2pDSXUJ7733wJyRD7cOeoAptqr6S6GrM
 T1HbwQ7mlFmVnjJCLulN5eD24qfKacEyQbKsEDtgM4aoW/deJKbyaFjJg2hFCJS/FiD5
 KCFw4C/F6Na9bRz9O7JzNrUtN5qLBws2leTf711lAUep65tIF7Xzn1hihVURmYQkQbbG
 BQ+ZGVWeraKSiVcCmAdl8UWWDc/dIJc311QYfiRTDK0E9PRefvxsUWLj+u6pyvNFVYwO
 Popw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777506123; x=1778110923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nbWcpUZf934CmYnE6WRwIoecwMH210jpBLNgg83bUQ=;
 b=Sgn0WduxyP/zbXtuUFGX3w0N5jGnqBRAjw3urk78ggGeFFERtwTc7N+PtPEZsQeq3I
 IlhR3BhiCszYGBoWvgFiglyJt6/kbzalhIdP2sqpDyWkr+1nOPitcrrR9htGUpU2vzSU
 MUQa6BvLjJ7mb08OduFvU9CtFmmIAtdrMDMqKcLahLZ/w7Q8GkqLAofQrIPGWyM181qt
 ZP5o8x91KvEyP93ylFk5gac1Z8Qsx12+QxZkhnvlf2+d5tdyzhm2cZiTNImgIy7sI/cM
 OZ60mJWkmIPPcePDqvaG4j3iXMbiNUVYBCXzp+I9JwnU4sxTvGrl0gE20pZnE05GGx4e
 zjmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y0Fzj0kf8CYx9qqHzllX2Ztzq2vWGRBdXlFtIbzrdF3Cn/vUN0zclhIs9e4Y0NPt0J35g5oyIMCOX@nongnu.org
X-Gm-Message-State: AOJu0Yx80K21o2is7Brs5Oyvmyte3OUIBi2CI2uWl/fcRIUgnz4SYlZU
 6kioU72OCWVajeeJf30k/x45NVWADbk6q+Xn69J/0I6leFM1jtEMdaTk+DaXAwBtvibaDx9DNJL
 IAIDW3u1VUfJecXFm4HWqFRoDhBhHytY=
X-Gm-Gg: AeBDiesFgGBx4bag0sxMMZSHxQ7owS+clqA3C2abfhUjsIXunIfInB78I7PfVehv4mv
 tzqOo0/4xz3yd++UaccTTg6X/+4fYCekJLLa8i5oksMbD8MDcguiHbfMcc7okWFkpppSWDdeM7A
 Q29uWfsjwY8fcafw9u0xZKjtmIGc7UtnGRGpQCqpmHPfpGpM+ZHLi34hn2WtB5EBfvsp+shGl+t
 fKC/SQoa8OzhGY3628ap09HkE7FA1jE23cckOefj0D7ufyfZGkxcQRg4n5+EWZLQdbGg66iDg0Z
 WoOoFyASTqzl9AYstuh7eSUzsXdduaCaQFyp0udxwDBO8LRO
X-Received: by 2002:a17:907:5cb:b0:bae:6e71:dc27 with SMTP id
 a640c23a62f3a-bbac4bd9832mr41289466b.17.1777506122466; Wed, 29 Apr 2026
 16:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-9-joel@jms.id.au>
In-Reply-To: <20260425131721.932250-9-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2026 09:41:35 +1000
X-Gm-Features: AVHnY4KU4IlVbxDWbfDA-Ed3zBrWOhA6DEfEcI3xJ2-n_Uy0abH9hCvgwNb9FII
Message-ID: <CAKmqyKOp9DZ_JbT7H+dbhqK=BPVL9-RmMT=bYDf6wKuPgxzWqQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] target/riscv: tt-ascalon: Enable Svadu by
 removing Svade
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Sat, Apr 25, 2026 at 11:20=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> Ascalon supports Svadu (hardware A/D bit updates).
>
> QEMU makes Svadu and Svade mutually exclusive, remove Svade so
> Ascalon comes up with Svadu working.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 69649462dd89..97e35672649e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3204,7 +3204,6 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_ssaia =3D true,
>          .cfg.ext_sscofpmf =3D true,
>          .cfg.ext_sstc =3D true,
> -        .cfg.ext_svade =3D true,
>          .cfg.ext_svinval =3D true,
>          .cfg.ext_svnapot =3D true,
>          .cfg.ext_svpbmt =3D true,
> --
> 2.47.3
>
>

