Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F0C54FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 23:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpDYv-0003YZ-VZ; Wed, 29 Jul 2026 19:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYt-0003SC-Fl
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wpDYq-0008HA-QP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 19:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785367180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFLIOP7KXUhsLxNU8aKzx2Ksu61X7QeSpeVNl9P28zE=;
 b=dH9RKMg73CwtW6m/kEuiV71Tb7sjFK3bXp1IGW8rdhSP4j/r2d0KrW+YPtK0Gh2uxDAMrl
 BCkMDxUnCyzrhGROFGi/tb6aptGRQl7nPMJCW4FhEj5LKAZZdEGkohCzcgJhvB8NrETWv8
 OOil7aroBacBCu+kQTGIgeeXv4FeynY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-BginPbpdPgeQWO12pPCFoA-1; Wed,
 29 Jul 2026 19:19:36 -0400
X-MC-Unique: BginPbpdPgeQWO12pPCFoA-1
X-Mimecast-MFC-AGG-ID: BginPbpdPgeQWO12pPCFoA_1785367175
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47CA2195608F; Wed, 29 Jul 2026 23:19:35 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55CEC300019F; Wed, 29 Jul 2026 23:19:32 +0000 (UTC)
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
Subject: [PATCH v3 7/7] hw/scsi/spapr_vscsi: do not crash QEMU on migration
 errors
Date: Thu, 30 Jul 2026 01:19:04 +0200
Message-ID: <20260729231904.775331-8-lvivier@redhat.com>
In-Reply-To: <20260729231904.775331-1-lvivier@redhat.com>
References: <20260729231904.775331-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Currently vscsi asserts on invalid SCSI requests.

Fail migration gracefully instead.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2: New patch to manage vscsi

 hw/scsi/spapr_vscsi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 7768ec0bdd49..b6a0411e9c44 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -650,9 +650,17 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq, Error **errp)
     int rc;
     Error *local_err = NULL;
 
-    assert(sreq->tag < VSCSI_REQ_LIMIT);
+    if (sreq->tag >= VSCSI_REQ_LIMIT) {
+        error_setg(errp, "VSCSI: request tag#%u out of range (max %d)",
+                   sreq->tag, VSCSI_REQ_LIMIT);
+        return NULL;
+    }
+
     req = &s->reqs[sreq->tag];
-    assert(!req->active);
+    if (req->active) {
+        error_setg(errp, "VSCSI: request tag#%u already active", sreq->tag);
+        return NULL;
+    }
 
     memset(req, 0, sizeof(*req));
     rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
@@ -662,7 +670,11 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq, Error **errp)
                                 sreq->tag);
         return NULL;
     }
-    assert(req->active);
+    if (!req->active) {
+        error_setg(errp, "VSCSI: request tag#%u not active after load",
+                   sreq->tag);
+        return NULL;
+    }
 
     req->sreq = scsi_req_ref(sreq);
 
-- 
2.54.0


