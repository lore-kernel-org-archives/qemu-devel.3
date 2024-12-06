Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110E8E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcqD-0001Ix-Fr; Fri, 06 Dec 2024 13:14:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqB-0001Im-71
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:11 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcq9-0005OR-EI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:10 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385dece873cso1186818f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508847; x=1734113647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0PBZR23Po9ToAnafigq0MA6TfCR66KP6lO73kHOKBI=;
 b=DMRIwzRNuVIo5SvL5RXpIVbv/ebsur9xmeVa+bKXdZ5li8hks2yOISX/8eTqD1nlWn
 yTvEUIfcqUOS9FriMltWGSMuDWy+EfR3DuybGxCSm16EfClObJwN/YlzcVB8s6qJcr3O
 c+CBhTO1B7y4w7dzyiXZXVej8ilAFNNW4SKuBaVo6sJNRknomXvV7Rm4x0jLW6snXI2B
 VXiuB0xn16SJz8Adt5UKM7cuHPtN6Z/+zt/h8j5FPJi32wo/ytvtqtfhOrnJXWM2TVyZ
 woroCq2w+ZMedtA5WAYoXxNo+78PuDrKgZa/ncHEzCoHzi582hTYNXEPM5/wWmsxme6h
 Hc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508847; x=1734113647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A0PBZR23Po9ToAnafigq0MA6TfCR66KP6lO73kHOKBI=;
 b=Lj/KBxA2LowIBfV4ax2L5bSikqmp0o5/wgu5EdlZpS0YfuatJ6r8etywbYbtqdfJNP
 /d3QAUlxJKZBXhJj1Uvnc2dPseqTIf3A/qRQYc85PjFwG/KEOR1dQf1SzLz8umcyoMOX
 w74qZ4TswHn2v1IllX+JpadQ/NOy2xJLn8n8J0IZdQKJXI+RqZh65DD0iXqehgIwV+LI
 iKGO+x5p7MeZEFTSUKJWNS12ii8+NFevfKKamy4rn4aVX4Zp5+Nu76Ar24gFBCAe4/Ok
 EV4dMttz2+ltjvQWgiPpNFTkHw6cfkR0R5h4MJ+buUIyM9PwmddwzCkh31MJ+FLk9Xnl
 TJ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUcsEuPpzksODw/fDntdZsQpBh24F92qh66nkelFv7bFV/OHNNz3dGGF1oxnheJAz8kMu24ncSu7oA@nongnu.org
X-Gm-Message-State: AOJu0YxVbjvtQUD8sIrge6bHFisaPEwFy9ICqoss5NVJCDPBp5Fs4+OQ
 M0SRGQB3Tj6CwwPqi7Gd0JqnylqBAd1V/XhVN0ePK/gUMutfPOEIhpKhnQ2e6xM=
X-Gm-Gg: ASbGncsjT5fSYeIrKpoVrm7wgwTSNsTUEdV58ZmplixRdayQVZNC4pbokGuc6OMFu6p
 5UKsLabYRkJ1CWeVkk97b75RP/+AwqKLetvhtPFq3L1Oo+Ywrg+084QQewZ9Ad6pVZ8w3q1ZAKY
 3uA3i+Z6nHH+l8JRwwSnLim8JKJO/IaXH5gROO5bdFWSGQtKsqQzUXVLcoI16hs8GmnsP0CKFkQ
 GmonHRhBM1Vg3fLQ2ESwnHDJi1nTr1WSiuiQGjfFROxDI8yXGnsT2w82YJ022+WSao=
X-Google-Smtp-Source: AGHT+IGSywxEn3NkVJzw7GgsndWeufu5axp6NpAzKXr1O4Tw0ePmeockps3DpUR2efWMOuNPLCGQ5w==
X-Received: by 2002:a05:6000:1846:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-3862b39759fmr3099375f8f.35.1733508847568; 
 Fri, 06 Dec 2024 10:14:07 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3862d05d82esm2147630f8f.40.2024.12.06.10.14.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 10:14:06 -0800 (PST)
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
Subject: [PATCH 1/6] hw/nvram/fw_cfg: Rename fw_cfg_add_[file]_from_generator()
Date: Fri,  6 Dec 2024 19:13:47 +0100
Message-ID: <20241206181352.6836-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206181352.6836-1-philmd@linaro.org>
References: <20241206181352.6836-1-philmd@linaro.org>
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

fw_cfg_add_from_generator() is adding a 'file' entry,
so rename as fw_cfg_add_file_from_generator() for
clarity. Besides, we might introduce generators for
other entry types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


