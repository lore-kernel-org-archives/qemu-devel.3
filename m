Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB92EFCD63
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzX4o-0001zJ-C0; Mon, 09 Mar 2026 05:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vzX4d-0001yC-5q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vzX4Y-0007Bi-N6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773049125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XMJw33FTROJsJV7N4Rh2nOPIMyVgCTPQtgv7C5NvxW0=;
 b=YlGtQsGG+n0G9SQK+6Rh/+2KBiuwxiXMgMc3gYtf0A9oa+y+QEOTRJG5IgW6gsC7m2ihql
 ICLzEhHnKgZo9UyW1wJyhfdh0Q3MShUutEsBFjyzuFLxdBSxcSjCSZ3vF/gmLc4VU70E+p
 qjz0WjUkg01rAxYKu4dB9Zh/Vf/2I3c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-U4Tagv_8OP-XJ5mVUijfQg-1; Mon,
 09 Mar 2026 05:38:43 -0400
X-MC-Unique: U4Tagv_8OP-XJ5mVUijfQg-1
X-Mimecast-MFC-AGG-ID: U4Tagv_8OP-XJ5mVUijfQg_1773049122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5AD119560B0; Mon,  9 Mar 2026 09:38:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8C981956095; Mon,  9 Mar 2026 09:38:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] hw/i3c/dw-i3c: Fix memory leaks in error logging paths
Date: Mon,  9 Mar 2026 10:38:38 +0100
Message-ID: <20260309093838.364126-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

object_get_canonical_path() returns an allocated string that must be
freed by the caller. Use g_autofree variables to ensure that memory is
not leaked.

Resolves: Coverity CID 1645550
Resolves: Coverity CID 1645553
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/dw-i3c.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 3d8b95a14c4b..e9bdfd6af2ac 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -490,8 +490,9 @@ static int dw_i3c_recv_data(DWI3C *s, bool is_i2c, uint8_t *data,
     /* I3C devices can NACK if the controller sends an unsupported CCC. */
     ret = i3c_recv(s->bus, data, num_to_read, num_read);
     if (ret) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
         qemu_log_mask(LOG_GUEST_ERROR, "%s: NACKed receiving byte\n",
-                      object_get_canonical_path(OBJECT(s)));
+                      path);
         ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_ST_STATUS,
                          DW_I3C_TRANSFER_STATE_HALT);
         ARRAY_FIELD_DP32(s->regs, PRESENT_STATE, CM_TFR_STATUS,
@@ -1107,8 +1108,9 @@ static void dw_i3c_resp_queue_push(DWI3C *s, uint8_t err, uint8_t tid,
 static void dw_i3c_push_tx(DWI3C *s, uint32_t val)
 {
     if (fifo32_is_full(&s->tx_queue)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(s));
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Tried to push to TX FIFO when "
-                      "full\n", object_get_canonical_path(OBJECT(s)));
+                      "full\n", path);
         return;
     }
 
-- 
2.53.0


