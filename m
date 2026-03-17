Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A715CFD8764
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TwT-0008Tx-2n; Tue, 17 Mar 2026 08:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shyliuli@aosc.io>) id 1w2N8o-0002k1-Bl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 01:38:55 -0400
Received: from relay3.mymailcheap.com ([217.182.119.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shyliuli@aosc.io>) id 1w2N8l-00029P-0Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 01:38:53 -0400
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
 by relay3.mymailcheap.com (Postfix) with ESMTPS id 0C6113EC16;
 Tue, 17 Mar 2026 05:38:40 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 by nf2.mymailcheap.com (Postfix) with ESMTPSA id F04404007C;
 Tue, 17 Mar 2026 05:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
 t=1773725917; bh=umYyLvqzELC3P2uR4dNmjT2sdWU3MiEUKd0uUobSRfY=;
 h=From:To:Cc:Subject:Date:From;
 b=mTGS6F2n1IyR3BT4XTDlMKHpQTJr/HWwR2F5/JDbSKXKrnpnY/o8DxH+/otNLsUAp
 igPk57RTrkDO2H7pHeznaii5ZqWTpyTv/2DCifOGyd74T5YGfktmKwm2ejdczbChoY
 U5/QqOPFO85sUS0IQKqo0pFoSxpMgeC/u0EQ6mtQ=
Received: from ArchLinux-desktop (unknown [123.138.183.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3D36C410D9;
 Tue, 17 Mar 2026 05:38:30 +0000 (UTC)
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] linux-user: Make openat2() use -L for absolute paths
Date: Tue, 17 Mar 2026 13:38:27 +0800
Message-ID: <20260317053827.25051-1-shyliuli@aosc.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: F04404007C
X-Spamd-Result: default: False [1.20 / 10.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
 R_SPF_ALLOW(-0.10)[+mx]; MIME_GOOD(-0.10)[text/plain];
 LOCAL_OUTBOUND(0.00)[]; RCVD_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[aosc.io:+]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=217.182.119.155; envelope-from=shyliuli@aosc.io;
 helo=relay3.mymailcheap.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:54:34 -0400
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
Reply-to:  Sun Haoyu <shyliuli@aosc.io>
From:  Sun Haoyu via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

openat2() ignored the -L prefix and opened host files directly.
For example, openat2("/tmp/file") opened /tmp/file on the host, not
QEMU_LD_PREFIX/tmp/file like openat() does.

Fix this by using path() to rewrite absolute paths. Skip this
when RESOLVE_BENEATH or RESOLVE_IN_ROOT is set:
- RESOLVE_BENEATH rejects absolute paths anyway
- RESOLVE_IN_ROOT resolves relative to dirfd

Now openat() and openat2() work in the same way.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3341

Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
---
 linux-user/syscall.c      | 11 ++++++++++-
 linux-user/syscall_defs.h |  7 ++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 064bc604c9..cff487f014 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8848,7 +8848,16 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
     if (fd > -2) {
         ret = get_errno(fd);
     } else {
-        ret = get_errno(safe_openat2(dirfd, pathname, &how,
+        const char *host_pathname = pathname;
+        if (pathname[0] == '/' &&
+            !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
+            /*
+             * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
+             * resolves them relative to dirfd.
+             */
+            host_pathname = path(pathname);
+        }
+        ret = get_errno(safe_openat2(dirfd, host_pathname, &how,
                                      sizeof(struct open_how_ver0)));
     }
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 20d862fd8b..6a62a45847 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2777,7 +2777,12 @@ struct target_open_how_ver0 {
 #ifndef RESOLVE_NO_SYMLINKS
 #define RESOLVE_NO_SYMLINKS     0x04
 #endif
-
+#ifndef RESOLVE_BENEATH
+#define RESOLVE_BENEATH         0x08
+#endif
+#ifndef RESOLVE_IN_ROOT
+#define RESOLVE_IN_ROOT         0x10
+#endif
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
     (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
     defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
-- 
2.53.0


