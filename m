Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053CECCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJJ-000295-I3; Tue, 14 Oct 2025 16:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJH-00028B-RH
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:51 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIv-0005Kf-8x
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-28e7cd34047so45273085ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472445; x=1761077245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0fUP5O6nkxBJR5PVsToUmM6ZB4XOvQbuwCKjBR/iU8=;
 b=NUrTxAShOnLA0obeuLNPOsYfVWKQjwB5V3c7Qt2MDRoyesABvHZ7nk1703SlvjuUbK
 gLMfiI3hd99Gm7NMAPDCh8EqUJZagwHtmY0kTzvSmLGr7VyJkBA04WnM616nxlwo/jg8
 hyCWr7/tH0gLD2uV2fd9ptWKFAvF4dTiEBZ468Km2ndkDgqNdsfts48nu19g74o+R1dn
 c1WQJKSFyus67UT3j3rQbp3TImkDBf5X7J/+BDPQXYe5PdWkhaAzEQVWbrHmtP05GQtt
 zFfxU0v8dWtGt4X8k3Tv+Mkv69yk3xK2fNDIoanm6Ix26VqHLxBD1SLJF+bDdEmFF81N
 b73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472445; x=1761077245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0fUP5O6nkxBJR5PVsToUmM6ZB4XOvQbuwCKjBR/iU8=;
 b=DHLrWQuT2k6dCEL5TZMnIhE9ilW17GyEGZhj+sPfz9BgebGcVHu8+Fyoui4xrdc684
 GtHOXhZANTpWfruhH9KZ4ZCTllxPe3Ckds9lzkWFh036IqLIIaNFbbsReZ/LG842TXoy
 sZs/BZxifQMcUg8D0mW4GXGQrq4eK2diAWnejOkPSCCK2H+YJEJIN9P3Z/XMvAj2O8c2
 5qYbH1m20enI71YNw6RrXKh5zq+hzjRb6vSzsXYnMOiqnZn8hR0ivdE8ldBRGssqCMdw
 hEDfeg9QC5BGdAt8CicjjpWlzShER1HFRq6RBARpQmxKzEBuyTv4EiWm1HlF0j86m8D3
 LuCQ==
X-Gm-Message-State: AOJu0YyrZigYF2mdcSX6xkFNecoQV92M4xcLzlMZWpSiKGNy1hqfoxYx
 chuTUr51QzRlFy1C5VbBDZJ/7h6UozG0hZyf+BlgTVKEJYXFsVA7+vOnWJR/2iPygLux7ot6CJV
 L5g7mBCc=
X-Gm-Gg: ASbGnct1f76n0g4/kqcb/B47SygAS9ak4omkn2uQhxV7xgEhXMGAXVwQl9sHd1GWTqq
 p6u6JEAVi7EVVW9rtSqamE7GU9Q9xHZWgVwfn58nEd/WtuFVB9A9bowrcCOz+q3oYZT5OKdCCIL
 P7xbTaQ0dbYjx4Ss4MZcxtjkBbLnZFafTKJWmjkcd7XKbnRqSIdzjSzTsDeRkuoLNgZPcwwtci/
 mFI8JENmC7Yr4RioNTtsy1hQ9AqehwBO0u9H9xwtSZghw+IjNazUfTiX6jNhC4rzsbUKehq0GVx
 tY1V6rDfZQ9gFJw/GkxBsX1ha+Cyvn8rDOQgNY4KxouXTTrgS1OcdJ+MYoYQjXLb6vNXDbsiJiY
 XQ2rtJuDmYNDUw74wUhTH7UtAjQ6EHilPaJxJoYTg7siBI32jKTwc/QIs/lgiWw==
X-Google-Smtp-Source: AGHT+IGT1IUZzEA0Rx3uAGwlskvY/zznUYoy1T6TPaEUv6Zhtb7VvhFERK5IeW7O244drVkSygWXrA==
X-Received: by 2002:a17:902:ce81:b0:288:ea7a:56b5 with SMTP id
 d9443c01a7336-2902723b882mr375122985ad.15.1760472444677; 
 Tue, 14 Oct 2025 13:07:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 08/37] target/arm: Use cpreg_field_type in
 arm_gen_one_feature_sysreg
Date: Tue, 14 Oct 2025 13:06:49 -0700
Message-ID: <20251014200718.422022-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Deduce bitsize from cpreg_field_type.  With this, we can
simplify arm_register_sysreg_for_feature.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8d2229f519..89324e4ae9 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -274,8 +274,9 @@ static int arm_gdb_set_sysreg(CPUState *cs, uint8_t *buf, int reg)
 static void arm_gen_one_feature_sysreg(GDBFeatureBuilder *builder,
                                        DynamicGDBFeatureInfo *dyn_feature,
                                        ARMCPRegInfo *ri, uint32_t ri_key,
-                                       int bitsize, int n)
+                                       int n)
 {
+    int bitsize = 8 << cpreg_field_type(ri);
     gdb_feature_builder_append_reg(builder, ri->name, bitsize, n,
                                    "int", "cp_regs");
 
@@ -292,28 +293,25 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
     CPUARMState *env = &cpu->env;
     DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
 
-    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
-        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-            if (ri->state == ARM_CP_STATE_AA64) {
-                arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
-                                           ri, ri_key, 64, param->n++);
-            }
-        } else {
-            if (ri->state == ARM_CP_STATE_AA32) {
-                if (!arm_feature(env, ARM_FEATURE_EL3) &&
-                    (ri->secure & ARM_CP_SECSTATE_S)) {
-                    return;
-                }
-                if (ri->type & ARM_CP_64BIT) {
-                    arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
-                                               ri, ri_key, 64, param->n++);
-                } else {
-                    arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
-                                               ri, ri_key, 32, param->n++);
-                }
-            }
+    if (ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB)) {
+        return;
+    }
+    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        if (ri->state != ARM_CP_STATE_AA64) {
+            return;
+        }
+    } else {
+        if (ri->state != ARM_CP_STATE_AA32) {
+            return;
+        }
+        if (!arm_feature(env, ARM_FEATURE_EL3)
+            && (ri->secure & ARM_CP_SECSTATE_S)) {
+            return;
         }
     }
+
+    arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
+                               ri, ri_key, param->n++);
 }
 
 static GDBFeature *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
-- 
2.43.0


