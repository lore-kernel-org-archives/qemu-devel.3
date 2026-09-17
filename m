Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDFCC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kK-0003IX-Kd; Thu, 17 Sep 2026 00:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0003Bl-PN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:00 -0400
Received: from mail-pz2-x28.google.com ([2607:f8b0:4864:3b::28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jo-0006nE-4N
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:47 -0400
Received: by mail-pz2-x28.google.com with SMTP id
 41be03b00d2f7-cc1cea34f01so331049a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619322; x=1790224122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zFSVA5B21DK4J9Z0Sb+FVIBRZ/HkG3ySKftoKO00ANg=;
 b=wJIXPZCBdfvtZqb8bt5fdu9pNdC7y+n/rciOFGfsGywSgrEWL+1aWH6NlHPc2TXFSt
 Jbu75A4BvjYhHTF7xUUfVe7WnImk1lozKNW7y91mFrWPulGgAkC8oy1msM+PqiI4/0zK
 SYc0Wc3GysdlJFgoyJslvwbW3U5Oo1fZ0S1brcPWZ0xLePGpghxCYX5bEuFCNVR/jO8X
 K0AmHjuD/5fZ1TB23Zt3EYRauifuqOH/LZj+tmrIoiVXd92BWrZ+YKzPjSdDwCNEFqTq
 nMgbiC09K28figZDIQqj9tePDdgx/vpv+x5V9NSX5IMKQ4QRF/WZjRgi/dSeKVSAkiN0
 znRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619322; x=1790224122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zFSVA5B21DK4J9Z0Sb+FVIBRZ/HkG3ySKftoKO00ANg=;
 b=j5nEZq+/UTjMX2/hi/ZhUmSPNReDAr8OZksQjfAqtjlR9FnFR/Hq1Jsp5e+Fz1h+0x
 fbFAntu+/PXlUI+wVFTt93fJjokzL66oKZ6luOqTEaHRmrkXt2IsdOgBdQRZgjYBOk1l
 U/dhnxojV507NKvNrVoEoguvaW/oMzesYvZsqscBPA9Adm59lJjyT4GpP9ND0hOKEpUu
 Vt2s+rBsTG/fZDfd4OgMuI7mC79sO5fchMS7rVIQUz3BYXv7AWKgj6TCheYPswVEBMRX
 XI22nYhuPM9VMTX7nPCw0RuFh6VbiSg5CHYXyJKHAUvmPbu1/grhpsjWbhP9wKSs6e5D
 lqtg==
X-Gm-Message-State: AFuF++nOgClGRPhzNEEGv4tQ7nJiQ4NWkSW11e6e9OJAs8OTVlQI9583
 OYcFzDJAHeL7RHgVTyYVbe9h91Dv8NQ3foKcJr4bSScsa4AYAl3Oe5XDKvWpajwtPerzhjt5kUM
 lo42TnRc=
X-Gm-Gg: AYBFou2YMA1nm99ZWg0F840Es3TF0L6dmqxhXdpFZz8gTZ87vSID8OA51BzfqW877MI
 SeWM7r8YhYaHXa76hzdJdTgsOKqT9ImFJH1TlxLRAPPsH5FwCZ5++7SxJ8IoEg4b2lL2CCoeZ0T
 i6bpSCSMpe1wCMmaQLd8M3fOKnN6MI18/wmGTrMbnf9j141Ye6UqUGmIwdiP7HDsW8kbjFRLBAr
 wIjiISqBzE/evV/pkqwbehILJZR62mpKSiMy+hRtq0IkVsuxt8QRECMPm/Ug1gOaj3Wl4BQOVf1
 Ynjl51h9/ktUb8q5z9jE8nsrp2xMAtgIT1OtkPRIJPabSMmXYWuaJKvE0YdAc7xJKEB+RjZXPRb
 FxGA46pjbhmZaP8ICiAj4HX80LFqvBheeMGQEUoYhuY2b34yNwB4QxqC6gspUJHWGH0MowmeYdx
 pTe1c3tbA7K97QYHQ2dOTL3qSR8DqCNpmD4ZQ5RG1eY4dEqPT79qqABy8iyAelT68DbufQlWxg0
 3HHXY4=
X-Received: by 2002:a05:6300:68c8:10b0:3dd:7a8b:2e88 with SMTP id
 adf61e73a8af0-3dd7a8b2efbmr1193808637.15.1789619321741; 
 Wed, 16 Sep 2026 21:28:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 014/101] tcg: Generic expansion of tcg_gen_sub_*
Date: Wed, 16 Sep 2026 18:26:56 -1000
Message-ID: <20260917042823.542588-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::28;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x28.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 13 ++++---------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7e6e17b2316..6be93865326 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -212,7 +212,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,8 +314,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 31982e2dc6e..aac64105175 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,3 +5,4 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(sub, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6a5081cf74e..be0db3195c2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,13 +428,13 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
-/* 32 bit ops */
-
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
+static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
+    gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+/* 32 bit ops */
+
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
     if (arg1 == 0) {
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-}
-
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-- 
2.53.0


