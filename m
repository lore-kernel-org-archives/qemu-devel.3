Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF4C5CFE7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwsv-00044T-6N; Tue, 11 Aug 2026 20:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwst-00043n-59
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsr-0000TJ-C0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:54 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so370338b3a.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494712; x=1787099512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GCy4QywX3WT2024WmusdDJbMQjYEZ61hPhsxtxgDYdg=;
 b=kl+aqpzoWqnAwQc0VstJzUPa3L7/4cffy7Ario1vthadMny5tUNATMkuzMw6gmoeaz
 2sqP1ibuw0QVQKnk73xbfz+uEZe8kE42A+IOjXwv5Otzwp8WnbTfVa1q3reiexbMYqfb
 i307jBt+HABUCAxKj5ijH+b0qsi6brNIcmL/OYGc1WttzkOnb1CoyDv9+DmdEzHf8URA
 KH1NEcJn3o1lc5gVSi2wJCj7HY9UBEf3sf9czYLAx0H7ebsC1Nt0TFHIJnzYPhFNWn7l
 g3X49Jb+GO9mAXJVHM2ggrlo6YSu+enXZElOGJCBcZGoCVhhOwLXMtBYYRRuz8Vza+jj
 LIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494712; x=1787099512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GCy4QywX3WT2024WmusdDJbMQjYEZ61hPhsxtxgDYdg=;
 b=NoBq0JTuppyZtpE099hGS/MeE/PSSmUKDGntewYqzmuQEKn9/QlFry+w6upy2U1031
 lSKbWvZy+M/gULzLsaLA4Rhrz57aZOBKcKGHR+0rI/HOOyZC9bF9syXD7ohhc8/9FLvy
 vErEmfE5A8DZQxifnaCp9ybMtUbIPjiozXR2F38Sw9Xhz0vQIeuORnVxdknDS/xADQJB
 4H3Ip0tKVqVrbqlJMa8CqcKV7D4o1EC6IDrRXIx4E7AHGsm6146cYp6yVW3CXPwbb8Jd
 35z4wCxMtFqMNTmDJwQU/OhwouifOWf8DHMWUhjWV25Wa6PPOGn4R321l//rJEcpbud9
 St2A==
X-Gm-Message-State: AOJu0YwaK00OoxPPmIJvCVeSwvApaNVHxHTGZOMfPPQX7VvHoiQz9p0b
 5HGeGBXQXof5DEDwZkEIQdHscPbjkw4T0gVocg1IFueH5Mn1jOjBqrt0Zg/orccy0QhPbkqclyN
 fy6lD
X-Gm-Gg: AR+sD11d0AiiaO5SdTMlZ7SKASghugio9teoKA92m+Tu49Xa2DOGYI0DRhKG5QQ3f0I
 Y/RTZCuwgHkqUbEqz7iFjV2juXwU06pj0VpSdmxEmctSyKDK3vjN5ldzuZAPGHE1TPKtUGzaiPs
 sR3hU430TpCb7MipQEw1pijVr8CbIkyJXUrLp4ukaDMEzNzgsqjviNh290w95hAWjcOrwpYeITU
 8mYsTztE2cOUgVgnyYtZEo5egPbfLK48kcnQmug2qC6wsrQJnpZVLdqbcGs9l47ZLdzssi4U31F
 0VFR2FJuKLunZ2LwEsLOYE5zR+PqEpJ+XF4ozrPy9FMXMr8xIbFrVbkBtTohHLP6Kf0rhIaA5N7
 /kLq+cpIw/i1x961W5W+6jWTpVm7X1kzvkTGm87ctJg8UQuzzoCmjBmEcr8sCvEfexYzyO63ZX/
 9GkT4GpGRxpYcA6+DIwA7Ep5mr8mXisF9w1KF/Ylsb+6husHB16JUstcMHEMBqNW2fsjahUfE+J
 pCckp0QhDifDywJrYWbWMGb7nY/An8=
X-Received: by 2002:a05:6a00:440c:b0:84f:77cc:63cd with SMTP id
 d2e1a72fcca58-84fb540b2bbmr1275889b3a.17.1786494711802; 
 Tue, 11 Aug 2026 17:31:51 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/riscv64: Implement min/max with Zbb
Date: Tue, 11 Aug 2026 17:31:41 -0700
Message-ID: <20260812003143.225228-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812003143.225228-1-richard.henderson@linaro.org>
References: <20260812003143.225228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 44 ++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 723c21b3da..2ce9d47a63 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -233,6 +233,10 @@ typedef enum {
     OPC_CPOPW  = 0x6020101b,
     OPC_CTZ    = 0x60101013,
     OPC_CTZW   = 0x6010101b,
+    OPC_MAX    = 0x0a006033,
+    OPC_MAXU   = 0x0a007033,
+    OPC_MIN    = 0x0a004033,
+    OPC_MINU   = 0x0a005033,
     OPC_ORN    = 0x40006033,
     OPC_REV8   = 0x6b805013,
     OPC_ROL    = 0x60001033,
@@ -2404,20 +2408,52 @@ static void tcg_out_set_borrow(TCGContext *s)
     g_assert_not_reached();
 }
 
+static void tgen_smax(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MAX, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_smax = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_smax,
 };
 
+static void tgen_smin(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MIN, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_smin = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_smin,
 };
 
+static void tgen_umax(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MAXU, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_umax = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_umax,
 };
 
+static void tgen_umin(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MINU, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_umin = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_umin,
 };
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


