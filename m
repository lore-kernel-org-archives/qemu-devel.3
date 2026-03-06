Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39191F01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVI1-00048e-Bp; Fri, 06 Mar 2026 08:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyVHt-00047m-LR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:32:17 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyVHs-0004WS-2b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:32:17 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64ad46a44easo8169505d50.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 05:32:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772803935; cv=none;
 d=google.com; s=arc-20240605;
 b=BlX0CHmPRmjxjPOx366GBOz4ZTh8rw74JRYHY/tDNwkplguoGLzoTOm3+7c/uDeoHe
 YSzIMYjd+PVf/Q2Of7P+RFGYWAC9FcxqSSwVocCwgam66/Bm1QP+FTEqts3h2HoE69uQ
 Sd/nlAdInPjW5bR1n/gB8nnR3jexu5JY8FyaSNckk78Vs1SkTl41g8RVZ+gNlUA1ICaI
 8YAfbLiwotPYFyEOtaykBIcZxBPMLUk7aYd1gp+WAFrya97UzBYkAUZo3unnw31DLFGR
 TXnbf7asCjG+cc39VeiiCC4NzFr+ODO4EB76VehtadiMWsaydcX3KcPqvhE6VaxLqq8X
 ErVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/2aL7EZzHA1Hp6SzmIMbOvN3v1QTlUg2peaZ7iAtZDs=;
 fh=jUYsI/2acYShRiXxoUq/Pm9LQcAd+S5Ayx7Ab2mBfmk=;
 b=j9INW9KrG5v3fbe1y60dHnXJW5zrXM7rTxglYyWmJTy/lql3pRV/68vB5V9utHnR4L
 wbca6C2GpZFMA/B2m2QeHeRmwJ6fNa5Hh+lAUOTDadYr4UkNBHQ/uiNdYqPzMXinAfHf
 xNrpZ9x7YMxigOrCL5mS0ODVbKPVvAOePKJxcljWq+jLf2TptmuY8fBZdMEh8asM7Eff
 cWUmzHOVtICazVzPBSENPBaakwWvSSq+O2VYFHs9Lu85G9+0rJCMkaxhAKc9xMCY4uLX
 7veJjmEHLX4t3s8EFoG6bSSr3msD0ZlqO0g1+suPbJRifobUoTiBXRtmWnaA9BlIDzYy
 9siA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772803935; x=1773408735; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2aL7EZzHA1Hp6SzmIMbOvN3v1QTlUg2peaZ7iAtZDs=;
 b=L0R1vFyxIin5wLCjVqcFmmJL9uDYiXP3rr0wQ6BYf4vdeDVb2EvqiZz0ATDKtdbyYP
 hqjeDb/KmE6K4LeZHAJt/OtXG9hDGCKd6BO6vV4Eb2KSbUng+YTL3kI9kN2riDh6hpfs
 WIiulIsIMjy2eprG/qJMhvMHfXNUii0qWbaLV1oM0kSZt/gch2OIgJ87V43hNAm3CjJJ
 4H3PvojfhnqNa03Ir164UZ2hxhXGMjDGOPKLsXFwS9oJcjdQFKubv8+txxuODAvDbyiE
 oxierzngh6MeZxH5Ng+AmJ4rptPN5cAeD4wmwNpJAu27B+nVgr2XCIfDoIKD/BBIs5iC
 7wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772803935; x=1773408735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2aL7EZzHA1Hp6SzmIMbOvN3v1QTlUg2peaZ7iAtZDs=;
 b=LLj5WV2VFzTwkzFOnUPPoPweKj/pMf+m7/CUS4cBUjUo3XrYOm5dBgjTIzv/U5ygAN
 i9E9NiTpJNwezre2nucG5T2pfqnSnQ6VWUniU2B0Yro6PZExbWRKpgmXfORNNfluejBm
 mQ3Kynvq/HkzVcteLqTKG9TOY9D/0uOZf7pGd/Dtas9/Da6jQWwJQCejZ+wrOtCWyOBw
 QQU2H5dHgT+5UcE7kJNAPHqswRWTqJ5B6+z1K+jK5ejZ1yi9KS/zWBUf7iTd08VCav9f
 GELjxstSfgGcEybKUGLvR/K8kqPAiJEapC90DqOTEPgCINhAqSU7vpy1k85+rxXByeya
 byDA==
X-Gm-Message-State: AOJu0YwIvk5eq6eA1NveKjKAQQdKRxiSnMvKhxhdwz17flEpe7BcSjLD
 4Ecz7C7eNZTUfJ9x4Lya4I1j9w2U1orR9ce3OlZDJCcFNRPKQhYyKd24E9SPP9EFvjxO/5O+vH7
 eWuB3jbxewtaTE2F1MYLPwEs+n3Yr0WPEebLCzPmXrA==
X-Gm-Gg: ATEYQzyxE5pHE652bSIw49iXUcZFyWAXujWN0vu77QIbR3laeB0Pi3LnJ7XnEzw1xk1
 YnmXT6ZmMcC2zAjd/b3g2V+wpK+d+82MdOny12t+hjGfw8FzhSXB6xaU7ANRavaUOwHizzj5e5g
 PaUGwivr+UP3HlUMHl0aV03zhIUqDC42+i4WWS80JmO6tlxziHLg0jvESN9V6CnvxFxkd4tytts
 +K5jSs0V0w27XflVhGDWPRh50qinECG0qNb60f1EiBqdsZsOLtIsOMwvVp9NXEWxl/pUgdXy6pK
 s0775NTjOqcSIKSDEboKXN3055Ceb8UJGa1i6bSolbfzsp14aDPaXER5GfM0i23zC00=
X-Received: by 2002:a05:690e:11c8:b0:649:cd05:c518 with SMTP id
 956f58d0204a3-64d14279849mr1817458d50.44.1772803934741; Fri, 06 Mar 2026
 05:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <20260306130107.35359-17-mohamed@unpredictable.fr>
In-Reply-To: <20260306130107.35359-17-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 13:32:02 +0000
X-Gm-Features: AaiRm50XBVwi8EKKem2F8piMsmWRsUTVvToqOQBCkYFYKgT46LOwJMseXYcO7Kg
Message-ID: <CAFEAcA-bh0s0mkUEsunwDRAjRsCDJaJkzHToUg77e-6X=ejbyw@mail.gmail.com>
Subject: Re: [PATCH v15 16/17] hvf: arm: disable SME when nested virt is active
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 6 Mar 2026 at 13:02, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Currently, Apple doesn't support the nested virtualisation + SME combination.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 3 +++
>  target/arm/hvf_arm.h | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 0183dd8a60..61ba5acce4 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1181,6 +1181,9 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>
>      if (hvf_nested_virt_enabled()) {
>          FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
> +        /* SME is not implemented with nested virt on the Apple side */
> +        SET_IDREG(&host_isar, ID_AA64PFR1,
> +              GET_IDREG(&host_isar, ID_AA64PFR1) & ~R_ID_AA64PFR1_SME_MASK);

This is
  FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);

isn't it?


thanks
-- PMM

