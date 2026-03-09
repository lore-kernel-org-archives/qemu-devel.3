Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D009FCA189
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPI-0004kp-H8; Mon, 09 Mar 2026 16:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhPB-0004go-Tc
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhP9-0007nj-E0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uf3HD61cPR9EZKQ9SCtWf0wlWyOgzRoud2zUcsD7Rg4=;
 b=RHG0OThO6MoDDTGygkpRJU6f0TTYg0Cbo3b8SES9iyBAwQuu5G930PV4uUczHX+Vg1B7BW
 hyLfrWSF4QL5jksQMWcFQXJ8ukvxOW+VJmNvRoacNziG41pH0J4C5zsPfpB8JE758JjjA7
 jiieC36UF0FZkkX4K6WDA3hYTZ7U0zU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-MnOoPJ9DMs-6iHB1nXkgcA-1; Mon, 09 Mar 2026 16:40:40 -0400
X-MC-Unique: MnOoPJ9DMs-6iHB1nXkgcA-1
X-Mimecast-MFC-AGG-ID: MnOoPJ9DMs-6iHB1nXkgcA_1773088840
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd7ea0bb20so1071408785a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088840; x=1773693640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uf3HD61cPR9EZKQ9SCtWf0wlWyOgzRoud2zUcsD7Rg4=;
 b=fKJITlpsZsS9K2rfXO2tHoXzaxWNm4fqj5e4VrEe/FL/iKg3dQ/MMxCVTX5mTLVFZZ
 fBSOBJZDP9tso+mQYuZ2RYt0O4FV4PiGUWJt0Mz9XRl3aqF/EXT3mwz/idhgm8pT5A4F
 /Zks+nyu1dFkyVQCyEtSdJFY47Wu6/7wWIlgVSpLgCYdQSSq7vvQavzzf3L528rIOl9M
 G/3YPLf3r2JXrBCHlRn4WCqptQgkgc4YhRbkrRXN8whZ1cN/cScsGSnZ+YZgISAmp38A
 twA76y/r96rGZFM1vnrPM9c7sqZLk2PCmvVQqFf3HhIsBm5O/MfgqvD+P11/mV5FGS8q
 0Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088840; x=1773693640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uf3HD61cPR9EZKQ9SCtWf0wlWyOgzRoud2zUcsD7Rg4=;
 b=Mht1FJiFO4c8JG6aOFfVH1ynE699+jzSGwUI0QVucaBRqiBq1qSaBpcrhrID2vV3Yd
 DlN0aDfA3FlL0FrOSaPr9nGl/FjARaLdkImfU5JPetQCPJyFaGzdDZrqTEulVJ+fsfAa
 x8dqIJ6lVRf0qHu1fR7rVTUZW3LAHu+SrTpMm5WFdKVfcQ7HfL0ojbuxXz8ihkYRrMOH
 wvEkq/VJzz8GHZ4FDse1Zc8xRXmU5IoPPR2/iOiGIus8itniBA+wYGp2REu8jtX44051
 dfwEPUgGDW3i29iKADIdQuuDXlCvF6jAzAMovemDNBczWS4y0tGa5FgjIrX+Sc74l/jB
 497g==
X-Gm-Message-State: AOJu0YzWm5qInn1uRnlPcrejYppWA2nlJA+ZR/TX3GjvRnAnE9awubbj
 4qFPLRQGztVIgYll9SbiYUI48/c5dGWR6KtHOk/2mmy5bkNR9rKksrZHBd/y7obOReFVOO6pEL1
 4aiP8mdlfbDmmvjp6JmlT1AOIqD9fJfj7yOvRSzqMkPy08CqHo0C2Jk2BeZKKxXhp408Q9+Lb7i
 hIVJwJBISti73U0JT/KPThM6Wsg+hCoSbfUq0/qg==
X-Gm-Gg: ATEYQzzUufdNBXmOoNJy+yDS2hdylRLUYhk4ZYbt8NkoBWhLu7aP54NjKz3+wut+Z76
 /YWTpleNBb7Y8eSueQ34EwHB1aSQtTfNdWotJ72HTda6RPXIBhuPR/Pd+de+qFUqqGjMo39Il+W
 Oqo/mM2towK/XNsKA6rcAWhWC2FI3QTHoASiqh+uVmHdbCGbcV8qdBl5SDhrFvv0OeoAWw0muh7
 jbGcYVYpMbjJ+yTxsBQCf9rvd0A7X+ILjYJZpNjYGZ0DGsm8l4peB0nDoW1u3pA30N1YV1egzBu
 /JNpPBLEQBrJJJG4T6JLDVKidbBjvPBYq4z2nyX8BnbBAKOhWVlhLLU7FXlZVJdLzLALwwofQNT
 l0FFY4emlDPds4K63ITIx0Odm/bvy3PZglweHW8gyQuIq3AYsBT9TK4/qYbUAya0aAATQoWHHui
 6ce01yKg==
X-Received: by 2002:a05:620a:564:b0:8cd:7f7d:b089 with SMTP id
 af79cd13be357-8cd7f7db148mr689055085a.70.1773088839708; 
 Mon, 09 Mar 2026 13:40:39 -0700 (PDT)
X-Received: by 2002:a05:620a:564:b0:8cd:7f7d:b089 with SMTP id
 af79cd13be357-8cd7f7db148mr689051485a.70.1773088839159; 
 Mon, 09 Mar 2026 13:40:39 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/18] system/ramblock: Constify various RAMBlock arguments
Date: Mon,  9 Mar 2026 16:40:04 -0400
Message-ID: <20260309204007.1709441-16-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the RAMBlock structure const when is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260309183536.88976-2-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/ramblock.h | 28 ++++++++++++++--------------
 stubs/physmem.c           |  2 +-
 stubs/ram-block.c         |  6 +++---
 system/physmem.c          | 28 ++++++++++++++--------------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index e9f58ac045..4435f8d55f 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -154,26 +154,26 @@ RAMBlock *qemu_ram_block_by_name(const char *name);
  */
 RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
                                    ram_addr_t *offset);
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
+ram_addr_t qemu_ram_block_host_offset(const RAMBlock *rb, void *host);
 void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
-const char *qemu_ram_get_idstr(RAMBlock *rb);
-void *qemu_ram_get_host_addr(RAMBlock *rb);
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
-ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
-bool qemu_ram_is_shared(RAMBlock *rb);
-bool qemu_ram_is_noreserve(RAMBlock *rb);
-bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
+const char *qemu_ram_get_idstr(const RAMBlock *rb);
+void *qemu_ram_get_host_addr(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_offset(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_fd_offset(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_used_length(const RAMBlock *rb);
+ram_addr_t qemu_ram_get_max_length(const RAMBlock *rb);
+bool qemu_ram_is_shared(const RAMBlock *rb);
+bool qemu_ram_is_noreserve(const RAMBlock *rb);
+bool qemu_ram_is_uf_zeroable(const RAMBlock *rb);
 void qemu_ram_set_uf_zeroable(RAMBlock *rb);
-bool qemu_ram_is_migratable(RAMBlock *rb);
+bool qemu_ram_is_migratable(const RAMBlock *rb);
 void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
-bool qemu_ram_is_named_file(RAMBlock *rb);
-int qemu_ram_get_fd(RAMBlock *rb);
+bool qemu_ram_is_named_file(const RAMBlock *rb);
+int qemu_ram_get_fd(const RAMBlock *rb);
 
-size_t qemu_ram_pagesize(RAMBlock *block);
+size_t qemu_ram_pagesize(const RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
 #include "exec/target_page.h"
 #include "exec/hwaddr.h"
diff --git a/stubs/physmem.c b/stubs/physmem.c
index 14667f2bd8..2eca06ab6d 100644
--- a/stubs/physmem.c
+++ b/stubs/physmem.c
@@ -7,7 +7,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
     return NULL;
 }
 
-int qemu_ram_get_fd(RAMBlock *rb)
+int qemu_ram_get_fd(const RAMBlock *rb)
 {
     return -1;
 }
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index 8790a59593..1c79e447ff 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -3,17 +3,17 @@
 #include "system/ramblock.h"
 #include "system/memory.h"
 
-void *qemu_ram_get_host_addr(RAMBlock *rb)
+void *qemu_ram_get_host_addr(const RAMBlock *rb)
 {
     return 0;
 }
 
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
+ram_addr_t qemu_ram_get_offset(const RAMBlock *rb)
 {
     return 0;
 }
 
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
+ram_addr_t qemu_ram_get_used_length(const RAMBlock *rb)
 {
     return 0;
 }
diff --git a/system/physmem.c b/system/physmem.c
index 7eecd81877..e5390d09be 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1859,48 +1859,48 @@ static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
     }
 }
 
-const char *qemu_ram_get_idstr(RAMBlock *rb)
+const char *qemu_ram_get_idstr(const RAMBlock *rb)
 {
     return rb->idstr;
 }
 
-void *qemu_ram_get_host_addr(RAMBlock *rb)
+void *qemu_ram_get_host_addr(const RAMBlock *rb)
 {
     return rb->host;
 }
 
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
+ram_addr_t qemu_ram_get_offset(const RAMBlock *rb)
 {
     return rb->offset;
 }
 
-ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb)
+ram_addr_t qemu_ram_get_fd_offset(const RAMBlock *rb)
 {
     return rb->fd_offset;
 }
 
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
+ram_addr_t qemu_ram_get_used_length(const RAMBlock *rb)
 {
     return rb->used_length;
 }
 
-ram_addr_t qemu_ram_get_max_length(RAMBlock *rb)
+ram_addr_t qemu_ram_get_max_length(const RAMBlock *rb)
 {
     return rb->max_length;
 }
 
-bool qemu_ram_is_shared(RAMBlock *rb)
+bool qemu_ram_is_shared(const RAMBlock *rb)
 {
     return rb->flags & RAM_SHARED;
 }
 
-bool qemu_ram_is_noreserve(RAMBlock *rb)
+bool qemu_ram_is_noreserve(const RAMBlock *rb)
 {
     return rb->flags & RAM_NORESERVE;
 }
 
 /* Note: Only set at the start of postcopy */
-bool qemu_ram_is_uf_zeroable(RAMBlock *rb)
+bool qemu_ram_is_uf_zeroable(const RAMBlock *rb)
 {
     return rb->flags & RAM_UF_ZEROPAGE;
 }
@@ -1910,7 +1910,7 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb)
     rb->flags |= RAM_UF_ZEROPAGE;
 }
 
-bool qemu_ram_is_migratable(RAMBlock *rb)
+bool qemu_ram_is_migratable(const RAMBlock *rb)
 {
     return rb->flags & RAM_MIGRATABLE;
 }
@@ -1925,12 +1925,12 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
     rb->flags &= ~RAM_MIGRATABLE;
 }
 
-bool qemu_ram_is_named_file(RAMBlock *rb)
+bool qemu_ram_is_named_file(const RAMBlock *rb)
 {
     return rb->flags & RAM_NAMED_FILE;
 }
 
-int qemu_ram_get_fd(RAMBlock *rb)
+int qemu_ram_get_fd(const RAMBlock *rb)
 {
     return rb->fd;
 }
@@ -1987,7 +1987,7 @@ static char *cpr_name(MemoryRegion *mr)
     }
 }
 
-size_t qemu_ram_pagesize(RAMBlock *rb)
+size_t qemu_ram_pagesize(const RAMBlock *rb)
 {
     return rb->page_size;
 }
@@ -2772,7 +2772,7 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr)
 }
 
 /* Return the offset of a hostpointer within a ramblock */
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host)
+ram_addr_t qemu_ram_block_host_offset(const RAMBlock *rb, void *host)
 {
     ram_addr_t res = (uint8_t *)host - (uint8_t *)rb->host;
     assert((uintptr_t)host >= (uintptr_t)rb->host);
-- 
2.50.1


