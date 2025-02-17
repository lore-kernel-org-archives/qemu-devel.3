Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C28EC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pj-0002bN-1L; Mon, 17 Feb 2025 14:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p8-0001yh-8O
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:38 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p3-0008QE-Q0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:32 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fbf77b2b64so8698828a91.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820627; x=1740425427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArewPxzX2L3g8+NIrXN+9y4T1awyV4Vx9ORorXETkQs=;
 b=la7DW/W/yYvIeHXxeU7vw3EXenGtRJR2au5sIqfegcu8346raRUms/46aufTBUhP7h
 WySLoD4Qs+RxAKlxZnDRzPHw5YXzm85YE+Pptq9137FgxVow3GjbXTPA+aU5sgJDiDtP
 RJyCQwL/+KQlfXcUWEl7Os9rYJ0jmCRBzCcnd6mPoSTCyx3l2STSgP3pF2+UPO9Y+sgu
 RyV9oFMdwUyDLZYuHl2KRhvTgUe2kFhEOBc6rtws96OK8jK3Z/W16UOl+8xVt0079QYN
 AxWjvKP4D4jKtJfopk2LjGxgm2uQmdMlNaT7NrxpBkv/SUpbpA2yBpksKjwRk5AYU05W
 R9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820627; x=1740425427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArewPxzX2L3g8+NIrXN+9y4T1awyV4Vx9ORorXETkQs=;
 b=u1mgWuVY0XVzRtdnhIGKkkA0JqZS8ufuS5CiMdk9GV8osbTvYGDo5UwS4MlF3fObFT
 vsf+jVQvR+C5oH8g4R6zKzXXnCM6/ZtdAMmHhcYtpo57J1jXwdGfyrqA9qpzHk3GGcp+
 wcvuAPaHPj6idTkS2HT4znCSGUwyZqjKA9+W+fMzKdW1rf1AbkgKAXHbbVp3hS1CfL99
 6QTANDausEzjf9Fsn0jb8PtrTJM8cP4QtEDDn3oalPl7BuqDJNAq85R+ZXoC4Us/Ac3H
 O6EHFk4T8JJ4mfybQc+CYCtU8m5LPDnvLw6W4NO/vfSTQPN7o1bpwArhWnFzzamUvio+
 tMkQ==
X-Gm-Message-State: AOJu0YxP0HFh7EuuoP2kMmfqYBcPlENhFXiA2huLH80Tyn7zz3dfwUHn
 /YK65LJBojmymv/UDoeG9K0Yaao58Bm+4TD4bXUg+/R1gt1nlRzYLf2aarydNdYsv6A6GF8K3tr
 g
X-Gm-Gg: ASbGncv5Y6pUP7EIHAAtXU3MxOxUXwDir5Zyi8DaB4UdzaAlgXSeMSma0K29bh0V+5V
 ABfzna/5O1n1YtOnj3ftlJMUGb4wv3qYOwSzW4yszcBOLZ215rWEKVzeaeJ4T4fcFtjzW83qJRy
 JE2zyA3toQTbvwBEI1kai4JhHYXMNBRxP+rfSVWa8bvpC9/9TeDQehTKOvQQcZ19yCTOOJiM6uR
 lO0ueA5j9cbfVymA/aJcziufe+nF7OaunPrcm4YzexOrDKd2Por6V25bxEzeNg3Ep9p8oLNjXc9
 Ez/dNyaRpngoDrX/FvTVmz54bcE49+XDlV45PWezAuDTtOI=
X-Google-Smtp-Source: AGHT+IG9RMOVw4eSssyv75nfaoAu5e44Rpph41zO26ZLXj2AIIlo6QWbn9nwYPww5+EoU+mkPPDgAQ==
X-Received: by 2002:a05:6a00:2447:b0:732:7fc1:92b with SMTP id
 d2e1a72fcca58-7327fc109efmr6331735b3a.14.1739820627446; 
 Mon, 17 Feb 2025 11:30:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 20/27] tcg/sparc64: Use 'z' constraint
Date: Mon, 17 Feb 2025 11:30:01 -0800
Message-ID: <20250217193009.2873875-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Replace target-specific 'Z' with generic 'z'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-con-set.h | 12 ++++++------
 tcg/sparc64/tcg-target-con-str.h |  1 -
 tcg/sparc64/tcg-target.c.inc     | 17 +++++++----------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 434bf25072..61f9fa3d9f 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -10,11 +10,11 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rJ)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
-C_O1_I2(r, rZ, rJ)
-C_O1_I4(r, rZ, rJ, rI, 0)
-C_O2_I2(r, r, rZ, rJ)
-C_O2_I4(r, r, rZ, rZ, rJ, rJ)
+C_O1_I2(r, rz, rJ)
+C_O1_I4(r, rz, rJ, rI, 0)
+C_O2_I2(r, r, rz, rJ)
+C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/sparc64/tcg-target-con-str.h b/tcg/sparc64/tcg-target-con-str.h
index 0577ec4942..2f033b3ac2 100644
--- a/tcg/sparc64/tcg-target-con-str.h
+++ b/tcg/sparc64/tcg-target-con-str.h
@@ -16,4 +16,3 @@ REGS('r', ALL_GENERAL_REGS)
  */
 CONST('I', TCG_CT_CONST_S11)
 CONST('J', TCG_CT_CONST_S13)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 527af5665d..7c722f59a8 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -76,7 +76,6 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 
 #define TCG_CT_CONST_S11  0x100
 #define TCG_CT_CONST_S13  0x200
-#define TCG_CT_CONST_ZERO 0x400
 
 #define ALL_GENERAL_REGS  MAKE_64BIT_MASK(0, 32)
 
@@ -340,9 +339,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
         val = (int32_t)val;
     }
 
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
-    } else if ((ct & TCG_CT_CONST_S11) && check_fit_tl(val, 11)) {
+    if ((ct & TCG_CT_CONST_S11) && check_fit_tl(val, 11)) {
         return 1;
     } else if ((ct & TCG_CT_CONST_S13) && check_fit_tl(val, 13)) {
         return 1;
@@ -1579,7 +1576,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
@@ -1611,22 +1608,22 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, rZ, rJ);
+        return C_O1_I2(r, rz, rJ);
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rJ);
+        return C_O0_I2(rz, rJ);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, rZ, rJ, rI, 0);
+        return C_O1_I4(r, rz, rJ, rI, 0);
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rZ, rZ, rJ, rJ);
+        return C_O2_I4(r, r, rz, rz, rJ, rJ);
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
-        return C_O2_I2(r, r, rZ, rJ);
+        return C_O2_I2(r, r, rz, rJ);
     case INDEX_op_muluh_i64:
         return C_O1_I2(r, r, r);
 
-- 
2.43.0


