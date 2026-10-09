Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A5ECA601D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCa8-0001bQ-Ry; Fri, 09 Oct 2026 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ5-0001SP-D6
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ3-00080u-5V
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyJrL50gtdvm3FTztrrzURWMCb9Tz1QgOWWG3qZnCgg=;
 b=AVOnCt5qp1eOgJ3jlYZ3hmPi4r+2vf4QVV0ZI4YcxvqLm5fNxHOHIt4N/O09Rr1Pryuy+c
 ZbaCgAbHiIURS/it2yEkVjpklTkf3bY9WSsusNandlBPeWDk/nTdkyQ3CZdMtqiOte2usk
 KEMfCYOis8dXFwqtb9iXLj46PepYP+0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-vXhMczZQPd2OPZ4jqty6RQ-1; Fri,
 9 Oct 2026 15:31:13 +0000
X-MC-Unique: vXhMczZQPd2OPZ4jqty6RQ-1
X-Mimecast-MFC-AGG-ID: vXhMczZQPd2OPZ4jqty6RQ_1791559872
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C6451964CCB; Fri,  9 Oct 2026 15:31:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF02E30000E8; Fri,  9 Oct 2026 15:31:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: akalenyu@redhat.com, <qemu-block@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 8/8] scsi: use REGISTER AND IGNORE EXISTING KEY for robustness
Date: Fri,  9 Oct 2026 11:30:58 -0400
Message-ID: <20261009153058.1089786-9-stefanha@redhat.com>
In-Reply-To: <20261009153058.1089786-1-stefanha@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The regular REGISTER service action fails with RESERVATION CONFLICT when
the I_T nexus already has a key registered. While we don't expect a key
to be registered, it is fragile to rely on this. If there is a key
registered for some reason, live migration will fail when the
destination hits the RESERVATION CONFLICT error.

Use REGISTER AND IGNORE EXISTING KEY so that the command is likely to
succeed.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-generic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index e41e973aa92..e48fcb926f1 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -424,7 +424,8 @@ static void scsi_handle_persistent_reserve_out_reply(
     }
 }
 
-static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
+static bool scsi_generic_pr_register_ignore(SCSIDevice *s, uint64_t key,
+                                            Error **errp)
 {
     uint8_t cmd[10] = {};
     uint8_t buf[24] = {};
@@ -432,14 +433,15 @@ static bool scsi_generic_pr_register(SCSIDevice *s, uint64_t key, Error **errp)
     int ret;
 
     cmd[0] = PERSISTENT_RESERVE_OUT;
-    cmd[1] = PRO_REGISTER;
+    cmd[1] = PRO_REGISTER_AND_IGNORE_EXISTING_KEY;
     cmd[8] = sizeof(buf);
     memcpy(&buf[8], &key_be, sizeof(key_be));
 
     ret = scsi_SG_IO(s->conf.blk, SG_DXFER_TO_DEV, cmd, sizeof(cmd),
                      buf, sizeof(buf), s->io_timeout, errp);
     if (ret < 0) {
-        error_prepend(errp, "PERSISTENT RESERVE OUT with REGISTER: ");
+        error_prepend(errp, "PERSISTENT RESERVE OUT with "
+                      "REGISTER AND IGNORE EXISTING KEY: ");
         return false;
     }
     return true;
@@ -620,7 +622,7 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
         return true; /* no PR state, do nothing */
     }
 
-    if (!scsi_generic_pr_register(s, key, errp)) {
+    if (!scsi_generic_pr_register_ignore(s, key, errp)) {
         return false;
     }
 
@@ -647,7 +649,7 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
      * CONFLICT is expected if our registration remained in place.
      */
     if (resv_type == 0) {
-        scsi_generic_pr_register(s, key, NULL);
+        scsi_generic_pr_register_ignore(s, key, NULL);
     }
     return true;
 }
-- 
2.56.0


