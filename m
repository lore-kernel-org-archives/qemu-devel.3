Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC6DCF34A1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLhwZ-0000gn-NW; Wed, 19 Nov 2025 08:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLhvy-0000A3-1n
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vLhvs-00038t-Fe
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:09:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763557751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWrrhvA/SQYaSu88z25wZQ2Z8oavREpawBAonXTqbBU=;
 b=Qocb20h98X5ii14ZgEsFScLwvtyP1uzIfozth9gvbmNfrrvqj5jsTD32r4HXltnsKM84TB
 Kr6hqyU5DzcM4SLcijOZwLY6b/S/rk2AkwtIhBXXKyIWD4xhVIH4/a3Ft6tam3KIY9GOJB
 kIfE+ejGJ+y0nfggTwXNcXr/fQw8KPA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-4l80z0zhO3KwJirOWaUm4g-1; Wed,
 19 Nov 2025 08:09:07 -0500
X-MC-Unique: 4l80z0zhO3KwJirOWaUm4g-1
X-Mimecast-MFC-AGG-ID: 4l80z0zhO3KwJirOWaUm4g_1763557744
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD5B218AB410; Wed, 19 Nov 2025 13:09:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17C931800346; Wed, 19 Nov 2025 13:09:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F4A421E66A9; Wed, 19 Nov 2025 14:08:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 berrange@redhat.com, peterx@redhat.com, farosas@suse.de, eblake@redhat.com,
 vsementsov@yandex-team.ru, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
Subject: [PATCH 5/5] error: Consistently name Error * objects err, and not errp
Date: Wed, 19 Nov 2025 14:08:55 +0100
Message-ID: <20251119130855.105479-6-armbru@redhat.com>
In-Reply-To: <20251119130855.105479-1-armbru@redhat.com>
References: <20251119130855.105479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This touches code in xen_enable_tpm() that is obviously wrong.  Since
I don't know how to fix it properly, I'm adding a FIXME there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/crypto.c          |  8 ++++----
 hw/acpi/ghes.c          |  8 ++++----
 hw/ppc/spapr.c          | 16 ++++++++--------
 hw/xen/xen-pvh-common.c | 13 ++++++++++---
 nbd/common.c            |  6 +++---
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index b97d027444..36abb7af46 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -938,14 +938,14 @@ static void GRAPH_RDLOCK
 block_crypto_amend_cleanup(BlockDriverState *bs)
 {
     BlockCrypto *crypto = bs->opaque;
-    Error *errp = NULL;
+    Error *err = NULL;
 
     /* release exclusive read/write permissions to the underlying file */
     crypto->updating_keys = false;
-    bdrv_child_refresh_perms(bs, bs->file, &errp);
+    bdrv_child_refresh_perms(bs, bs->file, &err);
 
-    if (errp) {
-        error_report_err(errp);
+    if (err) {
+        error_report_err(err);
     }
 }
 
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 06555905ce..841a36e370 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -563,7 +563,7 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     const uint8_t guid[] =
           UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
                   0xED, 0x7C, 0x83, 0xB1);
-    Error *errp = NULL;
+    Error *err = NULL;
     int data_length;
     GArray *block;
 
@@ -583,12 +583,12 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
     acpi_ghes_build_append_mem_cper(block, physical_address);
 
     /* Report the error */
-    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
+    ghes_record_cper_errors(ags, block->data, block->len, source_id, &err);
 
     g_array_free(block, true);
 
-    if (errp) {
-        error_report_err(errp);
+    if (err) {
+        error_report_err(err);
         return -1;
     }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 99b843ba2f..db5e98e458 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2847,7 +2847,7 @@ static void spapr_machine_init(MachineState *machine)
     int i;
     MemoryRegion *sysmem = get_system_memory();
     long load_limit, fw_size;
-    Error *errp = NULL;
+    Error *err = NULL;
     NICInfo *nd;
 
     if (!filename) {
@@ -2871,7 +2871,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Determine capabilities to run with */
     spapr_caps_init(spapr);
 
-    kvmppc_check_papr_resize_hpt(&errp);
+    kvmppc_check_papr_resize_hpt(&err);
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
         /*
          * If the user explicitly requested a mode we should either
@@ -2879,10 +2879,10 @@ static void spapr_machine_init(MachineState *machine)
          * it's not set explicitly, we reset our mode to something
          * that works
          */
-        if (errp) {
+        if (err) {
             spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
-            error_free(errp);
-            errp = NULL;
+            error_free(err);
+            err = NULL;
         } else {
             spapr->resize_hpt = smc->resize_hpt_default;
         }
@@ -2890,14 +2890,14 @@ static void spapr_machine_init(MachineState *machine)
 
     assert(spapr->resize_hpt != SPAPR_RESIZE_HPT_DEFAULT);
 
-    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && errp) {
+    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && err) {
         /*
          * User requested HPT resize, but this host can't supply it.  Bail out
          */
-        error_report_err(errp);
+        error_report_err(err);
         exit(1);
     }
-    error_free(errp);
+    error_free(err);
 
     spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
 
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index b93ff80c85..3e62ec09d0 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -101,7 +101,7 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
 #ifdef CONFIG_TPM
 static void xen_enable_tpm(XenPVHMachineState *s)
 {
-    Error *errp = NULL;
+    Error *err = NULL;
     DeviceState *dev;
     SysBusDevice *busdev;
 
@@ -111,8 +111,15 @@ static void xen_enable_tpm(XenPVHMachineState *s)
         return;
     }
     dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
-    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);
-    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
+    /*
+     * FIXME This use of &err is is wrong.  If both calls fail, the
+     * second will trip error_setv()'s assertion.  If just one call
+     * fails, we leak an Error object.  Setting the same property
+     * twice (first to a QOM path, then to an ID string) is almost
+     * certainly wrong, too.
+     */
+    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &err);
+    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &err);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, s->cfg.tpm.base);
diff --git a/nbd/common.c b/nbd/common.c
index 2a133a66c3..f43cbaa15b 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -282,10 +282,10 @@ void nbd_set_socket_send_buffer(QIOChannelSocket *sioc)
 #ifdef UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE
     if (sioc->localAddr.ss_family == AF_UNIX) {
         size_t size = UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE;
-        Error *errp = NULL;
+        Error *err = NULL;
 
-        if (qio_channel_socket_set_send_buffer(sioc, size, &errp) < 0) {
-            warn_report_err(errp);
+        if (qio_channel_socket_set_send_buffer(sioc, size, &err) < 0) {
+            warn_report_err(err);
         }
     }
 #endif /* UNIX_STREAM_SOCKET_SEND_BUFFER_SIZE */
-- 
2.49.0


