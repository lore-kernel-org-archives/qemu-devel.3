Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451F2C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2A-0004Ag-O5; Fri, 17 Jan 2025 13:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr27-00049o-Fx
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:27 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr23-0007uA-It
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:25 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166f1e589cso61674395ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138321; x=1737743121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxMn5wJHRN3fIBCSyLsUosuOZgtHeKHyf3XHFjAQWv0=;
 b=SUjk52X9Pg6mkAadYru6UctC223wShlaHNfiUbnVocZohP9J50zclBK8tyCM3xz86i
 CrIA1jjaN3S5v1SdQFZHHNbDZa+7xdL+C0NZohf4b6YYALCLd8JCcD67FXoXqmDtAAOO
 VCXThrYa/CZ0L012ZpIj4KRA7Otnee2CutFZUhU+DWnOUH4scX3ULtgoJRQxE0h0LYkE
 +baSn/LqzWS515MdQjl9SFAO0TGoMQZEyLRFm7lYLdkkemeBIcQ7ZFo0MY8GqyyZwygA
 1S5OVO48ZUbZER+oOeaJl3YbxiqsW0opaqxRgGtgq9qpVLMcCy8SIKcS10z+pNM9FE12
 UlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138321; x=1737743121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxMn5wJHRN3fIBCSyLsUosuOZgtHeKHyf3XHFjAQWv0=;
 b=HVKXupYyXNpgXu8mjMRmGJRLcEQQjlY3vu4JDHcZxSheS9Lzqszl8lGJCO/V6+2ijd
 u+VsYtj9+CYgLZ3ux6jwUqV96Op2Q+IeCEpANoSeritT8gzZMjAPiTBN/KzoxVieiDgc
 +aFO92XYBTPRTXwcZoB1WIe7xUfwuMW3IlqVnogwewfyGg1j0CYWWjzXU5dev+se1DPR
 gXr+x0LOadCFJZWIZGqCDzAm9jIE5kKdqQPeqRprMcgJNGz/C/UuSKfmctTpN5bOynVd
 IehxOSHv9JpAQkZ+UlyhMUbDmiuYVgaTM2rbxyxc1si7pDECKbuust7mC8rIcVUJf6mN
 W9eg==
X-Gm-Message-State: AOJu0Yw1bdvnpoTOD+TbG7/UBZ1ny/hOExr/2NDt/cIPU/iRWFcc3uyO
 ZYavpCowCIdUv3oxXxFRk+FfNP/PrKeYJslQqrU8J0qqx8sntcVJRAXUg8jOVLHEc5zEx9Gm8lS
 r
X-Gm-Gg: ASbGncvv5nBdjRnfNTb1wMQdbj2jIfksTMwWAR3UoykvIOa6X/kXo0BPXW46SYVd2f9
 I7YcVjUzF7IyNOtAyNlPlPHicJJDjB8wNlgAgjuyux8hngPET+R8kVb4HcVnDa94jykb8pQgKGA
 nHSwyYDb5k+RjvaDO/QlkWfAFhv6/jKtDll6fDqViPQ1ctTzGZODFA8FDUb1WE0WpWsSjJ/bXiK
 OapsJ6iBlwPijeEgocfK9d3XIDWbtpCWczpAwq2fY/hTtZn2bpSXg/zP7utPILWIiauSEBvCxUP
 sWYx8gohNeG8gwA=
X-Google-Smtp-Source: AGHT+IHwKJaMB8InW6WVATXxSB89YoSFtfvwSX6PxhL3vC3/5DSkCdkEvoAKNSoo8zttqqwxZhJNIQ==
X-Received: by 2002:a17:903:244f:b0:216:643a:535a with SMTP id
 d9443c01a7336-21c355c7c15mr46382745ad.20.1737138321177; 
 Fri, 17 Jan 2025 10:25:21 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/68] tcg: Include 'tcg-target-has.h' once in 'tcg-has.h'
Date: Fri, 17 Jan 2025 10:24:19 -0800
Message-ID: <20250117182456.2077110-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108215156.8731-14-philmd@linaro.org>
---
 tcg/aarch64/tcg-target.h     | 2 --
 tcg/arm/tcg-target.h         | 2 --
 tcg/i386/tcg-target.h        | 2 --
 tcg/loongarch64/tcg-target.h | 2 --
 tcg/mips/tcg-target.h        | 2 --
 tcg/ppc/tcg-target.h         | 2 --
 tcg/riscv/tcg-target.h       | 2 --
 tcg/s390x/tcg-target.h       | 2 --
 tcg/sparc64/tcg-target.h     | 2 --
 tcg/tcg-has.h                | 2 ++
 tcg/tci/tcg-target.h         | 2 --
 11 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 9a682e51a4..1ef8b2e300 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -47,8 +47,6 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 64
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index e114f7ddf4..21563e00f9 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -70,8 +70,6 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 32
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index a1dfdeb28d..e6d7fd526e 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -88,8 +88,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
-#include "tcg-target-has.h"
-
 /* This defines the natural memory order supported by this
  * architecture before guarantees made by various barrier
  * instructions.
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index a3a6130720..0432a4ebbd 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -85,8 +85,6 @@ typedef enum {
     TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif /* LOONGARCH_TCG_TARGET_H */
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index a34765b389..210044ca12 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -70,8 +70,6 @@ typedef enum {
     TCG_AREG0 = TCG_REG_S8,
 } TCGReg;
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO           0
 
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index fa2cc28183..0bc13d7363 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -53,8 +53,6 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index c710321bdb..4c40662402 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -57,8 +57,6 @@ typedef enum {
     TCG_REG_TMP2       = TCG_REG_T4,
 } TCGReg;
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 220ed68b1f..f790b77075 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -51,8 +51,6 @@ typedef enum TCGReg {
 
 #define TCG_TARGET_NB_REGS 64
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
 #endif
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 1462144631..5ecca5586b 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -66,8 +66,6 @@ typedef enum {
 
 #define TCG_AREG0 TCG_REG_I0
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index c09ce13389..65b6a0b0cf 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -7,6 +7,8 @@
 #ifndef TCG_HAS_H
 #define TCG_HAS_H
 
+#include "tcg-target-has.h"
+
 #if TCG_TARGET_REG_BITS == 32
 /* Turn some undef macros into false macros.  */
 #define TCG_TARGET_HAS_extr_i64_i32     0
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 899d9861a6..fea92f7848 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -44,8 +44,6 @@
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
-#include "tcg-target-has.h"
-
 /* Number of registers available. */
 #define TCG_TARGET_NB_REGS 16
 
-- 
2.43.0


