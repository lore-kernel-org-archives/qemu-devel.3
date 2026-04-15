Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2204DF433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9fe-00013R-M1; Wed, 15 Apr 2026 19:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wD9fc-00012p-RY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:29:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wD9fa-00010Z-FL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776295757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ykdNZSAaW0/nvkmQYjbcWRVUA1nOc186/+rW2QcWnQ=;
 b=iiMWxF4i5/YwNmWNxzHRNTd217Io9KLXRraAMWAy3gdHWcH/z4OWOoniGmJkp69FmdTsbp
 YfvAfS/ZmAqcd7fl19IapgTm2EYhXx2IslE4Cu2YQ9i7+rhRwPT0bt/HueMf+XvDOs9CcC
 0k7wS2fGeLmEs39cUXSirGYFZ1qiY5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-wdUZKjSDPhmsB7Q4wpw8MA-1; Wed,
 15 Apr 2026 19:29:16 -0400
X-MC-Unique: wdUZKjSDPhmsB7Q4wpw8MA-1
X-Mimecast-MFC-AGG-ID: wdUZKjSDPhmsB7Q4wpw8MA_1776295755
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 546931956095; Wed, 15 Apr 2026 23:29:15 +0000 (UTC)
Received: from localhost (unknown [10.44.34.70])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F147430001A4; Wed, 15 Apr 2026 23:29:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/2] scsi: change buf_size to unsigned int in scsi_SG_IO()
Date: Wed, 15 Apr 2026 19:29:05 -0400
Message-ID: <20260415232906.212349-2-stefanha@redhat.com>
In-Reply-To: <20260415232906.212349-1-stefanha@redhat.com>
References: <20260415232906.212349-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

SG_IO supports an unsigned int dxfer_len value. Existing callers use
less than 256 bytes, so scsi_SG_IO()'s uint8_t buf_size type was
sufficient. The next patch will use a larger value, so update the type.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h | 3 ++-
 hw/scsi/scsi-generic.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index a3e246dbd9..5f83e58d1d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -247,7 +247,8 @@ void scsi_device_unit_attention_reported(SCSIDevice *dev);
 void scsi_generic_read_device_inquiry(SCSIDevice *dev);
 int scsi_device_get_sense(SCSIDevice *dev, uint8_t *buf, int len, bool fixed);
 int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd, uint8_t cmd_size,
-               uint8_t *buf, uint8_t buf_size, uint32_t timeout, Error **errp);
+               uint8_t *buf, unsigned int buf_size, uint32_t timeout,
+               Error **errp);
 SCSIDevice *scsi_device_find(SCSIBus *bus, int channel, int target, int lun);
 SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
 
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 5182f9236d..29bc952af5 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -794,7 +794,7 @@ static int read_naa_id(const uint8_t *p, uint64_t *p_wwn)
 }
 
 int scsi_SG_IO(BlockBackend *blk, int direction, uint8_t *cmd,
-               uint8_t cmd_size, uint8_t *buf, uint8_t buf_size,
+               uint8_t cmd_size, uint8_t *buf, unsigned int buf_size,
                uint32_t timeout, Error **errp)
 {
     sg_io_hdr_t io_header;
-- 
2.53.0


