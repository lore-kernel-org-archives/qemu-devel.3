Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3536606A337
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=Wh/ultol
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM905-0000vq-C2; Wed, 28 Oct 2026 15:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xM8zx-0000gG-GM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:46 -0400
Received: from itx-kvm-14.itxnorge.no ([91.189.121.228] helo=mx.itxnorge.no)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stian@itx.no>) id 1xM8zv-0004NV-6g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:45 -0400
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
 t=1793214460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Se3Tqd42QQ32UDXnQSKqXA2k9HVBkzu9oIFDqt0m6cI=;
 b=Wh/ultolD2tFPJI+9xVxYNcJ6SNSvoAwYNb2QhYq6d4tSOLCBUrcg5fjvJeEcVGHK80Iff
 CKf/9Uq+k59C6c6CKE4hHb/l9e0n3TiRzwO8VWRls3nM7Jq51zH8lh9VX0xmKhzT7oLpjg
 9hDm2/pG1hcSbABlzaicm5A7saR+/OU=
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stian Halseth <stian@itx.no>
Subject: [PATCH] hw/sparc64: Pass hwcap-list to OpenBIOS via fw_cfg
Date: Wed, 28 Oct 2026 20:07:29 +0100
Message-ID: <20261028190729.1941434-1-stian@itx.no>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=91.189.121.228; envelope-from=stian@itx.no;
 helo=mx.itxnorge.no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux needs hwcap-list to enable crypto instructions, but only sun4v
firmware provides it.

When the CPU has crypto, pass the list through fw_cfg for OpenBIOS
to copy onto the cpu node. Include the capabilities linux-user reports,
since Linux trusts the list instead of guessing.

Without crypto, nothing changes.

Signed-off-by: Stian Halseth <stian@itx.no>
---
Based-on: <20261028113816.1651212-1-stian@itx.no>

This exposes the crypto hwcap to guests, so it should land after the
block-init series, which glibc's memset needs.

The OpenBIOS side, which copies the file onto the cpu node, is on the
OpenBIOS list as "SPARC64: set hwcap-list on the cpu node from fw_cfg".
The kernel change to read the property on sun4u goes to sparclinux.

 hw/sparc64/sun4u.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index a348096aee..7e38a55102 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -121,6 +121,51 @@ static void fw_cfg_boot_set(void *opaque, const char *boot_device,
     fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
 }
 
+/*
+ * OpenBIOS copies this list to the cpu node's hwcap-list property
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
@@ -717,6 +762,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
+    fw_cfg_build_hwcap_list(fw_cfg, cpu);
 
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 
-- 
2.43.0


