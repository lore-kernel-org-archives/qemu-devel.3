Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7437C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvs-0001Df-62; Mon, 02 Mar 2026 03:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuI-0004wj-Tz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu9-0001tj-QT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ph5r2s5vTC46MydMfLvvFmtPkIBHn0GG6bfe8Rxs+j0=;
 b=Jqh0PkrwvEezRfc0aTJ+PwqPN9RkQaQYNWcB6+A8fJXNAAfd5zheESAQ3nJ94Fi+z+Cm3q
 stMhsFcRuIhXZKiVDnSwdKpnzTvA2WWIskWhVJPCHQRl/vq7EkBEOml1M28TGt606wXCkm
 0+n0qQD1VhUiYGLZYBtC/oKKl/8w8sA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-adoxjV4zPYS0nUHvKGeJbQ-1; Mon, 02 Mar 2026 03:45:26 -0500
X-MC-Unique: adoxjV4zPYS0nUHvKGeJbQ-1
X-Mimecast-MFC-AGG-ID: adoxjV4zPYS0nUHvKGeJbQ_1772441125
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso32801395e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441125; x=1773045925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ph5r2s5vTC46MydMfLvvFmtPkIBHn0GG6bfe8Rxs+j0=;
 b=li/cwU4Bs6Etq7lvO3aQKna+tr3fGuqHpYRfCjZ+laBCJSbf5mOYiqvjkU4R7FEPdD
 2PzSBc7sKkTuBZznHVKXsltbWRDx6/ejQt1jWCODJJfEOtfscqXB1Feph58CquJ0EMj0
 oWztEmg7XfO/PLdxdC4I1bsa2Avw+XlScpl8++JOV7kKzQmvSGXm7GSsksssXdgdVP/q
 8NUzZ3D+wzD52fUIUox4GDUyGfhuqV5u6JQMyD37kNo5xEM8q+Zx2CuFxOazfaPH9DCj
 0Y0xvDT5Odhnt51E6LEC4zLWu6DkyyFXGkBJdIQrjXZI8XOE5nZCxlNGsKB/FsD83Bxu
 CS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441125; x=1773045925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ph5r2s5vTC46MydMfLvvFmtPkIBHn0GG6bfe8Rxs+j0=;
 b=xIZ3M7dQHIk2lkK+75CuRfr28LAVyhqQ0hcB2rTwdfWXvsuY65Mpqth8RKUg0UXUjt
 HDFlusERTWHhk7Lg3RukJQ8NaBUotDXuyggu8MuruyAuupvm3s3cwXxYz+AIdA6V57AC
 bRg8zdfgMMpzuH3/WFfx9c74fLCkI841Wv37CA2e1ZjszxLQm67BXTW8sVbVEA7taO+n
 iZXdw7rHtf0zd9swpBeOWixxc1rBKzLzS9DaNAALz6YTrQ92Od0QQHfFE08dAkqFwXj2
 vjVxRe5LWlK34mX/Zhy1Qt8TtoFSEVu+LVUpuI9qJQ1wLMfCgVLVUtJyNn5ffnIHAdaY
 PIjw==
X-Gm-Message-State: AOJu0YyjGy9H67NH/PWhplvxSnEfEyBDro0LbtluwdP0M1l4rK82jKFL
 9YmDS46w952CjOmNo2qI0DodjQysWjDywlIUHhC3LA7eF9UFivcMgwKCFJ8+0gk/6F54/hw/vOD
 mYce3Qz9OHcl/Ps47VZ97xXqRm2NWptPp9TC+aI0fsmaujJNUVIlPK2bU6DGxZkrenBmc963O3F
 JL3lCbWnp7TdTIN6zOL3MEn58VX2VG6JjQ2DPrhxad
X-Gm-Gg: ATEYQzzPzFTn6Inc1uzxoRqytz8GT5lcLrGmczRZjnAO3E3HOv3Tk72idZ26a939URt
 IVkoUg5rCBGrENSRQQO09atuKaiKiuV3LBiYB/XHs20b9VMREbzQ20ij8g+Ham6QyCSZZGbCJpZ
 pjvpJgDCkDj7ACPhoBUAy8h2THc+MtcMlStUwBrNIdeOiIb277R7OQSDS6X+Fk0uf9zuUG6H0RS
 G4ITTh7BA9AEXDOpGIsNQtNEgGzSxA/U0eu1NZ74zUSdWZ20fng05TBi8iKZBfGc3hfoE5WTnmd
 rotmz05rD0a5KT/dR8+nkCbupcA9s7q+jIDt3xEMRpYLG3BJiYs8ZACBiN0RcLNdlTeiqO7MIS0
 pB0NXrmS3aLhTiBiiP+rjOswL3/8LMw7XKYx3KG/O6T7njkTGbMTUSmL509tiNM7XBQSi3ztN/s
 JxTH9WND4cx5Ej+tr4anwJbssAAN8=
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211453425e9.2.1772441124884; 
 Mon, 02 Mar 2026 00:45:24 -0800 (PST)
X-Received: by 2002:a05:600c:a086:b0:483:a895:9d85 with SMTP id
 5b1f17b1804b1-483c9ba3ae6mr211452885e9.2.1772441124352; 
 Mon, 02 Mar 2026 00:45:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b3ce8fsm272486425e9.4.2026.03.02.00.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PULL 039/102] hw/core/eif: Move definitions to header
Date: Mon,  2 Mar 2026 09:42:34 +0100
Message-ID: <20260302084338.473368-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Graf <graf@amazon.com>

In follow-up patches we need some EIF file definitions that are
currently in the eif.c file, but want to access them from a separate
device. Move them into the header instead.

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Link: https://lore.kernel.org/r/20260225220807.33092-10-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/eif.h | 38 ++++++++++++++++++++++++++++++++++++++
 hw/core/eif.c | 38 --------------------------------------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/hw/core/eif.h b/hw/core/eif.h
index fed3cb55140..a3412377a90 100644
--- a/hw/core/eif.h
+++ b/hw/core/eif.h
@@ -11,6 +11,44 @@
 #ifndef HW_CORE_EIF_H
 #define HW_CORE_EIF_H
 
+#define MAX_SECTIONS 32
+
+/* members are ordered according to field order in .eif file */
+typedef struct EifHeader {
+    uint8_t  magic[4]; /* must be .eif in ascii i.e., [46, 101, 105, 102] */
+    uint16_t version;
+    uint16_t flags;
+    uint64_t default_memory;
+    uint64_t default_cpus;
+    uint16_t reserved;
+    uint16_t section_cnt;
+    uint64_t section_offsets[MAX_SECTIONS];
+    uint64_t section_sizes[MAX_SECTIONS];
+    uint32_t unused;
+    uint32_t eif_crc32;
+} QEMU_PACKED EifHeader;
+
+/* members are ordered according to field order in .eif file */
+typedef struct EifSectionHeader {
+    /*
+     * 0 = invalid, 1 = kernel, 2 = cmdline, 3 = ramdisk, 4 = signature,
+     * 5 = metadata
+     */
+    uint16_t section_type;
+    uint16_t flags;
+    uint64_t section_size;
+} QEMU_PACKED EifSectionHeader;
+
+enum EifSectionTypes {
+    EIF_SECTION_INVALID = 0,
+    EIF_SECTION_KERNEL = 1,
+    EIF_SECTION_CMDLINE = 2,
+    EIF_SECTION_RAMDISK = 3,
+    EIF_SECTION_SIGNATURE = 4,
+    EIF_SECTION_METADATA = 5,
+    EIF_SECTION_MAX = 6,
+};
+
 bool read_eif_file(const char *eif_path, const char *machine_initrd,
                    char **kernel_path, char **initrd_path,
                    char **kernel_cmdline, uint8_t *image_sha384,
diff --git a/hw/core/eif.c b/hw/core/eif.c
index 513caec6b49..96f1d765785 100644
--- a/hw/core/eif.c
+++ b/hw/core/eif.c
@@ -18,44 +18,6 @@
 
 #include "hw/core/eif.h"
 
-#define MAX_SECTIONS 32
-
-/* members are ordered according to field order in .eif file */
-typedef struct EifHeader {
-    uint8_t  magic[4]; /* must be .eif in ascii i.e., [46, 101, 105, 102] */
-    uint16_t version;
-    uint16_t flags;
-    uint64_t default_memory;
-    uint64_t default_cpus;
-    uint16_t reserved;
-    uint16_t section_cnt;
-    uint64_t section_offsets[MAX_SECTIONS];
-    uint64_t section_sizes[MAX_SECTIONS];
-    uint32_t unused;
-    uint32_t eif_crc32;
-} QEMU_PACKED EifHeader;
-
-/* members are ordered according to field order in .eif file */
-typedef struct EifSectionHeader {
-    /*
-     * 0 = invalid, 1 = kernel, 2 = cmdline, 3 = ramdisk, 4 = signature,
-     * 5 = metadata
-     */
-    uint16_t section_type;
-    uint16_t flags;
-    uint64_t section_size;
-} QEMU_PACKED EifSectionHeader;
-
-enum EifSectionTypes {
-    EIF_SECTION_INVALID = 0,
-    EIF_SECTION_KERNEL = 1,
-    EIF_SECTION_CMDLINE = 2,
-    EIF_SECTION_RAMDISK = 3,
-    EIF_SECTION_SIGNATURE = 4,
-    EIF_SECTION_METADATA = 5,
-    EIF_SECTION_MAX = 6,
-};
-
 static const char *section_type_to_string(uint16_t type)
 {
     const char *str;
-- 
2.53.0


