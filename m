Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C5AE77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdz7-0002aV-5A; Wed, 08 Jan 2025 16:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdz5-0002QN-H1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:53:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdz3-00047D-Jk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:53:03 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so2332645e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373180; x=1736977980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsLWtZCOjZPcUD3UGuDmlfBcap3DKIAtzC/UGYLn7Ok=;
 b=AYBUjvBQ7vdXhMcyPzWh3z0dlslWstpK87eTeS+44AmG7iDlEVX2KdngdVtZZnQTrM
 iymqnJPngcaWa4NOBLHuMuG0VWRimPJ6ns/QXhZ2MQjhEbomYteZsyX5/2CGkJsEsKwq
 GnVpMqSpwV2hS+UYqrxAuoAuka8GuvTZnmT9mKxmVvR+cnPGtO8mEjTKcbWYJ/mz/8sX
 6ZGSF+2PrWCPCs/Smw/3QMByEKPe+qrQyD5i1dHluhXDC8Iqa64kEkWSuMY7VPB6qc8K
 jTZvkmtC24nM/0ObnF/iCr6zaHYxSkWQyHbxwFONJOcHZqeycDA9wQtwwe109FQA+dY9
 e4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373180; x=1736977980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FsLWtZCOjZPcUD3UGuDmlfBcap3DKIAtzC/UGYLn7Ok=;
 b=jvDAvInHo+BYNTX5/ENCiCg/XgI0nXdoAAqQJ07MgVTjtAb7qmG6HbS1p8F8XVrHbW
 7bu9U3u6fBH/XVfl9u6SeRoyQ0fUtY7hhWJ42+QLuclOhd32Oq1fSXPxP1Cq3nYt17xH
 0NLG5iJyUTjgFPPJcuMgavB71iQP1KmnJBABvzNbnxUnmbppMV/q5eJx7yD63eTE9fhm
 BmQA3e0Re2/OjlnHwCKPAAxLpAiQuE7af+updNlyyZFpXvKGJ8HN4UhRvo8RP1W2GpNr
 DmdLn+DF/sGsTchN24CrMiha+ER55Hrhc0d6ehtHOQD5ehEZ3f0BDmg9xsJUcMOdpC3S
 oBGQ==
X-Gm-Message-State: AOJu0YziH6sFNhbKdpQ6MBpuG+19rjo2TvqivpkDFnDMRxIGf/Xxp899
 oHYq3acDhzJixAc5RVcnGTdAYs9zr7NjedpdW7iv59EmuNbek3yn1NvoR9JQujICgbKrfHkkz+X
 c7NQ=
X-Gm-Gg: ASbGncscvLeYu/XpIkC6PwtCh2vjjxXi1wXlbW2XiyutA2nrDu+fa2I7Ds30fYk34AG
 uU37GrljC8bcihs9fCJLEzE0cACm5zh4eJ3zNC+Do9tWka/QEfp2XxcsGvuG9tfCR1F5dB1A90j
 cSJB3scY3OIYckcXSVw5N5WkdcQRlIApYx+RYKYgG1FMDypAIvnbyzg2pOjxp5Oqhbq5pGZ+vAw
 UUqJrdki2MZgRyE34aq8jNmoCh+H3WLH+xw/Iw5oCRy01xpwYvCUXIufyvtRP5Mi4jmOoLHTinZ
 hULcAkczDKBWUJV64E/IbnW3RVARLLU=
X-Google-Smtp-Source: AGHT+IG4/6LWM6ezWgZCUfjGqA0kxVr0EZVBSLMUD8MpV7MfDR1P6K9Dhug9NjW25bplOv25aQ8Cqw==
X-Received: by 2002:a05:600c:229a:b0:434:fbd5:2f0a with SMTP id
 5b1f17b1804b1-436e269a7a7mr39134595e9.9.1736373179667; 
 Wed, 08 Jan 2025 13:52:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd14dfcasm50397675e9.1.2025.01.08.13.52.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/14] tcg: Include 'tcg-target-has.h' once in 'tcg-has.h'
Date: Wed,  8 Jan 2025 22:51:54 +0100
Message-ID: <20250108215156.8731-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 9a682e51a47..1ef8b2e300b 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -47,8 +47,6 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 64
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index e114f7ddf40..21563e00f99 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -70,8 +70,6 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 32
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index a1dfdeb28d4..e6d7fd526e2 100644
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
index a3a6130720b..0432a4ebbd8 100644
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
index a34765b3894..210044ca12d 100644
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
index fa2cc281838..0bc13d7363a 100644
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
index c710321bdb9..4c406624029 100644
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
index 220ed68b1f4..f790b770750 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -51,8 +51,6 @@ typedef enum TCGReg {
 
 #define TCG_TARGET_NB_REGS 64
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
 #endif
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 14621446312..5ecca5586b6 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -66,8 +66,6 @@ typedef enum {
 
 #define TCG_AREG0 TCG_REG_I0
 
-#include "tcg-target-has.h"
-
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #endif
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index c09ce13389e..65b6a0b0cf4 100644
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
index 899d9861a64..fea92f7848a 100644
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
2.47.1


