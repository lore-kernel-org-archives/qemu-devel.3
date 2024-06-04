Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DF4C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwp-0006ho-6T; Tue, 04 Jun 2024 02:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvw-0004ho-Ti
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvv-0007eD-8I
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8+XYqbQTMPq1BB+V1VrxOpCjz6T/cPUIIwIMJWLfJo=;
 b=MDULS0ci4k1FnbAJxTswIb5ghYefWkff8eh0XbDIxl43IYhSVgEuMgRYviSIiD0PoM3wlj
 kZHwfKhdKRFfPvP7/XYiKRgvGRvKu9+/pttKUU7kZQywzHCRZSAV4RsVjBEOk4voixAIga
 cRBkMBdLIemig4lYmww/Y8Vz8u/OiTo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-4kar3kWoOISHjfII_ZGM6g-1; Tue, 04 Jun 2024 02:46:08 -0400
X-MC-Unique: 4kar3kWoOISHjfII_ZGM6g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52b90dc90easo2143334e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483566; x=1718088366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8+XYqbQTMPq1BB+V1VrxOpCjz6T/cPUIIwIMJWLfJo=;
 b=rSiXVWtYQ26cqWqMMpAGPOECaU32OFuI5rSD1e1+LPvmd1Oo/cOeR+wzyAQy9bUXG3
 y9UNgg5ERKxad5iE7S1b93UcsU+t3izh+OsdSHM/mmHaZ9C2eqOsY6VLZe8gx7QNlPs0
 mGWQveHuSIXNZobolCP+krrTb25nn84RJWMUQ2IM3kmgC7wYNn9TuVtf8LaHyxdvmWVu
 143vEn3WvTMFQQ//zawwjbBpMJcNfJJlqe1jaPHUPOQkijEPa+htb0hVnq0Vk0TDeDf6
 HAYqTTG091wAKzHlnVbbnx6dMhX9/ZrK3cMaL96L/4g/RAsE8YYhdbq1jkiHKlYQ5FCD
 ffAQ==
X-Gm-Message-State: AOJu0YytkD0fv9gl87cUzSI6edIqor61YWHOUcazrb1sUhpRNFf4Uqdq
 Ymk9y3dWqTejkTjVcmJjTvEd0NeD2HWY/TN72mCw1YUr35ORwuG/lfDj08BDb5gsQ3YQ1RJWWTX
 lm3eIX1wuIKg5PhPM7yK/ICBmbK8rIVmfCfejJsSWywUCDjOc+1ILy1mFn9lLMjUtaNv0vU0j6b
 svJvUETESpsLiGqaNWBZhXt7aBQec4fENTNPdg
X-Received: by 2002:a05:6512:5d0:b0:524:652e:1696 with SMTP id
 2adb3069b0e04-52b896cac46mr7672214e87.60.1717483566388; 
 Mon, 03 Jun 2024 23:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlywvBJ8xrnNB8E69+mDsuaQjlEWpJxczr73wqULn8rzWPA59KqjG2cvRRXfYW8qt1hmYvdQ==
X-Received: by 2002:a05:6512:5d0:b0:524:652e:1696 with SMTP id
 2adb3069b0e04-52b896cac46mr7672196e87.60.1717483565918; 
 Mon, 03 Jun 2024 23:46:05 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31bb8247sm6720784a12.30.2024.06.03.23.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:46:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dov Murik <dovmurik@linux.ibm.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 41/45] i386/sev: Reorder struct declarations
Date: Tue,  4 Jun 2024 08:44:05 +0200
Message-ID: <20240604064409.957105-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Dov Murik <dovmurik@linux.ibm.com>

Move the declaration of PaddedSevHashTable before SevSnpGuest so
we can add a new such field to the latter.

No functional change intended.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-23-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 84 +++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 73f94067155..3fce4c08ebb 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -46,6 +46,48 @@ OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
 OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
 OBJECT_DECLARE_TYPE(SevSnpGuestState, SevCommonStateClass, SEV_SNP_GUEST)
 
+/* hard code sha256 digest size */
+#define HASH_SIZE 32
+
+typedef struct QEMU_PACKED SevHashTableEntry {
+    QemuUUID guid;
+    uint16_t len;
+    uint8_t hash[HASH_SIZE];
+} SevHashTableEntry;
+
+typedef struct QEMU_PACKED SevHashTable {
+    QemuUUID guid;
+    uint16_t len;
+    SevHashTableEntry cmdline;
+    SevHashTableEntry initrd;
+    SevHashTableEntry kernel;
+} SevHashTable;
+
+/*
+ * Data encrypted by sev_encrypt_flash() must be padded to a multiple of
+ * 16 bytes.
+ */
+typedef struct QEMU_PACKED PaddedSevHashTable {
+    SevHashTable ht;
+    uint8_t padding[ROUND_UP(sizeof(SevHashTable), 16) - sizeof(SevHashTable)];
+} PaddedSevHashTable;
+
+QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
+
+#define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
+typedef struct __attribute__((__packed__)) SevInfoBlock {
+    /* SEV-ES Reset Vector Address */
+    uint32_t reset_addr;
+} SevInfoBlock;
+
+#define SEV_HASH_TABLE_RV_GUID  "7255371f-3a3b-4b04-927b-1da6efa8d454"
+typedef struct QEMU_PACKED SevHashTableDescriptor {
+    /* SEV hash table area guest address */
+    uint32_t base;
+    /* SEV hash table area size (in bytes) */
+    uint32_t size;
+} SevHashTableDescriptor;
+
 struct SevCommonState {
     X86ConfidentialGuest parent_obj;
 
@@ -128,48 +170,6 @@ typedef struct SevLaunchUpdateData {
 
 static QTAILQ_HEAD(, SevLaunchUpdateData) launch_update;
 
-#define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
-typedef struct __attribute__((__packed__)) SevInfoBlock {
-    /* SEV-ES Reset Vector Address */
-    uint32_t reset_addr;
-} SevInfoBlock;
-
-#define SEV_HASH_TABLE_RV_GUID  "7255371f-3a3b-4b04-927b-1da6efa8d454"
-typedef struct QEMU_PACKED SevHashTableDescriptor {
-    /* SEV hash table area guest address */
-    uint32_t base;
-    /* SEV hash table area size (in bytes) */
-    uint32_t size;
-} SevHashTableDescriptor;
-
-/* hard code sha256 digest size */
-#define HASH_SIZE 32
-
-typedef struct QEMU_PACKED SevHashTableEntry {
-    QemuUUID guid;
-    uint16_t len;
-    uint8_t hash[HASH_SIZE];
-} SevHashTableEntry;
-
-typedef struct QEMU_PACKED SevHashTable {
-    QemuUUID guid;
-    uint16_t len;
-    SevHashTableEntry cmdline;
-    SevHashTableEntry initrd;
-    SevHashTableEntry kernel;
-} SevHashTable;
-
-/*
- * Data encrypted by sev_encrypt_flash() must be padded to a multiple of
- * 16 bytes.
- */
-typedef struct QEMU_PACKED PaddedSevHashTable {
-    SevHashTable ht;
-    uint8_t padding[ROUND_UP(sizeof(SevHashTable), 16) - sizeof(SevHashTable)];
-} PaddedSevHashTable;
-
-QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
-
 static Error *sev_mig_blocker;
 
 static const char *const sev_fw_errlist[] = {
-- 
2.45.1


