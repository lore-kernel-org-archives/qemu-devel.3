Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9028BD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvF-00069s-Q9; Mon, 02 Mar 2026 03:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyud-00059f-4y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuS-0001vl-1q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7M/zJBnp0CFgI6to1PfNFpWyTEZ/2AsbsDLwiqyg5wE=;
 b=INesZFozVcULRI8wneFuWGOAtngDteqHPLyaHpjKUhOFhEdLWKeL5Ouc301mF8MrABYLrj
 UcBMwXJrjYYz4GuHbQw/1JEq7ODCYqFTkMrmi7SPhryImtbUvBfMPL4RzCFgm5hMWHfm2w
 6BHO13yeV6O7AMDlH4X3rLivMh0N2yE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-8-HEBw5lNKCN8340nWhlew-1; Mon, 02 Mar 2026 03:45:43 -0500
X-MC-Unique: 8-HEBw5lNKCN8340nWhlew-1
X-Mimecast-MFC-AGG-ID: 8-HEBw5lNKCN8340nWhlew_1772441142
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso42656295e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441141; x=1773045941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7M/zJBnp0CFgI6to1PfNFpWyTEZ/2AsbsDLwiqyg5wE=;
 b=Vu2nJmdynGwiuxI+8kp/W7AtEiUzxgCO4yZ46DXBHSgzthILSLX7tgRM3zTNkfW6CR
 PSo0V2RHUPLgAKAZEsDQsz4yX7W9CSSSN4hZCKY5bRksNt900vkjH4NUZN9Xcu4qXtFS
 uT0uLA0YLC2bG/Gip/kd2NOy2/rSk2e8sfCnLHuydzMADDxYWNA5zDdfKafipAxUHubF
 //lgt/r7safKXqaU9K5X2wZOEo9Xh9JXwdGmaePhuGhd+mskvALIEZ7lmtZEU2XFo3UD
 Vf9OL15l0/OyWr47dmkCS8hgKxOiu7UxKj5E5MoNFfwHRz6cxItJX7MsJJz8pDuCj4wm
 vkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441141; x=1773045941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7M/zJBnp0CFgI6to1PfNFpWyTEZ/2AsbsDLwiqyg5wE=;
 b=fG28nfF24its+P+VQd+7TQTK3zvl9i/kFSiPfG1FYwjhYaLsVP1tCBCOEUxYBqI2nu
 wmzKPeIRPWwNnNRqgZcQMrTpKOHG9AqHXR+VcSr7cltCRebCPBsX6oBJz3r08CQXLcPW
 A6pKrbzR4YTDOIaSbyjBbRt989cwpijRtFMApfHm5G0vqM20S3/beBnAnDqNsBexQHKC
 YXaDUyR631/xYwyba9RPv+LLZNMMwOxUu0G5MNt9771l+tsPZ9K86h0tdtg41AFApPzm
 Docxj1WgOASayjQLX3mljfDTq/Tas0I4mKUXtKkceLv124xUh7oFF0PXF3gDPewtXaf3
 GZ0g==
X-Gm-Message-State: AOJu0YxZB6h+1FPNBafeex5LY7ZWuNOEZBCZgBvSLml4u6bGVtqt1sn+
 xMrxqoUK4rCq926mHYI1QS4dGp/eaqWkfiFkzcOH3CobyzWt9vaZRq7FDF/4eXKxMBf9zoDkLyj
 NRXYAaZbAIREkPlR9Nwlz2B8Yu/+NJbU/vRqT8COWEBJsJq6j8ikyVmKqEkW8+HpDFk7EieuMGg
 QH10VYJiu84hVQUv3f38bC/O47SrJFVq5OqTL2U0Z0
X-Gm-Gg: ATEYQzw2x/6yEqYaK9fXLSLLk/rn362yt0opWko7fltjnIfS1A9KVxpGzaDR60uHIoO
 eeDi4c4BjbL2OLiMBELaOjS4dhWdGdIB81JZq/H9ti062A0j9d0IzqFhdD4DuT0Hj+vRqXNI/a2
 8oqe/cw9ffrcpzY62LedF9zOgLdINOx+Z74xn1SX9IenCoAPVYokdgicKpuRt/GmHiNQLNz598A
 PKFdX1exefgYwMOcjtwu1tofrnUduKZ/nGwCC6foWO8oRw/VNcvz4SPAE21W1b2asNzxBYmQa2A
 6BICA/38Ej18awp3b5W5LxCnEsjHDotgaRyLGgeKDNFZw3zoQMxEvsSC4bsc3Ttw7xd3ndEfFIU
 WA10uPb4ADt0HGH8TAM45aPi8A/Dd0Z3jNJgwxm2iU4jwphqNXTxcvpIugjtgWjSwuZq1k0QK75
 hvgnx4sIirVSou+fD/vPScxwXVpEU=
X-Received: by 2002:a05:600c:37cf:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-483c9c23b6amr203555455e9.23.1772441141599; 
 Mon, 02 Mar 2026 00:45:41 -0800 (PST)
X-Received: by 2002:a05:600c:37cf:b0:477:6d96:b3c8 with SMTP id
 5b1f17b1804b1-483c9c23b6amr203555065e9.23.1772441141141; 
 Mon, 02 Mar 2026 00:45:41 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb789efsm205306465e9.2.2026.03.02.00.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 045/102] system/physmem: add helper to reattach existing memory
 after KVM VM fd change
Date: Mon,  2 Mar 2026 09:42:40 +0100
Message-ID: <20260302084338.473368-46-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

After the guest KVM file descriptor has changed as a part of the process of
confidential guest reset mechanism, existing memory needs to be reattached to
the new file descriptor. This change adds a helper function ram_block_rebind()
for this purpose. The next patch will make use of this function.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-5-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/physmem.h |  1 +
 system/physmem.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/system/physmem.h b/include/system/physmem.h
index 7bb7d3e1545..da91b77bd9b 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -51,5 +51,6 @@ physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
 bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                         ram_addr_t start,
                                         ram_addr_t length);
+int ram_block_rebind(Error **errp);
 
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 2fb0c25c93b..e5ff26acecd 100644
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
2.53.0


