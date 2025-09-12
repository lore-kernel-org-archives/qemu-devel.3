Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ABECAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux63Y-0007wv-2F; Fri, 12 Sep 2025 11:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ux63U-0007wR-0Y
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:51:20 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ux63S-0000MC-03
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 11:51:19 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d60150590so13142357b3.0
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757692274; x=1758297074; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lu6mlLT0PLoFbl1VC5pnBr/hANi9IR0prILlflPEtcA=;
 b=xOTyrPTluLG04BmQpSvzC1Lzz7+Bd969dhzm0a9+IytOjtuaIKrEbOHjTMzQm9Gux7
 7OU7EIuVWiWXL3Pd77Y6isOw8mEKhrSwdsz2DOfWRyHWuJXNdssHZbPneUylbm2z72oX
 NSH3dt5efEn7bH41lR3P8X+FwIgLX2Dadq6sY5PWvMga8QHEjWlDrtwG/fIfXqZlnLo4
 iY8qtDRhnpF3vvDnY+4jZRu0bvtNKLQX7pPHC0CdKWDpqaKrAZARR1BDE9mEzl2wr0F0
 Ze0C31/pSnuj5BJ4i57eDnmn/iFialoPktUvxLbAer4AwAkKwkTSEq8lAVDHngo6LVFh
 Z3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757692274; x=1758297074;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lu6mlLT0PLoFbl1VC5pnBr/hANi9IR0prILlflPEtcA=;
 b=R4zkIKqFjHA+cQR2O7lnVmqq1JDJkpf3rpdLtkWUpZeWMAyZLjQ4QoxOgcgJLTzXvN
 63L20b/H5hxofLiahRw5cnrNCfHNhYNF2Qnydn7CG2nX983+RimYnF551XMy9FRvhbdI
 TSCftfZNITK2OUljEnKB655qOaJ3an7ewx8aP6AYD3Ziu76LtGqPVszy2FzWqBRKVcBL
 Z9b/4YsKELWDINkO7COVzi96MTGX0c94SXbzdhjVcC9IuS453umRdAT+SzJtdvMZxEkV
 K+fbJFg3Hkv+REW4Yf8KzqY9I2Y7NvEIGZMqRH598FEhbDREwnExVGqPZ5VivhUky3+M
 g3Xw==
X-Gm-Message-State: AOJu0YyvIr7dU93eUf1emlFuSZHBMpfuhatleu2Bza9jv0fQNuePkHSb
 KtbJUQC9JscHFVQtGi+i2SDV0D66QGTbwBlg2GKoAqehoU0rbcUQG/Y0y5Z0f6a+gXK8e56zSkz
 lsN/5rjZwdnQj/VQruhwAQE4wSBR+GshoIXj6bNun5bIfkztPJQk1
X-Gm-Gg: ASbGncvivXtUZdGN7GYlFWBAlQHzPfzVd6fv66Bnlaf0ZX6RNxGyx3Ft6MgEl9psHni
 XN4Veuc2JxdjMRQ5DkliuglYy+QMd4op+KQTDXDVw5wiG9rOQghoRHg1jU9tabVjqOfmDc9vVZc
 D6f4xG0PBXGPuTfRV3ELdXPrHlO1mf2YC5RHnd1IYIfgxnH09SQh3O9wJ5OQcf5jlPaAHxt/f8u
 depU/OtVHogB+gQ6pw=
X-Google-Smtp-Source: AGHT+IHTxbewP9W+aPhGpm4W0zQ8O9Mheuan5rRSFWBie7SprXD5HuvVAseYipkuInPfGkaElkHLq4Ynd0plOQKVLAo=
X-Received: by 2002:a05:690c:6e93:b0:723:b330:3dd6 with SMTP id
 00721157ae682-7306338005cmr34478257b3.12.1757692274076; Fri, 12 Sep 2025
 08:51:14 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Sep 2025 16:51:02 +0100
X-Gm-Features: Ac12FXxGZ4f_ddUUQ4C4EZJqW8P6B0TzYh6DidrsAVZ99wd_2HRjIb8aQrv4mOw
Message-ID: <CAFEAcA80LakER=eZY1yK4X8CJA9Uwd-9ckLP=p4D3BJLpSTXqQ@mail.gmail.com>
Subject: when to use MemoryRegionCache vs direct address space read/write vs
 address_space_map?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

For devices that need to do DMA-like operations, the memory subsystem
provides three possible approaches:

(1) simple direct reads and writes, via address_space_read()
    and address_space_write(). Completely flexible, but every
    individual access will go through the whole memory system
    codepath, so not very fast.

(2) address_space_map(), which gets you a host pointer to the
    RAM backing the guest address space, which you can then
    directly access Subject to some limitations: can only use for
    reads or writes, not for a read-modify-write; you might not get
    the whole range you asked for; will use a bounce buffer if it's
    not operating on RAM. Has a dma.h wrapper dma_memory_map().
    Used by about a dozen devices.

(3) address_space_cache_init(), which initializes a MemoryRegionCache
    which you can then use for hopefully faster read and write
    operations via address_space_read_cached() and
    address_space_write_cached(). Again, subject to limitations:
    must operate on RAM; you might not be able to access the whole
    range you wanted. This currently seems to be used solely by
    virtio.

The documentation in include/system/memory.h tells you the
mechanics of the APIs, but it gives no guidance as to when you
should use one or the other. Any suggestions ?

In particular, I'm working on a GICv5 model. This device puts a
lot of its working data structures into guest memory, so we're going
to be accessing guest memory a lot. The device spec says if you point
it at not-RAM you get to keep both pieces, and requires the guest
not to try to change the contents of that memory underfoot without
notifying it, so this seems like it ought to be a good candidate
for some kind of "act like you have this memory cached so you don't
need to keep looking it up every time" API...

Does the MemoryRegionCache API cover all the use cases we use
address_space_map() and dma_memory_map() for? (i.e. could we
deprecate the latter and transition code over to the new API?)

Incidentally, on the subject of the dma.h wrappers -- I've never
really been very clear why we have these. Some devices use them,
but a lot do not. The fact that the dma wrappers put in smp_mb()
barriers leaves me wondering if all those other devices that
don't use them have subtle bugs, but OTOH I've never noticed
any problems...

-- PMM

