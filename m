Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BFBE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5oQ-0005IN-H8; Fri, 13 Dec 2024 08:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5ny-0005AL-7i
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:11 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5nv-00014y-Cm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:05 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1299389f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096840; x=1734701640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WlswgE/eUO5zmvvMPBofBLx3raLRd7GBRUggU9AjFY8=;
 b=IjtpxrzuxdaEX3fkeS7JbkX83ZVBNxAQSPxvsRLm3MpaXfaGj/BRo6fmcH58vSWHm5
 qcN4Xj82oIKb/0kZUjMj0KfzE7u3jYmjlQ9UcTjgJoRLyrLQN5koQd1Pjit6ZsIyoqDr
 FCjZzw/NG32/NDNev+jEvoU2DFXoT4dQH5bGRmW7V+yzVbn3/kWjgyyDf8PPlUrUw2bA
 8DoPgMutmrWQ1ydQ+uPBiF6+R9IM5v1kGd1E+gbaNx1kFiRZii+eUswfcU30aINvloul
 d6vOpDgp5wLzXM4UriXKXmT9lJk5Xn6z/ttpkOc9jF8Z8VDk+mvARFmn9tZY1WtShKW8
 g02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096840; x=1734701640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlswgE/eUO5zmvvMPBofBLx3raLRd7GBRUggU9AjFY8=;
 b=Q7EyP+FUfQafPiWvfZIYBv63h0KSNxy6ZAdafcd5CVDzI+Zzhhp3m2si98VCBZjHEV
 DSZCnW6RQDvq6Xlm4rtDmgz/0B3qXazsQ9U1g+yqsErt00V9jFvJoiJ5dsITVvx+sp82
 Oy5nNBe0NMLTO/Hpccn/gLnBRvI5Ok3ADSNDSQ0qHxXb1epB8ya5KfPBuXQ7/TWgEncU
 Du7Gt09wDT2l7edTDKd10owGZFS3Eo3aOWQv6eQT8JJQWkSGNGddBckPtYigyKaoTKho
 RkRP3QxbPhINjgSlijQPmXuG951n6essyFWBTMw7nWFam/C8aE3R6QvbWyOuBMahVdhv
 RAgA==
X-Gm-Message-State: AOJu0YyoRoUhHGP+Hpt7ywRZi/mIukwWIHBZVud5qxgxj2ze2DrOLwJN
 /foGtR7Id8xxA9W6NVE+xDyNnFnMtRJr0rxuK1ZA9uXMluSZ4qowJdqD29e6ljGzFQnBfyFvKPT
 j
X-Gm-Gg: ASbGncveEDiXFyRInQE775ymF/vLFeMKF87kXb1pkU9Nm37YywZVCr4ffYXtoAO9+Ge
 aJqae2to2cW9YdzvXyK4a52S9M2G7IFo76XqtjO2dYJJVj8rPIjaaFe9XmxH65G5mp/f5GlgBr+
 HSXgdFRm0kCciC/3p3jZDgt+zlQsVdVLPtK3WXH/I439+OYc5C+KgDCL6VLg0bYzQ2UeQRV57KT
 YtZx2xWwPB7dloiFQx5cZV7tHE1wydEhJDUIxJRIM8C8ZkRhR/0n9i2tJaeCNwQ8wxb40FFbTJT
 AzuSMGVLpqZyMHlZUng4UAfih4BHb7+aM7sP
X-Google-Smtp-Source: AGHT+IGV9gZYYybQXcMBoG+tUlEWZXZdxsf0Ak6kGnWW1Jywsdv5abqYvY/qrcHoLxGXaPhpQsTm6g==
X-Received: by 2002:a05:6000:4616:b0:385:dedb:a148 with SMTP id
 ffacd0b85a97d-3888e0ac4f4mr1863536f8f.46.1734096839885; 
 Fri, 13 Dec 2024 05:33:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436255531dasm48965815e9.8.2024.12.13.05.33.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:33:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/7] hw/nvram/fw_cfg: Rename
 fw_cfg_add_[file]_from_generator()
Date: Fri, 13 Dec 2024 14:33:46 +0100
Message-ID: <20241213133352.10915-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
References: <20241213133352.10915-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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


