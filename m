Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A020AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVQI-0004jI-Dk; Tue, 30 Jun 2026 06:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1weVQH-0004j8-Al
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1weVQF-0007O9-HM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782814230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OYtdoeGu28sJcv7mdKVuAn83px+QYHBnHohVAvgR3es=;
 b=hKfu5j1717FIIeTRTJqnCJ5513SuWTguTkwcDHtybCQ27iHW42UZbtBYYC6lFX+nmXzafK
 T5J2R2dCgOJ1bw4YGTzmpXbl7SqoFon093SsPTjdPh+9eYtvbna5ZOVT5aTH0Nna9xlm6a
 Fc7yAN+wJZUTGIqSlHxt/70S+1nbaDc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-vMtdONO4MK2VGoy-aOMn3w-1; Tue,
 30 Jun 2026 06:10:28 -0400
X-MC-Unique: vMtdONO4MK2VGoy-aOMn3w-1
X-Mimecast-MFC-AGG-ID: vMtdONO4MK2VGoy-aOMn3w_1782814228
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7ADC71801F36; Tue, 30 Jun 2026 10:10:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.50.133])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 959E319560B2; Tue, 30 Jun 2026 10:10:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-trivial@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH] hw/display/qxl: Fix mono cursor validation that can read past
 a cursor chunk
Date: Tue, 30 Jun 2026 12:10:22 +0200
Message-ID: <20260630101022.379057-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

qxl_render_cursor() maps the guest-provided QXLCursor object using the
guest-controlled cursor->chunk.data_size.
For a mono cursor, qxl_cursor() then validates the expected bitmap size
against cursor->data_size, but it does not validate that the first chunk
actually contains that many bytes.
A guest could set cursor->data_size to the correct full mono cursor size
while setting cursor->chunk.data_size to zero. In that case, cursor_set_mono()
reads the AND/XOR masks starting at cursor->chunk.data. If the cursor object
is placed at the end of the QXL RAM BAR, those reads cross the mapped RAM
region and could crash the QEMU process (e.g. under ASan).

Fix it by double-checking cursor->chunk.data_size for the correct size.

This patch is based on the suggested changes by the reporter in the bug
ticket.

Reported-by: huntr bubble
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3646
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/qxl-render.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 7b692d5a854..3bf634ee059 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -272,9 +272,11 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
     case SPICE_CURSOR_TYPE_MONO:
         /* Assume that the full cursor is available in a single chunk. */
         size = 2 * cursor_get_mono_bpl(c) * c->height;
-        if (size != cursor->data_size) {
-            fprintf(stderr, "%s: bad monochrome cursor %ux%u with size %u\n",
-                    __func__, c->width, c->height, cursor->data_size);
+        if (size != cursor->data_size || cursor->chunk.data_size < size) {
+            qxl_set_guest_bug(qxl, "%s: bad monochrome cursor %ux%u"
+                              " data_size %u chunk_size %u",
+                              __func__, c->width, c->height,
+                              cursor->data_size, cursor->chunk.data_size);
             goto fail;
         }
         and_mask = cursor->chunk.data;
-- 
2.54.0


