Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490BFC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRzC-0007PQ-T8; Thu, 27 Aug 2026 00:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRzB-0007Lx-8J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRz9-0005sZ-5o
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso197315b3a.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787805904; x=1788410704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=miXpqBfMXHUusxF7pDd8CEVSDCLDHCNp0HFGnt4WE5M=;
 b=Y6WFv7kyPae+rJLgbsPhvbaVoyBSFyPeF7Pkd+tMY8nmxS1GUOGZw+R6Tm64WCCrAu
 OHrB8DS1qbhPuB17tlWIhAWOAHr5+uTDwWD8iLP9uJYMjFRy/LnjwLsELG/VokJn/DXq
 OkekScko7qhATqCTfLW9Cls76zqNC2XYMLJVrMQuYQA5d913LUmB0fFbchBcHP5BY8KD
 ysIf41WkbyAGfFuhZobKMGDevqDf07rhywGVn46WbjujAe23BKxGAi31xfoOhoknuSzt
 mKmT6bQTIgnXStbJiwUliqxogqHplxO27xwlW5CClM7T2G0YljSyH79sGo/AH7ntgq5C
 RopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787805904; x=1788410704;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=miXpqBfMXHUusxF7pDd8CEVSDCLDHCNp0HFGnt4WE5M=;
 b=ViQxrSeCOLC8wz52e+AMowKdKOvOmcQzY0M2h44CircKsM+Ajwf5uLBQ2VPx0LlXmc
 eoSSIzgl3XxrDtIAQvO1bb3SFDyz4adEm4hpwJU2zHHXkvm2HdpvK2qFK+sk1QmsT7t9
 3xwhQ68MDXAutVAkCftIFL1pCSUMvil22tJ/XrecNNsGPxBOwsSuO9LDz1jJzWUCZjlZ
 X8MpJMctkL1zETArq8uKhHV7XJt0xN4boOJr0cO07yfXx4WJTInoLXPG4NjHzyoJVFPC
 lbddHhMAmBVyHM3if7ydg6vGkMM09CczeKT2tYiu+198iXVLveOIZ+RA3TvJ8KFIJKFd
 w9eA==
X-Gm-Message-State: AFuF++mzbUldO50wRqnpM7uUdAMB7C8u0EXzHQCAVDFPrMq4PjLadjla
 vgzcIV5CJ/qRCx2kJCUXXNVXKukaHXYyB9ey/DbI1ZfiPUvFpiwL1heKdMJJyDorUvvg7oNmVzU
 sq+MNPzA=
X-Gm-Gg: AR+sD127sbUX8RP4i+QvDPEYuDTNd6HUDNVgZkl/Sc4AtfFnB/1hKwRzVKy0QYfLAEN
 q1hK4UktzRp/MnBwtCl9z8h2tHYC6bo0xr9RbQwZ5JmvWQ7f9PZjqvwv+eqOxt5pLKQ+uNKMTMw
 JjIs9l3jZd37G4heKaEZmyuOiPqEo1A1T9L3fa5oXLCVM0b0QDUtw2UcUxyp7V83GcFrEpeezRv
 sKBNTGYmDArf976W92jkg93i09GGxNhVqHnb3HDrUeFsrrEye9oDFFBOQiUE1pTFYjSLoHdQP4E
 y5NBBfvXx2uNeoRLa9tYE62/kNxdSkqoLDdsaZF0IXvLEDqJXomPhf3BJKFggluWTP0yKVeuMwW
 kY3O5xVvGj7SGnU6SpHC0+bkM4zGC/IT7Ktjz8RN8LlO+A7aNT+q2buWurdqdnAEdVbDTLu2fOs
 Jfc3+e4qVAIZAhsx+fWZ3+G8LZ5cv7xX1iSxLHCW3fU+8v2FEOv4wota/VD/8kJpTx8SU9Gi/xq
 ON1wTU5bpF6W2huUQ==
X-Received: by 2002:a05:6a00:3907:b0:847:83bc:d2a4 with SMTP id
 d2e1a72fcca58-85372ea94ccmr21373606b3a.2.1787805903915; 
 Wed, 26 Aug 2026 21:45:03 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm1606003b3a.44.2026.08.26.21.45.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:45:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] tcg patch queue
Date: Wed, 26 Aug 2026 21:44:58 -0700
Message-ID: <20260827044502.778915-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

The following changes since commit 562bae590f194fb590beb5c65da44fc35ab9f64a:

  Merge tag 's390x-20260826' of https://gitlab.com/efarman/qemu into staging (2026-08-26 13:40:41 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260826

for you to fetch changes up to 01e1455139196cc8d6bcde7d2f918348a90f7f26:

  util/cpuinfo-aarch64: Fix build with older glibc headers (2026-08-26 21:25:04 -0700)

----------------------------------------------------------------
disas: Replace straggling CS_ARCH_SYSZ
tcg: Fix typo in tcg_gen_hswap_i64
tcg/aarch64: Use tgen_brcondi in tcg_out_qemu_ldst_i128
util/cpuinfo-aarch64: Fix build with older glibc headers

----------------------------------------------------------------
Eric Farman (1):
      disas: Replace straggling CS_ARCH_SYSZ

Richard Henderson (2):
      tcg: Fix typo in tcg_gen_hswap_i64
      tcg/aarch64: Use tgen_brcondi in tcg_out_qemu_ldst_i128

Tao Tang (1):
      util/cpuinfo-aarch64: Fix build with older glibc headers

 disas/disas-host.c           |  2 +-
 tcg/tcg-op.c                 |  2 +-
 util/cpuinfo-aarch64.c       |  3 +++
 tcg/aarch64/tcg-target.c.inc | 25 ++++++++++---------------
 4 files changed, 15 insertions(+), 17 deletions(-)

