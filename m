Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38548C9832F
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 20:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAZKz-0004ee-S7; Sat, 26 Sep 2026 16:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1xAZKx-0004e9-Cq
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 16:49:35 -0400
Received: from mail-qk2-x0d.google.com ([2607:f8b0:4864:34::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atar4qemu@gmail.com>)
 id 1xAZKv-0006qx-4q
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 16:49:34 -0400
Received: by mail-qk2-x0d.google.com with SMTP id
 af79cd13be357-93c5818c4a4so71623285a.3
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 13:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790455772; cv=none;
 d=google.com; s=arc-20260327;
 b=N2gMrEj0t6HB69OdZj0BhJkkAYCEIMEO/mXwGjU5bd9OXbQzlPLdSmGjUjYjXaKOL7
 FLCL7EifOnVivCpZcEY8KYZN65/eJTEOpgZtNsMs/XqXstVbxJHmi/grFY5wMIzuZArT
 yWS/zazxo7Lar0raB6H0CxoFgNKcS1O+8j6NlORW1Cm6/KIZ0uM2ZeabYIl4zHBLsInN
 25eD8c9dFlTWg20Ab6a/bArkrM/4XKwiM/3p0hUYkiUFsPtv7mEcZlZj9w58dcwPByrz
 Uvqn7jz3Youtr+wN7i50yupV7CbTWJmlUPqpfFT0MnNY9xgRvq0Aine6c5sLd49pdKeu
 LC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IHDb3SE5gAGOh2e1krH3XrPvpthbBbwBvTS4DtN2VNM=;
 fh=W9HkJwqqqp9IE0AFJwOScjF7VF7TzWSYpKEMq44zjo0=;
 b=azW48G0nY4vYVelc+pvIFNj73J3Dek3zzoBFHCBt/+hHOYYLHPf0ue3NXUVcszClxa
 WcbCM9aTU0LGGuyDcozaVbRbKABFM4RvwFWupPmUdz1Lnh5criL7OW8tJb5G54rr/m5+
 KckLepK5+xiyNAMzsxx5IgIk0pWQoutmKBdqOcku7pO2vYhojXoxPUsWi2YicEMhKzmH
 pmBLYlBYb1lCbHip9Gtt6YBoiPD3NOPX9xF5HwbNpYp9CTuW59Qy2QHunsCqho7Woxmb
 GjjIbC7BfVycFcwzk2PwKkuJwf14cU+IYNVlyRhsc2DgXE4TlxI6azdqlBSH4vjyWNYt
 glsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790455772; x=1791060572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IHDb3SE5gAGOh2e1krH3XrPvpthbBbwBvTS4DtN2VNM=;
 b=fmQWYJpL/pBZxph0kr1M0LIqaskb28fMTavQUv12em5DYekWXxKI7jFKNdMVuJBWFg
 q+J545nMKib75EBK3Hk1iHa7uhgLbAi2CRj8QcEuaYTFeGeXf+JlfTmyFlHHctcs2Ovw
 MXPH2E5HNR1D7PR7Mvxke3lxw8mJdA61So+HYDBEtKADS0TLDsPPAKLvJa23PNK4oT9U
 XBWOwm0J3cEkYiA5Pqc0KppF3vIy6B5VDcV75Z3gBCT5nQ5FEdJso/dhKvTfZEzUYYNI
 39yMCRgM+bWgDK70XDvvYXTXXz1km7dC6JaFMKGkgBwiH7bCQAj7O54+IKO81BGxQ+IY
 UM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790455772; x=1791060572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IHDb3SE5gAGOh2e1krH3XrPvpthbBbwBvTS4DtN2VNM=;
 b=S1dGvg/RUnUJLy/4UPgse+pvbLq4IV+s++cubcvsfty0Op4C254m/isiTJ0BhhJb98
 nLjFLc4ffGSAukCk3xcaQAHJmqkSrUj01S0uGMEEgas0yb/TLKc62XtUophm1IdnoheP
 M+VYsI32OwIemAH6mOTQZ+JTtKgSuiGCboYRwL02Kfuy5wVJukjF/uV0g62h21ds1VKD
 XpfuZoLcBHSvPEScDOjurZVgaTjSjiDEjjjZWdhoWiPM1kBKlt4I4Egppku454ufYT1s
 mcJdwimQ+mZ4pBkFdpuzjqMBaiog69HWzCrHkF8VRPnok/8eTrIfhitOp6ensFLq9baX
 TqSQ==
X-Gm-Message-State: AFuF++kYOwAqLqgr8RRuGGHZmXBXQD9jrAGDk8OeNlpgXGsCPD96u7JD
 c2NoMISF5glrg/bzu9pA7oY28pCqVbrM0rKWrn8M+77ygnZCORan/JYwCO1xxMZUP8kI8imVhqX
 Hl4EPl4kkRK5NIIXOe73WssXupER/5nA=
X-Gm-Gg: AYBFou2SMCpSFFyI5MmQkMMr5s4srihQioHhtWTrspZTNkZ1rrIHLC6o9vDydXI5JFl
 xrPn6mPnvU1AQFkSOy4lYosisw7C/wJffe13STNVRAhZqePYIkkfgfyRX7TKP+BBGjENo9TXCgq
 skuN8Qo58UmmWdOIVcsp0sLcP1rdKUWnHGwN9kcrdQX05aGPfJyMZDvuuujvYr5QjiUJnd+sMnp
 TMsqskLsHY0Mlrw9xKh8+JGAo/RHYBEuZ2ttAwXW8njUbTq4Ox21jUYT5SegkqyNFzh6WfdUWkE
 G9hvKabguHynlGrfOuPUiym1XaFlw6kIgjoh7Ho870pXRKRct/eNQVfGTt2RSA==
X-Received: by 2002:a05:620a:bd4:b0:939:57ca:7e06 with SMTP id
 af79cd13be357-93c43c306f6mr1252943885a.9.1790455771594; Sat, 26 Sep 2026
 13:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260918105705.433093-1-sun4qemu@gmail.com>
In-Reply-To: <20260918105705.433093-1-sun4qemu@gmail.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sat, 26 Sep 2026 22:49:20 +0200
X-Gm-Features: AclHuK8XILJV6XeBAFhPmb4Qi7M2Wwp7poX-dpsGd_5U-hITOT3T0vFuiHiuk4M
Message-ID: <CACXAS8ALB0EF-LE3icCzY6HO-znccOh6d4fjj799rp130q9CvQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/sparc: implement TTE page-size for 32M/256M
 pages
To: dpim <sun4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:34::d;
 envelope-from=atar4qemu@gmail.com; helo=mail-qk2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 18, 2026 at 1:00=E2=80=AFPM dpim <sun4qemu@gmail.com> wrote:
>
> Currently, the TTE's page-size field, Size, is 2 bits wide:
>
>     #define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
>
> That is the TTE of every UltraSPARC before UltraSPARC IV+.
> The JPS1 implementation supplements for UltraSPARC III and IV+
> describe the TTE word in tables F-1 and F-1-4 respectively, and differ
> in one bit:
> Before IV+ bit 48 is reserved and reads as 0, Size is 2 bits at 62:61;
> On IV+ bit 48 is Size<2>, which "is the most significant bit of the
> page size and is concatenated with bits <62:61>"
> On T1 the same split exists, szl at 62:61 and szh at 48 (T1 Supplement,
> sec. 13.1.2).
>
> QEMU models parts on both sides of that change (UltraSPARC III/IIIi/IV,
> IV+, T1, T2) with the III layout: Size<2> was never implemented.
> Bit 48 gets lost in more than one place:
>
> On sun4u the raw TTE word is stored as the guest wrote it, bit 48
> included, but TTE_PGSIZE() only reads bits 62:61: the bit survives in
> the TLB, it is just never decoded.
>
> On sun4v, sun4v_tte_to_sun4u() converts the incoming three-bit code
> (cpu.h defines TTE_PGSIZE_UA2005() for it, unused until now) but masked
> it to two:
>
>     sun4u_tte |=3D (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
>
> so the third bit was dropped before it was stored.
>
> demap_tlb() duplicates the same 2-bit math instead of calling
> TTE_PGSIZE(), so it misses bit 48 too, for a TTE from either origin.
>
> Either way 256M decodes as 64K and 32M as 8K; the guest faults on the
> first access past the truncated entry.
>
> This patch implements Size<2> at bit 48, where the hardware keeps it.
>
> TTE_PGSIZE() now reads bit 48 as the high bit; on parts that keep bit
> 48 reserved it reads as zero, so they decode as before.
> sun4v_tte_to_sun4u() stores the full three-bit code, and demap_tlb()
> now calls TTE_PGSIZE() instead of its own copy. dump_mmu() gains 32M
> and 256M labels.
>
> Link: https://lore.kernel.org/qemu-devel/20260727233646.332875-1-sun4qemu=
@gmail.com/
> AI-used-for: code, analysis
> Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

@Richard, Mark can you please pick it up?

> ---
> v2: described behaviour across sun4u/sun4v instead of the sun4v
> conversion; no functional change. QEMU_BUILD_BUG_ON and comments in
> cpu.h/ldst_helper.c are dropped.
>
> This email's text -- beyond the code and analysis the trailer above
> covers -- also had AI involvement: current policy (AGENTS.md)
> declines AI-derived content outright, and even the not-yet-merged
> llm-usage.rst RFC would require it to be human-written regardless of
> any trailer. Sending as-is rather than silently -- happy to hear if
> that's not acceptable here.
>
> Happy to run more tests or provide more evidence if this isn't enough.
>
> Guest is OpenSolaris snv_134 (osol-dev-134-ai-sparc.iso). Firmware is
> the S10image/ set from OpenSPARCT1_Arch.1.5.tar.bz2, which
> docs/system/target-sparc64.rst names for this machine, except the
> MD/hv-config pair (1up-md.bin, 1up-hv.bin), from the repo below. The
> archive's own config only boots disk.s10hw2, capped at 4M pages.
>
> Observed on upstream 5f664cd37a, with and without this patch -- same
> guest, firmware and RAM, plain `boot` at the `ok` prompt (occasionally
> hits an unrelated, pre-existing trap in OBP's loader phase before the
> kernel runs):
>
>   pristine: hangs after "Loading: /platform/sun4v/kernel/sparcv9/unix";
>             "info tlb" shows no 32M or 256M entry.
>   patched:  boots to "Enter user name for system maintenance";
>             "info tlb" shows 256M entries, e.g.
>             [17] VA: 600108b8000, PA: 140000000, 256M, priv, RW, ...
>   Full info tlb dumps:
>     https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/ver=
ification/0002-tte-size2/logs/pristine-plain-boot-tlb.txt
>     https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/ver=
ification/0002-tte-size2/logs/patched-plain-boot-tlb.txt
>
> The reproduction as a script, verify.sh (fetches firmware, MD and
> ISO, checks their hashes, boots):
>   https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verif=
ication/0002-tte-size2/verify.sh
>
> On sun4u the pre-extension page sizes are verified by
> make check-qtest-sparc64 and make check-functional-sparc64 (sun4u,
> tuxrun, migration), which pass on the patched build with logs:
>   https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verif=
ication/0002-tte-size2/check-qtest-sparc64.log
>   https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verif=
ication/0002-tte-size2/check-functional-sparc64.log
> To check whether
> Size<2> is exercised at all, I added a temporary log in
> replace_tlb_entry() and ran both suites again: zero hits, as expected
> -- IIi predates IV+ and doesn't implement Size<2>, so the guest
> running under it never sets bit 48. Result:
>   https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verif=
ication/0002-tte-size2/sun4u-bit48-probe/RESULT
> Probe and logs:
>   https://github.com/unix0cc/qemu-experimental-patches/tree/967a037/verif=
ication/0002-tte-size2/sun4u-bit48-probe/
> 32M/256M on sun4u stays untested by this suite; that would need a guest
> running under Sun-UltraSparc-IV-plus.
>
> Overview of everything above (scripts, logs, README):
>   https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verif=
ication/0002-tte-size2/README
>
>  target/sparc/cpu.h         |  4 +++-
>  target/sparc/ldst_helper.c |  9 +++++++--
>  target/sparc/mmu_helper.c  | 12 ++++++++++++
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 31a16c2af0..1ab420d831 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -307,7 +307,9 @@ enum {
>  #define TTE_SET_USED(tte)   ((tte) |=3D TTE_USED_BIT)
>  #define TTE_SET_UNUSED(tte) ((tte) &=3D ~TTE_USED_BIT)
>
> -#define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
> +#define TTE_PGSIZE_HI_BIT   (1ULL << 48)
> +#define TTE_PGSIZE(tte)     ((((tte) >> 61) & 3ULL) | \
> +                             (((tte) & TTE_PGSIZE_HI_BIT) >> 46))
>  #define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
>  #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
>
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 4ec8799d1f..142c1c24de 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -186,7 +186,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulon=
g demap_addr,
>                  /* demap page
>                     will remove any entry matching VA */
>                  mask =3D 0xffffffffffffe000ULL;
> -                mask <<=3D 3 * ((tlb[i].tte >> 61) & 3);
> +                mask <<=3D 3 * TTE_PGSIZE(tlb[i].tte);
>
>                  if (!compare_masked(demap_addr, tlb[i].tag, mask)) {
>                      continue;
> @@ -217,7 +217,12 @@ static uint64_t sun4v_tte_to_sun4u(CPUSPARCState *en=
v, uint64_t tag,
>          return sun4v_tte;
>      }
>      sun4u_tte =3D TTE_PA(sun4v_tte) | (sun4v_tte & TTE_VALID_BIT);
> -    sun4u_tte |=3D (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
> +    {
> +        uint64_t pgsz =3D TTE_PGSIZE_UA2005(sun4v_tte);
> +        sun4u_tte |=3D (pgsz & 3ULL) << 61; /* TTE_PGSIZE bits 61-62 */
> +        sun4u_tte |=3D (pgsz & 4ULL) ?
> +            TTE_PGSIZE_HI_BIT : 0; /* TTE_PGSIZE bit 48 */
> +    }
>      sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_NFO_BIT_UA2005, TTE_NFO_BI=
T);
>      sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_USED_BIT_UA2005, TTE_USED_=
BIT);
>      sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_W_OK_BIT_UA2005, TTE_W_OK_=
BIT);
> diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> index 07ba25dfce..8544de097d 100644
> --- a/target/sparc/mmu_helper.c
> +++ b/target/sparc/mmu_helper.c
> @@ -830,6 +830,12 @@ void dump_mmu(CPUSPARCState *env)
>              case 0x3:
>                  mask =3D "  4M";
>                  break;
> +            case 0x4:
> +                mask =3D " 32M";
> +                break;
> +            case 0x5:
> +                mask =3D "256M";
> +                break;
>              }
>              if (TTE_IS_VALID(env->dtlb[i].tte)) {
>                  qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
> @@ -869,6 +875,12 @@ void dump_mmu(CPUSPARCState *env)
>              case 0x3:
>                  mask =3D "  4M";
>                  break;
> +            case 0x4:
> +                mask =3D " 32M";
> +                break;
> +            case 0x5:
> +                mask =3D "256M";
> +                break;
>              }
>              if (TTE_IS_VALID(env->itlb[i].tte)) {
>                  qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
> --
> 2.43.0
>


--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

