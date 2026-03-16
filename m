Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33C8EFCBD7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226R-0007qD-AZ; Mon, 16 Mar 2026 03:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225c-0007Tq-2q; Mon, 16 Mar 2026 03:10:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225Y-0007jc-V1; Mon, 16 Mar 2026 03:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645002; bh=1vJ3glu4hYTQGumw1VmumcQjcBoRBkkjsNqx/2fzMLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=muMKQrcgAu5/OlUGi0v3VDos9Z+2mp3ZRyT//aXdspDUKH1y0RsjIJoEXKTKzgp00
 IeR7QlCScCga8zP3AlzeP7BMR2c6sOp1Ij8yapAiF75CblIrJM7BKM2VfRu6OVY08Y
 mbjYT2YHoeS63PFcWGTKinxag5+nS74kYpMuZ/xdtdlvAJ0p4AXaUU4pP48dZBzRXA
 CNzjxpAS+Z0wT9irDIxdswXPfN3pWAcOqZuHorZc80SsmatBJ3KvDa3MBJ95pSvqDu
 TDupA16WtYVW3114vWdmBla0CK6bkFFcTrSSS7VBsLdNjVGX6Ruxe6oVaepwaFYt9i
 xYm5shWiSMHxQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B497193C23;
 Mon, 16 Mar 2026 10:10:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 738D038004B;
 Mon, 16 Mar 2026 10:10:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Christopher Palmer-Richez <crichez@pm.me>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 01/14] net/slirp: allow hostfwd socket paths with dashes
Date: Mon, 16 Mar 2026 10:09:49 +0300
Message-ID: <20260316071005.91624-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Christopher Palmer-Richez <crichez@pm.me>

Adds get_last_str_sep, a variant of get_str_sep that checks for the last
occurence of a separator. Updates slirp_hostfwd to parse unix domain
socket paths with dashes.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/347
Signed-off-by: Christopher Palmer-Richez <crichez@pm.me>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 net/slirp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/slirp.c b/net/slirp.c
index 04925f3318..968be9cc99 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -69,6 +69,26 @@ static int get_str_sep(char *buf, int buf_size, const char **pp, int sep)
     return 0;
 }
 
+static int get_last_str_sep(char *buf, int buf_size, const char **pp, int sep)
+{
+    const char *p, *p1;
+    int len;
+    p = *pp;
+    p1 = strrchr(p, sep);
+    if (!p1)
+        return -1;
+    len = p1 - p;
+    p1++;
+    if (buf_size > 0) {
+        if (len > buf_size - 1)
+            len = buf_size - 1;
+        memcpy(buf, p, len);
+        buf[len] = '\0';
+    }
+    *pp = p1;
+    return 0;
+}
+
 /* slirp network adapter */
 
 #define SLIRP_CFG_HOSTFWD 1
@@ -848,7 +868,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
     if (is_unix) {
-        if (get_str_sep(buf, sizeof(buf), &p, '-') < 0) {
+        if (get_last_str_sep(buf, sizeof(buf), &p, '-') < 0) {
             fail_reason = "Missing - separator";
             goto fail_syntax;
         }
-- 
2.47.3


