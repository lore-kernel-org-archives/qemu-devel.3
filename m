Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6F5C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 04:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVE9-0002fO-N2; Mon, 10 Mar 2025 00:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE7-0002dl-Im
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVE4-00089V-Gp
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:58:55 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22548a28d0cso35990505ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582731; x=1742187531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JZyw573LWlQgbC9bGnVcpJUmDARxtxiYGI4BMcj5vE=;
 b=VLHaBYUyG7viQO2dbAkNjLUCtJCKq/23NN2citHXBDltpRObJxOhpmRKwVDh2HxAtS
 YFNI7TQqtUIqy1s8tB/1rVhUhoeVPP5qwMY2DDH88qWpZqiuxGoTfBhAFQAbtwozO09F
 XBIHaBmO010vXwaOU0PTuKWxtx0n4t+zwTaQwCilmBp/3C3zWPchi2JNqJ/Yer+SucJm
 70EZfggY1E/r8AmHvR2xuMXRZIGzBNSKgQoiCUxG7u66YuwnGFMEPaFlj93wnXSBUzlp
 jldxpItyDgBOYSeiu3/8ihroYCNiH9JtTJEU6HeWi6Rh1j9mmJzmv92UYJfoQdVoLw+C
 OtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582731; x=1742187531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1JZyw573LWlQgbC9bGnVcpJUmDARxtxiYGI4BMcj5vE=;
 b=MRRdUSzZVkLWBmqBEcpOxqGRh8UkqgLwcXwZeSqA9dLloNNCgl1BTXZqeAZz+hb20m
 ySRwkCQg7FIf637/Kd4f/pl89sO/2j5gfsBayG6AEj//XTo+X06UuGBvYIj+8nEagFaT
 sQzE5jTKG2mk6AF1gH8geQ9JvNCZ73vRVAogIdp+IUmQHT656LABIvEWGUCBVev+8eVC
 ajD7Y+ZHEZdweRm5P84q1Lsy2xIMeY/svuQ4e7k7alI1qnxZbd5gZMYlry2SalGHEZ+z
 15FuDR1AQ2gs7h8/Z07Rq9evVqT66WCHu2Iya3+6UvILaltm/f2yP3H7ywj6OmbskQYn
 uT6Q==
X-Gm-Message-State: AOJu0YzdjyGtHdVd4irpSG2tcufNeI34xfgdHKg9QMdRoKyep+LqgXCt
 N8KpyB1v5CoDMOx62joD6bHPYCDoQYyy28GmlhisZsqLeExj1N2iuRLopVlIQ0IgUt3yQHrpU6i
 t8dM=
X-Gm-Gg: ASbGnctQ13NJb/RmHKX+0hPweLlubHrcDy24dKIA+qUzMiwuLHYRVANPi0j3an9Djrp
 nK0bo48ur8itQTE7q1JUYdTyyg5Ql3uffHDdeIpNCusMVkUjc5EW4gHdHm44Z6iBbAU6R7UlDlI
 N53RDCLSinxB3BmapIbCCxlzWEhM10ESTg5LwnAinVTAfJWYf6GKfXo2vjt9TyehnzShLxIfYE+
 yuE3ItROTATQdKCtsY19OWDycSc9MeHw0Wk/8Dt9CKzm/Hbgd8ivA2LQ3xYGEXFo1HRUE2/6n6n
 UIW+N7eHX1EkXmXgxZX/tiMndDy33qfY5aJ2DFaBf4Ux
X-Google-Smtp-Source: AGHT+IHsrTctZA7T98GoAjZcAG6E707cPIOSM6QcsZhsVvq9UPUg2kUQ9eJxgIpK7zPxh80fLwzPDw==
X-Received: by 2002:a17:902:f644:b0:224:76f:9e45 with SMTP id
 d9443c01a7336-22428a8c6femr219904905ad.21.1741582731096; 
 Sun, 09 Mar 2025 21:58:51 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:58:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 01/16] exec/memory_ldst: extract memory_ldst declarations from
 cpu-all.h
Date: Sun,  9 Mar 2025 21:58:27 -0700
Message-Id: <20250310045842.2650784-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

They are now accessible through exec/memory.h instead, and we make sure
all variants are available for common or target dependent code.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h         | 12 ------------
 include/exec/memory_ldst.h.inc | 13 +++++--------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 8cd6c00cf89..17ea82518a0 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -69,18 +69,6 @@
 
 #include "exec/hwaddr.h"
 
-#define SUFFIX
-#define ARG1         as
-#define ARG1_DECL    AddressSpace *as
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst.h.inc"
-
-#define SUFFIX       _cached_slow
-#define ARG1         cache
-#define ARG1_DECL    MemoryRegionCache *cache
-#define TARGET_ENDIANNESS
-#include "exec/memory_ldst.h.inc"
-
 static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val)
 {
     address_space_stl_notdirty(as, addr, val,
diff --git a/include/exec/memory_ldst.h.inc b/include/exec/memory_ldst.h.inc
index 92ad74e9560..74519a88de0 100644
--- a/include/exec/memory_ldst.h.inc
+++ b/include/exec/memory_ldst.h.inc
@@ -19,7 +19,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifdef TARGET_ENDIANNESS
+uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
+    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint16_t glue(address_space_lduw, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint32_t glue(address_space_ldl, SUFFIX)(ARG1_DECL,
@@ -28,15 +29,15 @@ uint64_t glue(address_space_ldq, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
+void glue(address_space_stb, SUFFIX)(ARG1_DECL,
+    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stw, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stl, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-#else
-uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
-    hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
+
 uint16_t glue(address_space_lduw_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint16_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
@@ -49,8 +50,6 @@ uint64_t glue(address_space_ldq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
 uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result);
-void glue(address_space_stb, SUFFIX)(ARG1_DECL,
-    hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stw_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint16_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
@@ -63,9 +62,7 @@ void glue(address_space_stq_le, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
 void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result);
-#endif
 
 #undef ARG1_DECL
 #undef ARG1
 #undef SUFFIX
-#undef TARGET_ENDIANNESS
-- 
2.39.5


