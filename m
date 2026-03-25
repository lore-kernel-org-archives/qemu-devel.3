Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2CB103A999
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DwY-0007ho-Bn; Tue, 24 Mar 2026 22:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DwH-0007fX-EY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:25:51 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DwF-0000Go-KK
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:25:45 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-667acaeae82so9462870a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774405541; cv=none;
 d=google.com; s=arc-20240605;
 b=TiQ+wj50DmfborPXO2+iCpwXykosO/kEZAGuATBKkc/g/jo1yC/yDXkufuD10jSDfw
 Z8x3dQ496zP/aLhjRSZmipvMyQL50W8fPdRNbs0a52nDB/jIHvABP1+LxoNJnYI4GS0r
 aOdkDdXGMX3HhVbZPvMu+/clhvZBvSe6VLgK4ajmdXAB90B1CthZyTWsz1SMLijvDqTb
 +9m0HIqygVBg047zBbPV1b0RL3ruK/EZ5ZMgB/QtmNlOlvKipXoxH9PvoK+4jQpGsHPk
 ZpJvR+6l+fZC/uTT6BxVrGmAQba/ETmAWt85a5shQ63tsLL8RzdOYhRt8TLebWN+t2mt
 acRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tr17RtyvbLxS1/0zRk7inMx/sws3cdzrQAORYOvU5AI=;
 fh=Goub7LZgbm1v+svGrOo2k7EYKDHZ2ljEK1F5ta1PeDg=;
 b=KPO/q4pznn1uBjn16Q1VhWPc3IOPd6SV1QqsD8t824kVXw1I9LEjfz9Yy9MlYsbJf5
 CrTT8U0HB6FUlJRQTEwr6dT6A7uvFcwey3bksRl5AXc8B2fgxBWhhhz2XgJHD9IBnvgs
 2Nk99zbKj5EmPs4wr6kqSDN8miA07XsFwJclpRyAIy4HKIFKyNLL1/EcJX79ahomojwD
 ZzwY3Sf+AqTasWZ7rURLbn+gkCcx+Bmz2d18tCJvUMHeSN7CfHG4p21Zj+HXnuiU5Xcr
 GRxUqJfxhbUCcdc6v5LgiQwXzugUxmNSzLYilao1Y5osHI3bH7O5HWOM3BbY4ON68A8s
 JRXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774405541; x=1775010341; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr17RtyvbLxS1/0zRk7inMx/sws3cdzrQAORYOvU5AI=;
 b=tH70NNMPwGak7o+F1/OIeBHobq4gBFBRBkEIvLx5hl2l4eiCqyALCUhMBBo7ebOm3I
 DW8qxg4SHBGykoxi/U6P6tN0E/wpat7yxelbHxBVUJFZ6ZS634bzUVNq7IhcpAZJX6wH
 OR4NupPK+m2C0iPT1PJXZD8p2I7Yj+/cmnXB5dvRaE5uwaSU521N0tfL7nlQfZhZrXTs
 JJoWz+XnXw4zgYB8USrTB1//bKKvMT3hnDQJqTCAhWUc2Rh61KSPWWuzUs4NesU7DslJ
 4jbGYwZD32/4kAjlzYWWeb2BYcmQ2i3jg7gTnVsHiEi7+HQLIR91bppceSnL7x5vi3Wy
 IGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405541; x=1775010341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tr17RtyvbLxS1/0zRk7inMx/sws3cdzrQAORYOvU5AI=;
 b=saxpk195dtj6KUMwg4wf9Ish2C6t6zmETR8xIUpydEuaQvAxb3VVKhWvsYRqVL6swT
 wp+orQWiZQejjt7Wds+WtX6du52DSf6FDBou//HgOsx0iVBgH9SgMFRjjXdVLGb7JV7p
 KtozySLJxkFVWT8MYkTE+4liCg3I5SL+PON+1bSQ64zHVINGFvZG76tyTWvnOHEZZnyE
 bE8FENI0cwJ17T0sw0s7E4sGS8FH7oYolOr1/OJa+2xaiOxgXyRuvVVN353aumzQW/KG
 QdME6WxLBa9zTytOZuLZEXUblLtn6XjXT0yzAC82Rg8c/8rhF21OpbU6/1hSAld9WgPb
 TOhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqBFtuYBj5N6pf9iI9k6qlvlKb1pcOhSJSyeU9sFjXRWRGs/DkyB0IELAQtMKlRmhwWY78Nz086qaC@nongnu.org
X-Gm-Message-State: AOJu0YyiUGubBC7PWCqJeq6ThWOTGFjGMZTV7wNHXyPOqRyHxLmRv3Bh
 spd1watCmpipp7b9jA8rBUp0tCBQSTnJD1jC/Ke1G6iE7ndN1BVBbJYpuP/BeCYDwHq7EagRr7Y
 poRJ2hwIlB2hkDH6rRvotQrwmK4zdiEI=
X-Gm-Gg: ATEYQzyK2ZYo6srUziC7++ciNW6Vj9RCkcZ3rgdqgwcVkNjKNrvrPqFqYq0wilBvLJP
 RC13HTnJuAbthkxUS7qLukzL8ONqELQww3FI1NNXIHVT3Gpk4ucgFAJgFABNJ74QAeLD5qF/Uss
 QOw4z7Wj4PEIb9nimhJ5njd1GHQrTxArS2MfHqgkVD15fmdnTIg7AcAOK/29y1iIFL2P0f8w0S/
 CaeXvr2duIgVCWzdewA/En9vasVExdmtxSgIhRzuRKrjFiOXvEjrW14JCrb9Q4+fizm70aKmDeN
 Tiqr3M3IGJU6rRo2VXhweda6uDKjJsbWHW0R9da7wqONrZck
X-Received: by 2002:a17:906:a8d:b0:b98:86b9:f0cd with SMTP id
 a640c23a62f3a-b9a542c7072mr84965366b.54.1774405540861; Tue, 24 Mar 2026
 19:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260320134254.217123-1-james.wainwright@lowrisc.org>
In-Reply-To: <20260320134254.217123-1-james.wainwright@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 12:25:14 +1000
X-Gm-Features: AQROBzCdQozVb5Ay3GxBiCfaxy9Ub88-7Rq1q-TMNhIN98mSMDydAzSN939B6bQ
Message-ID: <CAKmqyKNTm51Gx4TEL_3nm+8K=mZa8pMfnL1PA9kcqHpq0Uw=ug@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] target/riscv: add draft RISC-V Zbr ext as xbr0p93
To: James Wainwright <james.wainwright@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Fri, Mar 20, 2026 at 11:44=E2=80=AFPM James Wainwright
<james.wainwright@lowrisc.org> wrote:
>
> >  This patch fails checkpatch:
>
> Oops, sorry about that. Fixed the license header but the original
> `crc32c` file didn't have a `MAINTAINER` so I haven't assigned one to
> this new file either. I hope that's okay.
>
> > Please keep previous tags in new versions
>
> Do you mean the `Reviewed-by` lines? I've kept those in this series.
>
> James Wainwright (3):
>   util: export CRC32[C] lookup tables
>   target/riscv: add draft RISC-V Zbr ext as xbr0p93
>   disas: diassemble RISC-V xlrbr (crc32) instructions

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  MAINTAINERS                               |  5 +-
>  disas/meson.build                         |  3 +-
>  disas/riscv-xlrbr.c                       | 79 ++++++++++++++++++++++
>  disas/riscv-xlrbr.h                       | 19 ++++++
>  disas/riscv.c                             |  2 +
>  include/qemu/crc32.h                      | 14 ++++
>  include/qemu/crc32c.h                     |  1 +
>  target/riscv/bitmanip_helper.c            | 20 ++++++
>  target/riscv/cpu.c                        |  4 +-
>  target/riscv/cpu_cfg.h                    |  1 +
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/helper.h                     |  2 +
>  target/riscv/insn_trans/trans_xlrbr.c.inc | 45 +++++++++++++
>  target/riscv/meson.build                  |  1 +
>  target/riscv/translate.c                  |  3 +
>  target/riscv/xlrbr.decode                 | 30 +++++++++
>  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
>  tests/tcg/riscv64/test-crc32.S            | 64 ++++++++++++++++++
>  util/crc32.c                              | 81 +++++++++++++++++++++++
>  util/crc32c.c                             |  4 +-
>  util/meson.build                          |  1 +
>  21 files changed, 380 insertions(+), 5 deletions(-)
>  create mode 100644 disas/riscv-xlrbr.c
>  create mode 100644 disas/riscv-xlrbr.h
>  create mode 100644 include/qemu/crc32.h
>  create mode 100644 target/riscv/insn_trans/trans_xlrbr.c.inc
>  create mode 100644 target/riscv/xlrbr.decode
>  create mode 100644 tests/tcg/riscv64/test-crc32.S
>  create mode 100644 util/crc32.c
>
> --
> 2.48.1
>
>

