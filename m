Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC20DC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQ2F-0004Yv-UO; Thu, 18 Jul 2024 08:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUQ2A-00040Y-7f
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:14:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUQ24-0001g0-Ae
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:14:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-367963ea053so577064f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721304884; x=1721909684; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9qsVsg1ViojjIwgSQ0F58P2aHMMy1cjG85swySoOl7M=;
 b=azSqQdyH+cENJeVbzu18sruL8A6KBfoCyFpAppbBOH5Ck9lH4Q2Jpyu+pUvxHVcaf2
 1DXVkv1TuJdZedCh3tuzrsjyVTc756sIW4R8e8IB4aZXzvH0p5lHL5tiI7srMrzyoxop
 0hH02k1N+vJUhrW/f3fOwxiQnYdLWPndbZdBHBVPDUiuVwZNDhBMdulkCTsgCIv9X7z8
 1pB3qPYpKq9uguVkkI7J0IZWwSCnawqC1uTtlJE0EsFiOi8n17Z+vca5aE+ycCAcZqmx
 Ez0wbPfGe3ZRWGlUkwBqBygV+dyZC+mMUUHSdDGsAnx/BQDqudNC2Hd7uPkrbkJWg6U+
 bttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721304884; x=1721909684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qsVsg1ViojjIwgSQ0F58P2aHMMy1cjG85swySoOl7M=;
 b=XB+Lf8mbzZz1Had4i7bWxwVyGF8e39aaJealOvtcZhERgkz54fO3omUUCfMI2RtIpN
 JuCSkpQ0g4UFqv9Heh78h7cgzB3nXrLUb4X0Y0Ug05H+1W4LCcEiHBkEWggZ0fZT8HnS
 N9jG/e+nRQHWtJSGOFIHiYYP49Z/h//3vbrXH/+lKgIIHhYcs8EIwqz4zPLrCsEBM7BZ
 ouMHui61clzagUdDZV4sGgfgmmdHdveJ/NjZ2m/ZpctG4U1Gvq3kMEw6wa3ztuHqRKkH
 1ShJZJffIaUAJXfgKTJ56m5zzRmpHMjthzF9pgY3yZOnZCElDO2s+3nzfxV7x0UbwPeo
 Dg8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEh2lGMN+cuCWJM5/jEDZysOEPcNeKx7DitAmcDd0Z941Rkdd9UZDtWH7kkmGGO+hsFje0n8uvdhzvNvijuMN00yfivVo=
X-Gm-Message-State: AOJu0YzIpSkPPU/2eg71ZxSqItgzJbmo86KieLfnz7cZ3dzaJgyH8F4r
 0N/d7hh1+0MHr+Vd2hkFk4EruCs4MkLK7xdC/O0w2ko5CiemRe+72fDi8TdBSbQl81if3ft6TCy
 ChXWFA7kzbf3kxyEciUTcrli69DyeB66meGY3bw==
X-Google-Smtp-Source: AGHT+IEMipb3SbK7ecswG8tKXL1R8ctTFurUtnHmwNCQTkbuz+DRKLXD8nr7YIIz7g8XnP6wpy2xuHCe+1bLjs7HiLs=
X-Received: by 2002:a5d:5009:0:b0:368:319c:9a70 with SMTP id
 ffacd0b85a97d-368319c9b62mr3353986f8f.5.1721304884408; Thu, 18 Jul 2024
 05:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
In-Reply-To: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jul 2024 13:14:33 +0100
Message-ID: <CAFEAcA92tB_Hf9AcYsnCSfzCu34RDOb1Mxf8QsQzV1Re9aGfDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] target/arm/kvm: Report PMU unavailability
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 16 Jul 2024 at 13:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> target/arm/kvm.c checked PMU availability but claimed PMU is
> available even if it is not. In fact, Asahi Linux supports KVM but lacks
> PMU support. Only advertise PMU availability only when it is really
> available.
>
> Fixes: dc40d45ebd8e ("target/arm/kvm: Move kvm_arm_get_host_cpu_features and unexport")
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v3:
> - Dropped patch "target/arm: Do not allow setting 'pmu' for hvf".
> - Dropped patch "target/arm: Allow setting 'pmu' only for host and max".
> - Dropped patch "target/arm/kvm: Report PMU unavailability".
> - Added patch "target/arm/kvm: Fix PMU feature bit early".
> - Added patch "hvf: arm: Do not advance PC when raising an exception".
> - Added patch "hvf: arm: Properly disable PMU".
> - Changed to check for Armv8 before adding PMU property.
> - Link to v2: https://lore.kernel.org/r/20240716-pmu-v2-0-f3e3e4b2d3d5@daynix.com
>
> Changes in v2:
> - Restricted writes to 'pmu' to host and max.
> - Prohibited writes to 'pmu' for hvf.
> - Link to v1: https://lore.kernel.org/r/20240629-pmu-v1-0-7269123b88a4@daynix.com
>
> ---
> Akihiko Odaki (5):
>       tests/arm-cpu-features: Do not assume PMU availability
>       target/arm/kvm: Fix PMU feature bit early
>       target/arm: Always add pmu property for Armv8
>       hvf: arm: Do not advance PC when raising an exception
>       hvf: arm: Properly disable PMU

Hi; I've left reviews for some of these patches. I'm going to
apply "hvf: arm: Do not advance PC when raising an exception"
to my target-arm queue since I'm about to do a pullreq for
9.1 softfreeze.

thanks
-- PMM

