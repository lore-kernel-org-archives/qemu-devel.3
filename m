Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v414e-0003jz-LO; Wed, 01 Oct 2025 13:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v414Z-0003fq-Cz
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413o-0001ER-DE
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so792795e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341372; x=1759946172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9xet65TEOOSdiYR/N0e1Kg4Di5ZGCrU0GtjpOB6lB8=;
 b=IWs0jrYkHhiE4HcoT9ncWx4flGxfyLcashOggc8a1ha3z5EhWjAauhzFEP8Ytk9OZ2
 KotC5QXQmJEsWr9paBdHE+hylvTnl1l1V9Xl3hJw+8gU6g/yie15+UMpNv1GOafMyFy1
 iD6/QTKl1clj4oo6M+F2lA1KflmONPWX9RGWGzf5f19dvqy/sxwQpccb8Lut7CX8cbzt
 apmKmtKAN0Uxdb3u/zMdmWmuq6hpbD0FkMZt3imBMB+r98b4dzlQeCoUENUfyLBCbQwh
 DYhkXGGVz8fXzZrR7Il0Dl1O3f79l1urvnFcGkVhaYHZqGM5DjNbJ2OBudZxWaFn9nDF
 w79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341372; x=1759946172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9xet65TEOOSdiYR/N0e1Kg4Di5ZGCrU0GtjpOB6lB8=;
 b=EJo5yLh0HiFrZiSGndTWfMm3L03xlmOiBxOFpwoaMuXq1i3NCpS6fYQH3aYGtWWHvc
 ZN0/VkwQXrS279hB+dGqty1hplYGLrsDCsI/04Knm2GRGim0qedfrVToD7V4oZVmEMXt
 pfgbsfXLp8b3bQ9c48UKLWXNiY+W0A7Io9UfZWu9pm35EijLJVloZro86sQmTJ0GS0bQ
 CEJ9oL1pvuYdapXJnc1meTa4wuJnbO+UvFYgNrbbuUh8Bj+4rsZAPIwwydvaF/zz9+hO
 VbVfUcChYaX8Xq9rd+vWIRXhYc78itVlQAwPlT93M66XxNqO2YAiImgU/UxlgrjVJuOr
 ZYEQ==
X-Gm-Message-State: AOJu0YynwQNA1iZnL7c0+e1n8mp7+UturZuBM17OTVTeFFHzdhvOzqmV
 ZwsRiHbrQf+0YGAlbKgXlJgJzqWg5ZGZS+FfUcF0QmRTdVpMQx4dR2OGLmF2pRf5WGEKzq0BmN8
 lDAWf777Wkg==
X-Gm-Gg: ASbGncvaNopptIGB86aCC4FK+8Q1iznjGrE5VJABt7REAGMsvLQ5aaLjbvX9cqR/o6q
 thQYhefOy/cYvHGmlzTCIkbYpKcd6193oeZsKleQMcx/g/Yi0fW+MOD5/yl45pBDJGBEgvZs6p0
 9lF03jfhXlF7uqzL1xR9NFRI7TXDI2vCe+YxW+h+OJye0OsJx3Pv0WaxAmIkuy+xslBhdvVUlDC
 dPHRmHVk7lQN4gmELOzjawkrmDee64x+s96ahOat6TnUVP/aLENqJfqEnThKOA+aFjAAHKz67YR
 rPQr7bthiN2PV6h36+snOAxDS5KnShukJCZb8Jb6J235GOFlRfc0QG4hCy3pAUXj/XxjM967md3
 U0ytsNGwsw9Bn47RsQExz8KcfddLChADVXZh9OaAToRd5UhlDiE+8WpdzMU9wtOOMSjxmQfJjpZ
 qJn1xgAzJtRzh3MNrbKNqkIviOmQ==
X-Google-Smtp-Source: AGHT+IFtPw+XkDGCPtbOzTM8COU+87F0gw68e5y7gIRqG0MAwDKlBk+G4T/X6jf8Wu0bRkQQ3KANlQ==
X-Received: by 2002:a05:600c:4e48:b0:46e:36f9:c574 with SMTP id
 5b1f17b1804b1-46e61269e21mr35695375e9.23.1759341372177; 
 Wed, 01 Oct 2025 10:56:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a2a808sm49585535e9.21.2025.10.01.10.56.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:56:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 15/18] system/physmem: Reduce
 cpu_physical_memory_clear_dirty_range() scope
Date: Wed,  1 Oct 2025 19:54:44 +0200
Message-ID: <20251001175448.18933-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


