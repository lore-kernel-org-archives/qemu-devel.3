Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F74F327C8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF6e9-0005bY-HQ; Tue, 21 Apr 2026 04:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wF6e7-0005b4-2s
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:39:51 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wF6e5-0002cP-Ad
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 04:39:50 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65006c99d38so3724824d50.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 01:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776760788; cv=none;
 d=google.com; s=arc-20240605;
 b=C9WHoLXT2ysmJYZJB9IL0OeErv2NhRnljpj8PwFAnuVxKPD0bAkLjm1gl7qfy4x1oq
 wBKHwBSFZnATPZpNok89I8i4bGsZpWQjm5vsJsVikTrekv41nw8glRcjmxFuPou5cEkI
 PZ+YVsdAXFAkkRFJudEV9RznVszQ1tN3wnb4ZpMRoXjF1USZVFxU+Id7fXks5diYPjO9
 XMGu2zr098aoyOaJjbFeChExKKywO5VtfuW2nrRnTU1IAWIbNeey2zv6yI7Qef5Ufswd
 v5yFAiFFlsf2gm1Veh3lVo9kSG1qJqW35Hzg4bqe7gJsYBp64ZpcTcNHshah4QJG2Hjz
 yCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WkrkKEPiE6o76ppNllO7Kkip67JjPVL/dOUbpu/tdUs=;
 fh=QzDfVTax6L6UX9hyN03AjD8AX423EV4qQK2O5I2vHx0=;
 b=W2aDIgMtbU/+5IVZ8Xrmme7FqlMUQuB5DfmnvFcLjkCaZ2FbGqt6sQC6h50ZLJeZrU
 gVIa2D3hUAqfmr87B2vyhDhtOaV8kG//bshBURerDUVC79uJuu0wFUZdQBCqBVnCdFhU
 6McMzXW5isfl7Y4X0h7J+BeLq9Ivz8IgqkbJTbHArV8NY7261oe7V+7Jzu6HHALR7USr
 dml2Pvbsv/hgkjbHEVGooAQ5qS56kQED/kb3vb9Tb5C4fP9AIDGV8xKdn5N9GECC3Hsm
 38KvNZjJLnebR37fLxustHrvr/6qTLakqRyaqPQRWPdXYfkPOcaxwBM+bLjk+mDvdVQp
 kOPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776760788; x=1777365588; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WkrkKEPiE6o76ppNllO7Kkip67JjPVL/dOUbpu/tdUs=;
 b=yVGClDDKEfbjAOBJtcrGj2kr7A8j0u1seCXcwxniNiVy0sb7lJJmg2VC18xDm1Xxnx
 Lw7Kir4ithU99Y1EiylSToklvuPNLChopdebmL1btT8laXQVdSLvJtcccvEnD4o1o8ds
 r5N4TWGBZaJF2ncJRyF+X/9ITWPzOehvA4qUZgJCxYRTssJ0bfYAXgSCra51FjkxnA8c
 lEnnL265uV/VNiHTgZYeZEmESLWFhwL2zKGcMGcsusteURv9XpBaoA02XennmmrChyfd
 73Qvlw/V2vhxQAx+fNdG450F2f+yrGbdSsMw9DszLB7KwHC1CSxfXz2/LQ/TOKfb9yIq
 D+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776760788; x=1777365588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkrkKEPiE6o76ppNllO7Kkip67JjPVL/dOUbpu/tdUs=;
 b=X6gAfPGfXTwaWR7nvqIuraaKBwN3x/CiqFm74yeaktB3ikA7/TbMtBtvhh22jif8Uu
 wL+Jz5Vpuyz0uI8Mu5Ou8YBTh1wLr6ojF+MPZM+KCCl7HWJ0OiIgMWQty5izJrjettHc
 90cO+9FoQkkgoVJfgINvC8fc1XStItGUKn/qQkyOw210434jcT71o2l/iO3OsHtQFPRV
 0hVwsJxzcn7qU1476NCmvxyRJkSH+Lh7zzGvgSgOq2yEBw4dYv33k6Rox6kROHlRIXZh
 DaWU8cWpHVpLB4zQfAVdW2fSjCVEGhI5cav/JTB5GcGfbhPzNYLv78gmPenPGR+pSkyp
 Umgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k2xxOKsB2H4/Ics4heUDAtBtfdarEeF5QITJviFQxL5Ix3nibNHXIJGZpFoIzZ8waoL6bi39nX4SJ@nongnu.org
X-Gm-Message-State: AOJu0Yw0Yiqd2ICsJeMkk7yQsosMMqcvdlknDB45pj/aMiYxfsqxM/hr
 GVZIe/8Xc/fnIFqGFqrsN5/btNpcl6JcPo6p5/6Y4hs2krsgrgl5iS2RYcnPVEnMrMfaBaO125j
 u2iXhs53MYy9ncyVvXwccqhS/mjrfkckcTE/WLGe6bQ==
X-Gm-Gg: AeBDietYNjmd4Fn5CX6jtl9qbLxOMc3zcPqLUkrdKWbCq9/7mgWhDC0Pm63V73ZUesV
 +jFmkRC6dX6o1ltO+z0TCJBGrw/84tQ2QOU07siOxZwX90puV6+k4oK/mijTTVbOnfYGQYV0qTi
 cbeT11hn/1BllF6w0CczoCerl2Um3GmdiyHYbCVPtCqnx4OSUYXl6N6RE5okmLLaaVDeiaAKacp
 ugs6p65vv3HrBsSSqC9cnT7VxzEfSdJqtb8O8dPETOTexYxLhyMXTOvMrmRQjIFQQ8f5zj1c69c
 iTMuqMJJPQeT893Jt+bgZHK/yAdhYiVeNAM2kGLehrlTF7tLOi05GZY3yWGFouceyFiGB+iV5lX
 4st4ho4Yfsp+K
X-Received: by 2002:a05:690e:488a:b0:651:c53a:ffd9 with SMTP id
 956f58d0204a3-65310b30793mr11274024d50.56.1776760787606; Tue, 21 Apr 2026
 01:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260420075159.106615-1-thuth@redhat.com>
 <CAFEAcA9=oLSEv89Y62kaVDjsdHXg00=yTnSt7W42aosm0B092w@mail.gmail.com>
 <e12933ef-5fb1-419c-b4c3-a1a9fc89fb44@redhat.com>
In-Reply-To: <e12933ef-5fb1-419c-b4c3-a1a9fc89fb44@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2026 09:39:35 +0100
X-Gm-Features: AQROBzBPXVmt-bpotCgiLVYfcQhAz6hJceupW-2L-TVIw1PY3Hwh-Q40GanMIdc
Message-ID: <CAFEAcA_wxoZ_jvXVO+iTyW9s+HpCNPhCEixGfGHepu2HP8jptw@mail.gmail.com>
Subject: Re: [PATCH] system/memory: Don't call MR handlers for bytes beyond
 the MR's size
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 21 Apr 2026 at 09:20, Thomas Huth <thuth@redhat.com> wrote:
>
> On 20/04/2026 11.51, Peter Maydell wrote:
> > On Mon, 20 Apr 2026 at 08:52, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> From: Thomas Huth <thuth@redhat.com>
> >>
> >> If a guest triggers a multi-byte read/write at the very end of a memory
> >> region, the code access_with_adjusted_size() still tries to access
> >> all bytes of the transfer, even if the final bytes are already beyond
> >> the memory region's size. If the device handler cannot cope with those
> >> accesses, bad things can happen, for example:
> >>
> >>   $ echo "writew 0x800064 0x4142" | \
> >>     ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
> >>   [I 0.000001] OPENED
> >>   [R +0.001750] writew 0x800064 0x4142
> >>   qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58:
> >>    avr_mask_write: Assertion `offset == 0' failed.
> >>   Aborted                    (core dumped)
> >>
> >> We really should not call MR handlers for bytes that are beyond the
> >> MR's size, so let's add a check to limit the size in such cases.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >
> > The MR in question sets .impl.max_access_size to 1 but leaves
> > .valid.max_access_size at its default (which we treat as 4),
> > and is then registered with an MR size of 1. Perhaps we should
> > also assert on MR registration that
> >    .valid.max_access_size <= the MR size ?
>
> Sounds like a good idea, but after a doing a quick check, it seems to me
> that we've got this pattern all over the place (see e.g. the "pcspk" or
> "kvmvapic" devices), so this would require a lot of clean-up patches first...

I realized yesterday while looking at something else that for
the IO case (i.e. x86 in/out insns, not memory-mapped) the
access size really can be bigger than the mapped size. There's
a comment in address_space_translate_internal() that mentions this:

    /* MMIO registers can be expected to perform full-width accesses based only
     * on their address, without considering adjacent registers that could
     * decode to completely different MemoryRegions.  When such registers
     * exist (e.g. I/O ports 0xcf8 and 0xcf9 on most PC chipsets), MMIO
     * regions overlap wildly.  For this reason we cannot clamp the accesses
     * here.

Port 0xcf8 is for PCI probing and is 32-bits wide; 0xcf9 is to
do with triggering reset.

thanks
-- PMM

