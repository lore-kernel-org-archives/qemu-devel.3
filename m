Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EE7D148B3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 07:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdk6U-0006tu-KM; Thu, 08 Jan 2026 02:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6Q-0006kj-2X
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdk6M-0006bI-Nk
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 02:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bcl23ps/bK4EauZ2W48nVvpVqg5Y5Ps47IeSDNjIedc=;
 b=hL1FSdZE61TiNjt/6U39Phak3LndEbEq6+JdWc4mjqRqYsDH4kcC+RCh8N8Dpc2+MYwrX0
 WoSOnAm7QSt4VXoYJG+as3b+mx95t6Oiialvuh+1RlDiUyLNr0HX/UTizSx7LaVnPtVW+C
 gRt9PJgVkLx7Xsrr6p8Vrnav+N4h8Dc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-wbLIreZFM1W4nEQg2GwIag-1; Thu,
 08 Jan 2026 02:06:30 -0500
X-MC-Unique: wbLIreZFM1W4nEQg2GwIag-1
X-Mimecast-MFC-AGG-ID: wbLIreZFM1W4nEQg2GwIag_1767855989
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373C21956094; Thu,  8 Jan 2026 07:06:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59BC9180009E; Thu,  8 Jan 2026 07:06:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8C1821E61A5; Thu, 08 Jan 2026 08:06:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL v2 01/17] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
Date: Thu,  8 Jan 2026 08:06:09 +0100
Message-ID: <20260108070625.1586474-2-armbru@redhat.com>
In-Reply-To: <20260108070625.1586474-1-armbru@redhat.com>
References: <20260108070625.1586474-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251119130855.105479-2-armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/core/loader.h |  4 +++-
 hw/arm/boot.c            |  6 +-----
 hw/core/loader.c         |  8 ++++++--
 hw/riscv/spike.c         | 10 +---------
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
index d035e72748..6f91703503 100644
--- a/include/hw/core/loader.h
+++ b/include/hw/core/loader.h
@@ -188,8 +188,10 @@ ssize_t load_elf(const char *filename,
  *
  * Inspect an ELF file's header. Read its full header contents into a
  * buffer and/or determine if the ELF is 64bit.
+ *
+ * Returns true on success, false on failure.
  */
-void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
+bool load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
 
 ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
                   bool big_endian, hwaddr target_page_size);
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 0ba3adaf81..e22609de93 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -766,16 +766,12 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     int data_swab = 0;
     int elf_data_order;
     ssize_t ret;
-    Error *err = NULL;
 
-
-    load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
-    if (err) {
+    if (!load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, NULL)) {
         /*
          * If the file is not an ELF file we silently return.
          * The caller will fall back to try other formats.
          */
-        error_free(err);
         return -1;
     }
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8252616fdd..89d67d2760 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -364,8 +364,9 @@ const char *load_elf_strerror(ssize_t error)
     }
 }
 
-void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
+bool load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
 {
+    bool ok = false;
     int fd;
     uint8_t e_ident_local[EI_NIDENT];
     uint8_t *e_ident;
@@ -380,7 +381,7 @@ void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Failed to open file: %s", filename);
-        return;
+        return false;
     }
     if (read(fd, hdr, EI_NIDENT) != EI_NIDENT) {
         error_setg_errno(errp, errno, "Failed to read file: %s", filename);
@@ -415,8 +416,11 @@ void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
         off += br;
     }
 
+    ok = true;
+
 fail:
     close(fd);
+    return ok;
 }
 
 /* return < 0 if error, otherwise the number of bytes loaded in memory */
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 1493b928da..35c696f891 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -180,15 +180,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
 
 static bool spike_test_elf_image(char *filename)
 {
-    Error *err = NULL;
-
-    load_elf_hdr(filename, NULL, NULL, &err);
-    if (err) {
-        error_free(err);
-        return false;
-    } else {
-        return true;
-    }
+    return load_elf_hdr(filename, NULL, NULL, NULL);
 }
 
 static void spike_board_init(MachineState *machine)
-- 
2.52.0


