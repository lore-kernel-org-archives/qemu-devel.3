Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5770FC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTML-0000SR-Nw; Mon, 24 Aug 2026 08:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wyTMD-0000Hc-Ow
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:00:54 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1wyTMB-0002RW-LI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:00:53 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-836d2861a39so45360267b3.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787572849; cv=none;
 d=google.com; s=arc-20260327;
 b=j0msSd2xVcSQsk6JfsCWjBJbcYBc0OqowDw0jKu6KFb5RbC10mZXJR2ApYDwKRVOJz
 EfXy2zZy3zXa0RMgqeoIiw/6cxc8G9kjZDqFgu8YENOGoAW3Ijgh2PYcjeSdJcoMy2CU
 PvlY4X1DMvK0Fi4PoSTsqxGbtvoD/Z881/0lY8p1IXesGv9xJdw2N16rV97XU8CdUZBH
 +cts2Uo37Au2ir1EYAjb0z/fuM1ClN6/6KAdndHgZfFj4WpjSIinr6w08/O6hbluuza4
 fwa6xudVeUmh90oYLonPtsIfmxdXN7AtpH9DiV4c+RIKuovu94pRPtglPirZc9oTNacY
 b2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o7EfmJNuV/+0dfwKsKxpyy70F/5EsEjAPhqDTV8Myk4=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=L3/aXTnxhF6UOI6JV1JA5J55VbPEggzXXtLeVWlGtDNc9EvvzNU1an11truA5EN6sA
 GOVEC1vR9duxh/9x1GzCvUMrTvRaAD9JiuByux1SlrS0sjRnWBpHY9ce+z58dpP0dvy8
 GC9IRy0PEn2SoHl3Z78sBqROZN7GN0oQJ4LWfhc4sJzpAOQSXdphxcDQ+v4AxtKRyimA
 rVswdOTG/DZS1Cl4v6H9C9KGbPQktveddkEmsbnJjfMwGDszcX27NT1acRc8S59oNLg7
 dbMwJrCLdilFHd0sJ2l8L8x9EmZ0SAyqivck0tD6CsaXvJHfQJnXAkDOimXLnYqfvYZa
 y5Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787572849; x=1788177649; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o7EfmJNuV/+0dfwKsKxpyy70F/5EsEjAPhqDTV8Myk4=;
 b=K/yCyewEXzoIgMFNaM2nQR1m96b/p2/YZRagQq9z7iEn3llU7rhFOY3/D50k82SK3K
 ThQOqxGzHeVvTG9F0C+FucAIfn8wFVxWfeyKBkiRYAohOcW5QjMajHPSTyhg+hu4x7/i
 O7rPr/kyps6LawmkdDd8VwSLjHgOXK2s7XdtJAgPMNreieBZZBF9LqYH8aw6IHXGPg4Q
 PCi3xOgRFlTPPXL1o4Fh844J2YzL5xp0Ve0r6cdLUQav9it1KsjCZth6DNPb6F+tKFhD
 iGw0zyuvTldgklbJHPIDvFzdVJsjLhp83trGiUiLgbnAdRiVi6Xz0duDvUNUFPAX1OTu
 +caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787572849; x=1788177649;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o7EfmJNuV/+0dfwKsKxpyy70F/5EsEjAPhqDTV8Myk4=;
 b=pgQT96FFiStbbfzKCTIIfvHYhrrv260YLivObX+AibodkHUduWKN9zotg5VtHxT+fN
 wKXEmdYALnRVUPRUtzpaNMpus4EbxS0flTBPkPFZ92HU3XJlGRPd/Itx7Lyq/sb93DdY
 UBjlb6hw0Uuk9K2EyFJjxWzsxJNaB5Swkj0H8mqNtEju2uRKsqBNPqrOLbe5/6eSM0Xb
 Mmlq5Ivb7CD4KgjJILIDuDUD60LC9U9fV9LqnIpU4d7bDV0HPHxomQP3q8EY1436TTa5
 sTrTGtqY/2NYHfcdvnbEFSaF6yrdIkLBN7xJGgYu/ul9lHFHGGhvJyzEKrOmic5FHwjD
 Lgrg==
X-Gm-Message-State: AFuF++ldUEXjVnFG1GlCo6juUzFMyyMBPhqroK/T/qV9qB2cnrKibGl+
 +VQwrIV9Y1cI8oBzg+P57iPRYfNvPlTH6GJJobWhAD0yh8d9sTj1zvZdjjpha/5LxWdf/TSUPnN
 A/Q/MI49vnlYkiE/J8G7OmxXwvB+dNvPjVbMZmE4=
X-Gm-Gg: AR+sD13ERFuwAXaBdHDN0fr7IVTTDiqxIf8D1qc8e+pHlvOHXAfJG+NdXPG2MIFSR39
 rhJ2RQ0KZQwPRZ0C9A79d6jYg4naDukrkUz8+rvUem4MJJmQoapQsSxzLCUg7ZI6QPMZPHQ0bCI
 RdQsDJVaTKBadShIrUXG9pSqBhJAVvrQ5uE8JQZCwio3xcHD1icllkZvfC80uD5LDClnTbg+zfp
 GoyZUnE10b4P4edSCX0bs9zaHdh5S+0E+TK2/BXVv39Z71XTySdZecbNIPOt35/Yg5pQV+ZNX9R
 FZwn+nmKicxzr1ip97IUwgl/hb4sw2vscOUM26Qk7h+rSKm9h0cBfOlcTpEw+CjtS5DA7sevqKK
 pOw9antkYaA/yW676LnELaYeoxT5FrtQ=
X-Received: by 2002:a05:690c:c604:b0:821:1288:f820 with SMTP id
 00721157ae682-84c95591347mr54083707b3.4.1787572848336; Mon, 24 Aug 2026
 05:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260807170751.390792-1-scherer.simon89@gmail.com>
In-Reply-To: <20260807170751.390792-1-scherer.simon89@gmail.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Mon, 24 Aug 2026 14:00:37 +0200
X-Gm-Features: AcwNN1VvxvoN0iD-raT9gVZlF66bDKniQNyXP_OqSArnIpi9IcmsIThElHG0Fn4
Message-ID: <CAEQwQtKoZkasDS4bSK2dDUyX8y0213=PG_UK5sE1-KMfsw-V+g@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: do not zero-extend BSR/BSF dest when
 source is zero
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yw1-x1135.google.com
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

Ping. Just following up to see if there is any feedback on the V2.

On Fri, Aug 7, 2026 at 7:08=E2=80=AFPM Simon Scherer <scherer.simon89@gmail=
.com> wrote:
>
> For the bsr and bsf instructions per the Intel SDM: "If the content
> of the source operand is 0, the content of the destination operand
> is undefined." The AMD64 Architecture Programmer's Manual is more
> specific: it states the destination operand remains unchanged when
> the source is zero. Testing on real hardware (multiple Intel and
> AMD systems) confirms that when the source operand is zero, the CPU
> leaves the entire 64-bit destination register untouched, including
> the upper 32 bits, even when executing the 32-bit form of the
> instruction (e.g. "bsr edx, ecx") in 64-bit mode.
>
> gen_BSF()/gen_BSR() already encode this intent (see the existing
> comment) by arranging for T0 to hold the correct full-width
> passthrough value when the source is zero. However, that correct
> value was then handed to the generic register writeback path
> (gen_writeback), which for a 32-bit destination unconditionally
> applies tcg_gen_ext32u_tl() and clears the upper 32 bits regardless
> of what gen_BSF()/gen_BSR() had just computed.
>
> Fix this at the operand-decode level instead: give the destination
> (G) and its 2op copy the d64 size class instead of v, so gen_writeback
> treats the write as full-width in the one case that was buggy (64-bit
> mode, 32-bit operand size), leaving every other case unchanged. The
> source (E) must stay v, or the decoder would scan the full 64-bit
> source register instead of just its low 32 bits. No changes to
> gen_BSF()/gen_BSR() are needed.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4132
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> ---
>  target/i386/tcg/decode-new.c.inc | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-ne=
w.c.inc
> index ac181308ca..85f9d27c56 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -659,12 +659,18 @@ static void decode_0FB8(DisasContext *s, CPUX86Stat=
e *env, X86OpEntry *entry, ui
>
>  static void decode_0FBC(DisasContext *s, CPUX86State *env, X86OpEntry *e=
ntry, uint8_t *b)
>  {
> -    /* For BSF, pass 2op as the third operand so that we can use zextT0 =
*/
> +    /*
> +     * For BSF, pass 2op as the third operand so that we can use zextT0.
> +     * G/2op use d64 because ctz already zero-extends the full 64-bit re=
sult,
> +     * and v would zero-extend the output register if the input is zero.
> +     * E stays v: forcing it to d64 too would scan the full 64-bit regis=
ter
> +     * instead of just the 32-bit source.
> +     */
>      static const X86OpEntry opcodes_0FBC[4] =3D {
> -        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0),
> -        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
> -        X86_OP_ENTRYwr(TZCNT, G,v, E,v,        zextT0), /* 0xf3 */
> -        X86_OP_ENTRY3(BSF,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
> +        X86_OP_ENTRY3(BSF,    G,d64, E,v, 2op,d64, zextT0),
> +        X86_OP_ENTRY3(BSF,    G,d64, E,v, 2op,d64, zextT0), /* 0x66 */
> +        X86_OP_ENTRYwr(TZCNT, G,v,   E,v,          zextT0), /* 0xf3 */
> +        X86_OP_ENTRY3(BSF,    G,d64, E,v, 2op,d64, zextT0), /* 0xf2 */
>      };
>      if (!(s->cpuid_ext3_features & CPUID_EXT3_ABM)) {
>          *entry =3D opcodes_0FBC[0];
> @@ -675,12 +681,18 @@ static void decode_0FBC(DisasContext *s, CPUX86Stat=
e *env, X86OpEntry *entry, ui
>
>  static void decode_0FBD(DisasContext *s, CPUX86State *env, X86OpEntry *e=
ntry, uint8_t *b)
>  {
> -    /* For BSR, pass 2op as the third operand so that we can use zextT0 =
*/
> +    /*
> +     * For BSR, pass 2op as the third operand so that we can use zextT0.
> +     * G/2op use d64 because clz already zero-extends the full 64-bit re=
sult,
> +     * and v would zero-extend the output register if the input is zero.
> +     * E stays v: forcing it to d64 too would scan the full 64-bit regis=
ter
> +     * instead of just the 32-bit source.
> +     */
>      static const X86OpEntry opcodes_0FBD[4] =3D {
> -        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0),
> -        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0x66 */
> -        X86_OP_ENTRYwr(LZCNT, G,v, E,v,        zextT0), /* 0xf3 */
> -        X86_OP_ENTRY3(BSR,    G,v, E,v, 2op,v, zextT0), /* 0xf2 */
> +        X86_OP_ENTRY3(BSR,    G,d64, E,v, 2op,d64, zextT0),
> +        X86_OP_ENTRY3(BSR,    G,d64, E,v, 2op,d64, zextT0), /* 0x66 */
> +        X86_OP_ENTRYwr(LZCNT, G,v,   E,v,          zextT0), /* 0xf3 */
> +        X86_OP_ENTRY3(BSR,    G,d64, E,v, 2op,d64, zextT0), /* 0xf2 */
>      };
>      if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
>          *entry =3D opcodes_0FBD[0];
> --
> 2.53.0
>

