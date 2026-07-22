Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9414BC4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmbsy-0004Rx-6J; Wed, 22 Jul 2026 14:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsj-0004Mn-LK
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:28 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsg-0006N8-RQ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so10756506a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784745681; x=1785350481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xq5Wzub/cfVSWWjxSqknbzvC0pj6eWHPPN8HDFNrQqg=;
 b=XRtlqi+FTUpK85EPM6KrBcy1LUnwnIBglUyuVfFAhdtnUpg25p6lh3G22hN61NHAZS
 n6STLTJqIJgUDZXw4D29+5qyVVhX2s5/9coVjXQ3yP1NwYnCnpOOsxfIINFs6JG3ifcO
 Z42rOwFcdJM8HKDGbQVsHM5vyfszgvnpg2hvtgKe60Tv53y//YmuU6qxvNqLytEK0w10
 Of/LQHh+OZALGBNqDZbF7d+Etqdq828rNgPQi29yzWBqYTMl5jELwhuxm+coSZs5VQ/V
 qyfOPl+2YlnTVbGh4Woi0wXIX8dJ7P4sYIvwuu1iptloSvO2TxwK4x/DU6lcYiOVGS16
 HZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745681; x=1785350481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xq5Wzub/cfVSWWjxSqknbzvC0pj6eWHPPN8HDFNrQqg=;
 b=A/iXXMzmTU7LI34YH2fmx5pB5SQmMuip0TLR5QMJAbRCMNWGNftx/rRBdocUR2mubT
 6bTArDyrFkGKUAhmgiDfaR+TWYbQbctp8K168E/FyPZ1bmf93jkcf0SEqYGguyrDz7Ln
 xq/ED+eyiDvuD9p2FexyWOb6vyYoGUjwZuy/yGru40JryS3Be1/pq+VrGvsXCHZXxt6z
 xwW5ekc/XOfy7IcvBYHNLVLnnC4cCjgfazXQw+uZvlChc0DyCYUzFCByVuC25RsMjKuX
 8TUAqWsVMcK0RuPFldY6xZd+vPS2ICyXdmwZnonNcDMLQk0JOL0Htv1A37eeOfmipdCo
 AioQ==
X-Gm-Message-State: AOJu0Yxat2HR9lGOQ7zW1NhVMAtwvrmENaOfLN6Tbu0ZfiENftA3lKiF
 wehshmD5STlEp+oSdiknQPp7YjZ4VAr0yPCXbtTRtg2FEYg8H6oh20cbwjvQBIyRS2tAXBssX7c
 dPoWS
X-Gm-Gg: AR+sD11clqi0rsAwVJmil7GTBu1CprIsic50v5jixkxDJOp4TUxubZiv12/+SKfm3BY
 6fa/oI6+JqK4WQxOq6FnBl0WAofde0aoHTtYH/UBfW3ZzxGHUZHrrLj9VEs/JnE+UrhkFt0Ep80
 f7Hv2l32TPGfNETMtnKPjvBtS2zC9XlhOtZbHB2OgMUcVW2M9ophBVlYNLTmjWOcYpVdNgZ/Uyd
 AE0cAH44W1Ddw0pvjr2bh3NnFQ1o5TralMyvDfXsQhzopdWsBwbjT73PQJ/HFHbCtZuA9Fpgtls
 ryS9j/vEfxNdVI6Z+ep0bX5q9gamB30TmF5/rMj4iHxhQYVgzFlsESDXVCOHvff/4SM9Z+72C3b
 BomresQFE+3asjWcNFB9scG2rlj1MBMxz0L+sNe6QbhjrDrZPO8zvcp4BoU137EatW8QwzMoeap
 0mRlFyW5rdGRf2xRLkrAtyk5ki5OpBIQz2VdRpGXZ5ET9vM/Lx5vXzMebyDH/weQ==
X-Received: by 2002:a05:6a20:ae2f:b0:3c3:834e:89bc with SMTP id
 adf61e73a8af0-3c3ad93177cmr24610343637.50.1784745681267; 
 Wed, 22 Jul 2026 11:41:21 -0700 (PDT)
Received: from stoup.. (162-198-231-97.lightspeed.wlfrct.sbcglobal.net.
 [162.198.231.97]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13015052sm8559298c88.5.2026.07.22.11.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 2/3] host/x86_64: Implement atomic64_set with MOVDIR64B
Date: Wed, 22 Jul 2026 11:41:16 -0700
Message-ID: <20260722184117.11937-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722184117.11937-1-richard.henderson@linaro.org>
References: <20260722184117.11937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Detect the host feature in cpuid, then use it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/cpuinfo.h            |  1 +
 include/qemu/cpuid.h                          |  3 +++
 util/cpuinfo-i386.c                           |  1 +
 host/include/x86_64/host/atomic512-ldst.h.inc | 21 +++++++++++++++++++
 4 files changed, 26 insertions(+)
 create mode 100644 host/include/x86_64/host/atomic512-ldst.h.inc

diff --git a/host/include/x86_64/host/cpuinfo.h b/host/include/x86_64/host/cpuinfo.h
index 93d029d499..34c4334f3d 100644
--- a/host/include/x86_64/host/cpuinfo.h
+++ b/host/include/x86_64/host/cpuinfo.h
@@ -28,6 +28,7 @@
 #define CPUINFO_AES             (1u << 18)
 #define CPUINFO_PCLMUL          (1u << 19)
 #define CPUINFO_GFNI            (1u << 20)
+#define CPUINFO_MOVDIR64B       (1u << 21)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index de7a900509..435fc7af9c 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -71,6 +71,9 @@
 #ifndef bit_GFNI
 #define bit_GFNI        (1 << 8)
 #endif
+#ifndef bit_MOVDIR64B
+#define bit_MOVDIR64B   (1 << 28)
+#endif
 
 /* Leaf 0x80000001, %ecx */
 #ifndef bit_LZCNT
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index f4c5b6ff40..bb88abcf8f 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -29,6 +29,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         __cpuid_count(7, 0, a, b7, c7, d);
         info |= (b7 & bit_BMI ? CPUINFO_BMI1 : 0);
         info |= (b7 & bit_BMI2 ? CPUINFO_BMI2 : 0);
+        info |= (c7 & bit_MOVDIR64B ? CPUINFO_MOVDIR64B : 0);
     }
 
     if (max >= 1) {
diff --git a/host/include/x86_64/host/atomic512-ldst.h.inc b/host/include/x86_64/host/atomic512-ldst.h.inc
new file mode 100644
index 0000000000..7db9a0b753
--- /dev/null
+++ b/host/include/x86_64/host/atomic512-ldst.h.inc
@@ -0,0 +1,21 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 512-bit atomic operations, generic version.
+ */
+
+#ifndef HOST_ATOMIC512_LDST_H
+#define HOST_ATOMIC512_LDST_H
+
+#include "host/cpuinfo.h"
+
+#define HAVE_ATOMIC512_LD 0
+#define HAVE_ATOMIC512_ST likely(cpuinfo & CPUINFO_MOVDIR64B)
+
+Value64 QEMU_ERROR("unsupported atomic") atomic64_read(const void *s);
+
+static inline void atomic64_set(void *d, const Value64 *v)
+{
+    asm volatile("movdir64b (%1),%0" : : "r"(d), "r"(v) : "memory");
+}
+
+#endif /* HOST_ATOMIC512_LDST_H */
-- 
2.43.0


