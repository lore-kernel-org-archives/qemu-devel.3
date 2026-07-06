Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DF2C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqKn-0002qV-0r; Mon, 06 Jul 2026 16:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wgqKc-0002mi-SC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:54:24 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wgqKa-00012H-GE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:54:22 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-738a5cc517eso2348362137.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783371259; cv=none;
 d=google.com; s=arc-20260327;
 b=jRWHKGVGosFsNZ2EfDLNAFZXJKtahc3kAKR5low7XIbyLVAQf6e/TIr5airsJC6KVY
 bGwsxIe3vEjtj7ejqegkZrH+r1nfBTkQ22u1fTmAdMHOiKCXp+Y0wsio1Bsxxg1s/bYp
 2W65J4iMYSB2ycYHS5W6lJvIAo/CkMDBqGFb2pODBiSLikWWwPyGpbxi+JFU1zO3A8tl
 YxV6t9rK3NPbbtEcLcSt9TW6lWlxqbJp0vsujTYupGK0C+w/OZFBmhIcEpSRdyAZovnO
 KeexFof2TssvnZk5ly3vvDUNQbXn3dGv/i0qbmd0K4FN+FFZ9FJhKO//IfLp+AZpwKYj
 HkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6G86pGY0QD+YAYVXMft+uBy7ixwSawg0OPHqIX9cbh4=;
 fh=dFNjeIM34xA3zqR45OBPnrD/e5PWqK0VcUjJJ1xW+t4=;
 b=Tk6wP30w6l4p55+zF+A+pQjGsL4mQWBY0bDQfmH8jw0gydjWfC5BhTjXD6c5KM1FyP
 PbMQNubV+dbaXHg1mGxalpQqGFDMCVY4iYs4JJERwqLaKBoKfXDt64I9J+BQb6DUWqv4
 GJ6vv3pn9YBCIdcIFGRe7HyG6BEymo9KjNSBbFPxY1dLoKc7vZZ0cc2Wf1JeXVmFXTw1
 CBkkV7TQFxdTPEaJXlBPlLAAvv2CY7TgGwZ6wxKiE8lQlKyFzowbOJJPdbWIwkhEvFAt
 6CgnZBZ8hZzYi+MfA9l5DBEJ4jCOAe7CPCn5PLWHc18KcBAb4pPxvJFMBYeHKAvO1pss
 PV3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783371259; x=1783976059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6G86pGY0QD+YAYVXMft+uBy7ixwSawg0OPHqIX9cbh4=;
 b=O8QBhnv0BKZhMRe8eDrkXxwclhJaJ5G+BJfreX3J3cUgHbjOjDnGZY8sR8XSZpMheM
 N3mQ3xnFAPqkT83KVY5WI8HAMppgtyfiWyLIqn7ixBmFfpDavST/tVp0OsIKcyr8vU37
 FpaEEJ8slXpdthhuegcVVeCK9p0A1G9dErWJR+99wC4dp3oBQiZW1OhDapR7RJKuut2I
 OzVH5gWEPwriPWjzTkINPC3lXPYfFcRGGr4uxzDmTjck0k4pNM1rsuUp3pX7MmScMenm
 uZ6ROlkDFpodHAjqaBAFLqSHvHxoPgsepgE1F0ljEkI2XZq6ndOiOUMSZgAb0e5ds60T
 UAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371259; x=1783976059;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6G86pGY0QD+YAYVXMft+uBy7ixwSawg0OPHqIX9cbh4=;
 b=Xsklk+/vxUTu5PDS6ctc78eXZVexW5anX5dEhyd+NHgAz2gi6JITVDk41qZbtnA3RJ
 MkX+5YC1lcsz2PpyQWNLsMXSdRCdUfBHqICN+/OVNbsYWkpqNyPCGeVLi56Y0VTKabVt
 w5Hg5SPHtQDxxSKRthSPzxb6Y5PRWH8wKGokgbmG3R92anO3+OVWXZXiHGGPFYd9mR4I
 8sbn5W4y8sbJN9SYX9DOFbqwliin4/ozJeKLYMEBGn4PHNRak/fuFF09+CjVCweNigTS
 Gc4TNE+xY6sDadxs4C4tJjpLHGv6Cv4oIan5NhcKnkz0Modei3WKV+LRStW3xLktLQy7
 KEpw==
X-Gm-Message-State: AOJu0Yz9YlY0t0W6JOwpVl0Xlv/lI20HCtfwDAT4NjFEnrx+M8xlHvh4
 5WE/i8JrcqXa3Q/ljt+A68v5EgsbBkcvBKMbwxISvZ6GHvWLD+y4BgcYehC71Bjr7tHqrloKjSr
 pE3FrPLL77Lh+nN3AY8JKY7RTLLqnhG8=
X-Gm-Gg: AfdE7cmnxsNVbYFeZKnI658Q2vwdEccrwUpAcU5p0/K8JhWxioRmXdEphTqRuWQGJRE
 fuEdQujYZtGYZZiolwx03LTPWfccDsDl0/YZ5zjtN1mwsfuXKwxECRIPdqKzd0VAb/F8GgN/7pj
 m+lxtK6d1A1KV1Q0MFZHJ+cjxEPNVh7WiNLzEX8XZrkBKvp8pakMhkoh7uL1+VaLD9ZWUmXsUNE
 SJawPRrhkvX2AxGfjkg2Fx6Hupenbj8gS44Q8YnKd48ZCWynezmGpGO/EMTih5welM2AoQWi/H0
 ykyEEhnEGeobPILtXbWRDsX2same7+OaCJFjEi/u/+w5AcSRkLYJAybwWka+XjDdHbTZbSM/URn
 2VKFv9nUtqyA=
X-Received: by 2002:a05:6102:560f:b0:739:5cfb:50f6 with SMTP id
 ada2fe7eead31-744b7beadc7mr1223202137.11.1783371258999; Mon, 06 Jul 2026
 13:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
 <20260608-mips-octeon-missing-insns-v2-v16-12-daef7a0d8b04@gmail.com>
 <346b848d-465b-4560-9615-bd0575967b29@oss.qualcomm.com>
 <CADvTj4r0MwV7csi5iXrNyX10xqC=XAOZ-EfdfyLDC-JrzzGD9A@mail.gmail.com>
 <aeb90e22-dd44-4de2-b1c7-b3b81c131031@oss.qualcomm.com>
In-Reply-To: <aeb90e22-dd44-4de2-b1c7-b3b81c131031@oss.qualcomm.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 6 Jul 2026 14:54:07 -0600
X-Gm-Features: AVVi8Ccn4rmEfLLDPAEDbxePovLK79YMacEIESgvyZB5BvD6SisKt95MfeIPUsk
Message-ID: <CADvTj4r1_EQxzWB8g5_bA6Qmovvf56OApL7ycqT-LTJ1XaU+QQ@mail.gmail.com>
Subject: Re: [PATCH v16 12/21] target/mips: add Octeon HSH COP2 helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=james.hilliard1@gmail.com; helo=mail-vs1-xe32.google.com
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

On Mon, Jul 6, 2026 at 2:41=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 6/7/26 20:13, James Hilliard wrote:
> > On Mon, Jul 6, 2026 at 10:57=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> Hi James,
> >>
> >> On 8/6/26 20:59, James Hilliard wrote:
> >>> Add helper support for the Octeon HSH hash selectors. This includes t=
he
> >>> base HSH data/IV windows, MD5, SHA1, SHA256, and SHA512 transform pat=
hs,
> >>> and the shared HSH/SHA512 register-window readback and write operatio=
ns.
> >>>
> >>> The SHA512 path shares the wide HSH register bank with SHA3, SNOW3G, =
and
> >>> ZUC. Keep the aliased readback and write paths centralized so selecto=
r
> >>> decode can route register accesses through these helpers when side
> >>> effects are required.
> >>>
> >>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >>> ---
> >>> Changes v13 -> v14:
> >>>     - Keep HSH narrow DAT/IV state updates in the low 32-bit halves o=
f the
> >>>       architectural HSH register bank so paired selector transfers pr=
eserve
> >>>       the wide shared-window state.
> >>>
> >>> Changes v10 -> v13:
> >>>     - Keep the 0x0057 SDK compatibility path as an explicit STARTSHA1
> >>>       compatibility helper instead of a generic STARTSHA name.
> >>>
> >>> Changes v9 -> v10:
> >>>     - Remove references to shared-mode tracking; aliased state is kep=
t in the
> >>>       architectural HSH register banks.
> >>>
> >>> Changes v8 -> v9:
> >>>     - Split HSH/SHA helpers into their own COP2 helper patch.
> >>>     - Replace generic selector dispatch with per-operation HSH helper=
s.
> >>>     - Keep shared-window readback and write helpers grouped with HSH.
> >>>     - Add matching helper.h declarations with the helper implementati=
on.
> >>> ---
> >>>    target/mips/helper.h            |   5 +
> >>>    target/mips/tcg/octeon_crypto.c | 375 ++++++++++++++++++++++++++++=
++++++++++++
> >>>    2 files changed, 380 insertions(+)
> >>>
> >>> diff --git a/target/mips/helper.h b/target/mips/helper.h
> >>> index 71b7a2b30e..834f2d0769 100644
> >>> --- a/target/mips/helper.h
> >>> +++ b/target/mips/helper.h
> >>> @@ -69,6 +69,11 @@ DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i6=
4)
> >>>    DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
> >>>    DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
> >>>    DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
> >>> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha1_compat, void, env, i64)
> >>> +DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
> >>> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
> >>> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
> >>> +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
> >>>
> >>>    /* microMIPS functions */
> >>>    DEF_HELPER_4(lwm, void, env, tl, tl, i32)
> >>> diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon=
_crypto.c
> >>> index 67959618cc..9523c84667 100644
> >>> --- a/target/mips/tcg/octeon_crypto.c
> >>> +++ b/target/mips/tcg/octeon_crypto.c
> >>> @@ -153,6 +153,348 @@ static void octeon_gfm_mul64_uia2(const uint64_=
t x[2], const uint64_t y[2],
> >>>        out[1] =3D revbit64(res);
> >>>    }
> >>>
> >>> +static inline uint32_t octeon_hsh_get32(const uint64_t *regs,
> >>> +                                        unsigned int index)
> >>> +{
> >>> +    return regs[index];
> >>> +}
> >>> +
> >>> +static inline void octeon_hsh_set32(uint64_t *regs, unsigned int ind=
ex,
> >>> +                                    uint32_t value)
> >>> +{
> >>> +    regs[index] =3D (regs[index] & ~(uint64_t)UINT32_MAX) | value;
> >>> +}
> >>> +
> >>> +static inline void octeon_hsh_set_pair(uint64_t *regs, unsigned int =
index,
> >>> +                                       uint64_t value)
> >>> +{
> >>> +    octeon_hsh_set32(regs, index * 2, value >> 32);
> >>> +    octeon_hsh_set32(regs, index * 2 + 1, value);
> >>> +}
> >>> +
> >>> +static void octeon_md5_transform(MIPSOcteonCryptoState *crypto)
> >>> +{
> >>> +    static const uint32_t k[64] =3D {
> >>> +        0xd76aa478U, 0xe8c7b756U, 0x242070dbU, 0xc1bdceeeU,
> >>> +        0xf57c0fafU, 0x4787c62aU, 0xa8304613U, 0xfd469501U,
> >>> +        0x698098d8U, 0x8b44f7afU, 0xffff5bb1U, 0x895cd7beU,
> >>> +        0x6b901122U, 0xfd987193U, 0xa679438eU, 0x49b40821U,
> >>> +        0xf61e2562U, 0xc040b340U, 0x265e5a51U, 0xe9b6c7aaU,
> >>> +        0xd62f105dU, 0x02441453U, 0xd8a1e681U, 0xe7d3fbc8U,
> >>> +        0x21e1cde6U, 0xc33707d6U, 0xf4d50d87U, 0x455a14edU,
> >>> +        0xa9e3e905U, 0xfcefa3f8U, 0x676f02d9U, 0x8d2a4c8aU,
> >>> +        0xfffa3942U, 0x8771f681U, 0x6d9d6122U, 0xfde5380cU,
> >>> +        0xa4beea44U, 0x4bdecfa9U, 0xf6bb4b60U, 0xbebfbc70U,
> >>> +        0x289b7ec6U, 0xeaa127faU, 0xd4ef3085U, 0x04881d05U,
> >>> +        0xd9d4d039U, 0xe6db99e5U, 0x1fa27cf8U, 0xc4ac5665U,
> >>> +        0xf4292244U, 0x432aff97U, 0xab9423a7U, 0xfc93a039U,
> >>> +        0x655b59c3U, 0x8f0ccc92U, 0xffeff47dU, 0x85845dd1U,
> >>> +        0x6fa87e4fU, 0xfe2ce6e0U, 0xa3014314U, 0x4e0811a1U,
> >>> +        0xf7537e82U, 0xbd3af235U, 0x2ad7d2bbU, 0xeb86d391U,
> >>> +    };
> >>> +    static const uint8_t s[64] =3D {
> >>> +        7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
> >>> +        5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20,
> >>> +        4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
> >>> +        6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
> >>> +    };
> >>> +    uint32_t m[16];
> >>> +    uint32_t a, b, c, d;
> >>> +    uint32_t aa, bb, cc, dd;
> >>> +    int i;
> >>> +
> >>> +    for (i =3D 0; i < 16; i++) {
> >>> +        m[i] =3D bswap32(octeon_hsh_get32(crypto->hsh_dat, i));
> >>> +    }
> >>> +
> >>> +    a =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 0));
> >>> +    b =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 1));
> >>> +    c =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 2));
> >>> +    d =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 3));
> >>
> >> The MD5 algorithm is little-endian, so I think for these we want
> >> cpu_to_le32(), ...
> >
> > Looking at the CN71XX manual, I think the current handling matches the
> > architectural HSH register view.  The HSH DAT/IV narrow selectors build
> > HASHDAT/HASHIV words from GPR halves, and the SHA-512 wide selectors mo=
ve
> > whole GPR values into HASHDAT/HASHIV.  These are COP2 register values,
> > not target-memory byte arrays.
> >
> > The manual calls out MD5 specially: HASHDAT/HASHIV are in the big-endia=
n
> > HSH register-word order, while MD5 is little-endian, so the MD5 operati=
on
> > byte-swaps HASHDAT/HASHIV on entry and exit.  That is what the current
> > bswap32() calls model.
>
> This call works on little endian hosts, because the target CPU is only
> built for big-endian in user-mode. I don't expect your tests to pass on
> a big-endian host, because we don't want to swap in this case.

I agree those helpers are host-endian conversions, but that is why I
don't think they apply here.

The HSH state is modeled as architectural COP2 register values, not as a
host byte array. The narrow HSH DAT/IV selectors split GPR[rt] into
HASHDAT/HASHIV low-32 register words, and the translator already handles
host layout when placing those low 32 bits in the uint64_t state. After
that, octeon_hsh_get32() is reading an architectural register word.

For MD5, the CN71XX manual describes a byte swap between the HSH
big-endian register-word view and MD5's little-endian word order. That
swap is part of the Octeon operation, so it must be unconditional with
respect to the QEMU host. Using cpu_to_le32() would make it host-dependent:
identity on little-endian hosts and swapped on big-endian hosts.

Likewise, the SHA paths consume the HSH register words directly in the
manual pseudo-code, with no analogous MD5 byte-swap step. Using
cpu_to_be32()/be32_to_cpu() there would also introduce host-dependent
behavior that the modeled hardware operation does not have.

> See in include/qemu/bswap.h:
>
>   60  * Endianness conversion functions between host cpu and specified
> endianness.
>   63  *
>   64  * uint16_t le16_to_cpu(uint16_t v);
>   65  * uint32_t le32_to_cpu(uint32_t v);
>   66  * uint64_t le64_to_cpu(uint64_t v);
>   67  * uint16_t be16_to_cpu(uint16_t v);
>   68  * uint32_t be32_to_cpu(uint32_t v);
>   69  * uint64_t be64_to_cpu(uint64_t v);
>   70  *
>   71  * Convert the value @v from the specified format to the native
>   72  * endianness of the host CPU by byteswapping if necessary, and
>   73  * return the converted value.
>   74  *
>   75  * uint16_t cpu_to_le16(uint16_t v);
>   76  * uint32_t cpu_to_le32(uint32_t v);
>   77  * uint64_t cpu_to_le64(uint64_t v);
>   78  * uint16_t cpu_to_be16(uint16_t v);
>   79  * uint32_t cpu_to_be32(uint32_t v);
>   80  * uint64_t cpu_to_be64(uint64_t v);
>   81  *
>   82  * Convert the value @v from the native endianness of the host CPU
>   83  * to the specified format by byteswapping if necessary, and return
>   84  * the converted value.
>
> >
> >>> +    aa =3D a;
> >>> +    bb =3D b;
> >>> +    cc =3D c;
> >>> +    dd =3D d;
> >>> +
> >>> +    for (i =3D 0; i < 64; i++) {
> >>> +        uint32_t f, g, tmp;
> >>> +
> >>> +        if (i < 16) {
> >>> +            f =3D (b & c) | ((~b) & d);
> >>> +            g =3D i;
> >>> +        } else if (i < 32) {
> >>> +            f =3D (d & b) | ((~d) & c);
> >>> +            g =3D (5 * i + 1) & 0xf;
> >>> +        } else if (i < 48) {
> >>> +            f =3D b ^ c ^ d;
> >>> +            g =3D (3 * i + 5) & 0xf;
> >>> +        } else {
> >>> +            f =3D c ^ (b | (~d));
> >>> +            g =3D (7 * i) & 0xf;
> >>> +        }
> >>> +
> >>> +        tmp =3D d;
> >>> +        d =3D c;
> >>> +        c =3D b;
> >>> +        b =3D b + rol32(a + f + k[i] + m[g], s[i]);
> >>> +        a =3D tmp;
> >>> +    }
> >>> +
> >>> +    a +=3D aa;
> >>> +    b +=3D bb;
> >>> +    c +=3D cc;
> >>> +    d +=3D dd;
> >>> +    octeon_hsh_set32(crypto->hsh_iv, 0, bswap32(a));
> >>> +    octeon_hsh_set32(crypto->hsh_iv, 1, bswap32(b));
> >>> +    octeon_hsh_set32(crypto->hsh_iv, 2, bswap32(c));
> >>> +    octeon_hsh_set32(crypto->hsh_iv, 3, bswap32(d));
> >>
> >> ... and le32_to_cpu() here.
> >>
> >>> +}
> >>> +
> >>> +static void octeon_sha1_transform(MIPSOcteonCryptoState *crypto)
> >>> +{
> >>> +    uint32_t w[80];
> >>> +    uint32_t a, b, c, d, e;
> >>> +    uint32_t orig[5];
> >>> +    int i;
> >>> +
> >>> +    for (i =3D 0; i < 16; i++) {
> >>> +        w[i] =3D octeon_hsh_get32(crypto->hsh_dat, i);
> >>> +    }
> >>> +    for (i =3D 16; i < 80; i++) {
> >>> +        w[i] =3D rol32(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], =
1);
> >>> +    }
> >>> +
> >>> +    for (i =3D 0; i < 5; i++) {
> >>> +        orig[i] =3D octeon_hsh_get32(crypto->hsh_iv, i);
> >>> +    }
> >>
> >> SHA is big-endian so we are good, but watch out this CPU could switch
> >> endianness.
> >>
> >> Maybe safer to use cpu_to_be32() and be32_to_cpu()?
> >
> > For SHA-1, SHA-256, and SHA-512, the manual pseudo-code feeds the HSH
> > register words directly into the SHA operation and does not describe a
> > similar byte-swap.  So using cpu_to_be32()/be32_to_cpu() here would
> > byte-swap based on host endianness, which is not the architectural HSH
> > operation.
> >
> >>> +    a =3D orig[0];
> >>> +    b =3D orig[1];
> >>> +    c =3D orig[2];
> >>> +    d =3D orig[3];
> >>> +    e =3D orig[4];
> >>> +
> >>> +    for (i =3D 0; i < 80; i++) {
> >>> +        uint32_t f, k, temp;
> >>> +
> >>> +        if (i < 20) {
> >>> +            f =3D (b & c) | ((~b) & d);
> >>> +            k =3D 0x5a827999;
> >>> +        } else if (i < 40) {
> >>> +            f =3D b ^ c ^ d;
> >>> +            k =3D 0x6ed9eba1;
> >>> +        } else if (i < 60) {
> >>> +            f =3D (b & c) | (b & d) | (c & d);
> >>> +            k =3D 0x8f1bbcdc;
> >>> +        } else {
> >>> +            f =3D b ^ c ^ d;
> >>> +            k =3D 0xca62c1d6;
> >>> +        }
> >>> +
> >>> +        temp =3D rol32(a, 5) + f + e + k + w[i];
> >>> +        e =3D d;
> >>> +        d =3D c;
> >>> +        c =3D rol32(b, 30);
> >>> +        b =3D a;
> >>> +        a =3D temp;
> >>> +    }
> >>> +
> >>> +    orig[0] +=3D a;
> >>> +    orig[1] +=3D b;
> >>> +    orig[2] +=3D c;
> >>> +    orig[3] +=3D d;
> >>> +    orig[4] +=3D e;
> >>> +    for (i =3D 0; i < 5; i++) {
> >>> +        octeon_hsh_set32(crypto->hsh_iv, i, orig[i]);
> >>> +    }
> >>> +}
> >>> +
> >>> +static void octeon_sha256_transform(MIPSOcteonCryptoState *crypto)
> >>> +{
> >>
> >> (ditto)
> >>
> >>> +}
> >>> +
> >>> +static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
> >>> +{
> >>
> >> (ditto)
> >>
> >>> +}
> >
>

