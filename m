Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F3ECD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 19:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPPk0-0002f5-PH; Tue, 19 May 2026 15:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPPjy-0002er-Cl
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:04:30 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPPjw-0001WN-Dm
 for qemu-devel@nongnu.org; Tue, 19 May 2026 15:04:29 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-95d04f205beso2722366241.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 12:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779217467; cv=none;
 d=google.com; s=arc-20240605;
 b=NP61IzyqNYDXInhLtHzAcRJc1o91fgrqNDaAAYvAI+EZrK498eV58uXB8MKDUJEjJh
 JtqZDvk/4TZbzkCbkCU1QU/ixj1PB0Xm4Fnb1vzG3IYqy5hGkt8D2bZGT+tbO5EIf7CL
 oWzz8IO4k0QXzufIMEnp2ix/YoRzOnImm0s918JpKZU3oSnwCtdz6Kr0P37ObRpe+LjC
 lhSMDz0dEYVOzOj8XRWJhVsu5wxttp/7RnuX96cnv+sxzNdybme9XG20x0uwR428K9u3
 Sij2prJDk3YRgdUe3pOxLrZHv73vjShojwPNeBLkwlwDrw+SvOLSLlt+t/jpVVmcNf4N
 HACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fMqF1SRPo+kdK2RpQrc6DavMeVYsv5GFaIV+J7jjof4=;
 fh=7Wt3KuSovZLr9zcokYH9drBFbpVphMhp0k1jxtehACM=;
 b=V6OIbw1NbufxG176e32IZ6DOx5UtmqOUf0fBEjBXockEQTEhw8yATMm/sNT0VhnQVh
 YKmJtBcEqp+iyPv2V0sggF1Q9pLXNsoAnxhnD5tBZGytF14+6LEdyOrP3X3Z5ELIcaxT
 aifHI7FFOQn7H6mNdmBz+iqvut80j2qqh3gxqw2MkzphT+lunaRGNQZX64enUXoAqSCH
 AYOlStRoqUY5nf4V3dZlj2bQxLX/uk2nYGu1w6nB3XL3XW1kFK3/m9yHTSHYCiYcoHgP
 R7U9R9JN9115NxWphbjKQX/g84PdIfntVi+B2libFr2ZRZUFF7UIP2jHTEbSh52bN6xR
 AOTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779217467; x=1779822267; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMqF1SRPo+kdK2RpQrc6DavMeVYsv5GFaIV+J7jjof4=;
 b=G/DyJz5Eb7JM6WZAjFShMu52UVu6U3f8bJwN25XSvPD0SxFD9GBSUfVxIz1tStzglG
 WvK74j2XNqHqEnmzIyvcSRLVHLe6zENc3skzOAU5lpU/XOZQaYNb19gk024tBSivMe4M
 E5SQd3nKaOBFysKRDOJx9ng4fCBwxLvd9sO8dVkDyg4SsktcmJ3rWucE78rayn3jtlai
 qAR1DTRyWZbnS6bHZL7KJLSEWtRKzxUHrkeS4vEgZ0t5hYJgLg793nVbh9YY51BLnDy2
 ZhBEC3tGRYamScDTWGd7ehR+4lPDxrS53fyw21G7B8vuDKrbhnkqO9t0ROTSxxSw1YK5
 5eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779217467; x=1779822267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fMqF1SRPo+kdK2RpQrc6DavMeVYsv5GFaIV+J7jjof4=;
 b=JZwlXlCGIHdxZUww9tumsd0Gm3k/LRIeHDZeAkdP2HBSBKbQvkJ2O5tBOP5F7DvRJC
 fGe9ae0JiJFY7fHMJuogFZep+dfhoyrbS7AcXEeeESXhi8cH7ncXkCgrP8BNAUsRVwI4
 fUS2re6b4Vol4H36l3URjLn6gr34022GhLmoeixPhsU/c/biEUvoyg61IVx6jkme0S7G
 Eix7pIYnOQZOxp0iYeDu76FJ9N5CMaFWW8sOfSp7bW5TLWHkD29VhShoa4/ZRph5xm8P
 38M9nJ6twBrcqxfgGo++5ATwAmdPPNjDUWJUzfJT8VMc6vFdJ+1GafCwUDDz+iViDvW0
 J6hA==
X-Gm-Message-State: AOJu0Yy0ZrFNfyP2nhG9a6UdQDTBzxAq0kRXPCswOWY8Zkl7ZfpDwHy4
 tRCauzBMKFjG+dPfgM4F1W/vIekoHTErmhjDcLHU8DBauHdQBPupVHU5Bdm7lTGuFu+CFtP1v37
 Za3p6ipC5/xdNzFF17p4xFSXDtIsG5z4=
X-Gm-Gg: Acq92OG7dEiouR9NVfM+Xr5wZYi8XVK0RvSuED8GDqgyRF74pVgCp0ch6uivYsh6kvs
 0AK9erkd34k1SgHHrGqdYQBOPzqSht+pSCiuApWTKyICJ6qw75C9Zk5xrVpy7SiZ0Y9+Au+9p/9
 Bjk7MFjojSpu76EcG0HKojW4Vkf56MLX+jedR4lxliNjwHw7qvzc1OAlb5r96+1lN2n38uTBzKK
 cnHN9MwTHPYeVQU8XttK2h2tPq/qVnKgtfMtE7xjb4YSSG5sSvP1yy8Ygcq+1KcJrDE8TalFmoj
 9z+5b/xxXvIKujPhR2QcX9nXo9ysbl4iTEiuu5G6bQq3Uo7Ss9jCpgAoiyQz2WJRUXpUW2YH8TD
 9b8W3USacNc6ESQ==
X-Received: by 2002:a67:e115:0:b0:631:d586:893e with SMTP id
 ada2fe7eead31-63a3ca1b807mr11397893137.5.1779217467014; Tue, 19 May 2026
 12:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-12-d7dd735ecddd@gmail.com>
 <6f0423ca-8c61-4f82-88fc-c826f9e06114@linaro.org>
In-Reply-To: <6f0423ca-8c61-4f82-88fc-c826f9e06114@linaro.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 13:04:15 -0600
X-Gm-Features: AVHnY4LnJmytdWB6mjmbyxFUJdloWNaMpfgkp1vLmi9pqkuwEe9bdhbYt_KKKb8
Message-ID: <CADvTj4quJAhysFO3deoyKkwq3_Brkh9jQ+Hp22u_bKwbEYme_g@mail.gmail.com>
Subject: Re: [PATCH v9 12/40] target/mips: add Octeon ZCB and ZCBT instructions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ua1-x933.google.com
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

On Tue, May 19, 2026 at 12:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 19/5/26 18:22, James Hilliard wrote:
> > ZCB zeros the 128-byte cache block containing the base address. ZCBT ha=
s
> > the same user-mode-visible memory effect for QEMU purposes.
> >
> > Model both forms with a single decodetree wildcard entry, align the
> > address down to a 128-byte line, and store eight zero 128-bit chunks to
> > guest memory.
> >
> > Acked-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v8 -> v9:
> >    - Use MO_ATOM_NONE for the 128-bit zero stores so TCG does not
> >      require unavailable 128-bit atomic stores on hosts that lack them.
> >
> > Changes v7 -> v8:
> >    - Fold the ZCBT wildcard decode into the ZCB patch so the series doe=
s not
> >      add a ZCB-only decode and rewrite it in the next patch.
> >
> > Changes v6 -> v7:
> >    - Use 128-bit zero stores with MO_128 instead of sixteen 64-bit stor=
es.
> >      (suggested by Philippe Mathieu-Daud=C3=A9)
> >    - Fold ZCB and ZCBT into a single decodetree wildcard entry instead =
of
> >      using a duplicate entry with a selector comment.  (suggested by Ph=
ilippe
> >      Mathieu-Daud=C3=A9)
> >
> > Changes v2 -> v3:
> >    - Split ZCB/ZCBT out of the combined Octeon arithmetic and memory
> >      instruction patch.  (requested by Richard Henderson)
> > ---
> >   target/mips/tcg/octeon.decode      |  3 +++
> >   target/mips/tcg/octeon_translate.c | 27 +++++++++++++++++++++++++++
> >   2 files changed, 30 insertions(+)
> >
> > diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.dec=
ode
> > index d77717cd50..01ed3b50be 100644
> > --- a/target/mips/tcg/octeon.decode
> > +++ b/target/mips/tcg/octeon.decode
> > @@ -49,6 +49,9 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
> >   SAA          011100 ..... ..... 00000 00000 011000 @saa
> >   SAAD         011100 ..... ..... 00000 00000 011001 @saa
> >
> > +&zcb         base
> > +ZCB          011100 base:5 00000 00000 1110- 011111 &zcb
> > +
> >   &lx          base index rd
> >   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
> >   LWX          011111 ..... ..... ..... 00000 001010 @lx
> > diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeo=
n_translate.c
> > index d3dfef2e0c..721a9a8d9d 100644
> > --- a/target/mips/tcg/octeon_translate.c
> > +++ b/target/mips/tcg/octeon_translate.c
> > @@ -176,6 +176,33 @@ static bool trans_saa(DisasContext *ctx, arg_saa *=
a, MemOp mop)
> >
> >   TRANS(SAA,  trans_saa, MO_32);
> >   TRANS(SAAD, trans_saa, MO_64);
> > +
> > +static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
> > +{
> > +    TCGv_i64 addr =3D tcg_temp_new_i64();
> > +    TCGv_i64 line =3D tcg_temp_new_i64();
> > +    TCGv_i64 zero64 =3D tcg_constant_i64(0);
> > +    TCGv_i128 zero128 =3D tcg_temp_new_i128();
>
>         const MemOp mop =3D mo_endian(ctx) | MO_128 | MO_ATOM_NONE;
>
> Although $zero endianness is irrelevant :) but I prefer to keep
> it explicit for coding style.
>
> I can squash upon applying if you agree or keep your patch as it.

Whichever you prefer is fine with me.

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> > +    gen_base_offset_addr(ctx, addr, a->base, 0);
> > +    tcg_gen_concat_i64_i128(zero128, zero64, zero64);
> > +
> > +    /*
> > +     * QEMU models ZCB/ZCBT as zeroing the containing 128-byte cache l=
ine
> > +     * in guest memory.
> > +     */
> > +    tcg_gen_andi_i64(line, addr, ~0x7fULL);
> > +
> > +    for (int i =3D 0; i < 8; i++) {
> > +        TCGv_i64 slot =3D tcg_temp_new_i64();
> > +
> > +        tcg_gen_addi_i64(slot, line, i * 16);
> > +        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx,
> > +                             mo_endian(ctx) | MO_128 | MO_ATOM_NONE);
>  > +    }> +
> > +    return true;
> > +}
> >   TRANS(LBX,  trans_lx, MO_SB);
> >   TRANS(LBUX, trans_lx, MO_UB);
> >   TRANS(LHX,  trans_lx, MO_SW);
> >
>

