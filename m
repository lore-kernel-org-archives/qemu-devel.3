Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3B8C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mCU-0002cd-GY; Tue, 15 Apr 2025 15:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5n-0008W1-Vo
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m53-0004XV-PS
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:09 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22928d629faso58663015ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745773; x=1745350573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0VK2es5HvnlFV+KBVLbNl2wz4jrx4AhtL6ozpqvrfgw=;
 b=AxrodPG96n8RMtGXHwgWMl//6hMQugbwXG3BxjwosK3icvNAHxV5DJHWjuBmtjznj/
 OGPCCRHESl6eGBek2Ud0LxbPsZrBAMIjSi0MXn5w2yGN2zS6aqehZdHof1lbIGoNG+Yl
 K1LvunMuUhVYP72agkJs287ks13qvteTSlUTU8NNuFf3M5zMeusLL/HSzY8PMVz7mM9x
 5KNpB7OLUax5ke1F3CrSt9ebsAZF/G584KpIW6j5AAymocS+N+BYHq8fkUIOmdeN21I6
 iP9Eaa873YPywSzw2h8vxhFOTkjMb7hFEw6FI7ohHxIaUfWf/C6lnanIe7jYcVZCxLLD
 2pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745773; x=1745350573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VK2es5HvnlFV+KBVLbNl2wz4jrx4AhtL6ozpqvrfgw=;
 b=ZDDt7+iD+1WFy6jmIXIvw5yc69f8X4cSaX3sV9UtQcdVIGYgwH1R8yS4UhrcKQ+zQr
 EI3Fqxh1BDn9CHmVrZS2TLLgFN/RYMugwA/S8U7G+0jSg+pO3DbqirAcfISTZ8AWq4Fi
 UV+X4HQ94FZ0mBT9qEG0g9VQDKK8MQWrZsYaURNC0n8qzMPK7i0+iQDvnJz+Kh7LhCjP
 iZA2kjaazIoYJi2wHVIgPEfz3lVpGS3XfUgvszlzS6DVx58F6FIoc3krHqJS5/ifww2A
 wyFNgs3av5lc6lYhwjGpvQeqCpnRTOmQ5kCZKD0e2C5ukf92atjPBiIBR8iv7cKfHtGq
 yRTQ==
X-Gm-Message-State: AOJu0YyCNOrEBVNix8LIhEkgYEhlgOwnG8W5qExugZ1UVI9TFIne99bY
 rEqitvY0qH28bPAk4wzE1Q5o/qfjY3uPUC0M9Ybi5t5hDD/AHoqV5fr0T4pXr6+BG9QR+sqnHmN
 f
X-Gm-Gg: ASbGnctvvQ1sEq3hKcb5VbJZdcxETKm06xk+aB275jGjr11UKkM9E1jR2/KOJ7kvYJv
 P6D1cmOofMaVczR/nExt2y5d51nTRf0Aj8phA5PxJPT4D6hNIphsWxFutt9B+RVo0ACPenliK4f
 ij+bnHoYUC5EIbJnmMhKuYtCOwOP7yv4mgwapGJnSkTDloN3qEb1o8OxXd5gS31CfgehW+IU3xx
 r/RU7VHl4e2xvXCP0zguss5q3+PnOX6nGthbC337zqpQhPiTihNuyQXvnXhGctmohR+JxK5uQfG
 KNV1ChF7My+ssqLLK9fpX+Mc8IPhNmZakvL3KAj9Sdf4NHWW+MR3O9zywIPfL7iTKqAMzww8Sl4
 =
X-Google-Smtp-Source: AGHT+IEJvPpH8ZZGmZIfCPFf93lEnffZv76ViJvnHY0kycEVO4dc1gxsvuB8Xt9z75fxZGTehXHy4Q==
X-Received: by 2002:a17:903:22d1:b0:224:826:277f with SMTP id
 d9443c01a7336-22c31ace381mr4286585ad.33.1744745772772; 
 Tue, 15 Apr 2025 12:36:12 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 140/163] tcg/s390: Add TCG_CT_CONST_N32
Date: Tue, 15 Apr 2025 12:24:51 -0700
Message-ID: <20250415192515.232910-141-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


