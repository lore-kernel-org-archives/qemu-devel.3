Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7909BCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G5O-0003Zw-OZ; Mon, 29 Sep 2025 11:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4k-00031V-Ec
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:46:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4Y-000854-4U
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:46:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso3942672f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759160746; x=1759765546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOipWRU8fk4RKadfaCTuleiBvZNuXiEbbPLdGlI48oU=;
 b=mcje6Uy+t8wz+8HiSBwrffhE53/2BT508rQOSe60dH/eQJQ5NlgdFXXWbXd+ZByhiI
 dqHQLBXXxIy0+fAm92y6AV3ZUjO/A/DmkN/yB5CCWGFZPdW9fknHHPrlOy0anPI0MOfH
 2JrbWwakAA7febOHYiETW+2sNxeICwaG93WrqVAQy0UomLTauSzUW+PIMe1NiPR6PmDN
 ucgyZk8zlB/yN51ylHuEn5MVb+QnzcSkAjQkfGNznwItWbwyHfAiYDon5IKOl/JKFwyV
 VuayfsuzQ9l9PIZWGgDZGu0TlhCsBmzWzq6ayIv7dKKwmWaLmR8DpG2fhza6jp9of4gt
 b9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160746; x=1759765546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOipWRU8fk4RKadfaCTuleiBvZNuXiEbbPLdGlI48oU=;
 b=L06wV036hkTRevJzd1odaAfI2179lK398I+7tJMsSyoYF0MGQPNdBlcVrZPO9ZBG2P
 tiQ+lQlRRtGbaRXk1NLfkwZ+p8bctDmTR9mxFz/mpFtkGPnf7BMp7yqa1xNluxFrZ8FZ
 NTpUD72bFkSfpwp08S7lLjfO/kn4OJmfMT+X1PL2iJGULKzoyxj4eDR85f40cAXCCP6P
 unUk8G+9xU4UdsvP8fNGMkM10oh7Ydq2/iVd9mgNaUsWztTV1Lk436WRacbJogXuvD/C
 IOUurCMUJ98HE4RNdeKzZxaPXHXNgqxRDqZOoXvhFODCMD3LbyGbKjrHO8j1HPOXuP6f
 nprA==
X-Gm-Message-State: AOJu0YyVKLx52NMDruoh3HqDdjju3pRXlXjwM9TwsZIy3SYKpzth2uqZ
 0b7La39p5oc87q7uvAZAqR9z0+PCpbRUzvaHo3ULVWaIv+OaGf8Lu/9lS5EldS0J94aVuaNNM3m
 tX7JsoevhUg==
X-Gm-Gg: ASbGncsKR1WiKjeyYzGQmlF7O1rCLIylZ6HlrdHrUGE3M36bWs7UlD2VCLjsm0K29Lt
 wU4KGeV37gq5Z9c9HSNBCclzMsBtED3Ys0BIdNsT8/8vVPzINIa5y11chyjUeJfF4EWK731CyK5
 6qzAEeJGsHtwcByoL+G+tUHEsG+/cjOG5Nk96zc0808idO9v/t/m54X7Ojy2QnypqscPrMvyPsS
 ACBYnCRDIYsnOrFaHMVspjUWKe27/uxuhktTdmlxaSGchozukAkWCm3d6/7KzihfEdwpbJww0j1
 HVVebAlFCLkLH5dVdywSOSFe3oVfbxzwvZ2bSEU6s+rbinXem/R3ylLaVsS5T83yCWNRHFvAeme
 sNkHXdPlSFnITABBhRIcwphpKftVF0wTyT1czzI8XI7xBeUkjJEuGWGIyttDZy8ddYHscnR2W
X-Google-Smtp-Source: AGHT+IEqDnpJSC0UsoPMmNpmG7ETJKIQx2OcIo9sQftcKrpnYAKz1TRrqCbtGIzqdge9XOJaoUrErg==
X-Received: by 2002:a05:6000:613:b0:3ec:8c8:7b79 with SMTP id
 ffacd0b85a97d-40e4d9ca985mr15223191f8f.61.1759160745826; 
 Mon, 29 Sep 2025 08:45:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e572683ccsm18198795e9.22.2025.09.29.08.45.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 08:45:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 3/6] system/ramblock: Move ram_block_discard_*_range()
 declarations
Date: Mon, 29 Sep 2025 17:45:26 +0200
Message-ID: <20250929154529.72504-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154529.72504-1-philmd@linaro.org>
References: <20250929154529.72504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 12f64fbf78b..e69af20b810 100644
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


