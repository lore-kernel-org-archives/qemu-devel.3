Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6710BCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNt0-0003ZR-Nh; Wed, 24 Jun 2026 09:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1wcNsm-0002wU-Ly
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1wcNsl-00023t-28
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782308590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hAQtRG78xVdwI/khtxM4j0/JOngu/ncCTJAHTND3+AE=;
 b=PAFsxVhkB7kM0NJi6B5veRP208ZgHyJ+2PbGKs03bwhHtd6aWBKcXHf3jpX84ETP1JS/0D
 JTsUe6Z0hIIiwqcu0vp0UlxpE2b7xooW+q5OKXzaMu02GpQtekC7ydxQ+O2BJsDOfrBljq
 admVT4NFI0jHToxk3yAZk0CRcINVN3U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-kSfTHU5NP0KHHAdt_xhyTQ-1; Wed, 24 Jun 2026 09:43:07 -0400
X-MC-Unique: kSfTHU5NP0KHHAdt_xhyTQ-1
X-Mimecast-MFC-AGG-ID: kSfTHU5NP0KHHAdt_xhyTQ_1782308586
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37de6edd915so734625a91.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782308586; x=1782913386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hAQtRG78xVdwI/khtxM4j0/JOngu/ncCTJAHTND3+AE=;
 b=Sw2u337sVM8yuB5H8kTx83XOqTjW8JaX92qbe2hWgSWXEhG7+zKBo6o86WwSnjJBAg
 sKumHTdbPLFdA2oSkJvMD+u+AkiUBwTrLGGyIZK8nshD0eTl+dsxkDOwcRYdGYotomYe
 cTMxlLyvo5k2EkDXOSXo2g2tcsGMNm7+PL6hesFbmbU5mpZ9B3c5MRxpzYlUiudyTHSD
 Ok7YHcH2kYRIDNEVvi7WR6fkJUGIhPOcJZD/JTOSEfEeSxxiD3eZnEw+bxeerLdpTWJ4
 KXesLTJmMeWDVP1FQZk9bvT68He60PM0PWE5cqCqrputXzCQFALdHkLGvV2ABxXv67uh
 84cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782308586; x=1782913386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAQtRG78xVdwI/khtxM4j0/JOngu/ncCTJAHTND3+AE=;
 b=TmPZt5DM74MJdsEmiMhiHt2D8EutcSnRBsBb/uynYdMQwntHmxBjuFP/irKN9ydDc/
 1kwQzRf7dX6is9Zf+jV7JhRo1tXX1u7UpQTEwRs1rxDZnKyB82PqOHWFKA0aYmKtsCas
 U/YI1TGwQAtMBi4UY5KGmqdCzY2twUgsxp1msy7s+Dc41dz3YYDuRFKlvR4bzM40xPcc
 fq3yKDD28fxZNRhM/zzMPM4Vypuorx60CBuafykEW1VaN3mjfkYSc4Kl9mpN/Msne/P0
 yCI/vshzP+V3qhPJBVhI/0neSmD9xbuG4bK6GV3ljqpup6tRUaQ/dawqWeWQfVhNonTj
 5XRQ==
X-Gm-Message-State: AOJu0YxrnWhFvIlRGih41qwKxgXPWNIqlDyq/vHmp4P6d7Qp+4CrgRmB
 egZFKhyRZV1jefWSN2mqnKpcyHgisjjgLZKLbTyS+v0688KEuvwfiQ/+u0JPSXyZTTpMic6TW5c
 Lu43qG7xDrHdvCU72bAX5H5tuqeFKfkeILv4al3rbnlcUJMvqD2zC9igjCWlvOkgB1BDDwVxO0y
 brDf29Wl7E86xMmAHrB40RCJCzZQEUvcEcEC0/9g==
X-Gm-Gg: AfdE7ckbpeoQtFVLb6BJoq7RmLntDyT3RMadXuR+5TRywDFZNw3ebjhBwBOdXMl9myz
 yp9rDwtR7y2PpIub1Pb7BhtDcwLy1l0icW+8BLplKKHlQzKRiXNjz3ff5UOOOY8wSCCUcELHeXm
 Dj804CUepnSDGXSIT2PPicuchbHPQmVZ/qtVlGmVoaX9KuuwEqspZzK4q3rdhcHCliSoSI/g8+/
 7e3JccY4JhU1JXbq6VUU9mOkaFRwnIpYNFU/VZe+CnI16i8qfX4nKruATrMMULDmbMDajsmtWxS
 7+r7pDaMKYtPNzTHgrQ+jlrZau+TSvmcKtRkkhPnkTxzbxGjfIkpSVyVS7oxRHeELNztTblb1EH
 i6FcOmTwDw0ijPLoMfvG8y3muO8z82pnRn7t/12xvt/OoCS2yescF
X-Received: by 2002:a17:90a:e7d2:b0:362:e826:cefe with SMTP id
 98e67ed59e1d1-37dd0e1f5c0mr9002108a91.23.1782308586116; 
 Wed, 24 Jun 2026 06:43:06 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d2:b0:362:e826:cefe with SMTP id
 98e67ed59e1d1-37dd0e1f5c0mr9002038a91.23.1782308585293; 
 Wed, 24 Jun 2026 06:43:05 -0700 (PDT)
Received: from utsingh-thinkpadx1carbongen12.bengluru.csb
 ([2405:201:d019:c162:22c9:3093:86cf:366d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37de3cc7727sm2419692a91.6.2026.06.24.06.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:43:04 -0700 (PDT)
From: Utkarsh Singh <utsingh@redhat.com>
To: qemu-devel@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it,
 qemu-block@nongnu.org, mlombard@redhat.com, jmeneghi@redhat.com,
 peter.maydell@linaro.org, Utkarsh Singh <utsingh@redhat.com>
Subject: [PATCH v2] hw/nvme: add user controlled 'vendor-id' and 'device-id'
 properties
Date: Wed, 24 Jun 2026 19:12:55 +0530
Message-ID: <20260624134255.558888-1-utsingh@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=utsingh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add user-configurable 'vendor-id' and 'device-id' parameters to
allow overriding the default PCI IDs. This enables testing of
vendor-specific and device-specific quirks in guest operating systems.

Both parameters accept 16-bit hexadecimal values and default to Red Hat
IDs (vendor: 0x1b36, device: 0x0010). They are mutually exclusive with
the 'use-intel-id' flag to prevent conflicting configurations.

Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
Suggested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Utkarsh Singh <utsingh@redhat.com>
---
Changes in v2:
- Renamed 'vid' parameter to 'vendor-id' for consistency with Qemu 
  naming convention
- Added 'device-id' parameter to allow complete PCI ID override
- Link to v1: https://lore.kernel.org/qemu-devel/20260623131946.46879-1-utsingh@redhat.com  


 docs/system/devices/nvme.rst | 16 +++++++++++++++-
 hw/nvme/ctrl.c               | 16 ++++++++++++++--
 hw/nvme/nvme.h               |  2 ++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 98a4401043..79514afcc5 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -51,7 +51,8 @@ parameters.
 ``use-intel-id`` (default: ``off``)
   Since QEMU 5.2, the device uses a QEMU allocated "Red Hat" PCI Device and
   Vendor ID. Set this to ``on`` to revert to the unallocated Intel ID
-  previously used.
+  previously used. This parameter is mutually exclusive with ``vendor-id``
+  and ``device-id``.
 
 ``ocp`` (default: ``off``)
   The Open Compute Project defines the Datacenter NVMe SSD Specification that
@@ -65,6 +66,19 @@ parameters.
   to more closely impersonate a particular device type. The model name
   can be a maximum of 40 characters in length.
 
+``vendor-id`` (default: ``0x1b36`` for Red Hat)
+  Override the default PCI vendor ID. This can be used when needing to
+  more closely impersonate a particular device type or test vendor-specific
+  quirks. The vendor ID must be a 16-bit hexadecimal value. This parameter
+  is mutually exclusive with ``use-intel-id``.
+
+``device-id`` (default: ``0x0010`` for Red Hat NVMe)
+  Override the default PCI device ID. This can be used when needing to
+  more closely impersonate a particular device type or test device-specific
+  quirks. The device ID must be a 16-bit hexadecimal value. Since PCI IDs
+  are a (vendor, device) tuple, this should typically be used together with
+  ``vendor-id``. This parameter is mutually exclusive with ``use-intel-id``.
+
 ``firmware-version`` (default: current QEMU version number)
   Override the default reported firmware version, which can be used when
   needing to more closely impersonate a particular device type. The version
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c..679f3b9930 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8610,6 +8610,14 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         return false;
     }
 
+    if (params->use_intel_id &&
+        (params->vendor_id != PCI_VENDOR_ID_REDHAT ||
+         params->device_id != PCI_DEVICE_ID_REDHAT_NVME)) {
+        error_setg(errp,
+                   "use_intel_id and vendor-id/device-id are mutually exclusive");
+        return false;
+    }
+
     if (params->model &&
         strlen(params->model) > NVME_ID_CTRL_MN_MAX_LEN) {
         error_setg(errp, "'model' parameter '%s' can be at most '%d' characters",
@@ -8976,8 +8984,8 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
         pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_INTEL_NVME);
     } else {
-        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
-        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
+        pci_config_set_vendor_id(pci_conf, n->params.vendor_id);
+        pci_config_set_device_id(pci_conf, n->params.device_id);
     }
 
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
@@ -9401,6 +9409,10 @@ static const Property nvme_props[] = {
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
     DEFINE_PROP_STRING("model", NvmeCtrl, params.model),
     DEFINE_PROP_STRING("firmware-version", NvmeCtrl, params.firmware_version),
+    DEFINE_PROP_UINT16("vendor-id", NvmeCtrl, params.vendor_id,
+                       PCI_VENDOR_ID_REDHAT),
+    DEFINE_PROP_UINT16("device-id", NvmeCtrl, params.device_id,
+                       PCI_DEVICE_ID_REDHAT_NVME),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
     DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5ef3ebee29..eb8467a641 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -544,6 +544,8 @@ typedef struct NvmeParams {
     char     *serial;
     char     *model;
     char     *firmware_version;
+    uint16_t vendor_id;
+    uint16_t device_id;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
-- 
2.54.0


