Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC2EA3C55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 11:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAnx9-0006Fm-SO; Thu, 09 Apr 2026 07:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wAnx8-0006FR-Ue
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:53:42 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>) id 1wAnx7-0000DX-E8
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 07:53:42 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5106420B710C;
 Thu,  9 Apr 2026 04:53:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5106420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1775735619;
 bh=A2gkHzyyrgJ48tKH/NCs6vPTaw/e/Fxg1+vebw64BvU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=d0QaIUOGkgNgLtMF7F4SnXDYriMh3mO/8k0r79DN+v/69py14Pylv09AVzopb6gnS
 Q7AE3YQJzqJfhJy8/cr3HfiOY/8ADXbVSclCGK/5YvziSDgkN1lTl6xq6xx0EXWE1i
 QVSK5GaUtyQco7vIHjTghA3KVIoEvSh4roepkzrE=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Thu, 09 Apr 2026 11:53:06 +0000
Subject: [PATCH 1/2] accel/mshv: fix ioeventfd deassignment to forward
 correct datamatch value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-fix_ioevent-v1-1-053b810ae6fb@linux.microsoft.com>
References: <20260409-fix_ioevent-v1-0-053b810ae6fb@linux.microsoft.com>
In-Reply-To: <20260409-fix_ioevent-v1-0-053b810ae6fb@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

unregister_ioevent() is not forwarding the datamatch (queue index) to
the mshv driver, causing only the first VirtIO-MMIO queue to be
deassigned correctly. Subsequent queues fail with `-ENOENT`, triggering
a fatal abort().

This failure was discovered while booting arm64 EDK2 firmware with mshv
accel.

Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d4cc7f5371..e1a8d62f8d 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -278,13 +278,22 @@ static int ioeventfd(int vm_fd, int event_fd, uint64_t addr, Datamatch dm,
     return ioctl(vm_fd, MSHV_IOEVENTFD, &args);
 }
 
-static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr)
+static int unregister_ioevent(int vm_fd, int event_fd, uint64_t mmio_addr,
+                              uint64_t data, uint32_t len, bool data_match)
 {
     uint32_t flags = 0;
     Datamatch dm = {0};
 
     flags |= BIT(MSHV_IOEVENTFD_BIT_DEASSIGN);
-    dm.tag = DATAMATCH_NONE;
+    if (!data_match) {
+        dm.tag = DATAMATCH_NONE;
+    } else if (len == sizeof(uint64_t)) {
+        dm.tag = DATAMATCH_U64;
+        dm.value.u64 = data;
+    } else {
+        dm.tag = DATAMATCH_U32;
+        dm.value.u32 = data;
+    }
 
     return ioeventfd(vm_fd, event_fd, mmio_addr, dm, flags);
 }
@@ -337,11 +346,12 @@ static void mem_ioeventfd_del(MemoryListener *listener,
     int fd = event_notifier_get_fd(e);
     int ret;
     uint64_t addr = section->offset_within_address_space;
+    uint64_t len = int128_get64(section->size);
 
     trace_mshv_mem_ioeventfd_del(section->offset_within_address_space,
                                  int128_get64(section->size), data);
 
-    ret = unregister_ioevent(mshv_state->vm, fd, addr);
+    ret = unregister_ioevent(mshv_state->vm, fd, addr, data, len, match_data);
     if (ret < 0) {
         error_report("Failed to unregister ioeventfd: %s (%d)", strerror(-ret),
                      -ret);

-- 
2.45.4


