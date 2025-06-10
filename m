Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF45C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyGA-00030h-Mv; Tue, 10 Jun 2025 08:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyFb-0001gG-Ep
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyFU-0000Vs-EQ
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749559111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dkga8yAxiWPTDYq3QtvpHFdSuxxC+fBow6wIf0iWCMg=;
 b=h5Dl9WcAbkdZgoIWmXjxbKJPzboE/tXt+nwvXva+NMzf8tDhuUDunvJ/tTfUz62bjOco0x
 IHJztXsM3UFVRIYsWDB8/fJkMgWmdEgLqtBnjBZ9rS3kcEKwE2fvaRw5lIzci99QRAM8cr
 ABHl1zVwinWsQyxrpSkI7QOO3ubHE+A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-CM_Ref_OPC6CQIIjVjX5cw-1; Tue,
 10 Jun 2025 08:38:28 -0400
X-MC-Unique: CM_Ref_OPC6CQIIjVjX5cw-1
X-Mimecast-MFC-AGG-ID: CM_Ref_OPC6CQIIjVjX5cw_1749559107
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 500821800292; Tue, 10 Jun 2025 12:38:27 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2001030001B1; Tue, 10 Jun 2025 12:38:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 28/31] hw/scsi/megasas: skip automatic zero-init of large
 arrays
Date: Tue, 10 Jun 2025 13:37:06 +0100
Message-ID: <20250610123709.835102-29-berrange@redhat.com>
In-Reply-To: <20250610123709.835102-1-berrange@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The 'megasas_dcmd_pd_get_list' and 'megasas_dcmd_get_properties'
methods have 4k structs used for copying data from the device.
Skip the automatic zero-init of this array to eliminate the
performance overhead in the I/O hot path.

The 'info' structs are manually initialized with memset(). The
compiler ought to be intelligent enough to turn the memset()
into a static initialization operation, and thus not duplicate
the automatic zero-init. Replacing memset() with '{}' makes it
unambiguous that the arrays are statically initialized.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/scsi/megasas.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 55cd188bd5..844643d916 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -981,13 +981,11 @@ static int megasas_event_wait(MegasasState *s, MegasasCmd *cmd)
 
 static int megasas_dcmd_pd_get_list(MegasasState *s, MegasasCmd *cmd)
 {
-    struct mfi_pd_list info;
-    size_t dcmd_size = sizeof(info);
+    struct mfi_pd_list info = {};
     BusChild *kid;
     uint32_t offset, dcmd_limit, num_pd_disks = 0, max_pd_disks;
     dma_addr_t residual;
 
-    memset(&info, 0, dcmd_size);
     offset = 8;
     dcmd_limit = offset + sizeof(struct mfi_pd_address);
     if (cmd->iov_size < dcmd_limit) {
@@ -1429,11 +1427,10 @@ static int megasas_dcmd_cfg_read(MegasasState *s, MegasasCmd *cmd)
 
 static int megasas_dcmd_get_properties(MegasasState *s, MegasasCmd *cmd)
 {
-    struct mfi_ctrl_props info;
+    struct mfi_ctrl_props info = {};
     size_t dcmd_size = sizeof(info);
     dma_addr_t residual;
 
-    memset(&info, 0x0, dcmd_size);
     if (cmd->iov_size < dcmd_size) {
         trace_megasas_dcmd_invalid_xfer_len(cmd->index, cmd->iov_size,
                                             dcmd_size);
-- 
2.49.0


