Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34381C9832F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 16:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAVQ6-00017e-FJ; Sat, 26 Sep 2026 12:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xAVQ2-00017O-2U
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 12:38:34 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xAVPw-00084Z-Qs
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 12:38:31 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a605c198fdso2815255a12.2
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790440706; x=1791045506; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ypS3P8gZWprnEo9dQToqNtKDGPuXVqBEIuFRziU+t3M=;
 b=f3zhZs7tDuy2X5mQRTPMhn9ITjFQ9+UqhL6pcA/7AnqCmWLTPtLnYa9Gz1ud01f1I/
 uj/COvX8QtekYWuRyDyAdt2/tKCYkeV3N44mx5iTBA8B3vvb44JPdiHmKwXPiRTmsbE9
 D9FbMcBUjHYCPKKum/XlMSN/a7VgxHtdQUipLggX/mQgKmOgP3pV4LDwe436b2oDUfEr
 AREvTWxzCp32AefdDrH7mDH5oyj/xmBNngy3Poz5GBtlpv/PKaZ3ux0UpWr5Nz5i0W0C
 aDo5o2eG6G58WvEJ2Go9G7DyTNjASADBXWVnBfi0ZB+mDhiuGhKUp9NwaegT7L/A9naA
 Hd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790440706; x=1791045506;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ypS3P8gZWprnEo9dQToqNtKDGPuXVqBEIuFRziU+t3M=;
 b=gEh2UO0s2uBvvMlbeQNKN2i0KST+6tkSuu67e91f7uwtatjeXU9zjaM1JXHVe/osjn
 ymCeqy6hHXkcjzg+ToWnaiFA2ugp6uxG7H8r4MnnhUzK90NdEEhu4VJAdvPFWPXEyK/6
 bAATvPaYIytI7Db7nulXD43yNWcbIVmxf4DjrVM27zQdq6K+Eg9l3cRbssQd43g/K0/P
 p/r3L1l2Ccd6oyPQL55JIgOsm8wxFkOpcaMxUqs4U+ABcat39hwRRosrMxmcZYavnTmm
 uc5Q4Dd/PcoQpuovy7bHNpDRnI7CMv2lR4oUSwjBxwtYMl1oVEGKDcHSGxJfisZG1yzb
 q/QA==
X-Gm-Message-State: AFuF++knsVEkI79lkNhKHkHG20MqBqQ/357k+8dsw0qrRKH3wlB9ZaHc
 O78lezhrmAmXyumlFB5JmZljAkKGAFNGhbEYg4SgqPKQGwEKmzL7U2knouhk2A==
X-Gm-Gg: AYBFou2JVvNTmrBxUOJAVO2VwWw+S0/rIVjdXR5HozY6vHjW+2wEVUt0fHPNS68QLda
 rJurwUeblKejF7qT3zcN124RAKnRHTf7S5XL1f9WLMZRcE+7bOJ/jBzuIOAqJuhSp6+OnF1AKM9
 2TWqfhmlc/rX8yjQZo7anSPLlVzk2dh39LyB0+HHdnuL5eevuofdAiaXufHdjF7/5eZjpyK4EJI
 N37t6HNTqVNb8yYIx+jL7Z0/29gTAubtbeYAXbJ6T3I+fty8sxPbFy7g1pZVlYSwRoz9vMqsJAg
 E3QgAYk6o9F333sJyjB3QeB8OBuK788N4raqdvDFaLDxOJtuOcPuSOOhsZjXy8eizTlCPBJjKI4
 K350a7Wp7vMcCTnef6c60dX/hJcIcfLiOFVqq+O5z26P9La+Qk/PvbZZhkXyC4Jh9D83W42noNu
 EpmyXSr1rFIG5U+JwFOfHTkGMA24Pss4zUMhQDZo0vF3S6dkD1OoIx2CaXMppoDxZDcV6EoDU9R
 +sEP5H9tR7UgZu/Qe7FFBSkVBbpPWZJwaL57bMQypbd3xKm9lhb0oVfVvM49xR5/dqq1QaPmpbY
 fR/wDg==
X-Received: by 2002:a17:907:8908:b0:c29:47b9:965 with SMTP id
 a640c23a62f3a-c2ac24d3ed6mr732033566b.25.1790440706335; 
 Sat, 26 Sep 2026 09:38:26 -0700 (PDT)
Received: from smtpclient.apple (088156177242.warszawa.vectranet.pl.
 [88.156.177.242]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2ae757cdd7sm246195966b.27.2026.09.26.09.38.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 26 Sep 2026 09:38:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v2] target/sparc: implement TTE page-size for 32M/256M
 pages
From: Dmitry Pimenov <sun4qemu@gmail.com>
In-Reply-To: <20260918105705.433093-1-sun4qemu@gmail.com>
Date: Sat, 26 Sep 2026 18:38:13 +0200
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D463C3A-EE1C-4BF7-8495-E35FA3B8C927@gmail.com>
References: <20260918105705.433093-1-sun4qemu@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=sun4qemu@gmail.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello,
A gentle ping.
This patch fixes TTE page-size MMU decoding so 32M/256M pages are no =
longer truncated across sparc/niagara (sun4v).
It improves support for the Solaris 10/11 kernels.
=
https://lore.kernel.org/qemu-devel/20260918105705.433093-1-sun4qemu@gmail.=
com/T/#u

Regards,
Dmitry

> On 18 Sep 2026, at 12:57, dpim <sun4qemu@gmail.com> wrote:
>=20
> Currently, the TTE's page-size field, Size, is 2 bits wide:
>=20
>    #define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
>=20
> That is the TTE of every UltraSPARC before UltraSPARC IV+.
> The JPS1 implementation supplements for UltraSPARC III and IV+
> describe the TTE word in tables F-1 and F-1-4 respectively, and differ
> in one bit:
> Before IV+ bit 48 is reserved and reads as 0, Size is 2 bits at 62:61;
> On IV+ bit 48 is Size<2>, which "is the most significant bit of the
> page size and is concatenated with bits <62:61>"
> On T1 the same split exists, szl at 62:61 and szh at 48 (T1 =
Supplement,
> sec. 13.1.2).
>=20
> QEMU models parts on both sides of that change (UltraSPARC =
III/IIIi/IV,
> IV+, T1, T2) with the III layout: Size<2> was never implemented.
> Bit 48 gets lost in more than one place:
>=20
> On sun4u the raw TTE word is stored as the guest wrote it, bit 48
> included, but TTE_PGSIZE() only reads bits 62:61: the bit survives in
> the TLB, it is just never decoded.
>=20
> On sun4v, sun4v_tte_to_sun4u() converts the incoming three-bit code
> (cpu.h defines TTE_PGSIZE_UA2005() for it, unused until now) but =
masked
> it to two:
>=20
>    sun4u_tte |=3D (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
>=20
> so the third bit was dropped before it was stored.
>=20
> demap_tlb() duplicates the same 2-bit math instead of calling
> TTE_PGSIZE(), so it misses bit 48 too, for a TTE from either origin.
>=20
> Either way 256M decodes as 64K and 32M as 8K; the guest faults on the
> first access past the truncated entry.
>=20
> This patch implements Size<2> at bit 48, where the hardware keeps it.
>=20
> TTE_PGSIZE() now reads bit 48 as the high bit; on parts that keep bit
> 48 reserved it reads as zero, so they decode as before.
> sun4v_tte_to_sun4u() stores the full three-bit code, and demap_tlb()
> now calls TTE_PGSIZE() instead of its own copy. dump_mmu() gains 32M
> and 256M labels.
>=20
> Link: =
https://lore.kernel.org/qemu-devel/20260727233646.332875-1-sun4qemu@gmail.=
com/
> AI-used-for: code, analysis
> Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
> ---
> v2: described behaviour across sun4u/sun4v instead of the sun4v
> conversion; no functional change. QEMU_BUILD_BUG_ON and comments in
> cpu.h/ldst_helper.c are dropped.
>=20
> This email's text -- beyond the code and analysis the trailer above
> covers -- also had AI involvement: current policy (AGENTS.md)
> declines AI-derived content outright, and even the not-yet-merged
> llm-usage.rst RFC would require it to be human-written regardless of
> any trailer. Sending as-is rather than silently -- happy to hear if
> that's not acceptable here.
>=20
> Happy to run more tests or provide more evidence if this isn't enough.
>=20
> Guest is OpenSolaris snv_134 (osol-dev-134-ai-sparc.iso). Firmware is
> the S10image/ set from OpenSPARCT1_Arch.1.5.tar.bz2, which
> docs/system/target-sparc64.rst names for this machine, except the
> MD/hv-config pair (1up-md.bin, 1up-hv.bin), from the repo below. The
> archive's own config only boots disk.s10hw2, capped at 4M pages.
>=20
> Observed on upstream 5f664cd37a, with and without this patch -- same
> guest, firmware and RAM, plain `boot` at the `ok` prompt (occasionally
> hits an unrelated, pre-existing trap in OBP's loader phase before the
> kernel runs):
>=20
>  pristine: hangs after "Loading: /platform/sun4v/kernel/sparcv9/unix";
>            "info tlb" shows no 32M or 256M entry.
>  patched:  boots to "Enter user name for system maintenance";
>            "info tlb" shows 256M entries, e.g.
>            [17] VA: 600108b8000, PA: 140000000, 256M, priv, RW, ...
>  Full info tlb dumps:
>    =
https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verifica=
tion/0002-tte-size2/logs/pristine-plain-boot-tlb.txt
>    =
https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verifica=
tion/0002-tte-size2/logs/patched-plain-boot-tlb.txt
>=20
> The reproduction as a script, verify.sh (fetches firmware, MD and
> ISO, checks their hashes, boots):
>  =
https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verifica=
tion/0002-tte-size2/verify.sh
>=20
> On sun4u the pre-extension page sizes are verified by
> make check-qtest-sparc64 and make check-functional-sparc64 (sun4u,
> tuxrun, migration), which pass on the patched build with logs:
>  =
https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verifica=
tion/0002-tte-size2/check-qtest-sparc64.log
>  =
https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verifica=
tion/0002-tte-size2/check-functional-sparc64.log
> To check whether
> Size<2> is exercised at all, I added a temporary log in
> replace_tlb_entry() and ran both suites again: zero hits, as expected
> -- IIi predates IV+ and doesn't implement Size<2>, so the guest
> running under it never sets bit 48. Result:
>  =
https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verifica=
tion/0002-tte-size2/sun4u-bit48-probe/RESULT
> Probe and logs:
>  =
https://github.com/unix0cc/qemu-experimental-patches/tree/967a037/verifica=
tion/0002-tte-size2/sun4u-bit48-probe/
> 32M/256M on sun4u stays untested by this suite; that would need a =
guest
> running under Sun-UltraSparc-IV-plus.
>=20
> Overview of everything above (scripts, logs, README):
>  =
https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verifica=
tion/0002-tte-size2/README
>=20
> target/sparc/cpu.h         |  4 +++-
> target/sparc/ldst_helper.c |  9 +++++++--
> target/sparc/mmu_helper.c  | 12 ++++++++++++
> 3 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 31a16c2af0..1ab420d831 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -307,7 +307,9 @@ enum {
> #define TTE_SET_USED(tte)   ((tte) |=3D TTE_USED_BIT)
> #define TTE_SET_UNUSED(tte) ((tte) &=3D ~TTE_USED_BIT)
>=20
> -#define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
> +#define TTE_PGSIZE_HI_BIT   (1ULL << 48)
> +#define TTE_PGSIZE(tte)     ((((tte) >> 61) & 3ULL) | \
> +                             (((tte) & TTE_PGSIZE_HI_BIT) >> 46))
> #define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
> #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
>=20
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 4ec8799d1f..142c1c24de 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -186,7 +186,7 @@ static void demap_tlb(SparcTLBEntry *tlb, =
target_ulong demap_addr,
>                 /* demap page
>                    will remove any entry matching VA */
>                 mask =3D 0xffffffffffffe000ULL;
> -                mask <<=3D 3 * ((tlb[i].tte >> 61) & 3);
> +                mask <<=3D 3 * TTE_PGSIZE(tlb[i].tte);
>=20
>                 if (!compare_masked(demap_addr, tlb[i].tag, mask)) {
>                     continue;
> @@ -217,7 +217,12 @@ static uint64_t sun4v_tte_to_sun4u(CPUSPARCState =
*env, uint64_t tag,
>         return sun4v_tte;
>     }
>     sun4u_tte =3D TTE_PA(sun4v_tte) | (sun4v_tte & TTE_VALID_BIT);
> -    sun4u_tte |=3D (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
> +    {
> +        uint64_t pgsz =3D TTE_PGSIZE_UA2005(sun4v_tte);
> +        sun4u_tte |=3D (pgsz & 3ULL) << 61; /* TTE_PGSIZE bits 61-62 =
*/
> +        sun4u_tte |=3D (pgsz & 4ULL) ?
> +            TTE_PGSIZE_HI_BIT : 0; /* TTE_PGSIZE bit 48 */
> +    }
>     sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_NFO_BIT_UA2005, =
TTE_NFO_BIT);
>     sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_USED_BIT_UA2005, =
TTE_USED_BIT);
>     sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_W_OK_BIT_UA2005, =
TTE_W_OK_BIT);
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 07ba25dfce..8544de097d 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -830,6 +830,12 @@ void dump_mmu(CPUSPARCState *env)
>             case 0x3:
>                 mask =3D "  4M";
>                 break;
> +            case 0x4:
> +                mask =3D " 32M";
> +                break;
> +            case 0x5:
> +                mask =3D "256M";
> +                break;
>             }
>             if (TTE_IS_VALID(env->dtlb[i].tte)) {
>                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
> @@ -869,6 +875,12 @@ void dump_mmu(CPUSPARCState *env)
>             case 0x3:
>                 mask =3D "  4M";
>                 break;
> +            case 0x4:
> +                mask =3D " 32M";
> +                break;
> +            case 0x5:
> +                mask =3D "256M";
> +                break;
>             }
>             if (TTE_IS_VALID(env->itlb[i].tte)) {
>                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
> --=20
> 2.43.0
>=20


