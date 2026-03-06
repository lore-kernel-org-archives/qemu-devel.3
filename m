Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF66FCB625
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYUx-0004hq-6w; Fri, 06 Mar 2026 11:57:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyYUv-0004hZ-8S
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:57:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyYUr-0006kL-FE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772816272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2bToJGrR728ljxaaDhnpYVbNbwzFUcS0wZqN1H6Yss=;
 b=aYttQ/ugvJDGifIP3are413+1A69zqPzpVI8/TbXw+jbWpBH7QXS9FH6hdEtbWLA/pTSJo
 wihW6dRDXg13HCIpRLU9FdzFpu8XjSbjgaXHyzaKmO6jKhQI9QaUVcBe2+l7tHl4o84ctb
 4DCOysUwL8ocshJXUJjMiWjJAq8pYVo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-3KRj2l_xOfmDk-6UktsDPA-1; Fri,
 06 Mar 2026 11:57:47 -0500
X-MC-Unique: 3KRj2l_xOfmDk-6UktsDPA-1
X-Mimecast-MFC-AGG-ID: 3KRj2l_xOfmDk-6UktsDPA_1772816266
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC1AF1956089; Fri,  6 Mar 2026 16:57:45 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.225.197])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5288180075D; Fri,  6 Mar 2026 16:57:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Avi Kivity <avi@scylladb.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/4] hw/nvme: add user controlled 'firmware-version' property
Date: Fri,  6 Mar 2026 16:57:17 +0000
Message-ID: <20260306165717.3360110-5-berrange@redhat.com>
In-Reply-To: <20260306165717.3360110-1-berrange@redhat.com>
References: <20260306165717.3360110-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This enables overriding the built in default QEMU project version string
with a user specified string. The value can be at most 8 characters
in length.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/devices/nvme.rst |  5 +++++
 hw/nvme/ctrl.c               | 14 ++++++++++++--
 hw/nvme/nvme.h               |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 109c01a70d..98a4401043 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -65,6 +65,11 @@ parameters.
   to more closely impersonate a particular device type. The model name
   can be a maximum of 40 characters in length.
 
+``firmware-version`` (default: current QEMU version number)
+  Override the default reported firmware version, which can be used when
+  needing to more closely impersonate a particular device type. The version
+  can be a maximum of 8 characters in length.
+
 Additional Namespaces
 ---------------------
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4067443309..b392e053ab 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -44,7 +44,8 @@
  *              atomic.awun<N[optional]>, \
  *              atomic.awupf<N[optional]>, \
  *              subsys=<subsys_id>, \
- *              model=<model-str>
+ *              model=<model-str>, \
+ *              firmware-version=<version-str>
  *      -device nvme-ns,drive=<drive_id>,bus=<bus_name>,nsid=<nsid>,\
  *              zoned=<true|false[optional]>, \
  *              subsys=<subsys_id>,shared=<true|false[optional]>, \
@@ -8614,6 +8615,13 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         return false;
     }
 
+    if (params->firmware_version &&
+        strlen(params->firmware_version) > NVME_ID_CTRL_FR_MAX_LEN) {
+        error_setg(errp, "'firmware-version' parameter '%s' can be at most '%d' characters",
+                   params->firmware_version, NVME_ID_CTRL_FR_MAX_LEN);
+        return false;
+    }
+
     if (params->mqes < 1) {
         error_setg(errp, "mqes property cannot be less than 1");
         return false;
@@ -9109,7 +9117,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
     strpadcpy((char *)id->mn, sizeof(id->mn),
               n->params.model ? n->params.model : "QEMU NVMe Ctrl", ' ');
-    strpadcpy((char *)id->fr, sizeof(id->fr), QEMU_VERSION, ' ');
+    strpadcpy((char *)id->fr, sizeof(id->fr),
+              n->params.firmware_version ? n->params.firmware_version : QEMU_VERSION, ' ');
     strpadcpy((char *)id->sn, sizeof(id->sn), n->params.serial, ' ');
 
     id->cntlid = cpu_to_le16(n->cntlid);
@@ -9389,6 +9398,7 @@ static const Property nvme_props[] = {
                      NvmeSubsystem *),
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
     DEFINE_PROP_STRING("model", NvmeCtrl, params.model),
+    DEFINE_PROP_STRING("firmware-version", NvmeCtrl, params.firmware_version),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
     DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index ebf1fcfdcd..5ef3ebee29 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -543,6 +543,7 @@ typedef struct NvmeCQueue {
 typedef struct NvmeParams {
     char     *serial;
     char     *model;
+    char     *firmware_version;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
-- 
2.53.0


