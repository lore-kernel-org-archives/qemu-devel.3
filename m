Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB54C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 00:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMzwl-0004dW-Po; Thu, 27 Jun 2024 20:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMzwj-0004d9-BH
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 20:58:37 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sMzwg-00064o-Fe
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 20:58:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6c5bcb8e8edso33169a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719536313; x=1720141113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OngnKGGfUguIAEUGMPPSK1wlKkUjWQZBpJxdshqqNo4=;
 b=SaN6p0b3wvkFY9CwFs1Za4yS2GoolmuQos5aCFkGxESrWnnBtOQKWbF2lgZlOYAMoi
 jHoivhT9x8PPLGLXKmBrHpwl1Vih15Uz842xNFsWqWRnDgsLRC1ShGRpj7p1ifrUZLuI
 GQ5vpLfV46wYOZ5w6rDc8s/XVGWJ4ou68TJiUyGCDjgyuXA0YGYy6B4wBj0IEC9jQFYX
 dyyiky1EiKGVEMfYtM7DYNyoDJwDtTyTKjTngA+90Qn0apGbpdYITEEodlR3KRfvJ/i5
 lHkM+/IOWcoWOMVtR8LthNKnwdlbp55axFsa60QM+cVOY7rSCvbN54xBOwBESmfxtsHz
 5Q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719536313; x=1720141113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OngnKGGfUguIAEUGMPPSK1wlKkUjWQZBpJxdshqqNo4=;
 b=TeLRfE/qMRGm1FiP1CmV/jEd21TBgDSEFuU6/7dZ0/t3rxjOkw0yEHkPoAh5Tts2qN
 NJG0Xwt3uKH+WOJ2VdWxvj04RwX9eIyVdtZL4Btx0ydStleDGPH88xnpKeJt4VSYSQC3
 o7mTpUFOrtvNHQEEbm4S6s3/+jgV+fMr8r4yocKOhRSN+bHRNXR6GkrLoSPCaSCuFZG6
 MYjCV0apJVCIgQu3M0y3jiZtpjJeQ5KBnDnfsb+054OrHBa/7c6+0bEfFdQNm6VDYoNq
 ICHbukX+I6ev5SJdkD9wMOIbfrWX2te+GTerut/whvOkI6sXWzuhND9oCQtgOrm/KoXa
 Ag2w==
X-Gm-Message-State: AOJu0Yy0RlBtjMc84d/awhz3kP8CfcpcspucGIOU6d2r2CCeA4KDxIMT
 7vnpKv9A7SHtWgAxo6uSiBKmf+Z64d1vuPUtfko+wgGPJaO9MHKZHXrWGAHD
X-Google-Smtp-Source: AGHT+IG7pipFkVYVsBmwtzYnN2jGZTyU9BWvHC7PHkAS/JyggBoAxeQOX3VpXFyGA0dIZF2v8qRF1A==
X-Received: by 2002:a05:6a20:608a:b0:1bd:2944:d295 with SMTP id
 adf61e73a8af0-1bd2944d464mr7011745637.44.1719536312994; 
 Thu, 27 Jun 2024 17:58:32 -0700 (PDT)
Received: from localhost ([136.27.11.53]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac155c339sm3767425ad.184.2024.06.27.17.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 17:58:32 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: yaoxt.fnst@fujitsu.com,
	Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v2] hw/core/loader: allow loading larger ROMs
Date: Thu, 27 Jun 2024 17:58:17 -0700
Message-ID: <20240628005817.1672298-1-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pg1-x535.google.com
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
multiple calls to read().

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
---
 hw/core/loader.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 2f8105d7de..8216781a75 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1115,14 +1115,13 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
 
     rom->datasize = rom->romsize;
     rom->data     = g_malloc0(rom->datasize);
-    lseek(fd, 0, SEEK_SET);
-    rc = read(fd, rom->data, rom->datasize);
+    close(fd);
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
-- 
2.45.2


