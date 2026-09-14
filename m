Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE8BC88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62lM-0008IP-0Z; Mon, 14 Sep 2026 05:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62lG-0008IC-Jp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:14:02 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62l0-0005ee-LF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:13:49 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-86382f10801so4886207b3.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789377224; cv=none;
 d=google.com; s=arc-20260327;
 b=q/1s9KIp4VlvdYC47c15xgxaCw6bhx4pcFJ2U8ltWmP9uF1grE7edL/wcHJBCvykvl
 mIKleZe8m6Dt3WniQ4+A+8Nbwt3E7DkQUneXbrL+o/Y7GEv9xOQ8d2P4emSZw5U4dw6c
 2DNRNe/BPNB8v7AmcKyiC9g3fMQx1l0dzoYhq/GOifCRsNZqIyoOW0CCoWAylxFTttbK
 1KoYG2zz694yXe4fcTHJDMidLp3CUWwRpO6INYE/c/OWNT7DO4RDfLFNGrXqws/+T1Kl
 OY+JyEU341qFIt/aml+RMC16qKZZq+pSB3Rzbh/C0yOdLWW31um3NWWu14HHv9co1Ohu
 4a3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZTsXqccZnn67dqHe3rEGu11j2FVDgwpzyyraxrGZuOA=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=jVOuXlBV+KHuU4UnsU9tY+qjqigig4cMg0Zm52f2/vgciddv1swk0cZFTaBMnkV/0W
 gqepBqWft4W0/sKN+kAVwTfYLkT73iBtBxOLxnQFg0kAZoDcVUBvyz8o7XKzlDAZQM0+
 bQGLWiPnApkTd7DEzg7JJmFvmpogIDe2skpls8IIK0mvEjyRU773byb862k24xlE4BXJ
 uY3mF/PPLVwXE8E9LNKgb6tthZQinlEBsKh937UM4EefJmCrKOF6joDGX9t2kt+f/K5F
 U/bN7cq1E93Zgj3V2ibeWepCUflWEd1HGJrE+NmLBd2t46GS5renHWCXoGsGmVC4hNJT
 H0qg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789377224; x=1789982024; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZTsXqccZnn67dqHe3rEGu11j2FVDgwpzyyraxrGZuOA=;
 b=w/HvjE8IrQVYCeqXO65kQxrp5tIad1vo51dhdg2HVH96GumQg1Zt+L+TVJ270VhpKr
 shEdyCku/58v8TPeT3Pd/MG4H1RorOkvrnqcL+4sX4g0FPWmrsLbiedL87XvKSYTykt7
 IhCHylKycrGvQ7bJs5SZfWM2YJWvgiRwqfjTC8uN8Yt5S3o9B7GA+wfjiBd+F8VI1AIg
 2FTXG0MYlbI0Umx4G2qyFs4HIeNFiL5yFw8ffK3hqd9ttR57AEnOAegVn8mC/qyXO5eL
 N//7Vf0lWZuJCl8UZaEd3vkR0qP5eiz5Y1TU+QfetC23dMxDPmfQ28W+eRmRruAVMfQD
 es4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377224; x=1789982024;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZTsXqccZnn67dqHe3rEGu11j2FVDgwpzyyraxrGZuOA=;
 b=FmSQSnCXZ1KJjQ1WkV3gg8yPoNdmTEueSiBk2RcSCJTufhw1ygMpgTGmimGMEc3QnF
 a2cogm3dEGrMtFWGG/TxaxzkgJY9qcLs7jetQVfjh/i0Z3top0M1BKr6YFJP2BOaKhiR
 2R6wJpGpxSTKMrrjsrhf5JfgSuXTqf3QZbzLm+rU0UzQaq+Rted//kes8fwDYTUATudE
 mV5c4IWE2DVq1/n2i3CBwNWKvAStrcBLHy8a3ACdsXr/zS+Wu/hXh+fm5cm6CjLCVgcY
 Zna6PRY8SudroOW+88DHPsgSbDP6bveGBGTiFfJDEDlwRn+33kEKY1UksbuPH1Mcam/E
 euVQ==
X-Gm-Message-State: AFuF++kBpDoXjNHlyKfYsJp0vSA+CIFxF0ob0I1DASzrEnM9U5ZovJlR
 ObwshZjS43zt46WsliMxXMrQ0cNpFpDjQFkCuyXnsZLXjOXzht0aMGQXUnCbtmwEheMkMp4EW12
 9L/uXe3Wm+b7d79Do5MDadOuKSI6nSDNJ7a6OgoY4nQ==
X-Gm-Gg: AYBFou3LiK0JkBTJw5BrrbpWMihBE3Bxl3KxsJqtZ1FvY/tYx6/uQzIRVYxUZv64GXP
 LZ7FdLzEU1C9fo7CS4Y/FM1pyVyw1B5jnUZiuit/KtuqZo4Ot0T6soJ49JGBfu0VMhqyWcYF2G0
 fMm6lmlOhvA8YxF6sqkNu3zPAnUnKrqB1q7IUbcIWTVLVYb/qqHTlunTN2pOVHGtR4RMkJKaN1w
 ZRXcyXBqQXEk+pvE5nS7vyUs9SbhSjr7N+LKhy3pY9d6x8lT9XgP+OFip51HDReepAeRX+SiLuG
 n3jTWdeaH+eTvtDng6jq6emS9j7ImHXDUzSIZ0a8dKdpZcD+uMyMIqFg3WJMw1ZrJKcl/K3MAJC
 L8tZwIP6Pz9NhSQkosBF1DvxeByfh5PlC3D3pOaM=
X-Received: by 2002:a05:690e:801:10b0:671:3d20:c2de with SMTP id
 956f58d0204a3-6714dba60b9mr174275d50.26.1789377223883; Mon, 14 Sep 2026
 02:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
 <20260906222551.3712954-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260906222551.3712954-3-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:13:32 +0100
X-Gm-Features: AcwNN1UpGbu_vKIWVGLa-JI7cl9Q5ZgNrkU2WZbWnlItt_LVbJj0cznRDIdoxGs
Message-ID: <CAFEAcA9m21oDgdGXdbFHfj9Od1a9waj2Aopvpka8WbpcGuqEUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/hexagon: Fix semihosting STAT filename handling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Sun, 6 Sept 2026 at 23:25, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> HEX_SYS_STAT could pass an unterminated local filename buffer to stat() when
> the guest string filled it. Use lock_user_string() to safely map the guest string instead.
>
> Fixes: 7711fdba88b ("target/hexagon: add main arch-specific semihosting operations")
> Link: https://lore.kernel.org/all/CAFEAcA9MOs6VfHf2UHZ8z4cdvaB+7DY6hJb2emYZ2aLSe-t6iw@mail.gmail.com/
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

