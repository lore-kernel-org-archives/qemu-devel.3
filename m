Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE22D0E6CD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNsDm-0004QS-FC; Tue, 25 Nov 2025 07:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vNsDa-0004Oq-JR
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:32:28 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vNsDV-0000fX-KY
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qu
 //VK0cdHDP8ZpGEq1WJhGTg/BK7zqSMnYv9AmgRdc=; b=WnjYGegAkc0nkI6dKK
 hnRIlk1X5P+/w+gw4flx3EsIxyPeHjmAD9LIQRBKT5d4sr+UUQOMYiJc2+rtdoB9
 UKx8qGZN2Rm4ktKY1t2Fw5G6ib8MtLxmWPTzoI8wsD/lBTPfuAOCT0pqDoRiE4ZV
 8Ych3tBH7+9Jmzft4JhmzPSV0=
Received: from DESKTOP-V2BFH29.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wBX5cctnyVp8fZPCQ--.1513S2; 
 Tue, 25 Nov 2025 20:21:03 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Alano Song <AlanoSong@163.com>
Subject: [RFC] ui/vnc: Fix qemu abort when query vnc info
Date: Tue, 25 Nov 2025 20:20:59 +0800
Message-ID: <20251125122059.24420-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBX5cctnyVp8fZPCQ--.1513S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1kCFy8JFyxCF1rJF4UXFb_yoW8JFW5pF
 ZxGas5Wr43Xrn7Crn3Z3y0gFyrGry0yr4fJr1ayw4fKr45Jr4UZryYkryqqFWjkrnY9w4F
 qay0ga4agw4kGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRLZ2sUUUUU=
X-Originating-IP: [59.174.57.70]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbBXwARFGklnDUybAABsg
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Alano Song <AlanoSong@163.com>

When there is no display device on qemu machine,
and user only access qemu by remote vnc.
At the same time user input `info vnc` by QMP,
the qemu will abort.

To avoid the abort above, I add display device check,
when query vnc info in qmp_query_vnc_servers().

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 ui/vnc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 0d499b208b..2fa79a5494 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -556,9 +556,20 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
         qmp_query_auth(vd->auth, vd->subauth, &info->auth,
                        &info->vencrypt, &info->has_vencrypt);
         if (vd->dcl.con) {
-            dev = DEVICE(object_property_get_link(OBJECT(vd->dcl.con),
-                                                  "device", &error_abort));
-            info->display = g_strdup(dev->id);
+            Error *err = NULL;
+            Object *obj = object_property_get_link(OBJECT(vd->dcl.con),
+                                                   "device", &err);
+            if (obj) {
+                dev = DEVICE(obj);
+                if (dev && dev->id) {
+                    info->display = g_strdup(dev->id);
+                } else {
+                    info->display = g_strdup("unknown");
+                }
+            } else {
+                info->display = g_strdup("none");
+                error_free(err);
+            }
         }
         if (vd->listener != NULL) {
             nsioc = qio_net_listener_nsioc(vd->listener);
-- 
2.43.0


