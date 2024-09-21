Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C30CF9C68
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 07:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sruZZ-0003fa-JL; Sat, 21 Sep 2024 03:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hal.martin@gmail.com>)
 id 1sruZW-0003dN-Ll
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 03:30:26 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hal.martin@gmail.com>)
 id 1sruZU-0004JM-I1
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 03:30:26 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f753375394so20826641fa.0
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726903820; x=1727508620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0Wxs7kBfWOJ5yX+nxciaC89wdOb1WYHBZYFrLIkU0c=;
 b=U2cz8mGgyc8kEfdMBVUnpgJhLPfqHse2qt4IUEnz2+2OzEF0MipMZedFGKbPBL+dLJ
 OwOdsBgmVGTh7kFG1gd5wZHpB+CJ6vp03VUyyrGxISYQmpYTtJ1Qg0JatPElqkRK6dj+
 Rnv2gDvjVq1+OyXR7VhBRhn3jLA/xp3m4LPDpo0murNpaVtGM4jm6j8jaB/Yh/pY/Isi
 LnkcLdUMHgQ4ymT5oDVcUWuaF3c9X0eOl7g7J6H5o3ATHV/jB8FtzKVXzLjK24FH3ojg
 JpmyYEhQ0NgK91AWe2a0YLb0bFAxQK4UM8e4cONxNHaVdefHy1qzaId6QlyG8gcOK2pB
 TOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726903820; x=1727508620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0Wxs7kBfWOJ5yX+nxciaC89wdOb1WYHBZYFrLIkU0c=;
 b=T8TPilONJRSYIb7v2eLeso5Zbpktp2yNE3UA+067TYVnQ0mEwC0oeRLvnggA6AY/Bb
 qX+2tBqzcWar6v4JMFGXuxYxPbt2HYl0kFfsNKjUNKJnukZ+W0h2VWGZPcRuS3NQeOqX
 g5lwNpiLNmbig651xctpS+oo2atG6y8MRUIIuklk7c/1wEg/46bz0vGTs/ncJXbR+sbG
 73v/f7OZxFpSnPf1Od1ikUgD/sFtbisBItEDI6ommDc8FqAaxwZL0C5U9ZmEuu5yNiyP
 d+MP9IaziyVSX7IaQ2ckL7Aj/28iQ+VOtS6OYwNI1wBRr6/Et8yTNIWA3kWBOjkiW7He
 Mxxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVH9Bue7zwLYyfcCi9sO6ouVQ389BlDSm776kC42sqjR8U9HT6XKYv19RVZXHEr1Jxiq/zTMed7xpL@nongnu.org
X-Gm-Message-State: AOJu0Yxzx+9XCDlnhcKB/j1eknMGsE7YcG+ENZ8QwWmN2am//pyR4DPd
 b06AxpMBu8AUNaSJUl9fk8MSoCms4SnuDpsGnAyuWNYmmy76djYs
X-Google-Smtp-Source: AGHT+IEGlBo5nanFXphY7i36DysS0rtnC8Jcu3qMLF5iLgKlCPf+Lbdv96iy6HKfyC2G9Oqn0i/dUw==
X-Received: by 2002:a2e:be0e:0:b0:2f7:7cc3:306 with SMTP id
 38308e7fff4ca-2f7cc366f4emr31073721fa.17.1726903819720; 
 Sat, 21 Sep 2024 00:30:19 -0700 (PDT)
Received: from fitlet2.primaryno.de ([185.154.111.57])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f79d2e1eb5sm21204591fa.27.2024.09.21.00.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2024 00:30:19 -0700 (PDT)
From: Hal Martin <hal.martin@gmail.com>
To: mst@redhat.com
Cc: Hal Martin <hal.martin@gmail.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, anisinha@redhat.com
Subject: [PATCH v2] hw/smbios: support for type 7 (cache information)
Date: Sat, 21 Sep 2024 07:29:55 +0000
Message-Id: <20240921072955.7150-1-hal.martin@gmail.com>
X-Mailer: git-send-email 2.38.5
In-Reply-To: <20240911071848-mutt-send-email-mst@kernel.org>
References: <20240911071848-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=hal.martin@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch adds support for SMBIOS type 7 (Cache Information) to qemu.

level: cache level (1-8)
size: cache size in bytes

Example usage:
-smbios type=7,level=1,size=0x8000

Signed-off-by: Hal Martin <hal.martin@gmail.com>
---
 hw/smbios/smbios.c           | 64 ++++++++++++++++++++++++++++++++++++
 include/hw/firmware/smbios.h | 18 ++++++++++
 qemu-options.hx              |  2 ++
 3 files changed, 84 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index a394514264..b71d5b0a92 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -83,6 +83,12 @@ static struct {
     .processor_family = 0x01, /* Other */
 };
 
+struct type7_instance {
+    uint16_t level, size;
+    QTAILQ_ENTRY(type7_instance) next;
+};
+static QTAILQ_HEAD(, type7_instance) type7 = QTAILQ_HEAD_INITIALIZER(type7);
+
 struct type8_instance {
     const char *internal_reference, *external_reference;
     uint8_t connector_type, port_type;
@@ -330,6 +336,23 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
     { /* end of list */ }
 };
 
+static const QemuOptDesc qemu_smbios_type7_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },{
+        .name = "level",
+        .type = QEMU_OPT_NUMBER,
+        .help = "cache level",
+    },{
+        .name = "size",
+        .type = QEMU_OPT_NUMBER,
+        .help = "cache size",
+    },
+    { /* end of list */ }
+};
+
 static const QemuOptDesc qemu_smbios_type8_opts[] = {
     {
         .name = "type",
@@ -733,6 +756,33 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
     smbios_type4_count++;
 }
 
+static void smbios_build_type_7_table(void)
+{
+    unsigned instance = 0;
+    struct type7_instance *t7;
+    char designation[20];
+
+    QTAILQ_FOREACH(t7, &type7, next) {
+        SMBIOS_BUILD_TABLE_PRE(7, T0_BASE + instance, true);
+        sprintf(designation, "CPU Internal L%d", t7->level);
+        SMBIOS_TABLE_SET_STR(7, socket_designation, designation);
+        /* cache not socketed, enabled, write back */
+        t->cache_configuration =  0x180 | ((t7->level) - 1);
+        t->installed_size =  t7->size;
+        t->maximum_cache_size =  t7->size; /* set max to installed */
+        t->supported_sram_type = 0x10; /* pipeline burst */
+        t->current_sram_type = 0x10; /* pipeline burst */
+        t->cache_speed = 0x1; /* 1 ns */
+        t->error_correction_type = 0x6; /* Multi-bit ECC */
+        t->system_cache_type = 0x05; /* Unified */
+        t->associativity = 0x6; /* Fully Associative */
+        t->maximum_cache_size2 = t7->size;
+        t->installed_cache_size2 = t7->size;
+        SMBIOS_BUILD_TABLE_POST;
+        instance++;
+    }
+}
+
 static void smbios_build_type_8_table(void)
 {
     unsigned instance = 0;
@@ -1120,6 +1170,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
         }
     }
 
+    smbios_build_type_7_table();
     smbios_build_type_8_table();
     smbios_build_type_9_table(errp);
     smbios_build_type_11_table();
@@ -1478,6 +1529,19 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
                            UINT16_MAX);
             }
             return;
+        case 7:
+            if (!qemu_opts_validate(opts, qemu_smbios_type7_opts, errp)) {
+                return;
+            }
+            struct type7_instance *t7_i;
+            t7_i = g_new0(struct type7_instance, 1);
+            t7_i->level = qemu_opt_get_number(opts, "level", 0x0);
+            t7_i->size = qemu_opt_get_number(opts, "size", 0x0200);
+            /* Only cache levels 1-8 are permitted */
+            if (t7_i->level > 0 && t7_i->level < 9) {
+                QTAILQ_INSERT_TAIL(&type7, t7_i, next);
+            }
+            return;
         case 8:
             if (!qemu_opts_validate(opts, qemu_smbios_type8_opts, errp)) {
                 return;
diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
index f066ab7262..1ea1506b46 100644
--- a/include/hw/firmware/smbios.h
+++ b/include/hw/firmware/smbios.h
@@ -220,6 +220,24 @@ typedef enum smbios_type_4_len_ver {
     SMBIOS_TYPE_4_LEN_V30 = offsetofend(struct smbios_type_4, thread_count2),
 } smbios_type_4_len_ver;
 
+/* SMBIOS type 7 - Cache Information (v2.0+) */
+struct smbios_type_7 {
+    struct smbios_structure_header header;
+    uint8_t socket_designation;
+    uint16_t cache_configuration;
+    uint16_t maximum_cache_size;
+    uint16_t installed_size;
+    uint16_t supported_sram_type;
+    uint16_t current_sram_type;
+    uint8_t cache_speed;
+    uint8_t error_correction_type;
+    uint8_t system_cache_type;
+    uint8_t associativity;
+    uint32_t maximum_cache_size2;
+    uint32_t installed_cache_size2;
+    /* contained elements follow */
+} QEMU_PACKED;
+
 /* SMBIOS type 8 - Port Connector Information */
 struct smbios_type_8 {
     struct smbios_structure_header header;
diff --git a/qemu-options.hx b/qemu-options.hx
index d94e2cbbae..21c05821d5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2706,6 +2706,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
     "              [,processor-family=%d][,processor-id=%d]\n"
     "                specify SMBIOS type 4 fields\n"
+    "-smbios type=7[,level=%d][,size=%d]\n"
+    "                specify SMBIOS type 7 fields\n"
     "-smbios type=8[,external_reference=str][,internal_reference=str][,connector_type=%d][,port_type=%d]\n"
     "                specify SMBIOS type 8 fields\n"
     "-smbios type=11[,value=str][,path=filename]\n"
-- 
2.42.0


