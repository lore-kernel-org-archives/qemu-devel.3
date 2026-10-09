Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EAFCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCZw-0001ZL-Uh; Fri, 09 Oct 2026 11:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ1-0001S1-Bd
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCYz-0007zj-SA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OobCKqtAno6tcheEnGg69jGbwQ9liU9tK+7iTZfAfx4=;
 b=dTC7DIHz5NRqeVHnvlpdNw4WZoxq4lVB6dE+sgroDamMtok+Bq33NvPm93ASnfmNjZMCDK
 lL5QurvsI+aRByJkDlDTMs6HvNJkF6NQAFOH72Q30abjYgWzgTqEHhVjl5sl3uQFZLjHEv
 Qd62BcKlPy5IJt+mjRB1Ejgo3RTKiM4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-D4rBIoKCPlWS_7xZOa6Bsg-1; Fri,
 9 Oct 2026 15:31:05 +0000
X-MC-Unique: D4rBIoKCPlWS_7xZOa6Bsg-1
X-Mimecast-MFC-AGG-ID: D4rBIoKCPlWS_7xZOa6Bsg_1791559864
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F19E18021FD; Fri,  9 Oct 2026 15:31:04 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFF0918005B3; Fri,  9 Oct 2026 15:31:02 +0000 (UTC)
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
Subject: [PATCH 2/8] scsi: increase sense buffer size in scsi_SG_IO()
Date: Fri,  9 Oct 2026 11:30:52 -0400
Message-ID: <20261009153058.1089786-3-stefanha@redhat.com>
In-Reply-To: <20261009153058.1089786-1-stefanha@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are different SCSI sense formats. Increase the size so we can get
more detailed sense data.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-generic.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 8999f3b7200..153a5275567 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -923,7 +923,7 @@ int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
                uint32_t timeout, Error **errp)
 {
     sg_io_hdr_t io_header;
-    uint8_t sensebuf[8] = {};
+    uint8_t sensebuf[SCSI_SENSE_LEN] = {};
     int ret;
 
     memset(&io_header, 0, sizeof(io_header));
@@ -947,15 +947,18 @@ int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
             error_setg_errno(errp, -ret, "SG_IO ioctl failed");
         } else {
             g_autofree char *sensebuf_hex =
-                g_strdup_printf("%02x%02x%02x%02x%02x%02x%02x%02x",
-                                sensebuf[0],
-                                sensebuf[1],
-                                sensebuf[2],
-                                sensebuf[3],
-                                sensebuf[4],
-                                sensebuf[5],
-                                sensebuf[6],
-                                sensebuf[7]);
+                g_strdup_printf("%02x%02x%02x%02x%02x%02x%02x%02x"
+                                "%02x%02x%02x%02x%02x%02x%02x%02x"
+                                "%02x%02x",
+                                sensebuf[0], sensebuf[1],
+                                sensebuf[2], sensebuf[3],
+                                sensebuf[4], sensebuf[5],
+                                sensebuf[6], sensebuf[7],
+                                sensebuf[8], sensebuf[9],
+                                sensebuf[10], sensebuf[11],
+                                sensebuf[12], sensebuf[13],
+                                sensebuf[14], sensebuf[15],
+                                sensebuf[16], sensebuf[17]);
 
             error_setg(errp, "SG_IO SCSI command failed with status=0x%x "
                     "driver_status=0x%x host_status=0x%x sensebuf=%s "
-- 
2.56.0


