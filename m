Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09910C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMyX-0003xG-SR; Mon, 29 Jul 2024 05:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyW-0003rl-He
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sYMyV-0004bb-1q
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722246446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fWS/MeBs6Kai+qgd4zCs2xGsxcdZvo3lCYuqY77YaM=;
 b=TR0zzB8Q7uR8WIStC/WrbqbGupk05mauw9GzwDuId2zA4VLWsPUc+5kVqPmISE2FCFtWla
 N11Kjja7fOjBbKsU5xB5xAVv5POiK6dwaVRgFuz7u7N5YW2tBoFd7ls2GmFMxLEKsvcf8Z
 5ahd3a+bqXu5nNE9viq7ZFuq/j9BVMo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-XY3OFOG7MSumPoj9h0OItg-1; Mon,
 29 Jul 2024 05:47:18 -0400
X-MC-Unique: XY3OFOG7MSumPoj9h0OItg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AC801955D4B; Mon, 29 Jul 2024 09:47:17 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.89])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4949E1955F40; Mon, 29 Jul 2024 09:47:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 3/4] scsi-disk: Add warning comments that host_status errors
 take a shortcut
Date: Mon, 29 Jul 2024 11:47:00 +0200
Message-ID: <20240729094702.50282-4-kwolf@redhat.com>
In-Reply-To: <20240729094702.50282-1-kwolf@redhat.com>
References: <20240729094702.50282-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

scsi_block_sgio_complete() has surprising behaviour in that there are
error cases in which it directly completes the request and never calls
the passed callback. In the current state of the code, this doesn't seem
to result in bugs, but with future code changes, we must be careful to
never rely on the callback doing some cleanup until this code smell is
fixed. For now, just add warnings to make people aware of the trap.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6e1a5c98df..69a195177e 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -68,6 +68,9 @@ struct SCSIDiskClass {
     /*
      * Callbacks receive ret == 0 for success. Errors are represented either as
      * negative errno values, or as positive SAM status codes.
+     *
+     * Beware: For errors returned in host_status, the function may directly
+     * complete the request and never call the callback.
      */
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
@@ -381,6 +384,7 @@ done:
     scsi_req_unref(&r->req);
 }
 
+/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_dma_complete(void *opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -421,6 +425,7 @@ done:
     scsi_req_unref(&r->req);
 }
 
+/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_read_complete(void *opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -560,6 +565,7 @@ done:
     scsi_req_unref(&r->req);
 }
 
+/* May not be called in all error cases, don't rely on cleanup here */
 static void scsi_write_complete(void * opaque, int ret)
 {
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
@@ -2821,6 +2827,7 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
     sg_io_hdr_t *io_hdr = &req->io_header;
 
     if (ret == 0) {
+        /* FIXME This skips calling req->cb() and any cleanup in it */
         if (io_hdr->host_status != SCSI_HOST_OK) {
             scsi_req_complete_failed(&r->req, io_hdr->host_status);
             scsi_req_unref(&r->req);
-- 
2.45.2


