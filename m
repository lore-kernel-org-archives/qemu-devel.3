Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E15CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 03:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4A06-0004UU-9j; Wed, 01 Oct 2025 23:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zw-0004U8-I0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:56 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zm-0004Zk-B9
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so4770455e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759375712; x=1759980512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzSBSlHCaylp8fky8q2R9+J/jUXS84YVjjAZKK8ryHc=;
 b=IFbOqfsr+8euKDd8YqD2FgtmK3q4Z9iScUliK18c1uiCikFCtuDK8GJpouGDMwPI3S
 0T9P/fIGQfMAVlWf91IwmMK5vHwTSfwPGXy9uZaDTJQfZ1iYhq068NjUPv/MW9fPdW0F
 U8xcm37ku3GdCr7EdBoYjUtxCd+Tk9enaArqg/BC9mpTUelWJ6f362a6QAJvc9kcQzND
 FmdSmsOf6kYxB6uLtIZnP+v335gx+nw0fd1MptR0qdsMVOAwX51uamY7hF7vltCmv/7h
 0/ZkO+ZF8GE6ADq3of1Fi0Vfm0y+MypBvLX4Eihvzwu2Rm4sa5pOK7Vkj1FkrKUc9A0s
 bJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759375712; x=1759980512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzSBSlHCaylp8fky8q2R9+J/jUXS84YVjjAZKK8ryHc=;
 b=S9LR0e/hjpmeOFlIJ1sZMk9U0G6dbVTLzTXLaQVhgdnK0fcoVtBzLSQiYFZgRsKKvU
 nAqKzyt+uCS5sGV9qP0EoHlQWE5ocNDtQKtjEQcjTv+RyU7uDKKFfnskzBGjkoUnLi38
 su4KIhyjBZaWcvWdLpk8CsVjcOfX82D1oP8OE/OGHcA0GbxF2b4SsbfIRDawb27zqnx1
 4owKOhYMXPa+w0d0IDGQW1txcwMJ5h7Ohm9BcePHAZgkc/b+BCxQMzWilK4IY2fcV+jO
 pWdePuweZJwce7z/KMEeP3viQvc4ZYGUEsrRW9FNlqn8bU5CBM+5fP5/6H1FAXaLmFFG
 jojA==
X-Gm-Message-State: AOJu0Yw1Q2nVgVd5j5OKZs7QL6a3z0uO0rIGQvMe2WHvZCLPJ4/HZCTB
 CUL4O9y2bHAvqvcb5n9peZlC7bbsaomT1h5aMp92Mjs7mr1jroviO5er97f/GdZ3Rkz7JS22xZL
 1C+ncNr4YHQ==
X-Gm-Gg: ASbGncsJULkRmaF8rsjfeLlIxhnEvbLcIwaTs2M6mp2F6Pq9bmuS8hJJuKC3mYPOWa1
 eatX38dqKIotRaE4K/u75TbhV6vc9jcFIORAb/UpHc2XDTcIbkKkKOsVvMvey0fvdnhQmWsTYhH
 4dG9KHUMksLOYf07s42n8pjvP02aDHKT5LUgRZJqeMI0Oo/flzREb4tnklQADKMOwVKu7nMWPN3
 0lySAO1YjmveAHUIu0fup8mhRPdZoOcYnnTMoySUsmYWKINNkLRwfiJ/on8Tcex0CVTTFAlBSss
 wUNOMGvdgLftMbtExoQ9ZQjwmFYEd/ecrYzyCLbFx3XeYVDGxAOeaFEiBwBl16geuqOELB6X5L7
 rgA5ifmENlP3Wso1xXuRlz6mSShY0NkGEemsjupCetxeC53eHZZiyfUGYHok45pPGfBjMIXSMup
 cvX13Fv3EmrRbHWmRo2npXvxSPmAvFZ7k2Rl/Bjx16
X-Google-Smtp-Source: AGHT+IFI90XTy9jeau0chMpSrKJtHcRaacrHSXE9+mPhxzMInivlCbyXQQVWlV2ajvnKP0lGmemyFQ==
X-Received: by 2002:a05:600c:8b02:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e612dafafmr47030715e9.31.1759375711852; 
 Wed, 01 Oct 2025 20:28:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97f0sm1578485f8f.27.2025.10.01.20.28.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 20:28:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 3/5] system/ramblock: Move ram_block_discard_*_range()
 declarations
Date: Thu,  2 Oct 2025 05:28:10 +0200
Message-ID: <20251002032812.26069-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002032812.26069-1-philmd@linaro.org>
References: <20251002032812.26069-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


