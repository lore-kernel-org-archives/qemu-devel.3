Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA91CCD5BB2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1Zg-0005qZ-51; Thu, 21 May 2026 07:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZX-0005QQ-Ve
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wQ1ZW-0003aE-4S
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779362893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReZqClySschHCYMohzTwFSGAEfy1GO0za1f1vd3CLQo=;
 b=EhFy0cc38YEhWopGrWEunlteUWDKgc/R8Pvb7VnjY6pmY6AEH1IxfTruHIFlUpKekbCE7a
 5VqjyNIqtEFPs4r5zkEZi7Sb2tHsvKNs9qHU3QHKQLO8lAHZXPaBZ6/RJJpNGMsUtow7gm
 9bZriMdVyywD1weoVst3J8a0bNfLoNs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-VriBjByGO4i8VOb3kQ7ASw-1; Thu,
 21 May 2026 07:28:09 -0400
X-MC-Unique: VriBjByGO4i8VOb3kQ7ASw-1
X-Mimecast-MFC-AGG-ID: VriBjByGO4i8VOb3kQ7ASw_1779362888
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3536419560A7; Thu, 21 May 2026 11:28:08 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.32.173])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 699191685; Thu, 21 May 2026 11:28:07 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 2FDE87DC644; Thu, 21 May 2026 13:28:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/3] hw/nvram: add load_image_to_fw_cfg_file()
Date: Thu, 21 May 2026 13:28:04 +0200
Message-ID: <20260521112806.504961-2-kraxel@redhat.com>
In-Reply-To: <20260521112806.504961-1-kraxel@redhat.com>
References: <20260521112806.504961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Function is simliar to load_image_to_fw_cfg() but loads the
image into a named fw_cfg file instead of fixed keys.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/nvram/fw_cfg.c         | 22 ++++++++++++++++++++++
 include/hw/nvram/fw_cfg.h | 15 +++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 1d7d835421..d8653d93cd 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1143,6 +1143,28 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
     fw_cfg_add_bytes(fw_cfg, data_key, data, size);
 }
 
+void load_image_to_fw_cfg_file(FWCfgState *fw_cfg,
+                               const char *fw_cfg_name,
+                               const char *image_name)
+{
+    GMappedFile *mapped_file;
+    GError *gerr = NULL;
+
+    if (image_name == NULL) {
+        return;
+    }
+
+    mapped_file = g_mapped_file_new(image_name, false, &gerr);
+    if (!mapped_file) {
+        error_report("qemu: error reading %s: %s",
+                     image_name, gerr->message);
+        exit(1);
+    }
+    fw_cfg_add_file(fw_cfg, fw_cfg_name,
+                    g_mapped_file_get_contents(mapped_file),
+                    g_mapped_file_get_length(mapped_file));
+}
+
 static void fw_cfg_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 56f17a0bdc..7b31bd0ba6 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -351,4 +351,19 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
                           uint16_t data_key, const char *image_name,
                           bool try_decompress);
 
+/**
+ * load_image_to_fw_cfg_file() - Load an image file into an fw_cfg entry
+ *                               identified by fw_cfg file name.
+ * @fw_cfg:         The firmware config instance to store the data in.
+ * @fw_cfg_name:    The name of the fw_cfg (pseudo) file.
+ * @image_name:     The name of the image file to load. If it is NULL, the
+ *                  function returns without doing anything.
+ *
+ * In case of failure, the function prints an error message to stderr and the
+ * process exits with status 1.
+ */
+void load_image_to_fw_cfg_file(FWCfgState *fw_cfg,
+                               const char *fw_cfg_name,
+                               const char *image_name);
+
 #endif
-- 
2.54.0


