Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6302CCED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 00:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxy3e-0002ux-63; Mon, 07 Oct 2024 20:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxy3c-0002uj-NT; Mon, 07 Oct 2024 20:26:33 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sxy3a-0003Po-TR; Mon, 07 Oct 2024 20:26:32 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5094a6123e4so1679467e0c.0; 
 Mon, 07 Oct 2024 17:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728347189; x=1728951989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrmEL/uDoic+8r8fG+qRB6VAaArxtoE9o9NaKY0xk5Y=;
 b=g8TRULRhd84TDZIckGrRlYvY6xKhTEwzRfI7T97e3dXqCIxYmKajL9Jwav0JyxmvoZ
 iosDMm7s4/kaclqwPM0SnTCy5OamzwlA/1fcjUwwA/V1N9kdVhHdzRNHq6gpJj4GfRiO
 N7mAtJJWM3+yFmLtG45RihBQz0XEP+Edv5EQFi3jnpUPpOyd0f0A1E1R6zDGap28NfIW
 Cq5tUwk3G/87XW0td+imPZnf3iagMjTbV/KUWYcekkUrmW7+ghPV+3jrP0hZsDu6nqaq
 9qOWdmkrjw4iHwALn6RfzPC1y5fiKBxaTYF97cWRPT429t2/ve3ijGj2MplmKCBVfbpr
 jC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728347189; x=1728951989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrmEL/uDoic+8r8fG+qRB6VAaArxtoE9o9NaKY0xk5Y=;
 b=Y6bZcV8p62bm4LuV/qZqPzN5XJtDUJmw2hsjqSRQbIv+/zYJaUXgKZqbdhncY/ayoK
 cio3dAiUgmxDKAku7L6WCxq/jkfERLf5HA1GmLbF/MkGB6NijHSV9U3Gdl+bObgOPt5v
 JJs5J7r0LHLP7xA8P/7bmyqQTXW3WX2AI8pVq1vx5AdpxdXtTULaB9hAP8Vky/PQBQGz
 eAU8t4/AD5wja73etDXJ9myAMDDQqzXmDKnUb9LD5GulGG9K57aDBARNypNgXyXmjMr7
 6zytc3BBGYk2IjyTVSLpKWkd6JF83DK7bpbyciuAsw0fkrkQEnV1vUftwnkYkOKBtrIj
 kiLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTVlQW4sxj1a+45XawaouuXOnyW8P/LeLCt6JBQkkTcJZS4+JNnIf/g16VM3WmfNIA73H2bWjOEnUHuw==@nongnu.org,
 AJvYcCXLqhuKe59xZ/UFMt1D8wI4WQwSLaorX5EiPnlJkvMqDohjP2ntND3Q+RDqk8GdOOtL2iNCZQfBDYoo@nongnu.org
X-Gm-Message-State: AOJu0YwIpTrChspZBC4agxqn4ZlVspYbGOp6sEukQCCzBjs9R0cD+Ewl
 pz/kf0oxqLAtUC0EKNaQeT8P7iW228nqVUy0GyCHmTG1nElxTLknDiGByl7UiSF7eoMP0Wb6aAU
 0TODKQT6sZXLMUUfarA+nqnvNLWw=
X-Google-Smtp-Source: AGHT+IF1EgmSsTpqxld22ne9b4BxwMYn0A43VdNXWThItCcKdbKnZysuVGS9K2IKMA3S3737sxknLtfui0LmzQuerqg=
X-Received: by 2002:a05:6122:4682:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-50c8555bf07mr8600135e0c.9.1728347188964; Mon, 07 Oct 2024
 17:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMmYPG0_jyrJFxvnxhTGTCAz4L5Lf6FouZpy3ZtywNiGA@mail.gmail.com>
 <20241002084436.89347-1-evgenii.prokopiev@syntacore.com>
 <163e6cfc-755e-487d-8653-a5524876e171@linaro.org>
 <ed5cf837-e397-44b8-b719-5c5b97646d10@syntacore.com>
 <44442707-dbe7-46dc-9039-2d88ec636c23@syntacore.com>
In-Reply-To: <44442707-dbe7-46dc-9039-2d88ec636c23@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Oct 2024 10:26:02 +1000
Message-ID: <CAKmqyKMSkBHsm0s3VZYWqg6QWq2D9g-MKvNh04vuDagDYYgqbg@mail.gmail.com>
Subject: Re: [PATCH v3] target/riscv/csr.c: Fix an access to VXSAT
To: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Fri, Oct 4, 2024 at 11:48=E2=80=AFPM Evgenii Prokopiev
<evgenii.prokopiev@syntacore.com> wrote:
>
>
>
> On 04.10.2024 16:38, Evgenii Prokopiev wrote:
> >
> >
> > On 03.10.2024 23:13, Richard Henderson wrote:
> >> On 10/2/24 01:44, Evgenii Prokopiev wrote:
> >>> The register VXSAT should be RW only to the first bit.
> >>> The remaining bits should be 0.
> >>>
> >>> The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture
> >>>
> >>> The vxsat CSR has a single read-write least-significant bit (vxsat[0]=
)
> >>> that indicates if a fixed-point instruction has had to saturate an
> >>> output
> >>> value to fit into a destination format. Bits vxsat[XLEN-1:1]
> >>> should be written as zeros.
> >>>
> >>> Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
> >>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >>> ---
> >>> Changes since v2:
> >>>      - Added reviewed-by tag
> >>>   target/riscv/csr.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> New versions should not be replies to previous versions.
> >> No need to re-spin *only* to collect tags; tools can do that.
> >>
> > Hi!
> > Thanks for your explanation.
> >>>
> >>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >>> index bd080f92b5..69c41212e9 100644
> >>> --- a/target/riscv/csr.c
> >>> +++ b/target/riscv/csr.c
> >>> @@ -717,7 +717,7 @@ static RISCVException write_vxrm(CPURISCVState
> >>> *env, int csrno,
> >>>   static RISCVException read_vxsat(CPURISCVState *env, int csrno,
> >>>                                    target_ulong *val)
> >>>   {
> >>> -    *val =3D env->vxsat;
> >>> +    *val =3D env->vxsat & BIT(0);
> >>>       return RISCV_EXCP_NONE;
> >>>   }
> >>
> >> Nit: no need to mask on read...
> >>
> >>> @@ -727,7 +727,7 @@ static RISCVException write_vxsat(CPURISCVState
> >>> *env, int csrno,
> >>>   #if !defined(CONFIG_USER_ONLY)
> >>>       env->mstatus |=3D MSTATUS_VS;
> >>>   #endif
> >>> -    env->vxsat =3D val;
> >>> +    env->vxsat =3D val & BIT(0);
> >>>       return RISCV_EXCP_NONE;
> >>>   }
> >>
> >> ... because you know the value is already correct from the write.
> >>
> > Yes, we mask the value when we make a write. But this value could be
> > changed in other places. So I added a mask when reading happens too.
> > If additional verification is not required, I will delete it.

When replying you don't want to add any > characters for your response.

It probably makes sense to not mask the read, if other code changes
the value in the future the guest will probably want to know.

This is fine as is though, in the future the mask can be removed if require=
d

Thanks!

Applied to riscv-to-apply.next

Alistair

> >>
> >> r~
>
> --
> Sincerely,
> Evgenii Prokopiev

