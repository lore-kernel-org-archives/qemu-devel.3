Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF3EFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHILn-0004cS-F5; Mon, 27 Apr 2026 05:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHILl-0004ZA-1c
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:33:57 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHILj-0000Tj-2n
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:33:56 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64e87a81639so8834629d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 02:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777282434; cv=none;
 d=google.com; s=arc-20240605;
 b=A3wYExQ+i5M7+MGJpNqC/a/Vmcl8HaUk8PHqx7tFK/afzg2x/bZJHPDG5Fmysp6ufO
 phZTkb40s/zz097wW3mEdDDBR38QekC3lsVoaY3oXHMotghofqJ1u3xZLjShWsecALJh
 TI+KAXWWHPwoGcJYi2FITLNKNRltdNB5GDYw8M+mP2YOxzUn6A2j1ht1o7ZfoC56bXxI
 MS5++E9ZdtghgDh80d0H5Rq7/bRGLJMLJwtr6NBufKdjuj+DHMLdF/UOMNVXvfR7YSd2
 wDDI95ZTE6v4Lcip4W1ANEFnwMAwr490G6mepn4v5BzD8hmx5SQ5AQWbjVO4722EnE2a
 asRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WDMhoO4qmVr4TqrVTgUXX9ejcEjnyPw1rATst4OZikw=;
 fh=4IzuF9C3pNdo34KC4Txgez6wdqphsTMBlsFX6wjEZLg=;
 b=H2XpkuN3ofKHESwce5c3SQa3x4eFPg+sibj6VrCZzKbc6xnG5shg+1R2b7ejsZLc5r
 hs8uzXKbIDv2B9moF9ODLD1rDAuxWnZVsDl/WVRTVItEFmE4lodqMm/sPxWAn8F3gAJk
 mz+3WKzFucdreJYH6Gyc3X9Y7jvnxGD4RBschrOO26jkz0zmCPgXsVXfCRW1a0mVrFVY
 Zg9wqwqtGxJ3GlBKnFfYDMBl4wamZcmK5kk8pS7nvB5YKwOIgwNGXe/Ceu0nTk+Jt/Nc
 lvDiO3GGa1BKFfLGglsXZmyMvILxDryMmMTpQP71q5uGi2IWNQnI2G1hTsvHtLU2GoKC
 8pHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777282434; x=1777887234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WDMhoO4qmVr4TqrVTgUXX9ejcEjnyPw1rATst4OZikw=;
 b=URccwXWmqKqp6C1BVopoRAlzzADdmC63VL/SPbXeLQ8iFP43hdanaySML2qg5zhENb
 DOSuS1REFIhYu7VNKtyc18OA2zweFw66ETWYiA26HVqPagoH7MbhpZZmv7yU3MpGUCRx
 CdJEwrEkEmOLO9NcP3rfKVZ41FVhJLygKQPT06dJFn7KIGgd2EnAewcyyyqe+imQt05B
 gOoYHpaAV/3VOv2qLnsRyGhJIZBLpQ/zMRcVBKsPD93NvjMPngyAEqUBybM3zgoXp1Pq
 fWIDlwdSmLMCQ5C3UMC9gVz0KDvHhsk7RiF6GnQyde1sOzrw8FUwQe7KBmsaGwwD5tFl
 /dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777282434; x=1777887234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WDMhoO4qmVr4TqrVTgUXX9ejcEjnyPw1rATst4OZikw=;
 b=p5mhVxqHKQIWsTLz0RZBe/4YounYxWyXSFdjnhZUbaz4s9eFqLJbBnOta3rt8cuhJz
 nJagrFu3C7zKHS5VVyjM5r8KWTo4LlwpGAO/M20vagw2gWPSYPJbig0Xxj3WTd1iY9b8
 TcvfRkDiiGNHs1j+Jou5532ksrWK+35n3E45sTHX0DdJ5uC0c2x52ybFfd/69rsvEcA7
 wqNYIQXWBq/mrMM16e0Iw+RRf/Ba+engOJ+VBDNv+tx9GdcGBeEdNKc1osYnw5b8Z6n3
 LlMSqTSkfGRr/F5ML4R+bePpUrFZX3mbTfpVPBvAzunVsjz9VwB2LG6x39alEduRCxRd
 V+Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80heTdJ0SFTXYBf7FoOmECdUX/mmRcuUxQLB0z1qVCgO65InqNdRnCB7YNsmitMaidMeREijM1KZwS@nongnu.org
X-Gm-Message-State: AOJu0Ywj21vLmxgWDOEQthTA2YzdTjLz2mhkPf//fPFtMROLF0Cvy1iv
 638VnELfCHb0eYvPDvzC2DeBp9vZ756N8j0QgAKSCXMMUvJR2d3EjoZjOuKD1H2u77ANDWvfwi2
 Kjh+DAUSHxC2/qefj1KSlKVBDYGEGME/N2a+0GcIGUA==
X-Gm-Gg: AeBDievCGBaUJ+WiUw5tMbsvqDzAZK0RgRw/xTgQ4wTFIPbyfa00uWGsDIU74MmwAt5
 MEMEoK7ARa53OtYQtJw+w8/BC4z9kACFnkl7JpHU2imVasEmNgy7CZhjoCTljndsRWMSfa41mTG
 FyQv9WUuFvrUMRQrWfutvg+V0qtgA8IOKkN4PCXa/i9Dr6x/1+FgBfMtq1yzNEYkQM12CSFHc8/
 geBubHp+wzKfV5pshPnswCybGgeQWcNeXvCbHg06E4a+eqQkwjUWgi1ULiZlvmOTbCqwELXFm07
 G7G8s1DVFBjeEJtYdoVGiNPsoEoSzs5RLCTauUlJF5gOrOrV6jhidXW3XBnGXSAqCtsHaI8JAc+
 JOw==
X-Received: by 2002:a05:690e:4191:b0:651:cf43:b28f with SMTP id
 956f58d0204a3-65310b0b5b6mr34988861d50.60.1777282433964; Mon, 27 Apr 2026
 02:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260420140552.104369-1-eric.auger@redhat.com>
 <20260420140552.104369-2-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 10:33:41 +0100
X-Gm-Features: AQROBzCEfYlKMO6BLPiKHOze75SAjM8txBCN60gETZmHcEIrSyNBM-3rvsVv1u0
Message-ID: <CAFEAcA9kVBCFUwAmEQG7gK0F69PXFyALUsouG5w7zJQYzsx=Zw@mail.gmail.com>
Subject: Re: [PATCH v10 1/7] target/arm/cpu: Introduce the infrastructure for
 cpreg migration tolerances
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 cohuck@redhat.com, sebott@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 20 Apr 2026 at 15:06, Eric Auger <eric.auger@redhat.com> wrote:
>
> We introduce a datatype for a tolerance with respect to a given
> cpreg migration issue. The tolerance applies to a given cpreg kvm index,
> and can be of different types:
> a) mismatch in cpreg indexes
> - ToleranceNotOnBothEnds (cpreg index is allowed to be only present
>   on one end)
> - ToleranceOnlySrcTestValue (cpreg index is allowed to be only
>   present in source if its value @mask field matches @value)
> b) mismatch in cpreg values
> - ToleranceDiffInMask (value differences are allowed only within a mask)
> - ToleranceFieldLT (incoming field value must be less than a given value)
> - ToleranceFieldGT (incoming field value must be greater than a given value)
>
> A QLIST of such tolerances can be populated using a new helper:
> arm_register_cpreg_mig_tolerance() and arm_cpu_match_cpreg_mig_tolerance()
> allows to check whether a tolerance exists for a given kvm index and its
> criterion is matched.
>
> callers for those helpers will be introduced in subsequent patches.
>
> Only registration of migration tolerances related to cpreg index
> mismatch is currently allowed.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

The way that ToleranceOnlySrcTestValue allows the bits outside
the field to be anything whereas the LT and GT types insist
on the bits outside the field being an exact match feels a
bit non-orthogonal, but I see why we do it (otherwise the EQ
check would effectively be a "check all bits match" check
regardless of the field mask; as it happens the only thing
we use it for passes an all-bits-set mask anyway).

I guess we'll see how many of these we accumulate and whether
we want to adjust the kinds of check we do in future.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

