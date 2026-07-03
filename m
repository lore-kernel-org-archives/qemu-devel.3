Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3453C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfe3G-0004mL-Sb; Fri, 03 Jul 2026 09:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfe3F-0004m2-GB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:35:29 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfe3D-0001V1-Pz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:35:29 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6662551100bso777626d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783085726; cv=none;
 d=google.com; s=arc-20260327;
 b=eltD9RfhL46+y31DoR0pajD3jQHVthbED+j/D7YQc0YvGH/CYOe1AIkI5WXDU8HFV7
 Dq87l8AN8TkyayegWLIMOohyRTZhoH3Qhyv6ZPwL+nIv7WxayplnpCZdKJtE61Ub57pv
 QsAG/gHL+e3QH3BTmlRFb3GckXjdg0iEosSddOueDK0Rn3w6eG6QB0BW6m3s3WCIhLM5
 VAu+q92Dkqi3EfteqeLEtavY6gRbV7N3KUcqHkpnTLSIG4E/F16s3kkZzg6VvIWxdILc
 fZVPhHUEBjfD5LuEooisSBTJMBLKnWpWqYS4sb/Qyo1tBX6xC7/NlTC4tisuZ38tnkG2
 8BoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2ZnG7QzwcOliIhXKPsIJ2MYdHzHVFB/ZwZoqJYHTYrM=;
 fh=VBrmjQo+3JMrF2hCjPLys6sRPC3o2Zr9rll2YMuINOg=;
 b=WnZaL9Q82Z/+ndV6ItrVDxiLKj3wE1obHr+XFWn1rLRshURSLzXBWH4VldVVvG6O3J
 dycdtogPE8Sfk6T7aU2/TjWVo6UuWOMwOMR23mxnhRfUBFSzAab7kjSlhcCAG1OIBqLW
 MwKBICv56rcsxWNVZLa5lY2f861QIaYSacTWRSJqHUAlweRlR3J6vDUHxIoqIc21N8Tj
 NeWVYvW/weDnzDj6j8NLrThjSnSisJQKp93HN6APDR04BGmWdDfnSvIpyStsoyzmX8xu
 reLeMBTHmMak3uLVv4X12HKah66qL+s/9cbEqDOU3jFCavVHsMtJZCH43BicubjNFx1K
 04jA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783085726; x=1783690526; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZnG7QzwcOliIhXKPsIJ2MYdHzHVFB/ZwZoqJYHTYrM=;
 b=cJbLaaKWqD3bGuSnN56gvXwdo6mpjFcRYjxdwA5vuiPfr4zHQZx3i9JuJDYwnnV3WK
 3uATdg8yhc6cTL8t9rpQtjQ656cKrBNTFWwfDLUPrumGR1iC3j8r97YeCk20v11KTJHv
 klspsI88HFJpLgoXoORjISVi0jx1bA000uZX+cXI2o3t86X9/fY5K7OtakWUA4diZ4Xc
 Fd2E7gPZOSZ+1foPe8p9FdulJ1+XQg1anH21uU+22Mp4qIYbASlw3q/jkZ2g8DSajyFZ
 3h+pZvopRuWNSSMavXBYLUrpVLLdjjPXbS0GSCucM6durboaHbSNYGhgywDR2AqXmkfm
 DEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783085726; x=1783690526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZnG7QzwcOliIhXKPsIJ2MYdHzHVFB/ZwZoqJYHTYrM=;
 b=FCXR/alzd5AosjqbceJIxG1GvlzlwGfnZRhhh48UOC28na3kuPMX+fue0pJyL3MW5J
 wTC3RexLi1Sr9p1/aDNE1p6PYlRPW+oigd/+Wg7xTasIF1W0WbhdoQCgvA6sLVvlCmnX
 qlxhh9Y4Yx0AdwMdcpWPPjDVLRTD50dd/d2ktsS86tUhe9nKo8az4qtwxDq4joFF+tgR
 /cMdoEcFjrG59Rmw+xt106cVErZ0WhxFH1JXrQa2xkwRe/uGBEunRNqus9FocGvOlb+F
 2XBTjiSiUSKh5s/YDCbQVN1hk0gEA9W6IO5zcOTgAi3YQc8v6lo6mjdjBIO/GJ1ERizd
 xX7g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBT2mqfnHXklABk/KT+cEDaDj5xEvKmwPcnbxqy8fhEuxaLw+AOhwdt4Gu1jv1pp19Tl62/Ykd/+k/@nongnu.org
X-Gm-Message-State: AOJu0Yw24CpoQk/ePzhvG5pPGAXyv0iW2F3rhJUkdFwg8UeGlYo3KYrE
 GZ23jfo++5tYYGoLzZ6jVoOm0i/9+S3XgQlBpjTmIpUd7yTozJ8F+dnvoje78rMsa+5Il32eH8j
 Xzq3OBmHQqMfOUkX4/8MCEDtyKhsb+knKwMMRUUqXVQ==
X-Gm-Gg: AfdE7ck3li6ArUmG3cqIcmcs3HKYyg7T7SfdB4vHxTVZDr6ZrpcHWSeIV1ZlKQcbntY
 J7D2g7jKh5rmbRKj3vbgMwBl64zAgtkCLCQlIykD62NSjLNP4DJjEzIN+Ra1zvghQPS3qXrZB5Y
 8IIuHjHRmrziNxpc00E5ZGzOCIIryxx33eMYKeMjgxVHF2bs/qqN32ztu9DcG86s30Lxgph+s+I
 zP+1x6MOHcgnUDQawNDbV1HiZLijfj9zg4Fd01Q9Asa/L3QQ375RleJ24QhN444oznnQ0Kk8BWa
 A8mU/fCOyzJnyVBSqncS7ubGoNcqjQsWAvASdJ0Xv4hwXzpBSHUGW/AA
X-Received: by 2002:a05:690e:4503:10b0:664:ae68:ca0e with SMTP id
 956f58d0204a3-66521d1aa8amr7421060d50.84.1783085726219; Fri, 03 Jul 2026
 06:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-12-peter.maydell@linaro.org>
 <d0222d0f-ee90-4d4a-bc60-71740a858543@linaro.org>
In-Reply-To: <d0222d0f-ee90-4d4a-bc60-71740a858543@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 14:35:14 +0100
X-Gm-Features: AVVi8CdsTVA3m8eLOvENZMSqYyL3dvVpLl1r66klaFBXvX8hOthURpD7Xtp2zIU
Message-ID: <CAFEAcA9_6Uf4WXc5qoqj63eBrf8sE=C7cMTpgTJDqqpVjHex1A@mail.gmail.com>
Subject: Re: [PATCH 11/11] target/arm: Implement CPACR.D32DIS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Fri, 3 Jul 2026 at 00:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/2/26 11:40, Peter Maydell wrote:
> > On some v7A CPUs, CPACR.D32DIS is a bit allowing the guest to make
> > VFP instructions that touch registers D16..D31 UNDEF.  Whether the
> > CPU implements this or not is IMPDEF, and the only two CPUs we
> > implement which have this are the Cortex-A7 and Cortex-A9.  In v8A
> > the bit is no longer defined at all.
> >
> > Since the only kind of trapping that needs to be done is a simple
> > UNDEF, this is straightforward enough to implement.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1499
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/cpu.h               |  4 ++++
> >   target/arm/helper.c            | 19 ++++++++++++++++---
> >   target/arm/tcg/cpu32-system.c  |  2 ++
> >   target/arm/tcg/hflags.c        | 20 ++++++++++++++++++++
> >   target/arm/tcg/translate-vfp.c |  4 ++--
> >   target/arm/tcg/translate.c     |  1 +
> >   target/arm/tcg/translate.h     |  1 +
> >   7 files changed, 46 insertions(+), 5 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> > @@ -210,12 +210,12 @@ static void gen_update_fp_context(DisasContext *s)
> >   /*
> >    * Return true if a VFP insn is OK to access D16..D31, false if
> >    * it should UNDEF. This checks whether the D16-D31 regs are
> > - * implemented by the CPU. Eventually we will also check CPACR.D32DIS.
> > + * implemented by the CPU, and whether CPACR.D32DIS permits access.
> >    * Note that Neon insns accessing D16..D31 do not need to check D32DIS.
> >    */
> >   static bool vfp_d16_d31_ok(DisasContext *s)
> >   {
> > -    return dc_isar_feature(aa32_simd_r32, s);
> > +    return dc_isar_feature(aa32_simd_r32, s) && !s->d32dis;
> >   }
>
> Not that it matters much, but if we stored
>
>    s->invalid_dreg_mask = (d16_d31_ok ? 0 : 0x10);
>
> and pass in the mask of regs like so:
>
> static bool vfp_dregs_ok(DisasContext *s, int mask)
> {
>      return !(mask & s->invalid_dreg_mask);
> }
>
> -    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
> +    if (!vfp_dregs_ok(s, vd | vm)) {
>
> then we eliminate a couple of branches and some boilerplate.

Mmm. We'd need to have separate masks for vfp and neon, though,
otherwise somebody is going to be tempted to change all the
uses in translate-neon.c to use this function.

-- PMM

