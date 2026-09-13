Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6CFC88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8A-0001M7-Em; Sat, 12 Sep 2026 22:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7J-0008OO-KN
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:53 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7H-0000yU-RF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:53 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so936286a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267130; x=1789871930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MBA2OMeCqLcGqLC2T4Z3TifKHdtzJ7qoLhKvHMvbtzs=;
 b=G/k5QoJHHVhNlFtOaaYFdw69zfEeNy/nyVOWs5ff/DSVoXA6CxusDMk4U1gnKDFCRW
 21HT2cJAwPK7PGUGgNjqLqXl8uJCM4xna4UYiLkQeJomHMGkRe9QifdIpaggH4ym/Yzy
 Wc/3DF3JURO0r7Q3ma19tNTPl6RSqErAbjfO2M15m2B5fHkCQAz6jzSW31RMyqRS+M3u
 EUGNKj3f0t+mMGET3ir5FVk/BdtVPmCfPWzHCvZdnBnzIkLDINYbp/0HPouSD6pa0EtP
 Jm3SgNTPlzzL8n9bRqdnkcwHVmMnQYJmUykO4zmHSkF6SjkgT7NH52aZwr7Jh/T1QFkQ
 aCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267130; x=1789871930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MBA2OMeCqLcGqLC2T4Z3TifKHdtzJ7qoLhKvHMvbtzs=;
 b=WDB2TcawUdMci0weiszyeJpzSbUBN8/4LHwr866UtVkzGM3+FbQAYlXuMKPiRoFxQZ
 fQaMbXUSCVrSqCdKY5rhhjUqgC8b953/51NrKaGVK8PryUJWRLsxc2Sf5Qm844EtgYyO
 ZCVGJFg3ApqXj2rLkWY/LrnUP6Vat9JwhISLVXX8Tl/G9Ad7MgeSj876TfqJof6PB7QT
 llNBUdNGhT5Rj1y4Gi6JxRTcOC5x4YdhkwVdIh96i/5+RfLGQdBV+5eOcSa/dsLXYlQm
 hqb8ud47Rfeq8sBwJX1ap98V0anqbnFoEJQE80EmrLHHQWzjogtucJfNN8gVcuLSUq0D
 EPYQ==
X-Gm-Message-State: AFuF++n2X7u/7fjX+HVmDtvsBOsZePIsZ0RtignFZamCRXSkduyuOROe
 YejwNtMoTarXCGEbKPZ9Iz9W6AxoG4ea3HVeeG8Rby28Pqd1MXYlGNndebQUqIjHr25Hlp/aPRx
 UqLE7R5o=
X-Gm-Gg: AYBFou2mdWcnJYqgSQTLf6kWc3K48KowWLS51N0Ywu5lMPRh9ZVyYmYwCdtwGU+eXZL
 HBL6SdD5qcqgql9ULgDgMabOHoTIC2YPauQfwvt9yQwRu6rGD40R0fcPkrKid0XgNkKz1w9ClV8
 Qx1kQnNmjhtsIMMBisL3wpVbq7zG+ADDe38u6VXkt5UPK6f3HAf5ok6qXy4eij4OGIxv0huCbYF
 /4daVkoqxCv6wbDPFiYJ74qSyaDJRIZ5qGufqe1RkGtyK7URq/95MpXCDf5SJaid9NIqTt0Bkrs
 DQlWcDjunTjgaNsyG38Jnvv7Z6BOSXm+Q7zgM68AAmH1AI9rIMek1WbNSmISuBtDCQ+QO8vuusV
 1Si85BEXpx/73XQ6OOWxJ7Zq/VbZgwSQ8Vr1zUvi4snX2Mc0vlfgIyX7AzZL8dSXq8mHx5odtcS
 N8IouS9bxlnH8PpFe0tqNvWjt0wEQGhf7qVgHiPiLTn35jWUeXkGoiSRT6Oy2xXifyim8VkIjAL
 Chq8s8=
X-Received: by 2002:a17:90b:380a:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-39d9bd63e1bmr18259130a91.8.1789267130266; 
 Sat, 12 Sep 2026 19:38:50 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/86] tcg: Generic expansion of tcg_gen_subi_*
Date: Sat, 12 Sep 2026 16:37:20 -1000
Message-ID: <20260913023837.741866-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 787dc158c02..11cf157d3ae 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* 64 bit ops */
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index aac64105175..122a71d7c4a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,3 +6,4 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
+DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3168ac71638..b66738674a0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -433,6 +433,11 @@ static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_addi(type, dst, src1, -src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -444,11 +449,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_addi_i32(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
@@ -1571,11 +1571,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_addi_i64(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-- 
2.53.0


