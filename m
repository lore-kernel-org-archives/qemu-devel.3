Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47842CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGezZ-0004EV-D8; Tue, 13 Oct 2026 12:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGezK-00046Z-H7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:04:30 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGezI-0008SC-U6
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:04:26 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6756a01fa01so3011129d50.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907464; cv=none;
 d=google.com; s=arc-20260327;
 b=RtfvVv+ua6SbsEAmFEY2WJBOOVdGGkIl27A+ee+PmG5Xm6SpAspY8lHhYkcBCjZpH/
 WcRmD4FuNJ83CM24dnihZiADf8Wo1TThsZUKe6G2dBz/KnPwhgN0NALPYG05kWOICxiN
 DObJNEct4ZdHPdNPWeBoHql/CEPAc1GDi0pQ8MjSWfHJdX8dLdzpJZEWwZFXsqurX1xO
 i+uBaHvTa/fFnxEFQsyRfwLr9iCgWhw7ZwHXbYsU/hwy4q/kij49bWB+Yvfy/A+KSapl
 gz2zu60cP18dNloGI/TNKfdtDO6JETuf7mp/Rizo53KdaGpbI2ZCJHHdr8GkXblzuthP
 TBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2C7OfiXt9IaI2mJWsPsiHzldRqnZN8DMcpH2IVSjVpI=;
 fh=86zCC63zsT14dCMBVJwZI7nKvnGR15JQbVuSm/aTiuU=;
 b=M4NUfef5D81wnhxoJCupEBern73cIEDYhF/QHGYigV4PBVyfJUMvBRlDPIMFP73BR3
 LY/B/txFkitDzbLpoiyh6r7csMBtfehUkfe1jbXcBENoLtgDIsSJjAZeoz9Siu+whhT9
 SSnlQnFB+FJGpsbeHvXbxXdfX9y+xLbM4m6JHjVf37SMMiabJ6EUxm1WQ3gXfiTZDS4p
 tqeGhZDBFVXTL6dLvkIfmdXCpReWC0/nMLTAq3FM7FIgP3AdhcSfhUtAA/HXEAaUMS4K
 qtB6Ept9Mp0Y/VmXFVXYus22pG3RDjXKODfs+WqekOlrFLsiW3MGJbBz3oyA6z8CEu+t
 WL0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791907464; x=1792512264; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2C7OfiXt9IaI2mJWsPsiHzldRqnZN8DMcpH2IVSjVpI=;
 b=EAMZ8muB3PDwS/B+oKYD5jOdDRU8GvbFxHJjSPhImyOnmujxuTXWe7cZUpvW6ETe5x
 u50SV5M4dojXS5nycoCF04JgUNv9yR7CHVkZKL2wJSPKrrzLvhY36qzHH/sxsGBUWpcs
 LF9edS4zqfoVwKTRe5Jxmp8trE1+An5FBalmO+L8wZ1flH0vxTFEpUdLEQhSW556NmkH
 TSIZ9/ulqrDxY0FIunBi5HjmUSw4kTaWFz7QKsnWJ36OJvkMJAhA+JZSXVsaLobf3aSd
 plnw2F9oIWK+1cjI1NBHROfPsp67WsZMXq6124AxNiqax1bEa6Niz3ozxQ66t1Zq2Z1E
 SsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907464; x=1792512264;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2C7OfiXt9IaI2mJWsPsiHzldRqnZN8DMcpH2IVSjVpI=;
 b=fEa2AjnoynpLz36cFFhc5Q0djPV2C8JQ2fdd8LhAwEz6Ruvhi+MgnIN/atzRYCHkCd
 sIZdnMtDYVvhfTodL/rF5diOPs2wBaE3tXAPjUKywElxiWKiWn5E6tQInrVN0e0gVJwB
 0wARa0OveJqOOIQPurr6q2BcK+Uvt4NFA6XqY2Z+Db6bFrxXTF+EP1DoxlBdbaACEblR
 +ADoRt2xeFfkfK58Qa2zfXZuQVM0xWTX8MuA7eSd10o/3oqiKUtYSgBweCGYOLhXLO78
 qesAUGABiPGwnbjcBK8FnwtTDDevHhF/gm6/nuZ7z2LBLabkcDXN4b2ZdpLcsF4cHvPA
 OPhw==
X-Forwarded-Encrypted: i=1;
 AKwUvByP0YL7D+oc074Sa3cobQu6Ey+97bXO5UN4ExD5UInWIYFlINLPmjF9FiFriLe34m29Ng3pIVxL0+Ja@nongnu.org
X-Gm-Message-State: AFq9FYKDDxItCIByUVnVQr0IFwAxGMFkrVHusHSHjryqSJewMWGcUfO6
 /vcxg3yDpdNoPqhY+5LPimj8w1R5CQuSBWIpQV2g9mIZTq0+msfFHgBEN+BMTzthZSJ9ht5F73A
 9PD9GhvwH3RTUdBxEZI31npNZ/aMK5T0ySBdPEAEf+w==
X-Gm-Gg: AYBFou0mKRm/DPLXivtTZvFHDiOVVce2qnEmPDPhCafBIYeuFd+yNXd7LFgRFLS0GRb
 +GVnJnR5OCa9hgEr2kuJgCR3lHRpsPSBJDvvxOwItO4N+qmqO5odtJ4PoEO5djO4gy6tZB5UpcU
 y5tlW/yd/2xLWirqiy4Bf7aJOUJavWDnJNEFKOFu4FYZvjmcBA7nJCkYEGE1Zl8/eGKpEgpwUJc
 qOZKw6u5SIiwBR2SYnBtJqpCneqHmh10bHKGykYjohEXZ0qGczNM+AZHfXwV1O5zWmNe9aro57z
 i06csMW4fr4V8RLLA5jAVHzBVC/wnzyL6GETnAuRdLYHr3BUCuJdWHxJVIb8um7aIVWHVJe9vfY
 NBIcDRLj804aISdGACVGT9gByPrtyhIcghv8Qxyg=
X-Received: by 2002:a05:690e:140d:b0:677:bf80:eb55 with SMTP id
 956f58d0204a3-679369b6ee0mr4493091d50.52.1791907463472; Tue, 13 Oct 2026
 09:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-17-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-17-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:04:12 +0100
X-Gm-Features: AclHuK8wb528RFkwEycNDWTgHt4Ti7HqhB22wX5Et2BKQLxl_F5iIYdPezPbfHQ
Message-ID: <CAFEAcA9iy0cnGZc9gVVJCnhRNuj3Pyk+BbNU3QMHWYFdVr1a3A@mail.gmail.com>
Subject: Re: [PATCH 16/22] xen-hvm.c: rename xen_interrupt_controller_init()
 to xen_i8259_init()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 16 Sept 2026 at 11:52, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This clarifies that the interrupt controller being modelled is an emulated
> i8259 implementation, and brings the naming convention in line with the
> in-built i8259 and KVM i8259 implementations.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/xen/xen.h  | 2 +-
>  hw/i386/pc.c          | 2 +-
>  hw/i386/xen/xen-hvm.c | 2 +-
>  stubs/xen-hw-stub.c   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

