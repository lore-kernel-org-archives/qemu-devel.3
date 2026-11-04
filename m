Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD75606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pw8xqdWH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOXEm-0001dv-VR; Wed, 04 Nov 2026 04:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOXEf-0001cj-MS
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:24:49 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOXEd-0000AC-Ke
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:24:49 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0ADA609D5;
 Wed,  4 Nov 2026 09:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1731F000C1;
 Wed,  4 Nov 2026 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793784277;
 bh=Tg6W3Z+kxMjihx9hBST4llq0xvLeury7LLnVy2GBEXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Pw8xqdWH10SRCDFKIo2Jn5bPTm+l2AHJ2oR3h2wOi5aTEIT09QhkP5iabcr+lsrO1
 r04w/3AHkI05tFqIHv9O2jHXaCeGb/LgZMXTFzOWh17I8Qck2T2UIAqrVFIUaL6n95
 KpWQPQG/p1TGk/HHZxPTFvxMVuW1ltP8tZPIL62moL0aqMcpzgGz9ivhs2ozXzHl64
 Bd1LsWlNyyD0D7oxNgakTg75jEsfqBYCcI1ltUvVtEbDroPyDhGW2wzWM6y7oew+oK
 T/iYvf6NIKcQNQHkeqzc0Tlx7PKNOQj32su4tybr/hi/5u1jOZ8u1L9bnpAQBXCRDS
 l67rkZqZrCW+A==
From: Imre Kaloz <kaloz@kernel.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 2/2] hw/sparc/sun4m: Limit max_mem to what the memory
 controllers decode
Date: Wed,  4 Nov 2026 10:23:16 +0100
Message-ID: <20261104092316.13052-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104092316.13052-1-kaloz@kernel.org>
References: <20261104092316.13052-1-kaloz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=kaloz@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Limit max_mem on each machine to what its memory controller decodes,
instead of the former 60 GiB or 256 MiB, and update the docs. The Voyager
default RAM size becomes 80 MiB so -M Voyager without -m still starts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 docs/system/target-sparc.rst |  6 ++++--
 hw/sparc/sun4m.c             | 17 +++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index 4116cac493..de0acc76dc 100644
--- a/docs/system/target-sparc.rst
+++ b/docs/system/target-sparc.rst
@@ -52,8 +52,10 @@ QEMU emulates the following sun4m peripherals:
 -  CS4231 sound device (only on SS-5, not working yet)
 
 The number of peripherals is fixed in the architecture. Maximum memory
-size depends on the machine type, for SS-5 it is 256MB and for others
-2047MB.
+size depends on the machine type: 512 MiB for the SS-10 and SS-20,
+256 MiB for the SS-5, 160 MiB for the SS-4, 128 MiB for the LX,
+SPARCclassic and SPARCbook, 80 MiB for the Voyager, and 1 GiB for the
+SPARCserver 600MP.
 
 Since version 0.8.2, QEMU uses OpenBIOS https://www.openbios.org/.
 OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 2f4eb19f7f..c586b1c44e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1177,7 +1177,7 @@ static void ss10_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x72,
         .machine_id = ss10_id,
         .iommu_version = 0x03000000,
-        .max_mem = 0xf00000000ULL,
+        .max_mem = 0x20000000, /* 512M: EMC has 29 DRAM address bits */
     };
 
     mc->desc = "Sun4m platform, SPARCstation 10";
@@ -1210,7 +1210,7 @@ static void ss600mp_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x71,
         .machine_id = ss600mp_id,
         .iommu_version = 0x01000000,
-        .max_mem = 0xf00000000ULL,
+        .max_mem = 0x40000000, /* 1G: onboard plus expansion boards */
     };
 
     mc->desc = "Sun4m platform, SPARCserver 600MP";
@@ -1261,7 +1261,7 @@ static void ss20_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x72,
         .machine_id = ss20_id,
         .iommu_version = 0x13000000,
-        .max_mem = 0xf00000000ULL,
+        .max_mem = 0x20000000, /* 512M: SMC has 29 DRAM address bits */
     };
 
     mc->desc = "Sun4m platform, SPARCstation 20";
@@ -1294,11 +1294,12 @@ static void voyager_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = vger_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x05000000, /* 80M: 16M onboard plus two 32M cards */
     };
 
     mc->desc = "Sun4m platform, SPARCstation Voyager";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Fujitsu-MB86904");
+    mc->default_ram_size = 80 * MiB;
     smc->hwdef = &voyager_hwdef;
 }
 
@@ -1327,7 +1328,7 @@ static void ss_lx_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = lx_id,
         .iommu_version = 0x04000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
     };
 
     mc->desc = "Sun4m platform, SPARCstation LX";
@@ -1360,7 +1361,7 @@ static void ss4_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = ss4_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x0a000000, /* 160M: 5 SIMM slots */
     };
 
     mc->desc = "Sun4m platform, SPARCstation 4";
@@ -1392,7 +1393,7 @@ static void scls_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = scls_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
     };
 
     mc->desc = "Sun4m platform, SPARCClassic";
@@ -1424,7 +1425,7 @@ static void sbook_class_init(ObjectClass *oc, const void *data)
         .nvram_machine_id = 0x80,
         .machine_id = sbook_id,
         .iommu_version = 0x05000000,
-        .max_mem = 0x10000000,
+        .max_mem = 0x08000000, /* 128M: microSPARC-I on-chip controller */
     };
 
     mc->desc = "Sun4m platform, SPARCbook";
-- 
2.47.3


