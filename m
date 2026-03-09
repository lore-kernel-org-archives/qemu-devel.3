Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4620EA8554
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 04:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSay-0007bi-Bs; Mon, 09 Mar 2026 00:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSax-0007bR-O1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:51:55 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSav-0005iK-Fk
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:51:55 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-660a293515fso10911594a12.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 21:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773031912; cv=none;
 d=google.com; s=arc-20240605;
 b=RFQPLqS7Jhl0BUOzLQqq7PtQlTHXQV4CHgOIu7+xVTdKlrSP/oQ/2L9EjMsI0ATht1
 HTl6aSuY5eaSQDaVl1UcAkqMXeucZg1EQS1gst96Emc9zzeG5kxLriDR3a3cbLWCGxLf
 0PY00DL34Na3jWiH1Fpp5391OdCvHveN/Lz1TmzxOq7tZLoOJmnrPfBnGQJhCiuVafEQ
 PG/5kP2RMdHlw+EliT/DKxkwRc2cDZhtiTkjbkQlkhvh9Wf/5EKO/1qQk8BrgBGZX8+Q
 kYh3xIR6XiGtY9PUnYUfXN20t4aE9xXYPdcjYpmdDOrmQnE7gB+AlT72PNFycoItWHgO
 z9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tCLCjWSNTNNqvCClUobMCGNbstEOnAljmP9KrfieV1g=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=LosDyMNhuBZEoimIg/Zm8u6TUISGFfQqi5GeW51MpXIDud9qJdPoIc0lAi3SW2dlIn
 luMswjYu1JMgdGjQaTV+Ef3trE4wDy9H4zdq9gEnySk042zww/ab8hNEUJNNAwjXwkr4
 pZITsEn73kuh2uIbEAb96Rr2wEzlll4nsBc/VLVSf3jE5Gf6o6cYqeJGEzxT/P7s/KRu
 leUdg8qkxfbtjIGjvXt3xIpooWXLA1Y8OeoJVNMEmfth0WXTBCgkE5PbIZy8vthdhFYS
 DVSGPGmhoy6+DXyVZopSeGpPg+qUG7Zmknb8FaK9CM3YjUIkHXGsasOgXa8S7hOX/DPT
 tvzQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773031912; x=1773636712; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCLCjWSNTNNqvCClUobMCGNbstEOnAljmP9KrfieV1g=;
 b=DNwDT5x4dTkT0UkogQtroYwcPO6hkFpXU1itk+UtDR6tzy6g4zicrMReq8lW5zmVis
 wtdF6z3w9RpHlgkpyQSqP7B1uRw6ypzznZr/+y5CODdqJBhi/rlyEKbsFRHO1qtazNOZ
 bfdy23ysdvr0IpKtjWIv/0FL8QBrqOl29YuDX0YcL2/98uj8rHcHjukVmcwZpq/mQTXq
 PtO38sANdbriLZu4PWBbJJxPhfovFaYnioQF/I7OLvcV8hdDDIfA3fyyzcF0H/MH+pbM
 /wkheKJ4634G+ElgpXo8frDsqX+2aOuwSMK9inAOZncfIWRG0gcglmH4zWCLaWbtI8sg
 NEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773031912; x=1773636712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tCLCjWSNTNNqvCClUobMCGNbstEOnAljmP9KrfieV1g=;
 b=eulI2VuCqIkz7g7HStWSDSO6soq8CTKU1aaztqRr56gXWXFmTj6lSpdlul4fQ6jJyH
 k/5CMC0ZFRPq8q1pq3u+lHxj+YTigkFCNX+SeCugYiR9SW6WlGwU1wbVAZbFn/axYObB
 UOLETFgsdcQY/CbO7BjewYVXQGxwf0JK3TW5Zlj4d4+H/CZ8uYFejVxQdOq54ts/6kby
 SCBaYzxPD4IUEJTau2ZdNzFmzF61AyZvS1kp04jhvW4eznbM6UabicXjsMsIYixsMlmk
 4F+LjzozcO1OMYxBZljozvZ1YKczw+2T76DLeRY5xVneqEHW8MRkOL2YAOJ6gPgPkBSq
 AlTw==
X-Gm-Message-State: AOJu0Ywlv6RzhgUxi9M/nd7xye8HSpF7tv9PQUT4HVy/THOmblmajktC
 5jLqignRfsKDP5A51DCbJZ0JLW0Or5IZD0kAmaG4MLtVgkAGsIxQOoONDrmeP47b0b0dhVzZGFd
 mm7MQ5y0Y5fa7kOJJpJebj0FIIZ8+vKg=
X-Gm-Gg: ATEYQzy0zN9McOSqf/hBvxh7w89Onl6V3/peokdY2C8fJCvQDvuedKI+gPMVILolGz/
 kr22+NtJ+YkKymF+IqGTqbCrsvR7kPT5zHinwh34CLWVIn/RQC1cQXzdL6fKcCV/DkoKyDijSpk
 1hAYrosL6hB6NWsVlftNUcmkF3T+njfP16aJ6nuDGT5NQ1rA9HKoNpUaEUV/CHn9NJv7vvs+DAT
 XChU8kY0beFtUx0hULrRfZ7dSEb1TAxS+tG3fY6Vm1BozQcOOHqq1HFAYiHPnRR464J+OoDyOuc
 61ZZNhkzClwZRoO6kpyoduUR1uJlmhJ0TrBQYw==
X-Received: by 2002:a05:6402:4303:b0:65a:3526:50e0 with SMTP id
 4fb4d7f45d1cf-6619d4ff435mr4752649a12.30.1773031911557; Sun, 08 Mar 2026
 21:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 14:51:24 +1000
X-Gm-Features: AaiRm50IZz7mfAux6OxIOThyFpTmWtzKAqWvROgITowtjvo9LgTrwHnJ30TuJME
Message-ID: <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
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

On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> This patch series adds support for the RISC-V Zvfbfa extension, which
> provides additional BF16 vector compute support.
>
> The isa spec of Zvfbfa extension is not ratified yet, so this patch
> series is based on the latest draft of the spec (v0.1) and make the
> Zvfbfa extension as an experimental extension.

It's not only not ratified, there isn't even a draft spec. A personal
GitHub repo without any tags or releases is not enough for us to take
this unfortunately.

>
> The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
> bit position 8.
> The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
>
> Specification:
> https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc

Overall this looks ok. Once a draft spec is released we can apply it

Alistair

>
> Changes in v5:
> - Fix typo in patch 1/5/8
> - Remove unnecessary do_bf16_nanbox
>
> Changes in v4:
> - Rebase on riscv-to-apply.next (commit 21101a7)
> - Update commit message of patch 2 (target/riscv: Add the Zvfbfa
>   extension implied rule)
> - Update checking flow of illegal ALTFMT SEW patterns at patch 3
>   (target/riscv: rvv: Add new VTYPE CSR field - altfmt)
>
> Changes in v3:
> - Rebased on riscv-to-apply.next (commit f66f234)
> - Fix typo in v2 patch 5 commit message
>
> Changes from v2:
> - Removed RFC designation from the series
> - Updated commit message for patch 3 (VTYPE CSR field -
>   altfmt) to clearly explain:
>   * VEDIV field removal (bits 8-9) since EDIV extension is not
>     planned to be part of the base V extension
>   * ALTFMT field addition at bit 8
>   * RESERVED field change from bit 10 to bit 9
> - Added new patch 4: Introduce reset_ill_vtype helper function to
>   consolidate illegal vtype CSR reset logic
>
> v4: <20260304132514.2889449-1-max.chou@sifive.com>
> v3: <20260127014227.406653-1-max.chou@sifive.com>
> v2: <20260108132631.9429-1-max.chou@sifive.com>
> v1: <20250915084037.1816893-1-max.chou@sifive.com>
>
> rnax
>
>
> Max Chou (9):
>   target/riscv: Add cfg properties for Zvfbfa extensions
>   target/riscv: Add the Zvfbfa extension implied rule
>   target/riscv: rvv: Add new VTYPE CSR field - altfmt
>   target/riscv: rvv: Introduce reset_ill_vtype to reset illegal vtype
>     CSR
>   target/riscv: Use the tb->cs_base as the extend tb flags
>   target/riscv: Introduce altfmt into DisasContext
>   target/riscv: Introduce BF16 canonical NaN for Zvfbfa extension
>   target/riscv: rvv: Support Zvfbfa vector bf16 operations
>   target/riscv: Expose Zvfbfa extension as an experimental cpu property
>
>  include/exec/translation-block.h        |   1 +
>  target/riscv/cpu.c                      |  15 +-
>  target/riscv/cpu.h                      |   7 +-
>  target/riscv/cpu_cfg_fields.h.inc       |   1 +
>  target/riscv/helper.h                   |  60 ++
>  target/riscv/insn_trans/trans_rvv.c.inc | 988 +++++++++++++++---------
>  target/riscv/internals.h                |   1 +
>  target/riscv/tcg/tcg-cpu.c              |  15 +-
>  target/riscv/translate.c                |  11 +
>  target/riscv/vector_helper.c            | 389 +++++++++-
>  10 files changed, 1088 insertions(+), 400 deletions(-)
>
> --
> 2.52.0
>
>

