Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D1CFB5EAA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w346U-0003ab-Ll; Wed, 18 Mar 2026 23:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w346S-0003a9-3R
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:31:20 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w346Q-0003vm-Hw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:31:19 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso71349066b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773891076; cv=none;
 d=google.com; s=arc-20240605;
 b=LpMokmEDr0lIXn+STzxFcYrRmelADMUxdVIN0Vk7abVd+YFvbE2tTRQO8XGLUgPd7g
 lnpVAuHFKUHxDjoD+MUVsFpu9HUXGSxEx66SB6ac+QJPwJunYhW2WC7CfeepdE6QvYgq
 zcjUh8aEIPT2Vd8PFlUwoqdkkZ1gj6YfWZmRhymccxJr0wsnl8KW5iQzmLcc4d7ozBbb
 ZT4JWDrNvZRhlyLr6ZCZqcBST69Qpni8co4wEvGeusbwoRLLUetaD3CRiU5vVSw+iZic
 yZ5kPoyhOq0OEvXVfnFGHNWb+wRGUWUJYSuLL2R6n8aAQsixf+tV985Es51X409hsf+q
 4q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hDctJ3QADuLMucwbgtlTjimIZOhz/gMzpUzgCmr2ZB0=;
 fh=XErS4XjkAQDBkClscxjQUC7TY1MVaIkgq5whaEGujtU=;
 b=eDU2DAlznKkD35Y/Xo9bDpLXOieaONJlz8FQ+ydNmnwCcaE5L0THMA0kZdGjorNgF9
 LuM7nL+FMzA7c9SraQ8tAYWFLsca8IljEj7h/V4ZM2yGfWSzfJW7UFlXvWJE7wp9hxW2
 CbXRqdphaKrOSe+ifn5z0uS8thQ9EyVy3ARW7rTB3RaA3bmfXoEgsjaF9uOPqNtUZJfN
 xmrSdGu+vtIr5GTEv/BmUGQxVpKyzt548J5sBi9J2QvbBOn3NmLz61O5DqZ2bIasIQEy
 fmPWgfMiYgiv8x2LcT0wQfG7ql0siZlC/Kp1uYJDY1NXfEurNv19jn4SJWVlbq3MR4sr
 oVIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773891076; x=1774495876; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDctJ3QADuLMucwbgtlTjimIZOhz/gMzpUzgCmr2ZB0=;
 b=nUqeyylU42+uZi5tlCG7HeusoyGP8d7+vybgRCHDEJMHZZN2LptCvhoRqHJvZbDrOP
 dDaahOS1lBK9lCbMISFj521bIHeItDvdN7yrKOj74Jx3P+ag/i/zN94YovHwySnZPZCU
 da5zPZPnzfDvA+kl82u6zXL4HzONZLtb7xYMwmcK+w4XJJXe329xqFwLtrsVHYkSo7vr
 Rdbg2YP5mh3+gj+KV2mWZ0AyxjebUycjaULvWKrvD3FBqmwEZ5wAixWafXRh3xmKUoHa
 LUEC1TJyw9T9hDdUy+5xVFc7wg+0egdnZNkxzCgI71y5VyeyrQ0cWm64XwWXFi/LHDDu
 X1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773891076; x=1774495876;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hDctJ3QADuLMucwbgtlTjimIZOhz/gMzpUzgCmr2ZB0=;
 b=dEfLMlo2y/FfJnaDvZ1/Uas+Ye86tFQrEqAfbdmF2x62uZmp9CMJJHv784SXCW+6Po
 H63VDowg6NLx2k+Wlz8bfTWOEHrL2X6mLLnon+Xc+vMmtUrXdvstJSru7BWvYMBX6yqR
 Lwgr+mvm+pdOdsrJS+Fa0RCUCBSqXaNBDdWGKWPiw73gjAPwmw74H99Ful0GHC2GTcDI
 TcF9qxmuQpH+sA2LJL4KYz2LSmlb/10qWeqU3yBbR8ondqTnmIKwUda6U+LSENZOFHYY
 bXcXkz4hsrbUCw2I7xrTVG+PuGcbhlovTkSWnt+vMgaOqpE1ZyuOuQ4QGkKAPdcx5JqL
 oP5g==
X-Gm-Message-State: AOJu0Yw9qSGRnNGXL+wYGfSEjeqMS9VlPoJni5iOs6SSa9aoaPzYEB98
 Y0v+X/8eHDdxnx53990/J5Sa5TB/nZ6ZqgzekxZshnPaMCCYVnm2dKVNILleLS9QLlCzf59eeUh
 4N1vFW05IDDOQbRfSaS7uwDSn867qrRA=
X-Gm-Gg: ATEYQzwmq3Z7OVH7AcOJfgQrnwlWm3YX8csTJBnEv5uCgsblqyIaMza+Y7Q/W1LwsJV
 TXmGl7BWmZqWcgY7eLfXHhbaMC5vdf0fjwOHcF6JtSmaYOUVttrw0u6nlwK3OhHfWfPW34MRxET
 4UywqTCGIawlEZT5YrmcrFMyfoaz8v9EIBTVUPAG47Hh6M7CICHUuOofTKHy5aeOwl3yf90DCGR
 qDr/ro/yw/3VCf7LfVbz8QnDcyDiEefYJr4c/BNG1TsV+y1pi2RIFFxOuG1XmUaM8l2giHXN2hy
 M8HoifYXhUX1i9pXYfPspAFdXxiVy1KPiVaO3w==
X-Received: by 2002:a17:906:794a:b0:b98:785:99a6 with SMTP id
 a640c23a62f3a-b980785a1b1mr232011766b.25.1773891075927; Wed, 18 Mar 2026
 20:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260318013805.1920377-1-max.chou@sifive.com>
In-Reply-To: <20260318013805.1920377-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 13:30:36 +1000
X-Gm-Features: AaiRm523u06IexXyM-0wW8eK898SsLHctOOf3TL2_YMKNU23IF77w71uxI_V2t4
Message-ID: <CAKmqyKPnN13mVeTc6mBgMHvx1FnyjT_4yyYWh1nPR8ad8r77dQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix probe_pages and vext_ldff issues
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
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
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

On Wed, Mar 18, 2026 at 11:38=E2=80=AFAM Max Chou <max.chou@sifive.com> wro=
te:
>
> This patchset fixes following issues in the RISC-V vector
> fault-only-first load implementation and the probe_pages helper
> function.
>
> 1. probe_pages flag handling:
>    When probing memory spanning two pages, probe_pages calls
>    probe_access_flags twice. The flags from the second page were
>    overwriting the first page's flags instead of being merged, causing
>    watchpoint and other TLB attributes to be lost.
>
> 2. vext_ldff cross-page logic:
>    The manual two-phase probing in vext_ldff had three issues:
>    a) Wrong condition: checked "env->vl > elems" instead of
>       "env->vl > elems + env->vstart", missing the vstart offset
>    b) Wrong address: used "addr + (elems << log2_esz)" instead of
>       "addr + page_split", probing incorrect addresses for segment
>       loads (nf > 1)
>    c) Wrong size: used "elems * msize" (first page size) instead of
>       calculating remaining size, potentially missing faults
>
>
> Patch 1 fixes the probe_pages helper to properly merge flags from both
> pages.
>
> Patch 2 fixes vext_ldff by replacing the buggy manual cross-page logic
> by a single probe_pages call with the correct total size. This
> leverages the infrastructure that probe_pages already provides for
> handling cross-page accesses automatically.
>
> rnax
>
>
> Max Chou (2):
>   target/riscv: rvv: Fix missing flags merge in probe_pages for
>     cross-page accesses
>   target/riscv: rvv: Fix page probe issues in vext_ldff

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/vector_helper.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> --
> 2.43.7
>
>

