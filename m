Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9877CC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpk-0000WA-Uz; Sun, 27 Sep 2026 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoH-0005XL-0f
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:37 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoF-0007iJ-7s
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:36 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bec20a6fso794986a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499874; x=1791104674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WfPDqQtDwps6T5uO6+6Bxqsag86wKBxeP6r86jxsUmQ=;
 b=jt0BzXZNrFcBPbbeKRroy1+wOBPqUgisliq3Bmy+UobcQYCwVd+krh3IYUWMaZ8Ya4
 Wvxln8Vf+oKcZ5dAEZLnxV7WmNqR2KvCzqRdFYE6P6FljTieG5qVJnVzoh4ELsaILggw
 akmj7EX8AeRaB7mK+ziWyq4NmoV5MOx9gBiqxkPh19Yr7YMjn2Z2N1lMC/oHtd7VKmrm
 pH88F2216Pc2ygSY6JUsspeUm+JCubRpr/5wFGy4Jx8QjwHXQaKMPyNHpWLryqLpCc0r
 VpqIacuT55BKX+u7m8hnrgo7A0k2bcVtSsgoG9MPAfWJdJYdcBSNS7IxZnnHWtRyBy36
 592w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499874; x=1791104674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WfPDqQtDwps6T5uO6+6Bxqsag86wKBxeP6r86jxsUmQ=;
 b=CLDYSMcMzssTeWj0SmotA+N+hC0XcilXptyu8n7lmTeICaWTqEz+zfXdZmAJL0Qz6F
 v/qGIb38nkXeWFKO2qG4ibqMFx2Vog6sV4+J/6KbZT9uP4DnhUnj2m4LeNlZoWW310UI
 wxkwdCgMA2PIA/W+WckUvsO0zbieWStx/B1IoFIoGMBGKu6cLtBQRksh4ns48uYEyPxq
 avcrOyQHWoPeEgxoBsKmDGzn51h2h43M1K4rS+BmBoaGCON0ZVvRPHpmIjFIzgP+W7i7
 XQi/3L7YHJUg62Zinx4hvOHWoGx8IeWGiDW3yasBZzV1ttSePo1p3MkGoaDc0hDX/V8E
 bSTg==
X-Gm-Message-State: AFq9FYIJ+2WTPpQgC8mS3smmKpD90hfhhY8oPr7XuTYIhc/T2/OAMjac
 608IJ3DphWDUQ6PMGfo6nxbU0z0i+GCxH+js/dIbLvOJ9ujj/TNyBht5Y5W9bYe0aBKdwsFZ8Pu
 YjTNO
X-Gm-Gg: AYBFou0PadFQxKvFpiKPcAPeFb/djKGRxynkFjnVnv1zpo4D5xagHXaStAwOvfEiTQa
 7F7famd7tV6KHoMDUl4jU81cylycuoLik80TZ6cRMgovhMlOrvlVJqMd0EvGYaMVgLwLu2olbRE
 BFLuJmqn/Ily8rfEJMnTDKuTurZFPFPdhQ4aLcXdmFeoOmP2cz1r+uA7pJJyMCYeerdkREM99IV
 wH1Xc3OIY285RVmlZRNKXPC6hJ3XpPwG3Eyv0cTDAO+fNwqECgPCppPNR1Ux1QgcFPdmirk/4Ir
 PAoq6tm6wOPnqoLYdlYQlu+QOPYYTpokjkmYQmgg8qcJlJGroz4vAS6Of/1OTLC/vLkb/TXHjpj
 z8najnnpXFDB+BLlqXJrbgspo9ChRQvv+7WMH0DxdazpwjXwULvgu9JoBHonzC649JUazPt1zll
 OHZEZg1/lhimuIVnNVIwaceimUMM6+SPaQcGGzlNbcwUWSmkk35EkZGF98PeM3buo0Vv+YzYc37
 /fU6ePK0D7eyU8C38ePfMY2YuzGIQ==
X-Received: by 2002:a17:90b:1a8a:b0:3a2:bb9f:f87d with SMTP id
 98e67ed59e1d1-3a2bb9fff91mr47867a91.21.1790499873752; 
 Sun, 27 Sep 2026 02:04:33 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 075/101] tcg: Generic expansion of tcg_gen_abs_*
Date: Sun, 27 Sep 2026 01:59:45 -0700
Message-ID: <20260927090011.10724-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 35 +++++++++++++++--------------------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 18130617966..91acfefb1a1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -147,7 +147,6 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -186,7 +185,6 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3c93c207044..19c6347fa7d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
+DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d16830c8dca..67145b43d12 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -331,6 +331,21 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+void tcg_gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        tcg_gen_neg(type, tmp, src);
+        tcg_gen_smax(type, dst, tmp, src);
+    } else {
+        int width = tcg_type_size(type) * 8;
+        tcg_gen_sari(type, tmp, src, width - 1);
+        tcg_gen_xor(type, dst, src, tmp);
+        tcg_gen_sub(type, dst, dst, tmp);
+    }
+}
+
 void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
@@ -1377,16 +1392,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-
-    tcg_gen_sari_i32(t, a, 31);
-    tcg_gen_xor_i32(ret, a, t);
-    tcg_gen_sub_i32(ret, ret, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1881,16 +1886,6 @@ void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-    tcg_gen_sari_i64(t, a, 63);
-    tcg_gen_xor_i64(ret, a, t);
-    tcg_gen_sub_i64(ret, ret, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


