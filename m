Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BEAEDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9Q-0007b9-B6; Thu, 12 Feb 2026 01:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9H-0007aP-OW
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9D-0005Cy-IE
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=UA/8+BUzd5t4aralgdZgzJO8S0faIpabSpWs1bSkd9+0LD3RAIG3L0gXhZh087mNfUyMp4
 y0qCcsWxR5rKVAJBrRTq39Tts1KziQAJDrpiVcVCz0ASNoNIUc81QfepwDOpnj3A9/Am7m
 8k1A/qk3s2CTBiQpblvajdFOOLrifxE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-qxpI8AkIMnaIe5PGyGXssA-1; Thu, 12 Feb 2026 01:25:49 -0500
X-MC-Unique: qxpI8AkIMnaIe5PGyGXssA-1
X-Mimecast-MFC-AGG-ID: qxpI8AkIMnaIe5PGyGXssA_1770877548
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-352de7a89e1so2597503a91.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877548; x=1771482348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=LcR6n4HXpcgdzNuK9X2ewFpR8tlstAQcdjqPJztnhIJdTUfXhB9ImtKtg2QVWUWRxA
 tlR/1H3k4iinkRDcJcuJoBhq0lm1ujd4rumD/B/sz0ot1HjiBwJ366Xer5us35x6mIfF
 UX8wLCf2OugomjFOttElXyrBTtzyTL6iQ+AA4dERf6oIimxgF3Oxv6ioqdzKKSKFBfoT
 UiylrgQrT0UNq3ioauUR3iCRT8Ug4hS25okZxZFqvgYQnTIAy6DVc5P3gO1PXzePZyFu
 cQsGpsu0qoZQ24IT+D6ThQGls65Z6mFrc2Ov9jHPtOn2Ri6/hc7jGuk1lpAJmGYQxT4I
 VE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877548; x=1771482348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CftdgO1HF5JRk8FcUFdEbJ2ICGVN5WChV4mkQQejD6c=;
 b=iGCka8XYapVSFtCF3A6lLoJ1RBRQZYWvpLGST94CgNpiX708X+GZm9FVrcqELbetlL
 JieM5VnH8lMR7KlAfqjJOp1NYEa1OmkgCE6AGfojaxZoLiplpJul5EIqLaSeE4HdTWul
 6fiA1Sz07wc/y1UcDQt93MhN5Nmi4mUhDsSAIsVemhkBtzuvQRT4bMCsWsViEbNT2GR3
 /2aEp6wK3MpLLj+4PloVhC+Nn9qWZxaHkMMXwsCXIj9r2CRggliulG1NPvPko7kT0iSA
 SVQcE7KMBeX79W0QI4FTY8x7eSuLO1gQBP+/DN6nQ8NU06hVs5sMpEnEwNyJOK1TqP6r
 GpDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlk1zJJr6W/kQKNEAFSaZBt0HjFG28QEDo7rzwQzK5YOT2/Gq2iVmLJcvP7zSN/5udMTe4zheFos1N@nongnu.org
X-Gm-Message-State: AOJu0YzQUM6qmm9xJ2/YQvOaXLDRmuId3tCnCzz7Kbe0xA6JL22LkZcE
 6SH+QzqXt0lAFl40hnIBUKc/egrOFLrfKUmhE+AR1iy++YHecs1KjPNAmh6Ie/fbqeSqhhJPa56
 Sk6ZPHmWpN2U8KekOMzHxYl77tDRTGnZb98Die2QQrra4S7W9VpLmzIhs
X-Gm-Gg: AZuq6aIwxNj2PmB3i3SyGfeRNhONyibI4A6IQDqQsXrpbnTCb4IHwVoUegtZLfEW4zb
 AY9CDwy+SrciAF+YHt3Rs4iXU0oCtvMKqA0wrQzzwDnHeZ5djjrhDr3BAdF3OPScLdijIrnc7Ub
 GcKyomeqjbvSZBxg6ytmBoHl1xLiEnHiipD9H2yJh8Hrecc8b/pwhjxSDq9dU9/8yAHmzpNcMlJ
 mjzUEXh4X9mtKzKRflQ8YnhKos/x2HOi2LOjF0/2vuBeYFxPHQRvweWEG4fCpf+VG+ZbaLqeg9A
 YdMYJw12e97GX216LePA+hthbGkp6LTgmM+iGuzvGEBFjStqDskjcb++sfH3WbQU8BF7CCFGsLC
 HfR7Sir5VEIuDvLOpfuGjO8LJb4u+Mty9WS+cA3P8uqJIYIPiUtQ43KM=
X-Received: by 2002:a17:90b:4d84:b0:343:684c:f8ad with SMTP id
 98e67ed59e1d1-35693c924e2mr1222981a91.4.1770877548125; 
 Wed, 11 Feb 2026 22:25:48 -0800 (PST)
X-Received: by 2002:a17:90b:4d84:b0:343:684c:f8ad with SMTP id
 98e67ed59e1d1-35693c924e2mr1222970a91.4.1770877547789; 
 Wed, 11 Feb 2026 22:25:47 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:47 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 04/31] system/physmem: add helper to reattach existing
 memory after KVM VM fd change
Date: Thu, 12 Feb 2026 11:54:48 +0530
Message-ID: <20260212062522.99565-5-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 2fb0c25c93..e5ff26acec 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2826,6 +2826,34 @@ found:
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


