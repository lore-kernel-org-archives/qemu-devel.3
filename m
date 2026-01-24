Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D558D715EB
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 14:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjecf-0001n1-2q; Sat, 24 Jan 2026 09:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjecc-0001m8-V7
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 09:28:18 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjecb-00014S-BY
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 09:28:18 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64931bbf70cso2729569d50.0
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 06:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769264896; cv=none;
 d=google.com; s=arc-20240605;
 b=gg7gxByEflCEcJeOLt3umRVL1eg//DsliMZ5CxwT3Pjey0AgBXmYtQhLMcy7fXc4sn
 JokTnvHNwj8q22XOIbQszRKr3Q4z6q1czX8hUYzHjnavARYFNC1QMTp6AeOXBvPqgvnV
 nuWf+hw90a/mfe2f7r5efGL2WbfBwBRjvGqBPFg7pYPby2Jlu94/cSHoRvB22SeBVQwQ
 wWGpyGL5/EpzSN/AF82RE4Uh3//CyoP/hzPheeSpC6u4FkKXHC9Ntd3yRPiot35LJEfQ
 AzOmblQk6hkRZLh69EB4GBs5U8vA6oKnN+JkK1P6a3Ohh5YOGIQnWxHzOqgE7wpqknPL
 m1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=peM3wtjXqPtiFGqCKVXz8Hi31hxFxpjgxlpaGNE2yQY=;
 fh=nf5FhO+RmFJAV0QNfK+CKqdkuCXrZWyW41hpO/euKMA=;
 b=YMQavVm5UoiUQLb3F4KU14nwHD3YLw/momKq3PCSVRoyDUCZXlYPHURrtbJBWn/fgb
 eaFLMlKm8hv2FSGOPnoKMD0m6Q4NZygQ4Uy7CkuEwyxbObTtR9o2yOk3MBf/GVYFWqZt
 mZEtdfIKZ9AtVz0/kzQl6WENLdWZlqVv509q5HjyQlf8WW9cRR+5RI7Fv8BuAR67czP2
 xhkR2NKt7BjLjmE5ECw2sz16FNox3cUPV22+3MO2Rp7QGkEd37TLTi0IS7tsK5WQrURV
 mhZtfGp2fupH8uDbWVeRH7Y7ZpjRsNODTjypIl8UzYnPs8+lJwNRO3Y/PjxvHiwJRzAT
 7/XA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769264896; x=1769869696; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=peM3wtjXqPtiFGqCKVXz8Hi31hxFxpjgxlpaGNE2yQY=;
 b=caxzskNp2aj/Ol5mpUYmz21IcvGG5/bRptyncrk1/TavlkiBp9++2eDqpIBn51Hv3e
 W2AGO6aj/UPC7Ylc6TiTOPxQ+HYLrkqHXahKwQPTvExO2reRYcYZ7Dks2J1RQ1hREZDc
 Id6C50hgytyAOZ9nMcFkhzPGUM2SLdbd/iETTJO4qoLUqroN8y0jtIHHt5USHwBcDkdY
 cWwBGN3FFAnFMmMKjl7lMku5bS0YkhR3YKe24Ve2Whzk2T51rMyUe/xmfpqAox+1OYRU
 jFqejApja4Et2SAE0hdulTvW8wrjzp+mJThMH8bc6TzJIl9TStTP7zHgI+v8w21v6fvc
 i9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769264896; x=1769869696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peM3wtjXqPtiFGqCKVXz8Hi31hxFxpjgxlpaGNE2yQY=;
 b=XSij5jRhkhJDRaF/Up8JJAzSYKNHI9eKa8fh4uW6snSRWjx++IcsElEClxYBH7bNJI
 v9cICvKVXi7eZ8OxQeq2Hp85Q7q0CHMCUaU0QjbrcC3APFgGAhlHiibyQhW4x6OvMMZS
 1ngsaja6bMZwiC6O4jTM9CYVTAB94uoFxAmvdBm4cQHoEmJEHy9fr4zq9sgYFOkJK6ew
 BwJLE7ctrvSD2CT6kKUz5HUtc7vU6nMq7uCdPguKtRFz5VDZxhtRJ9c+N6ooqlF0NSsF
 IB5iRKztdptQHqsdUH8v+WVW5IO7/9n7e/mQGxK1Cn2GfflQjkbaGjb35YbKL7/m/9wU
 6GFw==
X-Gm-Message-State: AOJu0Yw3Ng42TRbP0+Ms0Z25KPPQ/eDJ/WW5mVOqd0rVx3JgNrU3x/g0
 xQIC/zijkcbE2+0jsgg+x1/10NvsreDIZNI5UXB3wyhN9YONA8h4wYCkSST8XxcdF+9F1FSDYh5
 Th5e1nwcyflXdk2L0XJUtohQGcX6EmAu/Cp21qyYZgyTHOcD40Oi4S/I=
X-Gm-Gg: AZuq6aKdGrAl1MgT0+oMJCm0TuIOBJmAIHjKI+yu3LPreC+hbXxOQTiXlI/+JOasr0q
 mpRSeBPEV+RBVBMXoqcfIc0RF4pNoFUuqFUOA2l9a0rqRWM3TwPaDjoGsSj4pq9WgTL6CjbEOg4
 SGQz3HCiDpylTTIL/A7b5GLKGevaSRtq55tDeVD3ChCi+R8mSdV9KWiEw1FyIf3kQgqA8l+E32I
 u+YHoZ1Bb+2On2twCikRfmpGtNe12yIyf/JGeD2gkor+xnUHIO9p97Sp3i3p1ZnXUmFpw==
X-Received: by 2002:a05:690c:f81:b0:786:62bb:f6f5 with SMTP id
 00721157ae682-794398c9740mr108331217b3.17.1769264895829; Sat, 24 Jan 2026
 06:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20260124032121.84D2B47CD74@orions-MacBook-Air.local>
In-Reply-To: <20260124032121.84D2B47CD74@orions-MacBook-Air.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Jan 2026 14:28:04 +0000
X-Gm-Features: AZwV_QiKQTAcNRwnuih3DmRhCP7ThcOGsMZMYRrMPTvR92vDnjgOFEPrM9HoT1o
Message-ID: <CAFEAcA9RpYmHB=Fh2H8+Zbe2nWR_GnNpieR9VYTfBWFkUzDrfw@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8139: Fix integer overflow in
 rtl8139_write_buffer
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, orionhubble@163.com
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 24 Jan 2026 at 06:10, orion cai <orion@orions-macbook-air.local> wrote:
>
> From d1781652dc7039b2ac92fa80695091b97dbf1918 Mon Sep 17 00:00:00 2001
> From: orion cai <orion@orions-MacBook-Air.local>
> Date: Sat, 24 Jan 2026 11:19:17 +0800
> Subject: [PATCH] hw/net/rtl8139: Fix integer overflow in rtl8139_write_buffer

Hi; thanks for this bug report and patch.

> Fix integer overflow vulnerability in rtl8139_write_buffer() that could allow
> a malicious guest to bypass DMA bounds checks and write to arbitrary memory
> locations.

For clarity, this is an arbitrary write to guest memory,
not to host (QEMU) memory, since we're doing a pci_dma_write(),
correct ?

That renders it a bit less critical, because if you can
program the RTL8139 then you almost certainly already
have kernel level privilege in the guest and can write
to arbitrary guest memory directly if you want...

> - RxBufAddr is near UINT_MAX (e.g., 0xFFFF0000)

How can this happen? RxBufAddr is the device's
"Current Buffer Address" register, which is supposed to
be a 16-bit read-only register indicating the total
received byte count in the buffer. If it has ever got
larger than the size of the buffer, then I think we have
a bug somewhere else, and the correct fix is to make
sure we are not letting it get set incorrectly (with
perhaps an assertion in case of other bugs).

Do you have a repro case that triggers this bug? The
ideal here is a qtest repro case which gives the set
of memory writes etc needed to trigger it; for an example
of what that looks like see e.g. this bug:
https://gitlab.com/qemu-project/qemu/-/issues/2777
A guest binary that shows the problem would be OK too.

> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 9fd00574d2..41b8407acc 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -745,9 +745,16 @@ static void rtl8139_write_buffer(RTL8139State *s, const void *buf, int size)
>  {
>      PCIDevice *d = PCI_DEVICE(s);
>
> -    if (s->RxBufAddr + size > s->RxBufferSize)
> +    if (size < 0 || s->RxBufAddr > s->RxBufferSize - (uint32_t)size)

Is it possible to get here with a negative size ?
This is supposed to be the packet size, so if we get here
and it is negative something has gone badly wrong in the
caller. I think it would be better to assert that size >= 0
at the top of the function.

>      {
> -        int wrapped = MOD2(s->RxBufAddr + size, s->RxBufferSize);
> +        /* Calculate wrapped position safely without overflow.
> +         * Use modulo on each term to prevent overflow.
> +         * RxBufferSize is always a power of 2, so MOD2 is safe. */
> +        int wrapped = MOD2((uint32_t)s->RxBufAddr, s->RxBufferSize) +
> +                    MOD2((uint32_t)size, s->RxBufferSize);
> +        if (wrapped >= s->RxBufferSize) {
> +            wrapped -= s->RxBufferSize;
> +        }

When does this produce a different result to the existing code,
given that RxBufferSize is a power of 2 ? (For QEMU, we
always use -fwrapv, so we do not need to worry about a
signed integer calculation overflowing, as long as it
still produces the right answer, which I think it does here
if I'm not getting confused.)

>          /* write packet data */
>          if (wrapped && !(s->RxBufferSize < 65536 && rtl8139_RxWrap(s)))
> --

thanks
-- PMM

