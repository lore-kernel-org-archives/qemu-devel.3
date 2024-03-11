Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF31C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9a-0006q4-8T; Mon, 11 Mar 2024 15:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4s-0003M7-Cp
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4n-0000Ll-Fz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41312232c7aso24405245e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184363; x=1710789163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ae2H6jSaJUto5uaWCnZ0XvoB+nPYp9rIkOUV6PcAjZE=;
 b=JkfaibjuQQdKz1fUeyp2hf5iVEAlqHwqmXHveISP6lIhe6OvEeR4BJjD0imXC0o2NQ
 2RqP8sHDWn2849NgQafGsvHpC+tCiSEgs+6bMXZhRRfJx3ERYBhfbekdAvL2QoVuJE8j
 RlRvHkgnLzEFxtlAeNdVPUJVR6sH8Iw8vUZRsovuj5meiEGCEgNNcfV7oznENjczhg03
 g2XimtRuilids+36GVOYDjwM2qU6aV4mZwW9G62UQnkdS3ZgYczyt4GtPTtgRbzNY+PM
 sF3ln4Z6G6MujGiUtobtyrpk3sZlUDZhR8PQ1U/z/apwBBINHW+r9wMAPpxefBfqDib0
 kuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184363; x=1710789163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ae2H6jSaJUto5uaWCnZ0XvoB+nPYp9rIkOUV6PcAjZE=;
 b=lqxmY8i4IoaaHlvtzKcGrsId0v2I47piZA3JewekfQwYb4RGbzTmobPavo0QjyzlEx
 NaUvm3n5iDC1Ef5F4/FVw3ziPpSCUQ/9Cd27+O1QUQKFQWVlFpdrDILHYh7U9qadtRPB
 qk6woC/3wMWfeAln5aDHIY8adATcLZVmQly48kqpfWnbSlObhDBjG3udORQwqXIJ4NAZ
 RUb5Mf2i1Iowhl7AtCLCXVtaj3MOgsy+TUNVn1tK6rtGLn7+UCUihYeUkqAPCIkqlRqG
 ViNSsqtekHxRYCJZ1x5MR03xie5rDkga42WD+d4rxu4+2OBEuYJGUeSEbE6gsQZljG5R
 6oig==
X-Gm-Message-State: AOJu0YwyubbcmR/bRlEnuwoFgEMKvEy1qbwMpY2zAAVhS7J8zt7GG9b2
 SnU+RVrAMl2ATRMMKu5Ua6qGQogZuS35vopoVPvEvTl7GU+R9OqU05jyhBrhPzWn8+Sm4de7fYV
 X
X-Google-Smtp-Source: AGHT+IEPZ0OZDhUAgmbpeKq6s9FqgcQS5eH2JXIXPaurW4dbR86SYaQD3QKntcQqyV6AhEZkJQT8PA==
X-Received: by 2002:a05:600c:3b8f:b0:412:969a:24c with SMTP id
 n15-20020a05600c3b8f00b00412969a024cmr6304403wms.13.1710184363381; 
 Mon, 11 Mar 2024 12:12:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] contrib/elf2dmp: Remove unnecessary err flags
Date: Mon, 11 Mar 2024 19:12:23 +0000
Message-Id: <20240311191241.4177990-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

They are always evaluated to 1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-1-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/pdb.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 40991f5f4c3..abf17c2e7c1 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -177,7 +177,6 @@ static int pdb_init_segments(struct pdb_reader *r)
 
 static int pdb_init_symbols(struct pdb_reader *r)
 {
-    int err = 0;
     PDB_SYMBOLS *symbols;
 
     symbols = pdb_ds_read_file(r, 3);
@@ -196,7 +195,6 @@ static int pdb_init_symbols(struct pdb_reader *r)
     /* Read global symbol table */
     r->modimage = pdb_ds_read_file(r, symbols->gsym_file);
     if (!r->modimage) {
-        err = 1;
         goto out_symbols;
     }
 
@@ -205,7 +203,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
 out_symbols:
     g_free(symbols);
 
-    return err;
+    return 1;
 }
 
 static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
@@ -228,7 +226,6 @@ static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
 
 static int pdb_reader_init(struct pdb_reader *r, void *data)
 {
-    int err = 0;
     const char pdb7[] = "Microsoft C/C++ MSF 7.00";
 
     if (memcmp(data, pdb7, sizeof(pdb7) - 1)) {
@@ -241,17 +238,14 @@ static int pdb_reader_init(struct pdb_reader *r, void *data)
 
     r->ds.root = pdb_ds_read_file(r, 1);
     if (!r->ds.root) {
-        err = 1;
         goto out_ds;
     }
 
     if (pdb_init_symbols(r)) {
-        err = 1;
         goto out_root;
     }
 
     if (pdb_init_segments(r)) {
-        err = 1;
         goto out_sym;
     }
 
@@ -264,7 +258,7 @@ out_root:
 out_ds:
     pdb_reader_ds_exit(r);
 
-    return err;
+    return 1;
 }
 
 static void pdb_reader_exit(struct pdb_reader *r)
@@ -278,7 +272,6 @@ static void pdb_reader_exit(struct pdb_reader *r)
 int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 {
     GError *gerr = NULL;
-    int err = 0;
     void *map;
 
     reader->gmf = g_mapped_file_new(name, TRUE, &gerr);
@@ -291,7 +284,6 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
     reader->file_size = g_mapped_file_get_length(reader->gmf);
     map = g_mapped_file_get_contents(reader->gmf);
     if (pdb_reader_init(reader, map)) {
-        err = 1;
         goto out_unmap;
     }
 
@@ -300,7 +292,7 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 out_unmap:
     g_mapped_file_unref(reader->gmf);
 
-    return err;
+    return 1;
 }
 
 void pdb_exit(struct pdb_reader *reader)
-- 
2.34.1


