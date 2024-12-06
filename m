Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96717E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcqN-0001Mm-QN; Fri, 06 Dec 2024 13:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqM-0001ME-Ge
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:22 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqK-0005PW-Id
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434a83c6b01so16139105e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508859; x=1734113659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcfKXIJuNiuvzm2ydvBx89mK8MIYUVOg22CEhEE1H9M=;
 b=zAuPiWqkUAnLyuapXuXWEa131/B1BmQA9ITE/9cAbPclCeqTdqLr0A3RLUpiWrgV6T
 Fb2sOzPZ2BXs19DyNah3CcpAdYKxWiKJ70QRvjM/9/Q5caiHaKDle1gGtk/IkSqMt0+S
 L0ZrUX83W5uQGa9Xet8s4/bW5/tnX72fOi8WaYSPj+SyzewVOQ4IvXzcGEMt2iEjxDM3
 xSpRVL7e8nS51i4ZcZ7NxUC47FSpbbctEzHnfDBde+Acv8lNEethhBiOa4183a+4IXEA
 H36W5jZMain9Gumq2PzDOQgKbhsH6x1DOXnPzoyyW6ALd5AsIpiLrxyeVeRMKl9w/1qn
 0J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508859; x=1734113659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcfKXIJuNiuvzm2ydvBx89mK8MIYUVOg22CEhEE1H9M=;
 b=hC4gZ9V7FD1HBRbpzQlfxHlZ8xXJ7rarkD1jnDEV/bLYU3xvRYifSIIjlptrGrK1TN
 95DEIo+zCYuM8kX29Hs/DQJVEuazM3ooKOfsnVubwryuhdHggArP0b5jInDFF3tcanEk
 pP123dTviUqgf4Y+xWGmGEOlmjQ4MolNNflpdIAJeapFKhyqhwu4zRBI+E3Rti4K1IQG
 OwtPuhitA5tiTYBiPxWcwOCVjE1WznmK1Jry5Qrdc1eDdfjz6+2RTgd12vUIkgcp/J3o
 Ma1D5SBoAYvKhNWkMb92KOxtH9L/LED4bVYraS5QR/A67ArDjMYT2EE5nVro3vPVE9cM
 8YxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtMEuNLIjteSB9ig8QHZWxURMBKwFRQsjXMVnkDgrvjQ2OggVdbld9wIlWqwU5Z3zahgvJcyQvuoo5@nongnu.org
X-Gm-Message-State: AOJu0Yw+TYtw/agraK1qJYgcKDkuwzqsREZhlAj9uMOnLCcH15CTx3n2
 q+HGeQ3SmmdJKoYGOyx992njIjDjdJHBI9GpTwQQE+OKmcwqCI81bvFOYpK+f5Q=
X-Gm-Gg: ASbGncuTEfqkGwiZ1sCids8e2zp2IDyFysRyhg5nz/Lv/TYbA4g4zGHdEf0YNpU8AT/
 +31g7wkfEACUu0lpvN0Be5IVglcderoN9Hz6HyOHoM2JqeXIBnUfT1FJ8HQvu2MlYxhllgxI4QA
 vNMLe4ivMfpiiHzEo9G291DOQxiRh+JqtUKmH2cLG0Ra5F+SUD/C2UAL87G1vDLHIjQdjt8ES8/
 n1/DIJbsU1APsk/QQh5Z0aWyPv3ovaZL7xmizcd6qOVF6svEiamEP+avxbzk9JnyV4=
X-Google-Smtp-Source: AGHT+IHlaOCooYSRu6bTIhC/PfPUY7NA9to/ybCea651MHJEUR1wEhCjBtPLkV0dGpLBkXDFnDmNMA==
X-Received: by 2002:a05:600c:19c7:b0:434:a781:f5d2 with SMTP id
 5b1f17b1804b1-434ddea7f36mr35413855e9.5.1733508857333; 
 Fri, 06 Dec 2024 10:14:17 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d5272f99sm98988715e9.11.2024.12.06.10.14.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 10:14:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiahui Cen <cenjiahui@huawei.com>,
	qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/6] hw/nvram/fw_cfg: Pass QOM parent to
 fw_cfg_add_file_from_generator()
Date: Fri,  6 Dec 2024 19:13:48 +0100
Message-ID: <20241206181352.6836-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206181352.6836-1-philmd@linaro.org>
References: <20241206181352.6836-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Currently fw_cfg_add_file_from_generator() is restricted
to command line created objects which reside in the
'/objects' QOM container. In order to extend to other
types of containers, pass the QOM parent by argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h | 10 ++++++----
 hw/nvram/fw_cfg.c         | 11 ++++++-----
 system/vl.c               |  3 ++-
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 14e68966c59..fcb06f18cc3 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -294,11 +294,12 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  * fw_cfg_add_file_from_generator:
  * @s: fw_cfg device being modified
  * @filename: name of new fw_cfg file item
- * @gen_id: name of object implementing FW_CFG_DATA_GENERATOR interface
+ * @part: name of object implementing FW_CFG_DATA_GENERATOR interface
+ * @parent: the object in which to resolve the @part
  * @errp: pointer to a NULL initialized error object
  *
  * Add a new NAMED fw_cfg item with the content generated from the
- * @gen_id object. The data generated by the @gen_id object is copied
+ * @part object. The data generated by the @part object is copied
  * into the data structure of the fw_cfg device.
  * The next available (unused) selector key starting at FW_CFG_FILE_FIRST
  * will be used; also, a new entry will be added to the file directory
@@ -307,8 +308,9 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  *
  * Returns: %true on success, %false on error.
  */
-bool fw_cfg_add_file_from_generator(FWCfgState *s, const char *filename,
-                                    const char *gen_id, Error **errp);
+bool fw_cfg_add_file_from_generator(FWCfgState *s,
+                                    Object *parent, const char *part,
+                                    const char *filename, Error **errp);
 
 /**
  * fw_cfg_add_extra_pci_roots:
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index fe3b86135a7..b94cd27bd85 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1027,22 +1027,23 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
-bool fw_cfg_add_file_from_generator(FWCfgState *s, const char *filename,
-                                    const char *gen_id, Error **errp)
+bool fw_cfg_add_file_from_generator(FWCfgState *s,
+                                    Object *parent, const char *part,
+                                    const char *filename, Error **errp)
 {
     FWCfgDataGeneratorClass *klass;
     GByteArray *array;
     Object *obj;
     gsize size;
 
-    obj = object_resolve_path_component(object_get_objects_root(), gen_id);
+    obj = object_resolve_path_component(parent, part);
     if (!obj) {
-        error_setg(errp, "Cannot find object ID '%s'", gen_id);
+        error_setg(errp, "Cannot find object ID '%s'", part);
         return false;
     }
     if (!object_dynamic_cast(obj, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE)) {
         error_setg(errp, "Object ID '%s' is not a '%s' subclass",
-                   gen_id, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
+                   part, TYPE_FW_CFG_DATA_GENERATOR_INTERFACE);
         return false;
     }
     klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
diff --git a/system/vl.c b/system/vl.c
index f103532a9a1..4a370da624a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1184,7 +1184,8 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else if (nonempty_str(gen_id)) {
-        if (!fw_cfg_add_file_from_generator(fw_cfg, name, gen_id, errp)) {
+        if (!fw_cfg_add_file_from_generator(fw_cfg, object_get_objects_root(),
+                                            gen_id, name, errp)) {
             return -1;
         }
         return 0;
-- 
2.45.2


