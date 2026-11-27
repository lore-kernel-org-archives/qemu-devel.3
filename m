Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=x59G8KuI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp9n-0005aI-Fk; Fri, 27 Nov 2026 01:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8i-0007zA-3K; Fri, 27 Nov 2026 01:08:56 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8e-0000NH-U5; Fri, 27 Nov 2026 01:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=cOkT3Nt28S6VeVnrazZQae4AwPt/CupT90ol7H/THAw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=x59G8KuIsMbwXreLFF4eXdBHgb6AxfvQjemwrlVSSokz2pPCBty3R82kPWEoVP159
 DYspDEzOvShLhz9BEOuDNH28m4KdTXMQVJkLacb35B6ZplltlTieNImasuldZ1Y7eM
 1iH5z8i+as8Rq4Isy3T0T8XAyUPjEsAwZJHH0RV+0B/l6OP6WydM0IsQanyvY/iLgG
 93QqugLYao7J38IJcSHxwqL4CHwzQiy5BZh3PXqqz2uUnhrHK+2HFdN/oycrd29FYl
 p423/SzxiosnuuLxHjXsTQU8GOfxOmBU7xNd13RdFhe/HP4WnfXZu0Sl54ZUCjt57v
 AV5BbN3wHsnZQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 452321EA36F;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 432A446999A;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1D338CF32C; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 125/152] hw/nvme: fix zone descriptor extension
 allocation overflow
Date: Fri, 27 Nov 2026 08:54:23 +0300
Message-ID: <20261127055709.39630-62-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_ns_zoned_init_state sizes the zone descriptor extension array
with 32-bit arithmetic. A large enough zone extension size and number of
zones will wrap, causing either null pointer deref on Set Zone
Descriptor Extension or an out-of-bounds write.

nvme_get_zd_extension has the same problem.

Fix the initialization by using g_malloc0_n and compute the per-zone
offset using 64-bit arithmetic.

Cc: qemu-stable@nongnu.org
Fixes: 1a9290ade33a ("hw/block/nvme: Support Zone Descriptor Extensions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4730
Reported-by: Karl Mehltretter
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 63c9653696862f55646fa7a88833857cabb6a07d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 16524f2d915..5d20f230018 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -249,8 +249,8 @@ static void nvme_ns_zoned_init_state(NvmeNamespace *ns)
 
     ns->zone_array = g_new0(NvmeZone, ns->num_zones);
     if (ns->params.zd_extension_size) {
-        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
-                                      ns->num_zones);
+        ns->zd_extensions = g_malloc0_n(ns->num_zones,
+                                        ns->params.zd_extension_size);
     }
 
     QTAILQ_INIT(&ns->exp_open_zones);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 43e3c916f73..848786c18b1 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -363,7 +363,8 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
 static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
                                              uint32_t zone_idx)
 {
-    return &ns->zd_extensions[zone_idx * ns->params.zd_extension_size];
+    return ns->zd_extensions + (uint64_t)zone_idx *
+        ns->params.zd_extension_size;
 }
 
 static inline void nvme_aor_inc_open(NvmeNamespace *ns)
-- 
2.47.3


