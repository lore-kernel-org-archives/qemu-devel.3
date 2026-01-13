Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10692D29DF7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfarE-0003mg-Sc; Tue, 13 Jan 2026 04:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfar4-0003HC-Vy
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfar2-0003Uk-Iy
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ngXbfZKk15+ACRyo+DnfXhdDtH8HlbsllMkfeSzSIU=;
 b=gZL2s6AyDoSgYGe0WuzeZS0/XUtGrzwQ8MrgpIHocIRxx0haY8CNFxNW2K4kLG1AtdIuF0
 dhJ32t27IjTc5NJI+l9Tjlg7jBflS2hdS/oJhOX9mJ8wRuQYzWKAmvxkTfb3H2oGIg9NWw
 eSc5YCBmsGcORIBMYOrqSdDMvvj/pxk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-DFFv6Ls5OOaWCHiQJgIlrQ-1; Tue,
 13 Jan 2026 04:38:22 -0500
X-MC-Unique: DFFv6Ls5OOaWCHiQJgIlrQ-1
X-Mimecast-MFC-AGG-ID: DFFv6Ls5OOaWCHiQJgIlrQ_1768297101
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43B0C195609D; Tue, 13 Jan 2026 09:38:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C073C30001A2; Tue, 13 Jan 2026 09:38:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Farhan Ali <alifm@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/41] util/vfio-helper: Fix endianness in PCI config
 read/write functions
Date: Tue, 13 Jan 2026 10:36:31 +0100
Message-ID: <20260113093637.1549214-36-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Farhan Ali <alifm@linux.ibm.com>

The VFIO pread/pwrite functions use little-endian data format. Currently, the
qemu_vfio_pci_read_config() and qemu_vfio_pci_write_config() don't correctly
convert from CPU native endian format to little-endian (and vice versa) when
using the pread/pwrite functions. Fix this by limiting read/write to 32 bits
and handling endian conversion in qemu_vfio_pci_read_config() and
qemu_vfio_pci_write_config().

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260105222029.2423-1-alifm@linux.ibm.com
[ clg: Fixed typo in subject ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 util/vfio-helpers.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index c6195161637a16b4f26dc82f0297e43281a717f7..aab0bf9d485d41b7dc41a1e46449060777cca5e2 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -233,31 +233,36 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
     return 0;
 }
 
-static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
+static int qemu_vfio_pci_read_config(QEMUVFIOState *s, uint32_t *buf,
                                      int size, int ofs)
 {
     int ret;
+    uint32_t val_le;
 
     trace_qemu_vfio_pci_read_config(buf, ofs, size,
                                     s->config_region_info.offset,
                                     s->config_region_info.size);
     assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
     ret = RETRY_ON_EINTR(
-        pread(s->device, buf, size, s->config_region_info.offset + ofs)
+        pread(s->device, &val_le, size, s->config_region_info.offset + ofs)
     );
+
+    *buf = le32_to_cpu(val_le);
     return ret == size ? 0 : -errno;
 }
 
-static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int ofs)
+static int qemu_vfio_pci_write_config(QEMUVFIOState *s, uint32_t *buf, int size, int ofs)
 {
     int ret;
+    uint32_t val_le;
 
+    val_le = cpu_to_le32(*buf);
     trace_qemu_vfio_pci_write_config(buf, ofs, size,
                                      s->config_region_info.offset,
                                      s->config_region_info.size);
     assert(QEMU_IS_ALIGNED(s->config_region_info.offset + ofs, size));
     ret = RETRY_ON_EINTR(
-        pwrite(s->device, buf, size, s->config_region_info.offset + ofs)
+        pwrite(s->device, &val_le, size, s->config_region_info.offset + ofs)
     );
     return ret == size ? 0 : -errno;
 }
@@ -296,7 +301,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
 {
     int ret;
     int i;
-    uint16_t pci_cmd;
+    uint32_t pci_cmd;
     struct vfio_group_status group_status = { .argsz = sizeof(group_status) };
     struct vfio_iommu_type1_info *iommu_info = NULL;
     size_t iommu_info_size = sizeof(*iommu_info);
-- 
2.52.0


