Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8DCC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 07:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufw1T-0006JB-CP; Sun, 27 Jul 2025 03:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1L-0006Dv-CJ
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufw1J-00014T-3z
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 03:42:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23602481460so35055875ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753602127; x=1754206927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E6TDRzxDf7JZ5uG5ENuSiSwN4duOSvJb2nWMSGUGpe4=;
 b=C/VN+SIpYzBXRaeKJ52wv+Y+LDcNa2qrmtp59WVMAqhv7BU2DwiWiDa5RC327HzjhW
 q4UfB3uryZ7iQe8X2J8qODgWrnggM9y0QXJoDNm9tsUcAhFYHwOJV1INJbHcwdt2B1fV
 LbccQt0cM52Bxu1IfUqbwqem3CzAW2tFNrdnqMC88alwN+07Ba86W3N9nQ/FN1SmPF6V
 lCyn/RQ6rEtilPGC5ovKVLm8Ak4ClEbamsMzh0W6cMHROCDxVdLr5TF8Sb7IcIhAiPc1
 vcyh6Ge/eZuYb+AfvFCkgu6cjiTvX+EZz+x7NIoow2NWjjVTbmQxeMJLkuwWqFbAb1Ve
 X7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753602127; x=1754206927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6TDRzxDf7JZ5uG5ENuSiSwN4duOSvJb2nWMSGUGpe4=;
 b=VbzmSnSpcD/gD7DeSTZLmZhg4nCNT+SlA5VhPVeD3JGAVUNGXW2KfxAmpusn9IXNPw
 UzEOmquf/mIxnbbi6Nc0ktCgS+++IZlDqVwqDLltIrprV4RiDcFqxDH/kXIEYWt3vSE7
 tVBJYs0GD+99S9rw9O5UgXqmBqW0FhdGDhnthdkevdDgKLR9VzoZAVdgYUX/qjy1F6th
 +QCpo736mtpseRjcq/WiVSYmoPAn+Lvak/1cUehjFxFCsAk7V1Fccv/itnuSNk7+gbHa
 eANk60i5xZWyeayDw678IiDSnjagHcxNGlKq5Ebd43EOfjR0w9EM4G0j7rgzBjghNpRU
 wAcg==
X-Gm-Message-State: AOJu0YwmxnEWO1etzRdfTkB6Qs4mzPWojqCfsbWQJqTI2n01dzwSg6tx
 mtBuUmxIxt/WVg2YPeiZesDfOvMKe751tXv+hk1vhWINkkBElEXZPZHSmCKv1g64xISImJjgp+L
 mJrWu
X-Gm-Gg: ASbGnct7YBNo23PN9hF1iN60BOSChdOHBCfn39BMi90OVOHcN9phnI3jQJbM3t2mc6q
 oVEzns/YZPRzPd+Q0eRsnO3FzRe1XaPUb5eK2LvvzMORSS8Vcs9X7fNCslTE1wKbiaExgaPZ480
 HgZGssBkEa+ZiEREeNoOB2ieM8ZIY6pbnQ7LT69RGmIkkjB4SMuv6zaK1QWADrtiu6pGKifBnT6
 XzT8iJTDJlJHVMJd0JI+2YTH2zyrzijovaP60iEU26+MvbOXNoUygbFIMDXZvXyiAzWbNka1r1i
 0+ZUUkIZ+z4EkyY2uErjPjDDwQda5b6oohceoHvBlpLj/PpVXm/xwTZyAftJNDKkch6uG6KJ5/f
 JSevdrGtQU/ab2yaLHiOR3/w+ROJUTTysty6p+BFZFq+3D7oHKoppADOKrZtjtX1qdgv1pNyVuf
 ZCxD8UdR1cog==
X-Google-Smtp-Source: AGHT+IGiYLYizD2XtU68iwgdmFmUnTWbbeq//trO32x84IrPy9WPOk397yfdLdRk4D1pdx7dLhi4Gg==
X-Received: by 2002:a17:902:d102:b0:23f:df33:21cb with SMTP id
 d9443c01a7336-23fdf33243emr31309855ad.44.1753602126981; 
 Sun, 27 Jul 2025 00:42:06 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe53b546sm29633055ad.177.2025.07.27.00.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 00:42:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-10.2 v9 0/6] target/arm: Add FEAT_MEC to max cpu
Date: Sat, 26 Jul 2025 21:41:56 -1000
Message-ID: <20250727074202.83141-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Changes for v9:
  - Set bits in arm_hcrx_el2_eff has bits whose effective value
    is 1 when EL2 is disabled.
  - Include Pierrick's firmware updates.


r~


Gustavo Romero (4):
  target/arm: Implement FEAT_SCTLR2 and enable with -cpu max
  target/arm: Implement FEAT_TCR2 and enable with -cpu max
  target/arm: Implement FEAT_MEC registers
  target/arm: Enable FEAT_MEC in -cpu max

Pierrick Bouvier (2):
  tests/functional/test_aarch64_device_passthrough: update image
  tests/functional/test_aarch64_rme: update image

 target/arm/cpu-features.h                     |  15 +
 target/arm/cpu.h                              |  27 ++
 target/arm/internals.h                        |  23 ++
 target/arm/cpu.c                              |   9 +
 target/arm/helper.c                           | 274 +++++++++++++++++-
 target/arm/tcg/cpu64.c                        |   7 +-
 docs/system/arm/emulation.rst                 |   5 +
 .../test_aarch64_device_passthrough.py        |  27 +-
 tests/functional/test_aarch64_rme_sbsaref.py  |  64 ++--
 tests/functional/test_aarch64_rme_virt.py     |  85 ++----
 10 files changed, 432 insertions(+), 104 deletions(-)

-- 
2.43.0


