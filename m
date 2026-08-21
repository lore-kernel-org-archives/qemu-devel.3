Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEE7C5DF92
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0Y-0006Ht-Dn; Fri, 21 Aug 2026 07:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0X-0006Fg-Aa
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0V-0007JD-H0
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so5573695e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310114; x=1787914914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yQ/G37RMTnfkm692k/xkc06juSJPOR7nps3h8OgUkOE=;
 b=bjmAycmFtYDaeUQQ0G/ITNVqovaYNxcqIzkKg2ZVPMBnBAL/+RWzt0LuJjXS+5wOlZ
 iI2z7XYISanvpH9i4Jou1KxH/UObCyN2NWB9+zaK8zqmVkQpKTsw4zYeXDCTZHKFSi9g
 +ZTiQbDmwyLPArlPftt/Gl9yCHTvQGHGQadQLna9L2/ge+bKnM1pgRqEIyAlVZWzHW+R
 WYvXCr4IMWUzEkc31nbXx6ksSnr4wGAYAZvwEck7DxP6fTSk87juXVVqyZ/Ms6IU6lZD
 W+2Nq6e9nt+DiIBLbpa1aIYSDjs+Ni79tvJ0Ugu/nAfyUzcfUrBd50Jr0gpR4XDhzcRK
 Q27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310114; x=1787914914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yQ/G37RMTnfkm692k/xkc06juSJPOR7nps3h8OgUkOE=;
 b=G7T9xnsDbLbBcGRDhWxyDxk6OHO7Z36cQ/3E7A5ENo3RWBw+XFDSqr6jdxXgmkvXGc
 o5O9GB8AUZ32UcYg8CmcDckxoZQxeqvSE95ZTjqdU/Za4jBYmn/YdeRU+rqEtgWOVFJG
 /Rjz8oQzml9NTrfRiJYYtzgi8mWDDhLKGRelmR7UxLQ1cjkmQMiQOdpF4BSPPeoOG3wV
 AHI0sCrvUh/CespSdkkd4Ias1q4VWnduvoCYVEqqBM0096B5Ho1oOxAwCjzm8ZJtZjpQ
 w/UBW8nyWqeRuN7V8vw5STZnBiNSxyJADytLylHmogfxqLQzmyHcswSkdwnPxPxP4PDL
 1UmQ==
X-Gm-Message-State: AOJu0Yyuyl5XkOin89gidlsVXgA2AUk3WIZwVxtePw95gl8Er5Emidzm
 z1PB+T4IbX4t2m8QLqLsVkKaLfRf/0B+aLSQomdO/DH6PScfCUpnbguT/EDQ4obyYCPoGBgE5eZ
 eJjiD
X-Gm-Gg: AR+sD11Q3XJfPnJDKk8G7jM6/69OXYOBGpChhx4+CaHuvJEH6iMbQW9A1ezX+l+kvK+
 NudXxMEtsZ6x7w75Xb0DhmmlnPX6WZSwiyS/uz7ViZxY3mtHUhAzLO8KWdXu12fEwPfgAvcyuFV
 pduw/Oa2ji7oAIzZCkhx6b7rrW8GQiepyt2+qtFe2rzo4KY8767IxZRp0DUq3xIzy6rJt19Q1rJ
 TBgUEtfbJ26jFzq1pUP33df5GFtJFqKJ/fGlzkcwDJ+zeRYOwSb52JqGou1u3YN8iXq5+gnCg2H
 +XSV1ordZnG9oO2G1ApkV4jxPO/xgMJ0Gph62JOLAzQHNcfb1chGLaJ9T93+r/TJ+b/NccpB3X/
 Gl2sma/D6H7wTa3721LpZkfpNdCZbtJNfCb0ZMonOUL4Oq/Im8IPPQTn7i7JMH0lYSBDSpfBGvH
 +j9X9NWy8NO1A42ypes8B+il3gHyUSULcT5cKGZcX6Rqlau7cQztJizoGjXOhaxLQKXbdhpJGD8
 /g6YcWOrJC1IRIg57KS5KNV5gJUEi2PFxc6ZRgmw++RNTmnzHu1aUGF20rQ4axZas++zDU=
X-Received: by 2002:a05:600c:4f87:b0:499:5a50:b022 with SMTP id
 5b1f17b1804b1-499b830d220mr70720325e9.3.1787310114003; 
 Fri, 21 Aug 2026 04:01:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/43] tcg: Export tcg_gen_ussub_i{32,64,tl}
Date: Fri, 21 Aug 2026 12:00:30 +0100
Message-ID: <20260821110101.3971391-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move from tcg-op-gvec.c to tcg-op.c.
Use a temporary, to cover the possibility of operand overlap.

(Cc for stable as this is a prerequisite for the bug fix
in the next commit.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260811191540.79882-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/tcg/tcg-op-common.h |  2 ++
 include/tcg/tcg-op.h        |  2 ++
 tcg/tcg-op-gvec.c           | 14 --------------
 tcg/tcg-op.c                | 20 ++++++++++++++++++++
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f7b6aadb508..9b321f959c0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -163,6 +163,7 @@ void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
+void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -276,6 +277,7 @@ void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
+void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 568b78fe81d..37211642365 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -153,6 +153,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_umin_tl tcg_gen_umin_i64
 #define tcg_gen_smax_tl tcg_gen_smax_i64
 #define tcg_gen_umax_tl tcg_gen_umax_i64
+#define tcg_gen_ussub_tl tcg_gen_ussub_i64
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i64
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i64
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i64
@@ -275,6 +276,7 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_umin_tl tcg_gen_umin_i32
 #define tcg_gen_smax_tl tcg_gen_smax_i32
 #define tcg_gen_umax_tl tcg_gen_umax_i32
+#define tcg_gen_ussub_tl tcg_gen_ussub_i32
 #define tcg_gen_atomic_cmpxchg_tl tcg_gen_atomic_cmpxchg_i32
 #define tcg_gen_atomic_xchg_tl tcg_gen_atomic_xchg_i32
 #define tcg_gen_atomic_fetch_add_tl tcg_gen_atomic_fetch_add_i32
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index bc323e25009..27f3807b004 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2399,20 +2399,6 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
-static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 min = tcg_constant_i32(0);
-    tcg_gen_sub_i32(d, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
-}
-
-static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 min = tcg_constant_i64(0);
-    tcg_gen_sub_i64(d, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
-}
-
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
                         uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e28944cf720..28d3b2a847c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1328,6 +1328,16 @@ void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     }
 }
 
+void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
+{
+    TCGv_i32 t = tcg_temp_ebb_new_i32();
+    TCGv_i32 z = tcg_constant_i32(0);
+
+    tcg_gen_sub_i32(t, a, b);
+    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
+    tcg_temp_free_i32(t);
+}
+
 void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -2523,6 +2533,16 @@ void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     }
 }
 
+void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
+{
+    TCGv_i64 t = tcg_temp_ebb_new_i64();
+    TCGv_i64 z = tcg_constant_i64(0);
+
+    tcg_gen_sub_i64(t, a, b);
+    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
+    tcg_temp_free_i64(t);
+}
+
 void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.43.0


