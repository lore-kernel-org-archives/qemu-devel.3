Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4696CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G5P-0003nA-6h; Mon, 29 Sep 2025 11:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4t-0003Af-BY
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:46:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3G4j-00088o-Ec
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:46:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so4030170f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759160755; x=1759765555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txLBq2hBcl/jIiqR1VpYD85vDq9mb0UsYkys8wX8u/M=;
 b=PLtP00L3LWhhcTLcP5mWHTxUpmLp1ls+t9fY8XVeD7psufQ86PokO1qFkz5ucMXX7J
 o5mEdMu9K68X4qqzS4/9zAL4YnG5oz3UAnsC11KRvaKMj5FT4gMfnTG6hHMDIBg72jJa
 QIX8QPfsPZx2aWqLbSU7csUnuimK6QvAGZ0JoRdv869dHXn7YxvhvSM68qmDg/+OmkzW
 6TyDT5taXNeVA/Vfzbv72dJJukKbMceITjqvs4H1j2ArT3/7kM71Z2qpOEloNksrPd93
 NjztVGbENuAYAUCVee9l7cZbIh+rZOZkHwtveE0/N2J2cLWo5OtLF59Ynr4dDE95EevC
 CSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160755; x=1759765555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=txLBq2hBcl/jIiqR1VpYD85vDq9mb0UsYkys8wX8u/M=;
 b=AnHPpSj2Enro6OeCkzGSDemYLs47X4gOeXCgSArqQDKNRPYYu/FH7jK48I6O/imcy8
 eNSK6I9NuSHvqLtf7DqORPUifOrdenBIqbUL7gPwIgGdFiA7w8d+L2XOEytO+2qOC+ay
 kCVzMfS0QWKKximnR+cPB4jqUy5aQLKorsa/fzYs1rtiSp+2ohPz98mGHbgEoxrW4Hy9
 7abyrxW1B+bPhs3Up8tVbyRMiSEN+q9EKW8E0vT1vdBSAYQCdPwXXNyP5voKXWhSYEOM
 ux1Oh+BX65/iEdoIpUdZ5rIVwFyOCndBSOnKIZ5nT3K8OKUZty1+KAxyt0YVDQlQPEr5
 Zmpw==
X-Gm-Message-State: AOJu0YxtnJOUqn6tMBFRoZb2edlLDlD/92LZ+byvO5d0Rrtb5NSm37Lg
 Akl+rrgJb3IveoOOlUVsD9sf33Sz8CVT7J0sjI3SyYuUcEoOd0lXEj0zG07J9sxF+VBZT/sBT/S
 o/8upr+FnQw==
X-Gm-Gg: ASbGncsNsRVfnOOYIZEgWdEMRid8mYZBKsvXAEO9PF86gdBJdzp074wK1FFZV5R2UiS
 7/+TKNUDOrtbDjX+kgh1AqT0t0ZDPrFfCzYXGPH+5rQUHfeWGbJyUImoeuydlLdmStt6z9QDhFD
 D90os+njLaby1GFVddz5T3q/lTQBCt2VeLSWs591yQUxXYybmv0VAt5qL5n3ErIZZApMcfjFtnR
 qa/73JsARCQ7xn4Vl/2uWov/2BTYWAOe9+tvDnWUb5ucIDkBiQvkiwfMA8oRH3eipU5VzSfHJIW
 qas1MR2aGubtWa5nlA35LRuSfttatKE4P94OZ55atuEgSDXAo65cSgBZo4RjzxJvEDhVB71SEpO
 D81wthSflIuvrfeB8DYCrBhoyy461f561U3jza9HOfKKJI4o9xOCNAUsaFC/rEmOyTkWvfB88M5
 9iq7UgFxw=
X-Google-Smtp-Source: AGHT+IGTzp+BirKcRPCXo+kANtj3p1s1iIIjZmLqbDvTsgjpRSs7dA5CM6VwfzYsQdra8DfpYPvayw==
X-Received: by 2002:a05:6000:268a:b0:3e9:b7a5:5dc9 with SMTP id
 ffacd0b85a97d-40e479258cfmr15786461f8f.23.1759160755369; 
 Mon, 29 Sep 2025 08:45:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72facf9sm19283036f8f.13.2025.09.29.08.45.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 08:45:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: [PATCH 5/6] system/ramblock: Use ram_addr_t in
 ram_block_discard_range()
Date: Mon, 29 Sep 2025 17:45:28 +0200
Message-ID: <20250929154529.72504-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154529.72504-1-philmd@linaro.org>
References: <20250929154529.72504-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Rename @start as @offset. Since it express an offset within a
RAMBlock, use the ram_addr_t type to make emphasis on the QEMU
intermediate address space represented.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ramblock.h |  3 ++-
 system/physmem.c          | 33 ++++++++++++++++++---------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 897c5333eaf..57c00e42ca6 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -103,7 +103,8 @@ struct RamBlockAttributes {
     QLIST_HEAD(, RamDiscardListener) rdl_list;
 };
 
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+/* @offset: the offset within the RAMBlock */
+int ram_block_discard_range(RAMBlock *rb, ram_addr_t offset, size_t length);
 /* @offset: the offset within the RAMBlock */
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, ram_addr_t offset,
                                         size_t length);
diff --git a/system/physmem.c b/system/physmem.c
index e2721b1902a..bb744f0758e 100644
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
+int ram_block_discard_range(RAMBlock *rb, ram_addr_t offset, size_t length)
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
@@ -3867,19 +3867,20 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                            start + rb->fd_offset, length);
+                            offset + rb->fd_offset, length);
             if (ret) {
                 ret = -errno;
-                error_report("%s: Failed to fallocate %s:%" PRIx64 "+%" PRIx64
-                             " +%zx (%d)", __func__, rb->idstr, start,
+                error_report("%s: Failed to fallocate %s:"
+                             RAM_ADDR_FMT "+%" PRIx64 " +%zx (%d)",
+                             __func__, rb->idstr, offset,
                              rb->fd_offset, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
             error_report("%s: fallocate not available/file"
-                         "%s:%" PRIx64 "+%" PRIx64 " +%zx (%d)", __func__,
-                         rb->idstr, start, rb->fd_offset, length, ret);
+                         "%s:" RAM_ADDR_FMT "+%" PRIx64 " +%zx (%d)", __func__,
+                         rb->idstr, offset, rb->fd_offset, length, ret);
             goto err;
 #endif
         }
@@ -3898,22 +3899,24 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             if (ret) {
                 ret = -errno;
                 error_report("%s: Failed to discard range "
-                             "%s:%" PRIx64 " +%zx (%d)",
-                             __func__, rb->idstr, start, length, ret);
+                             "%s:" RAM_ADDR_FMT " +%zx (%d)",
+                             __func__, rb->idstr, offset, length, ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
-            error_report("%s: MADVISE not available %s:%" PRIx64 " +%zx (%d)",
-                         __func__, rb->idstr, start, length, ret);
+            error_report("%s: MADVISE not available %s:"
+                         RAM_ADDR_FMT " +%zx (%d)",
+                         __func__, rb->idstr, offset, length, ret);
             goto err;
 #endif
         }
         trace_ram_block_discard_range(rb->idstr, host_startaddr, length,
                                       need_madvise, need_fallocate, ret);
     } else {
-        error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
-                     __func__, rb->idstr, start, length, rb->max_length);
+        error_report("%s: Overrun block '%s' "
+                     "(" RAM_ADDR_FMT "/%zx/" RAM_ADDR_FMT")",
+                     __func__, rb->idstr, offset, length, rb->max_length);
     }
 
 err:
-- 
2.51.0


