Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E85BFF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHfjr-0001uZ-7H; Tue, 28 Apr 2026 06:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfjp-0001qS-7V
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:32:21 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHfjn-0006Of-BX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 06:32:20 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-651b4d09141so14973202d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 03:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777372338; cv=none;
 d=google.com; s=arc-20240605;
 b=GaLuqdGVso2N/I+SKEbpS91Nr+WDhLPFg3RTEEDrXfw3YIifAInsHA9mq2HKlEZV0w
 VpAlP2XwT4Eaq3qTn4tWT73JGkwzhnG3IxDluV09QHKW9IXncfHjE6rA+Ck5QjrrrZMP
 Wr2trLnBy8HSRBfLRQA9JTziDgGdWx8FTfJ5jUhV4/F3H4EopVt6++GL6Ll0QrR9sKEY
 SLWZlk9FObiqcmXfP9bqPxsbU1Fkfx+ld7xgANzxS9LZFB7kRURXB2iyQh7WbRlayBU5
 b/Z6svzprst4l9iegPDDnlsiTNwF7+fAt6C6IdwqTdy5FGW8zuJlehuKpdiwLKokKBg4
 xBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n0ay+AJtPdMJTtj1odWt7MgxiT+JVsqylEVLk6g39h0=;
 fh=jN+Rb3KzCIwJfV2usIbg3H8Elg3Bb3jYDyyQzk86X/4=;
 b=eU6UevAcbbT5sdkKjY7b3by6j28PdfHA4BHd/nWaY+1h5VEfGVsa6jCuPwSIH0SfSr
 GHqMQQ4FD2VWW4+FrKBcdB0HulaaxDU2ufBVmN+P6hlfyZaxU0UHxNMcV0VO7vbVgU+g
 DEWJOeKTVbcFX/GDMun0kAI33C+X8RMaRlJuswwvQuHJU9/LsHOyVeJ2n2433bslKl9D
 3DdunoHAv4/AFlcMeaeyILsZzU/w6MFG9xyxWkNJkUnC5e+yMd7/R/xEJdn/7zyGz/Rf
 XbLGR3Ocp+RnW0URNcqfX1soytguAI7M1dBWNSZ1yQoz6fZHXx6C2632fO83/EKHhx5M
 jJYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777372338; x=1777977138; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n0ay+AJtPdMJTtj1odWt7MgxiT+JVsqylEVLk6g39h0=;
 b=bIeByd+g9I0hNRgMvmToNlquvtSffDjlsZuTIIvciKQVm8BRe15OWrkGCIR15TMJNA
 t1EP2DwRfIx8R0Q8yWV5+UrBN2Zt9FfQBuMCALr42YveU/NXLtkmT9jlzgo+6KJ2Tnun
 Z7uiZJjJ5LyE6e2Tkxd6mw0I4hnP7b08NO7aPjRnoir3pCLL7qGBz+bItGif9dXUYIrn
 gBI5JgO94bsLZBwixPvfSNEM2/3mnXUfr/fSp5kkovGsQw9C9ox9pfJ4GAI9xDe4jX5F
 s+y968xpB5zsYhPPPSBS30xCmwID3MQSP/HniByROUZSNvKcD5ydLr570P6+kaCyskUE
 jXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777372338; x=1777977138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0ay+AJtPdMJTtj1odWt7MgxiT+JVsqylEVLk6g39h0=;
 b=DJ+1r/YP4IwDTg07ahHdQLCaa/FpWsmOWIRGlk6u00OZKaDxfIeqr5i3a4zUgN4nkV
 5rjjDCmsVq7FgLqFZZUlk7D64r9rD8vMSopGqoDpJsMQ+besEUS5kl0oQgLm9vbBhupu
 QcWcYzytIq37KrA1FEt8mYdD6Qzs03xiBUEwAhZgqCOhUioJmbsoZxbNu9P/IuGsK+OR
 41ZP7BC/sFMs68XaNB0qTNShjsKV09Oks1YaGF6MVeo1cwddXFKO6gnQw11tAOf/uBKI
 C43pYfixE2ScQLwV9wulsw7Mw41pyFGYOhUF4XR3yyuhNBUApZt2pR3NkyhrQbQ0Eirt
 3ESg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9p2qISqMjQ6Dl17v/9B/CA83D7IA1Sfea4WqcHpo5VTmeQtOlwXqNiXboh51k0omLkQl5eCQY90Mzz@nongnu.org
X-Gm-Message-State: AOJu0YyFpGYhiGFOCGVmUZfTTW2rqr2CPAz5K98LRJGfbEtab893wAYp
 +gnpZGu14PmPTBQjnO5AyeFHCyK1oenMu9LBhoQ3bpuWaHZEx7YLMD0rtHsk+0D72GYhmr9BsGy
 VJC66Bcu6gZfZMjsaBRzjJw25dutMKdN14cwn7mbzMQ==
X-Gm-Gg: AeBDiet/ELCfdfMPrCrrbAduN5KNa77H3x0d0EIQYZ0+y+3bk9l26IkEHjdHCHev6Fu
 TXYBGtxMPTD9xmV0XCgRA32Nx2MCHfqFbs/pFxTcOJ9Zt3EBA6EnnnQve1dsvzBzmjvBYtj2LA1
 NrNqNWYozXQq+Hdz5HHqkEJafyBYBYz58QjvE0tm/u4iT7bbV3AvmR2AVDkhLOVCeF79rqxVg/Z
 yAc7Na2L7+/erht3DwFyZNtmj7z7kUAyH+Ml0+cBI4n43WHw9oF2LW0OQIygjvhDLZXvAoM3vkF
 dry9aNnEX8nerJ7RQfMKURFIthZ7zuR+sP5tgfbkAek5lJbeHQgX1fvUTGkj9kCYjTIUFPe+5Sx
 4xnyaX+7fmUDF
X-Received: by 2002:a05:690e:e8c:b0:64a:ce57:cac4 with SMTP id
 956f58d0204a3-65bee7f6ab0mr1691095d50.24.1777372337833; Tue, 28 Apr 2026
 03:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-18-peter.maydell@linaro.org>
 <aa013ba2-31ef-46d3-a97e-b272d43a8824@linaro.org>
In-Reply-To: <aa013ba2-31ef-46d3-a97e-b272d43a8824@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Apr 2026 11:32:05 +0100
X-Gm-Features: AVHnY4LqTKLHN9EN8IXQy5tlHTDdstv6ic0xLZczzDHVtwWMAPijt9Ctkq2y1rg
Message-ID: <CAFEAcA9ACvYY-YbjDtZq0EKk7G1QkNV0+0DF+1-BO25W=8LXHQ@mail.gmail.com>
Subject: Re: [PATCH 17/17] system/physmem: Use translate_for_debug() in
 cpu_memory_rw_debug()
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 23 Apr 2026 at 04:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/18/26 03:31, Peter Maydell wrote:
> > Currently cpu_memory_rw_debug() assumes page-granularity for translations,
> > and it works in a loop where each iteration translates for the vaddr
> > rounded down to a page boundary and then copies up to the end of the
> > page boundary.
> >
> > Rewrite it to use the new cpu_translate_for_debug(): we no longer want
> > to round down the input address, and the boundary we copy up to is now
> > determined by the lg_page_size it returns rather than being assumed
> > to be page-sized.
> >
> > This, together with the implementation of translate_for_debug for
> > Arm targets, fixes the bug where semihosting would incorrectly
> > fail to access parameter blocks that were in memory where the
> > start of the 4K region they were in was inaccessible due to MPU
> > region settings, even if the parameter block itself was readable.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3292
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   system/physmem.c | 38 ++++++++++++++++++++++++--------------
> >   1 file changed, 24 insertions(+), 14 deletions(-)
> >
> > diff --git a/system/physmem.c b/system/physmem.c
> > index f2d9a4ff8f..45c3a926cf 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -4036,28 +4036,38 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
> >   int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
> >                           void *ptr, size_t len, bool is_write)
> >   {
> > -    hwaddr phys_addr;
> > -    vaddr l, page;
> >       uint8_t *buf = ptr;
> >
> >       cpu_synchronize_state(cpu);
> >       while (len > 0) {
> >           int asidx;
> > -        MemTxAttrs attrs;
> > +        TranslateForDebugResult tres;
> >           MemTxResult res;
> > +        hwaddr blk_base, blk_size, l;
> >
> > -        page = addr & TARGET_PAGE_MASK;
> > -        phys_addr = cpu_get_phys_addr_attrs_debug(cpu, page, &attrs);
> > -        asidx = cpu_asidx_from_attrs(cpu, attrs);
> > -        /* if no physical page mapped, return an error */
> > -        if (phys_addr == -1)
> > +        if (!cpu_translate_for_debug(cpu, addr, &tres)) {
> > +            /* Return error if no physical page mapped */
> >               return -1;
> > -        l = (page + TARGET_PAGE_SIZE) - addr;
> > -        if (l > len)
> > -            l = len;
> > -        phys_addr += (addr & ~TARGET_PAGE_MASK);
> > -        res = address_space_rw(cpu->cpu_ases[asidx].as, phys_addr, attrs, buf,
> > -                               l, is_write);
> > +        }
> > +        asidx = cpu_asidx_from_attrs(cpu, tres.attrs);
> > +        /*
> > +         * Clamp the amount we read to not go beyond a page even if
> > +         * the CPU returned a larger lg_page_size, in case this access
> > +         * is to a memory-mapped IO region.
> > +         */
> > +        tres.lg_page_size = MIN(tres.lg_page_size, TARGET_PAGE_BITS);
> > +        /*
> > +         * Find the length in bytes from tres.physaddr to the end of the
> > +         * block whose size is 1 << tres.lg_page_size; we will access
> > +         * that much in one go.
> > +         */
> > +        blk_size = 1ULL << tres.lg_page_size;
> > +        blk_base = ROUND_DOWN(tres.physaddr, blk_size);
> > +        l = blk_base + blk_size - tres.physaddr;
> > +        l = MIN(l, len);
> > +
> > +        res = address_space_rw(cpu->cpu_ases[asidx].as, tres.physaddr,
> > +                               tres.attrs, buf, l, is_write);
>
> Doesn't address_space_rw handle both MMIO and RAM?

Yes, but it doesn't handle accesses that cross boundaries
between MemoryRegions. (flatview_read() and flatview_write()
look up the MemoryRegion once for the first address and then
use that for all the data transfer.)

-- PMM

