Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26E1E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPf8-0001Lu-Tf; Thu, 02 Jan 2025 13:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeQ-0007D5-Ji
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:32 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeP-0006CN-36
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:30 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so198424345ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841427; x=1736446227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ODJWln5ZzSpU4153pmgMXNex3ZG66lQDw9JutqWsd/o=;
 b=dI8YI7wsyV7gvwNZA6cJeKLtkbJDZrdqRqU1vMuQAhLUGMKuIsu/zsICToFwSunT5e
 llhYP3fnE/x5Jngil9pOFYEEn6HB1KhIJCrW7ZVSMP9aG5TPa5mBBnsDtQtxIVfOAVms
 y4nvh1buFx4i72Xr9AX/0bo5/YWU3yOUcA8zxW1E+K/+V/iZG/Osch0vhDFdzP4uH9aS
 w7SKUxplHq6oWZmEr344htead3qPedGaghkuagBEwInKFQiL/uYowPhepq4ZswNmoPLI
 lsE72FBZxI60U4HoJATnTijvUq7pV/Z0bhHTbFggPi2Gq1NwHtf0HTJ4I1PONyj7Ewnp
 ZlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841427; x=1736446227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODJWln5ZzSpU4153pmgMXNex3ZG66lQDw9JutqWsd/o=;
 b=gSg37lUshNPEIzaZMzizWvjDlB5yOy2hjGx2IDQZc1oc7G2kxH1267lOIz69LtpF8c
 rVkZFdXfnEjVwH1AWxdMnh/B0+m7BGHNSoNzYSyQ+YZcAM6WJ+76x/ccKV3eIUeQgceA
 qhiesYMq6RDlB0HEMkgIJg/hRWDM25EVIGUuEWxdRWN/X22ORU3Akw/nrph7rMOlFI2u
 XQiE5lqJIJWAYkx0skgzPVyELKiYhsiKZJ0l5Ydnu/vcFvHhmW1PH01fAmy84/x0Pjy0
 +q8pHrjW/0r9zrFASA8EYo8CDDdTY+vj10DYUgWvbmKjMMjfhPJIulu+6IDP5p17DLRV
 zyTA==
X-Gm-Message-State: AOJu0YxXqq69hwL56mRBo9istx4ysdoei32XuiqMNe0u9Ihk8fDs2BWk
 sMy619oiJyEO6G4xXWTGkrRCAQUDsmhWphV4zbqsXtNPPF2mSinpdW/buL2+J+w7u9+fY/MO9TW
 K
X-Gm-Gg: ASbGnctaNzvk0zxlQP40tIDBW92a4+YGU4jRXpTu5U8PCSOJsa7Pz9uPlt5A4LVY/kS
 3EnredzwKHXiMgmnDwoqLP2xNiExCsSuyh49uFCRAidQ83OAoESkInJW07247vAxPldDM26eKsz
 fTf1xV/V6mEj/Q/IRZUecrBuiNYsaLQp5n+BkR0wXSdddJ0ZPySi4o9Ta0UPKm+4wlYzmXz/9CV
 V0Kty84lcLxBxfeGhtbgPQr00zsNJ5vpHYPlc1pgr0pvdpo7hoPqLnYK9N/Fg==
X-Google-Smtp-Source: AGHT+IGBzEuO/0mRgE1PA3nEMVK31jw/XPg/FJB+Olr4nwCDVmDCKpBDyYykzTYmP8s+iSkSkqIl5A==
X-Received: by 2002:a05:6a00:35ce:b0:725:eb85:f7ef with SMTP id
 d2e1a72fcca58-72abddcaf2fmr64941995b3a.14.1735841427429; 
 Thu, 02 Jan 2025 10:10:27 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/73] tcg/sparc64: Use SRA, SRL for {s}extract_i64
Date: Thu,  2 Jan 2025 10:06:21 -0800
Message-ID: <20250102180654.1420056-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Extracts which abut bit 32 may use 32-bit shifts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-has.h |  9 +++++++--
 tcg/sparc64/tcg-target.c.inc | 11 +++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index 188201eb80..0acc5301ca 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -55,12 +55,17 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16u_i64       0
 #define TCG_TARGET_HAS_ext32u_i64       1
 #define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
 #define TCG_TARGET_HAS_extract2_i64     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
 #define TCG_TARGET_HAS_tst              1
 
+#define TCG_TARGET_extract_valid(type, ofs, len) \
+    ((type) == TCG_TYPE_I64 && (ofs) + (len) == 32)
+
+#define TCG_TARGET_sextract_valid  TCG_TARGET_extract_valid
+
 #endif
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index fe3e727399..a2a8351945 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1510,6 +1510,15 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_mb(s, a0);
         break;
 
+    case INDEX_op_extract_i64:
+        tcg_debug_assert(a2 + args[3] == 32);
+        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRL);
+        break;
+    case INDEX_op_sextract_i64:
+        tcg_debug_assert(a2 + args[3] == 32);
+        tcg_out_arithi(s, a0, a1, a2, SHIFT_SRA);
+        break;
+
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
@@ -1558,6 +1567,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext32u_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
+    case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i64:
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
-- 
2.43.0


