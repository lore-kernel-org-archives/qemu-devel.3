Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A959CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 03:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4A0E-0004VO-LB; Wed, 01 Oct 2025 23:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4A03-0004Un-QE
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:29:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v49zp-0004a6-Ll
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 23:28:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so5022405e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 20:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759375717; x=1759980517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1+X2oMvazjHxrIb2bLCkH4C3BOYEho7EWsrbywbDVQ=;
 b=GcEv6bDqKtmyr00JIUrMLIh6yQTuqxBHjaaJB/HgxLBubuJ8QQYYYcTEhf+lF+pw4y
 IfkD2prWiqgjBpk8Upjov/nF6y9Y5Q+5epz+WYLeFqvemdHVs6rTKcc7YpEQRF5xuFnq
 hsKmEahLNOkZ9zC6bQQOAabq4cAMwuk0pay7u6XQlYoXaIPALbiJqsPc77LrBUJs4Q+m
 3mu9IwarCyQ8rzAdsImtoaBtcoW4GSE36BbeSsSYV5E20FCdXOaID0azS+Ds8TsgKp04
 0/RMdsLNdZlb916A1QXzcHD9ACDv3Md4eQzi+DCZHvMcPvkTjZfna0kSUXbYDh47KYVY
 zwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759375717; x=1759980517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1+X2oMvazjHxrIb2bLCkH4C3BOYEho7EWsrbywbDVQ=;
 b=mkQgLsHQNkl2KvZPf9qx83Jb+A1nx4TB0iAbhZPZOzaxOe13Sz8W+lE8MDIYSdgAML
 /GZfh4Ic8FeUY9/jt9laXZfY3mOD/0qm8xIpCcwzP19VK/JDpyVPmNBPich/6qmgA7CV
 nipjynUypAshN8pODvs6bYJ6OtxRII531lyu+NoqPhVhKM2TJ+KlJu2K6pUfOh/O+Bsw
 +zi0KTNjbMzcDIZvLE32aPPqPSEk2cibYjfFarS1n7N1gm+PtNgX75c8usE7+gEXOLbD
 cqtPq3KtZRGdO6uBeTCuDwayv/FhmeKLLr0uK7KidIsVRuVwiL3G4ZyGyCK3xM6vblKe
 LRyg==
X-Gm-Message-State: AOJu0YyKrV2PCOgkVzuDjsDrzAkZvuQ6VPQaW+a2/5gAC3X/vorDbAZp
 l7Dm10HbPXN39HOloH03r3zGB6jXKVuyuNSF66HAvAXfCevE+aqkl6uZpI25jGFu8J/uFzwtJfV
 LYeqoCUUH+Q==
X-Gm-Gg: ASbGncuPt0m3iQwuFcykLUVxFRTNqW1gbQZ6zkN4M5QooVKO3Abt3CZ1fgznOYrmm9i
 erR0v+nbJbteLGQUdBdGq4ZeogPBjPkUflxubwZxfpDn1FS0NewvFfW3LtaaNIlWRrxJjAjNZV2
 HWWlanzQNAg+mksjRlMuzeeB2W2HagSq5R7VzaJun814F5WC1KVD1d2xjh98wUVBQbYxvK0qHOt
 7mlKh8E6bpt9nFRXvW/iTP0Kv34b3odgfs7Mf8zGp3njzeTk+qJqAECzJcXOJkwxjJdZPllYwcS
 DAawRQmOplEIPs77+pHd1dhtBhAsHzJF4D/Pr4QcAp0dhhD5F4U7kV7xgG006zpPs2fkOyvjqBT
 jHLjN632SDMtJUxXuJHKll2VhzDdyLP3hxJyMMuXUqFEjRLB5xUtwmPT3avi8uznA/jg0maGgXf
 iOJLIxMlqYyL2Q31EBrFjFZGbddkQqlw==
X-Google-Smtp-Source: AGHT+IE/AVOVePpbh0V8yDK4JSymMcusLo1d0mmVuJJMEk6+ac5d1uzn4XJ8733wdbLt2qpqBFX8SA==
X-Received: by 2002:a05:600c:1f86:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-46e612bef22mr40680515e9.18.1759375716629; 
 Wed, 01 Oct 2025 20:28:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a029a0sm61512175e9.13.2025.10.01.20.28.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 20:28:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 4/5] system/ramblock: Rename @start -> @offset in
 ram_block_discard_range()
Date: Thu,  2 Oct 2025 05:28:11 +0200
Message-ID: <20251002032812.26069-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002032812.26069-1-philmd@linaro.org>
References: <20251002032812.26069-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


