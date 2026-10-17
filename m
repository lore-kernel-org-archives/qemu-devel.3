Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27C5CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB0R-0005V8-FM; Sat, 17 Oct 2026 16:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB05-0005Aj-MV; Sat, 17 Oct 2026 16:27:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB02-0003uQ-A0; Sat, 17 Oct 2026 16:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268829; bh=zDfY0jDVIJEScbQkYChOCCOZdJu7kmri3YOwtAgm5yc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FjzQg6ltRY5kNL9vbYPZUxqcvSM3ISNhOzVoKh+fmGVO/UfcNJz38+/XRwaWSq6n7
 i5A16fUQnGo+bXIXy83q8sc4SJvgVRfL1PN69ZRd0rBUC7iFVRXAM4D4+7nHJvVtIb
 sdpWkArla0po25gK3WVQKAVpeWQYnw+T2A0nKlF3YExZAXeO9+YKSa8XhpDjIRWfX5
 V84lZXNqrgdNbk8aP2jYCS247dgMG6svGouaXPJwSFfEWmAqEjii0UpBSClVaFtJuD
 bpd8ThOn0ZLYMf2N7W3n2Eczs85RxM5B0uGQ7JxbSb0JLT4SeR7rVXa39QpjX49A8u
 JcdC8qAbNuGsw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 398641DE742;
 Sat, 17 Oct 2026 23:27:09 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 72A7D443419;
 Sat, 17 Oct 2026 23:27:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 07/73] virtio-ccw: Fix rc check in read configuration
 path
Date: Sat, 17 Oct 2026 23:25:25 +0300
Message-ID: <20261017202638.728621-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Eric Farman <farman@linux.ibm.com>

Both the read and write config paths use wrappers around cds->op_handler,
depending on the direction the I/O is flowing. But they expect opposite
values in the returned variable to indicate success.

Fix this by unifying those checks, where CCW_CMD_READ_CONF needs to
see !ret as success. The end result is some erroneous data in the
SCSW response data, but the overall success/failure is correct.

Cc: qemu-stable@nongnu.org
Fixes: d895d25ae2 ("s390x: css: report errors from ccw_dstream_read/write")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-4-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit bd5bc2861fb6b5ba74137ed263465780894ec432)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index a28fac97a4..c27e49c865 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -475,7 +475,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             virtio_bus_get_vdev_config(&dev->bus, vdev->config);
             ret = ccw_dstream_write_buf(&sch->cds, vdev->config, len);
-            if (ret) {
+            if (!ret) {
                 sch->curr_status.scsw.count = ccw.count - len;
             }
         }
-- 
2.47.3


