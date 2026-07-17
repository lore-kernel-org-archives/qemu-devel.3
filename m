Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38587C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgkH-0006Vb-9m; Fri, 17 Jul 2026 07:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkgkF-0006Ux-LZ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:28:43 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wkgkD-0000CC-Fh
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:28:43 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81ee41aaec1so20952517b3.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 04:28:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784287719; cv=none;
 d=google.com; s=arc-20260327;
 b=gKokvbojzAirgd7A9zfIA9AQYltT8BwyNigtCG9RDzN2yg0kUmQRSFxC8JQ9lgSkds
 qE0j7uZHD1dmytYiuU1E0nmYcJhR5p5Zr8Ihlzdchl5Gic6c1J/ReJ7CXV9SYzlJWpek
 VowXoLCtjCvzCQfISZvCVdap4k96+43YDrNT5ruirLLOHk/8wAiYhJAGJwRXWNIOCLSi
 kZxI35isvAysfF6BTt19OjmsedZ0OMXi1FSWPxV5z35NlAFT78pRIhlANkRbcgSkwpFw
 JXX8a4PsSleEGmZmfK46oRy0Yd6sMcy7ts+3J7uSKymvJfVzLogDVPctv9ITYfd38xRr
 NrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8csP0/y1o4tNevTIFivehVlkNlmNFE5TfYnkt9pwNXE=;
 fh=OM3BSxedQk5F2YNEo6zs1zCTkf0tpzWc+pm1SrDXw1s=;
 b=MWOssTNcGHIGyQB88WQ46CTNYhs0cRFeDJ139TQK+RNh6+iRCAVvx2s8hZd867Kct1
 MfBh120gQcVZu/eQgHyf5xKyjkchKCEK7XctUmYUY/TAS+vpYfyFSi+Tj5jmJuH6HqP5
 drIPU/rcgUlD/uqt2Zw/KSprJbwHMbEoFtgMWEScBO9xClkLx+RHODe4yyY6tVF0aXFS
 4/AkV8zUqYNY1ltUYGbb4NfhYGXH4eX4A7Y2h9GRiK4562jfLuvrwL3MdR2CwgsNpcWP
 cAuhlk/SbdWrIWEU010XB7AyYsiUWsxTDYmPtY7FdTM0PGDXvKYRruorMj8Guiml4ivG
 hKyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784287719; x=1784892519; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8csP0/y1o4tNevTIFivehVlkNlmNFE5TfYnkt9pwNXE=;
 b=MeaoY7KU8CUMk1ymwI4JGKMIEfa29McB0T8+p4pQHv2M1ebsSxdgZ4tXZ7Z9yzCsZz
 JvovlMuXscMn3SoVFv4aurXerpycxtx3XccQzgHNU89KPTFOE4eA64x6r50HBESAveQB
 UYoHmaqkkAD2BY22e3CS7nndjNgJSOy0saXfEZSNfZGYSb4NazLh+ouc8P/hS2+QZ4KD
 6bFe4qDCwhrTXeAeswI8VsdVenhoo/ptvJJDcPbn9d9HsaRExH5B8wFY3pRib37f/vEa
 EcTPy0YGwcsAHpGQAF8dAjJcDxxHVs18rWDMugZoO0viXP7ImI+sKCKbYgnJkfeB8Un9
 Vv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784287719; x=1784892519;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8csP0/y1o4tNevTIFivehVlkNlmNFE5TfYnkt9pwNXE=;
 b=DBxaqgIO1nVRUew7y/zQ2/bGxo/n03X9KiQZIrC/FqCGC230nvRx32o+IHGeTJ84lT
 nz8R/vQEwey6xraZB1Ud97IJSQPaLIjAZNQy11FuHJcwQ9l8HkKq0tKiOf+N3grhNNol
 Sr7wWO2B8Zi4pXD8bhxdzgzOeWIIgUXLW8acSHcgpzgWKWmwxMtfKBf7IFq16YOU3k4n
 jPbSlRHzfEN/+hqct2KpitfiT8J14vVlFQvx+49SUoMS2M780hs9wMF8Zyhw/V59+Kef
 2aVkkhtKoiaGfMuVJDkM4dDMT9wrfwdP2h6xukf0S69qFAbgtmJyM71IhXMQxHSs3kh5
 xdQQ==
X-Gm-Message-State: AOJu0YyEDKEHaa8/YYyzOpoRN/qcK4OfH0IeboMWq2U2jEQdsyKhyxSK
 1w9JqcZMWFD2c97dxyGdX+FwNgtdGZOv4XdqcRexdiKBsZIibq8ubRywLWAyxoZ9MxooL82Oz7B
 acyfzKVFsMyPDAnSyKGgM6nPBeGefqbE+SKYg0shMuA==
X-Gm-Gg: AfdE7ckjCwuq/g85rCHL6677Hn7njfKedJzv3EhgmHdj7MdneMQFiGJwgYk01wyYUS2
 XPfYM9lmSjiaxOBjlPQmyXSA/hnsv9OTtNsRTMjUvLKD6UsQ2g8QxnI4Ne/jarTDKxfzA8kU6hc
 tBdRRmr6KD/2CkGFPCxMWtmTTYgc1ip6wugUEgpEF/zGE0rSmzMKvOx5jK2NnWuQXu8bO2HBGfW
 z3qFZDaCpFKxPBR4benis12RCOaXXpF5s9DeijmdOj9qEOXK+0b6kfeVLZ3c6hKs71faDdgl+VT
 TLkxWqnpcmZYiZfhjQTyWwZQQVLPmt2jmFz6M/fdks+UQrecETaAvYzb
X-Received: by 2002:a05:690c:dd2:b0:81d:6af3:b9b8 with SMTP id
 00721157ae682-81ef26b7ed1mr5205977b3.60.1784287718737; Fri, 17 Jul 2026
 04:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260715131819.14827-1-dingtao0430@163.com>
In-Reply-To: <20260715131819.14827-1-dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jul 2026 12:28:27 +0100
X-Gm-Features: AUfX_mytekb_1XJdQ79DW4roY87bbelE0vkQUmnZwMfIafaiVPXObc6z0M7LXHY
Message-ID: <CAFEAcA8AHg2Sov8rEsU1jNFYUgmBaVV7eBz0YtzExwHTLYvdEw@mail.gmail.com>
Subject: Re: [PATCH 0/1] imx_serial: add missing migration state
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, marcandre.lureau@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 15 Jul 2026 at 14:18, Tao Ding <dingtao0430@163.com> wrote:
>
> Hi all.
> The imx_serial is missing a migration status,
> resulting in no display on the terminal after migration.
> This patch fixes this issue.

Whoops. Yes, ucr2 has the rx enable and tx enable bits,
so not migrating it will leave the UART in a completely
broken state.

I've applied this patch to target-arm.next for 11.1. I
tweaked the commit message a bit to lead off with a clearer
description of the problem and to note that it's a migration
compat break:

    The imx_serial vmstate is missing the ucr2 field.  This register
    includes important state like the transmit enable and receive enable
    bits, so it's likely that after a migration the UART will be in a
    completely broken state. This bug has been present ever since
    the UART code was first added to QEMU.

    Add ucr2 from imx_serial to vmstate, and increment the version_id.
    This is a migration compatibility break, but this UART is only used
    in the various imx-based boards, where we are OK with compat breaks.

    [etc]

thanks
-- PMM

