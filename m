Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F3CC44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkRpv-0002zB-5H; Thu, 16 Jul 2026 15:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkRps-0002yM-Sc
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:33:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wkRpq-0005Xi-3w
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784230408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=esVHY9gqyyu9JCDoSbr4qjILp7A8+XrQkoBrzUOlL30=;
 b=Tx6hKeU/jKCECbo9p+ARIrNph1BmDv1zNbLq8V7F5wfGiZopF2GxIuyey6tdm5KZ7bv9rC
 sAHm3D0z2hSavkg+wLTiR+pfjvMFvY/9XIdS1iFdCLF5O3YSyC4mtL4A0wdxvpy+FrQoQi
 1of6d4uDawwcAteNDUjoLM6wI27oaN0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-ph6J_GohP7-n9RXpnimqVQ-1; Thu,
 16 Jul 2026 15:33:27 -0400
X-MC-Unique: ph6J_GohP7-n9RXpnimqVQ-1
X-Mimecast-MFC-AGG-ID: ph6J_GohP7-n9RXpnimqVQ_1784230405
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94C1A1955EAC; Thu, 16 Jul 2026 19:33:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.163])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7F1842D; Thu, 16 Jul 2026 19:33:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH] hw/usb/dev-uas: Fix guest-triggerable heap OOB access
Date: Thu, 16 Jul 2026 21:33:21 +0200
Message-ID: <20260716193321.256391-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The stream ID is under control of the guest, so we must not use
it for indexing into the status3[] array without checking it for
being in range.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3612
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3986
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/usb/dev-uas.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 8576dfec96f..7df58cdeee7 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -383,8 +383,15 @@ static void usb_uas_send_status_bh(void *opaque)
 
 static void usb_uas_queue_status(UASDevice *uas, UASStatus *st, int length)
 {
-    USBPacket *p = uas_using_streams(uas) ?
-        uas->status3[st->stream] : uas->status2;
+    USBPacket *p = NULL;
+
+    if (!uas_using_streams(uas)) {
+        p = uas->status2;
+    } else if (st->stream <= UAS_MAX_STREAMS) {
+        p = uas->status3[st->stream];
+    } else {
+        warn_report_once(TYPE_USB_UAS ": bad stream ID 0x%x", st->stream);
+    }
 
     st->length += length;
     QTAILQ_INSERT_TAIL(&uas->results, st, next);
-- 
2.55.0


