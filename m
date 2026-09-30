Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE53CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvOw-0005am-K8; Wed, 30 Sep 2026 10:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xBvOu-0005aN-Vn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xBvOt-0004DQ-3d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 10:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790778912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K+ucpArIQ3N6OuJYDqjytNuedNCak911eYfc1hncO7M=;
 b=dDErWYFl4zapks8X39f5ogJ/0f/nLP75tpwIHu+YjiOq7qbauT0kukotNVVHex5SfId85l
 TxHXhYPYjC4b2J62umbGueNBCU3FtiSfC8jKI8RFyJ+aPObKpkC/FXvn7X2L7By83uLh/F
 s7yprGZyzWEX7XRksyNwuxOJyx7f+JA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-HfXZwDxuNAK3KUE6lWEU1w-1; Wed, 30 Sep 2026 10:35:11 -0400
X-MC-Unique: HfXZwDxuNAK3KUE6lWEU1w-1
X-Mimecast-MFC-AGG-ID: HfXZwDxuNAK3KUE6lWEU1w_1790778910
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49953abe51fso35695645e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790778910; x=1791383710; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K+ucpArIQ3N6OuJYDqjytNuedNCak911eYfc1hncO7M=;
 b=mLdU7rrZ5ZTKc59yaSn+d3HIHLOJnbLy3qCPxAtwFsiVhQIIq+WsvjAJbJMlhJVtVB
 S97Yh+L/gppdOk2qx+wdm1tyBu7TUO15aSog/zcCRHx6f0Msi/Oe0c12CYtA+49Mw2yS
 P7kLJ83Erai1vhc861DVPH5tvCZXPSwdUJDtHf+iKV3pHlJri+PS0Y+yQVXjUTXkGx2H
 QcRY4PiRUHMolpG8lJjaYJizBLc9wia3n7p6Onu5mS4wpQFuYN9D1pO96stOXxijEs9Z
 IIJYZPOpSHRSBXqGi3sVKYFaknBupqgJ0fWpxKjS/+3a35+STCq2/Z58lJADU3BHpcRR
 CUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790778910; x=1791383710;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K+ucpArIQ3N6OuJYDqjytNuedNCak911eYfc1hncO7M=;
 b=BvPCbAhePl9fj9JbhZmfBqOT1sK1QXPhaeRM4CZQJi/c1uWwZ7g6lrQMv8ihJYDPOO
 qG642y+z8I2NFt03tGKCwWhB7zxTJgBWu/9zulJGRyNIAqLEIQVnLORWUbGrEfMU2nt3
 HAkKW+mURrUKirYvwSvp16x6Sl/KSSS+HloXMdl6/w1ldUeE6SR/xeiwV6Un53jJYTj2
 SMyeM8FPvPcRqsFn42CLZufArkUcWHOyfcN0btn9wnxVMzthacbaLSUlHxWG33xeI9VV
 dcRzKqYa8xXrCtN9l7AhzMEMb32xKOogIstfVjscTbeFmbrKknXrXUIhyNz72PtlDw0/
 RS9Q==
X-Gm-Message-State: AFuF++lsJzdXdGCs+/MASR8c7KR1VDPIoSNCaNg2VZzVsLDuoZ+YEZ/4
 kFsY213ARDMzTijPheQ/VpMptilxbQ8Tx7d39VHH2zhgGErqRk8PNQGr/Fp3BMA7LrA6Ec5+3hT
 DFbhkxxV7f2wQZArzovCLregQJ2raNF+3Mty+xoy/OwaXRWYfVgiatYJsaYuxvOVgTi0f7FXfTr
 RnJXRaKelvDmb7aEVAl2C7xBJCqGyN1HikJgrRquWr
X-Gm-Gg: AYBFou2fwceABPDWt/9D1DDfWRPb8DhCHYF0QnXZUv7RI4uPqeOTIEFKw1iJ4RjDpNY
 aY02lkVyW2K5QJEHgjD0xz2JRNS4FD7bBzNXaWqG1HRwPb2dqWKFpHh3qHYB3iUZ14V1om3OO3p
 6oa/93x4h7PXWYSLRse5Dy2JaGbA6333AtfJus/mKQwe8k0UOveRX/vaRJ0hL55IPSVO1sN3Fxz
 zJAcAzLwE4+POEXMS5nanKy5Yksi4t+VjkIQYh5Db8n1E9pZakIZwhQvPE5Qmi8CBk5vf9zHf8f
 WpvsHfVsQPPas2yrRnayS7lGvG/QdRYbV6xCJRyXS/Wk1RnCsSSvu1dYOvTGHOmV8BEtKbciFTV
 5ml4uQPvnunhvW9oh/Ya9dK7QW6ndUY8A/IDBk+ueRjCdkuVKDHuHKtXCOGchxl0PzIGP
X-Received: by 2002:a05:600c:474f:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-4a01aff6885mr26811655e9.15.1790778910077; 
 Wed, 30 Sep 2026 07:35:10 -0700 (PDT)
X-Received: by 2002:a05:600c:474f:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-4a01aff6885mr26811185e9.15.1790778909665; 
 Wed, 30 Sep 2026 07:35:09 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cd06778sm10042345e9.3.2026.09.30.07.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:35:08 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 30 Sep 2026 16:35:07 +0200
Subject: [PATCH] igvm: add command line parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-igvm_command_line-v1-1-62857007d89d@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBOmoqCuEhHmTDaQFgoSSHdPW
 r7F/xkiB+EIU5UhcJIoly9o6grMob1lJVQMLbYDjh0qscmt5nJOe1pP8ayM2XqNGxFphNLdgXd
 5/ue8vO8HKZZGt2MAAAA=
X-Change-ID: 20260930-igvm_command_line-ccb5a0bddda0
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This command line is intended for the component running at VMPL0, such
as SVSM, rather than for the guest OS, whose own command line still
comes from -append. SVSM can use it to select the serial port it logs
to, for example.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm-cfg.c            | 20 ++++++++++++++++++++
 backends/igvm.c                | 31 +++++++++++++++++++++++++++++++
 include/system/igvm-internal.h |  5 +++++
 qapi/qom.json                  |  6 +++++-
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 935ba54f54..5b9a30e938 100644
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
@@ -85,6 +98,12 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "file",
                                           "Set the IGVM filename to use");
 
+    object_class_property_add_str(oc, "cmdline", get_cmdline, set_cmdline);
+    object_class_property_set_description(oc, "cmdline",
+                                          "Set the command line for the "
+                                          "software loaded from the IGVM "
+                                          "file");
+
     igvmc->process = qigvm_process_file;
 
     rc->get_state = igvm_reset_state;
@@ -112,4 +131,5 @@ static void igvm_cfg_finalize(Object *obj)
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
index 5895c97750..d56bdef561 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1004,11 +1004,15 @@
 #
 # @file: IGVM file to use to configure guest
 #
+# @cmdline: command line for the software loaded from the IGVM file,
+#     rather than for the guest OS.  Ignored if the IGVM file does
+#     not ask for one.  (since 11.2)
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


