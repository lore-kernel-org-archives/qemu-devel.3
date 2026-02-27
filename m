Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E01FEFB71
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 17:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw1Sz-0004QD-8h; Fri, 27 Feb 2026 12:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw10E-0004CG-Nz
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:46 -0500
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw10D-0004Pl-59
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:46 -0500
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id 744931C00C2;
 Fri, 27 Feb 2026 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1772210863; bh=NMm/kX32LRg+v6QZcosiJTzs2eIW/U8R2D6wOBaE0dI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iOU6BRUL+Q4mWqYXW7S8HzTgX8rfUfMBCAqbzuNn5UPC6lUfTw8hsyzxAmbd3zCjd
 MfOn0nFk9EKjz6kK2Ld4RlrFB2I+Z0dXUyhAGls0PIsgL7/gZXThHGVcqexfYd4Yaf
 qp8iJBncsEhxukGGy/LZGuWnPQieLPXOE/56ErKVlPw/7RR2ZJbcRtpyiNpd5cxqCq
 tFU9KcAWT7nEZZ41ketDJTnnH0XpUqEwezCxXN/cxxiaQX9+pf0vEDondf8OJagK0j
 VoAQNB05xJzOI/CSeOvuN/g7qeTEdL8Fq1LQJIQ5RLr49R+53bNTj+qUVNybGb+LgF
 wZncfQ0qkwPxjxEgIeJ2rEhoN08kw6hOS/l21ZcXmBadrTYCLqZoxsS0bkbSIx6QXV
 xLozequvba6LFd0SEsxlk4PXtrLCpqTuaYUwPSzOqN/kvj4P2fa+B918tcmrMXqPLz
 m1RCOuL5CxsTShGRE5w9D4jAIJ8PS/gelcm5t8khQb2jpVltaD+shHxnjIR71SyZN/
 1IC3EofxS/Np5cPAPaZloXp/6BO/RGLfKOekzAa8tG8A3xmKn6lLfybMh3H1626ycX
 Q8SQ7EZyu4S0MjMt/eQcJsw1P8Qh+nBxyne+oimqMfhkkDJbVr1zWP2C5fy4OvIT3E
 AgmKaxpNJNtATE737HHYkq7g=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 52mR_DDD6IXc; Fri, 27 Feb 2026 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [142.248.151.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Fri, 27 Feb 2026 16:47:35 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
Date: Sat, 28 Feb 2026 00:46:31 +0800
Subject: [PATCH 2/4] bsd-user: Deal with mmap where start > reserved_va
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-abyss-mmap-relocation-v1-2-c8ec0476894b@astrafall.org>
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
In-Reply-To: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Bingwu Zhang <xtex@astrafall.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162; i=xtex@astrafall.org;
 h=from:subject:message-id; bh=7ZViOWjw7i41r2hZsN2jRt+YQI5vco7wj7fO41K7UUM=;
 b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDJkLT01Nt90o89/8R2nu6y1WQRYc6osZpkQLr92qdPP2B
 0MvU/frHRNZGMS4GCzFFFmKDBu8WXXS+UWXlcvCzGFlAhkiLdLAwMDAwMLAl5uYV2qkY6Rnqm2o
 Z2ioY6RjxMDFKQBTbXSUkeGt5DPmV/Gfnk+I+iOxv/K4z4frx11dmjxe8pVNe/Hwbk4AI8ND+ft
 12nNtbG3fbFnxRadx7zPv206i900PmklWPTuXasAMAA==
X-Developer-Key: i=xtex@astrafall.org; a=openpgp;
 fpr=7231804B052C670F15A6771DB918086ED8045B91
Received-SPF: pass client-ip=157.180.15.194; envelope-from=xtex@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Feb 2026 12:17:25 -0500
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

From: Bingwu Zhang <xtex@astrafall.org>

Fixes: f12294b5bd21 ("bsd-user: Use page_find_range_empty for mmap_find_vma_reserved")
Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
---
 bsd-user/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 24ba1728eb55..fe77eceb4856 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -258,12 +258,14 @@ abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong alignment)
 {
-    abi_ulong ret;
+    abi_ulong ret = -1;
 
-    ret = page_find_range_empty(start, reserved_va, size, alignment);
+    if (start <= reserved_va) {
+        ret = page_find_range_empty(start, reserved_va, size, alignment);
+    }
     if (ret == -1 && start > TARGET_PAGE_SIZE) {
         /* Restart at the beginning of the address space. */
-        ret = page_find_range_empty(TARGET_PAGE_SIZE, start - 1,
+        ret = page_find_range_empty(TARGET_PAGE_SIZE, MIN(start - 1, reserved_va),
                                     size, alignment);
     }
 

-- 
2.52.0


