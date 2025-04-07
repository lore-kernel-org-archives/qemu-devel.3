Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B90C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hpB-0000u8-9d; Mon, 07 Apr 2025 04:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u1hom-0000qk-RN
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:26:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u1hok-0002NR-GU
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744014413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obrCjaZBQ4Qxtaa01R1GgWbN2ky/LdQSspSBHmK+Ugo=;
 b=HadFSNU9JeCVKcai7weXTJE/Q2Q7KSap1v1c7bapUf0LxD7z/Wjjbr54OQWWRlMR1KF5a3
 SnZAK5qv5QC/2Wky3TYn3kYj7cyojd4EyeUYbS5O97d/t4NHJ4JOPBZfBJtliFYU+uHRgJ
 PcwC3NMHjRbVlhrV/lM8VRV8GkLG+W8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-8wiv2MwvNxGcc29pxwbgZA-1; Mon,
 07 Apr 2025 04:26:47 -0400
X-MC-Unique: 8wiv2MwvNxGcc29pxwbgZA-1
X-Mimecast-MFC-AGG-ID: 8wiv2MwvNxGcc29pxwbgZA_1744014406
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66092180AB16; Mon,  7 Apr 2025 08:26:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF4C1195609D; Mon,  7 Apr 2025 08:26:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C60421E66C7; Mon, 07 Apr 2025 10:26:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 1/3] cleanup: Re-run return_directly.cocci
Date: Mon,  7 Apr 2025 10:26:41 +0200
Message-ID: <20250407082643.2310002-2-armbru@redhat.com>
In-Reply-To: <20250407082643.2310002-1-armbru@redhat.com>
References: <20250407082643.2310002-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coccinelle's indentation of virt_create_plic() results in a long line.
Avoid that by mimicking the old indentation manually.

Don't touch tests/tcg/mips/user/.  I'm not sure these files are ours
to make style cleanups on.  They might be imported third-party code,
which we should leave as is to not complicate future updates.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/gpio/pca9554.c                     |  5 +----
 hw/i386/kvm/xen_xenstore.c            |  4 +---
 hw/riscv/virt.c                       | 25 ++++++++++---------------
 hw/scsi/esp.c                         |  5 +----
 hw/vfio/common.c                      |  7 ++-----
 plugins/api.c                         |  4 +---
 tests/qtest/cmsdk-apb-watchdog-test.c |  6 +-----
 tests/qtest/pnv-host-i2c-test.c       |  4 +---
 tests/qtest/stm32l4x5_usart-test.c    |  6 +-----
 tools/i386/qemu-vmsr-helper.c         |  5 +----
 10 files changed, 20 insertions(+), 51 deletions(-)

diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index fe03bb4b5e..7301fce934 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -118,11 +118,8 @@ static void pca9554_write(PCA9554State *s, uint8_t reg, uint8_t data)
 static uint8_t pca9554_recv(I2CSlave *i2c)
 {
     PCA9554State *s = PCA9554(i2c);
-    uint8_t ret;
 
-    ret = pca9554_read(s, s->pointer & 0x3);
-
-    return ret;
+    return pca9554_read(s, s->pointer & 0x3);
 }
 
 static int pca9554_send(I2CSlave *i2c, uint8_t data)
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 17802aa33d..227ad7ace3 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -209,7 +209,6 @@ static int xen_xenstore_post_load(void *opaque, int ver)
 {
     XenXenstoreState *s = opaque;
     GByteArray *save;
-    int ret;
 
     /*
      * As qemu/dom0, rebind to the guest's port. The Windows drivers may
@@ -231,8 +230,7 @@ static int xen_xenstore_post_load(void *opaque, int ver)
     s->impl_state = NULL;
     s->impl_state_size = 0;
 
-    ret = xs_impl_deserialize(s->impl, save, xen_domid, fire_watch_cb, s);
-    return ret;
+    return xs_impl_deserialize(s->impl, save, xen_domid, fire_watch_cb, s);
 }
 
 static const VMStateDescription xen_xenstore_vmstate = {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e517002fdf..85849e604c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1276,27 +1276,22 @@ static FWCfgState *create_fw_cfg(const MachineState *ms)
 static DeviceState *virt_create_plic(const MemMapEntry *memmap, int socket,
                                      int base_hartid, int hart_count)
 {
-    DeviceState *ret;
     g_autofree char *plic_hart_config = NULL;
 
     /* Per-socket PLIC hart topology configuration string */
     plic_hart_config = riscv_plic_hart_config_string(hart_count);
 
     /* Per-socket PLIC */
-    ret = sifive_plic_create(
-            memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
-            plic_hart_config, hart_count, base_hartid,
-            VIRT_IRQCHIP_NUM_SOURCES,
-            ((1U << VIRT_IRQCHIP_NUM_PRIO_BITS) - 1),
-            VIRT_PLIC_PRIORITY_BASE,
-            VIRT_PLIC_PENDING_BASE,
-            VIRT_PLIC_ENABLE_BASE,
-            VIRT_PLIC_ENABLE_STRIDE,
-            VIRT_PLIC_CONTEXT_BASE,
-            VIRT_PLIC_CONTEXT_STRIDE,
-            memmap[VIRT_PLIC].size);
-
-    return ret;
+    return sifive_plic_create(
+             memmap[VIRT_PLIC].base + socket * memmap[VIRT_PLIC].size,
+             plic_hart_config, hart_count, base_hartid,
+             VIRT_IRQCHIP_NUM_SOURCES,
+             ((1U << VIRT_IRQCHIP_NUM_PRIO_BITS) - 1),
+             VIRT_PLIC_PRIORITY_BASE, VIRT_PLIC_PENDING_BASE,
+             VIRT_PLIC_ENABLE_BASE, VIRT_PLIC_ENABLE_STRIDE,
+             VIRT_PLIC_CONTEXT_BASE,
+             VIRT_PLIC_CONTEXT_STRIDE,
+             memmap[VIRT_PLIC].size);
 }
 
 static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ac841dc32e..01bdfe2701 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -242,10 +242,7 @@ static uint32_t esp_get_stc(ESPState *s)
 
 static uint8_t esp_pdma_read(ESPState *s)
 {
-    uint8_t val;
-
-    val = esp_fifo_pop(s);
-    return val;
+    return esp_fifo_pop(s);
 }
 
 static void esp_pdma_write(ESPState *s, uint8_t val)
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1a0d9290f8..d8aad4e1ce 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -110,8 +110,6 @@ static bool vfio_multiple_devices_migration_is_supported(void)
 
 int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
 {
-    int ret;
-
     if (vfio_multiple_devices_migration_is_supported()) {
         return 0;
     }
@@ -129,9 +127,8 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
-
-    return ret;
+    return migrate_add_blocker_normal(&multiple_devices_migration_blocker,
+                                      errp);
 }
 
 void vfio_unblock_multiple_devices_migration(void)
diff --git a/plugins/api.c b/plugins/api.c
index 604ce06802..3c9d4832e9 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -237,12 +237,10 @@ uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
 {
-    struct qemu_plugin_insn *insn;
     if (unlikely(idx >= tb->n)) {
         return NULL;
     }
-    insn = g_ptr_array_index(tb->insns, idx);
-    return insn;
+    return g_ptr_array_index(tb->insns, idx);
 }
 
 /*
diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index 53538f98c9..cd0c602361 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -364,8 +364,6 @@ static void test_watchdog_inten_luminary(const void *ptr)
 
 int main(int argc, char **argv)
 {
-    int r;
-
     g_test_init(&argc, &argv, NULL);
     g_test_set_nonfatal_assertions();
 
@@ -393,7 +391,5 @@ int main(int argc, char **argv)
                             test_watchdog_inten);
     }
 
-    r = g_test_run();
-
-    return r;
+    return g_test_run();
 }
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 7f64d597ac..51e613ebdc 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -191,12 +191,10 @@ static uint8_t pnv_i2c_pca9554_read_pins(PnvI2cDev *dev)
 {
     uint8_t send_buf[1];
     uint8_t recv_buf[1];
-    uint8_t inputs;
     send_buf[0] = PCA9554_INPUT;
     pnv_i2c_send(dev, send_buf, 1);
     pnv_i2c_recv(dev, recv_buf, 1);
-    inputs = recv_buf[0];
-    return inputs;
+    return recv_buf[0];
 }
 
 static void pnv_i2c_pca9554_flip_polarity(PnvI2cDev *dev)
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 927bab6361..98a7472307 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -360,8 +360,6 @@ static void test_clock_enable(void)
 
 int main(int argc, char **argv)
 {
-    int ret;
-
     g_test_init(&argc, &argv, NULL);
     g_test_set_nonfatal_assertions();
 
@@ -372,8 +370,6 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
     qtest_add_func("stm32l4x5/usart/ack", test_ack);
     qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
-    ret = g_test_run();
-
-    return ret;
+    return g_test_run();
 }
 
diff --git a/tools/i386/qemu-vmsr-helper.c b/tools/i386/qemu-vmsr-helper.c
index a35dcb88a3..5f19a48cbd 100644
--- a/tools/i386/qemu-vmsr-helper.c
+++ b/tools/i386/qemu-vmsr-helper.c
@@ -71,7 +71,6 @@ static void compute_default_paths(void)
 
 static int is_intel_processor(void)
 {
-    int result;
     int ebx, ecx, edx;
 
     /* Execute CPUID instruction with eax=0 (basic identification) */
@@ -87,9 +86,7 @@ static int is_intel_processor(void)
      *  0x49656e69 = "ineI"
      *  0x6c65746e = "ntel"
      */
-    result = (ebx == 0x756e6547) && (edx == 0x49656e69) && (ecx == 0x6c65746e);
-
-    return result;
+    return (ebx == 0x756e6547) && (edx == 0x49656e69) && (ecx == 0x6c65746e);
 }
 
 static int is_rapl_enabled(void)
-- 
2.48.1


