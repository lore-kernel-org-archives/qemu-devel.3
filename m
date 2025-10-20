Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0182CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAsJh-0002wT-VB; Mon, 20 Oct 2025 12:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAsJS-0002t4-Se
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:00:56 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAsJP-0007Bd-9H
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:00:46 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78487b0960bso20686347b3.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760976041; x=1761580841; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gE0aTv0AybxpyvUrkw48kENR4BDFz7WGor4ksSfbP88=;
 b=DWfKJ1SLlyDZY9mMLBDPMqLLjAGIaOlY3Cd3vk6bSN1dln/WXgm3Z9Q7G/ya9XtnrJ
 v7NKm5ry7aLk9FoEWr/z0Hz0tFicJOwwEm40/ESylChE3ub1mMvqVshA4XZ1031ywCl2
 ZTactjSJi+Mf69Nf+25AhTjz9UUIJQm4s+J0EbbVaiZI6qqD4HT+6JoB/qTwAl1Wx2nP
 +/a670kYjE0B1W3/fjYAFeny0Z0Le5DFD3pxAyEppUYeRLySzLgA3JxDyDdA5OP/UJAJ
 tw4KF77yPVg/lZhTrB1IZIC7bZT2TkxB3SS9s7lUSelDy9nwVxN7pBQ3n2Hx8TKaJLUz
 b6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760976041; x=1761580841;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gE0aTv0AybxpyvUrkw48kENR4BDFz7WGor4ksSfbP88=;
 b=vKylguO/hdQxRJl+GkA37ealYkeHbquawwgRN+xZ6H1/pn/cvifF+akLrDYGzL+7QQ
 Qc2giyIBnBS33kAfeyFWTGmveZ6mo5qXCZsH+dmNsZzqrWh8H/gv78o9FOCeoceiHKVO
 dLLvPlEodTgG9YFxTk+PhLwgH22KgCwCRg8DHcXXLMtFq2Uy944ecmDrLNae70ymHIQd
 vCttgoF2C+QsBHfjtnY1+u+NZku19Qf3owWKDY7AkVcH0+HEKLo5sEPp4ivJP9496+iT
 +9EuvphiYEMEb7vxdL8ImldXnIfmFE8D3vszj/8qxuV62QntmuCc+pCpmbCUcsy9DxId
 8o1g==
X-Gm-Message-State: AOJu0YwwLJvbO+sYVyHhaDNFsXP+vvP3NavoNCNE6fShAuXJQRCq5Oqr
 bEFZvMMoDhoaCNS+XxEvSUjtG4+iHafH5AMMOCvt3lTuX5l6jduKxscz7UU5/BR9wt+GS87B8kN
 OoMNBSAI0oH88R8L1soDJH+U7XRRLMZPJ0G6n37YJHQ==
X-Gm-Gg: ASbGncu9DQ1wVAWKgoOnCm5Mf8H+44fEZF6TFFf+gWfknSUB+vW26XZAEfaNkZWadlP
 tSyG6XH1v2snfLvirWdifcKubiPq/i4RgPBtqqYMkG5QhOR93snQT4STuOSDaIwJvlt0s3DSU23
 oQtq+EEQTTUDI0u2mYdogCFxNqxsf2YJQlOsez9pvqqwTxfIKsPqL7kENIiDkD9cdcPanHGQIkk
 JUVPT2qbK59rL1Cph4nyQcz5bye9xkk5k+r2oOXIB90DSbHjAGHOCJ32TjZdQzdwafTsaNQ
X-Google-Smtp-Source: AGHT+IGj5yaIs7YXh4VhmkoPHrKX58fVe1hMF9e/q5XLdNrKaXPl/glyTwbnmvgfq66TDgnU5inmrI+Q/nXD2hPtgmY=
X-Received: by 2002:a05:690e:1541:20b0:63e:14cd:f988 with SMTP id
 956f58d0204a3-63e16168238mr8912059d50.6.1760976040858; Mon, 20 Oct 2025
 09:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-4-mlugg@mlugg.co.uk>
In-Reply-To: <20251011200337.30258-4-mlugg@mlugg.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 17:00:28 +0100
X-Gm-Features: AS18NWAlsPTs40mKq2vyHbsNI6RtBJhw88U7987zJOHQjNmq-v-zEOkssKjx6xM
Message-ID: <CAFEAcA-bCh=YdU=+FsHu_oKG_L+8hhrFW+E5XN3xomVyppNvnQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] linux-user: fix reserved_va page leak in do_munmap
To: Matthew Lugg <mlugg@mlugg.co.uk>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 11 Oct 2025 at 21:20, Matthew Lugg <mlugg@mlugg.co.uk> wrote:
>
> The previous logic here had an off-by-one error: assuming 4k pages on
> host and guest, if `len == 4097` (indicating to unmap 2 pages), then
> `last = start + 4096`, so `real_last = start + 4095`, so ultimately
> `real_len = 4096`. I do not believe this could cause any observable bugs
> in guests, because `target_munmap` page-aligns the length it passes in.
> However, calls to this function in `target_mremap` do not page-align the
> length, so those calls could "drop" pages, leading to a part of the
> reserved region becoming unmapped. At worst, a host allocation could get
> mapped into that hole, then clobbered by a new guest mapping.
>
> A simple fix didn't feel ideal here, because I think this function was
> not written as well as it could be. Instead, the logic is simpler if we
> use `end = start + len` instead of `last = start + len - 1` (overflow
> does not cause any problem here), and use offsets in the loops (avoiding
> overflows since the offset is never larger than the host page size).

I don't really understand this code, I'm just looking at
it fresh, so my comment below might be wrong.

> -    /*
> -     * If guest pages remain on the first or last host pages,
> -     * adjust the deallocation to retain those guest pages.
> -     * The single page special case is required for the last page,
> -     * lest real_start overflow to zero.
> -     */

This comment says we need the special case for
"real_last - real_start < host_page_size" to avoid an overflow.

> -    if (real_last - real_start < host_page_size) {
> -        prot = 0;

We delete the special case...

> -        for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
> -            prot |= page_get_flags(a);
> -        }
> -        for (a = last; a < real_last; a += TARGET_PAGE_SIZE) {
> -            prot |= page_get_flags(a + 1);
> -        }
> -        if (prot != 0) {
> -            return 0;
> -        }
> -    } else {
> -        for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
> -            prot |= page_get_flags(a);
> -        }
> -        if (prot != 0) {
> -            real_start += host_page_size;
> -        }
> +    /* end or real_end may have overflowed to 0, but that's okay. */
>
> -        for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
> -            prot |= page_get_flags(a + 1);
> -        }
> -        if (prot != 0) {
> -            real_last -= host_page_size;
> -        }
> +    /* If [real_start,start) contains a mapped guest page, retain the first page. */
> +    for (prot = 0, off = 0; off < start - real_start; off += TARGET_PAGE_SIZE) {
> +        prot |= page_get_flags(real_start + off);
> +    }
> +    if (prot != 0) {
> +        real_start += host_page_size;

...and now if real_start was the last page in the
address space, this addition will overflow it to zero.

> +    }
>
> -        if (real_last < real_start) {
> -            return 0;
> -        }
> +    /* If [end,real_end) contains a mapped guest page, retain the last page. */
> +    for (prot = 0, off = 0; off < real_end - end; off += TARGET_PAGE_SIZE) {
> +        prot |= page_get_flags(end + off);
> +    }
> +    if (prot != 0) {
> +        real_end -= host_page_size;
>      }
>
> -    real_len = real_last - real_start + 1;
>      host_start = g2h_untagged(real_start);
> -
> -    return do_munmap(host_start, real_len);
> +    return do_munmap(host_start, real_end - real_start);
>  }
>
>  int target_munmap(abi_ulong start, abi_ulong len)

thanks
-- PMM

