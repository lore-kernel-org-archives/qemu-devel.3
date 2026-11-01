Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F552606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=ilande.co.uk header.i=@ilande.co.uk header.a=rsa-sha256 header.s=20220518 header.b=TwePJzXn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWTL-0004U8-4N; Sun, 01 Nov 2026 09:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWT0-0004SF-Qj
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:27 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1xNWSy-0007aX-3M
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=8zNnqYIDSCvwYak7neqsQryPbDLAbo8KJnEBAhHIPQs=; b=TwePJzXnIJBoTljlMQ6aFk74Wt
 nOqgbcWHzdsqI+5VwuHaGckp8JegxZ0In4kFKBrPz61btUZOcraaXPMyN2s9uR5E/nQrALVA5r118
 6YF0BZvnx1RfqIw91mKZLqPOZXdJxCx+qLBUPXnz1QM3N7OjQRY+XxWYdPvk7OPTd/flFp1IvRM3f
 oDeLxn2zzxsySadFjqKW46obLoyqm+YgCeenyWIfqvtwaHS4mNGmVJqOQENIdA814WjupH6G4ewyI
 Dro8h/z/2581q0PeUzOcqy7Z3i+hk/TzXcaTJ7kvwbTo+DyiKa30KZCeUhw1w8ycxQDJAHCkt6V2C
 ZGDOGorhqOyD4HNMLIsGgXZ4mQbfknuuPcLq8aU+Ab3iu6Aykx9PYJ+sVaa5B4YGr/92zR9vK4BPH
 G45Pwz2NWqUWxndVatiJxC7kLlBsVqxhYuTJQxXJUsEH1H1S0DhbNs/Nc1e65NNaDh/MMOigsBgyF
 an7GYfz/ioIwypiox1x9RgXvFvtSMjKgxzGQZAWb4x68c5rcvi3gnrNa3JAdewDnrI0wKK6lMByGr
 lcDD81yEjRmBNriYfICUINFgUWior/MRqopEWgC8gE+kXcGCbVg/NkwzaafkiTvylYwVcl/rvsc/J
 NkHJ3QZGz9aJLj0+wE1RSwc0AsYpcQBEAtsSuv/tc=;
Received: from [2a02:8012:2f01:0:fe49:60b9:9856:b8ef]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1xNWS8-0055Ed-4Q
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 14:22:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org
Date: Sun,  1 Nov 2026 14:22:53 +0000
Message-ID: <20261101142312.983515-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
References: <20261101142312.983515-1-mark.cave-ayland@ilande.co.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:fe49:60b9:9856:b8ef
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 3/3] hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stian Halseth <stian@itx.no>

Linux needs hwcap-list to enable crypto instructions, but only sun4v
firmware provides it.

When the CPU has crypto, pass the list through fw_cfg for OpenBIOS
to copy onto the cpu node as qemu,hwcap-list. Include the capabilities
linux-user reports, since Linux trusts the list instead of guessing.

Without crypto, nothing changes.

Signed-off-by: Stian Halseth <stian@itx.no>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261031094841.3407049-1-stian@itx.no>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index a348096aee6..1057c591526 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -121,6 +121,52 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
+/*
+ * OpenBIOS copies this list to the cpu node's qemu,hwcap-list property
+ * for Linux, which gets it from the machine description on sun4v.
+ */
+static void fw_cfg_build_hwcap_list(FWCfgState *fw_cfg, SPARCCPU *cpu)
+{
+    static const struct {
+        uint32_t mask;
+        const char *name;
+    } capabilities[] = {
+        { 0, "popc" },
+        { CPU_FEATURE_FSMULD, "fsmuld" },
+        { CPU_FEATURE_VIS1, "vis" },
+        { CPU_FEATURE_VIS2, "vis2" },
+        { CPU_FEATURE_FMAF, "fmaf" },
+        { CPU_FEATURE_VIS3, "vis3" },
+        { CPU_FEATURE_IMA, "ima" },
+        /* The groups in the CFR value, see CFR_* in target/sparc/translate.c */
+        { CPU_FEATURE_CRYPTO, "aes" },
+        { CPU_FEATURE_CRYPTO, "sha1" },
+        { CPU_FEATURE_CRYPTO, "sha256" },
+        { CPU_FEATURE_CRYPTO, "sha512" },
+        { CPU_FEATURE_CRYPTO, "crc32c" },
+    };
+    uint32_t features = cpu->env.def.features;
+    GByteArray *array;
+    size_t len;
+
+    if (!(features & CPU_FEATURE_CRYPTO)) {
+        return;
+    }
+
+    array = g_byte_array_new();
+    for (size_t i = 0; i < ARRAY_SIZE(capabilities); i++) {
+        if ((features & capabilities[i].mask) == capabilities[i].mask) {
+            const char *name = capabilities[i].name;
+
+            g_byte_array_append(array, (const guint8 *)name, strlen(name) + 1);
+        }
+    }
+
+    len = array->len;
+    fw_cfg_add_file(fw_cfg, "etc/sparc64/hwcap-list",
+                    g_byte_array_free(array, FALSE), len);
+}
+
 static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
                                   const char *arch, ram_addr_t RAM_size,
                                   const char *boot_devices,
@@ -717,6 +763,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
+    fw_cfg_build_hwcap_list(fw_cfg, cpu);
 
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 
-- 
2.47.3


