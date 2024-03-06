Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C98C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWJ-0004yS-GQ; Wed, 06 Mar 2024 01:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW6-0004uV-41
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:40 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW3-0006Fi-SF
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dccb2edc6dso53970145ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705554; x=1710310354;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=shZdRVaAuTUEJwuhgEsEU4+8uLO5iP81udj39ehMmZA=;
 b=d1fib84f03jhFllKdHSB8RxwTMZp6OTXJpdJVFO0UUTEFGWp/zE4QpH2YErhKpgZZz
 EEYUlRaZ4ky3yUbpJDYEkTU++u2Z/Tvecl4dH5daFuU4wbR66Us8CtLcSSP8yAFMmxNe
 VVbgVDnNDvDNzAJJydmMDoiqZc/3Tj60k/MofsTtPdduvr7zVCgBtdWamET47zoXWPtA
 G8dlArC4+SAj73aHDU9xhUjzKKXtKRra7GHQRooJlbAMx2de271SN13QLOiYTBOQ7p4E
 SVepcFZiFyaVAl46ygnoygrLWwV35qnKSswrEbWzX+vbVo1aIEkXVkL4qvPTSk2TtE57
 isfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705554; x=1710310354;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shZdRVaAuTUEJwuhgEsEU4+8uLO5iP81udj39ehMmZA=;
 b=QONl+hyFczA9fXw2iPnx+gKArCe9wB+XkxQ7mQaA28PFLcmfSZnB7BMQ0FKFyE/Cp/
 kBtvp0ovDt6vpoVnCmaKCnDv3EVI2ubuwFoInKt/qooX5iFFZjFPilQp6iuTWpe03p2b
 ZG4gj7PH5R8CJ6nayvwScT+evOYsvdVjvd94LP4ZIBzh2SsOYwjizBZC3Ml7M1L8+zlT
 4rO0e5k8X+nPey/BHnjPlAx7p0ejL+8NYzdopY+n1kzyj9krQS72Ic/SOImK2niaP4NY
 VV08N3pwoo0FvjjK8GSw2MOwKkQDKuruALsA28RWiBQKk6Rids58sE/7hDEtN4bEs3W4
 S4rw==
X-Gm-Message-State: AOJu0YyDb9+XEGyhNRMZVOVQYfAGQBmsGwbVQjbF4qfzmshp1vVmpec+
 L7aKzq+7acxbRkparDO6e7j/m9Zagh9GWsy8YV8KSxHWWUg2J0CZ/A/FtEXBeXI=
X-Google-Smtp-Source: AGHT+IEPJUR1SmkG8FJsP4YIlUvXJuhewAiEeALXs188Ky0siTvP6xA2pZrC6TagwXq1zFPCeDYMhg==
X-Received: by 2002:a17:902:8a83:b0:1d7:2e86:fb2a with SMTP id
 p3-20020a1709028a8300b001d72e86fb2amr3583576plo.65.1709705554387; 
 Tue, 05 Mar 2024 22:12:34 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 q7-20020a170902dac700b001dc23e877c9sm11661866plx.106.2024.03.05.22.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:13 +0900
Subject: [PATCH v3 07/19] contrib/elf2dmp: Fix error reporting style in pdb.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-7-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/pdb.h  |  2 +-
 contrib/elf2dmp/main.c |  2 +-
 contrib/elf2dmp/pdb.c  | 50 +++++++++++++++++++++++++-------------------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index 2a50da56ac96..feddf1862f08 100644
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
index d295fd92be2f..7a3a7225905e 100644
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
index abf17c2e7c12..1c5051425185 100644
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
2.44.0


