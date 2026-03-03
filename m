Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9145AEC1432
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxNvo-0007mg-U8; Tue, 03 Mar 2026 06:28:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNvn-0007mE-Nm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:28:51 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxNvm-0006gu-92
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:28:51 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so5756269d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 03:28:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772537329; cv=none;
 d=google.com; s=arc-20240605;
 b=StHWmk/SK2IrODYAV+0iNBKOCxQRBECkVd0K47hQ1LD428jFyVaRldyeP8ggtvnVZW
 m7rkv58qgN6V9CjaT39dAmBPhlWjoajT+OnI8+o4oUTMWl+kvxcHdZStQuWtWAiYdZeg
 UxpeXP/dUul6Iafrw9lpXukPtLt0wlWaZgeGEi2QDEqCDyaIlZuKKmr++dZ9+qcpUS4k
 R/+h+9U0+jhkAv3Yq+NXohi3ZisqKxgqu5jdePxoiQEg3gzVLzzsq92aVofXz+rt3zMt
 ifBd1sF2ZOySmUNEs1B3YGkZ6QcMqlEEX6gRBrSr6omn12M9wSDfANv0aZrW5yN80X1L
 SJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+2b6TbtolqEqUHYCnJaMhaWWIYLpTc1S6n8wYDRGc5Q=;
 fh=e8lPG31nRq0pa29+ILZPVpv23pShvDc8zQNyomzI6HQ=;
 b=XNMRgzpP0GoQrgq8TbyXGfKNXERcT8SrOQLHPdHBDISHR5/EFBbbBXpkYMcOv+Sbfa
 LrH1Y4j8+7qBjN4GPJIE3JUdGQpWsXNXbba/3ZIuoq6aV2Q2gB8e59Y9jtqbYZKIy7Bu
 TMI9u9V74/F5cfX2Cq093TgCRy8s1YjmC8cCJcHZdmKEZLVSQ3x9f8Yeu+xlMkZyYv11
 LfvvFucmyd3/bFqy+TOX0D/sew59RPFhsGTy3beMlGlnYTgyjVU6F+aF4Mwg6Lodu7eI
 kiXO3unusC5tRXr5wq4GqFW990kE91mLHxda+XCxnyLC/f6kqTJkCuRb9V2ZlLk1Km5F
 3mXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772537329; x=1773142129; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+2b6TbtolqEqUHYCnJaMhaWWIYLpTc1S6n8wYDRGc5Q=;
 b=EMjVTD6BKx5zJRDFMR20Fhl/G2mCMn9Vhiy7bUk/wUzHtlTPasKQHWpxphTXppYWcN
 UTn9x4lgcnmOIv5hCRI6GTwApHcmEO69BIZhi9DgglczrQBZmYXg2yQ0x7jN9xyJraY0
 ueNz72ul+PJOxeDsN8dyiMZCdfneVAGGK1VTTEb7erskU3mRYqntWCftok0UzCO81DqI
 aO7FMwdJyW4vhXASAzfh7aj108tUbQTvm86wAnjQHBVOYweaXQbZ18SowJJ2buMDida2
 HLISfXkKQ/HYmjREGjJN6+gkNaynosL8rqb4nPJMKkvNkILvG1HLVZWVFCS6FY3d/TAV
 Eo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772537329; x=1773142129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2b6TbtolqEqUHYCnJaMhaWWIYLpTc1S6n8wYDRGc5Q=;
 b=Jf323qM/GNHp2ferJmYHLDQoVK9TSTth7d3GdlxoVXnpYna3Mko72hVKPxw1gLTxKU
 f42CSpkHkbevkF1bcGuvSVD4nGDirfhk0UJJNQglayjegMDdCd6MQ70fiTcZ/eaGzWZh
 Ha729u++YmtBH1IAg6mtVmTa8m53V0X/G2PtiU3RPcKvaNU8uPaLCN4uNtfg89UlmoK3
 BPldUgVIbs+fuBCm1JY2rBoLh2EXFexBhygVeayMnFNDxRVIRdprsLPtKcLHRyFSUKpQ
 U1P3mbuT/eaOeY/sB5UZ1pFVUwlDAQ3y/EY8z8pcgJsxFMu+tJ2zT0EKSxBFctTG6pc6
 3cxQ==
X-Gm-Message-State: AOJu0Yy8VdnfMq6/4rXQUURGivusGNi/oRFt0sUv9lpQ4pnRwA3gQKLl
 46Ib+PBMa1CZQTMDHK45waJFEnHYAM2znAaYmRadfjpUYxdVi1OTMMxWjXZbJpkas3OFfc+s0bq
 uSpd20r16QPKLr74VPVpxU5yeJSltjp/M2/n2YVqLdA==
X-Gm-Gg: ATEYQzwpvcOH3OKnU/vXdrW9Y/1nmM+90mYYMgq3tY7Ye9kCnkfdHGyKKHylpepk/Ti
 NTzysQvempdbkorgXpA7o76MnOHYYCFeuhcpL9i2zw7/CWSbZzLscAcyKDqMadURA+HHehIYlEl
 bgMStEl7pHY6mDZF0qt5HkHDtp+3uDJm98Admbac3d2tw1gnAWod4QXNxDxnyVl/xhI5CXqU4Ka
 dZi83O4fUQ7aiuVrAYEKMK8aZCNri1F2P9c8uTMPpuUwPGzOCNuvDj4BP139+Zt0nftQghyWi8v
 Nb6u/k/l6xWS9fWmcdeIvHxG98O7UY6grK75mex8nrIX7B1dWXvh0pEXiTixMVD+fvs=
X-Received: by 2002:a05:690e:bcb:b0:64a:d3b2:d3a2 with SMTP id
 956f58d0204a3-64cedc262e0mr1043496d50.27.1772537329295; Tue, 03 Mar 2026
 03:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20260302220254.1166849-1-shentey@gmail.com>
 <20260302220254.1166849-7-shentey@gmail.com>
In-Reply-To: <20260302220254.1166849-7-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 11:28:38 +0000
X-Gm-Features: AaiRm52xJmXiTl3H3wJ3imUf6rNuejBCuaWciDbNh6ErOqVpoz8mJ_vdO97cyI0
Message-ID: <CAFEAcA__4Tc=QzZb4rUwWEE2s9naam2CawHZVyE4oy-GYMLu5A@mail.gmail.com>
Subject: Re: [PATCH 06/12] hw/char/serial: Add constants for Line Control
 Register
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Mon, 2 Mar 2026 at 22:03, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Substitute some magic numbers by named constants for slightly improved
> readability.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/char/serial.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

