Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2085CFD370
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrqz-0003zg-TC; Tue, 25 Nov 2025 07:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vNrqv-0003yN-RJ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:09:01 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vNrqt-0004hI-7t
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:09:00 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.65])
 by linux.microsoft.com (Postfix) with ESMTPSA id E509E2120E87;
 Tue, 25 Nov 2025 04:08:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E509E2120E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1764072535;
 bh=JTo/K6E/wQATvBEl3UpUlNw2rzMGWy1zwGjD2ibgDwQ=;
 h=From:To:Cc:Subject:Date:From;
 b=nCC5lLWo/JzUuJlge9Ro9dE4FagHL/EoZ+eUgtqVmNIXbVeEB6bwop1BuXGp9B4lB
 kbAHYghmPai9ibUPFF0EB9OBbCrgz/IsWi9vVKMg+Xs2Js9KZQAFdK41gRHGD+8o82
 +Xr1KAW4SOkTFrZ/TNTkg3qAVTsJLflhmllt5VXA=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH] target/i386/mshv: remove unused gpa txl optimization
Date: Tue, 25 Nov 2025 13:08:52 +0100
Message-Id: <20251125120852.250149-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The removed parameters are remnants of a prior attempt to optimize
gva=>gpa translation. Currently there is only one call site and it's
not using it. So we can remove it as dead code.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 1c3db02188..03ef085d5e 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1189,7 +1189,7 @@ static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
     remap_result = mshv_remap_overlap_region(vm_fd, gpa);
     *exit_reason = MshvVmExitIgnore;
 
-    switch (remap_result) {
+   switch (remap_result) {
     case MshvRemapNoMapping:
         /* if we didn't find a mapping, it is probably mmio */
         return handle_mmio(cpu, msg, exit_reason);
@@ -1374,23 +1374,19 @@ static int read_memory(const CPUState *cpu, uint64_t initial_gva,
     return 0;
 }
 
-static int write_memory(const CPUState *cpu, uint64_t initial_gva,
-                        uint64_t initial_gpa, uint64_t gva, const uint8_t *data,
+static int write_memory(const CPUState *cpu, uint64_t gva, const uint8_t *data,
                         size_t len)
 {
     int ret;
     uint64_t gpa, flags;
 
-    if (gva == initial_gva) {
-        gpa = initial_gpa;
-    } else {
-        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
-        ret = translate_gva(cpu, gva, &gpa, flags);
-        if (ret < 0) {
-            error_report("failed to translate gva to gpa");
-            return -1;
-        }
+    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
+    ret = translate_gva(cpu, gva, &gpa, flags);
+    if (ret < 0) {
+        error_report("failed to translate gva to gpa");
+        return -1;
     }
+
     ret = mshv_guest_mem_write(gpa, data, len, false);
     if (ret != MEMTX_OK) {
         error_report("failed to write to mmio");
@@ -1445,7 +1441,7 @@ static int handle_pio_str_read(CPUState *cpu,
     for (size_t i = 0; i < repeat; i++) {
         pio_read(port, data, len, false);
 
-        ret = write_memory(cpu, 0, 0, dst, data, len);
+        ret = write_memory(cpu, dst, data, len);
         if (ret < 0) {
             error_report("Failed to write memory");
             return -1;
-- 
2.34.1


