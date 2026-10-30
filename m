Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C93606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mLm6MotU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMlyD-0005IV-IY; Fri, 30 Oct 2026 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMly9-0005Hq-N1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:44:29 -0400
Received: from out-120.mta0.migadu.com ([2001:41d0:1004:224b::78]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xMly7-0001lv-6b
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 08:44:29 -0400
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=JQxFpb1w6oonfIYf6ktt9ZoYfLKevZVXLt9ujZm4CoA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793364261; v=1; x=1793969061;
 b=mLm6MotUj4i5hMseaHIy4Uuq0pZ0QqaKYIpn8yUesOSddj6Kz0qcALAwKkVxPy6/djK3i8WR
 duXCM6YhEzx4+8YmJCgnAPL5THyXhz7h8Jtm5bQSvHm+o4rgRGmVbHzpjunZfmcTLddS79KNHwD
 ergrwBYhY5mZoPFP18dN+OnY=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id dccdfc7b858c4d25;
 Fri, 30 Oct 2026 12:44:21 +0000
X-Mizu-Trace-ID: dccdfc7b858c4d25
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, mjt@tls.msk.ru, jic23@kernel.org,
 anisa.su@samsung.com, mst@redhat.com, philmd@oss.qualcomm.com,
 linux-cxl@vger.kernel.org, junjie.cao@linux.dev
Subject: [PATCH stable-10.0] hw/cxl: free the CCI background timer on Type-3
 reset and exit
Date: Fri, 30 Oct 2026 07:44:17 -0500
Message-ID: <20261030124417.1066423-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::78;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ct3d_reset() re-runs cxl_init_cci() on all three CCIs, and each run
allocates a fresh background timer without freeing the old one, so
every reset leaks three QEMUTimers.  ct3_exit() doesn't free them
either.

Upstream fixed this in 259b877eac36 ("hw/cxl: fix timer leak in
cxl_destroy_cci()") and a004df0be51f ("hw/cxl: destroy primary CCI
before re-initialization on reset"), but both rely on
cxl_destroy_cci() and the .initialized flag from 98cbac128f1c, which
only went in for 10.1.  Add a minimal cxl_destroy_cci() here and call
it before each re-init and from ct3_exit().  timer_free() takes NULL,
so the first reset needs no guard.

ASan on v10.0.15, 5x system_reset on a paused guest with one
cxl-type3: 720 bytes in 15 allocations from cxl_init_cci ->
timer_new_ms before, none after.  cxl-test passes.

Fixes: 221d2cfbdb53 ("hw/cxl/mbox: Add support for background operations")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 hw/cxl/cxl-mailbox-utils.c  | 6 ++++++
 hw/mem/cxl_type3.c          | 6 ++++++
 include/hw/cxl/cxl_device.h | 1 +
 3 files changed, 13 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 516c01d840..6cbc649367 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2986,6 +2986,12 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->fw.slot[cci->fw.active_slot - 1] = true;
 }
 
+void cxl_destroy_cci(CXLCCI *cci)
+{
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
+}
+
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
 {
     for (int set = 0; set < 256; set++) {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1606aa3279..df9c70973e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -973,6 +973,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
+    cxl_destroy_cci(&ct3d->cci);
+    cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    cxl_destroy_cci(&ct3d->ld0_cci);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1222,15 +1225,18 @@ static void ct3d_reset(DeviceState *dev)
 
     pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed);
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
+    cxl_destroy_cci(&ct3d->cci);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
      * Bring up an endpoint to target with MCTP over VDM.
      * This device is emulating an MLD with single LD for now.
      */
+    cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
     cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->vdm_fm_owned_ld_mctp_cci,
                                           DEVICE(ct3d), DEVICE(ct3d),
                                           512); /* Max payload made up */
+    cxl_destroy_cci(&ct3d->ld0_cci);
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3a0ee7e8e7..d9238c903e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -316,6 +316,7 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_destroy_cci(CXLCCI *cci);
 void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
                           size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,

base-commit: c2cfbc6c121b4875ac509da605968ff4289b6aef
-- 
2.43.0


