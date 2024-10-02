Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6E6CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsBW-0004Fi-Gp; Wed, 02 Oct 2024 01:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsBQ-0004FJ-Nu; Wed, 02 Oct 2024 01:45:56 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsBP-0004Qe-1V; Wed, 02 Oct 2024 01:45:56 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-84e962c9a99so1867580241.2; 
 Tue, 01 Oct 2024 22:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727847950; x=1728452750; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmSQcK0z0DgYs22RTHsqMdyBfifB74uH137hPv4CngQ=;
 b=JXdJTDoChElKYW3tceQ5QebaNAlm2Jes3Rz2TorBWMZWZqq1jqLEb+cSGAeqR97hBA
 6n5VerxErpaizOAIl0e63//YDau/1KpNi5zk3wduga0mtNyvkTFRPVCFjB7RA96xzgMb
 4fQ0zPYixicEelPEHbkzSDaFCSYU0KUePooCPNiivmcqyl+GnP6YrxU89ofmpo8DLPB2
 yCqn6nOhbf4UpifdRkGAgaYRTQy3EC6F4Uqt+YZ+EKNrJJbFX9Y0qAVzGI2AcPTAbHX1
 fhFAQCJkKElAUfz4hR1Rb6cv6pW2lzGdpsmF0TVb3fZKdnmntNcy6Ts65W8YhpXwIudK
 7dJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727847950; x=1728452750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmSQcK0z0DgYs22RTHsqMdyBfifB74uH137hPv4CngQ=;
 b=sLFhPAl7VuIDAkoRsnSijVZIrNT9vJi9oS5v0X5oXakPqYTCNGb4yMOJNEXdwcN3zr
 194kgbUW2+kBrgOXptGAwUc5MwG1k56VQKUqvQZJWs6dreb6hCaiQ2q1QVCbmCRR7v23
 qSNgZQV0junLtJ4Qr6l/abR4eliEdxJ+VlPqGAQTACMmsG9u+Wlv9KCtVS8POxaa7H5K
 vEJ+Ej6fEoGffdNJgVybnnjuBQq3ixwxbVbiOR6Lm2C5lLQp4dUXVQgpsEsvHdkcAA8t
 CRQQPAeY7hImlRqRm1oxTl/0p/Shda4/5bvffdzQdEwuKbsWURu0unyIgAEB5jkf7wY0
 A0Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx7vqtMrqQ/xua/jiTpXGLve+y2x6T4wGrMkDSA5bVrEecJEFzeqKpKgKGlq3fObFm5ym0phkUtFB3@nongnu.org,
 AJvYcCXj2TRm4LfKzaBAc/ctOebvEt8xDkUfRjCC+itU9PpIA3N8CX3DOewkNVDCMrRHBYCpK9RpKRtxIXr1Uw==@nongnu.org
X-Gm-Message-State: AOJu0YzAKUX90S2vLYCoNQKfaP5bBVtkF8etCNTO0HK8kmuTTRs7jJQR
 E6QTRB2kEDyEPCN2WOy3j5FH8qrSq7PzSE2ocpDxHRRVnEFHcdVTAuXxtjbqToABA8tLqfQiHXS
 hWqd3Cv4UQ8JDOPeLbfusDlPjf7I=
X-Google-Smtp-Source: AGHT+IEKhOq/ywkWJZckvMl4Nv6dVN8znO54E6I8P8fZgJ8/tpR5W6aFoCHXbrfFVZudt8t9rG0bCXu3g8ocl6ufXTQ=
X-Received: by 2002:a05:6102:3a0b:b0:49b:e62d:b5d4 with SMTP id
 ada2fe7eead31-4a3e6929ef9mr2069719137.21.1727847950509; Tue, 01 Oct 2024
 22:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <70658cf5-4a72-4b83-8390-cb0a3506e6eb@ventanamicro.com>
 <20240926083944.15807-1-evgenii.prokopiev@syntacore.com>
In-Reply-To: <20240926083944.15807-1-evgenii.prokopiev@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 2 Oct 2024 15:45:24 +1000
Message-ID: <CAKmqyKMmYPG0_jyrJFxvnxhTGTCAz4L5Lf6FouZpy3ZtywNiGA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/csr.c: Fix an access to VXSAT
To: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Cc: dbarboza@ventanamicro.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Thu, Sep 26, 2024 at 6:41=E2=80=AFPM Evgenii Prokopiev
<evgenii.prokopiev@syntacore.com> wrote:
>
> The register VXSAT should be RW only to the first bit.
> The remaining bits should be 0.
>
> The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture
>
> The vxsat CSR has a single read-write least-significant bit (vxsat[0])
> that indicates if a fixed-point instruction has had to saturate an output
> value to fit into a destination format. Bits vxsat[XLEN-1:1]
> should be written as zeros.
>
> Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Changes since v1:
>         - Added reviewed-by tag
>  target/riscv/csr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index bd080f92b5..69c41212e9 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -717,7 +717,7 @@ static RISCVException write_vxrm(CPURISCVState *env, =
int csrno,
>  static RISCVException read_vxsat(CPURISCVState *env, int csrno,
>                                   target_ulong *val)
>  {
> -    *val =3D env->vxsat;
> +    *val =3D env->vxsat & BIT(0);
>      return RISCV_EXCP_NONE;
>  }
>
> @@ -727,7 +727,7 @@ static RISCVException write_vxsat(CPURISCVState *env,=
 int csrno,
>  #if !defined(CONFIG_USER_ONLY)
>      env->mstatus |=3D MSTATUS_VS;
>  #endif
> -    env->vxsat =3D val;
> +    env->vxsat =3D val & BIT(0);
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.34.1
>
>

