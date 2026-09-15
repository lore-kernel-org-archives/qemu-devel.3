Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4F8C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6PRY-00028n-8B; Tue, 15 Sep 2026 05:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6PRT-00028S-V2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:27:08 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6PRR-0000dx-UP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:27:07 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e56a1fe83so62080d50.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 02:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789464423; cv=none;
 d=google.com; s=arc-20260327;
 b=R4C6KVmBrnXgVfl0Rz0RSHK83wtSKIAqtV5x/TcriCR60lMmAHwygRTdwJxV4yD353
 88Sj30v/3atDPjoJhWDdeghGZiF+CwSbnuI8FFqNVpI8LwEQyzis/V1JeByDQv9dr/AQ
 njI0iF2KSSGbdp0+MEWYWLudnp/no3oiiRggTluk0R0L4a0khsWBb0J0Uwy5ATYIMMRz
 GajPRnYglqIwuL1CGBHPZGscYZ6JRMu4q6PnS7p5DZhCcWKgh//V1TtY7020R3rKPFYe
 5N7hTz690F+3ubC/CQwfr0zWyXu0wEHWYrZyOnwx4BQ30hCKZU21S0qhsLDFJKDjW5VL
 ZNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kJWLKjp4GOGXCfPOZ+gsvRnKFTOaquGm/0+TVK09fuo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=pO5FyELloOtZKQO//8jRc6D+jFv9jFWWIpH93Y33kaC4Dwgyw/dedOj3R9aVIcmQTl
 K1umcBlOmZcdnzAJ3/HJ9bc4wcM5aUCRO8F1Inh4glhby/x0JUl0ytq+aWH+9TswbuYK
 lf9YJAxJIhZgW+is6St3yWP0ay2jpSCCiEhvoD4uBodwRMywDrToROu6oEv1l9F62o1A
 HNOVzX+VBSWUWKJWnEwGZeLL44HNyVK4FWQutEy7VH5B0QZWuzj38NJJc1G+3TE3jwRv
 RgsfMFWGfIS2t9QvWO2ta77zmCxitr/i3RDc0jSr/ke1aLMFXMPDs8TCnKY6c7BxcT6Z
 xcHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789464423; x=1790069223; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kJWLKjp4GOGXCfPOZ+gsvRnKFTOaquGm/0+TVK09fuo=;
 b=ccUzhfoKc5/nhRFZ27FiYF7ZECpRc9R3/mE00p4EuYot6Rn8LxUxM0RTxsC1mu3lav
 B4q4EVE3fKrO55suJaO/xA4fwYZVhY0k4jfMMTi9Y5yifRJfRUGGGLO4lcD2zNtxzdM7
 2Qpe5QiyNp+g7+Ymvwsu6ei0urXe4Tw+Pr9pwvBOCOlZVFDWh1b1gmXutZs++/Y5cZ42
 SPqhGe8eovbKq9KRyL7wT9qZhHrc+d0ySkKJgoUot0OBN2Ese7bMrOVuqA+pIk0EGNF8
 fB+OpVV6tu73T+slzvM8j4Drgj39FR8CHSdGRN6Ljk69s9eGEaS6lNTyvEx4zqYTIvyw
 dSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464423; x=1790069223;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kJWLKjp4GOGXCfPOZ+gsvRnKFTOaquGm/0+TVK09fuo=;
 b=fQ7+PC/ocHf0A5cJezpvQ8jDfreqBIIspM0RlDM9an6yPxtSZIOtYER03CNMrEXOkA
 yJeuJsnklsdWWVSp6cpF8JHOFUfuquWTup813MQVj/HTXmmwJlDzK4E8OwUd+DfqxFmE
 ByFjaSD31ZhlogJKEoAw5daYi/LPCcdo1NEQyJhEMZkM+NYf8B6HFK9IsX6s2Y9WkNzD
 FFEIf/ARbSyxuw4iuqQLZE729GiedPHlTsdGPrLwuuQwluV52Mn1bICtNd8WokQxwhau
 rYEXFZQS6//z0tWPENI0HRiJh5ylSu07h8CcGi7jf0jgEfq0yS6l7YFxDhfYkF0FVibJ
 7eIA==
X-Gm-Message-State: AFuF++mepqwrVyjgOtrLjksjp3pdxh6XUuS8pxA9tiHWcD1Gfx/VaP7c
 Jmj1+1TEiBd4IHvwYYEKd0xiwYJB39xEC2p2gEDfYEijyLAwSQPJ+gDMO+fKwfRLh7lA5ag0y1m
 KrrE6O+Bd9qxhyJhlqQ0GHXelVb1qdmsBg7ZxM/dANQ==
X-Gm-Gg: AYBFou2MbtXttcKonHX2KUKlsRr2JErpgYYCGf/UavxCY8VDnUTUX/cEb7cXGZ2pKmX
 nfJ5dXjAS8cs2EwRTEYHSn27A+DVaMBjHiD7b7lnb/me0FIBQKtmhfO0L3gEJ5y+rs6HxEvoaUa
 /rymYQ4vSwBQUlRtLKBP+T3m1eqtP45aMu72hldFGLQ6Cr2VIoeUZ4NVFbERaT0zbcsCdEhO/5k
 q0C6Xfp+DZhZeGsws8inZj2tQpDre6ltu+sg08AE4lsgG1Y0LqAS/4RmEfBCz5S8zMXeONA6wpD
 euaykzXckNOTNo8bGx75ReAryGOR3FtvlILhKvwUJZJQkmZHidfmjWPpb3576LB46o+JIMjZ3D/
 ukwKUSlVPHWcKG0/UqL+RUo1SvC+kXL1pPHYUvP4=
X-Received: by 2002:a05:690e:4007:b0:671:2d01:48e3 with SMTP id
 956f58d0204a3-6715cae4336mr73774d50.29.1789464423154; Tue, 15 Sep 2026
 02:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260806173123.333423-1-richard.henderson@linaro.org>
 <20260806173123.333423-4-richard.henderson@linaro.org>
 <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
 <a930c1b6-dd93-46ad-9e61-eafda9dcaac9@linaro.org>
 <CAFEAcA_-UwXB9svLsFwJRfe37+CkwkRHnNVoWDScTEL=L4uOpw@mail.gmail.com>
 <72dd2ada-3b4d-4563-860a-86bf6c6a8a90@linaro.org>
 <CAFEAcA_7eYjtgXVidEMsG9ztZf1Zy8A4Qip_baSGxdNRQQKj6g@mail.gmail.com>
 <15c1d593-588a-4ab3-b438-a499cb719e7c@linaro.org>
In-Reply-To: <15c1d593-588a-4ab3-b438-a499cb719e7c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 10:26:50 +0100
X-Gm-Features: AcwNN1XhtbqxObq_Uf9i_Om4OQJn4NbS3djSJbfPlZr0wSbqJOOKR7TDFVcFP6U
Message-ID: <CAFEAcA_mFoYgWu4e9d0OpLqudy6Oi+C6vPTG44o8o1AUKSCd5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on
 undefined TID3 registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 19:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/14/26 08:21, Peter Maydell wrote:
> > On Mon, 14 Sept 2026 at 19:12, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 9/14/26 07:51, Peter Maydell wrote:
> >>> On Mon, 14 Sept 2026 at 18:21, Richard Henderson
> >>> <richard.henderson@linaro.org> wrote:
> >>>>
> >>>> On 9/13/26 23:16, Peter Maydell wrote:
> >>>>> On Thu, 6 Aug 2026 at 18:32, Richard Henderson
> >>>>> <richard.henderson@linaro.org> wrote:
> >>>>>>
> >>>>>> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
> >>>>>> within the range which are not explicitly listed.  Previously we chose
> >>>>>> not to honor the TID3 bit.
> >>>>>>
> >>>>>> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
> >>>>>> on these registers, so we might as well honor HCR_EL2.TID3 too.
> >>>>>
> >>>>> I thought we agreed not to change the behaviour here? Is this
> >>>>> just a "forgot to update commit message" thing?
> >>>> Oh, yes.  Because I did update the code to test for v8 in translate.c.
> >>>
> >>> So what does this patch do? Is it just a no-behaviour-change
> >>> refactor so we have a place to add the SCR_EL3.TID3 check
> >>> in the following patch ?
> >> It does what it says on the tin -- it honors HCR_EL2.TID3 for undefined
> >> registers.  We currently only do this via access_tid3 for defined registers.
> >
> > But there aren't any genuinely UNDEFINED encodings in the TID3
> > space, are there? The ID register space has to RES0, not UNDEF,
> > for reserved encodings, and so we have cpreg structs for
> > all the reserved encodings in the ID space.
> Since we don't do this for all arm_cpreg_encoding_in_idspace(), I
> assumed that we didn't do it for all arm_cpreg_encoding_in_tid3() either.
>
> Either that, or we have existing dead code testing
> arm_cpreg_encoding_in_idspace()?

Looking more closely at the Arm ARM (DDI0487M.c section D23.3.1)
I wasn't quite right in vaguely referring to "the ID register
space". The whole Feature ID space covers:
  op0 == 3, op1 == {0,1,3}, CRn == 0, CRm == {0-7}, op2 == {0-7}
The "unallocated encodings RES0 from EL1 and above" and "TID3 traps
apply" space is only a subset of that, where op1 == 0 and CRm == {2-7}.
For the rest of ID space, unallocated encodings UNDEF (or trap
as "sysreg trap" if FEAT_IDST is present), and TID3 traps don't apply.

So we need arm_cpreg_encoding_in_idspace() for the areas
where unallocated encodings UNDEF; we also need it for
the "access from EL0" case, which fails the cpreg .access
check. But we shouldn't need to jump through the same hoops
for TID3 traps, because they should only apply to the smaller
part of the space where we have complete cpreg struct coverage
and the .access trap doesn't forbid EL1-and-up accesses.

I think the upshot of that is that we can just add the
SCR_EL3.TID3 check to where we currently check HCR_EL2.TID3.

thanks
-- PMM

