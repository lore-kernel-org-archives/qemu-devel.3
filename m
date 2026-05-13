Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BA7CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzVW-0006fY-HU; Tue, 12 May 2026 22:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMzVT-0006eW-JG
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:39:31 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMzVH-0001wl-6C
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:39:24 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c80227b1f6cso2644065a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778639957; x=1779244757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fgbHqzJ3pTtKAEFR4UcnLuP9LkaHgaAc8cLdnR1Ks0s=;
 b=OB1NnLOdNHttTy2G14bBLQHxCClXgprRSGWjxQ4EQYVp+ZmsscaXq+ihAgeQM5kilK
 uiB24oca0uz3DR3f/dBVlWJ36h53gfubK5Rt1UM+kRHOmV+IlIzwXQlKRSUi+VM6qr9d
 L2sEehrrplIq56cCtwojgwoesNVtUwD4n93rviQnjLqbO/w+DGlaB5EBHLUwUxi3kKLX
 5Zg+A3YwYOAx675aWjX7RjzdAv91sd+1X8BUlHZonw91RxuCxHHek3sBQdO5DRCe8XxE
 ChOVtQHXw15JGhrOVUglB5QxrhW37dASELS40/V2wZdUncLp1LU9iAEtmsw5aI/X7xm2
 7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778639957; x=1779244757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgbHqzJ3pTtKAEFR4UcnLuP9LkaHgaAc8cLdnR1Ks0s=;
 b=GVgnGrl9FoMu6yU+P7f8x+FnW2m+lMYfCBpUtCnX3GmqP7PMNLZz7QL4EcDsuKUtj3
 MRQ/ibIQS2aUnadiB4I8B9d+fT9s4bn6xgBoMSGBEs6aNmtlxatwHBJr3pjn0frDTCZ4
 DD1HOnkm6uOX9wG6yPIHfQJmw1wjzCdWsl7BA2jGWblpTCZLSneERzabpJQa2WHls3tn
 AknhCkX7s7ySRG3yf9KppidX3aREg5ycsWqpbSe4LPfINodCMlm9hUi5CnPmjen5mxVV
 V/ey8BqjRe4T/GbVDbylymZKXvY63d5SOKuUT0ZXkIrwy0ar/Qjv06CK6lchjWe2q0A9
 lfAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Rr56uuFymiMD7pFdlp961YsXsK44VeET0SjVi0You1StPOVt5y1IHhG6EPKNmrURZucICu9y/z0oh@nongnu.org
X-Gm-Message-State: AOJu0YwzpApo0g0ErTXvFFr3JItmUk9RJ48DFlQb/w7F2k0GwQlnhthA
 b9ojjllhldxUfVY92lbeEBG5xzogLeU8wLMT/ZT5fe5vtmg51osc+CHL
X-Gm-Gg: Acq92OEtn89JwrIgcpqMoQ2eU44h7ZCQZu5P+nfsUcF0S83H0VqxKF2RVAJHktjjkGo
 UX5UWh0OKpUvqn2wJENdoTLvXgFrQBmLfzhUbO/C/oR2DcsThP5IA9Hqy5gZP4HB9rdvkYZiiV8
 vu43a5gB9+ENqWGLh9myK4Dn8S66joP1eQHjUZ8UjUqyWq/Ob+/ej9poeQozR44JDX5uU9pcFsY
 FKZjlM5HX/j4cyON+N7hDVI4vOlJDuZYKtGaH2V1cbGqPOJewjr5RsDkn+B2ARDkQfhei37YV6N
 746hEQIsc25NR7budepNEmV2h1fxkb+CsCnfUKbo9lE8JK0bJsdTavOu9blMG/mzvqSPPieCeQQ
 euAlrP85xaAa+eNvQMe3Fr7JWRcrBGY9cbutMJ0VGAlwv0nlTVF3XXUJRz4LeqBypL76t35NxeX
 kt3OJbxqk/A/GAIiOjHXWzMHJsmaFFUbGV62GkUl9mug==
X-Received: by 2002:a05:6a21:68b:b0:3a3:bb6:70a1 with SMTP id
 adf61e73a8af0-3af8068689cmr1290463637.20.1778639957532; 
 Tue, 12 May 2026 19:39:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d26968sm146725075ad.16.2026.05.12.19.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 19:39:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, conor@kernel.org,
 sebastian.huber@embedded-brains.de
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Date: Wed, 13 May 2026 12:38:59 +1000
Message-ID: <20260513023859.518484-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
Conor and Sebastian as people to help deal with the fixes.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
Conor let me know if it should be a different address

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 952ed683bb..9626eb1ea9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1751,8 +1751,10 @@ F: target/riscv/xlrbr.decode
 F: tests/tcg/riscv64/test-crc32.S
 
 Microchip PolarFire SoC Icicle Kit
+M: Conor Dooley <conor@kernel.org>
+M: Sebastian Huber <sebastian.huber@embedded-brains.de>
 L: qemu-riscv@nongnu.org
-S: Supported
+S: Odd Fixes
 F: docs/system/riscv/microchip-icicle-kit.rst
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
-- 
2.53.0


