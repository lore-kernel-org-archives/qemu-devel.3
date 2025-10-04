Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5C8CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSQ-0003V9-Lf; Sat, 04 Oct 2025 03:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSO-0003Uh-GM
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSM-0004tD-Im
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so29227455e9.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562004; x=1760166804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zBOoIsCiGpI+RFwPSubFv9Y2+DYez5faZU0y7jrxEo8=;
 b=n4dZJ3Vf9o8sCvBPb8mZnIgmrDAY8dMxkaseyiZeYpGJpEqin+JgPvDBzjKfciQ4a4
 4qwOHrsfzuq9xh2yEVVvWmDaftt1z7l2y8+B+UWIHNcQlOyKRDtqxEzFfqYp7TCKiZvn
 OCF+YMNsiFdc5u4348quT0yO58/M/XIHXpYLb8/1Us2tUOYTa4Ov5C2TM5RmxnnkFar+
 mtO4Uyo0KdymQTCVCrDLkbLSWf/o/7p1FxJUMg1qTvt2GyA/EueE/0pvTZyWZOg+U88P
 1kEUBIba+o/MMW0l21O0cZP9pKowOIMaIoz/3wvfEfqh63oyFc8kJOK0D7W9gbi2nbsy
 0KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562004; x=1760166804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBOoIsCiGpI+RFwPSubFv9Y2+DYez5faZU0y7jrxEo8=;
 b=s3cdK6R6hghz0I7k2BX/53g58/f2pFNIpoY8zwOB9f8j4q1vuFExKHh/0Eo1b+2kxe
 iOy98zMsPKAzX2si7bvXUGL7dVz6nWwvJ1jgWr19lDDfabNRGXX7V5mDhyIA2LrBoh2x
 5/RRNPt0I2sAx9zQF/NkR3csQowzHrZaYuIRipgokQvS06druXE16siMBCMVPQA8Ep6m
 4wQThi0SQOwf+o5QSHrxEcCq6LB6JJ4f3CfJA8bOHzieGGdp40rzycFtws7zXigbl7xu
 JZGA3kkqsWqh3x64WYcgLe/BAavxpiZclcKt+Da6XCeywGx1n9k8HJfBqkeHVaY6SoTM
 Rpqg==
X-Gm-Message-State: AOJu0YzKDj60LIYTbN9cTo4oZMWJ4jYq5eiB4CxSaxl1QkgeuW4alZ3t
 l9lJCgx+PfIcoZQcXNWJxEj1ogxipTtFdxCnlQsOpHjVdD7GCgYxG2/SxIcyhErLcm8IPk4V9Z2
 CevJdarpVjw==
X-Gm-Gg: ASbGncvUJpubQhjJ+bb3se6DEHoKMTDNHeNrfoLRNmhY3aJZppjiVQ7E3igSqgutjSr
 BrQUeD2kuPvB3f/4a2SLssjwU+7mKbGdXFQuS6ZygwmWDl2OfuYjZEE0ry2J8LOF9/XsSMDvH+h
 N7OmGt8VHu9yguwDK6Bef8Cng5uG2khzUAUvgTp6VFMD1piGztVYyLQzovBzfUdy68Y8bGUzkdY
 VFlQXuTdP2NriVNwLvstg3cAXkgBoNIBOVPz6uwNw4snS2OzFeZqJWblF7K02KCCYJHzrauz++p
 BeS70gQSJQfi+FR/rMxio/bLtdjQWORKl4QGwZ0qIaQ2xHVi0ORGP4claeLyxazjx8a02DJjkAB
 wsQR8Awy6HdYIzjXyKxsTyOUXO5ThVbGJW2sqoS6rYcq+fj2ffcRNLwScP07ADBK2I1yYuCOm4x
 yvpM8hcWadsdd7TnXG597GggiZwF3mPij7R8k=
X-Google-Smtp-Source: AGHT+IEiPuV+QzW5hQO/WyzJgglao/oD/eGLm0y0RUq3QHM8qvgS0to1xme5IOTUqJ7nr+kcoAmf5Q==
X-Received: by 2002:a05:600c:4f08:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-46e7608b5camr27005165e9.31.1759562003900; 
 Sat, 04 Oct 2025 00:13:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm66602495e9.20.2025.10.04.00.13.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] system/ramblock: Move ram_block_discard_*_range()
 declarations
Date: Sat,  4 Oct 2025 09:12:29 +0200
Message-ID: <20251004071307.37521-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20251002032812.26069-4-philmd@linaro.org>
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


