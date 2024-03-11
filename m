Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327C1C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl5y-0003zU-NN; Mon, 11 Mar 2024 15:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4s-0003M8-Eh
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4q-0000MX-EF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4132fbac6faso4751115e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184367; x=1710789167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=62mCtsOCyj3c3FuJKG39VRV6AssOCE2B0e0pxCJsMUw=;
 b=KbyfHT1agQqlst60UIntM9J7eHNRf1TeDVMNfFjPzzr9nwVUy7ID0EunUW8NcsegFR
 AacItX4qnnFJtFa1k1IecDJ8qcxPhNCrVWfne6X/wZgmkvmPzB9CErq+RhzS3PTLgZzu
 qFG6jqpY0CTFkyHPw87g0WM7l4VCG/7+qzesXpJhJffrE63QCZWwbRB/Nxh23ySMCb2v
 S03GX0NX5PAWl4O45af90otYTSEiYiaRMZ4kP6d7cf3H63IyRtAR148IsyaU+1YZMQBQ
 BpdUQ8W7CVaEIbKXFZ3+Xr9BSfLZ1+CJcYUIWxDd0IOQGNizSwrCSjwBsg6oLZaVHRis
 qW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184367; x=1710789167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62mCtsOCyj3c3FuJKG39VRV6AssOCE2B0e0pxCJsMUw=;
 b=ZFltMmUgENhxeDWvBM0jmKRLUrmDhkJPkuKtA200/zinM7FDy56fANYileFWuHPC7u
 ZuDHuZFjjwxbC0oDl/HADG5csX3U4eOOh/H5StjJFqe1dwbJa8pCPmPjVtE+0tJEbu0i
 XEAcXB6Iew0KemKsFxnSejZ8uRBzPaNBKIINOoYoE+zU2jWM0k9sOGWW1nvnRWoWIEM+
 YEEC6iSu9GHXeBarc2KBe62d43KubukaPBLiYyQR//bkYqihqOhszb9dFNo+aarMXEsy
 CYtfV4jQM7xZjud7pX7z8HZnoRQ/6eNGQuBqQebKO+F74AR+tx9jLChsjmz8y/Vq1GRV
 tmOg==
X-Gm-Message-State: AOJu0YzeckBNkMu0w4dUZea+kZFcf6K1iKD1E1AltIh13uaXaG1kkKrD
 xheTmEss9GjPOwe7pB3Hp5Th6p4DDBTn1j+cQ1UVLi/dRThAfj0tbUV8S2wlJD1p5StprBmyxQb
 z
X-Google-Smtp-Source: AGHT+IHucfx2dF3irdINjqmgHhcAeQBZLn7Z3CWQOjHtfDPy47TgKVmkyi1BPkGFw9/HUGO/SWUeTw==
X-Received: by 2002:a05:600c:1c16:b0:413:1ae3:6ad1 with SMTP id
 j22-20020a05600c1c1600b004131ae36ad1mr5974777wms.15.1710184366713; 
 Mon, 11 Mar 2024 12:12:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/20] contrib/elf2dmp: Fix error reporting style in pdb.c
Date: Mon, 11 Mar 2024 19:12:29 +0000
Message-Id: <20240311191241.4177990-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240307-elf2dmp-v4-7-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/pdb.h  |  2 +-
 contrib/elf2dmp/main.c |  2 +-
 contrib/elf2dmp/pdb.c  | 50 +++++++++++++++++++++---------------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index 2a50da56ac9..feddf1862f0 100644
--- a/contrib/elf2dmp/pdb.h
+++ b/contrib/elf2dmp/pdb.h
@@ -233,7 +233,7 @@ struct pdb_reader {
     size_t segs_size;
 };
 
-int pdb_init_from_file(const char *name, struct pdb_reader *reader);
+bool pdb_init_from_file(const char *name, struct pdb_reader *reader);
 void pdb_exit(struct pdb_reader *reader);
 uint64_t pdb_resolve(uint64_t img_base, struct pdb_reader *r, const char *name);
 uint64_t pdb_find_public_v3_symbol(struct pdb_reader *reader, const char *name);
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index d295fd92be2..7a3a7225905 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -596,7 +596,7 @@ int main(int argc, char *argv[])
         goto out_ps;
     }
 
-    if (pdb_init_from_file(PDB_NAME, &pdb)) {
+    if (!pdb_init_from_file(PDB_NAME, &pdb)) {
         eprintf("Failed to initialize PDB reader\n");
         goto out_pdb_file;
     }
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index abf17c2e7c1..1c505142518 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -158,30 +158,30 @@ static void *pdb_ds_read_file(struct pdb_reader* r, uint32_t file_number)
     return pdb_ds_read(r->ds.header, block_list, file_size[file_number]);
 }
 
-static int pdb_init_segments(struct pdb_reader *r)
+static bool pdb_init_segments(struct pdb_reader *r)
 {
     unsigned stream_idx = r->segments;
 
     r->segs = pdb_ds_read_file(r, stream_idx);
     if (!r->segs) {
-        return 1;
+        return false;
     }
 
     r->segs_size = pdb_get_file_size(r, stream_idx);
     if (!r->segs_size) {
-        return 1;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
-static int pdb_init_symbols(struct pdb_reader *r)
+static bool pdb_init_symbols(struct pdb_reader *r)
 {
     PDB_SYMBOLS *symbols;
 
     symbols = pdb_ds_read_file(r, 3);
     if (!symbols) {
-        return 1;
+        return false;
     }
 
     r->symbols = symbols;
@@ -198,18 +198,18 @@ static int pdb_init_symbols(struct pdb_reader *r)
         goto out_symbols;
     }
 
-    return 0;
+    return true;
 
 out_symbols:
     g_free(symbols);
 
-    return 1;
+    return false;
 }
 
-static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
+static bool pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
 {
     if (hdr->block_size == 0) {
-        return 1;
+        return false;
     }
 
     memset(r->file_used, 0, sizeof(r->file_used));
@@ -218,22 +218,22 @@ static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
                 hdr->toc_page * hdr->block_size), hdr->toc_size);
 
     if (!r->ds.toc) {
-        return 1;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
-static int pdb_reader_init(struct pdb_reader *r, void *data)
+static bool pdb_reader_init(struct pdb_reader *r, void *data)
 {
     const char pdb7[] = "Microsoft C/C++ MSF 7.00";
 
     if (memcmp(data, pdb7, sizeof(pdb7) - 1)) {
-        return 1;
+        return false;
     }
 
-    if (pdb_reader_ds_init(r, data)) {
-        return 1;
+    if (!pdb_reader_ds_init(r, data)) {
+        return false;
     }
 
     r->ds.root = pdb_ds_read_file(r, 1);
@@ -241,15 +241,15 @@ static int pdb_reader_init(struct pdb_reader *r, void *data)
         goto out_ds;
     }
 
-    if (pdb_init_symbols(r)) {
+    if (!pdb_init_symbols(r)) {
         goto out_root;
     }
 
-    if (pdb_init_segments(r)) {
+    if (!pdb_init_segments(r)) {
         goto out_sym;
     }
 
-    return 0;
+    return true;
 
 out_sym:
     pdb_exit_symbols(r);
@@ -258,7 +258,7 @@ out_root:
 out_ds:
     pdb_reader_ds_exit(r);
 
-    return 1;
+    return false;
 }
 
 static void pdb_reader_exit(struct pdb_reader *r)
@@ -269,7 +269,7 @@ static void pdb_reader_exit(struct pdb_reader *r)
     pdb_reader_ds_exit(r);
 }
 
-int pdb_init_from_file(const char *name, struct pdb_reader *reader)
+bool pdb_init_from_file(const char *name, struct pdb_reader *reader)
 {
     GError *gerr = NULL;
     void *map;
@@ -278,21 +278,21 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
     if (gerr) {
         eprintf("Failed to map PDB file \'%s\'\n", name);
         g_error_free(gerr);
-        return 1;
+        return false;
     }
 
     reader->file_size = g_mapped_file_get_length(reader->gmf);
     map = g_mapped_file_get_contents(reader->gmf);
-    if (pdb_reader_init(reader, map)) {
+    if (!pdb_reader_init(reader, map)) {
         goto out_unmap;
     }
 
-    return 0;
+    return true;
 
 out_unmap:
     g_mapped_file_unref(reader->gmf);
 
-    return 1;
+    return false;
 }
 
 void pdb_exit(struct pdb_reader *reader)
-- 
2.34.1


