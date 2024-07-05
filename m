Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3F4C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeV1-0008Q9-3O; Fri, 05 Jul 2024 04:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUy-0008Oz-Lt
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:40:56 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUv-0003Ay-6s
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:40:56 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso1603325a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168850; x=1720773650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFrU6v/HY4VIQITgassfFHdNS/uhlHYlsqE77XfqPZs=;
 b=AzkkqL450gSHHsGVLbtLqWdfec+mJ03Lhh673oDIwb8ypGeUDu8dBt+148Zd99sy5j
 4mvM6Vi+xIZc1rya7pJ9fR3p4xbn5FD6w+iXuB9nzBjbCGhWEQ2fmdDsbnxsf6biHZ+3
 B85HTqa+YAxRSj6YsdKYFdht55i9R+ZAPnBb+qZbhrcIKgDKruV/QWOrpyylfx9ekCSP
 pAPjHg7OzZE4BncJdw/HWwdu1rt8uak/S5FQL76sFPpjGadNuDYYUiS2LHpqGmF0Zwn2
 hZKRBJEok2eiaXCRF4/1OW1oozmBYzZn1vJvbZ/W0oEyNKGXOn4r3yte2bSI6FFsAuqh
 +BEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168850; x=1720773650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFrU6v/HY4VIQITgassfFHdNS/uhlHYlsqE77XfqPZs=;
 b=AXaFWGVwFp48+n9RkUEp9kSoaH7jEgSlpHB9X19nknDd391Wj4OwaUgw5oxPFdn3kW
 kSUM/j+H95Dql94DKoHbrfR9SvoEcImJKoSmieC9CdwfLHsLnyIseZvvkMMmsAh/Koda
 XmCqle2ZtaddZ2EB6X3LiNiC7iKKA40O1e8vvK9RzWO0REKPp5KkC3TACAVsh71CdJaJ
 +xxByx5QL5ZEQWcR4C8jjMh+xNJwSiJhVAClzBsmUoovJncAuCCWI31nyUxbjqABvf/S
 4O7YdKVhKrEhKn2cRPkmLLMA3P5QCflZpZn6RtD/o7bHe/FASejdQ5MdJYbpJRC7YSUU
 WKdA==
X-Gm-Message-State: AOJu0Yy/zf2AN84Z5rU+nARZZIq3rv4MIQiw9wT+ZNyXH+2iEfoM2XJ0
 DPyMswFyfGjzE3AIBChj5OGOAZoj0oiiuwBar49LGET9vr3q8jTgJ4e7zt859KY=
X-Google-Smtp-Source: AGHT+IEo1flafWU6+cEdwievaIimim5rz1ZpyRSPd/NRdT7yRN98lzK6pWrUpa6eCwXBYCDy2jZVZQ==
X-Received: by 2002:a05:6402:278e:b0:58b:fd23:7065 with SMTP id
 4fb4d7f45d1cf-58e5aec8d0amr2298950a12.16.1720168850164; 
 Fri, 05 Jul 2024 01:40:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58ad8730dcfsm5113394a12.7.2024.07.05.01.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F102B5F92B;
 Fri,  5 Jul 2024 09:40:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 03/40] tracepoints: move physmem trace points
Date: Fri,  5 Jul 2024 09:40:10 +0100
Message-Id: <20240705084047.857176-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Message-Id: <20240628124258.832466-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - dropped qatomic_set which came from another patch
---
 system/physmem.c    | 4 +++-
 system/trace-events | 6 ++++++
 trace-events        | 5 -----
 3 files changed, 9 insertions(+), 6 deletions(-)

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


