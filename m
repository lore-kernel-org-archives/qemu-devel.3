Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C72BCCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkUx-0003R5-D6; Fri, 16 Oct 2026 12:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkUl-0003Qo-MS
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:09:23 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkUk-00015X-3u
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:09:23 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b0d5ddafbcso805147b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166960; cv=none;
 d=google.com; s=arc-20260327;
 b=GhB375QKYM/lLcd/lI7mWDbeU6KoGxLcEe+KClPrVNP+jKXqZzMof09T4YE0C71qIZ
 knAROW9ik+VfxveLuBus5QF2N1IBn5caXOsYvMnMzJMKEraTvMRgC4SEUuSZHmaxYyYg
 Dkh2QKPXyCQyxjbqCH1v+fjfAV+ZtHeF0rleoYfOwcUsrkHnjnisteNi20eASgIYLM4/
 hDj/t+UYCS0Bk3RoypdjgbazfiQI9XZ0xkk2tL+mSSWzHuInZlZZJT0rUkbcsCjSlP4I
 /hAcSNZeCWMwHWGaVURrTE5TXv+l40zGjc7PGiHL53MUUDGUfbsYCFZQQUQP+bzBYD3B
 kH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ekA2GvyEqTKTqcCmn0VyediNRRfm4eukmQVIUJ/lNz0=;
 fh=51KBUpVi/saECQLyoujkj9MD4KqSZf+wjpEl+W3IuBY=;
 b=V+vBhwWF53l9cxqQanUfkZ8BvZUpe3Hk4k51hqedeIfX8Xh5L8UcFK8ag9BKBtl6TD
 kCwhWBEwOZmM/iexW0HmAbRCCtcs09hUytF29FsvEyQJTaFbpm4nUZoJyQhjAw4zTCZM
 YrthIXhpJCWT5jSIx0s8X6IA6YUEiqVN/7nn0+6tpQP7b/SNUQaaUxYMnnkuIEQbYgB/
 +uIxsB9TXsHPqzi8eeVsy5T/BJNr0KWueh4toZsLe9992imHqMKW9F2P2Fmj/Hrt9bmA
 PdQuPNkGL2qDP/ppsHSTh7fOJzoRkPuqp0NppXEQRQp3EpgST7UiFouifcz84OgbbvUb
 SYRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166960; x=1792771760; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ekA2GvyEqTKTqcCmn0VyediNRRfm4eukmQVIUJ/lNz0=;
 b=mmYOjR1pk6i2hu2BMkz0bSC8gNHy5X0R3lEiP6YVeE3Dg1SxutP6wXbQmvcS9ZfYHF
 ba3ioUnUIC3nA/QrOrnxF7gARmADY7E9BvyOqOsmNGjhSMiPuvc2Dw5YjUH4RMI8bVwL
 qJSKpIRca6RKv9wQsTLuC+KxmGMLHC5m3ZI6ta8uDWueWyUB0gMhcytK8jvAl0qtxFjX
 p6L+M0FijJNvcxe2HG7IhpzreW4rUGVC7aj+V1Mg7I1hP8I3z2NPWr8mQH1LfQgGQ7TC
 h+ZP6ziFGG8hlcX2q/aJ7g01va9eILk3dMlpc9TFm4wNmOLVlnemzIfkhZZDX3Hzzs4D
 U/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166960; x=1792771760;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ekA2GvyEqTKTqcCmn0VyediNRRfm4eukmQVIUJ/lNz0=;
 b=JcjqdSGp+RuhAUhM/dPfv5iz/OccvGee854BJVPXhRHHrtocH5H+rwgkbCQpMH+429
 OgXBdppQ81rDZCKLWS1Fv/R1/3O4jGubXIjk/QVAKWESKH7tEsFgUAJvAJSjHBffR5+Z
 2yGMXdM5NCIHaxkC4aaAEtt3x1DKDAkMIMa/JFcQhCaoHaMzoutTTUZmWED1r5pXLrsm
 L+9gBzv+nHViSNs15hbHA40fpk5Z+PCuP8pelJpkfH8W7yURF/IjeBs0Ejsu+DAIB0PX
 eyEk2kxASVaPKDSja5K+rF8++axBINZC17tUXlRNqpaw+Kjs3ic/KqZ6BQ3wiyTJ+6s5
 LKBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZHXM47MrKAITmMykOKU4rZBi+X4yKFKabTQQIbY0gndqjZo17tFZDJmdYxSlPuq6ybZRBK4evIPYn@nongnu.org
X-Gm-Message-State: AFq9FYJlsaOMXiNqT0wXf90+7M42WoQRYiGcCPmqzBCr1ezgaRWURbxb
 YWysuGx0U0GpphHIkW+Gf5p3HpXt56hTiJeAcyig6GFgMC6U9L9UID3uj8g5m1Q8LIFkF8U/Qxs
 GEL8ds2iGUpI/LRFIpYwgSfF2RqYxKoSo1Ok1iya+OA==
X-Gm-Gg: AYBFou1TvJQhUz706OSZ37OOVxdNulBosXWpYRe5vL1wq7i1ZU9NagwupPBwJHswPxt
 BzyRhbd4Y/+hht9UKAf8oXYHJKhDBIINpSl6axsTfy6I9dSHEx+4v0tfgKlJlmBcvgo2egBgHPh
 MDGI3mM4m9mTfKoQm/B1Pc0zUpH5vCz4AyY0JvJsqhF2UB6vtQlAzH0Tq7yjePIrG2FGaIq2ajP
 6pHS4mZN75AXqLQ9DP5CiKFRvei0DEKEUkgrT/8OLUfzn99u/pWC5Y3fB5C7prgllfQOd6FMQth
 yAJMIPBVga9bckBVwZUEsEu9S0Zc9STCGfCwTWwUd+48FgeVfFJoz9QJ2091v4pRAnkPEF0b6wV
 q4SinB1Y4xNq/Lgafk3VpOGpdRtLvicGtT2O0y0qOjaKa+R6jkA==
X-Received: by 2002:a05:690c:4006:b0:8ae:a9c6:2740 with SMTP id
 00721157ae682-8b0f2209bd6mr1304277b3.48.1792166960326; Fri, 16 Oct 2026
 09:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-27-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-27-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 17:09:08 +0100
X-Gm-Features: AclHuK_xiyk2gcyOJ54yQX5SpudyGYSJxaJAyBmrPRitHx7LJDYQO8xS_rh4vqA
Message-ID: <CAFEAcA-FkqRofnq037W2YzwNuHkaYs3-QkrnUGNf=R3Y6A5G2Q@mail.gmail.com>
Subject: Re: [PATCH v2 26/27] i8259_common.c: remove static irq_count and
 irq_level variables
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Fri, 16 Oct 2026 at 15:24, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Adjust the parameters to i8259_stat_update_irq() to allow passing in pointers
> to the irq_count and irq_level arrays, and then move the arrays into the
> corresponding i8259 PIC and KVM PIC devices.
>
> Doing this allows the statistics capture logic in i8259_set_irq() that handles
> incoming cascading interrupts to be removed.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

