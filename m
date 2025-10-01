Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45BBCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zyi-0004iJ-V7; Wed, 01 Oct 2025 12:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxl-0004Cb-7z
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:46:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxS-0008FH-80
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso46894095e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759337123; x=1759941923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoqOsJi+ckKEV7B3nJVRJEwDGiQ2IoFBy8rhaUoDJkE=;
 b=ZdMXKrRkvJxdmnu1Dkj7ZTNNsXjVv5SIA3fjLKRF2ak+wI9cteNZ9iLAJCCVLUw2hS
 cqYVARR5LjiRHwa607Nz6mZp72tQB5sU4h3ZB78iV6DzL4z3HpiBoAVVyMVMTmBs8oJV
 KxyUHPf2oxyAZs9AUS8yon5D9+OkPAA/8FEHY4jy/RJnPfIdOgt9Gw6s0oVMvf6LzGWe
 82ROpKbKRhlWdROVkeQ5j8WVnxeA62caYAE7JcH0ccvcHi81G0SUMg0wIs2XJ0rT5s+T
 osTkKdZIC/Gyz8lor9NzqzGfI1eUqbVVvdaMOR8u+MJInD2rbelPM4i4KfSjbOYgPRLY
 AKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759337123; x=1759941923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EoqOsJi+ckKEV7B3nJVRJEwDGiQ2IoFBy8rhaUoDJkE=;
 b=mJGeKv+RrxzyI3VCzOVxyUL7eeMVMht3UlP+NQ02gyn9XAjLjDFAeoaR45U7fz3kpT
 /MNaNUoq6YBFAs8cdpaKBPAuj28/hDAgKFmsYnjClHK09YGE83cQVopzMc4o3weQTMXh
 YAzV62SVP6HMZHdaKdnqsscbC54uEvXwfyGvrq+hV+XYEa0x55smGw6RQpsq8r4clKoq
 FqNbMBcfLn6j5ewWseUj2ermOR2gvqIUQDyek48MDn+JDqExNrHiTT/xAG+KYsCRAyRF
 Ce2dWTrFpUcA+lSeG2iwgJ+saJDjTESZP1eZEjXZweHb4HgMZHa3srmqhTbTAfqVRvxS
 fkFg==
X-Gm-Message-State: AOJu0YxpZ8EYTpWxEUzTo+OfNZHItM8xd6kQFa0wUVyBBtl3h3ipZvjH
 H6z1wpfPxcU5mwlwyciH1drqpoyS+GAcXsMI1iq3XXco3ohDbHPX2MiKdMnRlAuqtlO1q2IcCHI
 rBWm1ABhCTA==
X-Gm-Gg: ASbGncuKmMHWURP1RBLqolqpEhl9bnSfoXH2yUTUjgbb53RPJUPKPJwZmNpn3lNuTzE
 99dOMcjk5Tm3MUDWViZ9Rdj8DgfR7RRTnGzphk1gemRbm9o2FvOInKVDp9xbNnN4cbiMgLGwO6b
 jcsLdQl4DkOiMGWYPGfATofNwhDP5C32ZFXrfN1gTZzw6v4oEVq3OSPbH+AvI9F2BLnILjkc4Yj
 O9iwBua5WMgu6H8mffiJX1N+wt439BQ5lOg71tzER7ZuUrG68+cmKgxa7nnCxxg5ErgROX7p6ge
 SzzPIPgpnz8S1jw4yq86qPFHdMkJxsMv6gaa9dEDKk4gPkGHihq81+H/pZT13Oe47Qnu4YSaZAn
 hteiDVByyrrJs97UW9TPxucen7Lk3lKIlOSXIileoMvpnbkOC/+ySDW78BQMKtdUu8axRDNd16u
 SDjxO5Ec16p3XVmRHQ0LZt
X-Google-Smtp-Source: AGHT+IGowKGxiVqBsAQg7gWD80SiXziNmOE2dMHVl566mX2Ha6bMcqT5kUvsyzlNkaxRS8yyhh3OPQ==
X-Received: by 2002:a05:600c:c4a4:b0:46d:996b:826f with SMTP id
 5b1f17b1804b1-46e612dcfd0mr38835315e9.25.1759337122918; 
 Wed, 01 Oct 2025 09:45:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619a837esm44006115e9.14.2025.10.01.09.45.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 09:45:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/6] system/ramblock: Use ram_addr_t in
 ram_block_discard_range()
Date: Wed,  1 Oct 2025 18:44:55 +0200
Message-ID: <20251001164456.3230-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001164456.3230-1-philmd@linaro.org>
References: <20251001164456.3230-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 include/system/ramblock.h |  3 ++-
 system/physmem.c          | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 839d8a070c1..85cceff6bce 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -103,7 +103,8 @@ struct RamBlockAttributes {
     QLIST_HEAD(, RamDiscardListener) rdl_list;
 };
 
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+/* @offset: the offset within the RAMBlock */
+int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length);
 /* @offset: the offset within the RAMBlock */
 int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
                                         size_t length);
diff --git a/system/physmem.c b/system/physmem.c
index 2bfddb3db52..1a74e48157b 100644
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
@@ -3913,7 +3913,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
                                       need_madvise, need_fallocate, ret);
     } else {
         error_report("%s: Overrun block '%s' (%" PRIu64 "/%zx/" RAM_ADDR_FMT")",
-                     __func__, rb->idstr, start, length, rb->max_length);
+                     __func__, rb->idstr, offset, length, rb->max_length);
     }
 
 err:
-- 
2.51.0


