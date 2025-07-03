Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0A3C83F07
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNqg-0000hl-WD; Thu, 03 Jul 2025 13:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqM-0000MS-9c
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNqK-0001mu-HQ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:35:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso43626f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564126; x=1752168926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMC0+nUBwcayhXSZ9VnA1BuCntgKRX/upKf7MQ4uL1o=;
 b=vS30pJVw2DxnVtOnG70VfQ/hKPm68TnibDEUqhaRo+Mhkf0/KFQ3uOV3EKgQyauH8O
 rJPW4Mr13arnBFWEiHBFO7fEwZfH2PbrovTibJRY8TsaDSNFYALjr+FCzHnYyMmtRV4X
 9LLl4HtaxOeLN2/d9TAtdY8dHuoOOuXiuMzc6eqHQpl0GlTCVUOg2XJsDt55CvSk3A7Y
 dtyf5wSM2REfcJ/s3YaSVg8wd+fnASk+9qQVC6paOL2LXLgmba9dhZJDC0DIushGJm9V
 sziuAvD224mSKe4JD9V8ZJxVsDj9vFNj+HTB64TGe3MgurDZPL3SDAZRYcI9xNtuyHXB
 lhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564126; x=1752168926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMC0+nUBwcayhXSZ9VnA1BuCntgKRX/upKf7MQ4uL1o=;
 b=BstK88CK8mDAwCSmZb016UJgvZiPiwv/aMzUM5xn+hSpB4R8HJnscpVoIXlK7sk5nt
 Gq1tVVSTa4/F78nKByopdvrcJ+FFt/dEn9i9s9tWKa/3OHWB5t7x74g1cLOyfooETOsp
 QIfZhkSuohN9N+P0MndazytYLWPOFg4SerlFj+WMhykuQx3SgjEH3eAfJJSKRRnVxsDA
 BrYjAq+8Vap3TICJxE3X7h7tL/xmtAGbfSQwLL0bjxmeSBaaUsYbQBW0AZ+qFpi4KU8l
 MZ6M09deBPCnZCUmJ5LVi4VE7LDBzqI5WC2DdcvDfbDz/Lee45o4c3z2wPpQkKE5DikB
 6oJA==
X-Gm-Message-State: AOJu0YzU3BPS9O9J7VbxvUuLpjZB5m3Mi/Rl0Ox29BonWnCTQxj6Jk90
 elYfaM/qauq6MMw1eg7ReO+n40xHjfmTgR1iOfXimMXgl4Yad6BNa9KTEUerBcOtaJK9WVC6CFr
 +kU0Et+A=
X-Gm-Gg: ASbGncv5fTmnNX2p4O7fDP0/nlxyG2Cxhb10JwV1kxjTvZrZCJFsaqX4Pb2Ro1QbBEG
 puNMx/oF7B0u8U1EiOpzEr11Kz9gl1JOhZbgoGVbKYfrwEDoz8C/X4Jmk2NEogkgKV/i2X52Ccc
 GrsSpWnlNqfjHNkKXkb9qeHmeTYlbz3sQTD7jWBb/HTnZW4/c6H6ST2rmZSaMgEnv2H/1Y2XRsI
 c/GVJiMI7wcJzE09inCyYKgA6Y7iG1F+uEn8CSdKothHUuYGo7XpErsYofxsEMFjrHCflh90v0F
 TbVRNqP2GbhFA7gqq1Aemtv7lmra2ib2sCZtg+96UoRLs0FsJ3T+aBON2tY3p289NUVRl7qLrLc
 nbXo6qXpOpa5ioRu28lWf5EB69G5o7u75Cgms
X-Google-Smtp-Source: AGHT+IF1zTlhV/pE6jc+dDLOU+oSlfPDF14ZyWfUE6sQo5Gd3pIpXdWFoebQiJ3d/WWSngZcAJFj2g==
X-Received: by 2002:a05:6000:43cc:10b0:3a5:1c3c:8d8d with SMTP id
 ffacd0b85a97d-3b32e9ecaafmr2925229f8f.55.1751564126084; 
 Thu, 03 Jul 2025 10:35:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b472259842sm313782f8f.72.2025.07.03.10.35.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:35:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 29/39] accel: Keep reference to AccelOpsClass in AccelClass
Date: Thu,  3 Jul 2025 19:32:35 +0200
Message-ID: <20250703173248.44995-30-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Allow dereferencing AccelOpsClass outside of accel/accel-system.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/accel.h       | 3 +++
 include/system/accel-ops.h | 3 ++-
 accel/accel-common.c       | 1 +
 accel/accel-system.c       | 3 ++-
 accel/tcg/tcg-accel-ops.c  | 4 +++-
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index f987d16baaa..197badcb705 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -37,6 +37,9 @@ typedef struct AccelClass {
     /*< public >*/
 
     const char *name;
+    /* Cached by accel_init_ops_interfaces() when created */
+    AccelOpsClass *ops;
+
     int (*init_machine)(MachineState *ms);
     bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
     void (*cpu_common_unrealize)(CPUState *cpu);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 95a0f402cde..17c80887016 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -10,6 +10,7 @@
 #ifndef ACCEL_OPS_H
 #define ACCEL_OPS_H
 
+#include "qemu/accel.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
 
@@ -31,7 +32,7 @@ struct AccelOpsClass {
     /*< public >*/
 
     /* initialization function called when accel is chosen */
-    void (*ops_init)(AccelOpsClass *ops);
+    void (*ops_init)(AccelClass *ac);
 
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 4894b98d64a..56d88940f92 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
+#include "system/accel-ops.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 07b75dae797..b5b368c6a9c 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -95,8 +95,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
      * non-NULL create_vcpu_thread operation.
      */
     ops = ACCEL_OPS_CLASS(oc);
+    ac->ops = ops;
     if (ops->ops_init) {
-        ops->ops_init(ops);
+        ops->ops_init(ac);
     }
     cpus_register_accel(ops);
 }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index eb16a6bf6db..bc809ad5640 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -189,8 +189,10 @@ static inline void tcg_remove_all_breakpoints(CPUState *cpu)
     cpu_watchpoint_remove_all(cpu, BP_GDB);
 }
 
-static void tcg_accel_ops_init(AccelOpsClass *ops)
+static void tcg_accel_ops_init(AccelClass *ac)
 {
+    AccelOpsClass *ops = ac->ops;
+
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
-- 
2.49.0


