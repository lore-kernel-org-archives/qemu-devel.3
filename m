Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB94C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxZ-0006oZ-Jn; Sun, 16 Feb 2025 18:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwm-0004Ux-BX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:14 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwf-0006T1-AX
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:12 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso5329295a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748060; x=1740352860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0VK2es5HvnlFV+KBVLbNl2wz4jrx4AhtL6ozpqvrfgw=;
 b=ihExUKFEVa7NGW8MkVNr+upYSktamNHusVYsRZmQMoxvAVUlVzogdcfxis+q0oLIle
 Cf3yQgf/uzYvuRQuGzr6mn8D0IaJyxiMTHzPPoIcmxLXWHZhZioAhII9lHL632v7OKhC
 oTSHi43wnlF1CyZgzaNQyqsdIj9FMkOCiGUvGh66vKec/1VDBNOFT9dZQwOc+9Ht1aoT
 nPZzieGK2DnfyMheACXPQRg8gjwLILiAWX/npfuZwi+FNdLiWr9eAISNxyc7kNzhlBht
 bzPUHBGdj6BWVf5T6VDHK0RB9WKbyp9+0OAnTW+iIijJfoMeFSi3XIeeqqgLIhVz2Bch
 Nq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748060; x=1740352860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VK2es5HvnlFV+KBVLbNl2wz4jrx4AhtL6ozpqvrfgw=;
 b=PNSGG7Mhnh5wn6PtbeG6AlTI7cxlCtWTDn/hkxwRs46Ua6R1syB460kOJaGU7rd54L
 /K053aigOgMyuzwruZy0N/P1nxusuiwFlG0Nm/33lqU9CUIe/vSMlFONvtA3HQJj2T59
 5kHeUrlO28EO+jNRtbdiDUCuhhYb1qXfb36HtCGs8TJhv6o9vmIt/8rmDWij1ejln0J8
 K2xGQSICZzEKC+cKNSAiZh3TB7LsUMfwtgCejf45LsgzkBL2KOxuGGRyNs+0gd7xEOe7
 /tJsFLu0U/yqvO+RBfkLptUGZLVPScg0FZ9y2UrLwTqxlXTIP20JCQlaXygz6T5J4lAS
 Pqtg==
X-Gm-Message-State: AOJu0Yy/7LQyB/PpQ77TT2B93a0rjt/0qQbNuNR2rHaj5xyEsgHFOSE8
 eTeDHUm/Uhi2K1vTGahdXmL8CIIcZ82zeYI3WYn+wSJH/9+2Fsm3cfk1SmCZLvWg3+/LUCcXVde
 +
X-Gm-Gg: ASbGncs6HWdcy0gch8V5QEYgr9kepIshhiFFWLyMKxKiUpSDMrffG8XP6sfoEd0cV0z
 eAf/DKaf8N5DoSnqJLcXQ97vjjfYY9r47r8GkniyKuL0avXNLrxyoM9AI2sAQZ40Pr7DMFPp1ww
 dRXl3V3HgWEZTGa+yO6T7kWq9EvcMCfGgbTME9HSAyBvQAzL8+uR1pWelzxFaypwjhG1z5z6Ymm
 qmvV7fr+vI1kLBFw5j4eX5l9DB02HWHlK3Zf3lSfq6b/dQzNC72Y4QFP7pCNHLMD4E0dAW4lIb4
 9HH3oC1gCn6MLaMUJ0xA4zNVPzX2FFg6CJmNu1DlBhGs2ww=
X-Google-Smtp-Source: AGHT+IHWMsJvG1ssqcgnDOLP/5D1y9YoHiVXTlO8YTnMUnf6U3aBDX+9tcOqe4qGr51lwSUVfzBTdQ==
X-Received: by 2002:a17:90a:d604:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2fc40f0f0edmr10653444a91.8.1739748060431; 
 Sun, 16 Feb 2025 15:21:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 139/162] tcg/s390: Add TCG_CT_CONST_N32
Date: Sun, 16 Feb 2025 15:09:48 -0800
Message-ID: <20250216231012.2808572-140-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

We were using S32 | U32 for add2/sub2.  But the ALGFI and SLGFI
insns that implement this both have uint32_t immediates.
This makes the composite range balanced and
enables use of -0xffffffff ... -0x80000001.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h | 2 +-
 tcg/s390x/tcg-target-con-str.h | 1 +
 tcg/s390x/tcg-target.c.inc     | 8 ++++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 78f06e3e52..f5d3878070 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -44,4 +44,4 @@ C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
 C_O2_I3(o, m, 0, 1, r)
 C_N1_O1_I4(r, r, 0, 1, ri, r)
-C_N1_O1_I4(r, r, 0, 1, rJU, r)
+C_N1_O1_I4(r, r, 0, 1, rUV, r)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 3e574e0662..636a38a168 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -24,4 +24,5 @@ CONST('M', TCG_CT_CONST_M1)
 CONST('N', TCG_CT_CONST_INV)
 CONST('R', TCG_CT_CONST_INVRISBG)
 CONST('U', TCG_CT_CONST_U32)
+CONST('V', TCG_CT_CONST_N32)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index e262876614..9b28083945 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -43,6 +43,7 @@
 #define TCG_CT_CONST_INVRISBG   (1 << 14)
 #define TCG_CT_CONST_CMP        (1 << 15)
 #define TCG_CT_CONST_M1         (1 << 16)
+#define TCG_CT_CONST_N32        (1 << 17)
 
 #define ALL_GENERAL_REGS     MAKE_64BIT_MASK(0, 16)
 #define ALL_VECTOR_REGS      MAKE_64BIT_MASK(32, 32)
@@ -613,7 +614,10 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
         return true;
     }
-    if ((ct & TCG_CT_CONST_U32) && val == (uint32_t)val) {
+    if ((ct & TCG_CT_CONST_U32) && uval <= UINT32_MAX) {
+        return true;
+    }
+    if ((ct & TCG_CT_CONST_N32) && -uval <= UINT32_MAX) {
         return true;
     }
     if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
@@ -3548,7 +3552,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, rJU, r);
+        return C_N1_O1_I4(r, r, 0, 1, rUV, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
-- 
2.43.0


