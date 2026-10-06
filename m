Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E819ACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMIT-00054R-Oc; Wed, 07 Oct 2026 03:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEGdx-0005dN-4Y
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:40:55 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEGdY-0000a9-Qe
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:40:10 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-97ca72f2cd9so682557241.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791336971; cv=none;
 d=google.com; s=arc-20260327;
 b=OYirS1okj3HJmj04N9Bz0+n2iERQXZHfkJZ+2eVmJRLHQOUvRYK6nh8RRI+vNzctHG
 Bt5IOqAa9dJ0+6aupcdwYBw5mvld3vxxb6vi+gC9J9lLd98KcvWtFyRMugzLAnyQTn6c
 Z29GgjEPcc9eic/BVXrduHGrGoZ5GHf3ioQh5n3kiZhsBK390VhIwoTC55hyUDRqvSb3
 zERstf6RbvAoXSHoDnn9MJaPdvSs6yeOrRP5OBytULD1d/GZQ7vG9wpKMUrLxrW1yC3/
 yub8QLwkVJo/cXIdjkyvzspnYUJso9e8zO3PiaE7iemp5oe8Kheu3z7KPsWdPJW2yQwQ
 vnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BNe28fzsNkReZkp5SawmoMK8Xda+uKQwSZoPrHwYWD4=;
 fh=wTxIsAelXXjAlRbDvt0umNptksPbd8Ep0cPp+Wu6Bro=;
 b=nvjzkctEb/+49QK8VmX4MmS1NCgtb+fRV1fQezxYOflHFVXckzhwRJWtkLjdgvdAxx
 kcMPC3Dg0mLUlgmXonkjf55R65GAOJ3+JZlnDyR/FlFUU+bVl0ExEl/sqCqm3E7FT9x4
 4eiTh3xr1azTCT54/scZvzIC0/29m6afxNzoErtM9evKbLv9mePGIFXQAl6myNfzf312
 dD0ObfFEbbNDvoC2BYNOwv/8RSln6eUilpkxGuBwyBjcUWewDwmxtW7J1i5KqG0T+pDB
 +FBO5RAJL1KZNREMVKImAn6Lv//MQHNDDvtDRWI7tKgdWNO85ZbhVMhj+FYAZKjK+ydH
 j7pA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791336971; x=1791941771; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BNe28fzsNkReZkp5SawmoMK8Xda+uKQwSZoPrHwYWD4=;
 b=Gw4vPX/++ji7hm8+Hf3yOCZwRrLjjF6VNf6UUygAMlEv5aHorTgOUx9OaAhp/SiKJO
 SXt0RqYb/xEUrKklOWTbTCO0kPDFa1kHcl/VuwqnmNQ7foff+nxYUcJX0wBTThylBm2m
 zHV071KLD8NfiQBMOSBiQmZPvD6ZYV4U0fPPJlhxCq84VzZrSkcbREcuMSr60Wrz9y06
 9F9WgssX9kISzv3UBq7RNYKomEwMn63x+xH2XjV37QnEjHISl44y80EARtS7md7kDDsN
 gXrc8oU7t1K5GmVfUJXJRmw6PL7yMw61wu71+gTCgrOVda+E+7MlNth9ERHjG/+vrFFY
 CLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336971; x=1791941771;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BNe28fzsNkReZkp5SawmoMK8Xda+uKQwSZoPrHwYWD4=;
 b=jaFvcI/x5kfui0+0GaWHrYAWGRaWERBghv6W5CEX39kOdJGVnSYghB2vMyW7Vm0Uex
 0duNlPDWNa6BWnyzLPKWemdtvww6Lt6v9kvoECFDh/FunuowoUGYwcrOVCTjfnoEEjoX
 vu9JUFk9IEGYcJM7SFhOpD8dVwPsKNtBmP3aHamvi2EkbAKUagnAVjiK15n/Rdtytyji
 iq1/brDPIQUaLXOgUz1RjTt9xUu/m+3wf09UQEaoy1xZc53VUaKtX6B3myR4i/3pxGDU
 J+rHBON6nUg4u7L7QeHsDdFRgWxFSup96A7eh9vJrO49L7XHIh9gG3pga45WAdrOW9m6
 hlGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQA3qefEXMD4NgeJWrx2B2GqW05BrE1eNtR+u2r6SGgxB+rcJzDT95A+UUxxmJSUiobUdIatPpKW2z@nongnu.org
X-Gm-Message-State: AFq9FYJrxUrXQdtJ3JGFYdNwJKqEQecgs+33wVFle6q9lpGmm1eFuB2E
 g52/LBUp7os1tP2mNJLl5CjHnSJd2K5AuKP8UgldLViKnrp86se32BglWG4w1B0uQFMCv9lniRc
 ruWQYd8jFi7SDnZCilkRGMzrl492f83d7K1zyomzhr5jXE713LG1mGNdQZQ==
X-Gm-Gg: AYBFou3rt7MvwX/2VpvQmmV7RqwnJujvKxiHW6bAsd+4Aw8D0zADPtATKFXOTXrKg9a
 VoF5EtxjUCsanjWBnqCD0qJNgavc1lHt6o/W7UzToFVlNbBMFO/zrYud+ohKEsxtnBudLAYIVRU
 /8qwWypoDVK9sUn6Vz+95Sq8yGGxCAwaNa1Jdqt9mhxaLtem7sKwsQzDvFjKPrFngAXMQYC6/VR
 FtJfODN5tiM8OfI6eRUcyAr9BesDEygr8hSwOxCaeEDPLQycFxWX/PTx1cf+zJUw3vd4xAl/8Uq
 gckR8VnJP5faXf+xnK9vnS7X3cDegNTxXmFgVxPtPUAhO6Tng4dj7kZ9oFt0eBxHvTDDorNaeZX
 DRERB2VJdH+NW3jK4e16ZLffdbdRPQt/z2XPoayQ=
X-Received: by 2002:a05:690c:6d83:b0:8af:1843:a9e5 with SMTP id
 00721157ae682-8b04f489215mr4470257b3.23.1791285868752; Tue, 06 Oct 2026
 04:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261001175003.ttbr-baddr-52bit-0-fuad.tabba@linux.dev>
 <20261002070925.2627344-2-fuad.tabba@linux.dev>
In-Reply-To: <20261002070925.2627344-2-fuad.tabba@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 12:24:17 +0100
X-Gm-Features: AclHuK_TkizGvf2w5BH9Ft35CVoiFyCh2Bna_MqzKkZHPm7QtqNfesSt9hkXhj8
Message-ID: <CAFEAcA_+gr25p1gix=qto5DQzh=VAguhAUh6Una9uMLzNYWZmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Use the 52-bit TTBR base address layout
 when TCR.DS is set
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Will Deacon <will@kernel.org>,
 Itaru Kitayama <itaru.kitayama@linux.dev>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=peter.maydell@linaro.org; helo=mail-ua1-x932.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 2 Oct 2026 at 08:09, Fuad Tabba <fuad.tabba@linux.dev> wrote:
>
> With TCR.DS set, TTBR[5:2] hold bits [51:48] of the translation table
> base address, whatever the OA size. If the effective OA size is below
> 52 bits, setting any of them is a level 0 Address size fault
> (AArch64_S1TTBaseAddress(), AArch64_S1Walk()).
>
> get_phys_addr_lpae() uses the 52-bit layout only when the OA size is
> over 48 bits. With TCR.DS set and an IPS of 48 bits, it takes TTBR[5:2]
> as base address bits [5:2] instead. A guest that sets them gets no
> fault: the walk either succeeds with TTBR[5:2] ignored, or reads its
> first descriptor from the wrong address. VTTBR walks with VTCR.DS take
> the same path.
>
> Use the 52-bit layout whenever TCR.DS is set, and check the whole base
> address against the OA size. Add TCR.DS and VTCR.DS cases with a 48-bit
> OA to the test.
>
> Fixes: ef56c2425e5f ("target/arm: Implement FEAT_LPA2")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
> ---
>  target/arm/ptw.c                      | 16 ++++----
>  tests/tcg/aarch64/system/ttbr-baddr.c | 53 +++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 6cff52d592..16f5fdfe0b 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2107,18 +2107,18 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
>      descaddr = extract64(ttbr, 0, 48);
>
>      /*
> -     * With a 52-bit OA (FEAT_LPA or FEAT_LPA2), bits [51:48] of descaddr are
> -     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: a table
> -     * under 64 bytes is still 64-byte aligned (R_KBLCR).
> +     * With a 52-bit OA, or with TCR.DS, bits [51:48] of the base address are
> +     * in [5:2] of TTBR, and bits [5:0] of the base address are zero: the
> +     * table is at least 64-byte aligned.

You put that R_KBLCR reference into this comment in patch 1, so
why are you deleting it again in patch 2?

>       *
> -     * Otherwise, if the base address is out of range, raise AddressSizeFault.
> -     * In the pseudocode, this is !IsZero(baseregister<47:outputsize>),
> -     * but we've just cleared the bits above 47, so simplify the test.
> +     * If the base address is out of range, raise AddressSizeFault, as
> +     * AArch64_OAOutOfRange() does in the pseudocode.

Please don't drop information that's still relevant. This comment is
remarking that although the pseudocode is doing an IsZero check only
on the bits of the address between the max physaddr size and the
outputsize, QEMU is doing a check on all the upper bits, and saying
why that's OK. This is still the case, although the pseudocode has
changed a little so AArch64_OAOutOfRange()'s test is now:
   return !IsZero(address[NUM_PABITS-1:oasize]);
(and NUM_PABITS is 56).

>       */
> -    if (outputsize > 48) {
> +    if (outputsize > 48 || param.ds) {
>          descaddr &= ~MAKE_64BIT_MASK(0, 6);
>          descaddr |= extract64(ttbr, 2, 4) << 48;
> -    } else if (descaddr >> outputsize) {
> +    }
> +    if (descaddr >> outputsize) {
>          level = 0;
>          fi->type = ARMFault_AddressSize;
>          goto do_fault;

The code changes here look correct (compare AArch64_S1TTBaseAddress()
which checks walkparams.ds == '1' || (complex expr for FEAT_LPA)).

thanks
-- PMM

