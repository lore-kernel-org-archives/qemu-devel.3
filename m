Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF4606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=vO07uv1p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6m-0004sB-Ep; Fri, 27 Nov 2026 01:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5P-0007yz-Hg; Fri, 27 Nov 2026 01:05:33 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp5M-0006C9-Aa; Fri, 27 Nov 2026 01:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759045; bh=0KK3j5YSm7jpSkKniMVDVHom+HKaGWtO6xh8LdPOP9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vO07uv1p7+/MW+iZLuZkw6nMNT2DIGFl3jpezMJl3li7pMMDEdUkGjB5T1nxxXma1
 MXCK0nX/bcupyB3psRMR4L5nBTx4ugrmy599qZebBMZWGp10tEKWliVULAmS5/787x
 kRuikOa3jw4DAW5mt80ToUDWiIUo35s69OLCTBZO/9SHwRPk4sJWzXEASEaizewTbg
 CwqEYt0/l9OLOnljQ1sFuGjFpc/okDjg2KDw9tfgXAThfkHVIPCcPyCuXfk6pzLqmi
 wdm4Gi7jC2cwDLCSjKBPWmkDHlwW6GRP26pXTOO9pYeRXA21sYo+n6kAD+982TIwLc
 9ms7m4nR/p7YA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2AD811EA350;
 Fri, 27 Nov 2026 08:57:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 26F5D46997B;
 Fri, 27 Nov 2026 08:57:25 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 20168CF2EE; Fri, 27 Nov 2026 08:57:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifano@redhat.com>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 094/152] hw/usb/dev-mtp: Fix recursive delete of
 directories
Date: Fri, 27 Nov 2026 08:53:52 +0300
Message-ID: <20261127055709.39630-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Tommaso Califano <tcalifano@redhat.com>

usb_mtp_deletefn() only recursed into the grandchildren of the target,
never deleting the files directly inside it. The directory was left
non-empty, so rmdir() on the host always failed, and objects nested more
than two levels deep were silently kept.

Recurse into every child of the target instead. Since the root directory
can now actually become empty, skip the root object itself: rmdir()'ing
it and freeing it would leave s->objects empty.

Cc: qemu-stable@nongnu.org
Fixes: ec6206a68f70 ("usb-mtp: Support delete of mtp objects")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Junjie Cao <junjie.cao@linux.dev>
Tested-by: Junjie Cao <junjie.cao@linux.dev>
Message-ID: <20261112174907.158825-2-tcalifano@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 224899c3d3bee6d7c4b02eb1c6e7bf5f66ce6159)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 8507e516ab1..bc5a6f08917 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1152,19 +1152,20 @@ enum {
 
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
-    MTPObject *iter, *iter2, *iter2_next;
+    MTPObject *iter, *iter_next;
     int ret = 0;
 
     /*
      * TODO: Add support for Protection Status
      */
 
-    QLIST_FOREACH(iter, &o->children, list) {
-        if (iter->format == FMT_ASSOCIATION) {
-            QLIST_FOREACH_SAFE(iter2, &iter->children, list, iter2_next) {
-                ret |= usb_mtp_deletefn(s, iter2, trans);
-            }
-        }
+    QLIST_FOREACH_SAFE(iter, &o->children, list, iter_next) {
+        ret |= usb_mtp_deletefn(s, iter, trans);
+    }
+
+    /* Avoid deleting the mtp root */
+    if (o->parent == NULL) {
+        return ret ? ret : DELETE_SUCCESS;
     }
 
     if (o->format == FMT_UNDEFINED_OBJECT) {
-- 
2.47.3


