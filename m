Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08115C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfe9f-0006yM-6r; Fri, 03 Jul 2026 09:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfe9Y-0006y5-3K
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:42:00 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfe9W-0003UT-4T
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 09:41:59 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664db84f074so671423d50.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 06:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783086117; cv=none;
 d=google.com; s=arc-20260327;
 b=PQ1yazp1y77fDTL1ZvY8l2AwgryClhhU4enL74vfJ0c4Cd/hVqVobVAqQyD2jYhD0g
 LUEghHasCpCghH0N0D4q3cvp7+ZgrYxr0l6UoayKJM1zaA3VjOazBQ+c0dNuF1uLpvKW
 mZzCRhHGzoyBxquEVVOyQZzwnX2yFyPrmZg+s+MtNDBKC6MxtxcICQx2eEB+3q7KR9eM
 qlwBL8d4IcH7TCBXgOdWjguZsbNVpgNkX2pfll0YPwIdj3WxfOw/DcCUUHr12c4K/i1U
 u6jO3bxriFREjGGgzeZvJZpx5j1OygOe1apapcuc/VLYBOonXFYOpCDcNWTyZFY51MhA
 P6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MKvtIzcJ7QiwmYwb4AyUMgrw/hcZWOoeOSRmEyF375Y=;
 fh=DjAjrE5NJvYezeKxuUfizlcTg/Eru0iW1T6ZART3fRg=;
 b=c9Baf5z+RMpeDuxRYWwMTgnd+TDDM/Dv795QWI4XNe8gdThOb0Cap7nwbtItwfO5Mn
 ZX6qfpCjNUKC15E6Bi23p1c6RHowPndySJBn7DKAQopMkEYE3y95oqAZuH73MFbdX5SD
 Co9a/RMSkHFxLe8DRR55iYVpU9tfMnFQ+m4O9veJZAMr0+UPGFa00e1lAxwlzAHIIF3i
 QN0xDNWiym5Pyi79uL1Sza+lxXustAVgD3pBzJ9fpIppnwiVqd3B3fReGddigMh/Ge1k
 9N38+/MoN3bLM44bWG4bat4wxpJFFxaq6eJTABbBv8wefdvAnJFoyYQ+1BrhRolZWY0f
 U14w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783086117; x=1783690917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKvtIzcJ7QiwmYwb4AyUMgrw/hcZWOoeOSRmEyF375Y=;
 b=bz7G7hnQmGc5n5Q8XcIEsU07qfYPDM8kakrtWN6dWT2p/tjg6n1SpRcm6bMNBMEFlY
 6qr66FwWKo5x+97Kps7XLITOkOpqff+w+7As6HL4ny1qHb2vsh8yI/t/i26+av63Bemy
 xypFTJw0tV0bw9xVaxmbkd3MMqdjj0fViVq399pUMpQsPXUnknc3s98G4KmA2ab9WzKg
 zhiKW39E0EQRWX23qRZT73VCEfBwfWwAP+xFdpSmQkI6XiNsNBRGD4nmlmO/hxWlDqt2
 EhEV56oqX2n6bJW755pdxrGP0avGxilB7EvmFPP8WnWrlO1x7Ygl2TWcOTK1qsddgRmf
 edXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783086117; x=1783690917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MKvtIzcJ7QiwmYwb4AyUMgrw/hcZWOoeOSRmEyF375Y=;
 b=qOAvexh4U3PlaPwaJUsklTJV1BEbLGn8s7UV4v/CVfdt6cUuUS9ix13F8OzIghDh9a
 ylyOHE2HjleCIKHLlbSl8A3DeGzcMMA3704GRiavOgHgHmUduk8ufNq08JiqL85qleoR
 gN6gws+0C/c9jU/emwTRGpYDjskcZV39gIkj273lLMS3JvhQvnP4oLEGMxDpcCFRHkid
 q8SXr2G4P87BTxXeWCTUXbkzbQZ0DpNB61e5LrtxgGCX1UWzZxUad5yYjy0usx2MEz1X
 164Tz2QzlD1wZ7uSeWVTxaaWs+CWAKwCRmqh+KVa7KV40HTQREVdXt3tsLbFWiEG0MsJ
 2BQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIjt/0o4cMr35+GzG1xS1pVf47FRuPH+cVGV3ST6q0aXDiVSL66syOaxVAmksbiuTmE/vsGg9doLUs@nongnu.org
X-Gm-Message-State: AOJu0Yz20hTMzb+/1YF6y8OlLfOu5M4+ETbv4kvzhtlLoXnjHnhBAZS0
 QfccSpumSuqEf50L9+HmAAaXSBGO1tpXx59CEmh6SqQ3Fh/nuOkFb9EZ4Zxjl05+i+c/94LPAkk
 xOQ/Io6QnUQ0DQ0t0bsy/FIEeSwMnGegS39FP33L41Q==
X-Gm-Gg: AfdE7cmGxKu9TY4uQa5gxUfEaubeX8Y40WlDGpH4TAzagC2LjnjrkKkClNcUEDgEaIM
 fZ68v8wMKawoQbVgg2OKtMlX8BoDN1xZvYf13RtM/SJYpTIQyBtVBQlt3CFtb2m4MDI5WgwsWcX
 9bv6V1DbsoGvH6xq8bKlPPiZQCPEMB1PNuakMbPEY17n7aCAtAm+YixWRrKFD8PuSQvJlEMOghz
 zOYn2y68rh+QfXlr5x8fCKoBpuGLchqdyVJW6X2LYaI+QsEWekFGuYzS+42ir34bSFr6yM8g4dE
 UcEaFo9RAk0r+NIApAzqC+yRDCQDaqTWSp4kuW0Cj85DBrl7dnUimJql
X-Received: by 2002:a05:690e:d50:b0:664:b3c0:6546 with SMTP id
 956f58d0204a3-66521d485b4mr9080394d50.57.1783086116633; Fri, 03 Jul 2026
 06:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260512062142.67998-1-philmd@linaro.org>
 <20260512062142.67998-41-philmd@linaro.org>
 <CAFEAcA88TQhP6HFOhrAMjRMXU3UPYcw_EGp-Fj5GfA6L_WdjFA@mail.gmail.com>
 <3f5fc513-1dab-078b-7f05-70f6fe2dedcd@eik.bme.hu>
In-Reply-To: <3f5fc513-1dab-078b-7f05-70f6fe2dedcd@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 14:41:44 +0100
X-Gm-Features: AVVi8CesxqFy4TWN5Isidye1YQ79FPNUfFNSn-KRx1y3BlBZphpgc2v37QLx0Y8
Message-ID: <CAFEAcA8mL5QWNY8HfhMkVUu80J8OQRnfYhfGZzyTnrXFZoK-fg@mail.gmail.com>
Subject: Re: [PULL 40/41] ati-vga: fix ati_set_dirty address calculation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 3 Jul 2026 at 14:37, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 3 Jul 2026, Peter Maydell wrote:
> > On Tue, 12 May 2026 at 07:30, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> From: Chad Jablonski <chad@jablonski.xyz>
> >>
> >> This fixes three bugs with the ati_set_dirty address calculation.
> >>
> >> First, vbe_start_addr is a word offset. All other values in the
> >> calculation are byte offsets. It must be converted to bytes.
> >>
> >> Second, when setting the dirty region with memory_region_set_dirty
> >> the vbe_start_addr is used to calculate the start of the dirty region.
> >> This is a problem because the vbe_start_addr is the offset at which sc=
an out
> >> begins. This puts it in the visible screen coordinate system. The dirt=
y
> >> region however is in the virtual screen coordinate system. This can ca=
use both
> >> overmarking and missed updates. This is removed from the calculation.
> >>
> >> Third, when the start address of a blit is outside of the bounds check
> >> the entire blit is missed and not set to dirty. This happens even if t=
he
> >> blit does partially overlap with the visible screen. The fix here is t=
o
> >> find the intersection of the visible screen and the blit and mark only
> >> that region as dirty.
> >>
> >> This does not attempt to apply clipping to the blit. So there will be
> >> overmarking in some cases.
> >>
> >> Signed-off-by: Chad Jablonski <chad@jablonski.xyz>
> >> [balaton: drop excess parenthesis, use offsets instead of pointers]
> >> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> Message-ID: <20260506153920.C6B27596978@zero.eik.bme.hu>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> > Hi; Coverity warns here about some "we did a 32 x 32 multiply
> > and put the result into a 64 bit calculation" issue here (CID 1660048):
>
> I've got the warnings but didn't have time to look at it yet.
>
> >> ---
> >>  hw/display/ati_2d.c | 24 +++++++++++++++++-------
> >>  1 file changed, 17 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> >> index 504d1c57085..48498677c7e 100644
> >> --- a/hw/display/ati_2d.c
> >> +++ b/hw/display/ati_2d.c
> >> @@ -69,18 +69,28 @@ typedef struct {
> >>  static void ati_set_dirty(VGACommonState *vga, const ATI2DCtx *ctx)
> >>  {
> >>      DisplaySurface *ds =3D qemu_console_surface(vga->con);
> >> +    unsigned int bypp =3D ctx->bpp / 8;
> >> +    hwaddr dirty_start =3D ctx->dst_offset + ctx->dst.x * bypp +
> >> +                         ctx->dst.y * ctx->dst_stride;
> >
> > dst.y is uint16_t and dst_stride is int, so we do the multiply
> > at 32-bits, and then the whole set of additions at 32-bits before
> > putting it into a 64-bit hwaddr.
> >
> > Should we cast one of them to 64-bits to avoid the overflow,
> > or do we know here that these values can't actually be large
> > enough to overflow ?
>
> I think since the x,y values are limited (at about 16384 or so, we usuall=
y
> apply mask when writing the regs) these should never overflow but we coul=
d
> try to cast something to silence the warnings. I can try to make a patch
> eventually unless someone else does it faster.

Ah, yeah, I see now that dst_stride comes from dst_pitch and that
gets clamped to 0x3fff on writes. So I'm happy to mark this one
as a false positive. You don't need to send a patch unless you think
it makes the code clearer for a human reader.

Since all that we're doing here is calculating guest addresses
that we pass to memory_region_set_dirty(), the guest can't get
us to do anything particularly bad even in the worst case.

-- PMM

