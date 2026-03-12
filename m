Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43566103E2F5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 00:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Toy-0000Cc-F6; Wed, 11 Mar 2026 20:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Tov-0000Bs-Qi
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:22:34 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0Tou-0001wU-5o
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 20:22:33 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-662a1855af2so638984a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 17:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773274948; cv=none;
 d=google.com; s=arc-20240605;
 b=b9eBMqm4QKDeyNojcYkUgvfbz4BeMG7XGC4+JjQjgEH0ACa+5lG/q+N4APuQyFX0NS
 SETeQJMTKJ62ySGWGeb0vMjDsRYIBnpcP6B7DTRlkZEN5EuElbasEsNmcoiX6N7Em1g0
 uHS8dY8S/3ybpXxM8EhpPsjBqOv1ism1BI8EepyYIuIRjwQBnIYadxpjWDs7p9RZ58WS
 MWRB4Hhzv2FwGcwa8YrVFHBZGJSi5lkE/BZ7TE5uA1XFDVEVIKwKDFKvcx+hByBggFhA
 sVgIsGhqOfOk0beduHao/QVa4jbinLJkeeRoC7/e2e0N6vJEZyAYd3t6zRrzTWeP/OEG
 rdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TDFNOTqxOoHLgwF0z2XnUKsZQ69LGhskHLdeXM7pyPc=;
 fh=JtogSCRbRFCrH42R+QzEg97bVievFnNR/NSHsBDtTBo=;
 b=hZq3B/2JMSoVYOHQs4ffyINUABdhAIHZw4v6pbXlj8Bh8JnETE+qRO/rqEKXTB+zz6
 sbF59zjVZijHtSmYAIMc2G1m6fSDYwdt60Y+XLGAQPGO8uKdZFcCIe7/SOirUBPR7NAU
 N0hlTxmIRDcFgmW0L8MECQo/5FxQYBpK6PCIVoVriZVodWKB8k4x51/Lwk2lUBS1tBZO
 vKN/t/wWXIK84itFi2dXwxRU9MgH4hGMD+D6dK7x6zryAyBJddCRH4TV1DwXjj9S1v6G
 IdhZZWgRMiR77aaA3/G59xs9aOkr1elVruUsrycnv5D4DDNt1u87QO0T8M0wZFPmClPJ
 YQuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773274948; x=1773879748; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDFNOTqxOoHLgwF0z2XnUKsZQ69LGhskHLdeXM7pyPc=;
 b=Vneuwds8L0mbnjCfKe1OaeEEbiL8ZDlD0FXN8+gdzNDFqtPpsB/JMbm+TFZ3jwr9SY
 //drqupgGAsClhn3x09kVTJaJ0fIGAcLV7UlOIpQWCCwBFvPkTSYxsDwDyJkW/9tcPmB
 4bdQ/yqoICd6FVtr9vvrhf5SAbE43lIfJSBTa9asV+hjxycBArDmj7HGm1yqY/nOt+qa
 0dhOgPdkP8rTzAL3hIv4aJn3t1Qs8W2GRt2sAW8fJ+YwUOaMZbGQ8F9YQ/JbixH9ExeN
 g5BjZZeriQCVwepeGiWc48NQxr0bCVL29RndnWLST0RcSXZtzjI10ltVt6dcgHpGI4bm
 m6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773274948; x=1773879748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDFNOTqxOoHLgwF0z2XnUKsZQ69LGhskHLdeXM7pyPc=;
 b=AH49TGuw5yX7jxcFBWOFmgXrFdROYomkJQcakUD2Gg6p5aeEWr4eWsJfv6pWQwUVQR
 nctdlig0sHckzWF5N4BEwg6K+cwRX7+a/QD7zXfEX+rFT8a2EgzVJlT2WZ85jmMEA293
 LmrZBGsqpaKnQu24Uk5EIcttMRqJsHvBsbV803cLGk+RbSBkYKEnLWOQI81rrmwM+Fsj
 bMEL7td+72+EdYCnrJM++Zy4VGVYVJ5b2Z079PzqQ27zJRr4i+IA7xOlIAUqXNtU4syc
 KthUO5IIsyQufQqjVLwtQZ7Jh3L/zJrXpE+Cfrnl8sRbDexfH7j4FtrE772E+ZfRTEN7
 Sp+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrppLzK9S7RGBDnEEZrOxnHSwRvoDXkOR1rs0Jq+naYptpmzXNy/Cg0s8ld7XRDp5NCXJU0QPj5Nld@nongnu.org
X-Gm-Message-State: AOJu0Yypht/d0Atg9T/f6Peu9L2yNdEyWw2mHePWcZ+Xm/zBgnQE1XOj
 9sYfU1E78vfdeFCCvmnL9L5UN9PL22+GNrb8HnWu/La3qGX3H7MyL17J6iZGAqavZoyLjUUaVJ6
 xSPMeSXT4wzotuWTKb4ZDPG2xzWBThYVgMkFZ
X-Gm-Gg: ATEYQzxeXNR+mfmqo6h+3mM8+JDwld0E5aOzfwo5esf5IVk/+q2C/brKC8kNBbKpWN9
 eBhMDTcZqPGr2n3Hdrbm77i49dxPbwoYUVzG7pcqyYhjO1dYqW7466eU5I0CVGIlv/4uvdr6KlD
 WEAFcjWz6PmAwopRBiF5ah1Jc6/Me+zZKgieT2W7Wkh9X7ksm/PolWIk+VxMZh0Qi8z3xZrKzJO
 MRS/9IL/inRJXiAQDsCQ4JfUwbRBeabu2hLjoT8N2FqWKmYYv6Uob4Zjp3FgPVdswDVU+/bS4eK
 Z7lPkRc1C0GhEEvfAv04hRQP2x03WovX7WhdPg==
X-Received: by 2002:a05:6402:5210:b0:659:3fca:24d0 with SMTP id
 4fb4d7f45d1cf-6631a1e0d33mr2540006a12.29.1773274948338; Wed, 11 Mar 2026
 17:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260310151347.67263-1-james.wainwright@lowrisc.org>
In-Reply-To: <20260310151347.67263-1-james.wainwright@lowrisc.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 10:22:02 +1000
X-Gm-Features: AaiRm50ASigwqJPwS8b5tmrxQG2KOPnB4f5lUk1x7nK9xaFxtu5Wquksn-OoQy8
Message-ID: <CAKmqyKOjt0oUf66sOmj16MzTO=3Ry7TZZo5tDn_LW3ffSyeFgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv: add unratified RISC-V Zbr0p93 ext
To: James Wainwright <james.wainwright@lowrisc.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, FUZZY_PRICES=2.311, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 1:15=E2=80=AFAM James Wainwright
<james.wainwright@lowrisc.org> wrote:
>
> Reorganised as a vendor extension for Ibex and renamed to xlrbr (as in
> X-LowRisc-Bitmanip-R, like Zbr).
>
> Apologies for the double-post, I realised right after the last patch that=
 this
> name would be better. Please disregard v2.
>
> James Wainwright (3):
>   util: export CRC32[C] lookup tables
>   target/riscv: add draft RISC-V Zbr ext as xbr0p93
>   disas: diassemble RISC-V Zbr0p93 instructions

Looks good but you didn't change the names in the commit titles,
probably worth updating those as well

Alistair

>
>  MAINTAINERS                               |  5 +-
>  disas/meson.build                         |  3 +-
>  disas/riscv-xlrbr.c                       | 79 +++++++++++++++++++++
>  disas/riscv-xlrbr.h                       | 19 +++++
>  disas/riscv.c                             |  2 +
>  include/qemu/crc32.h                      | 18 +++++
>  include/qemu/crc32c.h                     |  1 +
>  target/riscv/bitmanip_helper.c            | 20 ++++++
>  target/riscv/cpu.c                        |  4 +-
>  target/riscv/cpu_cfg.h                    |  1 +
>  target/riscv/cpu_cfg_fields.h.inc         |  1 +
>  target/riscv/helper.h                     |  2 +
>  target/riscv/insn_trans/trans_xlrbr.c.inc | 45 ++++++++++++
>  target/riscv/meson.build                  |  1 +
>  target/riscv/translate.c                  |  3 +
>  target/riscv/xlrbr.decode                 | 30 ++++++++
>  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
>  tests/tcg/riscv64/test-crc32.S            | 64 +++++++++++++++++
>  util/crc32.c                              | 85 +++++++++++++++++++++++
>  util/crc32c.c                             |  4 +-
>  util/meson.build                          |  1 +
>  21 files changed, 388 insertions(+), 5 deletions(-)
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

