Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0416FC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Js-00015O-42; Fri, 28 Aug 2026 18:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jp-00013t-Lo
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jo-0004VD-5V
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:05 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso1600205a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957103; x=1788561903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u+s8HC0IZHR8hWuUBPldIbaMBtRwDmnsxDWvuogbQCU=;
 b=P27VtZh694c9kQEUDDdiABnPbS/yR9L4MO4ac+XwRrARWcJOUWA0ZLiJbhi2zPOh2X
 KfjDIWzYI1KIc4Q8PdKa+g+oG2KJfrlF/n8HwHMss1g81mXpM+S/Kc4rtq9rI72LQ5iJ
 ZO2hwtjavg4tK49MS/NG0vAUZS9PJcDv10MLqiLiacjbGBCbGrfruLONOU+VP8l3/mNs
 TI3nRBq9+l+MLD3FxsGiRrlmSVEIGn3YZHXNAJKYjHluiScosd+vc+uHY2ipgDW7k5ql
 OsUgcXFHxnqOWKfEhU9/DZoNNBgWLcgIAXVDh/glLP0pITeJ/2hwNJftW27ih0SHQR3+
 sDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957103; x=1788561903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u+s8HC0IZHR8hWuUBPldIbaMBtRwDmnsxDWvuogbQCU=;
 b=DxZx9YahFvK6dEK4sn/BbLnmkiPjGeduPDd4KbIZ7l/ZU+AraNNu8dRZqBrbA9W/li
 Q2+04Djq3F+QlPlIq+mD/sggzQjQkNhanGzuHMP69A8/kdVJgFeLxgdAGpk5GlDzI7sn
 2s4gaw6tV6T4NN5YtJrw5ZP/T6FSx3w3H2K/s2iCVAyvhORkQrYxXqbSUlkjCsiFo0et
 ypMUTSDOul53buk1Tq9V6IIdvJTToco1IhAO0FCbn78gFW+r9U4RN9BEz/6sgmnkrGEc
 OVrI9DjbjSia7wnze2KlVP/w0KjiFbxZoqWf3LvveLohxSa5OU26Xp74w+dGIkFFXNA/
 Qg6g==
X-Gm-Message-State: AFuF++lA9IErrzQI+UWvaIAlIU+m8tjCmO59xPUOpznQdzlZpwAyFawO
 JujzrO2ufIRfXYIZeoPEIRXs3vNUt7jl7ZHYLNQljdXsp9xI8+dlCrzCa1GdXawylMK8u3AOGvP
 JzPNFV90=
X-Gm-Gg: AYBFou2ZP1PwHHWovPz9Pj5k25liZH7/wV40u7MUqdiOfcBXZGoweaBsq11WDuIDv2N
 X7Sjbtk3aeBu+Y2Ujfo990+kM/G0nbTRPErh4CxwZbwcGcOHZvcfDIzG9mbjo9Os/DZvPfnZTLX
 V0RucRMsOAv+pY1DRp+swXJ1aAISATidC4OT9I/7hM+k4k5x7GE3FuSMBBQ4EOUDo9C59ZDdFQx
 KvS+Hqki84IW5wGTqmLmtIpXhyms8R3L4vIIjxeQ+oIY2EruH+jAJM8dmEpUwFqL3Qh9LMHtx3P
 yOX+YpvcL7tYfZctnBvwZU3lorRfh/8PB47bXSJZ7ji8U0DVVM7yD+5GEmXWY05HUD7vN4k6gke
 b+1QoqA8DhXT9wcmcqnImuHDzL0P4Kb9Cx0QOPKz2+LG/YTZxRaNt3RdprXII1WzHhuMzYJ4pxT
 FSdVGNi3y6iuvcoOWmHEJybuSl4UbjRkMIcXh0h8r04Ki3+vGkM1h0I974vIo5fMJYGlLvPFzb/
 R/0NAU1nrneOtEoo1PX
X-Received: by 2002:a17:90b:37d0:b0:385:3ab:fecb with SMTP id
 98e67ed59e1d1-3989b565671mr2564872a91.4.1787957102815; 
 Fri, 28 Aug 2026 15:45:02 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:45:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 13/16] tcg/loongarch64: Implement INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:48 -0700
Message-ID: <20260828224451.1564072-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 tcg/loongarch64/tcg-target-has.h |  4 ++--
 tcg/loongarch64/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 31e6ea9632d..53b7ca40571 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -54,7 +54,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) >= 1 && (sh) <= 4)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == 0)
 
 #endif
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 17784d8bbe2..377cd9ec08d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2098,8 +2098,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sladd_w(s, a0, a2, a1, sh - 1);
+    } else {
+        tcg_out_opc_sladd_d(s, a0, a2, a1, sh - 1);
+    }
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0


