Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE419CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBeo-0007tm-HX; Tue, 19 May 2026 00:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBeg-0007sw-9e
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:02:06 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBee-00012f-Nz
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:02:05 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67cac5ece75so6393472a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163323; cv=none;
 d=google.com; s=arc-20240605;
 b=UksWWaPleAzy1fqY4of1rCBJs9TXQdA4dyVN69bQZX8RCXoibEV/lmXrHSAA5WK90x
 qGQAsV5FQOe8ttk+WOEibRbEPfeZLHq8Y1irWmV+eIhqu8F+B2geVUSE33zREMbU0f7F
 6KBG8230AI5VoQm/NIPkKn4WQRh5jgSdk/rPZYsKSnwv4TppKCmelqtadRqwxo8uGM5V
 uaYNkYhSOCoDe5RNiQbcu6ozU/EBtwOSKcJAxHrYXrIzAbZR4aNbBkKK7P4BNBc78HEZ
 VKTlUkbvGu6GahZvEIZcTZeDP4C8zbKrXskxlwUyQhEoKqrqWFANJq3KrXoikO8KqThS
 pn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vnw+lix88wzW/PuUNMdNRXOuDO1s3D0vDqcmbVqltAM=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=Bg8DQ9LBcQITphZy/wvVSOEc6itMZoYiMz5CvTRj6wZsMP7zBl83pL0PbK6vjfzdUJ
 PebHr+8HhSGTueYXCbHdeRyeIH2oWcj48oOyGXkiHCRSXiCPQ8L+lSP6+uh3R8CabxmA
 XuQsRGOw2EhX8wXBPfjWYblR1Xlw6Pw+eON+SmBxxgBawcIGaolce9596BmVjvRhdZ/r
 yWUuH6GmP9TYfswphcSfvgKuHcRBNjhuL72bbdWfm8tKYdJWZYxqn7Y839U8m8gLMdqP
 edRgCKGh3mA0LYfHfk1P/lKa20+CIYfjs9DEHe0QkdRPgiVvoKoBtj1iAZbxCZfLPuRC
 2JbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163323; x=1779768123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnw+lix88wzW/PuUNMdNRXOuDO1s3D0vDqcmbVqltAM=;
 b=dalOSt9sgso26RRKTCJLdvD0kkY28dVmdGf1x9w3T3bDOEPhNaI3FW1+TZCSjSQXxU
 AWuiM31m171V9ONkPkymUYZDgL5KvDrv/fn23NCCZL/Wkz8E7VU+CzoFL+JfMST1PUje
 JENtTp1sEnOMb+cW/fOwKXQCv26zFlB7A7f36CdwLWqQuksU49mTPiFeC2VkU+ukBYPf
 0B+qBFfG6XDWPnIPwoQt+MCO+cFPmYbZILZHcIvBoXXjezCZ+eyiQO0N8KwW0ZjT71sA
 2foRxbdnhPemSCBLm9BcQn+hSIPnE6eS4e0ovvIFqR/fTlF+xnWxhdSNUMdgT6JfSC0J
 puPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163323; x=1779768123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vnw+lix88wzW/PuUNMdNRXOuDO1s3D0vDqcmbVqltAM=;
 b=K3te1c8UImlvPSEEv4kRfC2FDi8NFFVvjln6NayAhrfh0Qhk1fhPqvH+v7azAAb3RM
 4tzO+ryeL3fbmH08LiPQuQbGKwIktg7WLwFp+nSkI1uNOWGV8okjxsCqFfm7xCGU9XMG
 khz7Qm+UfzSoCDQOIUWFA59B5RNxZuIcPMndEmN1fAiZqWUM+iee0Obwq3xRWAKs6KvL
 owpuLlBEFo5EWuzgIoMjFu25LC1yTYyr9heIS9GQw3W9PE3l2k4OpgeeZBfZj0MubH9x
 JrOiXaW4WNtMbD0Wij/9Ly2XaXzaZFwLuuQD4DerNMKSNh2TtOYQj7Z8wh1+vgjBL80Y
 hFBQ==
X-Gm-Message-State: AOJu0Yw9+c2VdHe0x9EzPBXtHd3l+UAAlZ4+qAdRcH7sHdYhGeSSljbc
 5QmoM5N69PR13pZt//ihEhj3ss5uiDUtKUW5TEVHIt/BGU58Vzg77XvcDYJX3sXdyByO/m/Uicu
 hKaRmX8Dc5xUSHsQze8UGjFgUN9PXhPs=
X-Gm-Gg: Acq92OFJ4HL+fhGl/F4pBD7I1zjMoGKo5Z85Fb1nHEPCOMcSloD+mhJkaP6W3TwjN9z
 DA2wS2qG5VB5dvaEzjbs+iDBlszmvGdeLra9ep5ofW/FAX4JVP8gmXR0d7veEoynvogwM65MfYy
 vT5hlVq3P9/v+itRu8Lw3Ingr8SOWmjVQB7wfvTajMELGaGgDz4sy9wneAMATVKx7rGeLBd47NP
 IAWwSuyWq2+T0KPaLjsHIOXzY0jt2JajWlpQEWnEkuhYaRNiBU6m70j9BCgkGgxKQ2bRimCNPGn
 BxshR2i+kxGB2V2uNc0JrM5NNlAjcSqH6fBxWw==
X-Received: by 2002:a17:906:dc8c:b0:bd6:5288:58cf with SMTP id
 a640c23a62f3a-bd652885de2mr581546466b.42.1779163323186; Mon, 18 May 2026
 21:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-9-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-9-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:01:37 +1000
X-Gm-Features: AVHnY4KiRHH0v6Qz3TeYG_xYLb2fH4NFlv3njCsD-QVYBv_lxQyCiiBmC92pNtw
Message-ID: <CAKmqyKNcEjU2eNgyvHpS9TTULW75p6Dt3v7E5dZGdnTzi7aEKQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] target/riscv/tcg: use isa_edata_arr[] in
 riscv_cpu_update_misa_x()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The non-standard extensions, in this particular function the vendor
> extensions, are all riscv,isa names that starts with 'x'.
>
> In theory this is a bit slower than using riscv_cpu_vendor_exts
> (isa_edata_arr is longer) but riscv_cpu_update_misa_x() is executed only
> once during finalize(), i.e. not a hot path.  We're accepting a tiny
> performance hit as as a tradeoff for the code simplication we'll have
> later by removing all riscv_cpu_* arrays.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 8dea22bae5..b7d59f40f2 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1155,10 +1155,11 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu=
)
>  static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
>  {
>      CPURISCVState *env =3D &cpu->env;
> -    const RISCVCPUMultiExtConfig *arr =3D riscv_cpu_vendor_exts;
> +    const RISCVIsaExtData *edata;
>
> -    for (int i =3D 0; arr[i].name !=3D NULL; i++) {
> -        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
> +    for (edata =3D isa_edata_arr; edata && edata->name; edata++) {
> +        if (edata->name[0] =3D=3D 'x'
> +            && isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
>              riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
>              break;
>          }
> --
> 2.43.0
>
>

