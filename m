Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3AFD64073
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swe-00040C-4p; Fri, 08 Nov 2024 12:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swc-0003zF-DM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swa-0007au-K1
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lupvEcmnHg1GtHFHOuqV3Po9cXi+wkOo2DQJpTtu0xI=;
 b=IYgH2R+07600fnauoVqoE6QP3bAJyhc+2qxuxCQQ2/yJuPjmmObHbRIgWjldthp41Y7dbQ
 iky3x6Sz2D6BNzjr2lTbkUhkaUqjA16E5Dz94ucmdkOR3+TVfiBf8xtHehxgs6xl2WcEjc
 070UAsydb5LWhfd5lj3OBvrY7edQnpg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-8xmObHcCNx-OTh9CQhgHBg-1; Fri, 08 Nov 2024 12:38:44 -0500
X-MC-Unique: 8xmObHcCNx-OTh9CQhgHBg-1
X-Mimecast-MFC-AGG-ID: 8xmObHcCNx-OTh9CQhgHBg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso16728265e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087522; x=1731692322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lupvEcmnHg1GtHFHOuqV3Po9cXi+wkOo2DQJpTtu0xI=;
 b=BWUnbansXL20mOh+/I5c4C/bY3YSfrUqbaxZ2yXALOvOPa4xsy3kH/AtZn+2js3HcX
 jJrvbft5zXe/kWWnjW0yk+i1g7izCH1zmkEV9jzhGUYIo9URekaQszc3xu+61N/TzPyz
 aeQnJT+QJVyqzOkjejgeyvFfBuAMBfeSvCvcaiKOfudnTerINOImbBdoVQSWb0KWJfFm
 rmCzKCMn+Xr6b2ik1P5n2jAtio7PeJNrPeAR1tczYXNHGt4gZx5EECu9j2PrX09n+9bt
 iwBuUyKElzhyP7jEHshImBgq3Blsy0bB5ofsa86js6hftH1Gvr0kCspyi3gWzUl8/Bhu
 p/Ug==
X-Gm-Message-State: AOJu0YxDMuhgV0wn6prE2OHkMvLjkugsyRoccFtDY73i5/W/5d5hsHwA
 Gz4fOhK/8+cdcrypwP72AZFxk02hIFpDPfeq9pB2mGjifcbn8RsEkV0A4SL3z87N0zAMh1dr3Rh
 tlo+UzJ4NAerXRC3wfzuwRHJljkAUxFufro97feULocYuJfble8pyoXHMmf9RTz8ujNnIUbHqpU
 VFlYgqGa6IBgSqRT5NHRXhGWVUwx/MhO6SzSreiPc=
X-Received: by 2002:a05:600c:4f12:b0:431:5503:43ca with SMTP id
 5b1f17b1804b1-432b751f53cmr28912525e9.28.1731087522190; 
 Fri, 08 Nov 2024 09:38:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjZBCpKV8EvP6UY4bia8y8dsG6cswhaoAsM7kqVutlF2kYfFPjAPlUoQXWfwKLsN9b107XgQ==
X-Received: by 2002:a05:600c:4f12:b0:431:5503:43ca with SMTP id
 5b1f17b1804b1-432b751f53cmr28912315e9.28.1731087521791; 
 Fri, 08 Nov 2024 09:38:41 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm109798375e9.41.2024.11.08.09.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PULL 06/13] eif: cope with huge section sizes
Date: Fri,  8 Nov 2024 18:38:21 +0100
Message-ID: <20241108173828.111454-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Check for overflow as well as allocation failure.  Resolves Coverity CID 1564859.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/eif.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/hw/core/eif.c b/hw/core/eif.c
index 61329aacfe1..7a8c657f23a 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -119,6 +119,10 @@ static bool read_eif_header(FILE *f, EifHeader *header, uint32_t *crc,
 
     for (int i = 0; i < MAX_SECTIONS; ++i) {
         header->section_sizes[i] = be64_to_cpu(header->section_sizes[i]);
+        if (header->section_sizes[i] > SSIZE_MAX) {
+            error_setg(errp, "Invalid EIF image. Section size out of bounds");
+            return false;
+        }
     }
 
     header->unused = be32_to_cpu(header->unused);
@@ -278,7 +282,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
     struct cbor_load_result result;
     bool ret = false;
 
-    sig = g_malloc(size);
+    sig = g_try_malloc(size);
+    if (!sig) {
+        error_setg(errp, "Out of memory reading signature section");
+        goto cleanup;
+    }
+
     got = fread(sig, 1, size, eif);
     if ((uint64_t) got != size) {
         error_setg(errp, "Failed to read EIF signature section data");
@@ -320,7 +329,12 @@ static bool get_signature_fingerprint_sha384(FILE *eif, uint64_t size,
         error_setg(errp, "Invalid signature CBOR");
         goto cleanup;
     }
-    cert = g_malloc(len);
+    cert = g_try_malloc(len);
+    if (!cert) {
+        error_setg(errp, "Out of memory reading signature section");
+        goto cleanup;
+    }
+
     for (int i = 0; i < len; ++i) {
         cbor_item_t *tmp = cbor_array_get(pair->value, i);
         if (!tmp) {
@@ -503,7 +517,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 goto cleanup;
             }
 
-            ptr = g_malloc(hdr.section_size);
+            ptr = g_try_malloc(hdr.section_size);
+            if (!ptr) {
+                error_setg(errp, "Out of memory reading kernel section");
+                goto cleanup;
+            }
 
             iov_ptr = g_malloc(sizeof(struct iovec));
             iov_ptr->iov_base = ptr;
@@ -528,7 +546,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 goto cleanup;
             }
             size = hdr.section_size;
-            *cmdline = g_malloc(size + 1);
+            *cmdline = g_try_malloc(size + 1);
+            if (!cmdline) {
+                error_setg(errp, "Out of memory reading command line section");
+                goto cleanup;
+            }
             if (!read_eif_cmdline(f, size, *cmdline, &crc, errp)) {
                 goto cleanup;
             }
@@ -567,7 +589,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
                 }
             }
 
-            ptr = g_malloc(hdr.section_size);
+            ptr = g_try_malloc(hdr.section_size);
+            if (!ptr) {
+                error_setg(errp, "Out of memory reading initrd section");
+                goto cleanup;
+            }
 
             iov_ptr = g_malloc(sizeof(struct iovec));
             iov_ptr->iov_base = ptr;
@@ -606,7 +632,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             uint8_t *buf;
             size_t got;
             uint64_t size = hdr.section_size;
-            buf = g_malloc(size);
+            buf = g_try_malloc(size);
+            if (!buf) {
+                error_setg(errp, "Out of memory reading unknown section");
+                goto cleanup;
+            }
             got = fread(buf, 1, size, f);
             if ((uint64_t) got != size) {
                 g_free(buf);
@@ -662,7 +692,11 @@ bool read_eif_file(const char *eif_path, const char *machine_initrd,
             goto cleanup;
         }
 
-        ptr = g_malloc(machine_initrd_size);
+        ptr = g_try_malloc(machine_initrd_size);
+        if (!ptr) {
+            error_setg(errp, "Out of memory reading initrd file");
+            goto cleanup;
+        }
 
         iov_ptr = g_malloc(sizeof(struct iovec));
         iov_ptr->iov_base = ptr;
-- 
2.47.0


