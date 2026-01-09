Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863C0D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFiY-0004ko-JM; Fri, 09 Jan 2026 11:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFi2-0004M8-Bl
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFhx-0007Lg-7u
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:51:32 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d3ffa5f33so21248595e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977487; x=1768582287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cetaL8155CThR92fvfQP9zK4pirbJsIkyuhfEBQWxaI=;
 b=SwuR5R+s+S5Z159FT7tcurbwnkNhibl9iFZUmaT0nTmcG09JHdIkMnorTg84oE2NWq
 ePWvnoiz41Rclc9aaeKyu1vfspwT2LBMBpGV/dp6+qDRRCW1/7iR342CxFAkzwFU316n
 7Ov9ix2jTbSypFOz8R8qqlqHNPOAvnqqtixzRqOOGMgM8ZqVrnE5ljvJ1hJ1bkuT9lis
 s0ar9pQpFq2MGd/7kyDXUO9Q7SnPNCRxMhsShaxmaOQ2MDoG+9j+6l54T6ECQo8mi2y4
 mxiPFOKADIfEUzRg9XWfbvCxEK/FrZzZ7Cc7DwUt3EdKhyNHP2CjOEZk2J0xOCXyf+sr
 lfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977487; x=1768582287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cetaL8155CThR92fvfQP9zK4pirbJsIkyuhfEBQWxaI=;
 b=qb/PdZCUDjai937F8pW067ZE3pUKu79ilJCWcPniMRIJ9nYvsuZEzVz2Q+nPIUf8k9
 dQqwpZlZLI82hK4l63NFsKmtEaq8s4nfJ1mB7a+IgnYWmltsMMdRG5Gp9l/PuGcAaRU4
 q9js43kNysQwkqwkmwSoozN2jCj+FxbeFFFi4nM+vkYgpaEXARWCR1aVaVwOlYA/EUFz
 0HOG1HuMZCNVZYSXCynvlzQoQVHNYZkumUvw6tlJvHeIjdOEMeJA23SPPjSJux3wmpqI
 BB+xNWpSQl1azYdpHjBsUMNoXLqWEjgRl2H4KGxhwSJORWpd1PmNMbZ75kzU0pML+4x8
 tQ+w==
X-Gm-Message-State: AOJu0YzK30QhTd2Ma758IMIyfD8qEqBkdk/THNqhaEUl4i2+fKT5vcG5
 6tweiljoEZg/OC8M3PqHmsnFZ/w9mKT8r+8fpZ2aE+pbc5A2s6L54J8TZBOpL+ByvtQwBTtL+Vl
 JqQk7UEM=
X-Gm-Gg: AY/fxX67m6KEs8O3p/PTmdU/OqSm32fQPq/xKtHxjLDVAjJ5/LaxuirYSRzVRrik9Zw
 uNEAyQIKZaKKe77+V6A3GMyAA7oLAJZRdnv9aAd2eGO+9OhWQNVFriTmaWbj3ozQbmOa4vJDJEj
 mvUSmB30aDuQhbTe+408uejiZOUFAHjQgLBY1oEr7aJwsCl8aG9CXKHXuwbHYkf8uYsw0pfAmdW
 u+oSkXWSlVArlRgrvHOEndvVN1R/ZoyUUWmaZI8KesCWalSV5kmALUB3yjpkKqp+H68RqlPu4pb
 9hn3aDpcsnoeN87wdKH9aaTmKztA6nzvPd4YBVjYp3U0JPuWHBKRXlGNYaGAPaYj2uxZRrMBjJt
 FmngJM/MyHVmW+LLEfNuNx53rl2XlDye8PNbrbfeM+cP2tPg9e4LTIa9gFUUsYpXnyle8poarzr
 uIRS2LzlW7zLo8W8PbRLShA57sO41xxJvEgiGpHQZqPDKzY4EsY14khCv3nOSR
X-Google-Smtp-Source: AGHT+IFv8vk8Odo9BtMGQ2dyagTun9Rpl3O1jLkfWn/eSGc0vr+ionI56qGhdxUNYnf7opf6xIRlLQ==
X-Received: by 2002:a05:600c:8b2c:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-47d84b54c3cmr109451335e9.24.1767977487383; 
 Fri, 09 Jan 2026 08:51:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm211422785e9.8.2026.01.09.08.51.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:51:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 04/22] system/physmem: Convert DEBUG_SUBPAGE printf() to
 trace events
Date: Fri,  9 Jan 2026 17:50:40 +0100
Message-ID: <20260109165058.59144-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Defining DEBUG_SUBPAGE allows to use raw printf() statements to
print information about some events; convert these to tracepoints.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/physmem.c    | 29 ++++++-----------------------
 system/trace-events |  6 ++++++
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index cd2b0dc5fc2..0e8a2fb621d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -91,8 +91,6 @@
 
 #include "memory-internal.h"
 
-//#define DEBUG_SUBPAGE
-
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
  * are protected by the ramlist lock.
  */
@@ -2921,10 +2919,7 @@ static MemTxResult subpage_read(void *opaque, hwaddr addr, uint64_t *data,
     uint8_t buf[8];
     MemTxResult res;
 
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx "\n", __func__,
-           subpage, len, addr);
-#endif
+    trace_subpage_read(subpage, len, addr);
     res = flatview_read(subpage->fv, addr + subpage->base, attrs, buf, len);
     if (res) {
         return res;
@@ -2939,11 +2934,7 @@ static MemTxResult subpage_write(void *opaque, hwaddr addr,
     subpage_t *subpage = opaque;
     uint8_t buf[8];
 
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p len %u addr " HWADDR_FMT_plx
-           " value %"PRIx64"\n",
-           __func__, subpage, len, addr, value);
-#endif
+    trace_subpage_write(subpage, len, addr, value);
     stn_p(buf, len, value);
     return flatview_write(subpage->fv, addr + subpage->base, attrs, buf, len);
 }
@@ -2953,10 +2944,8 @@ static bool subpage_accepts(void *opaque, hwaddr addr,
                             MemTxAttrs attrs)
 {
     subpage_t *subpage = opaque;
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: subpage %p %c len %u addr " HWADDR_FMT_plx "\n",
-           __func__, subpage, is_write ? 'w' : 'r', len, addr);
-#endif
+
+    trace_subpage_accepts(subpage, is_write ? 'w' : 'r', len, addr);
 
     return flatview_access_valid(subpage->fv, addr + subpage->base,
                                  len, is_write, attrs);
@@ -2982,10 +2971,7 @@ static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
         return -1;
     idx = SUBPAGE_IDX(start);
     eidx = SUBPAGE_IDX(end);
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: %p start %08x end %08x idx %08x eidx %08x section %d\n",
-           __func__, mmio, start, end, idx, eidx, section);
-#endif
+    trace_subpage_register(mmio, start, end, idx, eidx, section);
     for (; idx <= eidx; idx++) {
         mmio->sub_section[idx] = section;
     }
@@ -3004,10 +2990,7 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base)
     memory_region_init_io(&mmio->iomem, NULL, &subpage_ops, mmio,
                           NULL, TARGET_PAGE_SIZE);
     mmio->iomem.subpage = true;
-#if defined(DEBUG_SUBPAGE)
-    printf("%s: %p base " HWADDR_FMT_plx " len %08x\n", __func__,
-           mmio, base, TARGET_PAGE_SIZE);
-#endif
+    trace_subpage_init(mmio, base, TARGET_PAGE_SIZE);
 
     return mmio;
 }
diff --git a/system/trace-events b/system/trace-events
index 82856e44f2e..6d29a823f04 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -35,6 +35,12 @@ find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_
 ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
 qemu_ram_alloc_shared(const char *name, size_t size, size_t max_size, int fd, void *host) "%s size %zu max_size %zu fd %d host %p"
 
+subpage_register(void *subpage, uint32_t start, uint32_t end, int idx, int eidx, uint16_t section) "subpage %p start 0x%08x end 0x%08x idx 0x%08x eidx 0x%08x section %u"
+subpage_init(void *subpage, uint64_t base, uint64_t len) "subpage %p base 0x%08" PRIx64 " len 0x%08" PRIx64
+subpage_accepts(void *subpage, char access, unsigned len, uint64_t addr) "subpage %p %c len %u addr 0x%" PRIx64
+subpage_read(void *subpage, unsigned len, uint64_t addr) "subpage %p len %u addr 0x%" PRIx64
+subpage_write(void *subpage, unsigned len, uint64_t addr, uint64_t value) "subpage %p len %u addr 0x%" PRIx64 " value 0x%" PRIx64
+
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
 
-- 
2.52.0


