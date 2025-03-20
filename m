Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02696C36000
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQO-0002wx-0z; Thu, 20 Mar 2025 18:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPM-0002RM-K8
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOP9-00078B-Eu
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:31 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2240b4de12bso36343685ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509820; x=1743114620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFqUHpOq6/zm0nogOBs1dNKROVvqoyXbuPu8a/iEMZk=;
 b=i21sxuNsAz8f+fThjf6Fk/2evEFrvpbv1O4XRFXEpmHbcGeEg1cwua1OEtFOL0whg3
 bS9D/svg3VygevKune3qAX37XcpKoLrOEp+b4FImyBHB5OOx22xkgrKvH4ZYgvde9lum
 nq9NYMjxxuiRBwKm4njGmPiwkhUATq/gZ0zH6/Q+88PlZJV8plIOgcOR2Z+4xZ0hyYwG
 GiQVh7+a2H2KZS5pDi4fKerRDx6hA+2eDl6m8BAktCQRNd6P7FDzPfpgZivUYSuQ7KV+
 IT0guLLpKpTzYDiRJs1AN8vhjzI323g9MtWLuFLAvTuO927Vnrna34HoKTu5mUhu06r3
 1q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509820; x=1743114620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xFqUHpOq6/zm0nogOBs1dNKROVvqoyXbuPu8a/iEMZk=;
 b=Rcj1IxDxpvZ/djqi49TfB+pr1HycWlcpSwlamI3ZFGVnN5kqAlHJRPkYL7NcXi4ulb
 TF7Su1SrpW34OMGSO9HUlxFPFs92GYNteH1B2KWP3QiUFNUO88LYxPahDSvHerpi5UOj
 G2OYnv0MeAOqt6kfcpdc8XOJneaS4f1kFQsWXe5vOLHQbEnTcaax8vyCJEL+PUwW+qVi
 oJt4c8yd+lFmJI8A/mrKMCLmcc6kVoqYJtVp7X4+EzvRY8NS0zkh8r8w/IQYAdlbtiDY
 HRz/+pPueXgrYINXDNRsyrcUBbOMfg8D9o5QOGZ5aN2wh4pfQsaZbAJFGWj7YfeHcxo2
 IYIg==
X-Gm-Message-State: AOJu0YyIhRbKhXKKt4GSiZ0HO1fD4ruIl5WfW9ab12ftQ+w6dFdHr1Ap
 Gh2ccrDQ3wPEeIh/KNdSEMuEa7t8W4jdvrJ4agU/uO8QA2CoGGlq8uRGRtYTux5g2/abc/BL11m
 W
X-Gm-Gg: ASbGncvCVRE1EBV7HyGhqciLW60JyuxrNv5CWTV8S3G71/xy5Nj+8o9QdSutFNu167i
 4/vsk9cGvnXC69CI/DG7f6+DhkmMAKHWlZFyl7ZMXR+pos/vBGXUOof6d6AD4lwlXqrGdbVDjdj
 DEd+CN66KgZVjNDZAtyn+VBx4liGgjG/0x0FMUVb42CZylTqNVOrRo2TL+ZyxxMUA2qN7jC8cLC
 kWUm1BRbCRr6aLAAo23U5SEkSLX2VACAWJcjpMk4xGQlYW0kaBoWvw/EXH00w2MJG3i1RLOm9R/
 Zbb4NuF070OwrpjpvmCweHNqpYsKAGoj4e06I2vPZEtf
X-Google-Smtp-Source: AGHT+IFBKDA1KSEszRYL6pQSK/w5qMFQcOYQFQf+g/w2J4vsHvlcI3/0ADJcw1lVzMWVtNrb1auW7g==
X-Received: by 2002:a17:903:32ce:b0:223:6180:1bf7 with SMTP id
 d9443c01a7336-22780e1557emr14650115ad.42.1742509820539; 
 Thu, 20 Mar 2025 15:30:20 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/30] exec/cpu-all: remove tswap include
Date: Thu, 20 Mar 2025 15:29:39 -0700
Message-Id: <20250320223002.2915728-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h               | 1 -
 target/ppc/mmu-hash64.h              | 2 ++
 target/i386/tcg/system/excp_helper.c | 1 +
 target/i386/xsave_helper.c           | 1 +
 target/riscv/vector_helper.c         | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 4a2cac1252d..1539574a22a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,7 +21,6 @@
 
 #include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
-#include "exec/tswap.h"
 #include "hw/core/cpu.h"
 
 /* page related stuff */
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index ae8d4b37aed..b8fb12a9705 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -1,6 +1,8 @@
 #ifndef MMU_HASH64_H
 #define MMU_HASH64_H
 
+#include "exec/tswap.h"
+
 #ifndef CONFIG_USER_ONLY
 
 #ifdef TARGET_PPC64
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index b0b74df72fd..4badd739432 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -23,6 +23,7 @@
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/tlb-flags.h"
+#include "exec/tswap.h"
 #include "tcg/helper-tcg.h"
 
 typedef struct TranslateParams {
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef..24ab7be8e9a 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -5,6 +5,7 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
+#include "exec/tswap.h"
 
 void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
 {
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index ff05390baef..ff8b2b395f5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto.h"
 #include "exec/tlb-flags.h"
+#include "exec/tswap.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
-- 
2.39.5


