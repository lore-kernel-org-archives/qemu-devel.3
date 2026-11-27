Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=VQNc4rCG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoxC-00008R-27; Fri, 27 Nov 2026 00:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWox3-00081T-QK; Fri, 27 Nov 2026 00:56:54 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWox1-0002aA-6z; Fri, 27 Nov 2026 00:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758876; bh=5VCM8CNKflsja39CJaxAzuKHYJJ2u3s2/BZ3CTRKjVg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VQNc4rCGE4UTcU2UiBIQX84ljMxKnOdCKcO0Mm6w6sl1cxOXEZge/NyuO4n/1LRoU
 xS9C3i0p0t5Eh76x2wfNHoqDTGQjXoWCyrRuxh9NJbQa3yXDwSTJFl9N+dZcvFq+jh
 F9O+4PbwKYwMiZAs8/SJlQI6hIsyONE6vQCjgEnfcnYZ11nFJPiFSvAUIQyvRcPY9S
 90un4CY1z2WZdIJ/f3sBQW9h7U/rIl8zlHc7CuYUE7kxsV6uuZNGrWgon1Tnwv6dA+
 bYlKwIsmYqtMVYXEzQ0e3ZNrUCCD7+8tUsEfM+GLNeYQ2l/mrJEAqEedpJj8C67tbv
 WSTd6hX17ZIEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 134A91EA2E2;
 Fri, 27 Nov 2026 08:54:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 10C6C46991D;
 Fri, 27 Nov 2026 08:54:36 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0ACDCCF246; Fri, 27 Nov 2026 08:54:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifano@redhat.com>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 088/140] hw/usb/dev-mtp: Fix recursive delete of
 directories
Date: Fri, 27 Nov 2026 08:53:14 +0300
Message-ID: <20261127055421.39015-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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
index 6bb1fc575e8..e5bab250559 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1153,19 +1153,20 @@ enum {
 
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


