Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCA3C5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8T-00084Q-41; Sat, 15 Aug 2026 16:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8Q-00082O-SJ
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:42 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8O-00089K-8Z
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2298880a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826259; x=1787431059; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w1jzfyEMyV4tcuUtopZTnGQBq6RAW96WuYdkZI5EwcE=;
 b=X/psgE/TK2HwQwD+QqliCkEgVHXsLcRGC+83YBx//46XFnVZ3XAlpvVTXMSR0D1smV
 GmWV6O1bsmJlQFq9GYABWm+ydadjOonKn5FUChk/iGb/ghxz53+pFMKwNqz8fRL3xEzA
 V2XunyclDFKbNDAU7hW8gXnzfIa+vGwxViiZDItD+U7YAOXGMsAfdvTx69n6zRA+5hAu
 NwFZG0YQJIVmq9uQUd2273f2G2sSXNZbgu1gchPQOpBSzZ5NLoavd61/KqANogtOF849
 adBI7lEmK0qpf3vRsT3NGe404+hT9FCv8QpTFEjjpvxorjFi0xaEcamzxU0mcV9RXdCQ
 DTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826259; x=1787431059;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w1jzfyEMyV4tcuUtopZTnGQBq6RAW96WuYdkZI5EwcE=;
 b=fcV0WzR/FkhWAmwNH6tElPHMqLW/R+Ix58yO0Mt0QxhzFKaBXtepgTe79YRSzqcr8Y
 R8P+2xWhWUtAVR20hEh6z4o5n94RjO8GmeWwtwbEt60718OxJ2nWymbj7PUNzZJht775
 FlomLW+gVhHfEe3gJcAH8LeywBl3CgB+pmPmKtxmhDR+GYw53gCaklW/jNDo8HOrn8M+
 dlxp1ZYvwehLhnIy3zzjsT7mKxhaxpZi+rDpY2mzK7iA01tSRvGwDgNN18WV8Db3F1nb
 zLnpDp3SFS/BBhh0OnXIPdoojJiRIcR+yU5LViTmzhMYKS4qJlqdKbPxffnibyaMh9t/
 wfvg==
X-Gm-Message-State: AOJu0YzqrIOBRWHcBm33m2AWX0vI9I1Sfeiu2cp14j64yuF7C9b3OnMN
 8S4x1/Z93A5/UWhTyZ+sexrXuQy3KlYJIHXOOKKZCqnyU3tTqYhtfzSwVTIAv8xuHC70uOzPZg9
 vRVn1
X-Gm-Gg: AR+sD12Uloer/cpMWlzRY1wJBosULa8tPL6ZLtYshfC9R7WFNO+ipNd9TiqkACALkAM
 KKH2ALBgtnkOpWUUVITte5caoY+NKIFJ4sdvvYue2A8pSC8P2K3uFEtMNgKa8Y2BDFB+gKBBK/h
 14CsGyca5mCBv4RXR50E5//iGtkG6QnLVcuHIIXXIV1NQg6AcPZrf1qxCt4quG2OfMAdXVCOD4u
 fJGJ0V573/B7C8xWb6RC0zSvNzb7wi+j7euL/hZYcTjvCXvmmUJCb5bJFAiZhppDJ9dP1p9m+24
 v8es61RWL8dlutqgqJ6JJLtV2nO9zrcJr/Hw+CfzlMUwzAVCH42dV8UYOIQCqRBiFCxIJNkvTTM
 zuYj13/4sm3saUbeyLxN8nGWaHOTl25afLAibKee7eEXavCFkEV8t79QiiPDbhM3oFLg5z6OqMN
 aFW+62WkPF0mUB9DTJvcV1PegbuoqcEZvkvyVaN0wdv2IA1VyGxk6hJWT4tgaEEc8O9oxhNc/3h
 9G6abT3g1kBDx5Wj6T+5byANA==
X-Received: by 2002:a17:90b:2f86:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-3933b84973fmr16022733a91.0.1786826258593; 
 Sat, 15 Aug 2026 13:37:38 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH 01/18] target/arm: Imply probe from
 allocation_tag_mem_probe
Date: Sat, 15 Aug 2026 13:37:13 -0700
Message-ID: <20260815203730.1468365-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Rename current allocation_tag_mem_probe to
allocation_tag_mem_internal, then create a new
allocation_tag_mem_probe that lacks probe and ra arguments.
Force those to true and 0 when passing off to _internal.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.h | 18 +++---------------
 target/arm/gdbstub64.c      | 10 +++++-----
 target/arm/tcg/mte_helper.c | 29 ++++++++++++++++++-----------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
index 1f471fb69b..b23a5de193 100644
--- a/target/arm/tcg/mte_helper.h
+++ b/target/arm/tcg/mte_helper.h
@@ -19,8 +19,6 @@
  * @ptr_access: the access to use for the virtual address
  * @ptr_size: the number of bytes in the normal memory access
  * @tag_access: the access to use for the tag memory
- * @probe: true to merely probe, never taking an exception
- * @ra: the return address for exception handling
  *
  * Our tag memory is formatted as a sequence of little-endian nibbles.
  * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
@@ -31,22 +29,12 @@
  * a pointer to the corresponding tag byte.
  *
  * If there is no tag storage corresponding to @ptr, return NULL.
- *
- * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
- * three options:
- * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
- *     accessible, and do not take watchpoint traps. The calling code must
- *     handle those cases in the right priority compared to MTE traps.
- * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
- *     that the page is going to be accessible. We will take watchpoint traps.
- * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
- *     traps and watchpoint traps.
- * (probe = true, ra != 0 is invalid and will assert.)
+ * If the page is inaccessible for @ptr_access, return NULL.
+ * Do not take watcnpoint traps.
  */
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   uint64_t ptr, MMUAccessType ptr_access,
-                                  int ptr_size, MMUAccessType tag_access,
-                                  bool probe, uintptr_t ra);
+                                  int ptr_size, MMUAccessType tag_access);
 
 /**
  * load_tag1 - Load 1 tag (nibble) from byte
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 0c3e5b30bd..08900f6843 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -725,8 +725,8 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
     /* Find out the current translation regime for probe. */
     mmu_index = cpu_mmu_index(env_cpu(env), false);
     /* Note that tags are packed here (2 tags packed in one byte). */
-    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
-                                    MMU_DATA_LOAD, true, 0);
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD,
+                                    1, MMU_DATA_LOAD);
     if (!tags) {
         /* Address is not in a tagged region. */
         gdb_put_packet("E04");
@@ -753,8 +753,8 @@ static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
 
     /* Find out the current translation regime for probe. */
     mmu_index = cpu_mmu_index(env_cpu(env), false);
-    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
-                                    MMU_DATA_LOAD, true, 0);
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD,
+                                    1, MMU_DATA_LOAD);
     reply = tags ? "01" : "00";
 
     gdb_put_packet(reply);
@@ -800,7 +800,7 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
     /* Find out the current translation regime for probe. */
     mmu_index = cpu_mmu_index(env_cpu(env), false);
     tags = allocation_tag_mem_probe(env, mmu_index, start_addr, MMU_DATA_STORE,
-                                    1, MMU_DATA_STORE, true, 0);
+                                    1, MMU_DATA_STORE);
     if (!tags) {
         /* Address is not in a tagged region. */
         gdb_put_packet("E04");
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index ad4ad5b4cc..a1d8618ddb 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -79,10 +79,11 @@ static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
 }
 #endif
 
-uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
-                                  uint64_t ptr, MMUAccessType ptr_access,
-                                  int ptr_size, MMUAccessType tag_access,
-                                  bool probe, uintptr_t ra)
+static uint8_t *
+allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
+                            uint64_t ptr, MMUAccessType ptr_access,
+                            int ptr_size, MMUAccessType tag_access,
+                            bool probe, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     const size_t page_data_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
@@ -91,8 +92,6 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     uint8_t *tags;
     uintptr_t index;
 
-    assert(!(probe && ra));
-
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
         if (probe) {
             return NULL;
@@ -249,8 +248,16 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    int ptr_size, MMUAccessType tag_access,
                                    uintptr_t ra)
 {
-    return allocation_tag_mem_probe(env, ptr_mmu_idx, ptr, ptr_access,
-                                    ptr_size, tag_access, false, ra);
+    return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
+                                       ptr_size, tag_access, false, ra);
+}
+
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access)
+{
+    return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
+                                       ptr_size, tag_access, true, 0);
 }
 
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
@@ -1144,7 +1151,7 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
     /* True probe; this will never fault */
     mem = allocation_tag_mem_probe(env, mmu_idx, ptr,
                                    w ? MMU_DATA_STORE : MMU_DATA_LOAD,
-                                   size, MMU_DATA_LOAD, true, 0);
+                                   size, MMU_DATA_LOAD);
     if (!mem) {
         return size;
     }
@@ -1202,7 +1209,7 @@ uint64_t mte_mops_probe_rev(CPUARMState *env, uint64_t ptr, uint64_t size,
      */
     mem = allocation_tag_mem_probe(env, mmu_idx, ptr,
                                    w ? MMU_DATA_STORE : MMU_DATA_LOAD,
-                                   1, MMU_DATA_LOAD, true, 0);
+                                   1, MMU_DATA_LOAD);
     if (!mem) {
         return size;
     }
@@ -1254,7 +1261,7 @@ void mte_mops_set_tags(CPUARMState *env, uint64_t ptr, uint64_t size,
     mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     /* True probe: this will never fault */
     mem = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE, size,
-                                   MMU_DATA_STORE, true, 0);
+                                   MMU_DATA_STORE);
     if (!mem) {
         return;
     }
-- 
2.43.0


