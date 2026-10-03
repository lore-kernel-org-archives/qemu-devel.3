Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE1CCA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 08:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCush-0002wc-OX; Sat, 03 Oct 2026 04:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1xCusc-0002wA-5A
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:14:03 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1xCusa-0003e3-9j
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:14:01 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8abd68b3937so2618737b3.2
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 01:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791015239; cv=none;
 d=google.com; s=arc-20260327;
 b=B3LT7+cK96/bsGZeVdQgZNJW6Jl+8yVFSjj8WcVOyuKVhWDP+Nqj9xv8yN6mszFiR5
 I9kQgRMIzsl15HBs+11whcdl1+dPiZZrjTo0CzglMaCjHOiKFTIU+k2TEqR6ArzRTT6z
 JCe2IFOfqF481fgtfLrH0JVq/YZqYQch0t/vPqmujU0/iZeiZMN4c9FrStSCyD8sntp+
 OgsHP/qsUmnzd82ddZbu9NUU6mVGqiWrsqAetp2/veRCg8gOqzyFfp+Bj4VDu89R7KC3
 pkqo9qbQ/Ng+yargmGKjVirzuHSsvJ8IRHiRadS0zhYr0pW5crhfT6OLHDL+7ydRzMJP
 YcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KymOpsceh2k9lu9WhgqcPhyC8Yo8s519n2MjusMGU8w=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=Ds2jQcKyIWMMGulEtMeFjqiKAW+H8dvUMwT+Yb/EiSIv6VWPocHbAbTiHllcj4ScSh
 SkQaChkWbzvnqPx0sGwsVslKZwvZXp0Njafi7ufo1bKNU6BwzlQ3n2I5AXqztHViXFMx
 9IbnWVrmt0U8xVLToJdVyTRsKasbvlMAv3qQydigSD6UKof3wliZFv9FDM43rz+RESba
 rwQSe0v/FbuVtNatX4bsAb/6MSbMeiO+cNHwBW1fA4lFVUhMKPa3W/++lU4il37az3bH
 Z85SADN5VChkgz7a3EAgKpyTChK6SCyy8APgZpD66AhXu8t2HiS777rac4wdLPCgtjnz
 6xaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791015239; x=1791620039; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KymOpsceh2k9lu9WhgqcPhyC8Yo8s519n2MjusMGU8w=;
 b=BpZOj0eZKGL3/pma/UmWfmctpjQu6uTCkSEHs0h39gOYEtzvKPg7iZAxJ+30pFNQb4
 T0x7YLGjokQecWb63Z7KQ6BcxOomDOjM5lD5I9pzriaonP9xtcsa0JT7zt3k4hDzcFZ1
 y7YLgoClzcQ2gI5LyE+p0887xUbSSS9nY1ZAiB9oe7jmz+X0s6NpBN5tZNTrYB2K7l0u
 0scbF5FOo/ZNc1UldOe6eHuIGAAHv4PipK4AzK7LAbBzs6PlXEmGu91vTysTcN/MhDUD
 0KZ5s4VcWQkjXqEMdXfyvrhp9U5o8szqtubS8zabpReKXLyzJJ4z7iYHPbHjPwc4YVZE
 pMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791015239; x=1791620039;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KymOpsceh2k9lu9WhgqcPhyC8Yo8s519n2MjusMGU8w=;
 b=B6b5Bh1d7QwaJNv+I+9KeRaQYLkzdXWOU84DO36nrjenKB2UtvfExVMbIYGN9OqDdQ
 I7bQjLZbrbKhlpuVpzOe4m2TnrUHOohZaDKx+izmpjxN2Rkv7FWkWsa1qKYhlLEc2rci
 YnHVdOmzCQlGIjy8U0Hc5lbUsYrW/cr+F1PbozRb2TDWDC8db9wdbdzd6HBB4edpsG3+
 kA1OvB0lHXUNwfWX9CmC13mkJpiANZhuEaq1ey+f62ceGMVnOyeZD749JIc01qAoZD/B
 TAOwm/1tNAV7bMS56eZ9MZXt0qu+J978aUC3haW6eyeFIo0dkxWPdDjtx+giWFboR5yj
 9YtA==
X-Gm-Message-State: AFq9FYJRCOhpltnHpQLhp9Rt2FgzyPu2xGU45+AyEklTGdyvojJ5CBfF
 MOm+bzx/+1l3BnEpCCDNUzBmBiYiNQBs4+dMmLnxLAGuzJy2CX+N+H33NeoEEa0YafwChSLjwEJ
 N2Z+ulUWLMgl/m76Eta2xjFBdEO8ZJRdV+qThTOw=
X-Gm-Gg: AYBFou0lWMgaP4JI39wlXDP1tb4YM1CnIm4pUha1kSo/TFWIRXIVNUOKbqCDeBvHwnV
 myOeSSY6/QQHmzavdYb4zXeRqeIaDkxjL4KtPgYGC4XORbRxavnCek9aWCri76IqoSp4RcHiHDw
 nqUCtsXP+8P106BYERFE9TmDJdqGN8hXsbuTDFVPIXsKtPZuxbNrvF2SBhxRBS4tpvmEZLOlPwi
 ccZL6IBScJmuhjmpEJb+AyTe4Y1dqNqi7iVj72/7Zy222I2h1daYA8DidKRd4lnhYcnPbcyZuuD
 ZfJbM6DkhUBaQyunkFxbOaa6H4uPo1WxaU9g1DVX9I2lXFk2rrysfvj1miX77cvp4zBSskLaMOc
 /aY0U/4LjMjCeQrr2czJ7EVQA1ZWEeGnTZgVmBS5r
X-Received: by 2002:a05:690c:3481:b0:873:5bb2:6c0e with SMTP id
 00721157ae682-8ae957d5b61mr8406267b3.56.1791015238976; Sat, 03 Oct 2026
 01:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260807170751.390792-1-scherer.simon89@gmail.com>
In-Reply-To: <20260807170751.390792-1-scherer.simon89@gmail.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Sat, 3 Oct 2026 10:13:48 +0200
X-Gm-Features: AclHuK9beSudgxf6ilQgBZd5BpAhWmxqePmDIZ9hG9B8aqs2MndoGW1QXtSsoKU
Message-ID: <CAEQwQtKA5+fwE+DQg+rG_teBrH4f_Eb2yf4QiyUEkxPQcDnzPA@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: do not zero-extend BSR/BSF dest when
 source is zero
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yw1-x1130.google.com
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

Ping. Maybe the patch has been missed.

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

