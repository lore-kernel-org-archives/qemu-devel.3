Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC37FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFc-0003wC-C1; Wed, 15 May 2024 11:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFW-0003vO-5f
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFR-0002yN-7v
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:57 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so45367405e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785731; x=1716390531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPObxy+AqeYTMv2Kbr9Ww6bj1NBgeP7IU5K30XX9RPI=;
 b=R6PsLwr5Ju68k2JlZhp0rF6quFh5pemGmBiKLcbEUGbUeW0FxXc2ROv39KryPO6oyy
 nWhCXIepX2Xm80vuPUI/FpkxYpcgyAUwdotU6qy9DUV07WTyoez42NTADKz76gC9ABle
 GJViRtivKnlaN5UIRsZ16Gd2yeL/qCqPgvfZQbPKJd4iX2bbDHngg6JMkf1oNCFX5MT6
 N2ZcMMiv8uXelYjyUubqZTKJOkY87QATtgnwEuHfxECg3kjUqLxwiuo8y2ualNI7F+CR
 6OAUxoG721FiuHnsMZbWhCbf8AeE4m8noEdFyoP33Pg3vkSAK4f81E3AVOVA4ETJT3GJ
 fgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785731; x=1716390531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPObxy+AqeYTMv2Kbr9Ww6bj1NBgeP7IU5K30XX9RPI=;
 b=cYlVG902/aLykIhi87MwVMtxvAUZy7PaoUgNfG0Kc0YediKWW/Iv/VWiAHq2wMrdPf
 sSwQzMX80Gu/cUOLU5XQ3VyMCbKWkQdn6z14YUQqD6UcA+j/Y59Jtwy03x1aUE7svQ6P
 /nHof6eeNa2iiCASnYl1d2T6khDkTrvk9tuvicjfAWFAg6K9rQUifpwsq1uz44FthM0w
 z3D5Z16+/ORKuwkuBsLFW6MdfRRqVJ9vaKq3Mob8L0n/yoiRsSjWmvTgazmAa4wKq+PM
 ohPL6tsziOXhRlKk6CwCBtwwDqrGZ+7bqdQhe2GkNwlLlHzPeLOJF+UVw7Ond8SQarcZ
 IUlg==
X-Gm-Message-State: AOJu0Yx/l0vt4XKu0ALtA1Qfe0Fx73vMegagYQeMMrVOSupqYSrnsXCt
 YclH5JpzKDOBctZ7a08IuQ3OLdGomThRK6VCGxEC9k8WkD98K/9flqjFN8kfYf2l6SGQBDMtzfb
 HBbg=
X-Google-Smtp-Source: AGHT+IHl851t8hCe1EM8du5hIf3IYEMaNSW9VBq5MsNWpqmB1NqsSSQrW07tTSxVIySVY5YiEl3Khg==
X-Received: by 2002:a05:600c:354a:b0:41b:f24a:b590 with SMTP id
 5b1f17b1804b1-41fbc91f3e4mr173123515e9.3.1715785730819; 
 Wed, 15 May 2024 08:08:50 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 14/28] target/i386: Add {hw,
 sw}_reserved to X86LegacyXSaveArea
Date: Wed, 15 May 2024 17:08:23 +0200
Message-Id: <20240515150837.259747-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

This completes the 512 byte structure, allowing the union to
be removed.  Assert that the structure layout is as expected.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 97014b14ce..4b3bffeb9c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1414,23 +1414,34 @@ typedef struct {
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


