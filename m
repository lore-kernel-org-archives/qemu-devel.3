Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24493CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNks-0007VC-Vj; Mon, 27 Oct 2025 09:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDNkm-0007U7-KC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:59:22 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDNkf-000162-1T
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:59:20 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-785f96ae837so13729787b3.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761573548; x=1762178348; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gib3Q92U+jR2r1WmjCDRtAJ/QprA+Vxy8H70HqEt8tw=;
 b=jyW+AnaY2t3DLvyNbvCpl6sF7VzFMoUVbvEkS+MBniIAVm6LJ0n7gR/n0gljaD18wl
 SDeXX1LmaKYglSFxXtWgJG7m5ih0Imfgw0rSkut/DqvNGVSFdQkKAdGQm3GyQnjn6muZ
 Ku2s6+OLKiVUU8/uZAHMkwQz9BGqMH1Iuhn7t4euqwUQYLmN2OzUPpCo6NwjD2P4hvHW
 7Mqma1xlWKHU+ZPkLTvBIAeY8zAGv1chUdGU40BajMy9nxZ3C+P/a+M+U8sbaA9GUry+
 8v2/vX937pnKS2/Kl1Uh++oRBNzL1Ie4RP1fKraQvTs/d8hLi+XvPMe6NT4By4R4BN5q
 sRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761573548; x=1762178348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gib3Q92U+jR2r1WmjCDRtAJ/QprA+Vxy8H70HqEt8tw=;
 b=soNX4g1+xxOM8eLrw3AV+7RFpTBXy3uTxfXlcclFs8keckHFhWFhAp/wVoQWroUsrK
 tXi7vzgq3LBvz2rfrJWS2JvY6jsVeRoQpItnhcyx6/d2t+bNcy+ios+I0JxZbibREvkA
 KQHHcftb5tn8br5tZ97I+JfdUil4UttifvxysggQ0ALW0wqlVjZM9URrABRweQ6hAWHb
 i97SBKkt27Glu3lVAf8b+O841i80w3Yp6lNbRBPNHxMqVyZWSlUSQeLEOIJPZ38EgtOK
 uOKN0l5UiJ/Kz6zJLKShOehq5YyVSBb1GnmgrzxlZhwJiE4z7x0KPmdje83cDOJvgAPO
 advg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJbiKi09E45jd/xmkPH81QlK9XqFHXLDKn2amtDhLybB338QVdC6WehYLUKU+f/bRCh+nVHyF49w9v@nongnu.org
X-Gm-Message-State: AOJu0YyipTuwnOnAFujVXrwTTOtIdE4PldTwN1QgDoCN5z7rr2tf0pE2
 Yke/ngKKmPKT3ThPexlz/ouGWUPd4C9bjBO6JvuXJydMA01cuu9LQ4AUXAGtkdjN3ip8jc5XE1t
 B2zpsLRXgZjJcKEqh09b2e86McVVcRSSR544sU/HKxA==
X-Gm-Gg: ASbGncvMZShLWpfOuuYVuU19fN7MCK1tQlwd1nOd7faA90RP1C3uekxLo+eRI7BlBJa
 9RCktt8LH9nSORRCwCBXQgjJtigAjFGKhLVBdUWJ0SmX7b0Z7AyOPRx3F/ewD/6+TmEA+PmQIPO
 JEhPHqXkOWqK8VvT+Ds71zI/05BFk1LkmTu31sqrHDkyQNcIrtK83BZyjnTV5YJmUWW/I45pS9w
 SO80fdLwOP23IKIlJ6ErDO0hrT/Lx3HZ81qTzwMrTRg1yJXXCUgkwaSRWnJ84lZhFjYBbwT
X-Google-Smtp-Source: AGHT+IEjKxj4VLcBisprjZ0EhzxGLR/Pd4lIOCNN6YSuh00RoMwdvK01PzfH9kL+pz6NH2Y8fYSbOEOnlM/c2a0lVvQ=
X-Received: by 2002:a05:690c:e4d5:b0:784:a44e:405b with SMTP id
 00721157ae682-784a44e4c1dmr211274977b3.8.1761573547818; Mon, 27 Oct 2025
 06:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
In-Reply-To: <20250930165340.42788-1-tangtao1634@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 13:58:55 +0000
X-Gm-Features: AWmQ_bmK2Y6vb3bkPw_S1yfceDjD_WXRBHyC_m9SeNS3O6bShXR7y7KNA36IYK8
Message-ID: <CAFEAcA92dTDn+Zf-GZVv9zQ3_mwJHZY5hrkdgrRyE7XUio4Sjw@mail.gmail.com>
Subject: Re: [RFC v2 0/2] hw/misc: Introduce a new SMMUv3 test framework
To: tangtao1634 <tangtao1634@phytium.com.cn>
Cc: pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com, 
 Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 30 Sept 2025 at 17:53, tangtao1634 <tangtao1634@phytium.com.cn> wrote:
> The smmu-testdev is intentionally not a conformant, general-purpose PCIe
> or platform device. It is a purpose-built, highly simplified "DMA engine."
> I've designed it to be analogous to a minimal PCIe Root Complex that
> bypasses the full, realistic topology (Host Bridges, Switches, Endpoints)
> to provide a direct, programmable path for a DMA request to reach the SMMU.
> Its sole purpose is to trigger a DMA transaction when its registers are
> written to, making it perfectly suited for direct control from a test
> environment like qtest.

This makes sense to me. But looking at the code it looks like the
device itself has a lot of code for setting up IOMMU page tables in
guest memory when the test code writes to its registers. That
surprised me, as I was expecting the test device to essentially
be "do DMA on command". Is there a reason why we can't have the
test code do the setting up of the IOMMU page tables itself
using the qtest functions for writing guest memory? (Obviously
you'd abstract this out into functions for the purpose in
libqos/ somewhere.)

If we did it that way, we could use the same test device as
part of non-SMMUv3 iommu emulation tests too -- the qtest
test case code would just set up the different IOMMU in
the way that IOMMU expects before triggering DMA.

thanks
-- PMM

