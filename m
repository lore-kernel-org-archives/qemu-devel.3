Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BE3C30658
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgk6-000745-Pe; Thu, 27 Jun 2024 00:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMeSi-0001GZ-Qa
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 22:02:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMeSh-0007JE-A1
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 22:02:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f9b523a15cso9368055ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 19:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719453729; x=1720058529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V7UUez2Ng0Gq7CrOp33lCArvsTqH1g6sRqOcOy9IZEA=;
 b=jC9pMwOJCjCBqmjliUmlTG9+ydj1SNlp4sFMDJTd7dhm3eQnceZxtBLgbpitPR6GNz
 /5JBXT9RGsf42+5pZ8Z/9829YW3/04uKICBPRPkRDhPfMswNJFrx2oMa7ta/2iR1eT8Z
 rB+wHtRAMmCYXO3HN3jqX/QBtL6o1BoCYNgO5oMoUS0g+HUZiJs+37hi1wHCglDa4clX
 q7okCK4HaJ6OpUGVJj4+qIkRFxVFz5JVqa0PZNfdTpQvyy0dGH7vd9HmSfd0/TMvFuc+
 cIuVU/COk3tGxJ3mssnFxBfHcUI/FlCUq7iHHFxwEC4pQtlGGZlN1XVKEwLHojNwWvPh
 BIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719453729; x=1720058529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7UUez2Ng0Gq7CrOp33lCArvsTqH1g6sRqOcOy9IZEA=;
 b=eOUWLPJcyCuoxHOCtsgCWebR/r6ff4abvybxnluCg/HtzZctYQWt11pJ5OJiJZRR21
 oHNbscAgjh9RpIGddCJMeyhP0+SZRwscV7aCFmGtXtO/dDVyVGN2fxZcj5HAJUYDnB+N
 t9fSF0JTqlvstWLAH4lC/6OimWY68wgU3hCmH6ta/BELufrRsqDGHZpC2csR90Qf0Ug4
 QWf7bW5soy+r+toAQDhXsQGwx5EItZbCT8zl/QbA0cyzxRKfRX/EEMbeZv4c8m98KveW
 x0H2fTnEUq3n//1omtzYwnY4IfpXgAPbjjpp29Ck+iVck/Q/ylkdRNUuaL+huiN4SKSs
 vEag==
X-Gm-Message-State: AOJu0YwbgE5K6XC7IGKH1b28hSYToBONEAktrbBxY6p5Pd+ciV9O8fAR
 LapREBYIP+gksaD1faog00wa+Pg4gZfJq2Rxewdr8p6nmGVy33W2iZV6gaF3
X-Google-Smtp-Source: AGHT+IFEbTdDntgxRcIODv7RAmIbM3KUuCBadPhiRCKj5m6UtM2Y2sCNnv5uoLDTNfmd31Rdr34tNg==
X-Received: by 2002:a17:903:1104:b0:1fa:97ec:3a4 with SMTP id
 d9443c01a7336-1fa97ec057emr34073075ad.8.1719453729466; 
 Wed, 26 Jun 2024 19:02:09 -0700 (PDT)
Received: from localhost ([136.27.11.53]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac9b11d1sm1553565ad.267.2024.06.26.19.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 19:02:09 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH] hw/core/loader: allow loading larger ROMs
Date: Wed, 26 Jun 2024 19:02:07 -0700
Message-ID: <20240627020207.630125-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Jun 2024 00:28:17 -0400
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
instead failing if all bytes are not read at once. This change wraps the
read() syscall in a do/while loop to ensure all bytes of the ROM are read.

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
---
 hw/core/loader.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2f8105d7de..afa26dccb1 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1075,7 +1075,7 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
-    ssize_t rc;
+    ssize_t rc, sz = 0;
     int fd = -1;
     char devpath[100];
 
@@ -1116,12 +1116,15 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
     rom->datasize = rom->romsize;
     rom->data     = g_malloc0(rom->datasize);
     lseek(fd, 0, SEEK_SET);
-    rc = read(fd, rom->data, rom->datasize);
-    if (rc != rom->datasize) {
-        fprintf(stderr, "rom: file %-20s: read error: rc=%zd (expected %zd)\n",
-                rom->name, rc, rom->datasize);
-        goto err;
-    }
+    do {
+        rc = read(fd, &rom->data[sz], rom->datasize);
+        if (rc == -1) {
+                fprintf(stderr, "rom: file %-20s: read error: %s\n",
+                        rom->name, strerror(errno));
+                goto err;
+        }
+        sz += rc;
+    } while (sz != rom->datasize);
     close(fd);
     rom_insert(rom);
     if (rom->fw_file && fw_cfg) {
-- 
2.45.2


