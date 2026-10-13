Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CD8CC6B1A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGh5W-0007Ai-S6; Tue, 13 Oct 2026 14:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4m-0006xU-GS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4k-00014u-66
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791915489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5EsQIfODyO7SmUrEsyt9aN00pLM9//FBxp1hkNZgmw=;
 b=ZVDu98zMF+0d/q6wj32MX56BuBpXOFIioyHe39SJrgUqdceRwU7brKDhw1Hx2qKog7GWPv
 DEeRc82bAJaMTeSsBRjSnqGH1lFhNq+gGWKPxsn2RNP2qqYpatSLtWXT6klJwOYeE6XO/s
 oACswxvnWUOcbEd0nXvjpDAhwR/x2cM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-D0osUGsDMo-gQvtNdKwv-g-1; Tue,
 13 Oct 2026 18:18:05 +0000
X-MC-Unique: D0osUGsDMo-gQvtNdKwv-g-1
X-Mimecast-MFC-AGG-ID: D0osUGsDMo-gQvtNdKwv-g_1791915484
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEE8B1800765; Tue, 13 Oct 2026 18:18:04 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7295B195608E; Tue, 13 Oct 2026 18:18:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 6/8] file-posix: forward PR_HELPER_CLEANUP commands to
 pr-manager
Date: Tue, 13 Oct 2026 14:17:50 -0400
Message-ID: <20261013181752.1299456-7-stefanha@redhat.com>
In-Reply-To: <20261013181752.1299456-1-stefanha@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
- Ignore PR_HELPER_CLEANUP commands when there is no pr-manager to avoid
  passing through this QEMU-internal vendor-specific command to the
  underlying SCSI device.
---
 block/file-posix.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 328adb57233..df117f35d48 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -4362,12 +4362,20 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
         return ret;
     }
 
-    if (req == SG_IO && s->pr_mgr) {
+    if (req == SG_IO) {
         struct sg_io_hdr *io_hdr = buf;
-        if (io_hdr->cmdp[0] == PERSISTENT_RESERVE_OUT ||
-            io_hdr->cmdp[0] == PERSISTENT_RESERVE_IN) {
-            return pr_manager_execute(s->pr_mgr, qemu_get_current_aio_context(),
-                                      s->fd, io_hdr);
+
+        if (s->pr_mgr) {
+            if (io_hdr->cmdp[0] == PERSISTENT_RESERVE_OUT ||
+                io_hdr->cmdp[0] == PERSISTENT_RESERVE_IN ||
+                io_hdr->cmdp[0] == PR_HELPER_CLEANUP) {
+                return pr_manager_execute(s->pr_mgr, qemu_get_current_aio_context(),
+                                          s->fd, io_hdr);
+            }
+        } else if (io_hdr->cmdp[0] == PR_HELPER_CLEANUP) {
+            /* This is a nop without pr-manager */
+            io_hdr->status = GOOD;
+            return 0;
         }
     }
 
-- 
2.56.0


