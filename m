Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1334C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNd3-00011M-MB; Fri, 21 Aug 2026 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxNd1-00010u-I2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:41:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxNcz-0000T8-Nx
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:41:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4998590d392so7494995e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787312500; x=1787917300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=upTdKsMlqEl4z/2IvDUxBIfujT7J8Jlu0FB1+sSl9SE=;
 b=i6igQdap/kIW13ArKcsCRGVUGhPSdTyuLPTjxsBfckZsZZV5NgKZIuZXzSwbP6NNc5
 0eykX0OfFs55oxvy2gYz8UCSIk062TPBickY0b74o3ljFg7Q2s1u7ojTIy8u1Fqd0Di2
 SEFxeWQZYFamCHrRe/z5dzGwsYokbao9nManOrXDL569R5BzOWFNYyE79vTsK5pMBjMB
 2Jp1PCg3itdZigv9/J0K4kQfUe9FECLU5zc4QZhkWqNZkUlveS75XcdfWyg9qSJH5s8j
 zI7EM947S30p1TzHZEuAuRltZijvpYehpxA3dHLp5eMVTxXsKvD8GiidLBTZbGgcqU8N
 IgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787312500; x=1787917300;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=upTdKsMlqEl4z/2IvDUxBIfujT7J8Jlu0FB1+sSl9SE=;
 b=KRJE63lehy6+DIfev7E0LyqSZE/pLi4gldSV70g1mB50VNtuRHZAh9wwLc2aw48AtC
 Iig5xyNcBV1Xz7+EcP1M/N4hoJNwzwx2HPFmlx6E1C8I/9p/R3WJ3TDQ+Xu/3slakW65
 JvkigB8pEglkr3sjU1AN7R6x5+4yX7UxG+dEQFIWdox33XAA4O0/DWHNQNXV7wfVwATS
 G6MGZP9WtKbIef/us3av7JKCOJ1lqMCYk7m3V+ZJISHnSkaUkAXhM6KiHf4NyhlvKqkB
 b5JKWtI7qlBtEDKE66RJ9ARIcE9VTwPFNe3YIMNSH/SBNiP62bXzjLKnA1ZwWOR3Bgi8
 G6Ew==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6r6N3s9fg+O3sVAKrr3c2DWkJTlgHF+Do5MQzQcuSBpzgP/00M44xsD6g1ukTNRdBvnkz4Di0ix30@nongnu.org
X-Gm-Message-State: AOJu0Yx6VYSA7h5d/Ve9pqkeSfnhHnx82P44IClweqA1avA3HpqE9SWD
 1qhiM3bO/SIkot9GpxxNdqqy3/K8meCwakxpjxebftNTEDHdebNwQqMynHtsFg88CbA=
X-Gm-Gg: AR+sD10anO98zXdKQ+Xh/oqjOu/lNwf2lWPrsTrFT2airc3CtW2yZdiSaOAPVHm6Aol
 yOAvqtPTmUfueRi9xnXHxqOHkZlBqQj9BmeZx/Zx8xbr7sxg7rWQ7UC/3KeNrPT/4HptmD6Ajek
 Ocz6VKYqMTDu0xOSf714+NFy8RTzSwhv2CESZy0oETsrZZFawRcvDcQuqIgeY7c5zBuT/hc74AL
 YePQWJv+6pD9tlRE2gYsdVu2GXk8nWPaI8TASMcJLSIzv4RH13gkfYSrdnrJ1rIkoGGxNOREMRw
 TsZibZEOJU7ik1IwhVlx+jfnG2PbkXe94mmsznzCasgJNot7oxo7AbvNbOu646oiWMs7BnVAE1X
 KP37H+/1OfVa9to3OOp1Lp4HnD/dpEgLxl/GO9FGdzPYVXueQE32bPIT8gRW+p1VgxgX6uWoaps
 e+ONuKAwl8yBrrEZHAb9AedO05rh+0TO53j02OLZJuhwTdDY0TrQCsoZ1KzmYdg98PChWLfDRY8
 6SvFQPGnOsjnm6dosxxvONPgd3zuHEuJe0wXNHgIrPRi6gbFJ00XZP1vcMRBsYC5nedjA==
X-Received: by 2002:a05:600c:e549:20b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-499b8343decmr66361255e9.10.1787312499780; 
 Fri, 21 Aug 2026 04:41:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90d67bfsm24393725e9.3.2026.08.21.04.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:41:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/arm: Correct reset value of SCTLR for arm926,
 arm1026
Date: Fri, 21 Aug 2026 12:41:38 +0100
Message-ID: <20260821114138.4068582-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

For the arm926 CPU we reset the SCTLR to 0x00090078.  This is not the
value specified in the ARM926EJ-S TRM (ARM DDI 0198E), which states
that bits 16 and 18 are SBO, bit 17 is SBZ, and bits [31:19] are SBZ.
It's also not the value seen on real hardware.

Similarly, for the arm1026 we use the same SCTLR reset value but
the TRM says that bits 18 and 16 are the SBO ones.

This has been wrong in QEMU since 2007 when we first started actively
resetting the SCTLR to some fixed value rather than zero.

This wrong value didn't affect any of QEMU's behaviour, because we
don't implement any handling of the old pre-v6 meanings of these bits
(which were IMPDEF), and their v8 reuse is guarded by appropriate
version checks.

Correct the reset values to 0x00050078 (i.e set bit 18 and not 19).

Cc: qemu-stable@nongnu.org
Fixes: 610c3c8afd99f4f11 ("Reset ARM cp15.c1_sys to default values. Fix XScale cp15 accesses.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4202
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v2: fix arm1026 as well, since RTH found its TRM
---
 target/arm/tcg/cpu32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 8220d785f5b..c49265e673c 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -33,7 +33,7 @@ static void arm926_initfn(Object *obj)
     cpu->midr = 0x41069265;
     cpu->reset_fpsid = 0x41011090;
     cpu->ctr = 0x1dd20d2;
-    cpu->reset_sctlr = 0x00090078;
+    cpu->reset_sctlr = 0x00050078;
 
     /*
      * ARMv5 does not have the ID_ISAR registers, but we can still
@@ -74,7 +74,7 @@ static void arm1026_initfn(Object *obj)
     cpu->midr = 0x4106a262;
     cpu->reset_fpsid = 0x410110a0;
     cpu->ctr = 0x1dd20d2;
-    cpu->reset_sctlr = 0x00090078;
+    cpu->reset_sctlr = 0x00050078;
     cpu->reset_auxcr = 1;
 
     /*
-- 
2.43.0


