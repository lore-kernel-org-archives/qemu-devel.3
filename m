Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74362C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnoo-0001vp-4R; Mon, 06 Jul 2026 14:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wgnom-0001vg-O2
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:13:21 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wgnok-0006vI-N7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:13:20 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-7389cff36bdso742866137.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 11:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783361597; cv=none;
 d=google.com; s=arc-20260327;
 b=DYL5CsWm5/UYExe22E7cBn5ggL64CyZ35PFZmOQUN864SjqntIPTvte4NcsaVgeIDQ
 4zd9JJQ+WyueDc7zU8tv4SX4yUMx3rqjFwq361uiG5vAFrt20PcJX/wL4SlJDpfE+KSc
 rl9bD4xZBO21XBgHDb6UKkDBBX1SPNsPa3vAZtc7xXEzDShjlTfQcenQao+K4OQ0SduF
 iTHam5AtHjG9VCM+8ZjqvwT3+K/sEbTc01ZdrRpeuiTWmHx7y2sZbnCwZcISJfdqPbPH
 Aap30gBT5TYvRgjnWSiyMCsjYd1+id1P71xnG8jePGojCeH98vq8udHgTKxWqzUvLEVE
 IWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4fiahFzfoASVOuykAmvuolHfkjiJ4pPViiTVmPhv//w=;
 fh=dFNjeIM34xA3zqR45OBPnrD/e5PWqK0VcUjJJ1xW+t4=;
 b=PT4ruam+rRTttapeARvH8lgBulKJxMF/7kCoWON+3QRHy6mqwUIYM5cjMo3IMTL9v1
 QLHofZ9iXdDQqSovkrhe7UXwGYNQkf/cuRvQkfBEJOGtsSketHffe/eQW5LlxEPfCC05
 9OZrRe/swWalIu7L+ECX2dDLMAz2iuHt0UnQIonBU7Moljizo+YLr0idturgP9Chg4cz
 KrO6cmt1zl6UzNxXBsk23A2F2NYb7IFmMjE1WNCPv44ytyhMh2W1ouzJ+u4qAm9njEmm
 jA3CWg3WR+HSgPu0dxh+C2aeS/N+cc2fw01xTYkyUiQ67KDrsGF82CZXITsxvBkkJUvg
 F71g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783361597; x=1783966397; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fiahFzfoASVOuykAmvuolHfkjiJ4pPViiTVmPhv//w=;
 b=k9VZWDQfPGJ8jounSpxVNboU5rxS2qTQGSHkAsbSXffBT7I8rm2MrzIOkIjxvcmrC9
 zpJ4ZjaF9z0FuZjM0zdg2z0T8EfUxnjMaD90A9bM/czNIE+e1X9in098uU53WXYBAJ8/
 lJCox/L1b1ERbAKVvJ/wU+Y71Ta86M6Cp/iymGtMNjPgjlxwL/2zBW7oYsP/gpVjGAgQ
 /tE9JH+xeTTXLLIvWvV635Ef0T5WHEbFmVmQVtOBmHcPYGRG93+eD2Dk0xLv8YtczQtf
 u7iaY/6GdFjtRfxwSwQv2IAfrkIr20D4hVGIPkplGi/0LmTqi9PmCyJZ0wT5t9hthycY
 mb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783361597; x=1783966397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4fiahFzfoASVOuykAmvuolHfkjiJ4pPViiTVmPhv//w=;
 b=aQgrntJJr9n5NgmQi0auSp3exl6BTYizCk0LDa3zSHqlLcDZk4owkTTgESW+00uaQK
 sBj74c65LSF+lzEZ/fQXLDIivjeOz1W43cGzAjxRbfwBEqz/fEdwee9F9K6d5+S9hT3L
 WNYqQcxSK0supT8xAnVxZgZzh/jX6ty0U73FJntNO/AvCSjAHH4D8AT1U5bwHriFpS4S
 OQD5CLGZ2seDBYORGKIjutHTrHer7OS+0P3aOhktJa8K64teygdEh8SD97ZkGYwJmv+9
 og8l+5mTX5aiOyDnE40L+ndCk/yQmjR7XptMdUs/JTAxdTm56L7VfWkKgCE1+gRSvIYn
 NibQ==
X-Gm-Message-State: AOJu0Yxbdn1zcBu3oB/u5aKK1nuVwVbufftKCcUb3p1yd/mC5eslKpcJ
 RdD6hdmx3iwbi7+ALhtoubfJjG14WtJ/+kLqYkNiV+/JgBUZnohg5ZsRgeoFDQC1GqTJlaXo/oF
 cD8TiWXRVYDWC3EouZ593RPkN4MbxCWs=
X-Gm-Gg: AfdE7ckyKCtn9oCVWC33lcKqflNXxJmW286Gt3YQSKML19SeQmXfbNAynh/F+cQhK3n
 N0okcym4iziNqZwfKIP8JzUD/XvyUPivvxjzQiy/wIcStiaxOZviSFl1+tV3FHCE7/jpmgkX77o
 ZLhZKIP27iH7PcgjGeVX1o3Vde+JUH4bLdxnu+TrzU7fmOCX26DvzRntVFLunE2n3KHnSnaqtOJ
 6Jd31BJmNu8CXJyEqMOo5hyUID1FZTSCQPaL9U67BC5KP/bhyYIfRRAvuVqbQda6KS8b7ICWvXD
 k2/xFOr16GwJPtzwxDM96MwbYugHMsReK22/Etxu4dlFyTc98M7Vv/HMVausXi5NN0acjn8gJrK
 0KaeD8nHYLQieeuDC0AE4Uw==
X-Received: by 2002:a05:6102:5789:b0:736:e617:b4f7 with SMTP id
 ada2fe7eead31-744b7d8481dmr865056137.21.1783361597104; Mon, 06 Jul 2026
 11:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
 <20260608-mips-octeon-missing-insns-v2-v16-12-daef7a0d8b04@gmail.com>
 <346b848d-465b-4560-9615-bd0575967b29@oss.qualcomm.com>
In-Reply-To: <346b848d-465b-4560-9615-bd0575967b29@oss.qualcomm.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 6 Jul 2026 12:13:06 -0600
X-Gm-Features: AVVi8Ccnfi6lPejTKbC4WJYp681LtbCOW08fW31GAod0NBBOd5BNvRGvPzew5b0
Message-ID: <CADvTj4r0MwV7csi5iXrNyX10xqC=XAOZ-EfdfyLDC-JrzzGD9A@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Mon, Jul 6, 2026 at 10:57=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi James,
>
> On 8/6/26 20:59, James Hilliard wrote:
> > Add helper support for the Octeon HSH hash selectors. This includes the
> > base HSH data/IV windows, MD5, SHA1, SHA256, and SHA512 transform paths=
,
> > and the shared HSH/SHA512 register-window readback and write operations=
.
> >
> > The SHA512 path shares the wide HSH register bank with SHA3, SNOW3G, an=
d
> > ZUC. Keep the aliased readback and write paths centralized so selector
> > decode can route register accesses through these helpers when side
> > effects are required.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v13 -> v14:
> >    - Keep HSH narrow DAT/IV state updates in the low 32-bit halves of t=
he
> >      architectural HSH register bank so paired selector transfers prese=
rve
> >      the wide shared-window state.
> >
> > Changes v10 -> v13:
> >    - Keep the 0x0057 SDK compatibility path as an explicit STARTSHA1
> >      compatibility helper instead of a generic STARTSHA name.
> >
> > Changes v9 -> v10:
> >    - Remove references to shared-mode tracking; aliased state is kept i=
n the
> >      architectural HSH register banks.
> >
> > Changes v8 -> v9:
> >    - Split HSH/SHA helpers into their own COP2 helper patch.
> >    - Replace generic selector dispatch with per-operation HSH helpers.
> >    - Keep shared-window readback and write helpers grouped with HSH.
> >    - Add matching helper.h declarations with the helper implementation.
> > ---
> >   target/mips/helper.h            |   5 +
> >   target/mips/tcg/octeon_crypto.c | 375 +++++++++++++++++++++++++++++++=
+++++++++
> >   2 files changed, 380 insertions(+)
> >
> > diff --git a/target/mips/helper.h b/target/mips/helper.h
> > index 71b7a2b30e..834f2d0769 100644
> > --- a/target/mips/helper.h
> > +++ b/target/mips/helper.h
> > @@ -69,6 +69,11 @@ DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
> >   DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
> >   DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
> >   DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
> > +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha1_compat, void, env, i64)
> > +DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
> > +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
> > +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
> > +DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
> >
> >   /* microMIPS functions */
> >   DEF_HELPER_4(lwm, void, env, tl, tl, i32)
> > diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_c=
rypto.c
> > index 67959618cc..9523c84667 100644
> > --- a/target/mips/tcg/octeon_crypto.c
> > +++ b/target/mips/tcg/octeon_crypto.c
> > @@ -153,6 +153,348 @@ static void octeon_gfm_mul64_uia2(const uint64_t =
x[2], const uint64_t y[2],
> >       out[1] =3D revbit64(res);
> >   }
> >
> > +static inline uint32_t octeon_hsh_get32(const uint64_t *regs,
> > +                                        unsigned int index)
> > +{
> > +    return regs[index];
> > +}
> > +
> > +static inline void octeon_hsh_set32(uint64_t *regs, unsigned int index=
,
> > +                                    uint32_t value)
> > +{
> > +    regs[index] =3D (regs[index] & ~(uint64_t)UINT32_MAX) | value;
> > +}
> > +
> > +static inline void octeon_hsh_set_pair(uint64_t *regs, unsigned int in=
dex,
> > +                                       uint64_t value)
> > +{
> > +    octeon_hsh_set32(regs, index * 2, value >> 32);
> > +    octeon_hsh_set32(regs, index * 2 + 1, value);
> > +}
> > +
> > +static void octeon_md5_transform(MIPSOcteonCryptoState *crypto)
> > +{
> > +    static const uint32_t k[64] =3D {
> > +        0xd76aa478U, 0xe8c7b756U, 0x242070dbU, 0xc1bdceeeU,
> > +        0xf57c0fafU, 0x4787c62aU, 0xa8304613U, 0xfd469501U,
> > +        0x698098d8U, 0x8b44f7afU, 0xffff5bb1U, 0x895cd7beU,
> > +        0x6b901122U, 0xfd987193U, 0xa679438eU, 0x49b40821U,
> > +        0xf61e2562U, 0xc040b340U, 0x265e5a51U, 0xe9b6c7aaU,
> > +        0xd62f105dU, 0x02441453U, 0xd8a1e681U, 0xe7d3fbc8U,
> > +        0x21e1cde6U, 0xc33707d6U, 0xf4d50d87U, 0x455a14edU,
> > +        0xa9e3e905U, 0xfcefa3f8U, 0x676f02d9U, 0x8d2a4c8aU,
> > +        0xfffa3942U, 0x8771f681U, 0x6d9d6122U, 0xfde5380cU,
> > +        0xa4beea44U, 0x4bdecfa9U, 0xf6bb4b60U, 0xbebfbc70U,
> > +        0x289b7ec6U, 0xeaa127faU, 0xd4ef3085U, 0x04881d05U,
> > +        0xd9d4d039U, 0xe6db99e5U, 0x1fa27cf8U, 0xc4ac5665U,
> > +        0xf4292244U, 0x432aff97U, 0xab9423a7U, 0xfc93a039U,
> > +        0x655b59c3U, 0x8f0ccc92U, 0xffeff47dU, 0x85845dd1U,
> > +        0x6fa87e4fU, 0xfe2ce6e0U, 0xa3014314U, 0x4e0811a1U,
> > +        0xf7537e82U, 0xbd3af235U, 0x2ad7d2bbU, 0xeb86d391U,
> > +    };
> > +    static const uint8_t s[64] =3D {
> > +        7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
> > +        5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20,
> > +        4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
> > +        6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
> > +    };
> > +    uint32_t m[16];
> > +    uint32_t a, b, c, d;
> > +    uint32_t aa, bb, cc, dd;
> > +    int i;
> > +
> > +    for (i =3D 0; i < 16; i++) {
> > +        m[i] =3D bswap32(octeon_hsh_get32(crypto->hsh_dat, i));
> > +    }
> > +
> > +    a =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 0));
> > +    b =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 1));
> > +    c =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 2));
> > +    d =3D bswap32(octeon_hsh_get32(crypto->hsh_iv, 3));
>
> The MD5 algorithm is little-endian, so I think for these we want
> cpu_to_le32(), ...

Looking at the CN71XX manual, I think the current handling matches the
architectural HSH register view.  The HSH DAT/IV narrow selectors build
HASHDAT/HASHIV words from GPR halves, and the SHA-512 wide selectors move
whole GPR values into HASHDAT/HASHIV.  These are COP2 register values,
not target-memory byte arrays.

The manual calls out MD5 specially: HASHDAT/HASHIV are in the big-endian
HSH register-word order, while MD5 is little-endian, so the MD5 operation
byte-swaps HASHDAT/HASHIV on entry and exit.  That is what the current
bswap32() calls model.

> > +    aa =3D a;
> > +    bb =3D b;
> > +    cc =3D c;
> > +    dd =3D d;
> > +
> > +    for (i =3D 0; i < 64; i++) {
> > +        uint32_t f, g, tmp;
> > +
> > +        if (i < 16) {
> > +            f =3D (b & c) | ((~b) & d);
> > +            g =3D i;
> > +        } else if (i < 32) {
> > +            f =3D (d & b) | ((~d) & c);
> > +            g =3D (5 * i + 1) & 0xf;
> > +        } else if (i < 48) {
> > +            f =3D b ^ c ^ d;
> > +            g =3D (3 * i + 5) & 0xf;
> > +        } else {
> > +            f =3D c ^ (b | (~d));
> > +            g =3D (7 * i) & 0xf;
> > +        }
> > +
> > +        tmp =3D d;
> > +        d =3D c;
> > +        c =3D b;
> > +        b =3D b + rol32(a + f + k[i] + m[g], s[i]);
> > +        a =3D tmp;
> > +    }
> > +
> > +    a +=3D aa;
> > +    b +=3D bb;
> > +    c +=3D cc;
> > +    d +=3D dd;
> > +    octeon_hsh_set32(crypto->hsh_iv, 0, bswap32(a));
> > +    octeon_hsh_set32(crypto->hsh_iv, 1, bswap32(b));
> > +    octeon_hsh_set32(crypto->hsh_iv, 2, bswap32(c));
> > +    octeon_hsh_set32(crypto->hsh_iv, 3, bswap32(d));
>
> ... and le32_to_cpu() here.
>
> > +}
> > +
> > +static void octeon_sha1_transform(MIPSOcteonCryptoState *crypto)
> > +{
> > +    uint32_t w[80];
> > +    uint32_t a, b, c, d, e;
> > +    uint32_t orig[5];
> > +    int i;
> > +
> > +    for (i =3D 0; i < 16; i++) {
> > +        w[i] =3D octeon_hsh_get32(crypto->hsh_dat, i);
> > +    }
> > +    for (i =3D 16; i < 80; i++) {
> > +        w[i] =3D rol32(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1)=
;
> > +    }
> > +
> > +    for (i =3D 0; i < 5; i++) {
> > +        orig[i] =3D octeon_hsh_get32(crypto->hsh_iv, i);
> > +    }
>
> SHA is big-endian so we are good, but watch out this CPU could switch
> endianness.
>
> Maybe safer to use cpu_to_be32() and be32_to_cpu()?

For SHA-1, SHA-256, and SHA-512, the manual pseudo-code feeds the HSH
register words directly into the SHA operation and does not describe a
similar byte-swap.  So using cpu_to_be32()/be32_to_cpu() here would
byte-swap based on host endianness, which is not the architectural HSH
operation.

> > +    a =3D orig[0];
> > +    b =3D orig[1];
> > +    c =3D orig[2];
> > +    d =3D orig[3];
> > +    e =3D orig[4];
> > +
> > +    for (i =3D 0; i < 80; i++) {
> > +        uint32_t f, k, temp;
> > +
> > +        if (i < 20) {
> > +            f =3D (b & c) | ((~b) & d);
> > +            k =3D 0x5a827999;
> > +        } else if (i < 40) {
> > +            f =3D b ^ c ^ d;
> > +            k =3D 0x6ed9eba1;
> > +        } else if (i < 60) {
> > +            f =3D (b & c) | (b & d) | (c & d);
> > +            k =3D 0x8f1bbcdc;
> > +        } else {
> > +            f =3D b ^ c ^ d;
> > +            k =3D 0xca62c1d6;
> > +        }
> > +
> > +        temp =3D rol32(a, 5) + f + e + k + w[i];
> > +        e =3D d;
> > +        d =3D c;
> > +        c =3D rol32(b, 30);
> > +        b =3D a;
> > +        a =3D temp;
> > +    }
> > +
> > +    orig[0] +=3D a;
> > +    orig[1] +=3D b;
> > +    orig[2] +=3D c;
> > +    orig[3] +=3D d;
> > +    orig[4] +=3D e;
> > +    for (i =3D 0; i < 5; i++) {
> > +        octeon_hsh_set32(crypto->hsh_iv, i, orig[i]);
> > +    }
> > +}
> > +
> > +static void octeon_sha256_transform(MIPSOcteonCryptoState *crypto)
> > +{
>
> (ditto)
>
> > +}
> > +
> > +static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
> > +{
>
> (ditto)
>
> > +}

