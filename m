Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74AD2A559
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 20:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1AM0-0004lX-0y; Wed, 16 Oct 2024 16:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1ALy-0004kj-NH; Wed, 16 Oct 2024 16:10:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t1ALw-0000fL-TV; Wed, 16 Oct 2024 16:10:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BEB8198F94;
 Wed, 16 Oct 2024 23:10:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A4F52156374;
 Wed, 16 Oct 2024 23:10:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 34/49] linux-user: Fix parse_elf_properties GNU0_MAGIC
 check
Date: Wed, 16 Oct 2024 23:09:53 +0300
Message-Id: <20241016201025.256294-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241016195251@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index b27dd01734..0b1c230b1c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3136,11 +3136,11 @@ static bool parse_elf_properties(const ImageSource *src,
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
@@ -3150,15 +3150,15 @@ static bool parse_elf_properties(const ImageSource *src,
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


