Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF21C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73qo-0003FO-SH; Thu, 17 Sep 2026 00:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qk-00033T-Aw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:54 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qi-0007uv-Of
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:54 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso317736b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619751; x=1790224551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KZ/JTifwIcwC9kSvJjXKajKChFluEZX879vyjE9MhOc=;
 b=ZrV5D/bWSS1LXbjDx7QYjWbcE5RPszPUFVpJc4bMwvQ9WWJv7fd9ccesW7YDPqbP/+
 yWICtDQYRAWsJNyweRtx5iEsXP7F6FUzM0hSLhduGsFTyggBtNdehOsChsTGTjIOsv8l
 OscldatJNYKHAOPoFh1pkXbDEBnLLTlHWfLSMCyxNGm2q/3mp1dWjgavu1gLLKuW7SyP
 v7lwpekVFtVQM1lyYrXmIP4B9sWry1wB9MDmrVvCqXwhn+WCnwrgHCs0NUzbFzviUIMO
 DdiwKZFMe8CLgf4qXfz3ChEghKrhCweADQM7LXQ12uOXxxC5YClZ9nefnuooOA7Axol5
 /uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619751; x=1790224551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KZ/JTifwIcwC9kSvJjXKajKChFluEZX879vyjE9MhOc=;
 b=OTwfRUNIuwn4H7kwB+yg9f77BiEIdX3UhGhn8JOXZQXpAA0U4qC0he2k8lNTDrtnH9
 8JPBCexpvvrdSKxhmbP9mBekF10a5kFzWgTSo6m4Yz3u7rdksb89gQpz4FYJx/uBBbQ2
 A0Emp4UBB5/K/7utXzupH4R+agUXfBwpbaexd9HTkqE2Mz55iKOwhkfVOVqoUKPgV7O4
 VuaLTn82Zxul1+vfKgFSN2ohrPW1HQreD8Bdnc0ZuUwau4BuHHG1T5vSUPBpyHvvIuV4
 5+R6c6CEEPLAGF12uYDA3i8t6jgxp82mIMuKLOJfSYGClkOfy8Eyw1pXlpTgwjdzdbwu
 kOYA==
X-Gm-Message-State: AFuF++m9K6JYXGG84cW4s2AR4sHac0gSoCDzLnIAnC4012PUciiSG4EF
 AENrJNk9cLgsTojSCxzkqTBYv/rufwPFGOKzdvBV+VfiGnagFXnywv7On2YVnpwUjrQgzSKTvA1
 ZWN9RnTE=
X-Gm-Gg: AYBFou2cTJtAYGHb8UE3gNFGJYF8ffda/RbgBFv2Tfh1u82SUfxVlWwlcdTPCWBtzki
 CaTblJw+RAZYxxgukL+dXnDsR1z7090fZRq39SXqu9ppEBihrN2SyFcw18mnojxjsv0gVXV9y/H
 veEMx73A91WKNB4yanGALPL1mamADj4s/KGvoLRZBQ5yuCJGSwvd9PN1KxH6BklduEm6tZek6ZT
 dbunKBDDVDSjmpcradATAEvR4KPq+/KxGyroQCQNhAT9Ee1mdbm+7WJbPtGRXb/VBEZ23P3D6qL
 GCtSuDsWPswk/SZJ9rWoENiBwvxiFa02hxhJSpaSBlsKbRaLwkR/haQKZZ70kkYUOb57b0h7jZg
 2r6wV6WiyP4V2s910xirhiZosBsu5rpBm6I0ACbwq0ZmSoksTHV2pa0rz88ToVBIAum+ucMv1u/
 iQeTv5w+VrJhHF7jI8lq1YFMqQ+d/EuhbtAP5erTx/2kbnOjyfs83B1PnmxgcIXfYYCxkGY5xQC
 39lZwc=
X-Received: by 2002:a05:6a21:1343:b0:3da:f32e:b3bf with SMTP id
 adf61e73a8af0-3dd5f5df79fmr13142088637.17.1789619751124; 
 Wed, 16 Sep 2026 21:35:51 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 080/101] tcg: Use umax in ussub if available
Date: Wed, 16 Sep 2026 18:28:02 -1000
Message-ID: <20260917042823.542588-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
 tcg/tcg-op.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 31c82cfe2fb..a97c0b2f765 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1192,9 +1192,18 @@ static void gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
 
-    gen_sub(type, tmp, src1, src2);
-    gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
-                tcg_constant_internal(type, 0), tmp);
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_umax(type, tmp, src1, src2);
+        gen_sub(type, dst, tmp, src2);
+    } else {
+        /*
+         * While umax can be expanded with movcond, some hosts can
+         * perform movcond with a zero source in fewer insns.
+         */
+        gen_sub(type, tmp, src1, src2);
+        gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                    tcg_constant_internal(type, 0), tmp);
+    }
 }
 
 static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
-- 
2.53.0


