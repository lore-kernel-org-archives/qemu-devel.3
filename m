Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AEDC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzF2r-0006Kh-F5; Mon, 31 Mar 2025 09:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzF2i-0006J8-Fp
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:19:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzF2g-00051h-RQ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:19:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223a7065ff8so65084245ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743427145; x=1744031945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4NVrWdEyfU0wG0uWtwwgd0qzv2VLsdlH2nP1WAvLOU=;
 b=BuvzFWps3G4n20KTbMuGgkT7Qz+1YEtF/bfSjtXdaD+NRC1ByKa1hI8yEupqd3lcga
 E+5opYTI5yW+yP4SQHA3S4rI7bxlQsWdhVl7Na6Zfbp0+EcFmmOlWnwz80GZt1b1hfXG
 +VfN4BHQRPnFin066FPtTpHWASC76gqxvjfUL/PBfIfHkzPG6fyZEUY9S63Y+9YT4x27
 n855FUwy7v1xwlOSBV8e/XMfvMlTNJJLCtjenp95zKyac7xNdheQu6KCgLhYFmZCJspK
 BAFYHogxEA6IelrtsEZfBL+BT7MfxuWMZqUs+NwSmZ/F61WbaOvJRVjUjETrgSHMWEl3
 xymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743427145; x=1744031945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4NVrWdEyfU0wG0uWtwwgd0qzv2VLsdlH2nP1WAvLOU=;
 b=uXGNmH41cXJm6PAoqiVt5tzlf+qfiCrj/BtM+zQQs5tuwCIbz7/ZHGA4x+OMn6bEiW
 ImnnZiIMBJigirMQZA82BDT/oSbHf/OjhynyxlcJcjoh1L5A0cUVbCkQFAMtt5ClfG1q
 4z1qFTN7yN7tRYZGqYbcp/FrfuYrN3FnGqWHOGk70xNPhBOyTsT6f2a4ASGyY+6Cb/2W
 2mPrFXHNqkfLOI/Oi1MEjtca00Oa2B2kXL1wZx/BssTV+WIXS3fTBxMX34Af3Xhm3qd6
 J44qM0wy228y8sXwDq+mXNq+WRWrR0xww7MnTGwWhigK5rSv+2IGOxcjncIDMAVLcfgu
 RQFg==
X-Gm-Message-State: AOJu0YxDAf17yrwwhmaWVABb4e2/0rvI1UVhATlQaohLNkxfR0S701EU
 2Mps72w9W/SViJTXWZu3DWVaJ9mdlKPTlZc4cbMKZBFLv9/jScdDGFnf6Q==
X-Gm-Gg: ASbGncvc3HqeTYOHSg6ZREjYROmJp8A6PpyP2ZD9fAFIXXuXlhNKQjW7cv/ntxmLWsy
 vqV6c7o5W99OYid6+uPQU4t3YQQyBIb8NAKjM2qGyK5BwyMULKPxUgBShEIc5ydxNR9ex+PhRAz
 0/21g7XGQtusLTx+kjs2wKQh4QZu7VA0ouUopczkSAlnUbvxyLYmzSDKISGlJnTtAPlTbZNtuOW
 DuXsUxkcVUz3Dz/lABLrpYyNqA/U1LW2mMh07M9Ws4+ep3gRKdfwdppiuztJCxc74q+eD9AT+YC
 DC6KBPPncW7YBo3VXHbfSs0dPgzTcI9QFg47xoCDxDsWUT5uFA==
X-Google-Smtp-Source: AGHT+IHvQ+1dXnyTvj3kGT4jyuXP9m1rMfUreO6siN59MQVYsI5UDnPcr4udw4jQlKRMLg/Xq6WH/g==
X-Received: by 2002:a05:6a00:170c:b0:730:8a0a:9f09 with SMTP id
 d2e1a72fcca58-7398041c86amr12679240b3a.18.1743427144904; 
 Mon, 31 Mar 2025 06:19:04 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7397109c494sm7090671b3a.136.2025.03.31.06.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 06:19:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 1/2] gdbstub: Improve physical memory access handling
Date: Mon, 31 Mar 2025 23:18:50 +1000
Message-ID: <20250331131852.612406-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331131852.612406-1-npiggin@gmail.com>
References: <20250331131852.612406-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Bring gdb's physical memory access handling up to speed with the CPU
memory access, by setting MemTxAttribute.debug=1, and by checking for
memory transaction errors.

GDB with PhyMemMode will now report failure for memory access outside
valid system memory addresses, and it is also able to write to ROMs as
it can with virtual memory access.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 gdbstub/system.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index dd22ff0fb3a..6a550e229e2 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -17,6 +17,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
+#include "exec/address-spaces.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "system/accel-ops.h"
@@ -453,16 +454,30 @@ void gdb_qemu_exit(int code)
  */
 static int phy_memory_mode;
 
+/*
+ * Like cpu_memory_rw_debug but it operates on the system address space
+ * rather than the CPU's view of memory.
+ */
+static int phys_memory_rw_debug(hwaddr addr, void *buf,
+                                hwaddr len, bool is_write)
+{
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    MemTxResult res;
+
+    attrs.debug = 1;
+    res = address_space_rw(&address_space_memory, addr, attrs,
+                           buf, len, is_write);
+    if (res != MEMTX_OK) {
+        return -1;
+    }
+    return 0;
+}
+
 int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
                                uint8_t *buf, int len, bool is_write)
 {
     if (phy_memory_mode) {
-        if (is_write) {
-            cpu_physical_memory_write(addr, buf, len);
-        } else {
-            cpu_physical_memory_read(addr, buf, len);
-        }
-        return 0;
+        return phys_memory_rw_debug(addr, buf, len, is_write);
     }
 
     if (cpu->cc->memory_rw_debug) {
-- 
2.47.1


