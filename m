Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A513C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7u2m-0003KZ-Ho; Thu, 24 Apr 2025 06:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u2i-0003Jv-O0; Thu, 24 Apr 2025 06:42:56 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u2e-0008VM-UZ; Thu, 24 Apr 2025 06:42:54 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-525da75d902so360622e0c.3; 
 Thu, 24 Apr 2025 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745491370; x=1746096170; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewStN/FpWrHozV0hvOiiRFxLwA0Nw0l72Tx+cR9UVGs=;
 b=YDl9Uymemr93Op+4XYuERKCui81NSGXJ413T81Vzzxqx7c3qfLyXD2iwrKkdu/ZJ61
 b82evF518nMQcvO9vckjyW0o80Wbds4+zKDUjauJqRMRuwZ2OxFQWNjGywj0T5YuNXvP
 1xosnI3jRfC9m6iRsPNlA6BFi1WxFJw1CkHG5Ts1z3SxYHHYo/Abpj/FjIXfVSkD0hIg
 YLycvt0h+1ozPpkaCUJ0t5Vs+7oL/zObVwe8e6R8qJJDLwtKbxgSo4Ihb3fC7birhh+y
 8JpG0GZGmYRT2ZAZJ7OSj6baMJG1GGTERzXErrKUGzHzEPmIG4ww+0t2k7bBAFPQuDq7
 Msow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745491370; x=1746096170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewStN/FpWrHozV0hvOiiRFxLwA0Nw0l72Tx+cR9UVGs=;
 b=hCy1iuL7icLVJsXX+IZXtF+rGHgVLD+dP8VK/ZVUttPThy+36UhIrTbhhiJ8ActP1g
 2G3eVXWWBkcqua5xS+79+ruPYCd9mjzmztMTsxpFGwZESnnIUco6Ijs1c1dDar04i/VM
 tSL1sLOrz/JFnC4dbxAfb9hlD+bjQdJ8OW4xdPQBeM+WKitvRofpPn68g6TCu8i4eonD
 RXbCtIbjeB2mY8cHMqwo+0cfJgX2RRJLZPhlwJKjPq34PDKnppXEl49y/6y89bvx8qZ7
 FYFJLwO4DBB+3lkDRNL1d9JGwYtCB3VHdDN+i3/fR/8WoZFoZm+c0Df8qGSfJEFTtQfe
 mBnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULe9CLDhCa3jb00gIJtNXkYovoCGZcrkA+doGN1p+toUfTtMVyvvniflbOrqqJJOjc5zL2yIEbmwO8@nongnu.org
X-Gm-Message-State: AOJu0Yy7l24wFw15qW3gNSkN9h13TbK2VAOtVFjv/nHbP1nuxYWxnuDf
 ZXFkLjp9wQygTBsLQGz27GhLk031isHTH5H6OcfiBHcSq7An5xFr1UpLV9mOh3b4zVug0/96XTK
 iVSI23pOFGpA9uCtYHxXaqgnOfUA=
X-Gm-Gg: ASbGnctj15AbeeGkPET0A0b9ArhSkuEV4GO4vngVMQK6FUtUiDQ2k04LHubz9gQsecV
 oRHEzWIgXwh8GaG/svFcUEmvvCw6rMhRcZzpNJxVMr1Ohg+OKB/K3QOjefSO26KrBulzx67Z9Ee
 5qvvCAqOIdjEYOAuakqsr0R9dbXZ243qupmotAkIjrWecSlU/aID6b
X-Google-Smtp-Source: AGHT+IHq8DOnZUcHX1qAEXV80NdDOWo7PbqEXTt6Zb/lYwbcxutVwjf6i/Eo8U6TIALFZDgdFY95rftZ7sX6adGZfIg=
X-Received: by 2002:a05:6122:2494:b0:52a:791f:7e20 with SMTP id
 71dfb90a1353d-52a791f7e4emr940013e0c.4.1745491370174; Thu, 24 Apr 2025
 03:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250408103938.3623486-1-max.chou@sifive.com>
In-Reply-To: <20250408103938.3623486-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:42:24 +1000
X-Gm-Features: ATxdqUG_CEeB278KCSGCnHrf1oyO-3e8np-i1R9E4njrhjciUVVO3oaoI9_b7KQ
Message-ID: <CAKmqyKMWm1MxA_e57CKnndR7zywy3yVsZdXSOA8=_nUVMwoLSg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Fix RVV encoding corner cases
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, antonb@tenstorrent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Tue, Apr 8, 2025 at 8:40=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> This patch series fixes several corner cases of RISC-V vector
> instruction's encoding constraints.
>
> This v3 series addresses:
> - Merge v2 patches (3 & 4, 9 & 10)
> - Remove extra blank line in v2 patch 5
> - Remove redundant co-authored-by tags
>
> Thank for Daniel Henrique Barboza's suggestions and review.
>
> Anton Blanchard (2):
>   target/riscv: rvv: Source vector registers cannot overlap mask
>     register
>   target/riscv: rvv: Add CHECK arg to GEN_OPFVF_WIDEN_TRANS
>
> Max Chou (8):
>   target/riscv: rvv: Apply vext_check_input_eew to vrgather instructions
>     to check mismatched input EEWs encoding constraint
>   target/riscv: rvv: Apply vext_check_input_eew to
>     OPIVI/OPIVX/OPFVF(vext_check_ss) instructions
>   target/riscv: rvv: Apply vext_check_input_eew to
>     OPIVV/OPFVV(vext_check_sss) instructions
>   target/riscv: rvv: Apply vext_check_input_eew to vector slide
>     instructions(OPIVI/OPIVX)
>   target/riscv: rvv: Apply vext_check_input_eew to vector integer
>     extension instructions(OPMVV)
>   target/riscv: rvv: Apply vext_check_input_eew to vector narrow/widen
>     instructions
>   target/riscv: rvv: Apply vext_check_input_eew to vector indexed
>     load/store instructions
>   target/riscv: Fix the rvv reserved encoding of unmasked instructions

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn32.decode                 |  18 +--
>  target/riscv/insn_trans/trans_rvbf16.c.inc |   9 +-
>  target/riscv/insn_trans/trans_rvv.c.inc    | 166 +++++++++++++++++----
>  3 files changed, 153 insertions(+), 40 deletions(-)
>
> --
> 2.43.0
>
>

