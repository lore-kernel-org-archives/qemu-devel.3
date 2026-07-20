Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC89C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljXO-0004c5-RT; Mon, 20 Jul 2026 04:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljXN-0004bn-Ha
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:39:45 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljXL-00033B-MD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:39:45 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-80814edb536so67440727b3.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536782; cv=none;
 d=google.com; s=arc-20260327;
 b=QVxE4tzvxGSIXTzyC9WjKTzL2I2P46qekbLZFzX5UIbHuBh5xiWJk9wCvgC+LT/gjN
 oSqojlj2opjOZCulWlfvxOB4IRpSen5JEU7PoEXQYnfwSGo1OHG8VGrcZZLUbjIxJpUc
 4lagac0kOYOZ11UE6qmOd3+lYqoHyTTp/2/5b/rPuG+OH/XcdfGFAI/gWYelj+tIOQQo
 Vuh7zhmOe/K46wsAlsGx46ZJdSzkWgtaIFiMgkjY0C/I11FNcEETaGQ410iS7HHS3koF
 7d2W0ecmw7pmasvRQLv1pOpRSRRXfc9mBZVQfpPmqsp2UHk/v8UATQKDYrlakq3sTgRl
 9BoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=sPMKVRs2YolYOTVPLxJzSQtljSvEn18yhYhoZvGNaKI=;
 fh=jaMzx8HEjQowExyDQRok/dSeNj0SaVh5RJRWlty3W7Y=;
 b=c6HK+m/OO1tiIFWgOvJx+oWSxCuCIQO4q1DAo1BVzkI8vSyLjmWsOxr2m1oLEjBpcl
 iBgu2Z+hxv3mLa9yz8BGPBilbR86N3Q4YocThGbl5agQIWeXdmxJUhJ2iShERlTbonhc
 UvHsxnK8FSr6oXth9Wm3KKHU3EMVzFHFjSK3OX+q6mOwRDucPfHisY+S850NsFPI5u9h
 Fb7+WxtP2BDBeGdUcwWJL+G+90h8DDFfO082oy96MPqx1ddAoKt2KPrAahFxyENWoyDe
 jr67S+Fc59zy0n7qx2jrSqCvVlIoO49z3K+teTwoDmPOT+oHlX2uC+q4FvwDTcraBMdu
 taRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784536782; x=1785141582; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sPMKVRs2YolYOTVPLxJzSQtljSvEn18yhYhoZvGNaKI=;
 b=MIkJzicjG03ZPl79KNUodaC0Prax/vBkOS9REyKKvG+HS59TyD/rpHxC3clcSnb8FO
 mQuSEsYsUnSnOFvCPKEglAXyVBLBsGtiztLl7rzbkGhzuEuFyRBJXnkky1cu+WQtsaIC
 lX8+I+l1cp/NTejcgPFMyv2fX8jgOwueSl5byk2wtrnhN926yhVx0B8ynjAoMJRCGbyA
 Pe7dzFYg/C8YvDvqlNBm+5uem37JB7lYM7T+VISjHbvn8m1cVneywwgeijyuGYpHa/jo
 kgto+w0zPrJDaQO6W0zeNV+esAPmIM5GObs+khHyC5bHkIfISQzgg62qGcbzEYafXlBT
 nCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536782; x=1785141582;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPMKVRs2YolYOTVPLxJzSQtljSvEn18yhYhoZvGNaKI=;
 b=W8ARoCCZWL3uJ6+HlF11Bm0/vLW4Zl9F5absFgGYXtaw0cn5C/E9kYxdHSXWHKyPM2
 ctVYok4Hx6QpY1D9CE0ZVZ1ilzHJr7C/eLocwwjBryVuN1KGCZEnHqtm93TLessidY4O
 CbXV01S4X1kyl70fH0HOSsSs2pOoo4PyGhkWirfuhBKJ75mBnMrDfmHakSw24zRSGFn5
 Xq3sSMSA4mZVvOJ91jPuHMnk80TfxYRPujSQm5gQbwRb4i/FEpPYg/sCqL4EpQrSyE8o
 fGVQPtKnR8w3AMrH7XitZRfpcNAVQaNFIRdc6hMFQ0EOr3aR15E1r6oGgrO7/OpYfXj3
 Ohvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8DdNAcs/1EfkbIOwRWpuDTqHu2l5RLekQDiabIF8fCy9rO5jPKFV19WP3YocXq2ad/CVlGTzj2233@nongnu.org
X-Gm-Message-State: AOJu0YxlblZsbhdbFzjFBCDmeWNo1QIIOJag1aCBj/g1BUbKRMir1msY
 ASjSGrTHoBN5CBYmQYoe0kYBfjQBVbgp0/tq1toeasavjMdd20s4YKjaI1Y4rDzlAwERLJtXN28
 7A1Jgo6SJtdU+H0fM9uaSQ0vKDENPo6CeP3ylijkSxQ==
X-Gm-Gg: AR+sD13C0xiNBoaHIG4+LnVPs/YCXSTzdPQTADwfzneWhUaQSTZOM0xOdTTvjVFesGi
 Y23YPsP3N0PyiWV4UsqrfPQlGc/voPDw6z2OlFUy6kk6ZEKymvyKbkFk43XMMPDPMhPRFwGPlAK
 TlcoqSV6Sxz2pbT+uQ/j12/D4JO0UVr/F2ts+tZZuWVcCAj/9RfYMd51ZlM+NqmO1x9N2DH8Rzx
 i8Guz+QhPGlw7nargF9p3FAbcxBfNiNRFknu3//dlV2RFAyBGzHIl6z3nffTZgRYGVs7z53nDpP
 cD2DEIUOYxU3i98HRri9BgNZ77tkrjGyqtMrt1zbryDIKg==
X-Received: by 2002:a05:690c:c508:b0:81e:cf41:9ca9 with SMTP id
 00721157ae682-81ef260d3e0mr43920407b3.53.1784536781976; Mon, 20 Jul 2026
 01:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260709095056.1803725-1-peter.maydell@linaro.org>
 <20260709201237.46ba7f2d-72-amachhiw@linux.ibm.com>
In-Reply-To: <20260709201237.46ba7f2d-72-amachhiw@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 09:39:30 +0100
X-Gm-Features: AUfX_mxllmErbTBpjXTs3lHoBPEkMB-zbA10-s8br7wCEsc-CZQju3ixk7jxLL8
Message-ID: <CAFEAcA8__tL8Dh5XwAK_GifA2boh1uMfL_eZgMTFvyMq15hLwA@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: Remove unused helper_lscbx()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Ping: this has been reviewed, is somebody on the ppc side
going to pick it up ?

thanks
-- PMM

On Thu, 9 Jul 2026 at 15:46, Amit Machhiwal <amachhiw@linux.ibm.com> wrote:
>
> On 2026/07/09 10:50 AM, Peter Maydell wrote:
> > The helper_lscbx() function isn't called anywhere.  It used to be
> > used by the PPC 601 CPU support; we removed that in commit 005b69fdcc
> > in 2022 but missed this helper function.
> >
> > Fixes: 005b69fdcc ("target/ppc: Remove PowerPC 601 CPUs")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This came to my attention because Coverity reported a
> > "shifts into sign bit" issue in the function: CID 1663681
> > ---
> >  target/ppc/helper.h     |  1 -
> >  target/ppc/mem_helper.c | 28 ----------------------------
> >  2 files changed, 29 deletions(-)
>
> "git grep lscbx" returns only the declaration in helper.h and the
> definition in mem_helper.c -- no TCG translator references, no
> gen_lscbx, nothing in translate.c. Confirmed dead code with zero
> callers. Thanks for the cleanup.
>
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>
> Thanks,
> Amit
>
> >
> > diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> > index e99c8c824b..6b2d19a3ad 100644
> > --- a/target/ppc/helper.h
> > +++ b/target/ppc/helper.h
> > @@ -54,7 +54,6 @@ DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
> >  #endif
> >  DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
> >  DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
> > -DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
> >
> >  #if defined(TARGET_PPC64)
> >  DEF_HELPER_4(DIVDEU, i64, env, i64, i64, i32)
> > diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> > index 119dc1df23..787ba2cdec 100644
> > --- a/target/ppc/mem_helper.c
> > +++ b/target/ppc/mem_helper.c
> > @@ -367,34 +367,6 @@ void helper_icbiep(CPUPPCState *env, target_ulong addr)
> >  #endif
> >  }
> >
> > -/* XXX: to be tested */
> > -target_ulong helper_lscbx(CPUPPCState *env, target_ulong addr, uint32_t reg,
> > -                          uint32_t ra, uint32_t rb)
> > -{
> > -    int i, c, d;
> > -
> > -    d = 24;
> > -    for (i = 0; i < xer_bc; i++) {
> > -        c = cpu_ldub_data_ra(env, addr, GETPC());
> > -        addr = addr_add(env, addr, 1);
> > -        /* ra (if not 0) and rb are never modified */
> > -        if (likely(reg != rb && (ra == 0 || reg != ra))) {
> > -            env->gpr[reg] = (env->gpr[reg] & ~(0xFF << d)) | (c << d);
> > -        }
> > -        if (unlikely(c == xer_cmp)) {
> > -            break;
> > -        }
> > -        if (likely(d != 0)) {
> > -            d -= 8;
> > -        } else {
> > -            d = 24;
> > -            reg++;
> > -            reg = reg & 0x1F;
> > -        }
> > -    }
> > -    return i;
> > -}
> > -
> >  /*****************************************************************************/
> >  /* Altivec extension helpers */
> >  #if HOST_BIG_ENDIAN
> > --
> > 2.43.0

