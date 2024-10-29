Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4F8D5B16B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 08:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5hpG-000326-0J; Tue, 29 Oct 2024 04:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpE-00031u-OX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:40 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5hpD-00083P-4N
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 04:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730191419; x=1761727419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tK36CO+mnwx3UfyesQ659HajFWB+D+B7nljlDYn8dyc=;
 b=Lwf2ewuN+ye2TJG7+fxMZBNMkBMo+8YLbnrY9NDmucWSl4FhpuWig0Sz
 gHrvc5Xo0RclFS2XvkNrnN8sCDwhe3fc33ZQsYaHF7Q40NToXg9OrM0vm
 ltSs8wlOGs5kiCey32+SnF7wd+y3YNEU0vrwhKFFnF+IlQ3X/NxaTq+Hm
 CtefNbPWPnNHyGf3QhqPq0Il1D7BpVfJj91njaXyB62qL86aJQwInbXGO
 jgdGr6/jWG0eADC82ZUEojxQQCKj0YStrMNA9LlYu8boulCZc8OxTkhtb
 KBo7G1HpokD+P9wY89Zc6rDAzlv8qQs/RI4xAK9tfEOw2YUyRcm27QOfC w==;
X-CSE-ConnectionGUID: 09NR5Z4rRLebWwUI32frrg==
X-CSE-MsgGUID: fD83p55JR0Sj1NLyPNWGIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29592813"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29592813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 01:43:38 -0700
X-CSE-ConnectionGUID: VP1IhmV/QtCkcdo/miMBew==
X-CSE-MsgGUID: lorqoSSvRsi8MKm63yTs7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="85847198"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2024 01:43:36 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 09/16] hw/virtio: Replace type_register() with
 type_register_static()
Date: Tue, 29 Oct 2024 16:59:27 +0800
Message-Id: <20241029085934.2799066-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029085934.2799066-1-zhao1.liu@intel.com>
References: <20241029085934.2799066-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/virtio/virtio-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4d832fe8455d..21ff7c5f6a9f 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2492,9 +2492,9 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
         base_type_info.class_data = (void *)t;
     }
 
-    type_register(&base_type_info);
+    type_register_static(&base_type_info);
     if (generic_type_info.name) {
-        type_register(&generic_type_info);
+        type_register_static(&generic_type_info);
     }
 
     if (t->non_transitional_name) {
@@ -2508,7 +2508,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
                 { }
             },
         };
-        type_register(&non_transitional_type_info);
+        type_register_static(&non_transitional_type_info);
     }
 
     if (t->transitional_name) {
@@ -2525,7 +2525,7 @@ void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
                 { }
             },
         };
-        type_register(&transitional_type_info);
+        type_register_static(&transitional_type_info);
     }
     g_free(base_name);
 }
-- 
2.34.1


