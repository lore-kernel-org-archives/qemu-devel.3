Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36463C54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDYp-0003A1-Q7; Wed, 29 Jul 2026 19:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYo-000375-M9
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYm-0008FI-09
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785367175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fpn1QAset08EX22OWWgA+5utTHpUdP9lkZAeuaAvzbk=;
 b=A5ybB+gtXx44y57AIkc3SL/4xp9NR/YUaJlxsTIgsjy/upgL8MIhbxyF148Lmrx5vMuXcU
 kHBlBd++c+yhQDDoQnaME8K3RbDCfN9dW3+XU/SiKFkkPSPH/c9XVZE43R+yXQsZU0kzPO
 cejUXcHg/VpzfqB5Tjkg5SofUfQ8YA0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-CyRn6ecHMT6yxdz1WDdzKg-1; Wed,
 29 Jul 2026 19:19:29 -0400
X-MC-Unique: CyRn6ecHMT6yxdz1WDdzKg-1
X-Mimecast-MFC-AGG-ID: CyRn6ecHMT6yxdz1WDdzKg_1785367168
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8449018004BB; Wed, 29 Jul 2026 23:19:28 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27B9230001A4; Wed, 29 Jul 2026 23:19:24 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 5/7] mptsas: do not crash QEMU on migration errors
Date: Thu, 30 Jul 2026 01:19:02 +0200
Message-ID: <20260729231904.775331-6-lvivier@redhat.com>
In-Reply-To: <20260729231904.775331-1-lvivier@redhat.com>
References: <20260729231904.775331-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

From: "Michael S. Tsirkin" <mst@redhat.com>

Currently mptsas asserts on invalid sg list count in the migration
stream.

Fail migration gracefully instead.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[lvivier: use errp rather than qemu_file_set_error() to report error]
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: new patch from Michael S. Tsirkin
        https://lore.kernel.org/qemu-devel/258d84f5af807e0103bf6f59165dd7450918e58c.1784898250.git.mst@redhat.com/
        Modified to use errp parameter with error_setg() instead of
        qemu_file_set_error() to report error

 hw/scsi/mptsas.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 45638af0afc3..34ceb6b5d25e 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -36,6 +36,8 @@
 #include "qapi/error.h"
 #include "mptsas.h"
 #include "migration/qemu-file-types.h"
+#include "migration/qemu-file.h"
+#include "qemu/error-report.h"
 #include "migration/vmstate.h"
 #include "mpi.h"
 
@@ -1242,12 +1244,12 @@ static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq, Error **errp)
     qemu_get_buffer(f, (unsigned char *)&req->scsi_io, sizeof(req->scsi_io));
 
     n = qemu_get_be32(f);
-    /* TODO: add a way for SCSIBusInfo's load_request to fail,
-     * and fail migration instead of asserting here.
-     * This is just one thing (there are probably more) that must be
-     * fixed before we can allow NDEBUG compilation.
-     */
-    assert(n >= 0);
+    if (n < 0) {
+        error_setg(errp, "mptsas: invalid sg list count %d in migration stream",
+                   n);
+        g_free(req);
+        return NULL;
+    }
 
     pci_dma_sglist_init(&req->qsg, pci, n);
     for (i = 0; i < n; i++) {
-- 
2.54.0


