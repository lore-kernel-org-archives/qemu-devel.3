Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0614BE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsWkb-0008Os-1l; Tue, 17 Feb 2026 20:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWkZ-0008IO-FV; Tue, 17 Feb 2026 20:53:11 -0500
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.1.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWkX-0005Np-Mt; Tue, 17 Feb 2026 20:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771379589; x=1802915589;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=txAK976ulrDqiv5ZANEFUx5CISRFuFCg+v/SRZmWc98=;
 b=UX5cU6Tgc0ErvN/ZR74BqRTw93QESkyTXENKm+ylLUiPRYototq1WGwD
 2JkAfua9uvXJzYhgh0s4rbxia8dewepQdrOb9tErpI2FcmS2nnYisuQcT
 OH1YEMUUrFa9lhyj8iAsMf6kfqaJdvHti7Hfmo1GkHjECwHSKCVkJ7bWD
 TEBefmc54fgQ4Pj1u746qd4BYn15kDyAiIfHSgiiXzR3hySyx4NkbIBqF
 kg7zBTC72Is6BrIkZffwZmBloOlgTCGhLTr9zF3opDGXNYWjKyGjfzH7e
 6BvED03zFjED5B1DXGXQ0PJYcGsx8ltWm/wlWhk41SyLB1Y9DPYq9vVLo A==;
X-CSE-ConnectionGUID: iYHG5GhqSDaRhs0neP8KRQ==
X-CSE-MsgGUID: GZBGa8S1TPOtSK/S1+Rwjg==
X-IronPort-AV: E=Sophos;i="6.21,297,1763424000"; d="scan'208";a="13259296"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:53:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:20099]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.130:2525]
 with esmtp (Farcaster)
 id 478f3760-1228-4186-a2be-98a433dc0f3a; Wed, 18 Feb 2026 01:53:04 +0000 (UTC)
X-Farcaster-Flow-ID: 478f3760-1228-4186-a2be-98a433dc0f3a
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:52:59 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:52:56 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH 08/10] hw/core/eif: Move definitions to header
Date: Wed, 18 Feb 2026 01:51:48 +0000
Message-ID: <20260218015151.4052-9-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260218015151.4052-1-graf@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=44.246.1.125;
 envelope-from=prvs=502105d20=graf@amazon.de;
 helo=pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

In follow-up patches we need some EIF file definitions that are
currently in the eif.c file, but want to access them from a separate
device. Move them into the header instead.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/eif.c | 38 --------------------------------------
 hw/core/eif.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/hw/core/eif.c b/hw/core/eif.c
index 513caec6b4..96f1d76578 100644
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
diff --git a/hw/core/eif.h b/hw/core/eif.h
index fed3cb5514..a3412377a9 100644
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
-- 
2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


