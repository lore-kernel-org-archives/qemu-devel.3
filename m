Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3666D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFic-0005Aq-ES; Fri, 09 Jan 2026 11:52:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFiZ-0004s3-2S
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:07 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFiW-0007Ob-Ec
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:06 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43277900fb4so1508475f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977521; x=1768582321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giWdPoxyT7GeYpAJXZMpfomroD+LhNldKaXalY7TMhs=;
 b=iOcTS81kAVaZ4mtLWzXewJ3bmQFtjcpXKlCnr+4Uxtjxq61IaBx/dWOi5nF7tGtDXK
 XRiZzwdxgrk2nBmOPKE1N8ZK8tQaRxE4rBMb6wqAueNdDAxTtsu7frQV7Rkbvn9jV2fH
 thIfZ4V0QIDgqcpXSW4k8m7rfCVZSyZyTukHDFBawBA9ffNumeY2ddsZyGpd0vQ5rYga
 GUpTRzWs3HO5QYBVtiuBCBu8ubWZmdYDAqFSD0CVOE1siW5vDz4rHaxyDThXGrH9s/2q
 9VrV/SuHZ1nOTEGsSDnrsOVMIrFwl5TCEm2/0rDADuhhAFVdkbDWJCCHQrzfcPhRRRWg
 eElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977521; x=1768582321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=giWdPoxyT7GeYpAJXZMpfomroD+LhNldKaXalY7TMhs=;
 b=cmsG9OcygFT9IIKisIMkcdmuRmlz84Q+KOKolzT09qOlu+mPQStKUytIVz5ndpKqZ3
 EcnlT+5yTkdOW1G1lRIJJiaGOC/iza7jfxfmvhfcaHfh14O3banQDtTgjVDXta365cJG
 Aygzd7rZtc+R5NwI6FAaRlxhYczDm2HQmJXEA/b8JBfWHG+x1UgLgH7HFfSw/z/cpjvh
 0riBToAufocQ85suk4gKu6qSjlcRt0wss6PoD3EeWGoeEvyxl7lTw5Qc0FI1SJB9PFts
 zIaLcv8ceDBlCZ03M2DI6qB/2Vgaqv9XJ1qLdoxSbWwMsE8BLv3awR81eU6qOcnSFJon
 jlGw==
X-Gm-Message-State: AOJu0YwqsVTJERC+OnkyDEIMkBOLkycdcfzMmFV6w/GegmN/MQXzSdCP
 XMR5fT242KEJNwzY4r7UqOzgzxqVfvXySuEOpLpyvP3Cp5fhytmNxNbCpX3RJf50bT/QUv2l3Mq
 /bMBNh4Y=
X-Gm-Gg: AY/fxX4E54BnZGDhT9AenYGn4DDFDjVsxsTK3LPuyAuX2mYB0SteQMfAZ/StI6Qc3hs
 RTt8ZK2wqn1A1kKDbG+bnBAc4bWuaVtPzBze4q/fRjxSecvWS9oIjPGeCaZxwISjFTJ+vYpdAMD
 zCOji4TuvUjPpiBLquIKiw90y80byj2fLumN2p5VnqCykjO7pgPzc0dGhYlavpH08lmKk0lYVVs
 kSJcNeigzzVc1U3q3zsAgYcy4vutzfI4xaCLowXTKDfZ2CaBjFcOgDGMZEGgi3+UnJt9RFvQrCz
 U9aH5ud5tXZwgEMX/sWEgI9xg1sRC+yiP2aatt2D592s+n63gX9pSA6uXTz6YmU5tyapyikODNj
 BPlB+KL5oOD4Dv7MrFvn0W5miBtgbdOkKVeFhd8PHo4+wcwVjwLqoDbYHvBvR/XBO8sDy7qXeEu
 pZDuZtGtL25mo6Awjs281PVdSLlB+AFjwgbm3Lqv/DyhyksZyEXutX34ugMIMd
X-Google-Smtp-Source: AGHT+IGWIeEbNJP4ztcqzEokeCnRELnxkHxta9VJ7KVH3od0V7cgjVDfPyq2ZzrJ4pDHxR8iRcP+rQ==
X-Received: by 2002:a05:6000:40dd:b0:431:771:a50c with SMTP id
 ffacd0b85a97d-432bcf99f09mr17106872f8f.1.1767977521015; 
 Fri, 09 Jan 2026 08:52:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16ffsm24197507f8f.12.2026.01.09.08.52.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 09/22] system/memory: Define address_space_ldst[Q] endian
 variants via template
Date: Fri,  9 Jan 2026 17:50:45 +0100
Message-ID: <20260109165058.59144-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Define address_space_ldst[Q] endian variants via template.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/memory_ldst.h.inc             | 17 ++------
 include/system/memory_ldst_endian.h.inc      |  4 ++
 include/system/memory_ldst_phys.h.inc        | 36 -----------------
 include/system/memory_ldst_phys_endian.h.inc | 10 +++++
 system/memory_ldst.c.inc                     | 42 --------------------
 system/memory_ldst_endian.c.inc              | 14 +++++++
 6 files changed, 31 insertions(+), 92 deletions(-)

diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index 7ccca46f2a9..dd1fb482eac 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -19,22 +19,11 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+             hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
+          hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
diff --git a/include/system/memory_ldst_endian.h.inc b/include/system/memory_ldst_endian.h.inc
index 845ec3b4ad1..f5b6b496be5 100644
--- a/include/system/memory_ldst_endian.h.inc
+++ b/include/system/memory_ldst_endian.h.inc
@@ -18,10 +18,14 @@ uint16_t ADDRESS_SPACE_LD(uw)(ARG1_DECL, hwaddr addr,
                               MemTxAttrs attrs, MemTxResult *result);
 uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                              MemTxAttrs attrs, MemTxResult *result);
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result);
 void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                          MemTxAttrs attrs, MemTxResult *result);
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result);
 
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_ST
diff --git a/include/system/memory_ldst_phys.h.inc b/include/system/memory_ldst_phys.h.inc
index c3c73419e61..f4c91dc7a91 100644
--- a/include/system/memory_ldst_phys.h.inc
+++ b/include/system/memory_ldst_phys.h.inc
@@ -19,54 +19,18 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-static inline uint64_t glue(ldq_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq, SUFFIX)(ARG1, addr,
-                                           MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq, SUFFIX)(ARG1, addr, val,
-                                    MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline uint8_t glue(ldub_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
 {
     return glue(address_space_ldub, SUFFIX)(ARG1, addr,
                                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline uint64_t glue(ldq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_le, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline uint64_t glue(ldq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr)
-{
-    return glue(address_space_ldq_be, SUFFIX)(ARG1, addr,
-                                              MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
 {
     glue(address_space_stb, SUFFIX)(ARG1, addr, val,
                                     MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
-static inline void glue(stq_le_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_le, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
-static inline void glue(stq_be_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint64_t val)
-{
-    glue(address_space_stq_be, SUFFIX)(ARG1, addr, val,
-                                       MEMTXATTRS_UNSPECIFIED, NULL);
-}
-
 #define ENDIANNESS
 #include "system/memory_ldst_phys_endian.h.inc"
 
diff --git a/include/system/memory_ldst_phys_endian.h.inc b/include/system/memory_ldst_phys_endian.h.inc
index 1589f34e8e4..820e9dd1f13 100644
--- a/include/system/memory_ldst_phys_endian.h.inc
+++ b/include/system/memory_ldst_phys_endian.h.inc
@@ -29,6 +29,11 @@ static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline uint64_t LD_PHYS(q)(ARG1_DECL, hwaddr addr)
+{
+    return ADDRESS_SPACE_LD(q)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 static inline void ST_PHYS(w)(ARG1_DECL, hwaddr addr, uint16_t val)
 {
     ADDRESS_SPACE_ST(w)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
@@ -39,6 +44,11 @@ static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static inline void ST_PHYS(q)(ARG1_DECL, hwaddr addr, uint64_t val)
+{
+    ADDRESS_SPACE_ST(q)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
+}
+
 #undef LD_PHYS
 #undef ST_PHYS
 #undef ADDRESS_SPACE_LD
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index ab2df6e429b..823fc3a7561 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -115,27 +115,6 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
     return val;
 }
 
-uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_NATIVE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_LITTLE_ENDIAN);
-}
-
-uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
-{
-    return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
-}
-
 uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
@@ -381,27 +360,6 @@ static inline void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     RCU_READ_UNLOCK();
 }
 
-void glue(address_space_stq, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_NATIVE_ENDIAN);
-}
-
-void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_LITTLE_ENDIAN);
-}
-
-void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
-{
-    glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_BIG_ENDIAN);
-}
-
 #define ENDIANNESS
 #define DEVICE_ENDIANNESS       DEVICE_NATIVE_ENDIAN
 #include "memory_ldst_endian.c.inc"
diff --git a/system/memory_ldst_endian.c.inc b/system/memory_ldst_endian.c.inc
index 5d46524ec4c..791d041b15d 100644
--- a/system/memory_ldst_endian.c.inc
+++ b/system/memory_ldst_endian.c.inc
@@ -33,6 +33,13 @@ uint32_t ADDRESS_SPACE_LD(l)(ARG1_DECL, hwaddr addr,
                                         DEVICE_ENDIANNESS);
 }
 
+uint64_t ADDRESS_SPACE_LD(q)(ARG1_DECL, hwaddr addr,
+                             MemTxAttrs attrs, MemTxResult *result)
+{
+    return ADDRESS_SPACE_LD_INTERNAL(q)(ARG1, addr, attrs, result,
+                                        DEVICE_ENDIANNESS);
+}
+
 void ADDRESS_SPACE_ST(w)(ARG1_DECL, hwaddr addr, uint16_t val,
                          MemTxAttrs attrs, MemTxResult *result)
 {
@@ -47,6 +54,13 @@ void ADDRESS_SPACE_ST(l)(ARG1_DECL, hwaddr addr, uint32_t val,
                                  DEVICE_ENDIANNESS);
 }
 
+void ADDRESS_SPACE_ST(q)(ARG1_DECL, hwaddr addr, uint64_t val,
+                         MemTxAttrs attrs, MemTxResult *result)
+{
+    ADDRESS_SPACE_ST_INTERNAL(q)(ARG1, addr, val, attrs, result,
+                                 DEVICE_ENDIANNESS);
+}
+
 #undef ADDRESS_SPACE_LD
 #undef ADDRESS_SPACE_LD_INTERNAL
 #undef ADDRESS_SPACE_ST
-- 
2.52.0


