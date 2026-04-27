Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A7FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIMS-00050B-54; Mon, 27 Apr 2026 05:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIMQ-0004zW-DB
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:34:38 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHIMN-0000ie-Vh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:34:38 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6501c9903edso9987236d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282474; cv=none;
 d=google.com; s=arc-20240605;
 b=Xx2lnH8CHyRmuUo/jeVbmFWDTATfGEADawrEDijr0hrF17RFC3A/8kpg/H+ismztN1
 pGwb4HP/Y9wXrguXFBUDYkaJJZaCtoMeS6SkXVzCVeQKjqNAiOtNA+pp7EaiPMiKhtYK
 /sDqzp0AZ4zaWr1wZjIOBYHaPl0HKGJdPKw7UGHIwVBru5y1X94EdHKdnVaxRBeH69V1
 U69JuMmPx5JqXqg5EkAUUbTesxH+uBYhRDorDIGIZAEk+y5kZQ0TWuqwFf1VRycGQ5ad
 ushLJfgVE4xGwAyO55z8/k6NfIUVJu2kEjdxaUDQ09RYRVYP00pz2N6GAhwM3C2KBnZU
 oQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j8eCnf4hQDjmLnHyqRUzu1wlRsZ31O/dfDDbavavQnk=;
 fh=gCCCR648ajMw/3KPZIdA3gdk0qoSYJtx7euoE1AaGXU=;
 b=S8ZFI0bY2CIBKlcqNOS9zL9r2K/irYgBBdnwO/6m8qkIqGealEaZAM/kTg/+kQGNT/
 8aLNKs85hOi8hR0ZDYuRnyu9Oo4oRAlN9PeO4KZyj/xT23p7FkrxzX6quU2mV9ZKB3Hp
 4s99k/Z6n+jS1VhFzxPTIsmctieLqqarMvgLEJc4GG+sl9hmqJquA2+GrT5j5fT0zr94
 EA9CVCP1tx16j8x3AvS7WjvxzrqgSchhlhab54eHCTlMqc5Or2cv69bGc1XVOBXi7sE+
 yn3+sbqL9Haal3B5Bc0/QGxl0Afv14ytvIMLXhIqTs4h+OmKlVOYlXzWO1EZ39YJ/kXG
 6FrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282474; x=1777887274; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j8eCnf4hQDjmLnHyqRUzu1wlRsZ31O/dfDDbavavQnk=;
 b=n7FIXrCpHmTvFRAv0lbGFVvfvw4xuTf9ewEPLC95grGepa6EsWt3eb67ar3/CaTotw
 9gkwatNWVNS3FhCbqSy4jkFCeBsE5fh+Wz39ytY4G6NdJso82oQz5eL1UnmY9Oend8WJ
 XDkOkU1sWR4mQ3AefT1ASKIjVrLs2u/NQGq2kTa++HeTHTP7tS58cIduwtAM1ebXJzQS
 uFYHuCUEwFuqEPm3Sr3GEKx1Ih0kewpI4F1FHCPD8OlSqxqhHWMEeNHoIDBG/e1ico9y
 Dw8ryR/8uMEH0aj9KUgQp8j6PlpJgH3QcxnQjXG67NZf5xMa8BA/1EXFNilDuSsVw1q2
 Itzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282474; x=1777887274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8eCnf4hQDjmLnHyqRUzu1wlRsZ31O/dfDDbavavQnk=;
 b=Z4HmXMEz0TTHPmZMbP0yvUH7Dz1bbiVCZ1QbtOa6f6B9D3cF1FLRhXKo7Dnesb72N5
 RdzDRrujTopGysompCXPczFPP1RuA1a0DlucB3zp01tKsByIdp4GwIGW0NMA8t/Kurzw
 GUGh66CH3WMzl31Gq6XmEBVsaPYG55DOiOahTlqRO6HI0S22AeOzLxEzdOj51yxgnqSd
 +HQVQMNEVoK29MX37Ncb22xNWE52PVfipLrA6mXvHiALYjprt+ls2KeRP2myp1+rqqoq
 UTMLqC5/sa1oZAqJxSGmh1cjPupa2NvL6jHlRvY2JnlBxk6g0G00kkecudt8oQ7uH9fg
 58QQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/kgh8eOqSm10cStIZEtG9FMKvvpApGYbPXX3vbkHZJcCww8xfV14ynhj5D6/JCHbGnwzVlZiQUh27@nongnu.org
X-Gm-Message-State: AOJu0YzZzy0uMYj/g8ypknRgDN9K3iilB1Lh9p5PQRWB7c0WMi8SpdX0
 f0y1d3fvPghdVpExi9/7UL9pNHGamQ7X0F0/fDO0c/gNYLRXryPLZitf/uENS/6+rkdR+yWujVV
 FFc2c+LInS8dv+Il2IzrHJe506l821NFZvo1tuStmbA==
X-Gm-Gg: AeBDievE3nxyFA7GsHfA1WMhR51tsc0qYG6MARGcHECOIGCnWDTxKU6ZclNSKz/dU5W
 x3L6kVOwpNb7FDVmbjjfHIFFnEQ4NH5U4IBJGZznrbdCFXqI5m57/ibhfJXAph5MOzpVI6EVSt+
 Ws/czKYDzFo18ciPJwO6Yo++ZezstxGfaNJ/rRvZGbGEPq81zzpcfb4hD+gsoyE6clRGMdpXV2/
 /brDyXVEUDtZALWY6wMelpIIiebM51LzKhvSOrfyrbaYIiPJFwGrEa2gAaM6Vn84J2VceulI0Ky
 FI1W0wC88kG5yZxbsbGM8tIkMI4fYL8eKCMJ3Zhl1js6bwWtde2SXz+hT5ZdVTNnOLZwwnOvKBY
 SZKYjL6uxzw6n
X-Received: by 2002:a05:690e:2505:10b0:650:37e7:e590 with SMTP id
 956f58d0204a3-653108302fdmr30094151d50.15.1777282474314; Mon, 27 Apr 2026
 02:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260420140552.104369-1-eric.auger@redhat.com>
 <20260420140552.104369-4-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 10:34:22 +0100
X-Gm-Features: AQROBzCyIpeUT0xpTLJFjZkFZrop_TbmUsK87Ixbfl9wzVon3mCXRRlLtkkCcTo
Message-ID: <CAFEAcA9sOn9hB+n+4QUtZqMUVY0axNs0MCFUM_S+b6P7q-LNqA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] target/arm/machine: Handle
 ToleranceOnlySrcTestValue migration tolerance
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 20 Apr 2026 at 15:06, Eric Auger <eric.auger@redhat.com> wrote:
>
> Pass the value of the incoming register to
> handle_cpreg_only_in_incoming_stream and check whether there is
> a matching ToleranceOnlySrcTestValue tolerance.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/machine.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

