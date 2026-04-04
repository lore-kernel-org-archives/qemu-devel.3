Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DD0E63FF9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 22:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w99fL-0004XX-NS; Sat, 04 Apr 2026 18:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w99fJ-0004X2-AO
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 18:40:29 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w99fF-0006wF-Jr
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 18:40:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B0A1C4054B;
 Sat,  4 Apr 2026 22:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC1AC19421;
 Sat,  4 Apr 2026 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775342419;
 bh=QQH19VbRhYXYPUyEUH1EWv9i9L2lje3mJnL+gL0s4+s=;
 h=Date:From:To:Subject:From;
 b=QepZcu1tMVc06bDf2+mMoDmGYnhiBFwNaUhsfNx7XQlC9GKrY9XF4ek3+pNYoXMaO
 XpXIHXfi9n7pQn6FECR6alUZeEwlajQGAKRmoLDSjRmX++tVHAv5Jth9YZcJ42r3vJ
 AHoGxcUBtRRgoLjJ/+nHBdGEAkA1PFzxlBEni0ILCzYW0zQKKOkqzFEE0RP/q3tH4v
 BlhizKF0Utqbbc31EFa27WH3YJb/vkT2i6/wMyJYCs6zT1pnZeLSRSHZDVS82TJ/0n
 rrtY/7m1hlg6ZmYsQD1FilEDCozYiy8RcpFOH78rKn6IwSGewOOQYzfq0imcrvegHP
 ZIYdIXmJubw3w==
Date: Sun, 5 Apr 2026 00:40:16 +0200
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v3] Allow building qemu tools on 32-bit hosts
Message-ID: <adGTUNUSckx1KrAk@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Qemu's tools like qemu-img are often needed on 32-bit platforms,
although the actual qemu emulators have been discontinued on 32-bit.

To allow building the tools on 32-bit this patch implements three small
changes:

a) The check in meson.build is changed to still error out if the user
tries to build qemu-system or qemu-user on a 32-bit platform, but allows
building tools (e.g. by "--enable-tools") alone.

b) The compile time check in atomic.h now checks against
sizeof(uint64_t) so that 32-bit environments can still build
successfully, while 128-bit atomic operations are prevented to sneak in.

c) Allow linking against libatomic as long as we don't build the
qemu-system and qemu-user binaries.

Sucessfully tested on the 32-bit big-endian powerpc architecture.

v2:
- keep comple time checks in atomic.h
- allow linking against libatomic when building tools

v3:
- Drop "-Wl,"
- added S-o-b

Signed-off-by: Helge Deller <deller@gmx.de>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index dc9290084b..e4dd948863 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -58,11 +58,11 @@
 
 /*
  * Sanity check that the size of an atomic operation isn't "overly large".
- * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
+ * Despite the fact that e.g. x86-64 has 128-bit atomic operations, we do not
  * want to use them because we ought not need them, and this lets us do a
- * bit of sanity checking that other 32-bit hosts might build.
+ * bit of sanity checking that other 32- and 64-bit hosts might build.
  */
-#define ATOMIC_REG_SIZE  sizeof(void *)
+#define ATOMIC_REG_SIZE  sizeof(uint64_t)
 
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
diff --git a/meson.build b/meson.build
index daa58e46a3..ab3e97eb9f 100644
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
@@ -423,8 +423,16 @@ endif
 #
 # Later checks assume we won't get atomic ops for int128 without
 # explicitly asking for -latomic, so we must disable GCC's new
-# automatic linking with the new -fno-link-libatomic flag
-qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
+# automatic linking with the new -fno-link-libatomic flag.
+#
+# When not building the emulators, but qemu helper tools only
+# (e.g. on 32-bit hosts), libatomic is sometimes required and
+# thus acceptable.
+if (have_system or have_user)
+  qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
+else
+  qemu_ldflags += cc.get_supported_link_arguments('-latomic')
+endif
 
 qemu_common_flags = qemu_isa_flags + qemu_common_flags
 

