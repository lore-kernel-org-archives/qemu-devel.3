Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138DAE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF8P-00037l-5y; Fri, 13 Dec 2024 18:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF86-0002hu-0s
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF84-00030J-8t
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so24327765e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132686; x=1734737486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BIyU7zMqnqhErJ1i6ewmJ4DGVFapxFjoG/3YA/JeJ8=;
 b=DB73Xybw7qo3NB+ywl/U1uhA+ntE3DSurTd8C+8wbHFFl7UmDYRIpZx7eCJae2ZK1i
 XO9mW6M4bosym9b/47Y1keZFalaTJxpMP/boRQgKgizOT+8sgxeBr9Uf5MSKaGmiNiif
 7kK6urjZqINlCovNQSNzt2OKJyM7f1t7LNsy/ha2lSTAnzK9Q8TR+gj2qHtOA5d+7/mK
 t5OJKDu2MOfveUNhDI4asBdbxu9vRdZV8CzusViZP1zn94a+0yxH3tP1Lbl/D5BiNjdF
 67PayWR1pmfsWzqDoFs7Vev1yW6QZVztd+jY/WhsPJHVZ4wnL32VvtyjbKPhEIJNq9fZ
 ANCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132686; x=1734737486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BIyU7zMqnqhErJ1i6ewmJ4DGVFapxFjoG/3YA/JeJ8=;
 b=Y9DIgcR6vdgNrkLx4qLROesJwQHDDn1/3hQPsHYGnYaPNH07Y9EyDAAdU7qskdZ1mW
 Lc8IuBluI3HPqApTGhYTLFyJM73Wmt1SLMvZ0HpRQgwK0lMwR2ugGxa9fFEhY39714ko
 1GMEemCVL5zzPqAUers6xTfHNSmbwrGgIyTt/Tq/ZfKiE9pB+BLqbUJAgQt/YzUmC9za
 deXMo+K3T2n8MA02h4oNgGSBjOfoLpwfAUIXvRAYrNEay059BfQIXJWi2V895NHPFR8k
 gi3EK2qSBgsGTQY124A+lzvbRNjAQFE6p8pnCgdJn1HgDfmOxFge5Qu/CcnKuSM/iTvR
 Z9/w==
X-Gm-Message-State: AOJu0Yx7/Gyz+wRvP/Ds6T8x5FwbotEKsJfBcRtsQKLlWErIDh08IVdJ
 9UdNkvpc3TSzNHwS+YkvqAFwakSC0dr/mgV9DdZj9UubUfahtLhIBvsxgfhbAC87yFJjs3spezF
 uhyQ=
X-Gm-Gg: ASbGncvhGD+7jwi5QedIds+Qz+FCOs5DCTVrvuxYduzEoLWrogdsuWxUHsOT8uNOf8l
 isFeXe3iXfk9XJrbe5SqpKzV25D8t7pXVD7mEwIsz2QReQ5dzhp7Jbkz3QlTQR7qMJbl/PATJn+
 nIhRzCvRWO1A9p0dG8kDVCqY4Z2R0H8UVZeRAokK35l7jQWVDLsxqSJWml6GCVIR8Dp4dKBfEfq
 nMmrI9MtWs+awjLsuVAguxZsES2OsyYzqHAZrfcrb5Yn6T6V+ZiZ+q57r0KtUHTuNWmBDwi5pI2
 pQhZNQ==
X-Google-Smtp-Source: AGHT+IEppK21NcUq/KApsIWNVb+6PipzoBmSZ4xqGjuMtZW5rDmTIr+K+btrO0nOSG+zll9gurTqPA==
X-Received: by 2002:a05:6000:786:b0:385:e394:37ea with SMTP id
 ffacd0b85a97d-38880acdab9mr3216004f8f.22.1734132686459; 
 Fri, 13 Dec 2024 15:31:26 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c806086dsm804587f8f.91.2024.12.13.15.31.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/20] hw/nvram/fw_cfg: Rename
 fw_cfg_add_[file]_from_generator()
Date: Sat, 14 Dec 2024 00:30:40 +0100
Message-ID: <20241213233055.39574-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

fw_cfg_add_from_generator() is adding a 'file' entry,
so rename as fw_cfg_add_file_from_generator() for
clarity. Besides, we might introduce generators for
other entry types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241206181352.6836-2-philmd@linaro.org>
---
 include/hw/nvram/fw_cfg.h | 6 +++---
 hw/nvram/fw_cfg.c         | 4 ++--
 system/vl.c               | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index fa426776192..14e68966c59 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -291,7 +291,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
                          size_t len);
 
 /**
- * fw_cfg_add_from_generator:
+ * fw_cfg_add_file_from_generator:
  * @s: fw_cfg device being modified
  * @filename: name of new fw_cfg file item
  * @gen_id: name of object implementing FW_CFG_DATA_GENERATOR interface
@@ -307,8 +307,8 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename, void *data,
  *
  * Returns: %true on success, %false on error.
  */
-bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
-                               const char *gen_id, Error **errp);
+bool fw_cfg_add_file_from_generator(FWCfgState *s, const char *filename,
+                                    const char *gen_id, Error **errp);
 
 /**
  * fw_cfg_add_extra_pci_roots:
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b644577734c..fe3b86135a7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1027,8 +1027,8 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
     return NULL;
 }
 
-bool fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
-                               const char *gen_id, Error **errp)
+bool fw_cfg_add_file_from_generator(FWCfgState *s, const char *filename,
+                                    const char *gen_id, Error **errp)
 {
     FWCfgDataGeneratorClass *klass;
     GByteArray *array;
diff --git a/system/vl.c b/system/vl.c
index 2f855d83fbb..f103532a9a1 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1184,7 +1184,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else if (nonempty_str(gen_id)) {
-        if (!fw_cfg_add_from_generator(fw_cfg, name, gen_id, errp)) {
+        if (!fw_cfg_add_file_from_generator(fw_cfg, name, gen_id, errp)) {
             return -1;
         }
         return 0;
-- 
2.45.2


