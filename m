Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A856EC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHEH-0001vn-LY; Tue, 23 Jul 2024 11:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHEB-0001cY-NO
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:14:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHE9-0001ti-Qf
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:14:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4267300145eso49104795e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721747696; x=1722352496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UWwbuo+0MsX1vzoGfMU7i9YYlVDtQOexa7m/ssopybY=;
 b=aMq1z/sx4EoeVsOMG8Gx/uPE116WyNdJZoIOxxz+jRpJX0vUckAjE9yWJShvjUX4c8
 M/UX9WyqPGe4rjL0RKfARM5ZolFVxNRWEjDEYhGxZaDgeMqmF2NkHv8wtvSZgRsR0TKz
 X5W0ruLfPH/qGtbmxxotA8rxzjCriowmOnSisncdhTFjemWXARXB1l0pMUec+w26N0up
 IcpFACv6bkdaLfLOfJKLyxvr1AOp1oHw1jG6L5lmowVAutmIGaA2KBq+nC9iBCRo7oo7
 Ay96QaGfVgt7w7OBT5/YOBtTcJgsbJXJxww6ajVthhOMXwdQQm7+Pz40CtxfFC+ro+Ga
 9Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721747696; x=1722352496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UWwbuo+0MsX1vzoGfMU7i9YYlVDtQOexa7m/ssopybY=;
 b=RaWr2Sgy2RUqLRTryoG6TX3Quvwx161jD0iinj8gRgk6FYcCnuM3QBi6RcmwouYIjT
 48T1Fq2KEPuj4Tb8k4AplCEvZiOg62N33A22he/qrO0qspDruqyts4tL+zV3DP5Sbfza
 2orJrGBWUyusByKW9CWzlDDoimUfOWC+7HsKoar9okFP4s9ckZXFAAgxyxBka2+61EE1
 8zxyFMd+aTwwRgd+hBUkvwgVKUChSPxwWWHrddxz5kQJY9CDzSdTRPlfXoTR1inssZcC
 WzMcO/xtaIguUHFK9inuGL4A/vt2NwF5cn2xZOvmDBO5B/BxuUm1FF0gMPVti7Gmsjha
 lDyQ==
X-Gm-Message-State: AOJu0Yzoi/4Soy/Q88FbRX5fphcDj8QJxiveGDh2na6R8cXpGLItFbMb
 HpwI5VzeAoedqO5T5TLoDbNfoVW/dAQBn7NNGTsOoXbBun+Qn5ZIJLDJbF9lGNYHYBQdzLv828x
 m
X-Google-Smtp-Source: AGHT+IHo9mTiCf6/z/e4+a/lXAPO3wb9Ye1f1mc3m+o/IUcaFEAAAdDd6Q6bNd3tao4doi3MHCbCyA==
X-Received: by 2002:a05:6000:1fa2:b0:368:4def:921a with SMTP id
 ffacd0b85a97d-369f0a7cab4mr71254f8f.48.1721747695633; 
 Tue, 23 Jul 2024 08:14:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ecf92sm11764163f8f.101.2024.07.23.08.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 08:14:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] target/xtensa: Make use of 'segment' in pptlb helper less
 confusing
Date: Tue, 23 Jul 2024 16:14:54 +0100
Message-Id: <20240723151454.1396826-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Coverity gets confused about the use of the 'segment' variable in the
pptlb helper function: it thinks that we can take a code path where
we first initialize it:
  unsigned segment = XTENSA_MPU_PROBE_B;  // 0x40000000
and then use that value as a shift count:
  } else if (nhits == 1 && (env->sregs[MPUENB] & (1u << segment))) {

In fact this isn't possible, beacuse xtensa_mpu_lookup() is passed
'&segment', and it uses that as an output value, which it will always
set if it returns nonzero.  But the way the code is currently written
is confusing to a human reader as well as to Coverity.

Instead of initializing 'segment' at the top of the function with a
value that's only used in the "nhits == 0" code path, use the
constant value directly in that code path, and don't initialize
segment.  This matches the way we use xtensa_mpu_lookup() in its
other callsites in get_physical_addr_mpu().

Resolves: Coverity CID 1547589

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/mmu_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
index 997b21d3890..29b84d5dbf6 100644
--- a/target/xtensa/mmu_helper.c
+++ b/target/xtensa/mmu_helper.c
@@ -991,7 +991,7 @@ uint32_t HELPER(rptlb1)(CPUXtensaState *env, uint32_t s)
 uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
 {
     unsigned nhits;
-    unsigned segment = XTENSA_MPU_PROBE_B;
+    unsigned segment;
     unsigned bg_segment;
 
     nhits = xtensa_mpu_lookup(env->mpu_fg, env->config->n_mpu_fg_segments,
@@ -1005,7 +1005,7 @@ uint32_t HELPER(pptlb)(CPUXtensaState *env, uint32_t v)
         xtensa_mpu_lookup(env->config->mpu_bg,
                           env->config->n_mpu_bg_segments,
                           v, &bg_segment);
-        return env->config->mpu_bg[bg_segment].attr | segment;
+        return env->config->mpu_bg[bg_segment].attr | XTENSA_MPU_PROBE_B;
     }
 }
 
-- 
2.34.1


