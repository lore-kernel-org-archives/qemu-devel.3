Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F842D5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f8N-0003Co-PE; Sat, 09 Nov 2024 01:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8C-00035K-6h; Sat, 09 Nov 2024 01:39:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f87-000208-1P; Sat, 09 Nov 2024 01:39:33 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C94B2A12EE;
 Sat,  9 Nov 2024 09:38:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3F71B167DD2;
 Sat,  9 Nov 2024 09:39:04 +0300 (MSK)
Received: (nullmailer pid 3272512 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 07/33] linux-user: Fix parse_elf_properties GNU0_MAGIC
 check
Date: Sat,  9 Nov 2024 09:38:33 +0300
Message-Id: <20241109063903.3272404-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Comparing a string of 4 bytes only works in little-endian.

Adjust bulk bswap to only apply to the note payload.
Perform swapping of the note header manually; the magic
is defined so that it does not need a runtime swap.

Fixes: 83f990eb5adb ("linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 2884596f5f385b5712c356310dd4125a089888a8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 87895847ec..97528a13ed 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2899,11 +2899,11 @@ static bool parse_elf_properties(int image_fd,
     }
 
     /*
-     * The contents of a valid PT_GNU_PROPERTY is a sequence
-     * of uint32_t -- swap them all now.
+     * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
+     * Swap most of them now, beyond the header and namesz.
      */
 #ifdef BSWAP_NEEDED
-    for (int i = 0; i < n / 4; i++) {
+    for (int i = 4; i < n / 4; i++) {
         bswap32s(note.data + i);
     }
 #endif
@@ -2913,15 +2913,15 @@ static bool parse_elf_properties(int image_fd,
      * immediately follows nhdr and is thus at the 4th word.  Further, all
      * of the inputs to the kernel's round_up are multiples of 4.
      */
-    if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
-        note.nhdr.n_namesz != NOTE_NAME_SZ ||
+    if (tswap32(note.nhdr.n_type) != NT_GNU_PROPERTY_TYPE_0 ||
+        tswap32(note.nhdr.n_namesz) != NOTE_NAME_SZ ||
         note.data[3] != GNU0_MAGIC) {
         error_setg(errp, "Invalid note in PT_GNU_PROPERTY");
         return false;
     }
     off = sizeof(note.nhdr) + NOTE_NAME_SZ;
 
-    datasz = note.nhdr.n_descsz + off;
+    datasz = tswap32(note.nhdr.n_descsz) + off;
     if (datasz > n) {
         error_setg(errp, "Invalid note size in PT_GNU_PROPERTY");
         return false;
-- 
2.39.5


