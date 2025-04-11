Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35748C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Cce-000180-Uq; Fri, 11 Apr 2025 07:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1u3CcG-00012c-DX
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1u3CcC-00078t-Pk
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZuL+PB2VHYWwf7g3pdTN3XdwO2EbAIMB/pFWGzrc1I=;
 b=TxgGo4Zs0bwcMBCdK+QNcCI2mDQEAK10LXb8GcJmpsLU/NCkhBPs9eJTYCuLBLCxQxj5W1
 eJ4pA+fRTVxszYLfk7B4rPzhLnl1m6FurEMdm7hdRnZqS3eWsNV08ytutfKiYo7Egv2lMi
 nJ6KZZ3DnR8dAPQ6/MlFKfSYT65Yzss=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-5KVBgsPiMMyMj-vwuTAndw-1; Fri,
 11 Apr 2025 07:30:55 -0400
X-MC-Unique: 5KVBgsPiMMyMj-vwuTAndw-1
X-Mimecast-MFC-AGG-ID: 5KVBgsPiMMyMj-vwuTAndw_1744371053
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA0C51955BC5; Fri, 11 Apr 2025 11:30:53 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.225.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67892180175B; Fri, 11 Apr 2025 11:30:48 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alberto Faria <afaria@redhat.com>
Subject: [PATCH v2 2/2] scsi-disk: Advertise FUA support by default
Date: Fri, 11 Apr 2025 12:30:36 +0100
Message-ID: <20250411113036.786841-3-afaria@redhat.com>
In-Reply-To: <20250411113036.786841-1-afaria@redhat.com>
References: <20250411113036.786841-1-afaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Allow the guest to submit FUA requests directly, instead of forcing it
to emulate them using a regular flush.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 hw/core/machine.c   | 1 +
 hw/scsi/scsi-disk.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63c6ef93d2..e4e6474a4e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -46,6 +46,7 @@ GlobalProperty hw_compat_9_2[] = {
     { "migration", "multifd-clean-tls-termination", "false" },
     { "migration", "send-switchover-start", "off"},
     { "vfio-pci", "x-migration-multifd-transfer", "off" },
+    { "scsi-disk", "dpofua", "off" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index f62dcded64..2f62f6069d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -3192,7 +3192,7 @@ static const Property scsi_hd_properties[] = {
     DEFINE_PROP_BIT("removable", SCSIDiskState, features,
                     SCSI_DISK_F_REMOVABLE, false),
     DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
-                    SCSI_DISK_F_DPOFUA, false),
+                    SCSI_DISK_F_DPOFUA, true),
     DEFINE_PROP_UINT64("wwn", SCSIDiskState, qdev.wwn, 0),
     DEFINE_PROP_UINT64("port_wwn", SCSIDiskState, qdev.port_wwn, 0),
     DEFINE_PROP_UINT16("port_index", SCSIDiskState, port_index, 0),
-- 
2.49.0


