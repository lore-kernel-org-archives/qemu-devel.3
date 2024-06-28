Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEFEC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 01:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN0lb-0004cU-Ed; Thu, 27 Jun 2024 21:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sN0lZ-0004c8-85
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 21:51:09 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sN0lX-0007uQ-Mg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 21:51:09 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d55ed47cc6so71260b6e.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719539465; x=1720144265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hIsxbBapIyHOOkTI4zsd8EUZ8OdiGNTjF94+afrWNJo=;
 b=mKLTztPnroYx0yaU34T/W5GuoW7MuhND/BaCHnAGn9bQcMXgHy4TRCNuMtjqWMgkmR
 TOCjZHWibse8IMbRnrThmGeF1vE8dr0l34rpgHsFanQWqw9tzkHTvI9wON3kkVWSmjV1
 9lh3znfqLLv6OzN9RBAzxdQ+T1NmofvRZe0wVnCikLXkFKLen1vH5zoOwXFmIHQdmW4u
 j8Dk62Ehb93IrpitDz6duqMRAwY2adryyf4K0Esmcs/ub7NbBB9VOA4FiHi4k7pZqJgD
 knBKDQy12Vbz1DzSCbBBAJJzQdb3MRuGOAnYglU+laoK5l18OKjD9UMGMsOxP+Z2hgK4
 jHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719539465; x=1720144265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hIsxbBapIyHOOkTI4zsd8EUZ8OdiGNTjF94+afrWNJo=;
 b=rxeCQ0yY21Pc5SJmrKNZGBnP2lmWTQwRGkyqmynW16OY/rbQw4JqE5BSVSki8FTWkn
 K5Ge4a7JQuHVZBjvqIad4PduD9ap94uLWMs6ZFphtpAKYHAq3qZJ11g3kfWqWDkKo6+M
 2euxMRwmA8IVSoOjablkQoM0K1NCy6iXjZVQMZ3yb+Duw/fD34h9td8GIPECVibrh0nC
 zoNd0gyAxTRAw3pxXxVkZgSQvupefLQM7WHIPhTYHO3TVcVWl4WxpipTAZeWBLxY3UKh
 k3P4AUAVk4PVptcouSKy62lqFXr9ssOgtC44ILdVQ2vaWghr6L7IaTC40hlH6JCyklR+
 b9vg==
X-Gm-Message-State: AOJu0YwklvW9wsZbzl0+2Y57dwbfOZVZOBGxLcsfYu2ue8BKnQtQ2rQS
 U1XWImsfufU+uryO9yZSVa3xXB7AR2KmlnnDa8UezHTkpPnhpuE2bL0i9Tl/
X-Google-Smtp-Source: AGHT+IHZqiyfyE68aBfi7ZlkOjHxbZuuypWtrZ05NltJ35zwpqL6DajdQh5pVP98+UQaZMhUrdC7UQ==
X-Received: by 2002:a05:6808:120d:b0:3d5:47bc:14db with SMTP id
 5614622812f47-3d547bc1742mr16055372b6e.22.1719539465131; 
 Thu, 27 Jun 2024 18:51:05 -0700 (PDT)
Received: from localhost ([136.27.11.53]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70801e63abcsm391648b3a.2.2024.06.27.18.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 18:51:04 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: yaoxt.fnst@fujitsu.com,
	Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v3] hw/core/loader: allow loading larger ROMs
Date: Thu, 27 Jun 2024 18:50:36 -0700
Message-ID: <20240628015036.1815838-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The read() syscall is not guaranteed to return all data from a file. The
default ROM loader implementation currently does not take this into account,
instead failing if all bytes are not read at once. This change loads the ROM
using load_image_size() instead, which correctly reads all data using
multiple calls to read(). Also, the ROM size is now determined using the
get_image_size() function rather than using manual lseek().

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
---
 hw/core/loader.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2f8105d7de..c2c61158f1 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1076,7 +1076,6 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
     ssize_t rc;
-    int fd = -1;
     char devpath[100];
 
     if (as && mr) {
@@ -1094,19 +1093,12 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
         rom->path = g_strdup(file);
     }
 
-    fd = open(rom->path, O_RDONLY | O_BINARY);
-    if (fd == -1) {
-        fprintf(stderr, "Could not open option rom '%s': %s\n",
-                rom->path, strerror(errno));
-        goto err;
-    }
-
     if (fw_dir) {
         rom->fw_dir  = g_strdup(fw_dir);
         rom->fw_file = g_strdup(file);
     }
     rom->addr     = addr;
-    rom->romsize  = lseek(fd, 0, SEEK_END);
+    rom->romsize  = get_image_size(rom->path);
     if (rom->romsize == -1) {
         fprintf(stderr, "rom: file %-20s: get size error: %s\n",
                 rom->name, strerror(errno));
@@ -1115,14 +1107,12 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
 
     rom->datasize = rom->romsize;
     rom->data     = g_malloc0(rom->datasize);
-    lseek(fd, 0, SEEK_SET);
-    rc = read(fd, rom->data, rom->datasize);
+    rc = load_image_size(rom->path, rom->data, rom->datasize);
     if (rc != rom->datasize) {
         fprintf(stderr, "rom: file %-20s: read error: rc=%zd (expected %zd)\n",
                 rom->name, rc, rom->datasize);
         goto err;
     }
-    close(fd);
     rom_insert(rom);
     if (rom->fw_file && fw_cfg) {
         const char *basename;
@@ -1159,9 +1149,6 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
     return 0;
 
 err:
-    if (fd != -1)
-        close(fd);
-
     rom_free(rom);
     return -1;
 }
-- 
2.45.2


