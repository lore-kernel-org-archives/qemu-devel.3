Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29633CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRSe-0007dS-6U; Mon, 11 May 2026 10:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRSI-0007Vj-Jy
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:18:08 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRSG-0001ic-34
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:17:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67cd93d8affso5375727a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778509074; cv=none;
 d=google.com; s=arc-20240605;
 b=PGAcvFdaY/iWZM/5SsMUinOZFs6qgi+ynMPppQpuJ4VdA7HY8vusm9pA0x2yJuKlz2
 sy+Mtb1SKmjjiQRC07lVUcfIRtjzOVgcIKehtE1AMvDGfI0ofPVgQAgUnEeqVNtUZ+mc
 A7War+6eNGtKaeZQrCEI3e1Tuz4WUYz3jQF/oiN8IEX5Vg0yp05SB1j2SxX9deULYUm5
 FFG+1Iabws6CbrGaB26IbkN0EPFy5RQiVYyn2EOeYXs1/QbRwCoAYb4ny7dEd727IvbR
 cPANfjEvZlDX6Cu+ZXJcPXPoS7KwtQIIEHwVLYJiSo4KJ3KW13NtqIk/WMZp5ONjrXYQ
 Q9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kZWegm3VQdlTb80HGFy9LYQRDs/QKdpT795/HcDOK3o=;
 fh=w1qLZYvxvfqm+49fh1s+ShNz2go/adfuHdhu2584auE=;
 b=jnocHTK7kJqneeNgGg0Tj01aiid+dl1DCqJI62LkyyW2Ph/Za8HHGUnnmMcVVRImAE
 txjDDnwHGy3o2stXcYpfLb+p2Z3ImDnE+Fphv6ZcX8XXVy7/OaJ5Sy0WPXL19d0Og0dQ
 xmndWnhVoE2YRd3O1R9FBF8yHSpckN/XFWle7fh+TAZF68rHU8OY07DUQu9Lj93sU/FI
 9cLEjNKTlmTFSnRKxzxcMZEBJfRLoV3BCOcZsGQk8WHtr30Xqu3KfGiy1ZNqDJaOHjK3
 yw4kSQQI5SwSEYdqOQW1RkDteOtsnPayC9W4bqtHtPFonWxLHIf8VS48zM/Lh+NlrRgl
 lxEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778509074; x=1779113874; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kZWegm3VQdlTb80HGFy9LYQRDs/QKdpT795/HcDOK3o=;
 b=xRey5b1P6BYuSBu6QjMA2rkYHsUs517hv84a4G9TTZ61xzSIdUzraGe/aBz1p0na3i
 ynmLHpCvYPoZs1aPzmTsyCikhPA+klTB2NtCnP4FL7Fp+pCuFuGJ9UH12/or1uAJC7iR
 nbPzzLyiwGN2nA8L+UJyWbhNrEoIe1uNNhABpTEy2bSZgom5zbiHkaeGYTqJLMaRnxpA
 Fntgk3eAhCEGdchJ6QVwnK5ksF6T1ystDY7Nb0Yfg6wUYWgHCfs1yaGccGVJH/rEbnis
 +IRQnjbTS2/AHqfj7kO/jaMPERJ3bft9bbvT+5+1W8ZdhL+YGMPQ6+IvNiTeGLuZl0I9
 nDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778509074; x=1779113874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZWegm3VQdlTb80HGFy9LYQRDs/QKdpT795/HcDOK3o=;
 b=CIueiINJJ2LnrGNafGiPTxDcxHQnmTVIVn38SwMZiYQqe1tuzEUPQpY7Nhhi8d+khP
 rf89G/iI/LUM7NrmqPw3hNIohKvKJla5trieC1WDYdB0nBeuWh/K73BUSv6rn8yQrcr0
 ybIOSWBP5TzFENEU5mz0MmS6cpWMIWFQfxO/VGO/F4D4WU2ChzHWD/Im1WFYuilT9/W9
 8MsNDxfvAy/OuZWj+ogNsVTxRxQXhPVRWTjH5yum5qZk7h5y+a4JOnNtTMuDAU7/lGu/
 fRyZD/NrWqdexS7QF7pJuwgZwI3HNA6s1UFcKWTGCcX/GRJdc/U6GEN96VTIBQU37OzL
 Nykg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/xtpGJZxIgBiDgHlaPLvC8zvpb7VV5knpWCBPD/4X5j1CBXg8vYqJwiI/yrtXAIkIGW/NmqK/6zry@nongnu.org
X-Gm-Message-State: AOJu0Yz3BOUs6KW/g8w/WQMRCg72Lk5qO+xD5/NWTkr+Nv6WF0z1E4rf
 qoQVjM+RssVK06bU/Z0AS4aYKAKy4K1YAvpAXQ8/f+ZK5Tr+wvOaeUnUKbogEwGDMMXRUVV54ok
 6rAWre2WwsiRFXG/PuGsPAV9IX7h3++2mWnh9wFg3dw==
X-Gm-Gg: Acq92OHo0V2euOsluNvwwfkJrovR+BptAdp4AvONHdGFmn4GNNwTY8yo+ir4ZYlSyZX
 h0fcnUvdgmnOIK4Fb98/ZsrmCMFdQ6gdghvQoQJ49pBxacgQ5pohzyfearqyolqMFSsE8bdVYUt
 xq9Nl5l98OocsnlsRvhOVjTZcRV0VNCSi+OsqnrsbNveYBwH9ue29j8QeCR3VcpKccZG+YG89ub
 YaB5z3JNd/hwS6K8eMrCQLY89ZTH8LoRa4pdULoxNubfCVwrZvuVV8Pc8PuxF4tmgTq+V6Njvb8
 Zn4uwTw/jn3KfJJf0PUrIu3HLqujlwxw/T27t2Zt8c+j/fno8+4yUB8q74m83Mx2lg8=
X-Received: by 2002:a05:6402:2103:b0:672:6419:8c23 with SMTP id
 4fb4d7f45d1cf-67d642b054bmr13072530a12.14.1778509073896; Mon, 11 May 2026
 07:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260511132814.63954-1-agarwal.vineet2006@gmail.com>
In-Reply-To: <20260511132814.63954-1-agarwal.vineet2006@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:17:41 +0100
X-Gm-Features: AVHnY4JdVtdmF3EeFHiTOKjM6THvNQHeuLoAXbuTjEtJbW0acTNSxieJwLMAEw0
Message-ID: <CAFEAcA8MTfvgoe5rOcWWbVMLdS9_+vnwSD-AWys-qnVdKO2fLw@mail.gmail.com>
Subject: Re: [PATCH] hw/core/sysbus: Guard sysbus_mmio_map_name() against NULL
 names
To: Vineet Agarwal <agarwal.vineet2006@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 11 May 2026 at 14:28, Vineet Agarwal
<agarwal.vineet2006@gmail.com> wrote:
>
> sysbus_mmio_map_name() passes MemoryRegion.name directly to
> strcmp() without checking whether the name is NULL.
>
> Commit e27194e087 ("virtio-gpu-virgl: correct parent for blob
> memory region") intentionally introduced a MemoryRegion with a
> NULL name, so sysbus_mmio_map_name() should not assume names are
> always present.
>
> Add a simple NULL check before calling strcmp().
>
> Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>

I guess so, but MemoryRegions with a NULL name seem
like a bad idea.

e27194e087 looks like it is trying to work around some
other issue. I think we should revert that and fix the
actual problem, not do an extremely non-obvious thing with
NULL name pointers that happens to avoid a refcount problem.

thanks
-- PMM

