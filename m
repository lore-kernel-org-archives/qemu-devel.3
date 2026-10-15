Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5A8CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIua-0006xb-OA; Thu, 15 Oct 2026 06:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xHIuY-0006xC-B2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xHIuV-0006ej-Cv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792060925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PycOLRXzU7agR6Q3OcAH6kmDrTbpnm5BwTz54oWot1A=;
 b=TdwbnV4MK2X/my4revdaQtDao50reYBxpSHMSlt79KjrTZAQfJ+flZYhcGhqcTyVZhjXzl
 0ZAlegceI+XUKr4kpgP0qM4rMhE2ysIST2bWjsqHMu9Ext8o1W/I8SITQTs7UtEqw5z/hx
 JcvsZfdxAF3kjTS7JdgTkbVhYBXzfrM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-VQTS2QPBMxC8JcEsHwKPng-1; Thu, 15 Oct 2026 10:42:04 +0000
X-MC-Unique: VQTS2QPBMxC8JcEsHwKPng-1
X-Mimecast-MFC-AGG-ID: VQTS2QPBMxC8JcEsHwKPng_1792060923
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a013ea30c0so36558215e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792060923; x=1792665723; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PycOLRXzU7agR6Q3OcAH6kmDrTbpnm5BwTz54oWot1A=;
 b=FcoBV+5CMv9kn3OtL9pW2RLj9WiXuCW+o9bBgw9RshmahC0hSjGcCY0vxi8dLNngfu
 DT/b4ibxqiTpaDJK9N+s9XwWqQYowMJ7if2SWq+p91S7+nr7ZjEFUNGFRqBMu11a3ayN
 g/4s6ks+k5KtlC02OzoREHOeEpO/HhoBaicMuLP5IDubrYTpVmWHspDjp/yg5dNd+vZ1
 CkMrijsgh/XgADgO5CuU0Dcc5ImoBDSk6stPLCXPoGCKcoBJ+qoSVBw1wf21kVaKsjLr
 imZRSLD9V1MXy2QT8im6Go+JUUP9lEfxZyAhH1ileoKgsDUPtpoa0xgZst3cEnz3jPtK
 KNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060923; x=1792665723;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PycOLRXzU7agR6Q3OcAH6kmDrTbpnm5BwTz54oWot1A=;
 b=YDiAFCQiDZJvljPX1euvab0C6HDUOnfuKDK5nwcIWid2tRMctqtgE9kyZRTOINMOLX
 5sQSOVqvIDKm7dQUN0pFhXB0T9AyHvqnlVz78Sm2fyfP7ZZ+em7BKX/OsS3omVSuOx3Q
 SPEXZyEWI0X1t5cSAFYm7UbrFup+BHWMam7LcSQBDPm3LzBC1ki9RvIz7K+8DlbospwQ
 FbttAIkx11eNyul6EFBC0WUACj9OBJEHH35DYZcA4/nBvSH+Bj3gYcailbnLPC9zK9D0
 +MeR35byxueOLYdVzH/UVkApe8VtIf2eQmT616SFQZ+QgwrHcLYUNYguSeX11PD/h/Hh
 ShDg==
X-Gm-Message-State: AFq9FYI15+zpy2eb/4kbGtKH5+FNqKOMdqVaUY+YjF+gCaO4dsc/XvT+
 viMLfxq8guRkHcuoNlslufLy1UnAC1BQ35PV1ZJ+ndfUtdlTwopYYNPYa75Xmk7BPqKK/9DCK9O
 05nQenBGrnat6aoaz5QqZYfVQauIOS4Uoougu0uB0ICnC2spIb5HpqP/D
X-Gm-Gg: AYBFou0F8QIrEkpMCW9THETbcf9vBXs6LNoOUeQj4Hj44zqou2HRhu51MHisRlVheZ0
 F/44qD9pwTU0dH0NPDhPiHyDPtVjQ8shQolxA3sUqhYIprFeYcOdbierXddg50aUc5O0/IUJZqk
 bWVyvg12WqXEhJgtW4gPIxvO+2NTEjaSAVV2gmUxjm+A0Sup4Uvb8pMJdvEC4+d8+Zxukb3hTX1
 Z2IuBgvHmOqGQ8iAfP1YHg2hKbyK7MKbLYUzJyfH/zOMtufVwnQ9+QPesnNP/KShv58w6QUuC+Z
 bX/VvlkM/KWQL8ezrM5a8EQPnoxKhu5TfDuGxCosGVgAPO4V79Yj6iq/kzZeJ98eGT7nXqPs5At
 MSh2k6Eaav0QPnUedHZZWL/lDD9SuazolDV8GcQq/ZwB3UzqMG4Hf7nlk4wPOs8nW+h56
X-Received: by 2002:a05:600c:8b6f:b0:4a0:25e9:bc47 with SMTP id
 5b1f17b1804b1-4a18e4ba6c2mr344020475e9.19.1792060922895; 
 Thu, 15 Oct 2026 03:42:02 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6f:b0:4a0:25e9:bc47 with SMTP id
 5b1f17b1804b1-4a18e4ba6c2mr344020205e9.19.1792060922553; 
 Thu, 15 Oct 2026 03:42:02 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd96fed4sm62387935e9.2.2026.10.15.03.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:42:02 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Thu, 15 Oct 2026 12:41:57 +0200
Subject: [PATCH v2] igvm: add command line parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-igvm_command_line-v2-1-1f358acfdf2f@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NXQrCMBCEr1L22cg20j+fvIeUkmbXdsGmkpSgl
 Nzd2AP4+A0z3+wQ2AsHuBY7eI4SZHUZ9KkAOxs3sRLKDBp1jd0FlUxxGey6LMbR8BTHytqxMjg
 SkUHIu5fnh7wP573PPEvYVv85LmL5S//ZYqlKVeu2ahAbaju6eabZbOfcgj6l9AUtBeRrswAAA
 A==
X-Change-ID: 20260930-igvm_command_line-ccb5a0bddda0
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a "cmdline" property to the igvm-cfg object and a handler for the
IGVM_VHT_COMMAND_LINE directive, which copies the string into the
parameter area the directive points at.

The command line is passed to whatever software the IGVM file loads,
such as an SVSM. For example, SVSM can use it to select the serial port
it logs to.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Updated commit message and doc to make it clear that QEMU does not
  need to parse this string [Markus]
- Link to v1: https://lore.kernel.org/qemu-devel/20260930-igvm_command_line-v1-1-62857007d89d@redhat.com
---
 backends/igvm-cfg.c            | 21 +++++++++++++++++++++
 backends/igvm.c                | 31 +++++++++++++++++++++++++++++++
 include/system/igvm-internal.h |  5 +++++
 qapi/qom.json                  |  6 +++++-
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 935ba54f54..ec796ea8a6 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -34,6 +34,19 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
     igvm->filename = g_strdup(value);
 }
 
+static char *get_cmdline(Object *obj, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    return g_strdup(igvm->cmdline);
+}
+
+static void set_cmdline(Object *obj, const char *value, Error **errp)
+{
+    IgvmCfg *igvm = IGVM_CFG(obj);
+    g_free(igvm->cmdline);
+    igvm->cmdline = g_strdup(value);
+}
+
 static ResettableState *igvm_reset_state(Object *obj)
 {
     IgvmCfg *igvm = IGVM_CFG(obj);
@@ -85,6 +98,13 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "file",
                                           "Set the IGVM filename to use");
 
+    object_class_property_add_str(oc, "cmdline", get_cmdline, set_cmdline);
+    object_class_property_set_description(oc, "cmdline",
+                                          "Set the kernel-style command line "
+                                          "for the software loaded from the IGVM "
+                                          "file (copied verbatim, not "
+                                          "parsed by QEMU)");
+
     igvmc->process = qigvm_process_file;
 
     rc->get_state = igvm_reset_state;
@@ -112,4 +132,5 @@ static void igvm_cfg_finalize(Object *obj)
         igvm_free(igvm->file);
     }
     g_free(igvm->filename);
+    g_free(igvm->cmdline);
 }
diff --git a/backends/igvm.c b/backends/igvm.c
index ec7bee428b..d059fee4d2 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -158,6 +158,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+static int qigvm_directive_command_line(QIgvm *ctx, const uint8_t *header_data,
+                                        Error **errp);
 #ifdef CONFIG_FDT
 static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp);
@@ -192,6 +194,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+    { IGVM_VHT_COMMAND_LINE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_command_line },
 #ifdef CONFIG_FDT
     { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_device_tree },
@@ -851,6 +855,33 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+static int qigvm_directive_command_line(QIgvm *ctx, const uint8_t *header_data,
+                                        Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    const char *cmdline = ctx->cfg->cmdline ? ctx->cfg->cmdline : "";
+    uint8_t *param_data;
+    uint32_t param_size;
+    size_t cmdline_size = strlen(cmdline) + 1;
+
+    param_data = qigvm_get_param_data(ctx, param, &param_size, errp);
+    if (!param_data) {
+        return -1;
+    }
+
+    if (cmdline_size > param_size) {
+        error_setg(errp,
+                   "IGVM: command line size %zu exceeds the %u byte "
+                   "parameter area defined in IGVM file",
+                   cmdline_size, param_size);
+        return -1;
+    }
+
+    memcpy(param_data, cmdline, cmdline_size);
+
+    return 0;
+}
+
 #ifdef CONFIG_FDT
 static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
                                        Error **errp)
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index b3b64cb584..b56a2e1254 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -32,6 +32,11 @@ struct IgvmCfg {
      *           format.
      */
     char *filename;
+    /*
+     * cmdline: Command line for the software loaded from the IGVM file,
+     *          if it asks for one.
+     */
+    char *cmdline;
     IgvmHandle file;
     ResettableState reset_state;
     QTAILQ_HEAD(, IgvmMemoryRegion) memory_regions;
diff --git a/qapi/qom.json b/qapi/qom.json
index 5895c97750..1823ece665 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1004,11 +1004,15 @@
 #
 # @file: IGVM file to use to configure guest
 #
+# @cmdline: kernel-style command line for the software loaded from
+#     the IGVM file.  Passed verbatim: QEMU does not parse it.
+#     Ignored if the IGVM file does not ask for one.  (since 11.2)
+#
 # Since: 10.1
 ##
 { 'struct': 'IgvmCfgProperties',
   'if': 'CONFIG_IGVM',
-  'data': { 'file': 'str' } }
+  'data': { 'file': 'str', '*cmdline': 'str' } }
 
 ##
 # @SevCommonProperties:

---
base-commit: 9c88811b81a935a172c5c873b2ada2d9b38a5f74
change-id: 20260930-igvm_command_line-ccb5a0bddda0

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


