Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38383606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=OxCvzOLf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3IU-0000tU-8L; Mon, 16 Nov 2026 15:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IR-0000bZ-FH; Mon, 16 Nov 2026 15:27:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3IN-0001Nq-Ft; Mon, 16 Nov 2026 15:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=zPvKBc1aw4e58ZcQW03JQcHbB2sLCcT9CPHhiw5r3eE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OxCvzOLfBvcNzfDzXWu8c0+aWuV86gA5Ew6cAnPB6eAssRgVxB08TUPC03Y3z+QVF
 LPFollkkdDF+/p/esfrUWIf6Y+4srFy5MsuUbUYTFUUoVTImsAOlIlsc3jshFX4MQM
 8G44tUO7w8Oct+/uK0s1m4HawQ0ptpvMpmlzNIzkSAocAbUUA/blUi0DkkQGhVbXbs
 gPlepz29ZsvZt9hjXkQGz5EL9ZHacwWpcr6iQhLTmRo057zMmIKTunzNWP7SODPuCc
 pQMy8AweYDPSPazbpO6pEWTo5eB+Zlgt9djxKy4lqcK2o+CKDws9wmYM2D/WeHxmpd
 3Vh1XzX8Ssd/A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C9FD1E71A7;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 06E5E45FBD3;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9D774B8E6A; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 18/63] hw/cxl: destroy primary CCI before
 re-initialization on reset
Date: Mon, 16 Nov 2026 23:24:57 +0300
Message-ID: <20261116202554.535325-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

ct3d_reset() re-initializes the primary CCI through the call chain
cxl_device_register_init_t3() -> cxl_initialize_mailbox_t3() ->
cxl_init_cci(), but never calls cxl_destroy_cci() first.  Each reset
cycle therefore leaks the old timer and leaves the old mutex
undestroyed while silently overwriting the CCI state.

Per CXL r4.0, the "Mailbox Interfaces Ready" bit in the Memory Device
Status register (Table 8-212) is set after a Conventional Reset or CXL
Reset once the device has re-initialized its mailbox interfaces.  The
CCI is the software abstraction of these interfaces and must be properly
torn down before re-initialization.

The secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) already follow
the correct destroy-before-reinit pattern in the same function; apply
the same discipline to the primary CCI.

Also destroy the secondary CCIs in ct3_exit() where they were
previously leaked at device removal time.  Guard the primary CCI
teardown there with the same .initialized check used for the secondary
CCIs: the primary CCI is only brought up from the reset path
(cxl_device_register_init_t3()), so a device that is unrealized before
its first reset would otherwise tear down a never-initialized CCI.

Fixes: cac36a8faffc ("hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-3-junjie.cao@intel.com>
(cherry picked from commit a004df0be51fd0f5c2b6bde9c61889302f99c7a1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a04dc74ecc4..363ac632f9e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,7 +1076,15 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    cxl_destroy_cci(&ct3d->cci);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+    if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
+        cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    }
+    if (ct3d->ld0_cci.initialized) {
+        cxl_destroy_cci(&ct3d->ld0_cci);
+    }
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1331,6 +1339,9 @@ static void ct3d_reset(DeviceState *dev)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
-- 
2.47.3


