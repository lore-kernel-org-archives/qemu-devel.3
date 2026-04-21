Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD62F94CB8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFL0l-0001Dd-Dh; Tue, 21 Apr 2026 20:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL0c-0001Bl-T5
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:00:04 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL0Z-00023M-OG
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:00:02 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so842694966b.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 16:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776815997; cv=none;
 d=google.com; s=arc-20240605;
 b=iHmyCI4I7DVYErw1KrHM4MVS7poexnsaL69X6mr3lNnkE3MvIqwQ/ORtx38bS+0XzK
 5j5E5VniGfyarcCuPoYZ2Nr5WS3tsTvifIrqnVQRddDJtzuqBDrGM4mXVenWHiB2jbiP
 /ygmXg0cOr7psjZii5ib9tcchYWE8AaeQiZazn2C6vAOONSl9D/nX9o7zwhlr2duilTi
 Y/Z4FidiuevKbIkfygvMBxbchQOmVWHvajPP9qGGgPpUb1sO6YfGYEVsXCfjxATSj3sY
 8ZWAF+MI7XJJMxEeLsos/rtOo3dH9fOi2qoPEouPlZGkRM7l+KxUyiRc7mEmuaMkCPFp
 OFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=93SZ2j0xgZWm/Y+ijz0t0nesXYj05dKVQz6rIRzHtDk=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=PyAoK07FSAoOCeFx0nB5nsojwuLxbsOuJPknpMggUbBjwQsDJvr0HAGgjRelujlY2B
 Wff2LA7p6/vuwXEUUXHKIV6XqFrsLF2pZW3rhWG14nc8DBnsKeSbKRqyY9Is84vC/J0W
 c9XJ77F/dRaMB6nKWOtaPUCtJdD2x/rL8lIsEbDsQP19yvCPqkTtOCa9ZmMfGUaSn2/Y
 MlZHun9RDKnA9xFbLGoa+zXNyGjVmCqEbtGRM0KuHvWvvSIuduZO+0m8zMmMTdnn36ed
 eveaUN27Ovm6uSPm9p2YfzJ+AFgE+MRzc4UjJ05t4UUFbD5NNjxDRpSi7UDJRe9+V6Vc
 owLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776815997; x=1777420797; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93SZ2j0xgZWm/Y+ijz0t0nesXYj05dKVQz6rIRzHtDk=;
 b=gEw4ejL9gtO/rMLGTmkJmU0EELLgIq9Pe0eNTZYtEGv/wdTqX+J147v/T49ELUeVic
 MszATxrBhtUzilE5WKUmsaQlQl/y88XOmsFaK31WtWGXzzKWdyeO6fHShh+Pm5nLfmRJ
 66Pn2YDbP3HcR587R2JLWN2vsy+AE05mJjAY93wz0/UQMJL6usmd26BSe0hHWS4Ovjlz
 B2n5CbFA9qcNjbqSgQdTqasVKHSypd8J3ZYMZBUF1HORRSi/rO6HALgI0qHprpN/GGDI
 2k6Ti8E+UeMlFQuXPVtjeUVbLd76mzIACyinae7PZ3zCrPtEP1hPasusOq2NF4NDWv0V
 O7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776815997; x=1777420797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93SZ2j0xgZWm/Y+ijz0t0nesXYj05dKVQz6rIRzHtDk=;
 b=TLQ7dQrmhxwFf6NubYVvdHXEtVOgaeWsC+/jgqgAMBTMWaptK2fBG8mG5NidW6UZQN
 ndwLiOkiwIZ65HTZRkuV8EAUmQrPBbTjTtVBphfJQKRAmOwOlGdKLm17NQcCZ8WIj50o
 Tcp+EkBbfPFuIlouv7zBM1JA1HhX4ZwHIUNvdhW8uCJB4vDf7CEXH2oaJFaEDy4Py6Lc
 xpfbH9l20VqRwTdkWhU3b7JyoNmvBDiVeuxguRYiObpJ9tWtrIw6tanVQFkCBPmDdgZ6
 e1lRTis2wT2cUQ9Z4A2whKMFj9lpyo2bVdIrFtzUcgoTwom91SN59rPWLSkU2R/8EWX+
 p/vA==
X-Gm-Message-State: AOJu0YyAXRL/LBetuzyyfjTKZox+v4+Jp2RdoR0C2hUpnNxTGFwPSPSY
 QVWzfZQBQaMR07U6/7ob9xX3OJWSGmC2ORYExl9i7hYp1wRUlR5GnAFzSZKwyfOLCHPHv/AGV+3
 bR+RFnTAaSCVWpEY95g00wDg8KrMZ1js=
X-Gm-Gg: AeBDieu9T0qYMp20l9I4TbEQ8Fsw04/ZekzZK8xBrBN1ey9UZ1tUhv9D+BR5Mo/UerQ
 DkMxyYsCWGv3iYQLpPQ70Bu4hy4OJIaqZ/B6ZborStmz//cH3L9bWouSpyfSeHByJou/hQ5EbRB
 PAz5T+xwIL167q/lO1fy2Kl+tTVBJtalvrHu8gNNKXqtYpfFzvOZ4QrcNqmspWiPy1e6x7pump1
 06Eq9R7dYwt2hiTRJxAaBUGYzYl5Vuv9GY5Q8ribEoygGDAzs3nyBh15KEyzP2uXacB3j1k3v6D
 N1JdUXOPUFg6t+VOZEVWXPxXK461awFACiUvXFV2z8ngPuAd
X-Received: by 2002:a17:907:b815:b0:b9d:3b68:954c with SMTP id
 a640c23a62f3a-ba41a044056mr932897166b.24.1776815996884; Tue, 21 Apr 2026
 16:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260421074940.2916287-1-frank.chang@sifive.com>
In-Reply-To: <20260421074940.2916287-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 09:59:30 +1000
X-Gm-Features: AQROBzAOcbtffRYvwFrVU0qsiEZBH_-0Q2t2DAgGCUwbojcBjCbTkFq0egOHYYA
Message-ID: <CAKmqyKPekg=s-ZrpaGErEJq5MORfkEGfg7kJc2PNB7ytKWNG_A@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Mask xepc[0] only when Zc* extension is
 enabled
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Tue, Apr 21, 2026 at 5:50=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> IALIGN is 16 when the CPU supports the Zc* extension. Only xepc[0]
> should be masked when the Zc* extension is enabled.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/internals.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index b001cbc080a..ab8dea45c90 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -173,9 +173,15 @@ static inline float16 check_nanbox_bf16(CPURISCVStat=
e *env, uint64_t f)
>
>  static inline target_ulong get_xepc_mask(CPURISCVState *env)
>  {
> -    /* When IALIGN=3D32, both low bits must be zero.
> -     * When IALIGN=3D16 (has C extension), only bit 0 must be zero. */
> -    if (riscv_has_ext(env, RVC)) {
> +    RISCVCPU *cpu =3D env_archcpu(env);
> +
> +    /*
> +     * When IALIGN=3D32, both low bits must be zero.
> +     * When IALIGN=3D16 (has C or Zc* extensions), only bit 0 must be ze=
ro.
> +     */
> +    if (riscv_has_ext(env, RVC) || cpu->cfg.ext_zca ||
> +        cpu->cfg.ext_zcb || cpu->cfg.ext_zcd || cpu->cfg.ext_zce ||
> +        cpu->cfg.ext_zcf || cpu->cfg.ext_zcmp || cpu->cfg.ext_zcmt) {
>          return ~(target_ulong)1;
>      } else {
>          return ~(target_ulong)3;
> --
> 2.43.0
>
>

