Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FCAE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF7s-0002HW-2B; Fri, 13 Dec 2024 18:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7p-0002ET-T8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:13 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF7n-0002yY-Co
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:13 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso24209685e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132669; x=1734737469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOaONdSmL00WQ1J4P+kzXqgpv2mLLgels234yJg+EFU=;
 b=t8TWKe+WY2EtPkU1IT/8bRo3nLfCQ+f0+q5Vk0q1CeE7KKeIRF9cgLo3TB3rKdrzK3
 HJW+8knVnj54Cbt4GtzrXlskp91rmZsQtCg4SBwyTkbUsCQLE7bDxip9PqMOiXT31X/n
 8v+PrqyWKDw0E6sCrBs9cWHtrJhTxfdDLoL+jfgDCcapBDBPMlJwco705g4MwEt5gQ8I
 M6lkARlLv+qPQXplIkGVYsCoVjyN7HTdahBoShWITf4CqGr0M8IVaa4Z0g/32VCqvu5l
 tmiNutSroK2V6klbSGDglQ2IzJ02PElC0u4hc8bfqFL1i4nQdsjXA5Y7c1MFBeLR5Z5B
 HMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132669; x=1734737469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOaONdSmL00WQ1J4P+kzXqgpv2mLLgels234yJg+EFU=;
 b=vxq6HGA5jofKkxfhDLSQvKYNDs65sH8xGFzG3NmxhSXatvbtTZ1FtuswPVMcIMXQ6q
 STi6iIrA74cpb3fsMKjSx0m6KBM+Wmp/mBYsXOEXwQKrZIZ5I4FRnzGYJgDZAoMA+/D5
 lkfJmaXpNfCyeHAm64/HEyf3KwOPIoCxpJGsziMYwhK8CBT5HsRuVXzJPtO7xuT9CYlA
 e9my6xCN06axxOCjE0sNbyUIny8bCcIizIMrNDGMs3WlGdxpVjiibVVLIBxVa3Fk8xnO
 QqWJei5TfKMiKHDcx2GbGbNhFlcl36mK9PsGHpmKthABBlqfhEVzdpew2juD3DVUABkT
 CKkw==
X-Gm-Message-State: AOJu0Yz+Ogzxb9TwYJHosbamEvTvRoDmespVDEagmjSDVa0CC0kGROAq
 g1P5MOT8pBmimXlOeaGDD7UeyLSSA/rcNKqkChVGUxtIl2hQrykOEddbjg2PAnU4ifoyiP+QagX
 Bp3A=
X-Gm-Gg: ASbGnctjZES81pdbj8ch/dw7WSPfYFmQBLTdeuJ8KOiR0nIXvtBIDb+1RO06AseWydl
 tLMtqcFhVUk9D/S0l+bqotzPugWLqeVBvHOjTar6cja1cQs6Fg+4zbmo10awRUS35IN1tZO21VK
 5t3A1B6+kCK3ykqkS0QO44N0yADFJ4bL86/4S6zoZlf2e/GF41WPUJxYk3Z3WDinVqKTH13+VK8
 xqOWzQArJezk4I2a+Zfw+AK14IlQYRk9UksTtK7JlCZm0am+i7nAA/ovT+IpoYYWAqfJMXENYRg
 G3cOLw==
X-Google-Smtp-Source: AGHT+IE5YsjBamT+QTr5WdchSgqKrLE0Z8sCQnR0Ouc3gCOHiRl8zv4ZipPUuVhJ83DFiHCYlX+BaA==
X-Received: by 2002:a5d:64a7:0:b0:385:e9ca:4e18 with SMTP id
 ffacd0b85a97d-38880ac23d0mr3278209f8f.1.1734132669335; 
 Fri, 13 Dec 2024 15:31:09 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046da0sm837078f8f.74.2024.12.13.15.31.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/20] hw/core/eif: Use stateful qcrypto apis
Date: Sat, 14 Dec 2024 00:30:37 +0100
Message-ID: <20241213233055.39574-3-philmd@linaro.org>
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

From: Dorjoy Chowdhury <dorjoychy111@gmail.com>

We were storing the pointers to buffers in a GList due to lack of
stateful crypto apis and instead doing the final hash computation at
the end after we had all the necessary buffers. Now that we have the
stateful qcrypto apis available, we can instead update the hashes
inline in the read_eif_* functions which makes the code much simpler.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
Message-ID: <20241109123039.24180-1-dorjoychy111@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/nitro_enclave.h |  16 +--
 hw/core/eif.c                   | 202 ++++++++++++--------------------
 hw/i386/nitro_enclave.c         |  12 +-
 3 files changed, 91 insertions(+), 139 deletions(-)

diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
index b65875033cc..885163ff640 100644
--- a/include/hw/i386/nitro_enclave.h
+++ b/include/hw/i386/nitro_enclave.h
@@ -44,14 +44,14 @@ struct NitroEnclaveMachineState {
     /* Machine state */
     VirtIONSM *vnsm;
 
-    /* kernel + ramdisks + cmdline sha384 hash */
-    uint8_t image_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
-    /* kernel + boot ramdisk + cmdline sha384 hash */
-    uint8_t bootstrap_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
-    /* application ramdisk(s) hash */
-    uint8_t app_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
-    /* certificate fingerprint hash */
-    uint8_t fingerprint_sha384[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    /* kernel + ramdisks + cmdline SHA384 hash */
+    uint8_t image_hash[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    /* kernel + boot ramdisk + cmdline SHA384 hash */
+    uint8_t bootstrap_hash[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    /* application ramdisk(s) SHA384 hash */
+    uint8_t app_hash[QCRYPTO_HASH_DIGEST_LEN_SHA384];
+    /* certificate fingerprint SHA384 hash */
+    uint8_t fingerprint_hash[QCRYPTO_HASH_DIGEST_LEN_SHA384];
     bool signature_found;
 };
 
diff --git a/hw/core/eif.c b/hw/core/eif.c
index a7128b71cec..513caec6b49 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -187,10 +187,16 @@ static void safe_unlink(char *f)
  * Upon success, the caller is reponsible for unlinking and freeing *kernel_path
  */
 static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
-                            uint8_t *kernel, uint32_t *crc, Error **errp)
+                            QCryptoHash *hash0, QCryptoHash *hash1,
+                            uint32_t *crc, Error **errp)
 {
     size_t got;
     FILE *tmp_file = NULL;
+    uint8_t *kernel = g_try_malloc(size);
+    if (!kernel) {
+        error_setg(errp, "Out of memory reading kernel section");
+        goto cleanup;
+    }
 
     *kernel_path = NULL;
     if (!get_tmp_file("eif-kernel-XXXXXX", kernel_path, errp)) {
@@ -218,6 +224,11 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
     }
 
     *crc = crc32(*crc, kernel, size);
+    if (qcrypto_hash_update(hash0, (char *)kernel, size, errp) != 0 ||
+        qcrypto_hash_update(hash1, (char *)kernel, size, errp) != 0) {
+        goto cleanup;
+    }
+    g_free(kernel);
     fclose(tmp_file);
 
     return true;
@@ -229,10 +240,12 @@ static bool read_eif_kernel(FILE *f, uint64_t size, char **kernel_path,
     g_free(*kernel_path);
     *kernel_path = NULL;
 
+    g_free(kernel);
     return false;
 }
 
 static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
+                             QCryptoHash *hash0, QCryptoHash *hash1,
                              uint32_t *crc, Error **errp)
 {
     size_t got = fread(cmdline, 1, size, f);
@@ -242,28 +255,47 @@ static bool read_eif_cmdline(FILE *f, uint64_t size, char *cmdline,
     }
 
     *crc = crc32(*crc, (uint8_t *)cmdline, size);
+    if (qcrypto_hash_update(hash0, cmdline, size, errp) != 0 ||
+        qcrypto_hash_update(hash1, cmdline, size, errp) != 0) {
+        return false;
+    }
     return true;
 }
 
 static bool read_eif_ramdisk(FILE *eif, FILE *initrd, uint64_t size,
-                             uint8_t *ramdisk, uint32_t *crc, Error **errp)
+                             QCryptoHash *hash0, QCryptoHash *h, uint32_t *crc,
+                             Error **errp)
 {
     size_t got;
+    bool ret = false;
+    uint8_t *ramdisk = g_try_malloc(size);
+    if (!ramdisk) {
+        error_setg(errp, "Out of memory reading initrd section");
+        goto cleanup;
+    }
 
     got = fread(ramdisk, 1, size, eif);
     if ((uint64_t) got != size) {
         error_setg(errp, "Failed to read EIF ramdisk section data");
-        return false;
+        goto cleanup;
     }
 
     got = fwrite(ramdisk, 1, size, initrd);
     if ((uint64_t) got != size) {
         error_setg(errp, "Failed to write EIF ramdisk data to temporary file");
-        return false;
+        goto cleanup;
     }
 
     *crc = crc32(*crc, ramdisk, size);
-    return true;
+    if (qcrypto_hash_update(hash0, (char *)ramdisk, size, errp) != 0 ||
+        qcrypto_hash_update(h, (char *)ramdisk, size, errp) != 0) {
+        goto cleanup;
+    }
+    ret = true;
+
+ cleanup:
+    g_free(ramdisk);
+    return ret;
 }
 
 static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
@@ -391,34 +423,10 @@ static long get_file_size(FILE *f, Error **errp)
     return size;
 }
 
-static bool get_SHA384_digest(GList *list, uint8_t *digest, Error **errp)
+static bool get_SHA384_hash(QCryptoHash *h, uint8_t *hash, Error **errp)
 {
-    size_t digest_len = QCRYPTO_HASH_DIGEST_LEN_SHA384;
-    size_t list_len = g_list_length(list);
-    struct iovec *iovec_list = g_new0(struct iovec, list_len);
-    bool ret = true;
-    GList *l;
-    int i;
-
-    for (i = 0, l = list; l != NULL; l = l->next, i++) {
-        iovec_list[i] = *(struct iovec *) l->data;
-    }
-
-    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALGO_SHA384, iovec_list, list_len,
-                            &digest, &digest_len, errp) < 0) {
-        ret = false;
-    }
-
-    g_free(iovec_list);
-    return ret;
-}
-
-static void free_iovec(struct iovec *iov)
-{
-    if (iov) {
-        g_free(iov->iov_base);
-        g_free(iov);
-    }
+    size_t hash_len = QCRYPTO_HASH_DIGEST_LEN_SHA384;
+    return qcrypto_hash_finalize_bytes(h, &hash, &hash_len, errp) == 0;
 }
 
 /*
@@ -427,8 +435,8 @@ static void free_iovec(struct iovec *iov)
  */
 bool read_eif_file(const char *eif_path, const char *machine_initrd,
                    char **kernel_path, char **initrd_path, char **cmdline,
-                   uint8_t *image_sha384, uint8_t *bootstrap_sha384,
-                   uint8_t *app_sha384, uint8_t *fingerprint_sha384,
+                   uint8_t *image_hash, uint8_t *bootstrap_hash,
+                   uint8_t *app_hash, uint8_t *fingerprint_hash,
                    bool *signature_found, Error **errp)
 {
     FILE *f = NULL;
@@ -438,18 +446,29 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
     uint32_t crc = 0;
     EifHeader eif_header;
     bool seen_sections[EIF_SECTION_MAX] = {false};
-    /* kernel + ramdisks + cmdline sha384 hash */
-    GList *iov_PCR0 = NULL;
-    /* kernel + boot ramdisk + cmdline sha384 hash */
-    GList *iov_PCR1 = NULL;
-    /* application ramdisk(s) hash */
-    GList *iov_PCR2 = NULL;
-    uint8_t *ptr = NULL;
-    struct iovec *iov_ptr = NULL;
+    /* kernel + ramdisks + cmdline SHA384 hash */
+    g_autoptr(QCryptoHash) hash0 = NULL;
+    /* kernel + boot ramdisk + cmdline SHA384 hash */
+    g_autoptr(QCryptoHash) hash1 = NULL;
+    /* application ramdisk(s) SHA384 hash */
+    g_autoptr(QCryptoHash) hash2 = NULL;
 
     *signature_found = false;
     *kernel_path = *initrd_path = *cmdline = NULL;
 
+    hash0 = qcrypto_hash_new(QCRYPTO_HASH_ALGO_SHA384, errp);
+    if (!hash0) {
+        goto cleanup;
+    }
+    hash1 = qcrypto_hash_new(QCRYPTO_HASH_ALGO_SHA384, errp);
+    if (!hash1) {
+        goto cleanup;
+    }
+    hash2 = qcrypto_hash_new(QCRYPTO_HASH_ALGO_SHA384, errp);
+    if (!hash2) {
+        goto cleanup;
+    }
+
     f = fopen(eif_path, "rb");
     if (f == NULL) {
         error_setg_errno(errp, errno, "Failed to open %s", eif_path);
@@ -517,21 +536,8 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 goto cleanup;
             }
 
-            ptr = g_try_malloc(hdr.section_size);
-            if (!ptr) {
-                error_setg(errp, "Out of memory reading kernel section");
-                goto cleanup;
-            }
-
-            iov_ptr = g_malloc(sizeof(struct iovec));
-            iov_ptr->iov_base = ptr;
-            iov_ptr->iov_len = hdr.section_size;
-
-            iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
-            iov_PCR1 = g_list_append(iov_PCR1, iov_ptr);
-
-            if (!read_eif_kernel(f, hdr.section_size, kernel_path, ptr, &crc,
-                                 errp)) {
+            if (!read_eif_kernel(f, hdr.section_size, kernel_path, hash0,
+                                 hash1, &crc, errp)) {
                 goto cleanup;
             }
 
@@ -539,7 +545,6 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
         case EIF_SECTION_CMDLINE:
         {
             uint64_t size;
-            uint8_t *cmdline_copy;
             if (seen_sections[EIF_SECTION_CMDLINE]) {
                 error_setg(errp, "Invalid EIF image. More than 1 cmdline "
                            "section");
@@ -551,33 +556,26 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 error_setg(errp, "Out of memory reading command line section");
                 goto cleanup;
             }
-            if (!read_eif_cmdline(f, size, *cmdline, &crc, errp)) {
+            if (!read_eif_cmdline(f, size, *cmdline, hash0, hash1, &crc,
+                                  errp)) {
                 goto cleanup;
             }
             (*cmdline)[size] = '\0';
 
-            /*
-             * We make a copy of '*cmdline' for putting it in iovecs so that
-             * we can easily free all the iovec entries later as we cannot
-             * free '*cmdline' which is used by the caller.
-             */
-            cmdline_copy = g_memdup2(*cmdline, size);
-
-            iov_ptr = g_malloc(sizeof(struct iovec));
-            iov_ptr->iov_base = cmdline_copy;
-            iov_ptr->iov_len = size;
-
-            iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
-            iov_PCR1 = g_list_append(iov_PCR1, iov_ptr);
             break;
         }
         case EIF_SECTION_RAMDISK:
         {
+            QCryptoHash *h = hash2;
             if (!seen_sections[EIF_SECTION_RAMDISK]) {
                 /*
                  * If this is the first time we are seeing a ramdisk section,
-                 * we need to create the initrd temporary file.
+                 * we need to:
+                 * 1) hash it into bootstrap (hash1) instead of app (hash2)
+                 *    along with image (hash0)
+                 * 2) create the initrd temporary file.
                  */
+                h = hash1;
                 if (!get_tmp_file("eif-initrd-XXXXXX", initrd_path, errp)) {
                     goto cleanup;
                 }
@@ -589,29 +587,7 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 }
             }
 
-            ptr = g_try_malloc(hdr.section_size);
-            if (!ptr) {
-                error_setg(errp, "Out of memory reading initrd section");
-                goto cleanup;
-            }
-
-            iov_ptr = g_malloc(sizeof(struct iovec));
-            iov_ptr->iov_base = ptr;
-            iov_ptr->iov_len = hdr.section_size;
-
-            iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
-            /*
-             * If it's the first ramdisk, we need to hash it into bootstrap
-             * i.e., iov_PCR1, otherwise we need to hash it into app i.e.,
-             * iov_PCR2.
-             */
-            if (!seen_sections[EIF_SECTION_RAMDISK]) {
-                iov_PCR1 = g_list_append(iov_PCR1, iov_ptr);
-            } else {
-                iov_PCR2 = g_list_append(iov_PCR2, iov_ptr);
-            }
-
-            if (!read_eif_ramdisk(f, initrd_path_f, hdr.section_size, ptr,
+            if (!read_eif_ramdisk(f, initrd_path_f, hdr.section_size, hash0, h,
                                   &crc, errp)) {
                 goto cleanup;
             }
@@ -621,7 +597,7 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
         case EIF_SECTION_SIGNATURE:
             *signature_found = true;
             if (!get_signature_fingerprint_sha384(f, hdr.section_size,
-                                                  fingerprint_sha384, &crc,
+                                                  fingerprint_hash, &crc,
                                                   errp)) {
                 goto cleanup;
             }
@@ -692,52 +668,28 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             goto cleanup;
         }
 
-        ptr = g_try_malloc(machine_initrd_size);
-        if (!ptr) {
-            error_setg(errp, "Out of memory reading initrd file");
-            goto cleanup;
-        }
-
-        iov_ptr = g_malloc(sizeof(struct iovec));
-        iov_ptr->iov_base = ptr;
-        iov_ptr->iov_len = machine_initrd_size;
-
-        iov_PCR0 = g_list_append(iov_PCR0, iov_ptr);
-        iov_PCR2 = g_list_append(iov_PCR2, iov_ptr);
-
         if (!read_eif_ramdisk(machine_initrd_f, initrd_path_f,
-                              machine_initrd_size, ptr, &crc, errp)) {
+                              machine_initrd_size, hash0, hash2, &crc, errp)) {
             goto cleanup;
         }
     }
 
-    if (!get_SHA384_digest(iov_PCR0, image_sha384, errp)) {
+    if (!get_SHA384_hash(hash0, image_hash, errp)) {
         goto cleanup;
     }
-    if (!get_SHA384_digest(iov_PCR1, bootstrap_sha384, errp)) {
+    if (!get_SHA384_hash(hash1, bootstrap_hash, errp)) {
         goto cleanup;
     }
-    if (!get_SHA384_digest(iov_PCR2, app_sha384, errp)) {
+    if (!get_SHA384_hash(hash2, app_hash, errp)) {
         goto cleanup;
     }
 
-    /*
-     * We only need to free iov_PCR0 entries because iov_PCR1 and
-     * iov_PCR2 iovec entries are subsets of iov_PCR0 iovec entries.
-     */
-    g_list_free_full(iov_PCR0, (GDestroyNotify) free_iovec);
-    g_list_free(iov_PCR1);
-    g_list_free(iov_PCR2);
     fclose(f);
     fclose(initrd_path_f);
     safe_fclose(machine_initrd_f);
     return true;
 
  cleanup:
-    g_list_free_full(iov_PCR0, (GDestroyNotify) free_iovec);
-    g_list_free(iov_PCR1);
-    g_list_free(iov_PCR2);
-
     safe_fclose(f);
     safe_fclose(initrd_path_f);
     safe_fclose(machine_initrd_f);
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index b6263ae1273..acbbc06b715 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -117,13 +117,13 @@ static void nitro_enclave_machine_reset(MachineState *machine, ResetType type)
     memset(ne_state->vnsm->pcrs, 0, sizeof(ne_state->vnsm->pcrs));
 
     /* PCR0 */
-    ne_state->vnsm->extend_pcr(ne_state->vnsm, 0, ne_state->image_sha384,
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 0, ne_state->image_hash,
                                QCRYPTO_HASH_DIGEST_LEN_SHA384);
     /* PCR1 */
-    ne_state->vnsm->extend_pcr(ne_state->vnsm, 1, ne_state->bootstrap_sha384,
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 1, ne_state->bootstrap_hash,
                                QCRYPTO_HASH_DIGEST_LEN_SHA384);
     /* PCR2 */
-    ne_state->vnsm->extend_pcr(ne_state->vnsm, 2, ne_state->app_sha384,
+    ne_state->vnsm->extend_pcr(ne_state->vnsm, 2, ne_state->app_hash,
                                QCRYPTO_HASH_DIGEST_LEN_SHA384);
     /* PCR3 */
     if (ne_state->parent_role) {
@@ -140,7 +140,7 @@ static void nitro_enclave_machine_reset(MachineState *machine, ResetType type)
     /* PCR8 */
     if (ne_state->signature_found) {
         ne_state->vnsm->extend_pcr(ne_state->vnsm, 8,
-                                   ne_state->fingerprint_sha384,
+                                   ne_state->fingerprint_hash,
                                    QCRYPTO_HASH_DIGEST_LEN_SHA384);
     }
 
@@ -173,8 +173,8 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
 
     if (!read_eif_file(machine->kernel_filename, machine->initrd_filename,
                        &eif_kernel, &eif_initrd, &eif_cmdline,
-                       nems->image_sha384, nems->bootstrap_sha384,
-                       nems->app_sha384, nems->fingerprint_sha384,
+                       nems->image_hash, nems->bootstrap_hash,
+                       nems->app_hash, nems->fingerprint_hash,
                        &(nems->signature_found), &err)) {
         error_report_err(err);
         exit(1);
-- 
2.45.2


