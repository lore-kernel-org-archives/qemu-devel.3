Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E16D3941D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8IKm-00060V-Qo; Thu, 02 Apr 2026 09:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w8IKl-0005fW-Ay
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:43:43 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w8I5s-0002RH-AM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:28:21 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CFBC60008;
 Thu,  2 Apr 2026 13:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB22C116C6;
 Thu,  2 Apr 2026 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775136491;
 bh=+Q6VYouA7YTugZZPEUHit4u4mCrzCUyb9xTNxtHHngk=;
 h=From:To:Cc:Subject:Date:From;
 b=Y3ZSW0E4qJkZ7e4vsJwy0wNksXKVXI800IIJ+/T5YFBAi7GhnSP83eHkutEf7hefh
 wZUI/WrGPzbf2zSyGjtfOwkrPiZNw3L2T+W4GWL5PA2/GyO4MW/DhkVN4cVnqQv3Dd
 Dow7dDMRp+E8RalaLk6UB96rc3KeikMTfrDDYDBcnrxwIRSWuoCiATduUxKkdyq9OZ
 A08bq36WrImM0rUAWlpUDv9xsSWXPHg3Ubi6J0vZqIiEiQndzUbpiJGa/GE3NJieY2
 30dPzZBFA2jdhsK6WWLbtn8Bh9xVeFtUMp2FQbyX8lpmb3gyWnAdRmTqXhw826T/aS
 QJos7fSHYID4g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] RFC: Allow building qemu tools on 32-bit hosts
Date: Thu,  2 Apr 2026 15:28:01 +0200
Message-ID: <20260402132801.16053-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Qemu's tools like qemu-img are often needed on 32-bit platforms,
although the actual qemu emulators have been discontinued on 32-bit.

To allow building the tools on 32-bit this patch implements two small
changes:

a) The check in meson.build is changed to still error out if the user
tries to build qemu-system or qemu-user on a 32-bit platform, but allows
building tools (e.g. by "--enable-tools") alone.

b) Remove the compile time checks in atomic.h because:
- for the qemu-system and qemu-user emulators this check is redundant
  since we only allow 64-bit platforms anyway (see a)
- it breaks those 32-bit platforms, which do provide (slower) 64-bit atomics
- 32-bit platforms without 64-bit atomics will fail instead with linker errors
- the runtime speed of the qemu tools aren't actually that important.

I've sucessfully tested building qemu tools on 32-bit hppa.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 include/qemu/atomic.h | 16 ----------------
 meson.build           |  4 ++--
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index dc9290084b..f05dce36eb 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -56,14 +56,6 @@
  */
 #define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
 
-/*
- * Sanity check that the size of an atomic operation isn't "overly large".
- * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
- * want to use them because we ought not need them, and this lets us do a
- * bit of sanity checking that other 32-bit hosts might build.
- */
-#define ATOMIC_REG_SIZE  sizeof(void *)
-
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
  * no explicit memory barrier for the processor.
@@ -79,7 +71,6 @@
 
 #define qatomic_read(ptr)                              \
     ({                                                 \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
     qatomic_read__nocheck(ptr);                        \
     })
 
@@ -87,7 +78,6 @@
     __atomic_store_n(ptr, i, __ATOMIC_RELAXED)
 
 #define qatomic_set(ptr, i)  do {                      \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
     qatomic_set__nocheck(ptr, i);                      \
 } while(0)
 
@@ -110,7 +100,6 @@
  */
 #define qatomic_rcu_read_internal(ptr, _val)            \
     ({                                                  \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
     typeof_strip_qual(*ptr) _val;                       \
     qatomic_rcu_read__nocheck(ptr, &_val);              \
     _val;                                               \
@@ -119,20 +108,17 @@
     qatomic_rcu_read_internal((ptr), MAKE_IDENTIFIER(_val))
 
 #define qatomic_rcu_set(ptr, i) do {                   \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
     __atomic_store_n(ptr, i, __ATOMIC_RELEASE);        \
 } while(0)
 
 #define qatomic_load_acquire(ptr)                       \
     ({                                                  \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
     typeof_strip_qual(*ptr) _val;                       \
     __atomic_load(ptr, &_val, __ATOMIC_ACQUIRE);        \
     _val;                                               \
     })
 
 #define qatomic_store_release(ptr, i)  do {             \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE); \
     __atomic_store_n(ptr, i, __ATOMIC_RELEASE);         \
 } while(0)
 
@@ -144,7 +130,6 @@
 })
 
 #define qatomic_xchg(ptr, i)    ({                          \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE);     \
     qatomic_xchg__nocheck(ptr, i);                          \
 })
 
@@ -157,7 +142,6 @@
 })
 
 #define qatomic_cmpxchg(ptr, old, new)    ({                            \
-    qemu_build_assert(sizeof(*ptr) <= ATOMIC_REG_SIZE);                 \
     qatomic_cmpxchg__nocheck(ptr, old, new);                            \
 })
 
diff --git a/meson.build b/meson.build
index daa58e46a3..98a708372b 100644
--- a/meson.build
+++ b/meson.build
@@ -323,8 +323,8 @@ endif
 # Compiler flags #
 ##################
 
-if cc.sizeof('void *') < 8
-  error('QEMU requires a 64-bit CPU host architecture')
+if (cc.sizeof('void *') < 8) and (have_system or have_user)
+  error('QEMU emulator requires a 64-bit CPU host architecture. Only tools may be built for 32-bit.')
 endif
 
 foreach lang : all_languages
-- 
2.53.0


