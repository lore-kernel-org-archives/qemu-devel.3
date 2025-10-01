Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D97CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zyL-0004Sx-FJ; Wed, 01 Oct 2025 12:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxU-00042d-De
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxG-0008ED-7D
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so6967f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759337113; x=1759941913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZF0/7NKHmGsxltQLUgG2+GyvAElBS9/WQenlIVcQwVI=;
 b=ZYM/xCt7ESJxgNIt/WwH6eaOExdi2w4LSG7mSl4iDpZMClKxNFTEmw3EyO4vNkD+9u
 v4rbt3V4TfY9Ve0tNChnbZuuQObjPfjrhVuYdkw6eNNmaG9ceuKxztm2xoV5tyhk1Cmb
 3Nn3+POdP4HqjagkiOSxaVTT0QWhwJpV5Tt0T/qYP84Iy7otWOAOP0HL1U8Bz67chOFL
 gB5nK5j2AsWOgEnzMWJWGmIvbFQS5b7+Gtfd+6zPwbS3KBAxG5+SSn5bDER33NCTgPsy
 HYVudaBLELx2uCxvqxiYT+pVk2Po5jEbmW8xjlHvGwcvxQF4oVpfi82N4YreVI9KHvmn
 kKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759337113; x=1759941913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZF0/7NKHmGsxltQLUgG2+GyvAElBS9/WQenlIVcQwVI=;
 b=KaatQWN9xYpyRTYmTi43jnhLvFXO8sX+MvjV/7bpi2zrNo8gi1K48WohYM+OOCVc9t
 Re5pglTjt2Ph4vVFZ7fLSYziE2fYemKW4J274KPuh0ubzmRZsOFNNdTfT4Vi+b/sH24o
 3xSrno3FUJDsjuR/j5Ujri0YUd3XzO0ueOSikqO7sghgtph1NZlJdiYsXnAEQxr84jI2
 hu9t8oNK2O3TMkk7tpjgvloqyYvt+YLpyc+eTysRNtvzk7fgnFyow3+2PkQDXa26uPim
 68kLtaaUqkDJFt5Zm6EgOqu3Ec7MgsNUMv8HjCM6H2AFfIyGffe3LunG3WK7jIX6YeKO
 glOA==
X-Gm-Message-State: AOJu0YyKG2tFXiZdFOwBEURFWJ1ga+alufYW5M0765PYlCqPVRlQ8M6H
 SyY7PMMCvhdT7W80glPYMp/mYTw3QQI4Glla0BHhwsEHVKWZRl55noggxI9jPkY85lP+wjReaf5
 VTXdNlHYv6Q==
X-Gm-Gg: ASbGncvgdjqoeL59vT0JwYGR5xCBbWU77oEUiSnx1wHs/6WLQDMemUSSaF1Gv4lr+UX
 CBjH7wdAvh5KRPsAN6U88ZYod+urzOhPyCblDu2CD/J+fxqhY7q2a+8P/WI/ol8dew0+inDSSys
 ZFAEMIIhLKrqQEQJeoGF7o3tTqrvJ1D4gx3pfEUi932wj2bBd+ohAFe7f489CJHS+0QsER/8/7s
 3kJmOK0IvEIoB8UH3rQXC9lSNH+LaWaFF9wxACcarW5YF9ITbbQ7s90DMPR5DZHZ7vFhgMljPup
 qDaHIPP6g3OTLwOT3njx/BVXuzFQenQFKNfw/l965fJu9qPlyfs96+txf6U1U1zHT13PCo+VPKt
 oDu/QGRTCydRL2FJeQhZCdbESR3fEPgRrMYBPn/+8/Qob2rFjqtPJB3+ZK3nnWcMJjlh1+g0tD5
 Ig5CByc+jKi2fEmvies0if
X-Google-Smtp-Source: AGHT+IFnPvn/75MQHEavymTCcU+aMgCbscZUZr4f9pa21JdkbQhKSiJMn9TY1QMBoMpVPn0VhJXgoQ==
X-Received: by 2002:a05:6000:2890:b0:413:473f:5515 with SMTP id
 ffacd0b85a97d-4255781b8c5mr3187923f8f.48.1759337113221; 
 Wed, 01 Oct 2025 09:45:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41f00aebdb7sm15112856f8f.57.2025.10.01.09.45.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 09:45:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/6] system/ramblock: Move ram_block_discard_*_range()
 declarations
Date: Wed,  1 Oct 2025 18:44:53 +0200
Message-ID: <20251001164456.3230-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001164456.3230-1-philmd@linaro.org>
References: <20251001164456.3230-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Keep RAM blocks API in the same header: "system/ramblock.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h                 | 3 ---
 include/system/ramblock.h                 | 4 ++++
 accel/kvm/kvm-all.c                       | 1 +
 hw/hyperv/hv-balloon-our_range_memslots.c | 1 +
 hw/virtio/virtio-balloon.c                | 1 +
 hw/virtio/virtio-mem.c                    | 1 +
 6 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f373781ae07..e413d8b3079 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -163,9 +163,6 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len);
 typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
-int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
-                                        size_t length);
 
 /* Returns: 0 on success, -1 on error */
 int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 7059b20d919..530c5a2e4c2 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -103,6 +103,10 @@ struct RamBlockAttributes {
     QLIST_HEAD(, RamDiscardListener) rdl_list;
 };
 
+int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+                                        size_t length);
+
 RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block);
 void ram_block_attributes_destroy(RamBlockAttributes *attr);
 int ram_block_attributes_state_change(RamBlockAttributes *attr, uint64_t offset,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9060599cd73..e3c84723406 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -32,6 +32,7 @@
 #include "system/runstate.h"
 #include "system/cpus.h"
 #include "system/accel-blocker.h"
+#include "system/ramblock.h"
 #include "accel/accel-ops.h"
 #include "qemu/bswap.h"
 #include "exec/tswap.h"
diff --git a/hw/hyperv/hv-balloon-our_range_memslots.c b/hw/hyperv/hv-balloon-our_range_memslots.c
index 1505a395cf7..1fc95e16480 100644
--- a/hw/hyperv/hv-balloon-our_range_memslots.c
+++ b/hw/hyperv/hv-balloon-our_range_memslots.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/ramblock.h"
 #include "hv-balloon-internal.h"
 #include "hv-balloon-our_range_memslots.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index db787d00b31..02cdd807d77 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -23,6 +23,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/boards.h"
 #include "system/balloon.h"
+#include "system/ramblock.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "system/address-spaces.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c46f6f9c3e2..1de2d3de521 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -17,6 +17,7 @@
 #include "qemu/units.h"
 #include "system/numa.h"
 #include "system/system.h"
+#include "system/ramblock.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "hw/virtio/virtio.h"
-- 
2.51.0


