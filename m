Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1BAC531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvlW-0001le-6W; Thu, 23 Jul 2026 11:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wmvlV-0001kW-7k
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:55:17 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wmvlT-0006MK-Fk
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 11:55:16 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-81e9d8f3289so7830397b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 08:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822114; cv=none;
 d=google.com; s=arc-20260327;
 b=dO+8nTV4kdUU6t4AqhEtOKYMxvjxkjqQ8uwbz8BXXjW7mtS8vku3Zw2BvlmiCwxrPX
 UntHOc14BF/lH3eocFkswrCQP2ZxQtenfTipe9yqIrnw6xFuUJTtvnetqnuYzwuav9mO
 SWM9ZJP8vpuKrK3GwfdQsvIOhnaay8kUoH3JiXTjb/svmNShn8eqmznbVVBIIT/i5AoA
 ooLmUF4AM6Al1VUUitIqwi9eYdbnjHaTGsESLPqDl6eLZ2YlQqmU7h4d0BXcAIPeO48a
 e5ais9h06GgGR3ZkRZQoaEakJs+69Qn4ylVrCa6qEK8BsSNxflPmmTqCkyIqs8W8rlXa
 ALnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pJwSn3ukjKM+JqNAYqgEihjr16ONhDRfENkHSdoCMqw=;
 fh=b2BSeoINc7FjlbtZ1gt2iTqWSO3XM9Yc0uw5KWYzFm4=;
 b=kqqPtBgJyFvUMeXFBXGYBlp1M+IF3liw8o6yj1xqhVW9A3iyrRs7poUWcRUv0eL88h
 48cb6iBoy12t11Lcp0TmDrMM8bO92yDETvnl6QaVtQfQj13jbuFBGC9/C6NypEx3bnFO
 ulmK3unCdccZWkgNKS2klrX6b/jSMC0ifwo2EwFbMAU62AX8M1Q15YUQ0x2CgT4ydi5D
 HvUP6lxue4CTTVT6AIkAvuxX1wSKpenRyp7jGwB0F/kBLecAsPaYLwzfXee64ipRotY3
 319n7XQyyHpFdM/jPEI+l9vY16LcZuxu1fmdV4AeNgmZ4HYYHtS/mWqjCY5Xd7Rpe17x
 iiFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784822114; x=1785426914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pJwSn3ukjKM+JqNAYqgEihjr16ONhDRfENkHSdoCMqw=;
 b=XUcBM809ggQh0g1NUiPKP4UXlnS8JHGiTLC6NAXVdi0szDfqhScm9MQk/JAIWubncY
 G2+fLdDvP6tpNmmMq5Ie/uGxVJzChgFG9crQ+3RD3TpW/BcUk9lvSDsBeyEArM//sfYK
 gTp1ZGu0AQGxWxEVQKsopiZJNiiufzg85RvjwAHaCbvlAfbY5MVbUw67seO0mQR1nEsw
 xHbIAqCYeVHVOKhgH8KtbXva1pW2LXtkf++Xl4LXoBjaq/5/eFjTA/FcOYz/70/a30bi
 uKHTJ6Kxr3lBGdbpzcTRD5kEs2bznrdP0ur+gRrw8QU6YmekkK6UHaXzuj3BL+dhLCrd
 6OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822114; x=1785426914;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pJwSn3ukjKM+JqNAYqgEihjr16ONhDRfENkHSdoCMqw=;
 b=NCVg67O1mdDV7hAWB1KVjCbI4QCJ9jJfB8a/LqqPbuOG8yMz/gxMHon2PFQOLCKMyl
 P3yKJ5Zhm8cTuhCkFXtbedHkqpmx4zEjCqdGLsZAgLqk/IXLqtrtzMk3Z1+watvUurq1
 6J4/jv/pfy6a3FbF5LPVmQkrTpulYuJIqu7eubPZCPgDS+R09l7LjYNXZbmswiO/V8+L
 6+V2JgSeaV3VExsjGQl/imH7oycV7vPtR0fn5QFQW9CxoXHLuatcALHE3zZqv0Zfa8Pz
 ZV+NzcygNCCzTJaVDA39vphHdVfVJim6fMBd2bXS6fwIl8hbmiItyQ6pFliQJMisSmxU
 Zakg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/kOVqBJC5VfWe1djl+MkEz5PNKiQZy6LhlA66MVBsHtt1x+eSGEH0oQhxuSIhY9ksLBRWC1UIlRJi@nongnu.org
X-Gm-Message-State: AOJu0Yxv3aNH0ehompA5ik7M+vQM80BGFDr9Mpj0/FxcP5xzYfdmbpJx
 F0e+Dn/IthUdJwY3dFzMqekawEAXBlDa2R6e29e7M/jQh5lzF0YxJRuL+PI+0RxbdT377TicWY7
 pGtt/NbTtIvWNcoHgm6xEMcNo+mZCLmo=
X-Gm-Gg: AR+sD123o6+DPws5EuuUVp06w+VXUo/F2/lC6vZJexBeeBHi46JO+hiF/LFmPk7/U70
 eG7J8gO2WyR7ERL8KzOFCeCvsrSK8jELA5RXqlRiTQix2rysTMz9Q0VVQKKQ/2L1TIzoy6b+MKx
 hYp8WYpboH4BQqpecd/CaSvikSDkYklSZTZ4k3q3VbzE3n9NHSlbXfym16Rm9cfL4/bUO18Sjls
 EeMn2nvySQQtYTvw/6dxGLoywQxQXlB3KJgPtLFLpTYgU4A2M2G7DenEhGGwEo=
X-Received: by 2002:a05:690c:7093:b0:81d:6af3:bbca with SMTP id
 00721157ae682-81f4c37a8d1mr11663757b3.54.1784822114011; Thu, 23 Jul 2026
 08:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260723151853.2143177-1-bin.meng@processmission.com>
 <20260723151853.2143177-17-bin.meng@processmission.com>
 <20260723-seducing-plunging-ef7d4c60d917@spud>
In-Reply-To: <20260723-seducing-plunging-ef7d4c60d917@spud>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 23 Jul 2026 23:55:03 +0800
X-Gm-Features: AUfX_mza-ENc2gHXL57pFrPB1UXge9cWPqvHb4WnBi1nO7WAOzspKzKmMyv5-EE
Message-ID: <CAEUhbmVYdwUbp_y8TKZggoz7oNRWo7+sfe1Q+vbqApawp7jEmg@mail.gmail.com>
Subject: Re: [PATCH 16/26] hw/rtc: Add PolarFire SoC RTC model
To: Conor Dooley <conor@kernel.org>
Cc: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jul 23, 2026 at 11:29=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Jul 23, 2026 at 11:18:43PM +0800, Bin Meng wrote:
> > The PolarFire SoC exposes an RTC with binary and calendar modes,
> > programmable prescaling, alarms, and wakeup and match interrupts.
> >
> > Add a standalone device model with explicit MMIO handling for time,
> > commands, alarms, interrupt state, reset, and migration. Add its
> > Kconfig and Meson entries and list it under the PolarFire SoC
> > maintainer section.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > +
> > +#define RTC_REG(offset) ((offset) / sizeof(uint32_t))
> > +
> > +static uint64_t mchp_pfsoc_rtc_get_count(MchpPfSoCRtcState *s)
> > +{
> > +    if (!s->running) {
> > +        return s->frozen_count;
> > +    }
> > +
> > +    return s->tick_offset +
> > +           qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> > +}
>
> Just to be sure, this is done to match the hardware's behaviour of
> resetting the count when the device is power cycled?
>

Yes, the rtc_clock + tick_offset scheme is commonly used by other QEMU
RTC models, such as PL031, etc. It is not specifically intended to
model the counter being reset on a power cycle. Instead, it maps
QEMU's clock source to the guest-programmable RTC counter value.

Regards,
Bin

