Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05272E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF8N-000324-74; Fri, 13 Dec 2024 18:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8C-0002kP-6y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:40 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8A-000317-Fm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1249118f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132692; x=1734737492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzHeNsZnxQi+It9LDPqSmZfWCtnOxBbi6olOAYenQV4=;
 b=QK8WgHlZQmTjj2Tq6aYEGFk9tNsRTXlV4L3CMSBqr6uZeRqQ7zsYnm5oFRJVw+JVZ4
 HSGcbW4NImBXnc1JxBFIoe20OOunClS0qW7SUcxrXX8XC7uqPLa3kDYa6H+5+xKz6iW3
 OduAbKrNP0T2h4WI6F9kv/hWb+Bu7iwoGCbeOhX9xEABZnLyyiOlCdenwbWxyQAyl9zU
 vUUXSSuRtsPRanA6Q+iWgBGL8imyFnB+as4snwHAdTX8fPHzIcOU9O6WwA3qGa0S6FyO
 dxneX2syAD/DkiGVMkDllnC/3pYzkfYAJ/a4jSX5/DFDp3SvlQC2fM17JVXBL5PTWZoD
 Qc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132692; x=1734737492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzHeNsZnxQi+It9LDPqSmZfWCtnOxBbi6olOAYenQV4=;
 b=xPr5Ho71afzFrz38gnuRLeBVttbhosS/tchNLAIeOeGd/rxbOgsEUiLR+NTTStV6Fx
 GUaokwc6X9ILIEIQIcVyKxUtXvHNJJb8TZHfZjVADxxUqKysMMHVV9pwabmeXPkcfF2+
 1o33V1Z04dtCWhSmyqODGz8DB/Gc5LummGMdMtGgBRsGXl07V3Ay22J7EZ+R7eKW00zP
 aBJnlf6V7xY/DNuMA5WdW43aoB9TDIFNaY3uhz4ybJ8NLOnbPkUBrT4Uk91WRMingE2n
 6v/+iWJzHUVeSvLBh1BettI/W6xH0QFKq/V4SihoHGTtaKUrljWIisep2NCRUUZ41BOF
 P7KQ==
X-Gm-Message-State: AOJu0Yz75Wt7+VycEbtCzAVtimSdgMscsoACy4gzu1svKnvdWnKZieRx
 GiPRXKCMSxG8W91R0T3spMzM2b1sb8pchfJALsG6nGadKfOTSgHRT8IUukROGEJIXrLdlrF5yB4
 +PbM=
X-Gm-Gg: ASbGncup+fMSfasuyn6nReflNJd5X6PP0N1E95JpzR6CzsvDQoECqmKc/OjCkxuDE36
 HRw6KT75MhWFt1b9Iy+VooxsIh4W6jkNajs0QSEaU5VrWrwfFFM2x7elaVFwHKWWi8joBkdaRR0
 XNLpTFk94O91Z11zpdHl4g1C1q/usDC2jFxnkQ95UPqA56tKxnFoeotFnFmxtDG3sGohoyfwBnt
 VhyOX2QLQ76ffhMr6tgG/hfjBAGgy3Txq9AoTtHV64R/ZdXnUG4MJ1b3bilaoMUwB/+yUf4wzQ1
 ERgjWA==
X-Google-Smtp-Source: AGHT+IHjBslLDLMU0bNikTKcI4izg0tmyn+2Bt/EJJxJGAd9F8ZLEcI6ddUzf2A/253O7lHdq2O7+w==
X-Received: by 2002:a5d:5f8b:0:b0:385:fc97:9c63 with SMTP id
 ffacd0b85a97d-38880ac4dddmr3371282f8f.9.1734132691768; 
 Fri, 13 Dec 2024 15:31:31 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801bb00sm820086f8f.62.2024.12.13.15.31.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 06/20] hw/nvram/fw_cfg: Pass QOM parent to
 fw_cfg_add_file_from_generator()
Date: Sat, 14 Dec 2024 00:30:41 +0100
Message-ID: <20241213233055.39574-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241206181352.6836-3-philmd@linaro.org>
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


