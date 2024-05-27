Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7497C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZb-0007VM-TR; Sun, 26 May 2024 20:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0007Cv-B4
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ5-0003dj-SV
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:26 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8e819a540so2617861b3a.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771014; x=1717375814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OR3Qa4eUXbe55AL25e+hfKaOaNfudQydQzuaT/Ly7pQ=;
 b=QlN/H1JMNM7d2UlxpEl112cpwwJJuLnGKilU494syglbThx9vlieBmimHHBmqomW4m
 k+1kxqqHpRmy1IFWq8WEQwj0ySWzeMBmc1iYbNSqg7yH0h7a1mcC6gg5tBndId+Ztrjd
 oqxd2qXaMCPcxiwFc33qgfXpbZJoCXks3zuoRWEB7Say8ceuMMmpcDkwi1jMQhEMowDY
 8Yuo6d+1yW+3r/vqXlvfLTMKsIpiNJQatw3m/AD4+nzQH4xzV9faZiz08/3qWATZMK33
 +x345jC/XiaN14VaqxA5V4xQ20xaD5NSC0u2YCzT61d0kA2pNBWftix3CjxKUTehGL70
 cMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771014; x=1717375814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OR3Qa4eUXbe55AL25e+hfKaOaNfudQydQzuaT/Ly7pQ=;
 b=m01WpksiZBvNpZUAcwCxtYnU44ZnKYsFLrBQ1lYTLNAm6nZL1XwQsYN5hRCDlovnVc
 cOKrPssbt6N9yTbcMuFoEzYxtKcDy/ucGd88GbgmUm/UNYbiwWpcrU1jV/2tSkAy1rHl
 3tOrgW9DaF2bMvg1CVO71x5SWHv9WWGU2GczePGHAtEmNBZZ78mDhC8+Qow3pFa+r/7x
 jVmjVwNRkyW0vlVIsJck6aDocbRmcDu+7kgDOhkwAq3rYjEkqYAFXRKV6q1IlUVXds0a
 2UnReV9zMsZ3dvWhl2BnXVIrqnpERivvL0t3Hycp2phRjerRRZehgmRDr1VUawEO0Nij
 t5Xg==
X-Gm-Message-State: AOJu0YxfkfAwDEo2bAwj9oWagYXhrKhyGPLl7YWfht/zScfwM/AD9k/J
 jsjsMWduWn5um6mC3vxPiDah+XskYMWSSvVuShbYYN+cd6mpBkyhYqVKg/u8qubidu3jHXUx4B6
 C
X-Google-Smtp-Source: AGHT+IFMjeTGv0XNN8iBop5Ue0/+RFuOxDRlu8O1N0507wrR+14CuezpSI1Sg25IXVgUyO4RLIZCsQ==
X-Received: by 2002:a05:6a00:9099:b0:6f0:c828:8e0b with SMTP id
 d2e1a72fcca58-6f8f32b5a19mr9346291b3a.7.1716771013671; 
 Sun, 26 May 2024 17:50:13 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/28] target/i386: Add {hw,sw}_reserved to X86LegacyXSaveArea
Date: Sun, 26 May 2024 17:49:47 -0700
Message-Id: <20240527005001.642825-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This completes the 512 byte structure, allowing the union to
be removed.  Assert that the structure layout is as expected.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 91170a088a..fdd318963a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1425,23 +1425,34 @@ typedef struct {
  */
 #define UNASSIGNED_APIC_ID 0xFFFFFFFF
 
-typedef union X86LegacyXSaveArea {
-    struct {
-        uint16_t fcw;
-        uint16_t fsw;
-        uint8_t ftw;
-        uint8_t reserved;
-        uint16_t fpop;
-        uint64_t fpip;
-        uint64_t fpdp;
-        uint32_t mxcsr;
-        uint32_t mxcsr_mask;
-        FPReg fpregs[8];
-        uint8_t xmm_regs[16][16];
+typedef struct X86LegacyXSaveArea {
+    uint16_t fcw;
+    uint16_t fsw;
+    uint8_t ftw;
+    uint8_t reserved;
+    uint16_t fpop;
+    union {
+        struct {
+            uint64_t fpip;
+            uint64_t fpdp;
+        };
+        struct {
+            uint32_t fip;
+            uint32_t fcs;
+            uint32_t foo;
+            uint32_t fos;
+        };
     };
-    uint8_t data[512];
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    FPReg fpregs[8];
+    uint8_t xmm_regs[16][16];
+    uint32_t hw_reserved[12];
+    uint32_t sw_reserved[12];
 } X86LegacyXSaveArea;
 
+QEMU_BUILD_BUG_ON(sizeof(X86LegacyXSaveArea) != 512);
+
 typedef struct X86XSaveHeader {
     uint64_t xstate_bv;
     uint64_t xcomp_bv;
-- 
2.34.1


