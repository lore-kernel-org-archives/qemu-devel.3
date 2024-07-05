Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B4EC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPktw-0005eC-HU; Fri, 05 Jul 2024 11:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktq-0005bl-Uf
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:04 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktm-0000Im-Fn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:02 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77c9d3e593so103473166b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193455; x=1720798255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CurKVhgGzPO6kvK5KOd6kl4xIM/fKHjGD5Ox4ZiqWow=;
 b=QooZZcdZAyIt6GDlokBLZJb/gbEL0O4BwIdWv/6PLTYW1rmf27H2wPHiYhdUsHW+aj
 I6G5yB7oWWpRrJ0tb00rs/7YmFr3R1NHgeybw9M3TQf94ohp5uRqypLfh3BHYUbeFRxU
 ificnIkuJo7s1RAsNFvIxDu36I29jIdpsVURL8mQU832ho39SOlcudUK5KnyW6IAJMMK
 P5WI80RJd8zMaFPWPn1w9IdvDbG5jmT9tr4a1TD0mDXrGi712Zih4+ekS+hs6/amOOFK
 X4W7i9nG3Av7VQHfZfZKNTsQl5wHCzWL+V+DPM8IuvlJReoIls/wdBKsjlPcfDVURfX7
 aU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193455; x=1720798255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CurKVhgGzPO6kvK5KOd6kl4xIM/fKHjGD5Ox4ZiqWow=;
 b=UUFXreYZxZirS91Q3jjVoULn36RrKfIe/YwW+xKV3Ou2JnRNvGGL7/1VihiLJOLpD+
 A90QoCYP6HOWrPmPp5DN5CV1rHsQUGYjA1bG+av9qHBWZS3RWqvVW7mq2rLQZuCLKpQb
 KETLug0Ja794zPGCsnO+xVx3D3Jf7CYPyA/dQyKLEi+2tWDj4m62WnTyccUq+7Xejp0D
 ydOtPXsMhVakFq8rDgQNMAFSLfaJ11fBvb1u9rjHEG6INx6TTM0GJ3ywu66OGi9bW58F
 jx6r6INlZE5qf7tfySBBX3OJdL3RastXnTCMimXbVK91c296Az1FQQrzCaacjYYYvAfK
 jFvg==
X-Gm-Message-State: AOJu0YxdChggzgQYEbzAw+BvLrZFVswh0c0TkRoqbaZy7VlHjgMLqS7h
 6Om/Negtly2sXD/mTHZc83S9dQL9SEFJuOKB7sdKwkEs0NiiVTz3kESIltSNfoI=
X-Google-Smtp-Source: AGHT+IF0L1QaqcKeMInhjUGjMZY7zdiQR+gsY0atO7qfHdPnG18IVrxR7GmLOfGE1HRAEy9LNzQQrg==
X-Received: by 2002:a17:906:5acd:b0:a72:631d:6de1 with SMTP id
 a640c23a62f3a-a77ba4785b5mr338581866b.20.1720193454930; 
 Fri, 05 Jul 2024 08:30:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c3925a96sm105257666b.120.2024.07.05.08.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E4895F92B;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PULL 03/40] tracepoints: move physmem trace points
Date: Fri,  5 Jul 2024 16:30:15 +0100
Message-Id: <20240705153052.1219696-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

They don't need to be in the global trace-events file and can have a
local trace header. Also add address_space_map tracepoint for tracking
mapping behaviour.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-4-alex.bennee@linaro.org>

diff --git a/system/physmem.c b/system/physmem.c
index 261196cde0..14aa025d41 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -53,7 +53,7 @@
 #include "sysemu/hostmem.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace/trace-root.h"
+#include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
@@ -3193,6 +3193,8 @@ void *address_space_map(AddressSpace *as,
     MemoryRegion *mr;
     FlatView *fv;
 
+    trace_address_space_map(as, addr, len, is_write, *(uint32_t *) &attrs);
+
     if (len == 0) {
         return NULL;
     }
diff --git a/system/trace-events b/system/trace-events
index 69c9044151..2ed1d59b1f 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -21,6 +21,12 @@ flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 
+# physmem.c
+address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t attrs) "as:%p addr 0x%"PRIx64":%"PRIx64" write:%d attrs:0x%x"
+find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
+find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
+ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
+
 # cpus.c
 vm_stop_flush_all(int ret) "ret %d"
 
diff --git a/trace-events b/trace-events
index dd318ed1af..9cb96f64c4 100644
--- a/trace-events
+++ b/trace-events
@@ -37,11 +37,6 @@ dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
 dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
 dma_map_wait(void *dbs) "dbs=%p"
 
-# exec.c
-find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0x%" PRIx64
-find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset, uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 ", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
-ram_block_discard_range(const char *rbname, void *hva, size_t length, bool need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d fallocate: %d ret: %d"
-
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
 job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
-- 
2.39.2


