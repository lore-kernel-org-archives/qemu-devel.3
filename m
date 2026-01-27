Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A02D25937
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRb-0006ht-RO; Tue, 27 Jan 2026 00:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRa-0006h3-7H
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRY-0008JN-RH
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/m58jsrTIZK0luSPJaSrEgjDGlXyqLhzlqk7ugFZnAI=;
 b=ILMkzuDLNJUJ9e+RPDEqCuvmaVltaV3OZWkFYdN369BRdKzSqkidDtOCTS6SO2lKPIOyZG
 nxF3CZYaSybi5qOHTJvpenSUkmmkL0TbvouKOJf91873MgL0sSPcLRUdBZg6aWm9S/RWSO
 NaZuRGDL38Bw19WzP6TDvixoMzFwyGU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-4C_0RT6bMU-8ABJbnDqsBg-1; Tue, 27 Jan 2026 00:16:45 -0500
X-MC-Unique: 4C_0RT6bMU-8ABJbnDqsBg-1
X-Mimecast-MFC-AGG-ID: 4C_0RT6bMU-8ABJbnDqsBg_1769491004
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6ce1b57b9cso2554370a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769491004; x=1770095804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/m58jsrTIZK0luSPJaSrEgjDGlXyqLhzlqk7ugFZnAI=;
 b=rGg7dSx01shZj0N6ntVqQQcVhMlsbVR+pMRkjwS5xc4TbCdyxcjZbQzg5LxxyhtdHj
 xOPtUuBjUl/D3V4VPopOwmYOraCVGeyoGuVXx38dG3R5gljgH5qsuLv/snaYh9YXFLCU
 0brH21ckTa6lFc7bctidcM0V6KUp85yOHV1YGOOeh9BMfTZa6UMLJ+ek/hGO7Thsb/B9
 lDuoDd9xL8LXHG6ZEpDeZ+H7V4/ebXNazBIK60r2NB400z7orJfizYXuvMXCpfyfgqNh
 y0NUJ5+NMFYbrUEl+TOmjXWqJYluelIWYuBSmv5sl81jVuBpTYgVTVWWEMTbbFDehzWo
 xFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769491004; x=1770095804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/m58jsrTIZK0luSPJaSrEgjDGlXyqLhzlqk7ugFZnAI=;
 b=FVgrCQAAHBUAIMq1k2KpegxcmdQU47NxuGrWlnlLBONV1lxD4TjsH81UToqXDlJ3HS
 ns2hvkDancrVglwtBf726JWkmB+VswOO7Q63xuClDBLJx1Af0HKJbYUg0xaEJOWJ0F7L
 +QwmYW2eUU/OGUui7PziFa5D/FkRnwNChiPDLK87f3d1ScHQbY27pnKOlxWbMNCdpVOz
 WXNikHDZwDQBSr729Ae94KuAvWogAp+6lWvqG51/gTCbCDlUk8egL4d4r9zeloEw+7l4
 pe04WUL7ZR56j8CZJvxSHm4BZnqvKSFdEXKKL7Ki3hknyz6lVdOiB8r0pR7jiIjepPfj
 W5SA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHxJsvA+x5NRVKx2Te58TPag8SqoAw5JLfz8bA08nYRCU0XxjZAzpvxAcJ5yQS4iCUmRTMtD69UVJC@nongnu.org
X-Gm-Message-State: AOJu0YzSKm19Qz0tsCQu6paPd/QZM1vgySJ2zQEnsikpbBMPvkDBqYCa
 OUb2d2Qx97blBzq9gt12lv5lXgHiZeyqs6/iLEFXCqXaw/CYZUARyCkNGvQGjtfQYuUhc0+HOkQ
 E8HqfvLQeoxcMU1e2ny6A3b6+0ZBjaVK4Lq6Y6xi2OuDDzJBB8CM9M+Fa
X-Gm-Gg: AZuq6aIaeeSJDEQ7j5cXN3P6JKOwVpHQp4J/FSIYlgUgLhG+t7mbyae0rJ+uop0lLwB
 OKklCQVY1k/21H/Y4yKiu3jYczdT7e/nmIqRDe98Aj1o7jamZSa3xScZ3k/BCwrH/NUXr9Cb2kx
 kz4eWaIWEgOYqkub4x97fsz51YSd6MNJXzJLlhx41aHj50L/vCL8DUqEq+6XvsWuUgBy3B1fZRs
 plG9g1uXc0E9uCcXvRZQEM0u0QHybwGWEVrnzDor2BcDfBUh+foZygCle/Mim+Rsz4+Vn1PwHNY
 iVxMfXL9TWB97XhlTUlE9Qf6j7yWxUM9ZMYeycfKhHM8a0MYDAEaEhyxYN+2b/G+STzS6xE//A4
 uYhWzdCcZV/xUgeQmp7p1dEl+Vgv00vWNqDGT2eFsPg==
X-Received: by 2002:a05:6a21:62c3:b0:38e:9c27:72e8 with SMTP id
 adf61e73a8af0-38ec6279239mr485150637.4.1769491004094; 
 Mon, 26 Jan 2026 21:16:44 -0800 (PST)
X-Received: by 2002:a05:6a21:62c3:b0:38e:9c27:72e8 with SMTP id
 adf61e73a8af0-38ec6279239mr485136637.4.1769491003723; 
 Mon, 26 Jan 2026 21:16:43 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:16:43 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 04/33] system/physmem: add helper to reattach existing
 memory after KVM VM fd change
Date: Tue, 27 Jan 2026 10:45:32 +0530
Message-ID: <20260127051612.219475-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

After the guest KVM file descriptor has changed as a part of the process of
confidential guest reset mechanism, existing memory needs to be reattached to
the new file descriptor. This change adds a helper function ram_block_rebind()
for this purpose. The next patch will make use of this function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/system/physmem.h |  1 +
 system/physmem.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/system/physmem.h b/include/system/physmem.h
index 7bb7d3e154..da91b77bd9 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -51,5 +51,6 @@ physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
 bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                         ram_addr_t start,
                                         ram_addr_t length);
+int ram_block_rebind(Error **errp);
 
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 9a7aba9521..6755d85319 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2857,6 +2857,34 @@ found:
     return block;
 }
 
+/*
+ * Creates new guest memfd for the ramblocks and closes the
+ * existing memfd.
+ */
+int ram_block_rebind(Error **errp)
+{
+    RAMBlock *block;
+
+    qemu_mutex_lock_ramlist();
+
+    RAMBLOCK_FOREACH(block) {
+        if (block->flags & RAM_GUEST_MEMFD) {
+            if (block->guest_memfd >= 0) {
+                close(block->guest_memfd);
+            }
+            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
+                                                        0, errp);
+            if (block->guest_memfd < 0) {
+                qemu_mutex_unlock_ramlist();
+                return -1;
+            }
+
+        }
+    }
+    qemu_mutex_unlock_ramlist();
+    return 0;
+}
+
 /*
  * Finds the named RAMBlock
  *
-- 
2.42.0


