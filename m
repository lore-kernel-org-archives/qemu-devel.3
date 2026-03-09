Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79050FCA16D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfSJ-00078s-HS; Mon, 09 Mar 2026 14:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSI-00078b-7e
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:35:50 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSG-0003VB-CT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:35:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so10493015e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773081346; x=1773686146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xA3KiBRZDEy+tGK0VBSBg6K/vS9OJsxKrmQTjGkh/tM=;
 b=r54g4rNOxfL2dZgOm3oH2kHJd71A2PLKkxyqZxtp2hI84nQ8G+bomJeIsKaeRHCJ95
 XvPAY6ZAjv5Yucokg/o0K1W2RDTggbVsBI35KBU3Pw+/3ywCUymO1UCIMUS1xriC5ky0
 jYIPZnZ4kDEU7p0wKM/EDzC9QazXI9Z1jVXTpYc5s3wQcqHHfKt7jC+FsCMF2c12mIGr
 4lF5q/xvawbwjVrzAg9bqo/ND0JrQ3KCpxTZHPvzDHu++wmg3+xr2aJrKpAwIN0kOCay
 uTI3K7LudwXfo1c2+QIbY4HnVJeHfYy47UEV9I0tRkfxKJKgATVBNvKBnvTSplxjBxK5
 K9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773081346; x=1773686146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xA3KiBRZDEy+tGK0VBSBg6K/vS9OJsxKrmQTjGkh/tM=;
 b=WJCL5tXfW2GMTRbLVG4K0exzCbFzuvCi0iUo8aiyW7lev0T5OqnBZgZoQSPxzyq+26
 LcxCR1l1XtlR6D5SXRAVbihTcyMw262C9LOhZELiiyGawnbOUpCKuM6sAsxgxIoLxzhh
 YgroaWySeyVuNRPTPjHSkMMCmTmn2/WeNgL10pUOk1MyIVR7dVXH6+JVA+rMHqznjVY9
 oa+o0HragjwVjxLLWNhu29uo2gQgaWt380G/9PD1a7v26LzXqshhx2+yUPhTiIlU3Q6s
 c767w2GfBDvG6wnWbJFGk51PRxdWfM8X0gk2CRTuz2oZzqRRlOiZOlPOCjtMTh7LkjZ4
 F1TQ==
X-Gm-Message-State: AOJu0YyBxYKyC+ia4CVbGmWBZTmqH1XM5rOT58i5iE1FTYBTy+rVZTO8
 NqI3PXhEc8ajMBCJqnHPZg5hRESjSFtJZr9tN32/dckK51V9rxQNsF4x2Z4x1YCt4GpLdmIlBk/
 dtoPeV4c=
X-Gm-Gg: ATEYQzxsZ2R5g+jjVGJ/OApGHelNCQsKcJBnupxXOlaLb5fwMLjPNTKDhYwtipVdyIJ
 xU9t0WZ8vahVzPYu6m4E2nMglq0Ii+FGyxojl8hNDhXz58ERT5OdpML9uTqb/9Sn4t2uNPpTekc
 jR28ER7b8b+4hm0xlEAF/gqBV6JMDn2YlSOKYYy6QyrSqssop+RAGN8hJ8K/xY/minvzXysM+1A
 jOkNmqm/8DoyQoF/Fv31XCoBRJy/8shgmzWvrd9vpOyDayTTSZmFnc+uWz5DfL8tLg4NTt/HRrT
 CO5pCVXtUzdbv3t0Nk2YbPwYXGg9vNBzyw9jmPUffyQwmuzVrhsYIpAEYbZHXtKDEbGq5Whh94L
 B1Hl2e+VKfCpvvJC2BP6Z26j5gcHG9wqmioaM9bFhCRmmTLrK67dBscaNsDqbVjtgrLjsgxfbri
 ZaZeOTcQoGmcN0LBrNNXfySzL5olrB3dcK+0WkkRj2TipzxYuVXg0edi7HfbapBuiCtUcsLi/d
X-Received: by 2002:a05:600c:3b8e:b0:485:35a4:939c with SMTP id
 5b1f17b1804b1-48535a4a188mr113829175e9.29.1773081346102; 
 Mon, 09 Mar 2026 11:35:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a6bb86sm9367755e9.1.2026.03.09.11.35.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 11:35:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 1/4] system/ramblock: Constify various RAMBlock arguments
Date: Mon,  9 Mar 2026 19:35:32 +0100
Message-ID: <20260309183536.88976-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309183536.88976-1-philmd@linaro.org>
References: <20260309183536.88976-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Mark the RAMBlock structure const when is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/system/ramblock.h | 28 ++++++++++++++--------------
 stubs/physmem.c           |  2 +-
 stubs/ram-block.c         |  6 +++---
 system/physmem.c          | 28 ++++++++++++++--------------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index e9f58ac0457..4435f8d55fe 100644
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
index 14667f2bd8f..2eca06ab6d6 100644
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
index 8790a59593e..1c79e447ff0 100644
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
index 7eecd818770..e5390d09bef 100644
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
2.53.0


