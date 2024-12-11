Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76832E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLJSP-0000cK-OJ; Wed, 11 Dec 2024 04:56:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLJSP-0000cC-2v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:56:37 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLJSN-0005jn-Fb
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 04:56:36 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6f0054cb797so29205367b3.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 01:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733910993; x=1734515793; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aQlweYfhWxO1RVzzhnC2aPMv4kSL00cF7d3mFbQclLg=;
 b=nL1tLMGdpNHFBr362HosUQJb2UoeOTj/W6bJW7hXo96Ijuh+t4EP9DjlCPxamlsFli
 QWbxzeYhVyQI7HR8+K/JQXRWkvaZNHT35I97e9u6zpJhOtMZyW1jGqquvQtBOH82sdPS
 G0BuFsFDroRmoTZOJ7OpH6lgnbDjcsMbPhzLw+EiBMVLVnQts+k8g9KPfOCqtJPlY9TH
 pNHshpMFu3KK1FGlfHRjpk0+s4XUDUhXG2Lo6DiPzDsrFZwv4zWL52tkY3zg4mUwwgXH
 BhdKwLjh4bIaWzgld5g6FVdkRr+N3fbxFBkEG9Od4P5OBJN/J3N5fjX59NOOoexfTogs
 lKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733910993; x=1734515793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQlweYfhWxO1RVzzhnC2aPMv4kSL00cF7d3mFbQclLg=;
 b=XLUDwElvCSWSKVd17BZ6XwglOgFfIhQSNUhMehfcXNNiCAAePWfpCj5FRsBphqurs6
 Ee/foUS1wbiJDFlUgyrViaEqHS4s/VPHKDVBvjJh29wbDDD5+nj+kch0NAlzJzQ8Ksjh
 G+Assa0+EdWxhwZV60lzGM0NE72yBJHNv/0IVoF2MTGNBCa/lHSJlAUtSnMdhLV7/9JH
 NdlF+04720+OSK0L5EkTvKHBonXtYWOE6P3nxrd1iuMYfuP5jSb4dFzICJYUWt6DCFKy
 Z2GZyXcTmTe9/6ySX/60N1fZ+SUZuMpNMkgzIo0YU9XukZ12XZkeHMv2Uz7XloOxvAVL
 y4QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoqp9EiID4iz1S/Qt0CXCrmSPUfMXs9PnkULpoeTyFtHDnuUqbzcxqUzmDQ7TK1N8R5lL8jZgAGvrT@nongnu.org
X-Gm-Message-State: AOJu0Yzv538vdPCPlU6ZP6qxEXGrjk0iX1NIz0p3YuZaJ4y2C8X+t8Nb
 eiXbVQ5ArzZsBHOW5UGNsmbtBdtPE13sXDXpfPw8q3SEQLvG9SzooiLIK1uxGg85C+WhmD+PkxG
 lBbZy3iddlr41OKk6lpxorfZsHThbJVd+hTdcmw==
X-Gm-Gg: ASbGncvcvLXXw4hsgeKripMvVIxVTYjwqnvRRMGKZOuLuljjL+snyfQYiZgNhlHEOPt
 ynA7XkE5MuHqrAJGioR/MWcSRzVeYoKjt49fB
X-Google-Smtp-Source: AGHT+IFpXn77kwRxi3AGAnE3lfS4Cr2co2vWYvDAI5Xl3tgprgmSaaVBFUau9L9nK5hesMrwzsLOQ7m4EJeKH6/Ez7U=
X-Received: by 2002:a05:690c:3342:b0:6ef:c24e:5f8 with SMTP id
 00721157ae682-6f147fe9c7dmr24645047b3.19.1733910993072; Wed, 11 Dec 2024
 01:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp> <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp> <Z1MpY7ZIAAoBDbZU@x1n>
In-Reply-To: <Z1MpY7ZIAAoBDbZU@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 09:56:21 +0000
Message-ID: <CAFEAcA-6KksbRmL7V0dm_0KJ_zgsaJqCkuTpswbbefyjdVeFCw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
To: Peter Xu <peterx@redhat.com>
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Fri, 6 Dec 2024 at 16:43, Peter Xu <peterx@redhat.com> wrote:
> I assume it's about xhci_cap_ops then.  If you agree we can also mention
> xhci_cap_ops when dscribing it, so readers can easily reference the MR
> attributes from the code alongside with understanding the use case.
>
> Does it mean that it could also work if xhci_cap_ops.impl.min_access_size
> can be changed to 2 (together with additional xhci_cap_read/write support)?
>
> Note that I'm not saying it must do so even if it would work for xHCI, but
> if the memory API change is only for one device, then it can still be
> discussed about which option would be better on changing the device or the
> core.

I think the memory system core has been broken in this area
for a long time -- it purports to support impls which only
do a subset of what the valid operations are, but it actually
does buggy and wrong things in some cases. So far
we have effectively worked around it by avoiding defining
MemoryRegionOps that try to use the buggy areas, but I
think it's much better to fix the code so it really does
what it's theoretically intended to do.

thanks
-- PMM

