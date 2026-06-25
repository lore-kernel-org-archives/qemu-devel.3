Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6963CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrX3-0007aj-V9; Thu, 25 Jun 2026 17:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrX1-0007Qr-PR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWy-00045I-Rs
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YhYMnPhbRYhjBhgARIMoP5FZYbbXSNC5Y99BK0mBCEY=;
 b=A8da8PmRnMCj5S/d8AZj4+G1EdpURS+lmIbDwOCEmkcbelUUEB7R53cscrnbUiNl4k11XO
 b2rlTZgmd2spiPk7kp3phQxHmqO9qu6J9Xro2Sf/YADo8YwmOnlVOk+c0uwF8xcyVraIq6
 vALDIXz+DATF+bW3UYssgoxNhVLvsUU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-eEc5xAsiOvimtrmlHh91aA-1; Thu,
 25 Jun 2026 17:22:36 -0400
X-MC-Unique: eEc5xAsiOvimtrmlHh91aA-1
X-Mimecast-MFC-AGG-ID: eEc5xAsiOvimtrmlHh91aA_1782422556
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D98071955F38; Thu, 25 Jun 2026 21:22:35 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4DD5531D2; Thu, 25 Jun 2026 21:22:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:35 +0400
Subject: [PATCH v2 34/39] Guard HMP command implementations with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-34-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=22115;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eYZoSOXto3I/Guv1BywDpFtgYoq43ZklUDHw6DxAJIU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZteGE6W12wpgxpKm6mu4RqzpTJgGg02Xmmg2
 zGAULcECdSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXgAKCRDa6OEJdZac
 5YvbD/oD7Xi1AnvWuwJ3fAXQsj+WUc0wIN5jhgqr6zPaAesmIkHYokMcWQjb7EE1F6+MOiTosIC
 w13gYW8RxpEqIVFWjlthSMcKHHzwN3ss0FJvNIssrTwFcWPrRAkzGmnH+ZzfAtCe7k/bEcG6yIw
 WsnOnXA+AtMC7p4CcdA6XkB5z9MwD/Ucid9fINhEHHoKv/CTLci5lDnpEStHOD3gxPZScseyqb6
 ZsclUQ4mQ74/9YGUXNSBAtwbKcZnLvs6X40a4qVoVwW3RBvLuLG0Ni+p23Kd9xUBktiPj6/9PDk
 byWfXObt1A3/pP7uO8RkEhepmivn43yCeGGCAPTegaF2KvuOJ1In6iTVbrzPvHxtffSmKAe3pVx
 xt1l08zZVDLg28dwT+yvEvEEp5rwdi/3aUe400nSJCdv8B+E1jf3oIx/I9gcqQQo+wN9z/50HhY
 mm+Sej8TVRkL1H8Zvt/AsaXqkcGHf8i8KmG2fJvas9BowS0uSL68i8+8dCC4+JGoeyItxzmB4yU
 iRDzSDcVWzYNoKHYXI7eRghobbe20pl0FCT2y1PyY8yiVZeRRVOVQMnRpn9n49Ymswib8MB4cqb
 WXbsOEPa4iSHt/YXVhZPGCfAXQkz4WcZFcgBu9v++qstcHn9ob/zKs5PUyoghxxRmnwROUqmuwf
 yFa62kqwTbUMnKA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add #ifdef CONFIG_HMP around all hmp_* function implementations and
their HMP-only helpers across subsystems.

This covers monitor_register_hmp* callers, hmp_info_* handlers, and
HMP-only helper functions like slirp_lookup.

To link succesfully, use empty cmds tables in hmp-cmds.c (to be removed
once meson build-sys is updated with !hmp support later in the series)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/accel-system.c      | 2 ++
 accel/tcg/monitor.c       | 2 ++
 hw/i386/kvm/xen-stubs.c   | 2 ++
 hw/i386/kvm/xen_evtchn.c  | 3 ++-
 hw/i386/sgx.c             | 2 ++
 hw/misc/mos6522-stub.c    | 2 ++
 hw/misc/mos6522.c         | 2 ++
 hw/pci/pci-stub.c         | 2 ++
 hw/s390x/s390-skeys.c     | 2 ++
 hw/s390x/s390-stattrib.c  | 4 ++++
 hw/uefi/ovmf-log.c        | 2 ++
 hw/usb/host-libusb.c      | 6 ++++++
 migration/dirtyrate.c     | 2 ++
 monitor/hmp-cmds.c        | 5 +++++
 net/slirp.c               | 7 ++++++-
 replay/replay-debugging.c | 8 ++++++++
 replay/stubs-system.c     | 6 ++++++
 system/dirtylimit.c       | 6 ++++++
 system/qdev-monitor.c     | 4 ++++
 target/i386/cpu-apic.c    | 2 ++
 target/i386/monitor.c     | 3 +++
 target/i386/sev.c         | 2 ++
 target/m68k/monitor.c     | 2 ++
 target/ppc/monitor.c      | 2 ++
 target/riscv/monitor.c    | 3 +++
 target/sh4/monitor.c      | 2 ++
 target/sparc/monitor.c    | 2 ++
 target/xtensa/monitor.c   | 2 ++
 28 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 9176665202d..a8715924729 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -108,7 +108,9 @@ void accel_init_ops_interfaces(AccelClass *ac)
 
 static void accel_ops_class_init(ObjectClass *oc, const void *data)
 {
+#ifdef CONFIG_HMP
     monitor_register_hmp_info_hrt("accel", qmp_x_accel_stats);
+#endif
 }
 
 static const TypeInfo accel_ops_type_info = {
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index be5c1950177..c860744536b 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -29,9 +29,11 @@ HumanReadableText *qmp_x_query_jit(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
+#ifdef CONFIG_HMP
 static void hmp_tcg_register(void)
 {
     monitor_register_hmp_info_hrt("jit", qmp_x_query_jit);
 }
 
 type_init(hmp_tcg_register);
+#endif
diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index bf6ac28bef4..df36c84a4f4 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -40,6 +40,7 @@ void xen_primary_console_set_be_port(uint16_t port)
 {
 }
 
+#ifdef CONFIG_HMP
 void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
@@ -49,3 +50,4 @@ void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "XEN emulation is not available in this QEMU\n");
 }
+#endif
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 8b243984e41..cb7b4c7a81b 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -2344,6 +2344,7 @@ void qmp_xen_event_inject(uint32_t port, Error **errp)
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_xen_event_list(Monitor *mon, const QDict *qdict)
 {
     EvtchnInfoList *iter, *info_list;
@@ -2391,4 +2392,4 @@ void hmp_xen_event_inject(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "Delivered port %d\n", port);
     }
 }
-
+#endif
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 7e4c509f5a4..4ac8ea75aa7 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -234,6 +234,7 @@ SgxInfo *qmp_query_sgx(Error **errp)
     return info;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
@@ -265,6 +266,7 @@ void hmp_info_sgx(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "total size=%" PRIu64 "\n",
                    size);
 }
+#endif
 
 bool check_sgx_support(void)
 {
diff --git a/hw/misc/mos6522-stub.c b/hw/misc/mos6522-stub.c
index 85eb0ee36ee..03fea6985a9 100644
--- a/hw/misc/mos6522-stub.c
+++ b/hw/misc/mos6522-stub.c
@@ -10,7 +10,9 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_via(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "MOS6522 VIA is not available in this QEMU\n");
 }
+#endif
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index bae766ef178..6be7ed3ff30 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -497,6 +497,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
     }
 }
 
+#ifdef CONFIG_HMP
 static int qmp_x_query_via_foreach(Object *obj, void *opaque)
 {
     GString *buf = opaque;
@@ -596,6 +597,7 @@ void hmp_info_via(Monitor *mon, const QDict *qdict)
     }
     monitor_puts(mon, info->human_readable_text);
 }
+#endif /* CONFIG_HMP */
 
 static const MemoryRegionOps mos6522_ops = {
     .read = mos6522_read,
diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index 3397d0c82ea..f217373ef03 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -34,6 +34,7 @@ PciInfoList *qmp_query_pci(Error **errp)
     return NULL;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_pci(Monitor *mon, const QDict *qdict)
 {
 }
@@ -42,6 +43,7 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "PCI devices not supported\n");
 }
+#endif
 
 /* kvm-all wants this */
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 7dca67d6618..81885a1640c 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -104,6 +104,7 @@ static void write_keys(FILE *f, uint8_t *keys, uint64_t startgfn,
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_skeys(Monitor *mon, const QDict *qdict)
 {
     S390SKeysState *ss = s390_get_skeys_device();
@@ -144,6 +145,7 @@ void hmp_dump_skeys(Monitor *mon, const QDict *qdict)
         error_report_err(err);
     }
 }
+#endif
 
 void s390_qmp_dump_skeys(const char *filename, Error **errp)
 {
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c334714b31a..2fdf70bf2ed 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -32,6 +32,7 @@
 #define STATTR_FLAG_ERROR   0x04ULL
 #define STATTR_FLAG_DONE    0x08ULL
 
+#ifdef CONFIG_HMP
 static S390StAttribState *s390_get_stattrib_device(void)
 {
     S390StAttribState *sas;
@@ -40,6 +41,7 @@ static S390StAttribState *s390_get_stattrib_device(void)
     assert(sas);
     return sas;
 }
+#endif
 
 void s390_stattrib_init(void)
 {
@@ -59,6 +61,7 @@ void s390_stattrib_init(void)
 
 /* Console commands: */
 
+#ifdef CONFIG_HMP
 void hmp_migrationmode(Monitor *mon, const QDict *qdict)
 {
     S390StAttribState *sas = s390_get_stattrib_device();
@@ -110,6 +113,7 @@ void hmp_info_cmma(Monitor *mon, const QDict *qdict)
 out:
     g_free(vals);
 }
+#endif
 
 /* Migration support: */
 
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 3a24afd9417..395a2d10a37 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -256,6 +256,7 @@ FirmwareLog *qmp_query_firmware_log(bool have_max_size, uint64_t max_size,
     return ret;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
 {
     g_autofree gchar *log_esc = NULL;
@@ -284,3 +285,4 @@ void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
     log_esc = g_strescape((gchar *)log_out, "\r\n");
     monitor_printf(mon, "%s\n", log_esc);
 }
+#endif
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b9f3ad3f66d..121fd817e82 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -183,6 +183,7 @@ static void usb_host_attach_kernel(USBHostDevice *s);
 # define HAVE_SUPER_PLUS 1
 #endif
 
+#ifdef CONFIG_HMP
 static const char *speed_name[] = {
     [LIBUSB_SPEED_UNKNOWN] = "?",
     [LIBUSB_SPEED_LOW]     = "1.5",
@@ -193,6 +194,7 @@ static const char *speed_name[] = {
     [LIBUSB_SPEED_SUPER_PLUS] = "5000+",
 #endif
 };
+#endif
 
 static const unsigned int speed_map[] = {
     [LIBUSB_SPEED_LOW]     = USB_SPEED_LOW,
@@ -1814,7 +1816,9 @@ module_kconfig(USB);
 static void usb_host_register_types(void)
 {
     type_register_static(&usb_host_dev_info);
+#ifdef CONFIG_HMP
     monitor_register_hmp("usbhost", true, hmp_info_usbhost);
+#endif
 }
 
 type_init(usb_host_register_types)
@@ -1919,6 +1923,7 @@ static void usb_host_auto_check(void *unused)
     timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
 {
     libusb_device **devs = NULL;
@@ -1962,3 +1967,4 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
     }
     libusb_free_device_list(devs, 1);
 }
+#endif
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index b360f49efea..8808f20f1b9 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -856,6 +856,7 @@ struct DirtyRateInfo *qmp_query_dirty_rate(bool has_calc_time_unit,
         has_calc_time_unit ? calc_time_unit : TIME_UNIT_SECOND);
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_dirty_rate(Monitor *mon, const QDict *qdict)
 {
     DirtyRateInfo *info = query_dirty_rate_info(TIME_UNIT_SECOND);
@@ -932,3 +933,4 @@ void hmp_calc_dirty_rate(Monitor *mon, const QDict *qdict)
                    " seconds\n", sec);
     monitor_printf(mon, "[Please use 'info dirty_rate' to check results]\n");
 }
+#endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e7a02b1fddb..a68d3b828d2 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -42,6 +42,7 @@
 #include "disas/disas.h"
 
 /* Please update hmp-commands.hx when adding or changing commands */
+#ifdef CONFIG_HMP
 static HMPCommand hmp_info_cmds[] = {
 #include "hmp-commands-info.h"
     { NULL, NULL, },
@@ -52,6 +53,10 @@ static HMPCommand hmp_cmds[] = {
 #include "hmp-commands.h"
     { NULL, NULL, },
 };
+#else
+static HMPCommand hmp_info_cmds[] = { { NULL, NULL, }, };
+static HMPCommand hmp_cmds[] = { { NULL, NULL, }, };
+#endif
 
 HMPCommand *hmp_cmds_for_target(bool info_command)
 {
diff --git a/net/slirp.c b/net/slirp.c
index 517dd23be14..d9527e663aa 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -710,6 +710,7 @@ error:
     return -1;
 }
 
+#ifdef CONFIG_HMP
 static SlirpState *slirp_lookup(Monitor *mon, const char *id)
 {
     if (id) {
@@ -800,6 +801,7 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
  fail_syntax:
     monitor_printf(mon, "invalid format\n");
 }
+#endif
 
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 {
@@ -956,6 +958,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
     return -1;
 }
 
+#ifdef CONFIG_HMP
 void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
 {
     const char *redir_str;
@@ -976,8 +979,8 @@ void hmp_hostfwd_add(Monitor *mon, const QDict *qdict)
             error_report_err(err);
         }
     }
-
 }
+#endif
 
 #if defined(CONFIG_SMBD_COMMAND)
 
@@ -1223,6 +1226,7 @@ UsernetInfoList *qmp_x_query_usernet(Error **errp)
     return head;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_usernet(Monitor *mon, const QDict *qdict)
 {
     g_autoptr(UsernetInfoList) list = NULL;
@@ -1236,6 +1240,7 @@ void hmp_info_usernet(Monitor *mon, const QDict *qdict)
                        ui->hub_name, ui->info);
     }
 }
+#endif
 
 static void
 net_init_slirp_configs_host(const NetdevUserHostForwardList *fwd)
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 11053640021..1adf7422e36 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -31,6 +31,7 @@ bool replay_running_debug(void)
     return replay_is_debugging;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
     if (replay_mode == REPLAY_MODE_NONE) {
@@ -42,6 +43,7 @@ void hmp_info_replay(Monitor *mon, const QDict *qdict)
             replay_get_filename(), replay_get_current_icount());
     }
 }
+#endif
 
 ReplayInfo *qmp_query_replay(Error **errp)
 {
@@ -103,6 +105,7 @@ void qmp_replay_break(int64_t icount, Error **errp)
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_replay_break(Monitor *mon, const QDict *qdict)
 {
     int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
@@ -114,6 +117,7 @@ void hmp_replay_break(Monitor *mon, const QDict *qdict)
         return;
     }
 }
+#endif
 
 void qmp_replay_delete_break(Error **errp)
 {
@@ -124,6 +128,7 @@ void qmp_replay_delete_break(Error **errp)
     }
 }
 
+#ifdef CONFIG_HMP
 void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
@@ -134,6 +139,7 @@ void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
         return;
     }
 }
+#endif
 
 static char *replay_find_nearest_snapshot(int64_t icount,
                                           int64_t *snapshot_icount)
@@ -208,6 +214,7 @@ void qmp_replay_seek(int64_t icount, Error **errp)
     replay_seek(icount, replay_stop_vm, errp);
 }
 
+#ifdef CONFIG_HMP
 void hmp_replay_seek(Monitor *mon, const QDict *qdict)
 {
     int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
@@ -219,6 +226,7 @@ void hmp_replay_seek(Monitor *mon, const QDict *qdict)
         return;
     }
 }
+#endif
 
 static void replay_stop_vm_debug(void *opaque)
 {
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index f8e17dcf1ce..5ca80b4439d 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -63,22 +63,28 @@ void replay_vmstate_init(void)
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+
 void hmp_replay_break(Monitor *mon, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+
 void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+
 void hmp_replay_seek(Monitor *mon, const QDict *qdict)
 {
     error_report("replay support not available");
 }
+#endif
+
 ReplayInfo *qmp_query_replay(Error **errp)
 {
     error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 50fa67f3d6a..8992c45a509 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -491,6 +491,7 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
     dirtylimit_state_unlock();
 }
 
+#ifdef CONFIG_HMP
 void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
 {
     int64_t cpu_index = qdict_get_try_int(qdict, "cpu_index", -1);
@@ -505,6 +506,7 @@ void hmp_cancel_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "[Please use 'info vcpu_dirty_limit' to query "
                    "dirty limit for virtual CPU]\n");
 }
+#endif
 
 void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
                               int64_t cpu_index,
@@ -548,6 +550,7 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
     dirtylimit_state_unlock();
 }
 
+#ifdef CONFIG_HMP
 void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
 {
     int64_t dirty_rate = qdict_get_int(qdict, "dirty_rate");
@@ -564,6 +567,7 @@ void hmp_set_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
 out:
     hmp_handle_error(mon, err);
 }
+#endif
 
 /* Return the max throttle time of each virtual CPU */
 uint64_t dirtylimit_throttle_time_per_round(void)
@@ -647,6 +651,7 @@ struct DirtyLimitInfoList *qmp_query_vcpu_dirty_limit(Error **errp)
     return dirtylimit_query_all();
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
 {
     DirtyLimitInfoList *info;
@@ -672,3 +677,4 @@ void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
                             info->value->current_rate);
     }
 }
+#endif
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index dfc95a08c10..68454bc7909 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -763,6 +763,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     return ret;
 }
 
+#ifdef CONFIG_HMP
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
 
 static void qdev_print_props(Monitor *mon, DeviceState *dev, DeviceClass *dc,
@@ -864,6 +865,7 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
 {
     qdev_print_devinfos(true);
 }
+#endif /* CONFIG_HMP */
 
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
@@ -1001,6 +1003,7 @@ void qmp_device_sync_config(const char *id, Error **errp)
     qdev_sync_config(dev, errp);
 }
 
+#ifdef CONFIG_HMP
 void hmp_device_add(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
@@ -1043,6 +1046,7 @@ void hmp_device_del(Monitor *mon, const QDict *qdict)
     qmp_device_del(id, &err);
     hmp_handle_error(mon, err);
 }
+#endif
 
 void device_add_completion(ReadLineState *rs, int nb_args, const char *str)
 {
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 04b7257ad12..2f4c8a58fb2 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -80,6 +80,7 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
      }
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
 {
     CPUState *cs;
@@ -102,3 +103,4 @@ void hmp_info_local_apic(Monitor *mon, const QDict *qdict)
     }
     x86_cpu_dump_local_apic_state(cs, CPU_DUMP_FPU);
 }
+#endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 9ed772e6d7f..18329b6cc98 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -31,6 +31,8 @@
 #include "qapi/qapi-commands-misc.h"
 #include "system/memory.h"
 
+#ifdef CONFIG_HMP
+
 /* Perform linear address sign extension */
 static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
 {
@@ -595,3 +597,4 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, err);
 }
+#endif
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 99cf30806be..b6d975ae2b2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -758,6 +758,7 @@ SevInfo *qmp_query_sev(Error **errp)
     return info;
 }
 
+#ifdef CONFIG_HMP
 void hmp_info_sev(Monitor *mon, const QDict *qdict)
 {
     SevInfo *info = sev_get_info();
@@ -791,6 +792,7 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
 out:
     qapi_free_SevInfo(info);
 }
+#endif
 
 static int
 sev_get_pdh_info(int fd, guchar **pdh, size_t *pdh_len, guchar **cert_chain,
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 3e0df40a6b8..27f65d556e5 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -10,6 +10,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
@@ -21,3 +22,4 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
     dump_mmu(env1);
 }
+#endif
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 7c88e0e2bda..2fa27105a34 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -11,6 +11,7 @@
 #include "monitor/hmp.h"
 #include "cpu.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
@@ -21,3 +22,4 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+#endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3e89dcaf7c6..da9975dd1b9 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -39,6 +39,8 @@
 #define PTE_HEADER_DELIMITER    "-------- ---------------- -------- -------\n"
 #endif
 
+#ifdef CONFIG_HMP
+
 /* Perform linear address sign extension */
 static target_ulong addr_canonical(int va_bits, target_ulong addr)
 {
@@ -244,6 +246,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
 
     mem_info_svxx(mon, env);
 }
+#endif /* CONFIG_HMP */
 
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 50324d3600c..619d2678d0a 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
+#ifdef CONFIG_HMP
 static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
 {
     monitor_printf(mon, " tlb%i:\t"
@@ -55,3 +56,4 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     for (i = 0 ; i < UTLB_SIZE ; i++)
         print_tlb (mon, i, &env->utlb[i]);
 }
+#endif
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 36f3d8d58e9..ed7e3b4b8b2 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -27,6 +27,7 @@
 #include "monitor/hmp.h"
 
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
@@ -37,3 +38,4 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+#endif
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index 2af84934f83..3f8a93ed724 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 
+#ifdef CONFIG_HMP
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
@@ -36,3 +37,4 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
     dump_mmu(env1);
 }
+#endif

-- 
2.54.0


