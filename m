Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509C5C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwc5-0003cC-5M; Mon, 17 Aug 2026 08:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc3-0003aB-Lz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc1-0001DZ-GQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4956242332dso35664765e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786970322; x=1787575122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=opC12ydTNugOwOJ6xGPR73o1WqfNlp3JxYQBD+XkUu8=;
 b=zeErLOSlbq4rXYafGthjHQZ2xLQAvHb6Q4e5rUE1n053FvCQl/iqeB3ZBEZqjcw25K
 2oQPi05u0bY1Xz76zNRqshYyJ+P3P1ZMI4YrD0Yce8QQgR+3PjZpmPzouL6jAzt5BAh7
 2jxsHxMyjvaJUSMXbI6xmqVOLE8fUnTkTGfAm9nYz1Er6oTNpHAN3KX8hr/oapYRDVIN
 eO+/fzsR3WgpI3iEldH/DSQSGo/XLizfu5SXMOD+28F7B70kKDBZ8eLJMpGIRaAr37Zp
 LACpfw2TD6F4JmSG7o3bfqUv/7ouQKiXClXkYhGEJHMVlOzVT7n6Ww+ZWxqF0p9RKeqi
 nJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970322; x=1787575122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=opC12ydTNugOwOJ6xGPR73o1WqfNlp3JxYQBD+XkUu8=;
 b=mQAuggMruUDidLqr0BGkvsR1QmTbdTPxEh9BuqPULTnyj4zxL8B90FLj2IyQAzqZHz
 si49Bj/xWbhJNShVIlCHhSxCzWHDqjoWkpNr4AHFVK2j2ESenotbEFzMruu5WUPGusQE
 NZSxkWG3blP96I6GmR1g5s0+uGGb6ila66lhqUYAo+PZZd1+h56BWQiy6aDAU6EL4+OJ
 FnoGRUCp798UqFSFurT0iJUySbwkCckXe6pIdPjzUvxSAmx97XFucq2EaAxtzEz/xrSC
 GTsvOS29HYUkk4DolG2h2qq6ajUYoFEWhx0pVnUrH3ARJxh9Hj2DwKUyTdig6Kr88ySR
 0lZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoemDmaUoMzGwOzyZZPQUsub39+t1b+xvEw26DKnezYdqEdhspsgjGPCDH0kpBxwPlvkwqIyTpJoI8n@nongnu.org
X-Gm-Message-State: AOJu0YxmX5pv/JoFEnYjuqubgoCU8Fyyw4TP7I7H+nh2m8RUYluclNq+
 +MsPhVE6rGO8xw20AeSynDua6Evo28TfnPIOMue2XlZEa+dV4T54Z+IZCoQMXOvEh7o=
X-Gm-Gg: AR+sD12OpQMzmcWzgogCtM1lpzsZKoUroCjIxpPjDoX3yyd+4fzQhds5ZxXiUaRajfd
 aCaqJOYcV3djr8QKfGaQWteOMRZQUSqbyAbQxg2AlKKGyJp4JhxKuA8VdwODqOdrybDCCvFsxG9
 evwQN7elc6i7pntR0JSno89Nuft1+lQ1WbaRAneP5vS9Z1BgAgNq12mFktEbCpqvXAJm3HTNz2p
 v+zLj0tC495afwh3to/fgK0nAzavPdVOCl54+pS/ZbFgzOcQdbLx0OT6mLa1rGl+3H5NfkLULbW
 w5dxlooJiKfPVCMIdxVl9KxrC4uw2ICLtZqPkcowZ0eNYLPWlGQNy8HpMBe1EkfBGJ1VKNd9NCO
 U9Ac7waWCLxBGdKgh0GTv2oc8DxAmSrNzEtkKG8KLZvO38Eop66QsUIglq5f3YgxHvrJBMWr4Im
 XeFmCTiNsVTdpo/5d+3ojG8NNx3iXbDqWeKOP4ylKItcnbKshg3ZbBHpxI/sYdML/ff6tEMYD/w
 9XyhBUz8DB/Gxw02eXSXopfElQjGrJk2dgbPzJdJes08aeJqzc2wGy4NTXuq0d6AiAhRA==
X-Received: by 2002:a05:600c:4e8f:b0:499:972f:6b8b with SMTP id
 5b1f17b1804b1-499972f6d08mr122199655e9.16.1786970322362; 
 Mon, 17 Aug 2026 05:38:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998780397dsm120415055e9.3.2026.08.17.05.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:38:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/8] target/arm: Handle NSACR.NSASEDIS in CPACR accesses
Date: Mon, 17 Aug 2026 13:38:31 +0100
Message-ID: <20260817123838.1578060-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817123838.1578060-1-peter.maydell@linaro.org>
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In cpacr_read() and cpacr_write() we have code that implements the
"CPACR.{cp10,cp11} behave as RAZ/WI from NonSecure when NSACR.cp10 is
0" behaviour.  There is a similar requirement for CPACR.ASEDIS: if
NSACR.NSASEDIS is 1 then CPACR.ASEDIS behaves as RAO/WI in NS.

This doesn't matter to us yet because we don't currently implement
ASEDIS or NSASEDIS. But we're about to do that, so add the handling
to cpacr_read() and cpacr_write().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index af45234ad2..c33de9c5d4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -588,11 +588,19 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /*
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     * Similarly, if NSACR.NSASEDIS is 1 then CPACR.ASEDIS ignores writes
+     * and reads as 1.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
-        value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            mask = R_CPACR_ASEDIS_MASK;
+            value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
+        }
     }
 
     env->cp15.cpacr_el1 = value;
@@ -603,12 +611,18 @@ static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     /*
      * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
+     * Similarly NSACR.NSASEDIS makes CPACR.ASEDIS read as 1.
      */
     uint64_t value = env->cp15.cpacr_el1;
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
-        value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
+        !arm_is_secure(env)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
+            value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
+        }
+        if (FIELD_EX32(env->cp15.nsacr, NSACR, NSASEDIS)) {
+            value |= R_CPACR_ASEDIS_MASK;
+        }
     }
     return value;
 }
-- 
2.43.0


