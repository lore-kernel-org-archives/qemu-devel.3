Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC46ACD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZ3c-0000ph-EZ; Fri, 19 Jun 2026 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZ3X-0000pI-Ql
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:14:47 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZ3W-0006EJ-EY
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:14:47 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-662bb8b1f93so2065642d50.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:14:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781874885; cv=none;
 d=google.com; s=arc-20240605;
 b=Hg5aGdRKa7wslNTBa4cVN8p6L5HwSEnFJTz/PcKOGVOxS0me8/u4uFt+atz2zEgxhy
 EIeqm56dj3d8A9TFBHO2Eq2ZYaPqqWnMo1nPGiwUPQJQJYgOmCj7c8Gdp0FozsTFG1qv
 urwPIlJjdbP6Ozn83N7EJUAtSlMDhCnedne+r0JmR0WfiZbV3Ez5QMarj0UkKywB3n5X
 wGn2KYEUqHhzIZPjJUyX5WAXuHMaHKEwemCZOq5Gax5qiRfHpYsUcQ5MHtpjjS3B3T+i
 GLy/0jWuUI6OKvyXksEcdenaDVGE0oVuYr1OsWAghaQ2PnpGhhRipfWNduFT5AyEVrIl
 Vv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JjEqOBx4XBRQmpZWps6rk9/oRg3CowveChr0GB1L2fs=;
 fh=xI+f3cV0+eCVjWmeQZ75vTRDgvX17Dd5Ehccp5/eVJY=;
 b=EJuskLGrvM3dbx5q2DkGweLB2t0J17TrxdfhTBPKEKzDrEIc+CFggMsu6BmAeT/CS+
 DA7x7ke+Jvg4B1tKil63tvxoctrFH/dVMjpABXoGsmcV15DFx6Acz6iyZXg0F54HkkvY
 FpHMEe8a0E7/9c1J+4yM+eEf8jMJ3of0oh7lhcnQxDDH5wKlMP6/oVF3ivYfcnAKS19T
 eRr6wrHQ+IPzZ/7m7jYTVFOqBqYq12JFGe3egqkb5+4aGMmPxcM0S36U9LmuqOKT8SZ2
 aj+Evo5M42Vk+gC4DdXYiwRcfjwrjq3hDkgGctbW0NYsf/BIMRG7TAQu7ORqj5bhI6e5
 Iwdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874885; x=1782479685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjEqOBx4XBRQmpZWps6rk9/oRg3CowveChr0GB1L2fs=;
 b=nb6qDi81L2pKt+RpRRHOyyuXyag1X/eE3yPmormzyelk7xWigNUNahq0SUOX8A/xbr
 lWaYC8mi7PdZ1ushPqjQPj2S0GN0yhslH99EJtZOMCaCw+EYdcHcVh97VyMXKZ5OLd9f
 tpdPMOfYZc9aqoyztUewJ2NnPOsbiazLoCuxGqe9Y+G1vUaknHDQZMG6OWbQVqE0fbzR
 5+WBPyktFBGHKynlBo/yPmtRTJ6binpty5Jdwq0E5vzGTKaithQwX7gbjyIuy42y9G1o
 J7TL7s8Xxp+3GUg/PBugS2wN6XvGbYHYxpE632+jOyaAd8lPluh0yF4y7m8BLlRrU5Ka
 W5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874885; x=1782479685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JjEqOBx4XBRQmpZWps6rk9/oRg3CowveChr0GB1L2fs=;
 b=fSTRI+K/GPTFsUP7Sb8GIaVyCmukNiWV00CThew+bZM5OjVho/JMgoNJjYz/geHuLm
 To+6+dSlxthLBRYSt1ot1cjOdbGzcoskppFR8tprmDjog7F10bmoC5Af+q/6FJukHnbi
 8sKmIOA/SlVOaw+oaFV62XsYLqKC9UBml+EPAq/xdm/ZCuWLooJgUHYsTgOkm4dEdF6R
 fXz29CP8mQOFL7Po1TQp8jEdnnsAU9V2r3mDNlWryjJAfTdJWfsm7yGA3zV5baKNwaCe
 AJa/MSjEN8Y8xeiAT5nBSQOaub45X4cr3OTH/7PMKiwsZM3OmGKYHqtZkVLtHEB8GFqG
 wyqg==
X-Gm-Message-State: AOJu0YxPE0+BPPpFt3RSnNcnWdYXGelH1+mu+PF4g/3CUyEmhClTnXi5
 DFHtZSBmzqWA1FmFwc1cV0HinA/ViwfqCf9qh2jOm1oooEgIsM/nYKodER/cYl/1G/xCGoDZUKV
 GDe49XAz0R5MWojGhns1vjoFIPGgAqFivRfPJkDb1kQ==
X-Gm-Gg: AfdE7cn1ddGDNn/1PC9xg71h6hKqao7panPQFHDmbx5K8fY2OCpnJI6AyjZ+EjcEwsJ
 Lcexrnqu7HoU3zltn25rV5HSQ9s8dgpWJIN/MKFxNhy42T/tz9pq1fEJyMJXNMvgvhFgUQPoXcS
 ZjmURTQr4Wag8yRQRRlLumHeJsQkG9ae1QHiHj6mH4DGs42DXNILBKJL+Y3i91ef6nigTFlMVDj
 YA0gqvI9fwBRfril665xWBY8bZIcK64xN+zbOHu7prdEu25EFTob0nqAiRp6EUPPJKLTnjamm83
 irBJCTvVupizDq8jdJ8OtOjHMWUaLThhQyC55i2sWzvXWg8zQcaZSDS1
X-Received: by 2002:a05:690e:12c9:b0:660:4090:90e8 with SMTP id
 956f58d0204a3-663030d63cdmr1999344d50.29.1781874885105; Fri, 19 Jun 2026
 06:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260619130537.820184-1-alex.bennee@linaro.org>
 <20260619130537.820184-4-alex.bennee@linaro.org>
In-Reply-To: <20260619130537.820184-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:14:32 +0100
X-Gm-Features: AVVi8Cdq18FzEkc_gHexW-klQUyn9uNvwzjyRrER_rbWwczZhnhBDP5u_klSlxY
Message-ID: <CAFEAcA_rnV3Fq0Qp_XfNRn9p970iAXzeNMD9VJiE3sW+PQ6vVA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] target/arm: do not clear halting reason in
 has_work helper
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 kvm@vger.kernel.org, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Fri, 19 Jun 2026 at 14:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The helper will be called multiple times as we exit a loop and until
> we actually restart (via arm_cpu_exec_halt) we should leave the
> condition the same.
>
> Fixes: 6fd2fcdc61b (target/arm: teach arm_cpu_has_work about halting reas=
ons)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/hw/core/sysemu-cpu-ops.h | 3 +++
>  target/arm/cpu.c                 | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

