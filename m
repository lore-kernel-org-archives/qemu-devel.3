Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6DBC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC7p-0000rN-Lo; Sun, 09 Aug 2026 18:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7n-0000pT-Oj
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:11 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7l-0007Mp-Ui
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:11 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cb5a6aa8760so607901a12.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314969; x=1786919769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FhxLDO3O9RIWT94V76RFafGB0Fmi5VYVrOZhU1ZVb60=;
 b=LpOUoh4WOgWDzJrl08C6AKMDjEzcBX11+W4iWSvyXiMe/ak5pHcWRhE5mZOh0wrjR9
 xhYNaCCDTQoMA79GQjzgNxE9td9rVoP2nG9d+q+1AZ5NxpvTVJjyJWfBtq3pnoAT8d4Y
 6b0Fs1xKyAGUbycLEVAQ+/I4XT7M3ZvR+Q8mEdqsiYXjqWWme/s2+Y6Ce2K6N6B8fQ1q
 2SxEoW10J4RvWCTUbOifoZMnV4rLdXITqx8RkVgvzsmZcA9CLglpye3nXLJUNmQ1wQkV
 vjqPw9dgxHpXQLMVfgUSwbumFoA/k2mpM0/UQuUb9nb6VdHawj3SvIlTZx403AjdsYUM
 uzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314969; x=1786919769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FhxLDO3O9RIWT94V76RFafGB0Fmi5VYVrOZhU1ZVb60=;
 b=OMAyEfUgNGUHeaOsanxaQj+UafXTLJ09QMwRlUk2cMl5hBO+ItL0SVE2KGkeGkfZi/
 oSDqUXYc447uw+Ukv1Feh7GvqWf42jRtKbvIvnCLpngV3kqCbfjrby4vO/TRTusQxZlX
 Es6On8D60qn1f0nNPI7gtm7qqAPsT2Ms+ipe5CcJpeTxK2iKuy6b8iIIG1B20fUCEN2E
 LNhxrUJSpeuKF9IicV6ph34XvT/dddGC5RBUnDS0hs6UURIFhX4sRfDLJjM1znHA4QRc
 GZMy2L6szv6dqhT3oJZeZb4Z/DCwBrwt6VtMhzu0UE/TBgJMOEvaVrP2y1rai2oagr66
 PAzg==
X-Gm-Message-State: AOJu0YwkJLK1yRq2CoQ72zG77elDyILxfM7LSW04eHFzUxyFzofJGVgQ
 es6ggE6aiuQL1/gwcH59LP6Ga2fSi+XS+TzNIGDxYVX3vPX2M3D9E1eZsccuhANTzpUA292yz6o
 uWy7I
X-Gm-Gg: AR+sD1343mOQkrL7vuKy4EtiNsIc0SJN/grDG7ONedxptn1ACdASxfptyP0hNPle+Mp
 z5khjCU8BRsWHKjBExe0hBD4DjwBi8ZmRxtR67j6QIFvZ4UvFGlPCJZSe16IrgJme8dicflGX6E
 Q5W5gGXUoj5VwHVP1L9XT8qNkbb2KRxwPlwFw5V7NLLr8kvRTMZWToQKqWXuLQd4v++DWm+zeqB
 pvTZkEvEqUJEVfwPu8uMryTSByu9UBjryJRJ6a+eht4HTwEQixuedDJfUMvCBIpLwIw12Bhl0w3
 CD1lkOESz3Sagn3hQZ4OSo5wD3UO294999yLEilAGrn3GNU9UrCkqDcvS4vPqOzZ/ygWPzpp30u
 Clw46LY4UdUjISu70F88hazSWXKUD890We2Kh2uwlY6hnTCNS+0QCMyFbhlo3pY0BTo25xYYVDr
 4jqdytEaHPsmZouK0uIRWq4LLSOtOXGmu5RmoG/c0ObgWvVIf0+F9QmY+TEaot464wUzPw++ToU
 4fmFMiQARSC2g1Z5AXrn2C4ZZ+7rpG+
X-Received: by 2002:a05:6a20:430b:b0:3c3:954d:279a with SMTP id
 adf61e73a8af0-3cbadd1bc8bmr26752320637.33.1786314968582; 
 Sun, 09 Aug 2026 15:36:08 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 17/56] disas/riscv: Drop codec from rv_decode
Date: Sun,  9 Aug 2026 15:35:06 -0700
Message-ID: <20260809223545.730664-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

This is mostly write-only, only used in one place;
other updates are ignored.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h | 1 -
 disas/riscv.c | 7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 3325b7b4ef..31bb0db86c 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -197,7 +197,6 @@ typedef struct {
     int32_t   imm;
     int32_t   imm1;
     uint16_t  op;
-    uint8_t   codec;
     uint8_t   rd;
     uint8_t   rs1;
     uint8_t   rs2;
diff --git a/disas/riscv.c b/disas/riscv.c
index ec40abb618..9813d75feb 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4603,8 +4603,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
 {
     rv_inst inst = dec->inst;
 
-    dec->codec = op->codec;
-    switch (dec->codec) {
+    switch (op->codec) {
+    case rv_codec_illegal:
+        break;
     case rv_codec_none:
         dec->rd = dec->rs1 = dec->rs2 = rv_ireg_zero;
         dec->imm = 0;
@@ -5369,7 +5370,6 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
             if (check_constraints(dec, comp_data->constraints)) {
                 dec->op = comp_data->op;
                 op = &dec->opcode_data[dec->op];
-                dec->codec = op->codec;
                 break;
             }
             comp_data++;
@@ -5407,7 +5407,6 @@ static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
             dec->op = decomp_op;
         }
         op = &dec->opcode_data[decomp_op];
-        dec->codec = op->codec;
     }
     return op;
 }
-- 
2.43.0


