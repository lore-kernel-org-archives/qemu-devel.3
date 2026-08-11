Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF88C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk9N-0000pq-3C; Tue, 11 Aug 2026 06:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtk8u-0000XL-No
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:38 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtk8s-0000OC-Hz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:36 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81f64e8dfbcso43857717b3.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786445733; cv=none;
 d=google.com; s=arc-20260327;
 b=HPqiBvvrmBznz1UOlGQtpjCgE4KLImMGmhfHmssaVVgy6TZCdpLgac+nsAfcNCYeql
 D6rcu6hSmyySYZ16HrF7a300LrfVEmh1FxOa5qsL166eOxz7rmwQ/DFmNBTV3hfb3UI+
 kfY0BFOolIWrSihXE69TozKSjaJYwYSQe2e/Wmi2WfqF+lxONyFr0OW8hGB1TQS7KmLR
 f0B0DouHYT7B4pjlr6O4qafoFaHeoti3ThO4SLOgx1V4dRyA6yFgcH6zgXumDsUIeQS2
 AcEANy8yQExAuft5f2W9Cp07BmvkKihYne9eqgFziVx6I/lPkrMNv9zfiSJPL8U0mSQa
 3V2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WZ3wcahnXNlAgbdHHJ1r5HEIC1YtGEznpsZJ+BBGOKo=;
 fh=iwudhItC4xSGmiIeYfsKWTWy7D/x/N0NDyvs//gGYeA=;
 b=io0T+zE/d2xxxYbayJlSBiYckmDDO/VFuHwTbx2KvXetyR30eGYJ5eWHtfNLaQ6ClZ
 2aRVMlT9NonR+qyc2m8bJkbcCHVNo/AVTex2/U9fm39CIOgTUkBTLE25VpFxMn+ybX1a
 5IRNDSrB4J5ztVfS7bACjd2sXu6d5yGD8jh9aZ5C0LP49Yk8IM111zwj2x9Xy+r/jnjk
 n0HH/z7Lk5P+Zck7SlVH3UKxvK/6R4wUmp2el/UXSU0vtJ7tKFws6nH30c3lv0W9ENPN
 W98EKlrRyfS9cL+01nedMZk1bKZKA8bpv//tIvdjdm29JP+01MiVDT6rfis+AEVfJ8AQ
 C0LA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786445733; x=1787050533; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WZ3wcahnXNlAgbdHHJ1r5HEIC1YtGEznpsZJ+BBGOKo=;
 b=pGo7NSClY4Im+djV5jm/0o0VbNWM80ufQ15nBqn1kVz+2peBnR4t4k5HWMLiiyBTH5
 rvjSQjLjbVH0LtQv0W4YFEgDWXLt42nHayLmuzuIeeYb1MGdWAgByP6qLCiaFpPr854k
 Jax9xTJN5X+KUNWlN1P4xlJF49NUJqgd8sG4sZDFvgfcQrC9h443pNd6ABn7Y4X8lTuX
 tgpM4XlbogsUF1eCjpB+/pOrnv5JsWG4Wv8h+kC3NaF7Jx5b3PNvjju5oS+QDbk5Ymo6
 wqITnsCYzP05hKJcM6Nz+U+GUmV1ngMIYezsmMYKCxeyCJb7rRcyQdO5UYF32ejDQSmE
 qlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445733; x=1787050533;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WZ3wcahnXNlAgbdHHJ1r5HEIC1YtGEznpsZJ+BBGOKo=;
 b=qQcAVI/0m4pZdAybwfMetonem9ncgD3CUGXnD/14PuaHXn5Ib/rRYwRFvJ7sD8n80B
 QGhFnUI4HN5rmENEh+9c0yqog0EqdQ/0Qgc9F5QJJko51Kt2HWfc4SZ/l/cGYPm7s2/c
 bQGN6cIubtx0FLvE1sR8VGEFtwuCXwffzWmrwIcUlck28k5xd1D2GkVnFd044qS3DpTc
 p+gc5ervITC8aVsKaJcXiaU5pW81d8VDrMXlm7XQPjR9JQkDeIus01NxAlUG6jUTPg2x
 RYmZtCTU7kSod+YaTDWVc5oIs6hiWBTOIn9A3z8JNk79Ylq4lKiyRn5ZsfUQyv1Knutq
 SxUg==
X-Gm-Message-State: AOJu0YzYgzl6ZlhX5LSx+Yn9+6jDUyENW4/ePtZLoDn2pbt+zIe3rsX0
 cugmW3WM3M2Wj//TnHcedH9XnGvTjCA72HjJdGvOpxOgyQTt+mclLTmtWDO8VMQCSoLEwLdUII0
 5EI1G0dhvTR+K1mb1lZw+PKV7awXfXRy4MBhmj1J57g==
X-Gm-Gg: AR+sD13vDqMlerJ01698ok6yP0SaFfZfWqPU7KfC0VQN12JdZbOIRgnv8PIXssHL+4M
 2aJhIfinRRcH1SQ5KOsuWpDTvXMKsxZm/rA0OUEWTZRgOU4txxwbiI5ylgnKrA7WvRLIXH0TrmJ
 cjbQTcBeh9oJr6uhhNPlOIlFeG+S8jdTZVilDRDLopLfT/9/yoHIacn6SXsIqOzCEsuhfG+jN6C
 a65unMJauDxJ0FA+vZPL7zBWSsgit+ZKCChxlM1+kA92nI9rHDJs5v24RT6o2DBEh2LfPiq9Fec
 ZgtMRoFZEhTzNPR3XMz0iK6yZhptlSaEzVEyQaL5c6slUaSwTAGUsF/syy5opYacP2gV6afJhf4
 OMplLUiClhAGt3cV6/P9ae2Fzt3IJ
X-Received: by 2002:a05:690c:680e:b0:820:132b:6309 with SMTP id
 00721157ae682-82f2f9cb639mr15384167b3.35.1786445733261; Tue, 11 Aug 2026
 03:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260725231142.61663-1-marcelomanzo@gmail.com>
In-Reply-To: <20260725231142.61663-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:55:22 +0100
X-Gm-Features: AUfX_myK-7XcBQfqWDo6fQ2z5EUWa-bWZiwC5hawV0ImSEhcGiljoQnIhNM0iaE
Message-ID: <CAFEAcA9U_y_yox+h6zW-rDeMC20-t5KWmD077vg_sMca2RwewA@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm/raspi4b: fix watchdog and GENET bugs hit by
 modern distro kernels
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sun, 26 Jul 2026 at 00:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Follow-up to "hw/arm/bcm2838_pcie: make PCI device enumeration actually
> work" [1]. That series (plus the GENET/RNG200/thermal work before it)
> got a real Raspberry Pi 4 SoC far enough to boot official, unmodified
> Raspberry Pi OS releases end to end under raspi4b -- not just the
> functional-test suite's minimal 2019-era kernel+initrd. Doing that
> surfaced two further bugs that only show up with a modern distro's
> systemd actually driving the hardware, both on paths the existing
> tests don't exercise:

> Marcelo Manzo (2):
>   hw/misc/bcm2835_powermgt: implement a real watchdog timer
>   hw/net/bcm2838_genet: fix per-ring DMA status and RX ring selection

Patch 2 is to a device that's not in upstream git yet, so we
should fold the bugfix into the patches that add it, rather
than adding it and then bugfixing it afterwards.

I've taken patch 1.

thanks
-- PMM

