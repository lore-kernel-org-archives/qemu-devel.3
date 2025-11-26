Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF553D10F5A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 14:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOGTF-0000T9-J5; Wed, 26 Nov 2025 09:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGTC-0000Ps-Az
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:26:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOGTA-0006Yy-FB
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 09:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764167167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aR8Q56hXIcWVV17OLcpeOmz3e6PhKAJ2AMYxM59GumA=;
 b=C0ChYnuD1Z6Nm7LqKupNyiXAh+ArGjox2i8eH5rgdIOAMOivR8H6fi9SvbBg3dNPRwLoqc
 BTbd6QonM5ozUDquJfBK7WqU0AtIN4OQbeMmaYbPzREx/Lxrw5uO5I1AZr9PqvGS8WAH8p
 sMFjVjogbWnL45CWslOePYPlMv5WA54=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-F2lWqx9MPHie5qvzGGnAjg-1; Wed,
 26 Nov 2025 09:26:05 -0500
X-MC-Unique: F2lWqx9MPHie5qvzGGnAjg-1
X-Mimecast-MFC-AGG-ID: F2lWqx9MPHie5qvzGGnAjg_1764167165
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BF721956052
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 14:26:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.126])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 748961800451; Wed, 26 Nov 2025 14:26:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B81541800397; Wed, 26 Nov 2025 15:25:59 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] hw/uefi: add pcap support
Date: Wed, 26 Nov 2025 15:25:59 +0100
Message-ID: <20251126142559.4081483-3-kraxel@redhat.com>
In-Reply-To: <20251126142559.4081483-1-kraxel@redhat.com>
References: <20251126142559.4081483-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add pcapfile property to uevi-vars-* devices, allowing to write out a
capture of the communication traffic between uefi firmware and qemu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/uefi/var-service.h | 10 ++++
 hw/uefi/var-service-core.c    |  7 +++
 hw/uefi/var-service-pcap.c    | 94 +++++++++++++++++++++++++++++++++++
 hw/uefi/var-service-sysbus.c  |  1 +
 hw/uefi/meson.build           |  1 +
 roms/edk2                     |  2 +-
 6 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/var-service-pcap.c

diff --git a/include/hw/uefi/var-service.h b/include/hw/uefi/var-service.h
index 91fb4a20918a..116ee90a1146 100644
--- a/include/hw/uefi/var-service.h
+++ b/include/hw/uefi/var-service.h
@@ -77,6 +77,10 @@ struct uefi_vars_state {
     bool                              force_secure_boot;
     bool                              disable_custom_mode;
     bool                              use_pio;
+
+    /* request + reply capture */
+    char                              *pcapfile;
+    FILE                              *pcapfp;
 };
 
 struct uefi_vars_cert {
@@ -189,4 +193,10 @@ uefi_var_policy *uefi_vars_add_policy(uefi_vars_state *uv,
                                       variable_policy_entry *pe);
 uint32_t uefi_vars_mm_check_policy_proto(uefi_vars_state *uv);
 
+/* vars-service-pcap.c */
+void uefi_vars_pcap_init(uefi_vars_state *uv);
+void uefi_vars_pcap_reset(uefi_vars_state *uv);
+void uefi_vars_pcap_request(uefi_vars_state *uv, void *buffer, size_t size);
+void uefi_vars_pcap_reply(uefi_vars_state *uv, void *buffer, size_t size);
+
 #endif /* QEMU_UEFI_VAR_SERVICE_H */
diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 6ab8df091aaf..6d7913e03f45 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -101,6 +101,8 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv, bool dma_mode)
     }
     memset(uv->buffer + size, 0, uv->buf_size - size);
 
+    uefi_vars_pcap_request(uv, uv->buffer, size);
+
     /* dispatch */
     if (qemu_uuid_is_equal(&mhdr->guid, &EfiSmmVariableProtocolGuid)) {
         retval = uefi_vars_mm_vars_proto(uv);
@@ -127,6 +129,8 @@ static uint32_t uefi_vars_cmd_mm(uefi_vars_state *uv, bool dma_mode)
         retval = UEFI_VARS_STS_ERR_NOT_SUPPORTED;
     }
 
+    uefi_vars_pcap_reply(uv, uv->buffer, sizeof(*mhdr) + mhdr->length);
+
     /* write buffer */
     if (dma_mode) {
         dma_memory_write(&address_space_memory, dma,
@@ -163,6 +167,8 @@ void uefi_vars_hard_reset(uefi_vars_state *uv)
     uefi_vars_clear_volatile(uv);
     uefi_vars_policies_clear(uv);
     uefi_vars_auth_init(uv);
+
+    uefi_vars_pcap_reset(uv);
 }
 
 static uint32_t uefi_vars_cmd(uefi_vars_state *uv, uint32_t cmd)
@@ -319,4 +325,5 @@ void uefi_vars_realize(uefi_vars_state *uv, Error **errp)
 {
     uefi_vars_json_init(uv, errp);
     uefi_vars_json_load(uv, errp);
+    uefi_vars_pcap_init(uv);
 }
diff --git a/hw/uefi/var-service-pcap.c b/hw/uefi/var-service-pcap.c
new file mode 100644
index 000000000000..879eee4699a3
--- /dev/null
+++ b/hw/uefi/var-service-pcap.c
@@ -0,0 +1,94 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/pcap.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+#define LINKTYPE_EDK2_MM  302
+
+#define SNAPLEN   (64 * 1024)
+#define TYPE_RESET       0x01
+#define TYPE_REQUEST     0x02
+#define TYPE_REPLY       0x03
+
+static void uefi_vars_pcap_header(FILE *fp)
+{
+    struct pcap_hdr header = {
+        .magic_number  = PCAP_MAGIC,
+        .version_major = PCAP_MAJOR,
+        .version_minor = PCAP_MINOR,
+        .snaplen       = SNAPLEN,
+        .network       = LINKTYPE_EDK2_MM,
+    };
+
+    fwrite(&header, sizeof(header), 1, fp);
+    fflush(fp);
+}
+
+static void uefi_vars_pcap_packet(FILE *fp, uint32_t type, void *buffer, size_t size)
+{
+    struct pcaprec_hdr header;
+    struct timeval tv;
+    uint32_t orig_len = size + sizeof(type);
+    uint32_t incl_len = MIN(orig_len, SNAPLEN);
+
+    gettimeofday(&tv, NULL);
+    header.ts_sec   = tv.tv_sec;
+    header.ts_usec  = tv.tv_usec;
+    header.incl_len = incl_len;
+    header.orig_len = orig_len;
+
+    fwrite(&header, sizeof(header), 1, fp);
+    fwrite(&type, sizeof(type), 1, fp);
+    if (buffer) {
+        fwrite(buffer, incl_len - sizeof(type), 1, fp);
+    }
+    fflush(fp);
+}
+
+void uefi_vars_pcap_init(uefi_vars_state *uv)
+{
+    int fd;
+
+    if (!uv->pcapfile) {
+        return;
+    }
+
+    fd = qemu_open_old(uv->pcapfile,
+                       O_CREAT | O_WRONLY | O_TRUNC | O_BINARY, 0666);
+    if (fd < 0) {
+        warn_report("open %s: %s", uv->pcapfile, strerror(errno));
+        return;
+    }
+
+    uv->pcapfp = fdopen(fd, "wb");
+    uefi_vars_pcap_header(uv->pcapfp);
+}
+
+void uefi_vars_pcap_reset(uefi_vars_state *uv)
+{
+    if (!uv->pcapfp) {
+        return;
+    }
+    uefi_vars_pcap_packet(uv->pcapfp, TYPE_RESET, NULL, 0);
+}
+
+void uefi_vars_pcap_request(uefi_vars_state *uv, void *buffer, size_t size)
+{
+    if (!uv->pcapfp) {
+        return;
+    }
+    uefi_vars_pcap_packet(uv->pcapfp, TYPE_REQUEST, buffer, size);
+}
+
+void uefi_vars_pcap_reply(uefi_vars_state *uv, void *buffer, size_t size)
+{
+    if (!uv->pcapfp) {
+        return;
+    }
+    uefi_vars_pcap_packet(uv->pcapfp, TYPE_REPLY, buffer, size);
+}
diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index a5aa218e2600..bd37d5bd3526 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -33,6 +33,7 @@ static const Property uefi_vars_sysbus_properties[] = {
     DEFINE_PROP_SIZE("size", uefi_vars_sysbus_state, state.max_storage,
                      256 * 1024),
     DEFINE_PROP_STRING("jsonfile", uefi_vars_sysbus_state, state.jsonfile),
+    DEFINE_PROP_STRING("pcapfile", uefi_vars_sysbus_state, state.pcapfile),
     DEFINE_PROP_BOOL("force-secure-boot", uefi_vars_sysbus_state,
                      state.force_secure_boot, false),
     DEFINE_PROP_BOOL("disable-custom-mode", uefi_vars_sysbus_state,
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
index c8f38dfae247..3eae47553315 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -3,6 +3,7 @@ system_ss.add(files('hardware-info.c', 'ovmf-log.c'))
 uefi_vars_ss = ss.source_set()
 if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
   uefi_vars_ss.add(files('var-service-core.c',
+                         'var-service-pcap.c',
                          'var-service-json.c',
                          'var-service-vars.c',
                          'var-service-auth.c',
diff --git a/roms/edk2 b/roms/edk2
index 4dfdca63a934..46548b1adac8 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
+Subproject commit 46548b1adac82211d8d11da12dd914f41e7aa775
-- 
2.52.0


