Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A87CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 11:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIOgc-0001QX-0U; Sun, 18 Oct 2026 07:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1xIOgX-0001QP-Fm
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 07:04:13 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1xIOgU-0003t6-Jb
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 07:04:13 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-97622cc1f40so1036659241.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 04:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792321448; cv=none;
 d=google.com; s=arc-20260327;
 b=WS7+/AaQ1jAOqGoY33nCa16cQRUxXpq8aEraVQALmj3aKsuItYkEEYJwxMg0gJcNCF
 b+XpugbIXSLKdltADUVRK8JQrB+bOWsHMEA5k+pN9eMW51a6gsX1YRVU5o5qJXHDozvv
 /fphxkyw/9zG0QR5H90RRUK1H3POx1QoyufiS2djJ7eLVn7zQABMpguI6KD1yrHuN78K
 iz+JjPAiIVPj1MqixUC6NnI318dWh65dFp5ffVgj3+/gfPhl+myqr8rDJEcbjJ/ub8LJ
 GvdpPQ7Zm481YB+M9JZ2sGZvlp3obwfhRXzrqUG/MV0gFvjnJMToFHVWHn6YRS37Ob5P
 ZZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=75eLIY3FN4+v/keyk3bBcek2YY0M4RhVm4z+Jq93TW0=;
 fh=CzjPuOB5Yd/Rs7SzmRKen+/N3DIXYkzhWptyxMRA/s8=;
 b=JKJC/iRs0WqTd6DS8uH277iKerlKbq9yrT8Tflj3Ev0SzZh3aAmjDCTGtnUmkEtarJ
 Va3j9rdrHkK4Klp8450z1q+NQRlVXzS4PacvelB/kNErPvhv2P/oWwXU5LygPPnvKzgp
 g7eQAIkOGSjCfpNVIv21/gVPUofmBYqg7fW/Z/430e7R8gowDcjt3J/yTBh4FJ2KP3dJ
 P3A/eF0ZLO9GKzDFMAeIValwH3kg/vFSD0J2P6L/gyTW/GbMHMM8IZ4Wg2xid+J3+E9L
 BBxTJFIail6v39xGJVAD72KMVrit1p4GA/wGqfmgZpPxS4EGQF55Pct6KL8ClOhcbK51
 0OuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792321448; x=1792926248; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=75eLIY3FN4+v/keyk3bBcek2YY0M4RhVm4z+Jq93TW0=;
 b=o8cDN3SlqNUpsXmiDQYdC6k7U1dCH5yKIgCf+N+g38f1RjXDZRmhbkySZ8QDLDPA+7
 /ZQsxLfGwIuD1GuzGTifBFpmZJhKDrmfCRXAToAOD5h/dbtvs3ndb0KnKfU8iBJj6Iki
 RKnBq/5UTHzt0dePQO5AD06TyZW73DsJgaHzjRAndxTyQ1wqLrZ0itQkBkINbRKlfaKS
 nE0cdzzZbZj1dpwYjiG0wmtY3ER1yPHkhFSryZoeJw2NqIBkyXCYZXJj6+Bf6AVuk7xZ
 RnEXUl35IN4dI4VqdM4jX+fb9X5hdqLSCRHIhxeEaAgQOB7wm+ieWj2PSLW+23l2icZM
 glCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792321448; x=1792926248;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=75eLIY3FN4+v/keyk3bBcek2YY0M4RhVm4z+Jq93TW0=;
 b=yTXIjUyjMLH5JM06G9bK1toQAD2oi4wQPpHzK/+IjnlaTVZ4YparuBY0iBZCyox15+
 XRqLW82w2k0T4ov8LfcvtE5Le6rNNsF64vA4agZG76t0bWbYf1+Xg+jMSlmNMZJdXPgY
 hkVhe4KvyySM0a2zYaa+WK8uQVkrvbXszlGgcP+wsAhnddpHzvyHwa51A6aek7K9HbBF
 9+/MTYoKYqToXbVuuMd+ekBiD2DWAjj69rnJn9cDtcIBU6BAdwKBjhWpy2fsk052gBa5
 0vPrrkz2DO+nRuoyYQt9DoW9yWTLBHfpAr4DglsCPY98c89AUigNqinF4zTToSJViYL7
 MRQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNTUcoNpKIrr/rSj7zwKw7EQwfOKvhLUyLjm2hnR1gnOb720OKgQM6oMPbfgj4YMmRgbiu8O+Mn+OQ@nongnu.org
X-Gm-Message-State: AFq9FYIFPWkIlOHB1F1W7KnXS3a8MMEdzX9FuabvmPI+Zc5opPrdjDUb
 ILp9SFBF5yzU+qhwc0n9azMhjkqJfTeZSJdzQ6k/Hym50iK+WdmLnTxSchaEOmPc0XimAlOba/i
 FajnwN2aVwUP4qKo1FbGUKOwEKJ1LiAM=
X-Gm-Gg: AYBFou1sdhBckX5g2m0mtsioGA1TcpRi1fth309zM/uaJ+LZiGfomj55dJXkN+wSJaF
 eFUGBjb7ucxGMug5iktDJkoFc6peyDpOQ/pB3LxQr1X4iAtplt7TzDh9AlGcTjRRgBIjNlJTPwc
 CYYXtDEtS25qIT5knlzyLtwLrEnDDrRVyx9Z5CP7nJcnOqAkrtmsZIhOD5+yuVkCdYd4VN8Hs6u
 /HsKBwNZa+WlJNr5evDYHZlz/52XYqF8QJ3vPPvO/9y+d6aDZ7chuuB72hgD7OLfwDfp8sYpGAA
 6APhkxVZhim6riPGBEbA5JI2/jfIdahvGGJPwdZKLkYj5irYoPx4WAw=
X-Received: by 2002:a05:6102:5cc8:b0:7cb:9e72:cee2 with SMTP id
 ada2fe7eead31-7cc36905d5emr1743798137.10.1792321447866; Sun, 18 Oct 2026
 04:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260918105705.433093-1-sun4qemu@gmail.com>
 <ebea4a0e-3a70-4f6a-bd4e-0ab80f810e31@ilande.co.uk>
In-Reply-To: <ebea4a0e-3a70-4f6a-bd4e-0ab80f810e31@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 18 Oct 2026 13:03:57 +0200
X-Gm-Features: AclHuK_W0XARJw37Xe0JKL-U0xaf7qN2RkEzx3oLTgYjphJEFEIlKAQ-XXgYjYQ
Message-ID: <CAAM0arPaue5A331c7MSd_Z-C+tTZbNQes-9T-dX0Vmu8vmQyDQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/sparc: implement TTE page-size for 32M/256M
 pages
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: dpim <sun4qemu@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003935e5065e1b5be4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=a.tarasenko@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000003935e5065e1b5be4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

=D0=B2=D1=81, 18 =D0=BE=D0=BA=D1=82. 2026 =D0=B3., 11:23 Mark Cave-Ayland <=
mark.cave-ayland@ilande.co.uk>:

> On 18/09/2026 11:57, dpim wrote:
>
> > Currently, the TTE's page-size field, Size, is 2 bits wide:
> >
> >      #define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
> >
> > That is the TTE of every UltraSPARC before UltraSPARC IV+.
> > The JPS1 implementation supplements for UltraSPARC III and IV+
> > describe the TTE word in tables F-1 and F-1-4 respectively, and differ
> > in one bit:
> > Before IV+ bit 48 is reserved and reads as 0, Size is 2 bits at 62:61;
> > On IV+ bit 48 is Size<2>, which "is the most significant bit of the
> > page size and is concatenated with bits <62:61>"
> > On T1 the same split exists, szl at 62:61 and szh at 48 (T1 Supplement,
> > sec. 13.1.2).
> >
> > QEMU models parts on both sides of that change (UltraSPARC III/IIIi/IV,
> > IV+, T1, T2) with the III layout: Size<2> was never implemented.
> > Bit 48 gets lost in more than one place:
> >
> > On sun4u the raw TTE word is stored as the guest wrote it, bit 48
> > included, but TTE_PGSIZE() only reads bits 62:61: the bit survives in
> > the TLB, it is just never decoded.
> >
> > On sun4v, sun4v_tte_to_sun4u() converts the incoming three-bit code
> > (cpu.h defines TTE_PGSIZE_UA2005() for it, unused until now) but masked
> > it to two:
> >
> >      sun4u_tte |=3D (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
> >
> > so the third bit was dropped before it was stored.
> >
> > demap_tlb() duplicates the same 2-bit math instead of calling
> > TTE_PGSIZE(), so it misses bit 48 too, for a TTE from either origin.
> >
> > Either way 256M decodes as 64K and 32M as 8K; the guest faults on the
> > first access past the truncated entry.
> >
> > This patch implements Size<2> at bit 48, where the hardware keeps it.
> >
> > TTE_PGSIZE() now reads bit 48 as the high bit; on parts that keep bit
> > 48 reserved it reads as zero, so they decode as before.
> > sun4v_tte_to_sun4u() stores the full three-bit code, and demap_tlb()
> > now calls TTE_PGSIZE() instead of its own copy. dump_mmu() gains 32M
> > and 256M labels.
> >
> > Link:
> https://lore.kernel.org/qemu-devel/20260727233646.332875-1-sun4qemu@gmail=
.com/
> > AI-used-for: code, analysis
> > Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
> > ---
> > v2: described behaviour across sun4u/sun4v instead of the sun4v
> > conversion; no functional change. QEMU_BUILD_BUG_ON and comments in
> > cpu.h/ldst_helper.c are dropped.
> >
> > This email's text -- beyond the code and analysis the trailer above
> > covers -- also had AI involvement: current policy (AGENTS.md)
> > declines AI-derived content outright, and even the not-yet-merged
> > llm-usage.rst RFC would require it to be human-written regardless of
> > any trailer. Sending as-is rather than silently -- happy to hear if
> > that's not acceptable here.
> >
> > Happy to run more tests or provide more evidence if this isn't enough.
> >
> > Guest is OpenSolaris snv_134 (osol-dev-134-ai-sparc.iso). Firmware is
> > the S10image/ set from OpenSPARCT1_Arch.1.5.tar.bz2, which
> > docs/system/target-sparc64.rst names for this machine, except the
> > MD/hv-config pair (1up-md.bin, 1up-hv.bin), from the repo below. The
> > archive's own config only boots disk.s10hw2, capped at 4M pages.
> >
> > Observed on upstream 5f664cd37a, with and without this patch -- same
> > guest, firmware and RAM, plain `boot` at the `ok` prompt (occasionally
> > hits an unrelated, pre-existing trap in OBP's loader phase before the
> > kernel runs):
> >
> >    pristine: hangs after "Loading: /platform/sun4v/kernel/sparcv9/unix"=
;
> >              "info tlb" shows no 32M or 256M entry.
> >    patched:  boots to "Enter user name for system maintenance";
> >              "info tlb" shows 256M entries, e.g.
> >              [17] VA: 600108b8000, PA: 140000000, 256M, priv, RW, ...
> >    Full info tlb dumps:
> >
> https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verific=
ation/0002-tte-size2/logs/pristine-plain-boot-tlb.txt
> >
> https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verific=
ation/0002-tte-size2/logs/patched-plain-boot-tlb.txt
> >
> > The reproduction as a script, verify.sh (fetches firmware, MD and
> > ISO, checks their hashes, boots):
> >
> https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verific=
ation/0002-tte-size2/verify.sh
> >
> > On sun4u the pre-extension page sizes are verified by
> > make check-qtest-sparc64 and make check-functional-sparc64 (sun4u,
> > tuxrun, migration), which pass on the patched build with logs:
> >
> https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verific=
ation/0002-tte-size2/check-qtest-sparc64.log
> >
> https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verific=
ation/0002-tte-size2/check-functional-sparc64.log
> > To check whether
> > Size<2> is exercised at all, I added a temporary log in
> > replace_tlb_entry() and ran both suites again: zero hits, as expected
> > -- IIi predates IV+ and doesn't implement Size<2>, so the guest
> > running under it never sets bit 48. Result:
> >
> https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verific=
ation/0002-tte-size2/sun4u-bit48-probe/RESULT
> > Probe and logs:
> >
> https://github.com/unix0cc/qemu-experimental-patches/tree/967a037/verific=
ation/0002-tte-size2/sun4u-bit48-probe/
> > 32M/256M on sun4u stays untested by this suite; that would need a guest
> > running under Sun-UltraSparc-IV-plus.
> >
> > Overview of everything above (scripts, logs, README):
> >
> https://github.com/unix0cc/qemu-experimental-patches/blob/967a037/verific=
ation/0002-tte-size2/README
> >
> >   target/sparc/cpu.h         |  4 +++-
> >   target/sparc/ldst_helper.c |  9 +++++++--
> >   target/sparc/mmu_helper.c  | 12 ++++++++++++
> >   3 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> > index 31a16c2af0..1ab420d831 100644
> > --- a/target/sparc/cpu.h
> > +++ b/target/sparc/cpu.h
> > @@ -307,7 +307,9 @@ enum {
> >   #define TTE_SET_USED(tte)   ((tte) |=3D TTE_USED_BIT)
> >   #define TTE_SET_UNUSED(tte) ((tte) &=3D ~TTE_USED_BIT)
> >
> > -#define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
> > +#define TTE_PGSIZE_HI_BIT   (1ULL << 48)
> > +#define TTE_PGSIZE(tte)     ((((tte) >> 61) & 3ULL) | \
> > +                             (((tte) & TTE_PGSIZE_HI_BIT) >> 46))
> >   #define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
> >   #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
> >
> > diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> > index 4ec8799d1f..142c1c24de 100644
> > --- a/target/sparc/ldst_helper.c
> > +++ b/target/sparc/ldst_helper.c
> > @@ -186,7 +186,7 @@ static void demap_tlb(SparcTLBEntry *tlb,
> target_ulong demap_addr,
> >                   /* demap page
> >                      will remove any entry matching VA */
> >                   mask =3D 0xffffffffffffe000ULL;
> > -                mask <<=3D 3 * ((tlb[i].tte >> 61) & 3);
> > +                mask <<=3D 3 * TTE_PGSIZE(tlb[i].tte);
> >
> >                   if (!compare_masked(demap_addr, tlb[i].tag, mask)) {
> >                       continue;
> > @@ -217,7 +217,12 @@ static uint64_t sun4v_tte_to_sun4u(CPUSPARCState
> *env, uint64_t tag,
> >           return sun4v_tte;
> >       }
> >       sun4u_tte =3D TTE_PA(sun4v_tte) | (sun4v_tte & TTE_VALID_BIT);
> > -    sun4u_tte |=3D (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
> > +    {
> > +        uint64_t pgsz =3D TTE_PGSIZE_UA2005(sun4v_tte);
> > +        sun4u_tte |=3D (pgsz & 3ULL) << 61; /* TTE_PGSIZE bits 61-62 *=
/
> > +        sun4u_tte |=3D (pgsz & 4ULL) ?
> > +            TTE_PGSIZE_HI_BIT : 0; /* TTE_PGSIZE bit 48 */
> > +    }
> >       sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_NFO_BIT_UA2005,
> TTE_NFO_BIT);
> >       sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_USED_BIT_UA2005,
> TTE_USED_BIT);
> >       sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_W_OK_BIT_UA2005,
> TTE_W_OK_BIT);
> > diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
> > index 07ba25dfce..8544de097d 100644
> > --- a/target/sparc/mmu_helper.c
> > +++ b/target/sparc/mmu_helper.c
> > @@ -830,6 +830,12 @@ void dump_mmu(CPUSPARCState *env)
> >               case 0x3:
> >                   mask =3D "  4M";
> >                   break;
> > +            case 0x4:
> > +                mask =3D " 32M";
> > +                break;
> > +            case 0x5:
> > +                mask =3D "256M";
> > +                break;
> >               }
> >               if (TTE_IS_VALID(env->dtlb[i].tte)) {
> >                   qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
> > @@ -869,6 +875,12 @@ void dump_mmu(CPUSPARCState *env)
> >               case 0x3:
> >                   mask =3D "  4M";
> >                   break;
> > +            case 0x4:
> > +                mask =3D " 32M";
> > +                break;
> > +            case 0x5:
> > +                mask =3D "256M";
> > +                break;
> >               }
> >               if (TTE_IS_VALID(env->itlb[i].tte)) {
> >                   qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
>
> Hi,
>
> I've run this over a few sun4u test images and it doesn't seem to
> introduce any
> regressions. I just need to make sure there is no conflict with our AI
> policy here,
> otherwise I'll queue it.
>
> I don't think the AI policy might be relevant for such patches. Probably
any human would have done it precisely the same way. At least I'm sure I
would.

Kind regards
Artyom

--0000000000003935e5065e1b5be4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Mark,=C2=A0<br><br><div class=3D"gmail_quote" dir=3D"a=
uto"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=81, 18 =D0=BE=D0=BA=D1=
=82. 2026 =D0=B3., 11:23 Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-a=
yland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>&gt;:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">On 18/09/2026 11:57, dpim wrote:<br>
<br>
&gt; Currently, the TTE&#39;s page-size field, Size, is 2 bits wide:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 #define TTE_PGSIZE(tte)=C2=A0 =C2=A0 =C2=A0(((tte)=
 &gt;&gt; 61) &amp; 3ULL)<br>
&gt; <br>
&gt; That is the TTE of every UltraSPARC before UltraSPARC IV+.<br>
&gt; The JPS1 implementation supplements for UltraSPARC III and IV+<br>
&gt; describe the TTE word in tables F-1 and F-1-4 respectively, and differ=
<br>
&gt; in one bit:<br>
&gt; Before IV+ bit 48 is reserved and reads as 0, Size is 2 bits at 62:61;=
<br>
&gt; On IV+ bit 48 is Size&lt;2&gt;, which &quot;is the most significant bi=
t of the<br>
&gt; page size and is concatenated with bits &lt;62:61&gt;&quot;<br>
&gt; On T1 the same split exists, szl at 62:61 and szh at 48 (T1 Supplement=
,<br>
&gt; sec. 13.1.2).<br>
&gt; <br>
&gt; QEMU models parts on both sides of that change (UltraSPARC III/IIIi/IV=
,<br>
&gt; IV+, T1, T2) with the III layout: Size&lt;2&gt; was never implemented.=
<br>
&gt; Bit 48 gets lost in more than one place:<br>
&gt; <br>
&gt; On sun4u the raw TTE word is stored as the guest wrote it, bit 48<br>
&gt; included, but TTE_PGSIZE() only reads bits 62:61: the bit survives in<=
br>
&gt; the TLB, it is just never decoded.<br>
&gt; <br>
&gt; On sun4v, sun4v_tte_to_sun4u() converts the incoming three-bit code<br=
>
&gt; (cpu.h defines TTE_PGSIZE_UA2005() for it, unused until now) but maske=
d<br>
&gt; it to two:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 sun4u_tte |=3D (sun4v_tte &amp; 3ULL) &lt;&lt; 61;=
 /* TTE_PGSIZE */<br>
&gt; <br>
&gt; so the third bit was dropped before it was stored.<br>
&gt; <br>
&gt; demap_tlb() duplicates the same 2-bit math instead of calling<br>
&gt; TTE_PGSIZE(), so it misses bit 48 too, for a TTE from either origin.<b=
r>
&gt; <br>
&gt; Either way 256M decodes as 64K and 32M as 8K; the guest faults on the<=
br>
&gt; first access past the truncated entry.<br>
&gt; <br>
&gt; This patch implements Size&lt;2&gt; at bit 48, where the hardware keep=
s it.<br>
&gt; <br>
&gt; TTE_PGSIZE() now reads bit 48 as the high bit; on parts that keep bit<=
br>
&gt; 48 reserved it reads as zero, so they decode as before.<br>
&gt; sun4v_tte_to_sun4u() stores the full three-bit code, and demap_tlb()<b=
r>
&gt; now calls TTE_PGSIZE() instead of its own copy. dump_mmu() gains 32M<b=
r>
&gt; and 256M labels.<br>
&gt; <br>
&gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/20260727233646.332=
875-1-sun4qemu@gmail.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">=
https://lore.kernel.org/qemu-devel/20260727233646.332875-1-sun4qemu@gmail.c=
om/</a><br>
&gt; AI-used-for: code, analysis<br>
&gt; Signed-off-by: Dmitry Pimenov &lt;<a href=3D"mailto:sun4qemu@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">sun4qemu@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; v2: described behaviour across sun4u/sun4v instead of the sun4v<br>
&gt; conversion; no functional change. QEMU_BUILD_BUG_ON and comments in<br=
>
&gt; cpu.h/ldst_helper.c are dropped.<br>
&gt; <br>
&gt; This email&#39;s text -- beyond the code and analysis the trailer abov=
e<br>
&gt; covers -- also had AI involvement: current policy (AGENTS.md)<br>
&gt; declines AI-derived content outright, and even the not-yet-merged<br>
&gt; llm-usage.rst RFC would require it to be human-written regardless of<b=
r>
&gt; any trailer. Sending as-is rather than silently -- happy to hear if<br=
>
&gt; that&#39;s not acceptable here.<br>
&gt; <br>
&gt; Happy to run more tests or provide more evidence if this isn&#39;t eno=
ugh.<br>
&gt; <br>
&gt; Guest is OpenSolaris snv_134 (osol-dev-134-ai-sparc.iso). Firmware is<=
br>
&gt; the S10image/ set from OpenSPARCT1_Arch.1.5.tar.bz2, which<br>
&gt; docs/system/target-sparc64.rst names for this machine, except the<br>
&gt; MD/hv-config pair (1up-md.bin, 1up-hv.bin), from the repo below. The<b=
r>
&gt; archive&#39;s own config only boots disk.s10hw2, capped at 4M pages.<b=
r>
&gt; <br>
&gt; Observed on upstream 5f664cd37a, with and without this patch -- same<b=
r>
&gt; guest, firmware and RAM, plain `boot` at the `ok` prompt (occasionally=
<br>
&gt; hits an unrelated, pre-existing trap in OBP&#39;s loader phase before =
the<br>
&gt; kernel runs):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 pristine: hangs after &quot;Loading: /platform/sun4v/kern=
el/sparcv9/unix&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;info tlb&quot; s=
hows no 32M or 256M entry.<br>
&gt;=C2=A0 =C2=A0 patched:=C2=A0 boots to &quot;Enter user name for system =
maintenance&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;info tlb&quot; s=
hows 256M entries, e.g.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [17] VA: 600108b8000, =
PA: 140000000, 256M, priv, RW, ...<br>
&gt;=C2=A0 =C2=A0 Full info tlb dumps:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experim=
ental-patches/blob/967a037/verification/0002-tte-size2/logs/pristine-plain-=
boot-tlb.txt" rel=3D"noreferrer noreferrer" target=3D"_blank">https://githu=
b.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-=
size2/logs/pristine-plain-boot-tlb.txt</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experim=
ental-patches/blob/967a037/verification/0002-tte-size2/logs/patched-plain-b=
oot-tlb.txt" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github=
.com/unix0cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-s=
ize2/logs/patched-plain-boot-tlb.txt</a><br>
&gt; <br>
&gt; The reproduction as a script, verify.sh (fetches firmware, MD and<br>
&gt; ISO, checks their hashes, boots):<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experimental-p=
atches/blob/967a037/verification/0002-tte-size2/verify.sh" rel=3D"noreferre=
r noreferrer" target=3D"_blank">https://github.com/unix0cc/qemu-experimenta=
l-patches/blob/967a037/verification/0002-tte-size2/verify.sh</a><br>
&gt; <br>
&gt; On sun4u the pre-extension page sizes are verified by<br>
&gt; make check-qtest-sparc64 and make check-functional-sparc64 (sun4u,<br>
&gt; tuxrun, migration), which pass on the patched build with logs:<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experimental-p=
atches/blob/967a037/verification/0002-tte-size2/check-qtest-sparc64.log" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/unix0cc/qe=
mu-experimental-patches/blob/967a037/verification/0002-tte-size2/check-qtes=
t-sparc64.log</a><br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experimental-p=
atches/blob/967a037/verification/0002-tte-size2/check-functional-sparc64.lo=
g" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/unix0=
cc/qemu-experimental-patches/blob/967a037/verification/0002-tte-size2/check=
-functional-sparc64.log</a><br>
&gt; To check whether<br>
&gt; Size&lt;2&gt; is exercised at all, I added a temporary log in<br>
&gt; replace_tlb_entry() and ran both suites again: zero hits, as expected<=
br>
&gt; -- IIi predates IV+ and doesn&#39;t implement Size&lt;2&gt;, so the gu=
est<br>
&gt; running under it never sets bit 48. Result:<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experimental-p=
atches/blob/967a037/verification/0002-tte-size2/sun4u-bit48-probe/RESULT" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/unix0cc/q=
emu-experimental-patches/blob/967a037/verification/0002-tte-size2/sun4u-bit=
48-probe/RESULT</a><br>
&gt; Probe and logs:<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experimental-p=
atches/tree/967a037/verification/0002-tte-size2/sun4u-bit48-probe/" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://github.com/unix0cc/qemu-ex=
perimental-patches/tree/967a037/verification/0002-tte-size2/sun4u-bit48-pro=
be/</a><br>
&gt; 32M/256M on sun4u stays untested by this suite; that would need a gues=
t<br>
&gt; running under Sun-UltraSparc-IV-plus.<br>
&gt; <br>
&gt; Overview of everything above (scripts, logs, README):<br>
&gt;=C2=A0 =C2=A0 <a href=3D"https://github.com/unix0cc/qemu-experimental-p=
atches/blob/967a037/verification/0002-tte-size2/README" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">https://github.com/unix0cc/qemu-experimental-p=
atches/blob/967a037/verification/0002-tte-size2/README</a><br>
&gt; <br>
&gt;=C2=A0 =C2=A0target/sparc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +++-<br>
&gt;=C2=A0 =C2=A0target/sparc/ldst_helper.c |=C2=A0 9 +++++++--<br>
&gt;=C2=A0 =C2=A0target/sparc/mmu_helper.c=C2=A0 | 12 ++++++++++++<br>
&gt;=C2=A0 =C2=A03 files changed, 22 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h<br>
&gt; index 31a16c2af0..1ab420d831 100644<br>
&gt; --- a/target/sparc/cpu.h<br>
&gt; +++ b/target/sparc/cpu.h<br>
&gt; @@ -307,7 +307,9 @@ enum {<br>
&gt;=C2=A0 =C2=A0#define TTE_SET_USED(tte)=C2=A0 =C2=A0((tte) |=3D TTE_USED=
_BIT)<br>
&gt;=C2=A0 =C2=A0#define TTE_SET_UNUSED(tte) ((tte) &amp;=3D ~TTE_USED_BIT)=
<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define TTE_PGSIZE(tte)=C2=A0 =C2=A0 =C2=A0(((tte) &gt;&gt; 61) &amp;=
 3ULL)<br>
&gt; +#define TTE_PGSIZE_HI_BIT=C2=A0 =C2=A0(1ULL &lt;&lt; 48)<br>
&gt; +#define TTE_PGSIZE(tte)=C2=A0 =C2=A0 =C2=A0((((tte) &gt;&gt; 61) &amp=
; 3ULL) | \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((tte) &amp; TTE_PGSIZE_HI_BIT) &gt;&gt=
; 46))<br>
&gt;=C2=A0 =C2=A0#define TTE_PGSIZE_UA2005(tte)=C2=A0 =C2=A0 =C2=A0((tte) &=
amp; 7ULL)<br>
&gt;=C2=A0 =C2=A0#define TTE_PA(tte)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((tte=
) &amp; 0x1ffffffe000ULL)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c<b=
r>
&gt; index 4ec8799d1f..142c1c24de 100644<br>
&gt; --- a/target/sparc/ldst_helper.c<br>
&gt; +++ b/target/sparc/ldst_helper.c<br>
&gt; @@ -186,7 +186,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_u=
long demap_addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=
 demap page<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 will remove any entry matching VA */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ma=
sk =3D 0xffffffffffffe000ULL;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask &lt;&lt;=
=3D 3 * ((tlb[i].tte &gt;&gt; 61) &amp; 3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask &lt;&lt;=
=3D 3 * TTE_PGSIZE(tlb[i].tte);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (!compare_masked(demap_addr, tlb[i].tag, mask)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0continue;<br>
&gt; @@ -217,7 +217,12 @@ static uint64_t sun4v_tte_to_sun4u(CPUSPARCState =
*env, uint64_t tag,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return sun4v_tte;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sun4u_tte =3D TTE_PA(sun4v_tte) | (sun4v_tte=
 &amp; TTE_VALID_BIT);<br>
&gt; -=C2=A0 =C2=A0 sun4u_tte |=3D (sun4v_tte &amp; 3ULL) &lt;&lt; 61; /* T=
TE_PGSIZE */<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t pgsz =3D TTE_PGSIZE_UA2005(sun4v=
_tte);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sun4u_tte |=3D (pgsz &amp; 3ULL) &lt;&lt;=
 61; /* TTE_PGSIZE bits 61-62 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sun4u_tte |=3D (pgsz &amp; 4ULL) ?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TTE_PGSIZE_HI_BIT : 0; /* T=
TE_PGSIZE bit 48 */<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_NF=
O_BIT_UA2005, TTE_NFO_BIT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_US=
ED_BIT_UA2005, TTE_USED_BIT);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sun4u_tte |=3D CONVERT_BIT(sun4v_tte, TTE_W_=
OK_BIT_UA2005, TTE_W_OK_BIT);<br>
&gt; diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c<br>
&gt; index 07ba25dfce..8544de097d 100644<br>
&gt; --- a/target/sparc/mmu_helper.c<br>
&gt; +++ b/target/sparc/mmu_helper.c<br>
&gt; @@ -830,6 +830,12 @@ void dump_mmu(CPUSPARCState *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ma=
sk =3D &quot;=C2=A0 4M&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x4:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D &quo=
t; 32M&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x5:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D &quo=
t;256M&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TTE_IS_VALID=
(env-&gt;dtlb[i].tte)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qe=
mu_printf(&quot;[%02u] VA: %&quot; PRIx64 &quot;, PA: %llx&quot;<br>
&gt; @@ -869,6 +875,12 @@ void dump_mmu(CPUSPARCState *env)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 0x3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ma=
sk =3D &quot;=C2=A0 4M&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0br=
eak;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x4:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D &quo=
t; 32M&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x5:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D &quo=
t;256M&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TTE_IS_VALID=
(env-&gt;itlb[i].tte)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qe=
mu_printf(&quot;[%02u] VA: %&quot; PRIx64 &quot;, PA: %llx&quot;<br>
<br>
Hi,<br><br>
I&#39;ve run this over a few sun4u test images and it doesn&#39;t seem to i=
ntroduce any <br>
regressions. I just need to make sure there is no conflict with our AI poli=
cy here, <br>
otherwise I&#39;ll queue it.<br><br></blockquote></div><div dir=3D"auto">I =
don&#39;t think the AI policy might be relevant for such patches. Probably =
any human would have done it precisely the same way. At least I&#39;m sure =
I would.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Kind regards=C2=
=A0</div><div dir=3D"auto">Artyom</div><div class=3D"gmail_quote" dir=3D"au=
to"></div></div>

--0000000000003935e5065e1b5be4--

