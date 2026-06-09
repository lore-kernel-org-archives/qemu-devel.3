Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA6ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWu8S-0000eV-CZ; Tue, 09 Jun 2026 06:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWu8N-0000dv-VC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wWu8L-0004K6-N0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 06:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781002595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wXABRRAevTm0wVVRrTSdgk6YyvsOYcfIeVKGsaY9ubo=;
 b=QjPms70LU9E41nF/o7NRpDPw5cnHzm23z8b/uXreg1i+gl62RBtFxBcZlIrKUhIncnuibz
 ZoPq5LBWE2z9tLe5UA2u2qEb7KasEEJO9FBVs4YOzJDi0nbqzxzVOePiialadUZiqKyJAV
 SfLJXUlS5CO3qYv7xKHAgwQZd4YYB3Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-t_f4R2NHPsmH_CWuxt788Q-1; Tue,
 09 Jun 2026 06:56:31 -0400
X-MC-Unique: t_f4R2NHPsmH_CWuxt788Q-1
X-Mimecast-MFC-AGG-ID: t_f4R2NHPsmH_CWuxt788Q_1781002590
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95E4518009D4; Tue,  9 Jun 2026 10:56:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet01.pony-001.prod.rdu2.dc.redhat.com [10.11.142.86])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C890B3008B38; Tue,  9 Jun 2026 10:56:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Titus Rwantare <titusr@google.com>
Cc: qemu-trivial@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH] hw/i2c/pmbus_device: Fix a possible crash when requesting too
 many bytes
Date: Tue,  9 Jun 2026 12:56:26 +0200
Message-ID: <20260609105626.1038690-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The pmbus_send_string() function contains an assert() statement that
can be triggered by the guest code when requesting too many data
without reading from the device in between. This should not be possible.
pmbus_send() already has a similar logic, but it simply ignores the
error after logging a message with qemu_log_mask(), so do the same now
in pmbus_send_string() to fix the issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3388
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i2c/pmbus_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index b1f9843f52e..6aa608a2998 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -104,7 +104,12 @@ void pmbus_send_string(PMBusDevice *pmdev, const char *data)
     }
 
     size_t len = strlen(data);
-    g_assert(len + pmdev->out_buf_len < SMBUS_DATA_MAX_LEN);
+    if (len + pmdev->out_buf_len >= SMBUS_DATA_MAX_LEN) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: requested too much data from PMBus device\n",
+                      __func__);
+        return;
+    }
     pmdev->out_buf[len + pmdev->out_buf_len] = len;
 
     for (int i = len - 1; i >= 0; i--) {
-- 
2.54.0


