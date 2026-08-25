Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08888C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqy-0005na-Hg; Tue, 25 Aug 2026 17:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqw-0005lu-Pu; Tue, 25 Aug 2026 17:38:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqu-00051F-TD; Tue, 25 Aug 2026 17:38:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 42A5A80BF4;
 Wed, 26 Aug 2026 00:38:39 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-eBmCp7Dr; Wed, 26 Aug 2026 00:38:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693918;
 bh=YrgMToP0NRwk8bp8EDG1ZziGYNNhT9TPc5zyFCqWwD0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Vkp25B/AJo1qsMOBsxh8HviI8XL5H7is+gIXR8n9p1YmMD0ycPaHPVdVtm2f2X5cF
 iPEdyJ34CXBFtqjlB1WFdxGSW47m1Z9YSA8JBXo460AUMecIDJOU2bitI/CrUVqoZF
 hM6F05z2A83akZ09U6Hu3CHLqkIj4ZF1yJIH1IoQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH 08/30] hw/scsi/spapr_vscsi: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:48 +0300
Message-ID: <20260825213811.3725682-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/scsi/spapr_vscsi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22a..5938a392b95 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -629,12 +629,11 @@ static void vscsi_save_request(QEMUFile *f, SCSIRequest *sreq)
 {
     vscsi_req *req = sreq->hba_private;
     Error *local_err = NULL;
-    int rc;
 
     assert(req->active);
 
-    rc = vmstate_save_state(f, &vmstate_spapr_vscsi_req, req, NULL, &local_err);
-    if (rc < 0) {
+    if (!vmstate_save_vmsd(f, &vmstate_spapr_vscsi_req, req, NULL,
+                           &local_err)) {
         error_report_err(local_err);
         return;
     }
@@ -647,7 +646,6 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     SCSIBus *bus = sreq->bus;
     VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(bus->qbus.parent);
     vscsi_req *req;
-    int rc;
     Error *local_err = NULL;
 
     assert(sreq->tag < VSCSI_REQ_LIMIT);
@@ -655,8 +653,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     assert(!req->active);
 
     memset(req, 0, sizeof(*req));
-    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
-    if (rc) {
+    if (!vmstate_load_vmsd(f, &vmstate_spapr_vscsi_req, req, 1, &local_err)) {
         fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
         error_report_err(local_err);
         return NULL;
-- 
2.43.0


