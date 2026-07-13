Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1973DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjI7g-0005AF-6H; Mon, 13 Jul 2026 10:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjI7e-00059r-Io
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:59:06 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjI7d-0004it-3c
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 10:59:06 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6647bc8f900so5347221d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783954744; cv=none;
 d=google.com; s=arc-20260327;
 b=e0z+M3MZcJj17LJA8UfJfQZlklI22FlBaO19RKxmNmSB5DzXQ8HcAxYhpHJP7h7dTI
 H7rgpMDuD2WtXaghi9Ekerq1gToqf/+w8s+iZjJGrP/PeRYDrEpLXe4mMCgfy5l4RIgt
 EcNE6mL4sHg432u2IF3X6cF0q9GWWYZqOxV+e96abxv35UnD0wxsjLv0Lobl4fJKM2UA
 bnqAU+ZHJaJ0bIZ4G/s7oqHxt3GtCANSV7N83UBUabtB/AqFrFGJpPuoDUuRS2oGmxVu
 otkO/emshAFPmxixwSm/w14sK1/F9Qtqn3VBaPzm/cn24ss8Myddamwe2Z09DPB/20qN
 HHaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c5BYm9w4yqyN/YvHb+KsJEZ8MQzP936ynUUDjI51L6k=;
 fh=9jvu9sb98tMkv3eZc8YkNKxrKg31/dCzrqGIUZZi0dw=;
 b=pJ0S78pfbRqi2LE62IHFbJBb5I/pLYg/OqpK4T7cLP31ita60xZaFY5ywMcX+PBJbw
 YodtKwPGcc0DR9RwV72/e90qcMUhxX2lrRLM16ENBjWVh1R6CweCuhEPiwf1ZjGgqBnP
 pJsN3hSJR1NVsvaiYFCV+cVL01GTmKYrBGRsd6R7BQjU9pEEOEXgff6EaYuvyKzUAgaO
 +mZK4NRlYpTA+Rpf3boeR02kA6jWcSlpEavqSnbodtE0NHqdblMi8C6KYNjqvrMBto/v
 1/vkL8D2DuBS+8EpNxSKqRP6DvWDxln7dgfBVvStemtvhT1BmiJZh+wBoIBpZGjIoT0A
 sDcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783954744; x=1784559544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c5BYm9w4yqyN/YvHb+KsJEZ8MQzP936ynUUDjI51L6k=;
 b=FuuADT9GrPLNBxlmS7JJ6OGz6uCqLyzZCAa+tnaeKgtxEcnzhJZmRD4S5rTh+hQZL/
 Y5WEq4aRkhlBEA6u6BUibQk61sc4li2QUUtvwER4Ysnlhxw7YYu42NtIvs6zvX5tjwUK
 zuJEuixFjCW4KZDW9BCunG0yKyXwjJoi+NPJmDH/k0rVNTG2IS+EI/kD7tZN97Gf7Q8t
 ZWxPpM+Z/Jl77Fg8kG/TxXmSHemZxhc2KHFy0YKY67dH7HTvI7Yum+BCUrjkDTmlvI+p
 KYBCGzL4AvvWYReTspesNelcAelO3TvwUdK9ugbUsXjEUZTs9N2mcnANpxqxuXsnoJBM
 rJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783954744; x=1784559544;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c5BYm9w4yqyN/YvHb+KsJEZ8MQzP936ynUUDjI51L6k=;
 b=RqApFKzy7Ch4qcVuI2s45bABgwfo1cPCyrfQcOispOrwmWHj1AIDZcO42quWrAkhwk
 uzujHBz+343c++sS0X9JH2qwBTbPFORucqsCCp6E9PZliaM08h47ckApauDkK9OzB2To
 dsOXBZAd3jI5B6Gs7Kr/s4O4YoyX07l5nouS6db/2D3TkBg8dmxgING5v0LUbcGO3Fex
 PaH4/TU1hFRya2Np5J7lQOed2eR4YBnBvsCzkamXe1sBFUpkn6VhUjtfxC8I0VrLgcKW
 9Hsg/atDFafdQdInxZcaGhhCS1p5NRtwBR6RQDIhFfGYnvakm1zIuP8DXPQqs7nUQUGP
 E6zg==
X-Forwarded-Encrypted: i=1;
 AHgh+RovVoat3lGVXfrnASI5QRpxo4/X5LvLPD4je9u9qcCzf988SNmGi0s6UYKFmjc2ZGKIQaYeCzdzptRq@nongnu.org
X-Gm-Message-State: AOJu0YwA0oPdgfggitd2ccqlElqHR0fSb6/rlZnfULy02H8FBBxCtwzP
 Fca9zc5f+F//oGluD52LeDlz6rpPNw164j8MUBrh+bOAb75bHAjlYfGh3F1T58M4LRkQ3+SM8Q0
 IbDnIU7fRGL/3ITQGzomydLdEAtP5INr3eZEUSRWs7A==
X-Gm-Gg: AfdE7ck5NRkqlYKVNE9JhGPElvg5pv3+WomF0euG4fJuO7xv9swINN5ySY5voQhDVNe
 BNp018KgxzpIvGUQsWrlfiJpi3zKzaLV92TwXgk2quGiu8cAhGQoASxkdthDJ6GZQncMZzbWVLw
 ixmnaKYrfePL2rRx+UJBlT4ZIpNRn/VbjA0a6oxhs11PcaAGJBTDb8uDaOS2+1Mqt4YjbQHmvzF
 Ti09Jq4dKoH7Skh9cADCCpXDlR64Tb+W+9O1ftRtL2e/BKIHoYDYZB7qpjp9Op2XtIbMt24rLH1
 Y3ubMloidVIibTCq78CRSpAOMXH0jD3UXcZUgDxY1z3GcgGhX/BbhH1D
X-Received: by 2002:a53:d018:0:b0:664:aeda:bfd9 with SMTP id
 956f58d0204a3-667d7afc08emr6245685d50.7.1783954743629; Mon, 13 Jul 2026
 07:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-8-philmd@linaro.org>
 <aah7i1iaoRb9yh7X@x1.local>
 <ec368507-fe6c-4d6c-ac37-d13b9cb7f46e@oss.qualcomm.com>
In-Reply-To: <ec368507-fe6c-4d6c-ac37-d13b9cb7f46e@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 15:58:52 +0100
X-Gm-Features: AVVi8Ccl0ZmN6-xx8sg091n9EdSPRhGPb80NP9ylQ7dclT8Je-9-7RAj30DD5IQ
Message-ID: <CAFEAcA-JW3vAmUWObx+WLhKdMbXdjq7+oNKzTUSCvoQww4sZuA@mail.gmail.com>
Subject: Re: [PATCH 7/7] system/memory: Have 'info mtree' display addresses
 nicely
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Mon, 13 Jul 2026 at 15:27, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 4/3/26 19:35, Peter Xu wrote:
> > On Thu, Feb 26, 2026 at 11:02:25PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >>   #define MR_SIZE(size) (int128_nz(size) ? (hwaddr)int128_get64( \
> >>                              int128_sub((size), int128_one())) : 0)
> >> -#define MR_ADDR_WIDTH   16
> >> +
> >> +static unsigned mr_addr_fmt_width(const MemoryRegion *mr)
> >> +{
> >> +    const unsigned int bits =3D 127 - clz128(mr->size);
> >> +    unsigned int width;
> >> +
> >> +    if (bits <=3D 8) {
> >> +        width =3D 2;
> >> +    } else if (bits <=3D 16) {
> >> +        width =3D 4;
> >> +    } else if (bits <=3D 32) {
> >> +        width =3D 8;
> >> +    } else if (bits <=3D 64) {
> >> +        width =3D 16;
> >> +    } else {
> >> +        width =3D 20;
> >
> > Is there any case this can happen?  I thought we don't have MR larger t=
han
> > 1<<64.  Not a huge deal, though.
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
>
> There are few uses of 0x1.0000.0000.0000.0000:

Yes; that's the largest possible MR size: exactly 2^64. Inside
MemoryRegion we keep the size in an Int128; in some APIs
(e.g. the ones for creating an MR, and the return value
of memory_region_size()) we represent a size as a uint64_t,
with UINT64_MAX being a special case meaning "actually 2^64".
So here the largest possible value of 'bits' is 64: anything
else would mean some bug elsewhere in QEMU resulting in an
invalid mr->size somehow, I think.

-- PMM

