Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38F2CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wSV-0003WZ-BD; Sat, 04 Oct 2025 03:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSS-0003VO-Ur
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSQ-0004tV-VW
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:13:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so1997188f8f.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562008; x=1760166808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VQy9CRNq59Jgxjrk3bVqa+dLyrw0C83SnQUkRzrgfa4=;
 b=pNReBg2SPiDB8RwhMV3B+pyYR7Occ0gK2kr55wYf7HfQt/0zKtxeGyXbd3badlSIxJ
 g4heRpraqvI6DJR51xvb2+CeqNJsN7jF+NABJQ3v6s+EkeKdSWxEG2fH0fRzzXpMM7UP
 3w4pY3F8nR56nMMI/o0vNwhYGvwbW2guFyxeQSwPdebcBFaRFhBLLZ7cQVycBJMlX1uB
 9kKHxBJPVp4yDZsQRNXCBANnsFS+nOABT6XloLmW6vxqQGQBTM4KvWI4P95ISrhjimKl
 RioWEZgfO7/+RssVoCY+drBp2/RLUzyqgppU8mI0yC4oDmITtrcfFbMFrsn+CpUo7AEu
 4tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562008; x=1760166808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VQy9CRNq59Jgxjrk3bVqa+dLyrw0C83SnQUkRzrgfa4=;
 b=tTDjVUl+86+jUrpIAD6uoLGBaHnOVYkt+udzyNVDTV33VphoRgnPrCPRcPmZeYZCHq
 KTtC7PoVZEWQsk9dco8NtVXMTe8QtuXsUTCUhNjl17cpT4WMbPUsdun7ApM9alzNnGxq
 6QUGbcYK0QhcAVyenctBdx12B8Z+zcFMm2ZLgWv5ooeqfevxic2PnB3v9ylHz3ZmG8Ne
 gNX41qQ/gTC/+Qqa0x+AuyxY+DdlX3kFDqdg8bQw99lWRUVeCR7qCLcXavwYNaQAMnXE
 QsAONdb65FpAfxy6UKDNn+mTYxT2zZvFB8pp7Li0VKuagkPUssBAwDUOl3QBH5ezj8bi
 v4Ig==
X-Gm-Message-State: AOJu0Yw9SgsumZiG4BEoaom8W1ZbvMeMbv20sT2mNgtUyRVSC2W9qspB
 1vQtQNjZpG+beg42fV76dAJ+JJW1QasBZ35paMPizFkj4yaIzSP/YIKqJr81mfWDoOLe+nKTIY8
 0kzGoLGuQlA==
X-Gm-Gg: ASbGncv1QbA0Fg4ZjXMSXPrYKIvyYC2t+skkuArQuIHRU4Y9NSjSgUQsLQtM9MvAUIj
 BlcXEhLhY7VbfJXckAVd2XisxEs25zT7+jT9pnWQMgiSi2IlXj4PGVk6pgdULTyVXXBKT+yFZy8
 bD2i9NnzUwcn56uLpILuPrOgiEPwXG1aC4pMyYpXxRqk3AKn/hKYNUaJT9ImykCCqnXTQ6AAyik
 B/MVZ2iLMcSJpSCyoo4eA4HpuCn9671s2CGjlGU3OB5BLvbSX68a4o5WNrlTF3CFt/DmrWoBp5D
 n9WUvYFk9bHmVeJyuLfhAN0Czf9VIw4KuqUDssSXMU69nTgEyh9Ye7WNBOWTjNTLC3JMk9LQ266
 vOhyoazntF60CmL2RthLuUY0dZH8jfaGufckYfHPefGtWY784nvYW1wJWMGeNd2YjDtUP6RB1pj
 1nF/v3h8gJD/9pcXvyfSgyAMniZP8Dz2WsuV2NVnf1YB5c/w==
X-Google-Smtp-Source: AGHT+IHDt+rpxmEqQ44ij80r2/UWX/WHHmUY10q+V3TAFOE3mjOK4JFbT7slD6c4JwFEM4ZkNEjQjg==
X-Received: by 2002:a05:6000:603:b0:3ee:3dce:f672 with SMTP id
 ffacd0b85a97d-4256712a5dcmr2934706f8f.4.1759562008505; 
 Sat, 04 Oct 2025 00:13:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01a0sm11093046f8f.48.2025.10.04.00.13.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/41] system/ramblock: Rename @start -> @offset in
 ram_block_discard_range()
Date: Sat,  4 Oct 2025 09:12:30 +0200
Message-ID: <20251004071307.37521-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Rename @start as @offset, since it express an offset within a RAMBlock.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20251002032812.26069-5-philmd@linaro.org>
---
 include/system/ramblock.h |  6 ++++--
 system/physmem.c          | 28 ++++++++++++++--------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 530c5a2e4c2..85cceff6bce 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -103,8 +103,10 @@ struct RamBlockAttributes {
     QLIST_HEAD(, RamDiscardListener) rdl_list;
 };
 
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
-int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+/* @offset: the offset within the RAMBlock */
+int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length);
+/* @offset: the offset within the RAMBlock */
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length);
 
 RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block);
diff --git a/system/physmem.c b/system/physmem.c
index 3766fae0aba..1a74e48157b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3797,18 +3797,18 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
 }
 
 /*
- * Unmap pages of memory from start to start+length such that
+ * Unmap pages of memory from offset to offset+length such that
  * they a) read as 0, b) Trigger whatever fault mechanism
  * the OS provides for postcopy.
  * The pages must be unmapped by the end of the function.
  * Returns: 0 on success, none-0 on failure
  *
  */
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
+int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
 {
     int ret = -1;
 
-    uint8_t *host_startaddr = rb->host + start;
+    uint8_t *host_startaddr = rb->host + offset;
 
     if (!QEMU_PTR_IS_ALIGNED(host_startaddr, rb->page_size)) {
         error_report("%s: Unaligned start address: %p",
@@ -3816,7 +3816,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
         goto err;
     }
 
-    if ((start + length) <= rb->max_length) {
+    if ((offset + length) <= rb->max_length) {
         bool need_madvise, need_fallocate;
         if (!QEMU_IS_ALIGNED(length, rb->page_size)) {
             error_report("%s: Unaligned length: %zx", __func__, length);
@@ -3867,11 +3867,11 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                            start + rb->fd_offset, length);
+                            offset + rb->fd_offset, length);
             if (ret) {
                 ret = -errno;
                 error_report("%s: Failed to fallocate %s:%" PRIx64 "+%" PRIx64
-                             " +%zx (%d)", __func__, rb->idstr, start,
+                             " +%zx (%d)", __func__, rb->idstr, offset,
                              rb->fd_offset, length, ret);
                 goto err;
             }
@@ -3879,7 +3879,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             ret = -ENOSYS;
             error_report("%s: fallocate not available/file"
                          "%s:%" PRIx64 "+%" PRIx64 " +%zx (%d)", __func__,
-                         rb->idstr, start, rb->fd_offset, length, ret);
+                         rb->idstr, offset, rb->fd_offset, length, ret);
             goto err;
 #endif
         }
@@ -3899,13 +3899,13 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                 ret = -errno;
                 error_report("%s: Failed to discard range "
                              "%s:%" PRIx64 " +%zx (%d)",
-                             __func__, rb->idstr, start, length, ret);
+                             __func__, rb->idstr, offset, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
             error_report("%s: MADVISE not available %s:%" PRIx64 " +%zx (%d)",
-                         __func__, rb->idstr, start, length, ret);
+                         __func__, rb->idstr, offset, length, ret);
             goto err;
 #endif
         }
@@ -3913,14 +3913,14 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                                       need_madvise, need_fallocate, ret);
     } else {
         error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
-                     __func__, rb->idstr, start, length, rb->max_length);
+                     __func__, rb->idstr, offset, length, rb->max_length);
     }
 
 err:
     return ret;
 }
 
-int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length)
 {
     int ret = -1;
@@ -3928,17 +3928,17 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
     ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                    start, length);
+                    offset, length);
 
     if (ret) {
         ret = -errno;
         error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                     __func__, rb->idstr, start, length, ret);
+                     __func__, rb->idstr, offset, length, ret);
     }
 #else
     ret = -ENOSYS;
     error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
-                 __func__, rb->idstr, start, length, ret);
+                 __func__, rb->idstr, offset, length, ret);
 #endif
 
     return ret;
-- 
2.51.0


