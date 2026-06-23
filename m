Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591D7CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc1XY-0002FY-DA; Tue, 23 Jun 2026 09:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1wc147-00055W-9o
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1wc145-0008HX-CS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 09:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782220879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QQTzJNCTunADVCOzzNxf5Iq4+GwioWcKVXffcodEvBw=;
 b=JLc76nfVC95SZmappI4iAew5X/8Dsa7NebLfuNnvJ9AQd5/kfwUQ89pntqIvkPFIi2QnJb
 MKZuyfP19Uwc+zaKpwWH4er5pB1D4PnZ1ifGTYIArm+uIVJLufXf4ENKlm+44XhEeBlIwp
 ZXE2Qr2Z3ZRaNy0BD1tv2W2YbyZdKDg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-wC7YIcbcP9WkUIV6dl7Ezg-1; Tue, 23 Jun 2026 09:20:10 -0400
X-MC-Unique: wC7YIcbcP9WkUIV6dl7Ezg-1
X-Mimecast-MFC-AGG-ID: wC7YIcbcP9WkUIV6dl7Ezg_1782220809
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84240683a82so840842b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 06:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782220809; x=1782825609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QQTzJNCTunADVCOzzNxf5Iq4+GwioWcKVXffcodEvBw=;
 b=LGqO0bEtqBSProhFN5NBLhRPR2JO+xwBhYS3LdOIzpWLUcTA/nb71FG/GlJbaBeCv1
 9J+zHKOh9QIBpbTvqjOgqGhXbewPvW86U2TDyZigcxpSgXmcRboZen9Rv4uaUdlW2TAX
 ETv1KaRTkO6FsQb8cQcj6MW9l1eFYvOsv9dgZ7GGe7WcUsLnR8AV/lb7PBkCmEKoG617
 Pe3vCJf6zL76eGJzfR29+qhIHe6suGu2yUqrEzZTXIxW+CgOizVb2lKfEG19Fzu0W7aH
 4+drbzCPpR/23U3oSEapVMa84ki8NzzSFTfdByS1bfDNfiEZXDlxoi4Cvgu9GmLixxK/
 aPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220809; x=1782825609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQTzJNCTunADVCOzzNxf5Iq4+GwioWcKVXffcodEvBw=;
 b=rEuF5+g/bjK4eFWyi/fabSVxCLNCAnajpZY/O6mIlyFIIHGSQ9aTWRmalmqwWJxxqm
 t9mth3guRkIp97nq7zMCnp6YBOTGbjemNyf16Jb/cIVZiZrfpHB1jJWr+ngQhSrX4w1Z
 +pjHPp9B3muP/CZ170bZP/OWgPso5CUvLMR++P1eA7yyomeHwrz72iL4WxEk5N6MGR+t
 tQBgmLdXhfxLwcT0vpjIozmr0nF5Ood/p+Cdn3QFa27jl4Uk88EcXvVxotGxVHtEiMvm
 UB6nymoJjisdBCY7LzbNNjVqL0XbDMbza2IekqgZG2rHD1i+Zrl5djU9e9gMZP+9YTGt
 zzDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8USb61AGmO4xja6QeWd10+fEDQOV+w/mQQq1GB744liLGbBVz3l+Vxd+AO4QCuu706hrn1daF+1mCN@nongnu.org
X-Gm-Message-State: AOJu0YxqVu8Ez4v6n+OwhEMQtrTunSVeX9Hdephx4Ducu/LfUehbeAC4
 MZTuwVqxhMFhg5woJL+kZKrm9ij8Q5W7f2FuD1TRkOO622DlLu5/7uXxh/H086ch9fLyNpM07uc
 FTWkxTHIWjb3AH4vTvxU0MrNVnyBaCeegpJzo64BAmoR+vtJiRHIHwN0=
X-Gm-Gg: AfdE7clSeBxxV+zw8gwVoSsi19ociQIX8w+IV+PcpsmgyICIGWeEOuIaxFmhavqKhA8
 kJwJ35ADpF2syU0bHU2Ms92Xr2mXnJ6rVSKrbvtj3/hWqJrfCstzfzZPiVecSy1ugTtaTFmlfyr
 Aq+bZweET5l2va5OjGCHNar6jr2YX0bIfeTnh3fTmJPC+2r598YyLWgSHbO9lmnKyGc0eGa3vT0
 3NXUJ7NZiNorQPOtrIt+T7YRT6iHGaQZDjR2aCvDy89k7o5erI7o2y/UQjZ1vMYNYdGEiqgipyh
 GuB8Me37+XwZcHzHBVa3Y1oSf9E1uwNU2QXs0tToIC3+yCwEzE1LrKviLhHLwmZCvJbIOuQrQQ7
 JlDpX9nSWIrxmg4+a5aoYrnr2kWgwJdsTMxlclE5B33alHKbC9JJn
X-Received: by 2002:a05:6a00:9284:b0:842:307b:b9d0 with SMTP id
 d2e1a72fcca58-84591cec0b8mr3493369b3a.30.1782220808518; 
 Tue, 23 Jun 2026 06:20:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:9284:b0:842:307b:b9d0 with SMTP id
 d2e1a72fcca58-84591cec0b8mr3493281b3a.30.1782220807651; 
 Tue, 23 Jun 2026 06:20:07 -0700 (PDT)
Received: from utsingh-thinkpadx1carbongen12.bengluru.csb
 ([2405:201:d019:c162:22c9:3093:86cf:366d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564ecd784sm11194887b3a.54.2026.06.23.06.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:20:07 -0700 (PDT)
From: Utkarsh Singh <utsingh@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maurizio Lombardi <mlombard@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>, Utkarsh Singh <utsingh@redhat.com>
Subject: [PATCH] hw/nvme: add user controlled 'vid' property
Date: Tue, 23 Jun 2026 18:49:46 +0530
Message-ID: <20260623131946.46879-1-utsingh@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=utsingh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Jun 2026 09:51:47 -0400
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

Add a user-configurable 'vid' parameter to allow overriding the default
PCI vendor ID. This enables testing of vendor-specific quirks in guest
operating systems.

The parameter accepts a 16-bit hexadecimal value and defaults to Red Hat
vendor ID (0x1b36). It is mutually exclusive with the 'use-intel-id' flag
to prevent conflicting configurations.

Suggested-by: Maurizio Lombardi <mlombard@redhat.com>
Suggested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Utkarsh Singh <utsingh@redhat.com>
---
 docs/system/devices/nvme.rst | 8 +++++++-
 hw/nvme/ctrl.c               | 8 +++++++-
 hw/nvme/nvme.h               | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 98a4401043..0c0c861579 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -51,7 +51,7 @@ parameters.
 ``use-intel-id`` (default: ``off``)
   Since QEMU 5.2, the device uses a QEMU allocated "Red Hat" PCI Device and
   Vendor ID. Set this to ``on`` to revert to the unallocated Intel ID
-  previously used.
+  previously used. This parameter is mutually exclusive with ``vid``.
 
 ``ocp`` (default: ``off``)
   The Open Compute Project defines the Datacenter NVMe SSD Specification that
@@ -65,6 +65,12 @@ parameters.
   to more closely impersonate a particular device type. The model name
   can be a maximum of 40 characters in length.
 
+``vid`` (default: ``0x1b36`` for Red Hat)
+  Override the default PCI vendor ID. This can be used when needing to
+  more closely impersonate a particular device type or test vendor-specific
+  quirks. The vendor ID must be a 16-bit hexadecimal value. This parameter
+  is mutually exclusive with ``use-intel-id``.
+
 ``firmware-version`` (default: current QEMU version number)
   Override the default reported firmware version, which can be used when
   needing to more closely impersonate a particular device type. The version
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c..2e57fd3585 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8610,6 +8610,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         return false;
     }
 
+    if (params->use_intel_id && params->vid != PCI_VENDOR_ID_REDHAT) {
+        error_setg(errp, "use_intel_id and vid are mutually exclusive");
+        return false;
+    }
+
     if (params->model &&
         strlen(params->model) > NVME_ID_CTRL_MN_MAX_LEN) {
         error_setg(errp, "'model' parameter '%s' can be at most '%d' characters",
@@ -8976,7 +8981,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
         pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_INTEL_NVME);
     } else {
-        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
+        pci_config_set_vendor_id(pci_conf, n->params.vid);
         pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
     }
 
@@ -9401,6 +9406,7 @@ static const Property nvme_props[] = {
     DEFINE_PROP_STRING("serial", NvmeCtrl, params.serial),
     DEFINE_PROP_STRING("model", NvmeCtrl, params.model),
     DEFINE_PROP_STRING("firmware-version", NvmeCtrl, params.firmware_version),
+    DEFINE_PROP_UINT16("vid", NvmeCtrl, params.vid, PCI_VENDOR_ID_REDHAT),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, params.cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, params.num_queues, 0),
     DEFINE_PROP_UINT32("max_ioqpairs", NvmeCtrl, params.max_ioqpairs, 64),
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5ef3ebee29..25d46ae8d0 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -544,6 +544,7 @@ typedef struct NvmeParams {
     char     *serial;
     char     *model;
     char     *firmware_version;
+    uint16_t vid;
     uint32_t num_queues; /* deprecated since 5.1 */
     uint32_t max_ioqpairs;
     uint16_t msix_qsize;
-- 
2.54.0


