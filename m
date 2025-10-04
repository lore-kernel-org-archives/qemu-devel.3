Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6C1CCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wWF-00032u-1l; Sat, 04 Oct 2025 03:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wV5-0002Jc-Cv
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wV3-0005Os-2S
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:16:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso18465935e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562169; x=1760166969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b4vT0oHPpE6PzHl8pNB5QhR7O7PRoflwlDAx8XNEBOc=;
 b=DHB2Gir66Bxh/LqR5dvPH8X4Q3SzvFBJLzlnEnBAp4zQrKUy3r6qrhL6lWreRcQ1GE
 0TgOL6A14jTbzzapxuoWaLvY0OpInpj3PadJl2m285mKezMqvFMcQ+WN63bzb6WYWls5
 n45cyq08tSadFicvYH3nIfy+dqBaYgSrEH13LOJNJU81O7+dxTbbjt3lS84JrMhRbo+N
 IqFBThYZLNNBqa1vIPvHAUV9lIh94Nb7+YRd1GOxE2e7M7+nzqSdIBWduHAf26FmB333
 S015DdENgHfYIWJb2yY9Uc1F6bWvQ/KyABqHGRSO/yhQjRASTugS/v9Nrbm/hHDzXPAU
 HLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562169; x=1760166969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4vT0oHPpE6PzHl8pNB5QhR7O7PRoflwlDAx8XNEBOc=;
 b=urHGbAc2tEvrfoJF/1RtGLwjEpQn+lovf9V5dR/cjFEr6G+tNCqIBtlMT0IeY8CPZ7
 k60Wnrb2N0sAhI5KkBxs9tNqRE8faLJBrxdNjx1DwkS+E98VUPAtFWhfjeCe0kkj9P9/
 uFu8Ur1NfjJBQ3zw32VkTdfEF0AbYepPVrFoMVDlUmUFr9094VRXW2Ib7tXWvfld3tNw
 jwMweTE5714dEwFgyt4+lPrvSOOqUOSzurZMrkhnTo5F8T9fXyLSFHJLmd8s20PHeSlC
 +UU8nmInyoc8hZufHJ2y/RsgrhQwTnu4lbMECjA2JUJOnQ2JYfANnOFmFgVQoTAgw4gF
 ZOqQ==
X-Gm-Message-State: AOJu0YxbbqnUAGPyCKcTWVmVWKB4ga9DH1l45WxRWNKtwRmzkHjY0hK3
 RFxuqVXJ4BSfdeFJ4HxhRYXZLowDkx+K03i/XT8dHKbo3ILwfks18k7WposJCWq8JhbiarL+sik
 DZPE2FG/QKQ==
X-Gm-Gg: ASbGncsr40ezM3ngs9rdNrEAldzfg962izXUgpIqjboWdv5Bn+sHvNEwh9JXCamoQbG
 jgV2CZHuD08ofLzwgBORH6e0bK4CTUIepqN9g1RMfJcIDP3juZdXHIAxAeLg1CfIaDePfwXenNj
 wfygxcb924nkjHx9YNbaVs0RVKh4f+Xu6DJMuWEK2lpNIzq9YzRO0yPfEGfpHwOypD84e5QpeTB
 15z085+Wh/Lua5a41zjgZVLE+mvEigG/vZmHAHWNCrxafkJTobcQhD0hv4jdpYHzyhQDPtCSuks
 0WF08enn+A2nsVzqPgXxwpjy5zPttlTwQdCFzQ7eltgmzlOAK3MwDCWMcEluHpNq6pPWzmzWS+A
 g1uNJulcA0cWWhH3QxxMt2t2IGi2qw9LcqHPDkj2mecK1GIVSQC+bFOGzy3u+2vNFF+J/0v9tdW
 eOg7PNxQkq1TW4z8I60JgD/pu4oy1QXED0P80=
X-Google-Smtp-Source: AGHT+IHKQvhr2ke9QEFVAqMApDlbFycniKJZyXX2+FlUvBNXn7eNU3NQNm4zVwhAI6JXW79IpARXaA==
X-Received: by 2002:a05:600c:3d90:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-46e7115178cmr32971995e9.28.1759562169186; 
 Sat, 04 Oct 2025 00:16:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a022d8sm151161325e9.12.2025.10.04.00.16.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] system/physmem: Reduce
 cpu_physical_memory_clear_dirty_range() scope
Date: Sat,  4 Oct 2025 09:13:04 +0200
Message-ID: <20251004071307.37521-39-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

cpu_physical_memory_clear_dirty_range() is now only called within
system/physmem.c, by qemu_ram_resize(). Reduce its scope by making
it internal to this file. Since it doesn't involve any CPU, remove
the 'cpu_' prefix. As it operates on a range, rename @start as @addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251001175448.18933-16-philmd@linaro.org>
---
 include/system/ram_addr.h | 9 ---------
 system/physmem.c          | 9 ++++++++-
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 54b5f5ec167..cafd258580e 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -175,15 +175,6 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
                                             ram_addr_t length);
 
-static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
-                                                         ram_addr_t length)
-{
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_MIGRATION);
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_VGA);
-    cpu_physical_memory_test_and_clear_dirty(start, length, DIRTY_MEMORY_CODE);
-}
-
-
 /* Called with RCU critical section */
 static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
diff --git a/system/physmem.c b/system/physmem.c
index 0daadc185de..ad9705c7726 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1139,6 +1139,13 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     return dirty;
 }
 
+static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
+{
+    cpu_physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
+    cpu_physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
+    cpu_physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
+}
+
 DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
 {
@@ -2073,7 +2080,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
         ram_block_notify_resize(block->host, oldsize, newsize);
     }
 
-    cpu_physical_memory_clear_dirty_range(block->offset, block->used_length);
+    physical_memory_clear_dirty_range(block->offset, block->used_length);
     block->used_length = newsize;
     cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
                                         DIRTY_CLIENTS_ALL);
-- 
2.51.0


