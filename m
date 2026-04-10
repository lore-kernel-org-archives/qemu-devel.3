Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D1BF36BA6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 03:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB2Uw-00033D-OL; Thu, 09 Apr 2026 23:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2Uu-00032k-SO
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:25:32 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB2Ut-0006x8-6A
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 23:25:32 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so277035866b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775791529; cv=none;
 d=google.com; s=arc-20240605;
 b=Ro6MRreMe/stEnDRZ+76JR+xnMPM5vyEc+p92Kdwc9sGjeU2ldAwaozEbTFjeakU5F
 BkhjeNneXQdxOxpwmHyk8WyXaKTPF7AVGYieqwrxCjaF0zXi/v1Z9xsFMb0J1UuuJg4O
 lHo8a4xvgOSDexaC/55IWWWeQN1/oi2EatxFasnH8FMHZINEJpx/NIPw5p1OawXvPILw
 M+Au6kwBZMMQPJzprKqRU01EiU/BoS3Q4kjNl9Ut0NEYjIqjtq5kn3M6cLXncr326U/J
 Z18+amsEMwy5f92CqNxTmoejrWbe2/Bya5WKu93HoURsEzS9U+bkIEHEQ3+GuIHLiiVi
 Kuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zVr30i1/eTqTL3hpJAo7nJYoXQEcAh+382n4cuVjM8c=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=RevOG30QoqJhmvOghi4fCJVtJ5z2tjUNU65JuXK9VB70wv3MDK1MyPOIaOzWMP840I
 PblOCC3e0wYgM8XpKoY4SwQAyo8YWXR1w8q5KaRW2l3HcjBe3WyR3nK6i9tzuW+ci7qi
 dyvEfLcDWvu6QOUgbJsYiuV9KNJ8kcGIcsVtBgtQIXdDUgRssneKWyu45Aqq0ywpv1r4
 rKAno+FtI6rFWOvHaFvuCDyb9QHodebzxWN32dwS2lP0w0zuLQZpjAReGKTx3hySSQek
 gg6dKDPdtg52ycCaCvvEX2OkfEp1h1nJ8c5QbMxgwbJeC8izrv4RwnpUwa4QNmjbl2e6
 1Szg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775791529; x=1776396329; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVr30i1/eTqTL3hpJAo7nJYoXQEcAh+382n4cuVjM8c=;
 b=NE8CdIWToN5icfG50FYlaQiXCkfgqS3vHOrOCo/Kl0Bwn+LvEu4+h8ponu7w84LuCp
 SivCBlTXuAAZvUEECk535D8VJb/H7UD2Mo8R2ZbriC1juFarhT+5lUx59yQLoX6S+zAG
 Hhk2FBV/kqH+LPX056HNKLuUOZ07jUTecD9r0ZBu4QxX2Lx030A3dmqSml+AzVwE9Rx4
 iNg34JYcE8Bqfh6Zyk0BEmQH9iljXo8WD2B4T2uSgYF/phzamJnlQ18f1hGD7aNT3SgP
 lbL65IQ7D7wW9WP8+i+PO8leBng3n3uakLeE1C9qc08HeYtDLNgvBeDzRSX1Qr60bIIY
 974A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775791529; x=1776396329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zVr30i1/eTqTL3hpJAo7nJYoXQEcAh+382n4cuVjM8c=;
 b=r/11ccigA3/MEiAGxtBNjLzXyG3f15WDhQzf1hnpea5IS7PkbqLHaCtrGMrcgKtPsq
 bYfSjtKWufAtAx58bmVl+cWYt9msec1GYBIbXwI5Br0bHGlWdgWKImGBn2cAfA7okELY
 TrgzvzkCW5LgtuXVVaOSb+a1D6F1QwwB1z14qvBuTLVfM2vSlLXXpnvDTg0+gbj2pGWS
 gVKQBPxF33MJOJlsAlmcKZwy95g2xHXYZrRCTpk4Uk4HDWDcwyjtR3uhlu2rkSdsElXg
 miBOpEAAQXBF2AaRWG58aDO3m4NZdmxTuHt58+OBDP7gReQf+cIiFZVvElkg9Z1KeDXL
 XWSQ==
X-Gm-Message-State: AOJu0YzJg1NQDM/pJHk6SgHK+vjAF6+HAzuMgKvv34M/nhmrF0AwdEB+
 wjWFxMchtJfumN3doRbe1/ReWND4ZoDVbo2YVkazkTrJXQrqeZ//S+0umBBxmF9azKrRkkD18JQ
 Q0T/cMH/mdc4cGy2WaxgOX7z5g4hWwCE=
X-Gm-Gg: AeBDieu3EYkiEMiRf3bbAe5Ph+a5wKKtIWqQcxZ8hEfuEVfUeL+0OFBV6LhKxPV1Th/
 HklNa7PaPiTrCPbxHLBwm21lAw0jESrg/tltmefR0tXyXlXtvHsyQNeSABHrsbbR8mecoBo+ULi
 jg0LtAroeUNmjGBStjzDzgbu86Hdqt7FSfjorIl3JHuMuAtTezep3QXtUGE25qf4nEVwE71uMF+
 iDKDYCi8lGR4blf30lwq/FRCbQveGK27QupmZ/JMjL2dVrdzE0EA/eS3N0F2EZYnfeqtqWfbLUE
 51Ein2/qL66ETt1IdDhKESAQshTvzqbHY5qyUg==
X-Received: by 2002:a17:907:7b93:b0:b9d:166f:ff82 with SMTP id
 a640c23a62f3a-b9d7243ee78mr80324666b.6.1775791528534; Thu, 09 Apr 2026
 20:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260402125234.1371897-1-max.chou@sifive.com>
In-Reply-To: <20260402125234.1371897-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 13:25:02 +1000
X-Gm-Features: AQROBzBGG14qawWPI27eYzGYD00-L67phPBckcOwb8PXlUhwAddjoVgPByy9lxM
Message-ID: <CAKmqyKMWtBwJzzG5yqDoyycoR6uJz-_4iS8ZRnk5CBAkd1o6Pw@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Add Zvfbfa extension support
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Thu, Apr 2, 2026 at 11:50=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> This patch series adds support for the RISC-V Zvfbfa extension, which
> provides additional BF16 vector compute support.
>
> The isa spec of Zvfbfa extension is not ratified yet, but is frozen
> (v0.9) with a tag in official riscv-isa-manual repository.
> This patch series is based on the latest frozen draft of the Zvfbfa
> spec v0.9.
>
> The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
> bit position 8.
> The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
>
> Specification:
> https://github.com/riscv/riscv-isa-manual/releases/tag/zvfbfa-0.9
>
> Changes in v6:
> - Remove the experimental `x-` prefix in cpu property.
> - Rebase to latest riscv-to-apply.next branch (commit 479e3e4)
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
>   target/riscv: Expose Zvfbfa extension as a cpu property

Thanks!

Applied to riscv-to-apply.next

Alistair

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

