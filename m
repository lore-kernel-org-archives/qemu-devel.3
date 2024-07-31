Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E061C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 17:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZD2N-0000NQ-Es; Wed, 31 Jul 2024 13:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZD2J-0000Mj-1r
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:22:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZD2H-0005ds-Ih
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 13:22:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-367963ea053so3734842f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722446567; x=1723051367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=krq/DVBMGIf3UCTnG4Govxc+YjVtitrTOmfpG0clA+g=;
 b=B+OkF8R3MU3mfyP/hClSK8caTHzqdqQ2fbIX3lOyA0vZgeMeBbwyI6BhEvJ89RrCCx
 ZSEw2zB9k4yAe6ox0gkyaoSpvjngJUnPSyoQ6H7/vHUUYEPn3DPHEFWJkiiO00nvpTc8
 zbkZ8uurFCmo7b8HO/gJxnOHIpMEZD2qRniCEwDuYWVXfTLmuYMrKviEhFlvp8feZdRx
 FhGLIJnl/yfSyA5w6VRZkym5m33yAOGnC7l0fhh76WulWk/jsS8SsyClNAHTOc3sjHZl
 JA8evvvnbPgcaU4do/IKZq0WQWd1hD0luTeI+ZpMWxJloswtGtr7WgMNvgcSZB39CcKS
 +cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446567; x=1723051367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krq/DVBMGIf3UCTnG4Govxc+YjVtitrTOmfpG0clA+g=;
 b=m7F5g5O8bVeWlsxolA4uGDXGc0BuuVSQq1cZKDXUAxHzjMNGXpXb15RMJjLah0y/9e
 SOfLCc/9scBOSP6UiU2fyoC8KEvASzFD6mSdeuBJxfyAxFCt4/WT+iZYENLmV3LB74HQ
 2i24q7S6nLdVFIwI9f/SJmkkT7RdD4czfdb0Babm4JpGQL7Q4JANCBT8dSRhAeqKnL7F
 nUkPzULXPK2Mvq8WiBg77Iq49R+yuC/jKAW8MNtRkmrGofSs8OwLLRQ71p/kx1flYAk5
 KlNUW8B6mQUSV0/67k1tcjGCXw6LSQroQYh3X1AWMC6SkA6hJTJu/ZCKGCjnP945Ko9n
 O2SA==
X-Gm-Message-State: AOJu0YxNyQSV+nTg3U064yuad0oQ+Nv52J2ims3OrXiFA60TUDv6Wisd
 HX8hAHCJSvHBcINwT/BrGt2fxkvWpOcOupyBAwt71HGtxwAqf6DNjAvF5S6ZO+mIOL3Uu570TRv
 e
X-Google-Smtp-Source: AGHT+IF3VIuzY4sZRhm2IyCP2I6uw4EW0NRqXNwuciEkXUbsHr9TawBA9fsA5Vidi5fccf5orWZNcg==
X-Received: by 2002:a05:6000:b09:b0:368:5042:25f3 with SMTP id
 ffacd0b85a97d-36b5d092d74mr11872685f8f.34.1722446567545; 
 Wed, 31 Jul 2024 10:22:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367e51f0sm17545140f8f.46.2024.07.31.10.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:22:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] target/xtensa: Correct assert condition in handle_interrupt()
Date: Wed, 31 Jul 2024 18:22:46 +0100
Message-Id: <20240731172246.3682311-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

In commit ad18376b90c8101 we added an assert that the level value was
in-bounds for the array we're about to index into.  However, the
assert condition is wrong -- env->config->interrupt_vector is an
array of uint32_t, so we should bounds check the index against
ARRAY_SIZE(...), not against sizeof().

Resolves: Coverity CID 1507131
Fixes: ad18376b90c8101 ("target/xtensa: Assert that interrupt level is within bounds")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Spotted because Coverity (correctly) thought the issue was still
outstanding.
---
 target/xtensa/exc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 0514c2c1f32..ca629f071d1 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -171,7 +171,7 @@ static void handle_interrupt(CPUXtensaState *env)
 
         if (level > 1) {
             /* env->config->nlevel check should have ensured this */
-            assert(level < sizeof(env->config->interrupt_vector));
+            assert(level < ARRAY_SIZE(env->config->interrupt_vector));
 
             env->sregs[EPC1 + level - 1] = env->pc;
             env->sregs[EPS2 + level - 2] = env->sregs[PS];
-- 
2.34.1


