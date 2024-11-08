Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938C5D64063
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 16:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Rre-00005M-A8; Fri, 08 Nov 2024 11:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrP-0008UI-VZ
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9RrH-0003qm-0c
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 11:29:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so19781705e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731083352; x=1731688152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IopW0NUe1TNdNcszGjYz9ml/HiprL+NUDAeJGglZdAY=;
 b=cPtNcb6hiLRgbzXGmjdMT3MbUAYMsf9ojgZvScpFZ0ust2u/S5Y9hLHfcGojZwRmSr
 Or2uhX+YZiJPRght8KV4jEXsy2c19nqiAz2H5VaaW06rcHEX9t450BrHjxgzsl32o35B
 G8OATadpRP/gutFkP7oq8nDzKHuY4kXu6G/oILutZYIX/qzNgGUI4HgWrPbVJPbqHjRg
 BJimX3sMdfh/5UawtkXr57/kr5poQt001yq3XF0akblTHxgQjnv8U8A1jLcigqLbYIMU
 9kQZ0EwHpIhmHi4/r90yhaeztd9G82BWQ/11pI1jgcug/k2QIAWy55u/oBi6Kfxk53db
 3epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731083352; x=1731688152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IopW0NUe1TNdNcszGjYz9ml/HiprL+NUDAeJGglZdAY=;
 b=N4HCK+YO10eREf6q9yA7B7NazDs4GbALC3h2AVv77ZE6H68IXEMJ+/jsZgRu1vurjZ
 2cOeIF1VH6wZhLn+rVTtheUnMYhAOD3EpWlvr9vtKqEFWjhfK7uj1pcOuMAuy55ApSLB
 6BGhgy2ahpf4cuV8d7EXDdwZ4kHFJU5OjwIckWkDCQ7IHPJ9LkicucYQCAmc6+vbjD4M
 n8tBv0B6+EI+G0+wKMEYpIlJGIWv2ihVA5vT+kqN9dH3ppdcvBRxZKDQ+KJYuiFAu7HD
 F76bmEmPRNnfWEgZYsfaQyolJ1uNB5gFDVHvb30lAFzLFhe/sPR6FJgLEhCeYWqPPFOh
 RWpg==
X-Gm-Message-State: AOJu0YxDCywiS19GnYWVjgkJpsRD2USugYR8cwPBDiVd00d7YqS+f3o6
 6Ilt6VwWDg23PlH6P/lxHWynK8Ss4faG4eyETc0x32UuGJ3amqQ4ZC2PT2RdgOZz2vP0BibY2E4
 B
X-Google-Smtp-Source: AGHT+IHJfp7blm3cJ4xTkkEDsRmDuRRVkxkpFF8jX8vZN0Fj0nx2j9/jU4SvO2jYY2ygKQE6BeDjXQ==
X-Received: by 2002:a05:600c:1391:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-432b7506634mr29347145e9.16.1731083351673; 
 Fri, 08 Nov 2024 08:29:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b0530599sm78109135e9.1.2024.11.08.08.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 08:29:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 1/3] system/dma-helpers.c: Move trace events to
 system/trace-events
Date: Fri,  8 Nov 2024 16:29:07 +0000
Message-Id: <20241108162909.4080314-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108162909.4080314-1-peter.maydell@linaro.org>
References: <20241108162909.4080314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The dma-helpers.c file is in the system/ subdirectory, but it
defines its trace events in the root trace-events file. Move
them to the system/trace-events file where they more naturally
belong.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/dma-helpers.c | 2 +-
 system/trace-events  | 7 +++++++
 trace-events         | 7 -------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 74013308f52..cbcd89dfaaa 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "trace/trace-root.h"
+#include "trace.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpu-timers.h"
diff --git a/system/trace-events b/system/trace-events
index 2ed1d59b1fb..5bbc3fbffac 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -4,6 +4,13 @@
 # Since requests are raised via monitor, not many tracepoints are needed.
 balloon_event(void *opaque, unsigned long addr) "opaque %p addr %lu"
 
+# dma-helpers.c
+dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
+dma_aio_cancel(void *dbs) "dbs=%p"
+dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
+dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
+dma_map_wait(void *dbs) "dbs=%p"
+
 # ioport.c
 cpu_in(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
 cpu_out(unsigned int addr, char size, unsigned int val) "addr 0x%x(%c) value %u"
diff --git a/trace-events b/trace-events
index 9cb96f64c4a..3ec8a6c7202 100644
--- a/trace-events
+++ b/trace-events
@@ -30,13 +30,6 @@ breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
 
-# dma-helpers.c
-dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=%p bs=%p offset=%" PRId64 " to_dev=%d"
-dma_aio_cancel(void *dbs) "dbs=%p"
-dma_complete(void *dbs, int ret, void *cb) "dbs=%p ret=%d cb=%p"
-dma_blk_cb(void *dbs, int ret) "dbs=%p ret=%d"
-dma_map_wait(void *dbs) "dbs=%p"
-
 # job.c
 job_state_transition(void *job,  int ret, const char *legal, const char *s0, const char *s1) "job %p (ret: %d) attempting %s transition (%s-->%s)"
 job_apply_verb(void *job, const char *state, const char *verb, const char *legal) "job %p in state %s; applying verb %s (%s)"
-- 
2.34.1


