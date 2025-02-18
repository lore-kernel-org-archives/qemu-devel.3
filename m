Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A3AC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 21:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkV2I-00034A-I9; Tue, 18 Feb 2025 16:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2E-00032m-Nr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:42 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tkV2B-00033S-V3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 16:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913698; bh=86QjUrEhAuhhbXN0b8DnVM4v1JDgzxiyHIi3K8dZDjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Uub6E4KCzOJqh67mOc6PRlNn2CRUdj/jntCwFdwF0mcqloJDQ7uR1dTGAofYOdaR1
 /QHt5N7LkAEZK2vIWk9J2KO04GbswweA6iIObJEchfAbhxLh8suWK4/kV3hdcR+50a
 LyZyJYLRs2wMPQO+kZqyOQtKZ/z0vdL3aTDh0i8/t7L+zY6TZRHwo+n8nTsO+VAcx0
 1vHnRIGsyesvILOXUVYvDnIf9TP8Ejbxz9G/hE+Ph0o+VmmX7Ajans6IrTXD7e+Vhd
 9us0yEVCMiTEDftbJoeMryoMDiZOYI/ZSwgVhMdUBc81n+NgipY6YDcuLTQ2Oyvfgy
 3mcWKv9KmBwrg==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id BBC813F20C61
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 13:21:38 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id iT7caFC17IXn; Tue, 18 Feb 2025 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739913694; bh=86QjUrEhAuhhbXN0b8DnVM4v1JDgzxiyHIi3K8dZDjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WAUVOqTsOyKQla6hHO/qlMj3gZi1+LoGo6453tTBprxpUglA1GtsygF3+yCu6cSDl
 XrOLgKIZnV+VHB/Xn9cCGdMRUnPtGdCZLADUGuXQ6+JQMGpxYo118PQAB/flEuM+tb
 qvg2g+s473eu0EWle7uQi87QgxwTRW/hEsPbjUeHHm+GxCWXtce+UrGZgrlvwiT+Bb
 iO3e4fkjCDhopZ0N5jUr8hKfDGEW9EbAwS6E/asG5BkKeZN5bHaqvFwRnkoMJ02Uw5
 KjcpJbs6NrxurZbs1wXh9DbCb218yPis3P96hLUNFDIHHsD4JVBg6YaezJ9jMpN3LE
 qv1DnTo4aqbBw==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id EDC3E3F22241;
 Tue, 18 Feb 2025 13:21:34 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id C0ADE1E6009F; Tue, 18 Feb 2025 13:21:34 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 4/4] rx: Support loading of ELF files too
Date: Tue, 18 Feb 2025 13:21:03 -0800
Message-ID: <20250218212103.2024039-5-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218212103.2024039-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
 <20250218212103.2024039-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The existing loader supports raw binary blobs with the entry point
defined as the start of the blob. Add support for loading ELF files by
first checking if the provided filename has a valid ELF header,
falling back to the existing loader code when that fails.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/rx/rx-gdbsim.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 9e395ae345..58492b713f 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -25,6 +25,7 @@
 #include "exec/cpu_ldst.h"
 #include "hw/loader.h"
 #include "hw/rx/rx62n.h"
+#include "elf.h"
 #include "system/qtest.h"
 #include "system/device_tree.h"
 #include "system/reset.h"
@@ -85,6 +86,37 @@ static void rx_cpu_reset(void *opaque)
     }
 }
 
+static bool rx_load_elf(RXCPU *cpu, const char *filename)
+{
+    CPUState *cs = CPU(cpu);
+    Elf32_Ehdr elf_header;
+    bool elf_is64;
+    Error *err = NULL;
+    uint64_t lowaddr, highaddr, entry;
+    ssize_t ret;
+
+    load_elf_hdr(filename, &elf_header, &elf_is64, &err);
+    if (err) {
+        error_free(err);
+        return false;
+    }
+
+    ret = load_elf_as(filename, NULL, NULL, NULL,
+                      &entry, &lowaddr, &highaddr, NULL, false,
+                      EM_RX, 1, 0, cs->as);
+
+    if (ret <= 0) {
+        /* The header loaded but the image didn't */
+        error_report("qemu: could not load elf '%s': %s",
+                     filename, load_elf_strerror(ret));
+        exit(1);
+    }
+
+    cpu->env.reset_pc = entry;
+    cpu->env.use_reset_pc = true;
+    return true;
+}
+
 static void rx_load_image(RXCPU *cpu, const char *filename,
                           uint32_t start, uint32_t size)
 {
@@ -92,6 +124,10 @@ static void rx_load_image(RXCPU *cpu, const char *filename,
     long kernel_size;
     int i;
 
+    if (rx_load_elf(cpu, filename)) {
+        return;
+    }
+
     kernel_size = load_image_targphys(filename, start, size);
     if (kernel_size < 0) {
         fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
-- 
2.47.2


