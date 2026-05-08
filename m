Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC6FCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 16:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLNw3-0001KJ-Jp; Fri, 08 May 2026 12:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw2-0001KB-L4
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:18 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLNw1-0000wN-9N
 for qemu-devel@nongnu.org; Fri, 08 May 2026 12:20:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so1364158f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 09:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778257216; x=1778862016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GRwc8mb/8Ps6W04pgqlwhp3oyQjaN3bNjOn2aZwlwdA=;
 b=yJFgdKnChIk6hAbmjwvTLqME0Ldd6UF/oB0OGuAMfk98uZ3cTwGgWTUDtN4Dj5kqFu
 gNmWFRGem8Kuqes5YeCZo/LJZ1INbaKxrH+Afw94YZgn7FPmsZP41veyT2f1b8YQCq/E
 +6DUOOcwHD/NIU8JYxN1B+G6ZO0tk7Nr2NYxLoQuEJzVa+9AO47AUHphc9+V2VWgVy1X
 Lyml80ugjlPJsLNr3k6xCUsy0IF4s89XGIPH0aB8Qe84W56PqmQe5zIPbloZ0P3dSPFP
 hD2EKm7YphamqH9WuA5iDRndZybHoJ1FnPOxJhpkbh4LEoxITTwjn8KeARYiWcOInj3h
 o7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778257216; x=1778862016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRwc8mb/8Ps6W04pgqlwhp3oyQjaN3bNjOn2aZwlwdA=;
 b=mCPX3/wIjhTRiKmhWN4kK6HMQHmTZwV8FRrV78bmeqOX9y4TrYXB32vNgmr9/OWh/0
 Krh11AV/HJR3iPWdDFI8KkDJFanhUxaotL96ePvl5p1fOdpNFZ1K0bgDVX7xGS3zrSaE
 JYbYmDxMna/n/BbzVxwx18fvvOf5nwrGdQCi8mH4NebPsYzVa47KWyyq3NzZNeem1Hpk
 ynRJDc91eUJrqq5ErSerIlcQG1N4DNoYXdeBBYyyUCCglZkj1YjQAkbckfotRgc1S6yV
 Pb4dNlX97dduEKX1XQFdaGOwS9ndleP6lWNAgB/fY7alff1B1i7Mcj8n6wkpSTE0oK7A
 9Piw==
X-Forwarded-Encrypted: i=1;
 AFNElJ91s227A/GwH08b4MScPo6Aiywl+VtSaEL6g1pj/oDlVN5ryakwOSUNFPSGsu/6kMS4DctCyew0B1Lw@nongnu.org
X-Gm-Message-State: AOJu0YwedgM+cTZWzppSWkQumK/brER/Dp0UmbgqCxrDAq6ffxLP7f5B
 iM4xb8NRn0VJdOIt74M3jTFWZGHlkM9hcBuNiUATPIXvUdGCuw/DVieykfHJmOJimX4=
X-Gm-Gg: Acq92OEYX0m27MW3N/ZYpwU+H8IihaYr7fECeRhTy6SfqUKmoFjpUiy8Ou1sHTx2Cas
 WNrGYXDz5hr2le9OzLJcmB1BILn4PhRImAhBIRiA6D2R7csVsDGNtZcrAjBpvg8Zs7MkJ2ylJnw
 l7z98BaZ6RxSZrlZ6zvhPvMhiwxJBX0ZQtuSN7AxOhNPlJCZv4VHcshHkgIUXbeCD1ENGORDMbM
 Po7NBHUmrqK8jj/edhG3pb6LBTiOlUutfsensALD/UBJtEYnHipGEjv+n56kwfQ8wh1yOnzUaCw
 pAe4V90r9wu0WUCC82uOba8k74X4g/y29iNfEDGPpBXDCiRG3xU9BTzb2eqjC7zWt3B5+hcWdkh
 CM1iG4SpcpkkhO6szl5WvTyO6yhhX94Ronhqg8Uv5u9qOP5ZMdt2x4tyttdmiplFzjz33TlBp/L
 lMXurpRaQn7ngvz6kksiI+yCeopA6/QqNPcK/0xgUI1gAQouiDvekUXOWR1EqO0Zz73JupOcKG8
 liKPV9cX5BzowrVDqxn/gQAqNCsNDc=
X-Received: by 2002:a05:6000:250c:b0:44f:f4de:a844 with SMTP id
 ffacd0b85a97d-4515d2e6ef0mr22029042f8f.37.1778257215370; 
 Fri, 08 May 2026 09:20:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6aea4sm6226998f8f.10.2026.05.08.09.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:20:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw: Fix some minor arm buglets
Date: Fri,  8 May 2026 17:20:09 +0100
Message-ID: <20260508162013.2751001-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

This patchset fixes a handful of minor arm buglets reported
recently, not because they're important (they're all very
dull AI-located "bugs") but because I had a spare 30 minutes
at the end of a Friday :-)

thanks
-- PMM

Peter Maydell (4):
  hw/misc/bcm2835_control.c: Don't assert on local timer zero reload
    value
  hw/arm/integratorcp: Use LOG_UNIMP rather than hw_error()
  hw/display/exynos4210_fimd: Use LOG_GUEST_ERROR instead of hw_error()
  hw/display/exynos4210_fimd: Assume display surface is 32bpp

 hw/arm/integratorcp.c        | 16 ++++++---
 hw/display/exynos4210_fimd.c | 69 ++++--------------------------------
 hw/intc/bcm2836_control.c    | 15 ++++++--
 3 files changed, 30 insertions(+), 70 deletions(-)

-- 
2.43.0


