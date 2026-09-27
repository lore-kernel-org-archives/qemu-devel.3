Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28339C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklC-0002zV-Jl; Sun, 27 Sep 2026 05:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkT-0002Ua-9y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:41 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkR-0007Sb-AK
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:41 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0eeda3e03so309306a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499638; x=1791104438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1l0lEFmU2w5fumtakCX5Ty73mUn1YU9TFhC7QQAPdwY=;
 b=WSt4qKSW8WBO3mkqgS3Gzm0cAEW76oqYorOcXPd+0Z5z+iCuA6yGE5ZDp2OTzUu4C2
 pFwzEfnciOO9tnwRjijqgI8SE95aLD1GGbizJkMmc0+OBd05uV2hnO3KwihYhw/zPwwG
 EYZdzm85C1cizqqTuRmuRgiPCC5bWcA6mdad4RuB6yVLSykOjxM6+07yEPKBjbhSrXiF
 36AXWhLLsnsW2ZfCpsvAml6urrHJbLlWbNUuppWdesCKhpNb5vqcA51mMQgME7xzmp2c
 azDtMlgPsHHkE+Q4aKEIv9ygdHR7F6qlZmWDr6wpnEPyrI57blkS0+20knnPlB9fodzt
 kwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499638; x=1791104438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1l0lEFmU2w5fumtakCX5Ty73mUn1YU9TFhC7QQAPdwY=;
 b=1oZaeTUkqpejDqhqa+FcRJfA3MKJ+k+rZYpEgF/94cLJXWXVSwY+hs6Glmps4OUZTo
 LG7BvM93CD0jPeqVpscMPdM90PvB5QQUtnIB6t9cmZlQJMeDva8XlfkyQK6PE3RpeaxH
 VR/SFAHqY/Lwwnq9XlwTQUIx6kwsEhihf8SzNnPpCP5AKhbiRuvOGSNJ83Mq9gWGc0Su
 uiPmVgEAnzwbKZ8aNdlaaQBU9kKSxNpi0we2UncAWGYjeKOKMOGDqz9in85zp2w06icv
 TlsM9qK5XK+MY0LeAKWgoBTE9MUhDg8NuFDb4oDDJEWpucbDnf+P/WduF+B3r2GzfR2n
 ZLOQ==
X-Gm-Message-State: AFq9FYIY2YrJjvLRVpiTsvYgx5YLvTQnqjtvzK1Yy6tmKfriv+lmEhXD
 UbFeWQnenu4bw0XU/UhObzfjs3YxbYkndiysAcMwPY6QCG82/qRSuGio1hrmVM0ZpgMflRMY7FY
 aJXvv
X-Gm-Gg: AYBFou0v1qin5g3nx9qtUU+OKoScG0Qv7I0G36FKw4LHwdRDPqa+af+AZ2uApqncbjq
 OuJjNpnmvRzQLzL33Yt44kstk5nhwO/hvWnDI2YHTai3qiWFsmBSWq6rIKC/n8NZTWIl6k9wOBA
 ANTcpbls7grpiNM7N41UcF+mfe6E7EUpd4e+QY0y4+CVJ3zN8bdPZ6MZOZlL9zXg/gjoD2h+FUt
 WIqzBVdsCUIz6njPo9x4iqrkgKshSscNW+etYitHQoynGJdEveTN6xDE6aGLxuPjnlFx6DbXnQ3
 MaMOxKr4acQrhywrxA91VOediZsb/qcxVzRUtDAfaSUJmbu+JeZE4S9r5iBZ4TeUJqzcdeI8iJw
 rZrg5x8nrAkMJa5721upwZSJr/zedEPmJAAKoBj4Kz3mYN6sfBPxlc/7ixeLoBSFUYqTq+aepus
 +9C3BYhmR8AVym2zKzbtLawBY5+zNDRnzbEnUQ3FbcjWX1MT69ZGP//f18SWHRjAvjdMIcZ3wFu
 fzDI7oR6E/b1P7Ylv630yPUsGvHeA==
X-Received: by 2002:a17:90b:2647:b0:39d:ef3e:9035 with SMTP id
 98e67ed59e1d1-3a0985bd43dmr7543562a91.10.1790499637879; 
 Sun, 27 Sep 2026 02:00:37 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 025/101] tcg: Generic expansion of tcg_gen_shli_*
Date: Sun, 27 Sep 2026 01:58:55 -0700
Message-ID: <20260927090011.10724-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fd35307a848..d469f2b42a2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -217,7 +216,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c1273a10197..c47de1a3a42 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,6 +12,7 @@ DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 70591ba503c..716417bbfc4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -424,6 +424,16 @@ void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+void tcg_gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
@@ -520,16 +530,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


