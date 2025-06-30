Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACA3C83026
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 04:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uW6Cg-0004VM-Pv; Mon, 30 Jun 2025 00:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6Ca-0004UC-MA
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:09 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uW6CU-00053W-Cr
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 00:33:03 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4a442a3a2bfso34207091cf.1
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 21:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751257979; x=1751862779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xwg4/mGs9AWU01hT2+1uM8Iz4xoWbdqsFjVaCRRcKlo=;
 b=QqYCQe8Hs1Fs//1Sfqa2lGCQMMRGlYO+k5SoSbifeqOmZhqb5FeKWRVwXxqEBqhIJE
 7z5VGxR3ZpcVYwmvIgqeU2ylg/qwWqA6KlIpui3Z4CHvyhUzf7YQl2xGSFj9e5Tmkavc
 DskKQ4ktxSfgHf8r0lhZ4bK9VPIwNXP6p0m1iooNP/rJ9WywrVcZ3JU0Xm++I7zLeHLC
 rAa52HCer0awgehKuo+lTy1yfP8NyOoyZ+vhR68lK4c3iLm3ICLfMTxcmPpZBj9LKPiW
 ZpSApJJ84dhXjkNk7o04CKWJow+fi+PoOhN+9N84ap8JKYgQjqEMZVKrNoUxgtzGLXbQ
 tjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751257979; x=1751862779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xwg4/mGs9AWU01hT2+1uM8Iz4xoWbdqsFjVaCRRcKlo=;
 b=WStRXDikLowoeyi33KVopELg9Q8mhn9utWZBPHVlz9tdTfGhtJjSooH7zsGeQvZslU
 xjYh8LTJavBZgHtcig9+iYk0BlzYGDx7j5viw/BHNcTkx9KsqVeTOSZVqgNuhu9leuwC
 Aw/frU0VFDSKZ+iGBKkyX5HI/Fx27TsvWyJoWXyNmdzLc5NArzwE5RAkAxwb2JexjevF
 ax63vZbytQhfc1usALIoYEj2zsf8UJxXVX+YgN+OQMkgS5HlpimVXDldRaaMEr5XMOoC
 2I1T4R7r/SNXhdLLa4k1lYDbVE6zwXG+nqSMRH+qfn3QxEguSCwXNyYwbrMvPZBmJLFu
 jIdg==
X-Gm-Message-State: AOJu0Yzt5cVC+hR66GxbEYy7KiJ1nQc9dh+oU6+KRZbmcXzyK/FVF/yU
 vjKvz7qbJZpUGbU5e1iu/Xp4QRk0vWd3Nn73qHwKxEUQPAOa1ff83GSj/ur12Axf6/o=
X-Gm-Gg: ASbGncur94UgIeuVuSFjXwF6fAjQdx02FLcJjYaPHZoNprKPNC48zqCg5mtF0v5Fo9Y
 F2ceUJ5Et9eGipmnKmui1H2xCuByiaqeKePOKvC2HfxwgRj1X2szGBa5t0NKxOitltmK31ChrCB
 A13gx6kZSLHEefv2e3HGsYHLkslBo8GHzz7hB9nfFoloDYLKRFiLNsDYn7k3RMq1QqeoIevdRn2
 021OklIuaXhQMcyLgTzlU/PzB9ZhSSS4z6hrcdvsoEWIipomzr1Fpi2qaCfVbrlALkf4c96e/Jm
 Nmk3YS5Z3am3J5wRmDIfPfJJk941p2bLFjFz6FBNS/BUXIRu75vlOuo89sTitUOB5Pw=
X-Google-Smtp-Source: AGHT+IFHnkvJlPZGoYIy5ZOVjm6Excfd1PisbneTFkOA2RRZnH1Q/nxBwevrtm1F2aCa0VzIkb4gdQ==
X-Received: by 2002:a05:622a:8b:b0:4a7:fbd0:79b3 with SMTP id
 d75a77b69052e-4a7fc8bb4c1mr183691361cf.0.1751257978871; 
 Sun, 29 Jun 2025 21:32:58 -0700 (PDT)
Received: from gromero0.. ([186.215.58.88]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a7fc13971fsm53470171cf.20.2025.06.29.21.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 21:32:58 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, gustavo.romero@linaro.org
Subject: [WIP-for-10.1 0/3] target/arm: Add FEAT_MEC to max cpu
Date: Mon, 30 Jun 2025 04:32:34 +0000
Message-Id: <20250630043237.996788-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=gustavo.romero@linaro.org; helo=mail-qt1-x829.google.com
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

This series a WIP for adding full FEAT_MEC support to arm max cpu.

It adds the FEAT_MEC registers but does not touch the translation regimes to
support the MECIDs. I'm currently looking at the possibilies to support it in
QEMU for the various translation regimes we have on Arm64.


Cheers,
Gustavo

Gustavo Romero (3):
  target/arm: Add the MECEn SCR_EL3 bit
  target/arm: Advertise FEAT_MEC in cpu max
  target/arm: Add FEAT_MEC registers

 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     |  5 ++
 target/arm/cpu.h              | 15 ++++++
 target/arm/helper.c           | 98 +++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu64.c        |  1 +
 5 files changed, 120 insertions(+)

-- 
2.34.1


