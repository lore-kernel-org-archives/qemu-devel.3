Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD55CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 00:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUZkX-0001TZ-60; Tue, 02 Jun 2026 20:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZkV-0001Sb-5U
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:46:23 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZkT-0004Ok-Ed
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:46:22 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so8863414a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 17:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780447580; cv=none;
 d=google.com; s=arc-20240605;
 b=DbQkEyJ9YSQoApMBCo/uiRrcCyit1ciVV9C8LZpAbumaRoEfQz817O6Yg2hv7H2Ahj
 oMx2DsEgxXcg60jpdIqSEW78cAcjSfjOdEVdOM2p74L9JQ693T30REowcdH2uQDNiAIt
 qKbk6qFRGvJN/K/Je+5rZjJ2FB9R8dUILiCZOd8lzqEz6XZVF9HPNEd/Xibp0ASYlss8
 Bg4yM4O+eP2Q/d9TsySWsRsZ5MtRZMGyTaOwrUx+HSuY1eY3b+INJs9jjWww8U+PTJzD
 4DHrRACR5vC4FxfF8xYxLl1BlppTBWfdpqB7FvbBbhyOG5aai2YThyCrPrPMsWpuVAga
 iyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mV72vRjRa7b/Ga7RHTw4kOyktIkyYNiqpq2SKCB17Qs=;
 fh=uqr/DpQacYcsRXO1RgcDHJmf4HNnoXaKHl6JDk/PLmQ=;
 b=TR50HtXAyoFnW5PDFWA1slcB/9+AJuO4sXfLhiBTfktzNZ2J6REfn+Xl72fyit4R2H
 OFwcgU6SPLTHH9dp463RVW/eJAKOqxIoZdzC6KZfMPSLvLwLuoE9V3RDY/zI3oqPzi+B
 lZkvr0eEVaVdXL2VWPs6kgBKD4DOZrqgxeVV5DWmhmN+KcdhYQqQFc6apeSn2gDCcOvO
 +J76SiUdmpaGEbzumqgkIBs1zUfj7IkxB8NZS1OWWDq5leIz7t3Jwm5bvvSce9R+i9Oj
 cW3NYWqd2o4zEzzvm06bNslZwwSrHpFt3M1XkjlGVySpsy5eQgog7EEhs5fW3hgf86bT
 lRlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780447580; x=1781052380; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mV72vRjRa7b/Ga7RHTw4kOyktIkyYNiqpq2SKCB17Qs=;
 b=dBT556JuPlkm5fNhQF4S+LStlHrJyeTQ/7xgqp7UTPAzAsP8vRYEPeAnlTnQhxA696
 GdwTE9xhn75P5WDPS+tLz1J4v1t2pLy1yN/e2e5xvekDOH79KwhbfM1j75CReo8I7qS8
 MPHDTMkcFK5oUpmzkSDCpbhhWR/m6XRWhH3leybagzsNXJ8xMCmUyMlEqGcmSFFmbS9P
 uNE8uINo+xDyItop6sQHkYr8oTfchsnzLACw5UFNI2I/MFy8kCKtCzRHd0zbdXo6vx9C
 eLPGu6W6QwGlI/+wytlLFZQ+kt84eqa4HEu8Keld6QNM4zykxMIxslcTzIqFwbooRiwk
 HmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780447580; x=1781052380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mV72vRjRa7b/Ga7RHTw4kOyktIkyYNiqpq2SKCB17Qs=;
 b=kD5LK9mJPKdfS6ZKoUJ2xqgRElYFQdrbmwWhNasnkEpSF0IDKMm9kWRU/rmi19aApS
 JyFP2xPhR17bCJf6qWQGBk4UV0twTuUf8jmN5s23yrByz3E+DyIgw1uZvW3Hfd+vYhM0
 HTSwP7vkb86u5MBFLrIhZrqFZQ8GOnqhJYUstGQpm4FrGYVIk6S9CXID65Xq9OSZdR9j
 Dr5ljzal+3O2EicJguh1hI0fq1K4fsnNjVMrUyW69EhmEHsygS1mL7Harpv16Fvk74a7
 z7HxL1bq3FlKXbCyR929UkXPHLC7mOa2mscHyKMZPYZho4EwFiQL8U44wXJq8sBHeUbx
 L3Vw==
X-Gm-Message-State: AOJu0YwrTqhaI10vTrTiVlywja+Lg79VE4WwZBA1ZEuGA9C0ST4T2TwI
 ZE9G++m1IE4WL/DZ8JK2P6YJHFCQ/l1dXwpn5FJflpMilKICSkhPSMDDu2F1j/miSY95GvJR4s0
 U6fCM6kLc6HfDeKNlK/oOsVeealGQc/A=
X-Gm-Gg: Acq92OEPRyC2R+spdQdA7TH46dcLTjJLwaLROTcMZTt7gRrGlc7r+QVbe6Vlvycn116
 TMVWFI9gB28vtx0zCbqlPVZnUlOeYliu+S+YWQ7e45AjhfFw9gY7SxM4h9U8NtlEzanGs5bNPhu
 X5BleXD5Foq57APjC/JOeS02R12Jq6dS6HuFiQdZC1I52SrZME6C5H1BcB7crCgb8wPtHr+1TOp
 dRE2EGz3usPXu/ISA3IIS5HUVhtMXz6L70dGUypAPnq9UCuRx5oja+jb5BAZq56x1Z5AsCPjRhW
 xz5ASryED0QEWhPdRWGF4282Slkdz2ewJpkgKXElEor5GRfx
X-Received: by 2002:a17:907:7617:b0:bd5:7c2:70ca with SMTP id
 a640c23a62f3a-bf0b43925acmr22548966b.48.1780447579730; Tue, 02 Jun 2026
 17:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260529053519.1224019-1-antonb@tenstorrent.com>
 <20260529053519.1224019-2-antonb@tenstorrent.com>
In-Reply-To: <20260529053519.1224019-2-antonb@tenstorrent.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 10:45:51 +1000
X-Gm-Features: AVHnY4KT0oif0oYLcwiuVQd0Z8KUkO7Wa9ceFZeUhQ54YgGOOsnlvzXZTFF3UDY
Message-ID: <CAKmqyKNY0625bsGo1-k2zYrP+SiQ=Yatuer9t3+FtoYfk5bD_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Improve alignment in
 riscv_cpu_dump_state
To: Anton Blanchard <antonb@tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
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

On Fri, May 29, 2026 at 3:37=E2=80=AFPM Anton Blanchard <antonb@tenstorrent=
.com> wrote:
>
> Align all the CSR values. mcountinhibit is the longest CSR name at
> 13 characters, so use that width for PC, implicit state, and CSR names.
> Also remove the redundant '=3D' from the implicit state lines.t
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> This makes it easier to read the output in my eyes, but I wasn't sure if =
the
> format is set in stone. Feel free to drop it if so.
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b38ddc39ea..883aa906a1 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -575,7 +575,7 @@ static void riscv_dump_csr(CPURISCVState *env, int cs=
rno, FILE *f)
>       * to do the filtering of the registers that are present.
>       */
>      if (res =3D=3D RISCV_EXCP_NONE) {
> -        qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
> +        qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
>                       csr_ops[csrno].name, val);
>      }
>  }
> @@ -604,17 +604,17 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE=
 *f, int flags)
>      uint8_t *p;
>
>  #if !defined(CONFIG_USER_ONLY)
> -    qemu_fprintf(f, " %s %s\n", "priv   =3D  ", riscv_priv_str(env->priv=
));
> +    qemu_fprintf(f, " %-13s %s\n", "priv", riscv_priv_str(env->priv));
>
>      if (riscv_has_ext(env, RVH)) {
> -        qemu_fprintf(f, " %s %d\n", "V      =3D  ", env->virt_enabled);
> +        qemu_fprintf(f, " %-13s %d\n", "V", env->virt_enabled);
>      }
>
>      if (cpu->cfg.ext_zicfilp) {
> -        qemu_fprintf(f, " %s %d\n", "elp    =3D  ", env->elp);
> +        qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
>      }
>  #endif
> -    qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
> +    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
>  #ifndef CONFIG_USER_ONLY
>      for (i =3D 0; i < ARRAY_SIZE(csr_ops); i++) {
>          int csrno =3D i;
> --
> 2.34.1
>
>

