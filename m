Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ABAC35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD6I-0003Xl-2C; Mon, 17 Mar 2025 12:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuD61-0003UY-7Q
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:13:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuD5y-0003h8-Ni
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:13:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2649082f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228021; x=1742832821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9NJx4AwvlUnmR3t10jY6mrzdFJXWIigMof79SEafyw0=;
 b=WH7gs6MXPT7bIK5cwM+7jpCegc0vSzJCHw8KB9u5LsSVo3/nt7ZYyTzb14u8yX8btG
 RnkaNBsci7UoL4nM8tCSC9Y8nliQcYpTRmFdis5/RqsWbUScCNZB2gAEuQatPuCztTFH
 55Zwhvhj7E8y40TaakKtQDkgcqTqttL1d3nAjMAZ5A/U9zPQvew0VXZP2/Qyd4+j7ODn
 d6VV5keoU2jlEPOjAik1O063YcqWfUWLNYhBAASep5DcdqW+gedbZ3El8CmyCB/iAB8X
 tw/jsqFFlSu4OnFCaB+sZ9MjUqpa+un9Pq7EB86Z3n/HioqYk7dtQc7SzNyJGwukx+Pt
 r9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228021; x=1742832821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NJx4AwvlUnmR3t10jY6mrzdFJXWIigMof79SEafyw0=;
 b=VwGJHVRnhPvOFStGOFCV8Hjv1zOiCET3URuY3Cct/tQPvKBz04yMXJ39wSMxCfYXsT
 3rwTacxyqHwFOHyDWIAW5/ThQYwyVW4E3cn6SWD41VCacnppc809/gVCznik6A9e9jbU
 WCXc1kqigwmBLcwShyQZouw8vvKDcPGJ8jspTmf6avuMz46Zy0pU9cFQekTYmQMYhc5b
 G/Bmk6iU0Z0HGhHjr3adtwRFvaQVu00w8zNfBX1YseYs9+pBz3eS/Vhz4rqIUyypINKT
 l4UuWvmD+eId/rnMnTA32D/oB1bJFaQRDNxOGut8YNLStayYmjqL49WxBF/s3+T/55yQ
 cx5Q==
X-Gm-Message-State: AOJu0Yz76xEaKP2Zdnn+sjHGFB7TF/VCoBRnDWOV0d4GbZKBTwgbOFru
 rHMFmtoyqPJUyvrzFr6RMZO/Pi2dZBjKxzEThYaJiFY1OGupo9NNvTrU8e7lFvG/7KwAMiArPKn
 i
X-Gm-Gg: ASbGnctXKC9bo/sSYCos0iidhsWg+BWd6OM0GeUbiEYMgQyxV/3pYPOuPyD9ISR260S
 WyhVUbr/oyO00oPTyuDCEdz2K5Udqx6jUY+Bi/YO1o8dixfLXkWPtMLUH9ChQ7SziuG0Xj0454A
 YyKFYP6r6+HsjGuIphY8QtMKEPuKADzt9a5BouExTmuQTF05bOVBFkCn9jwnPlcogLcom15braS
 yUXshazqmjF4onNgWiB2S9Evms0uMWy2vH+vRKUlJYvsLXqsAXBVoJfgOXOZMsLw07fJCxu2tsC
 oqoxtxmrGmPpFYoRIl1DpAoQXqM1PTa6+XeWR1riw3HNvkZSB7FTYAa1TWl2F9Mm079dQ/hexOQ
 BUWmlsKU+ms2t0yCnkcY=
X-Google-Smtp-Source: AGHT+IGMARGdAzQpNp58cXY1dngIJmhTLCMEg3BLT1P9WDXA6C6eXAaFnr7iSz+G11LN9Sk7ep37rw==
X-Received: by 2002:a05:6000:1789:b0:391:29f:4f87 with SMTP id
 ffacd0b85a97d-3971fadef12mr13442481f8f.49.1742228020705; 
 Mon, 17 Mar 2025 09:13:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6a32sm15681861f8f.33.2025.03.17.09.13.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Mar 2025 09:13:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] exec: Restrict memory-internal.h to system/
Date: Mon, 17 Mar 2025 17:13:29 +0100
Message-ID: <20250317161329.40300-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250317161329.40300-1-philmd@linaro.org>
References: <20250317161329.40300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Only file units within the system/ directory need access to
"memory-internal.h". Restrict its scope by moving it there.

The comment from commit 9d70618c684 ("memory-internal.h:
Remove obsolete claim that header is obsolete") is now obsolete,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                | 2 +-
 {include/exec => system}/memory-internal.h | 6 ------
 system/memory.c                            | 3 ++-
 system/physmem.c                           | 3 ++-
 4 files changed, 5 insertions(+), 9 deletions(-)
 rename {include/exec => system}/memory-internal.h (88%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f470a1c9b7..b9f6c3cf15c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3115,7 +3115,7 @@ F: system/ioport.c
 F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
-F: include/exec/memory-internal.h
+F: system/memory-internal.h
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
diff --git a/include/exec/memory-internal.h b/system/memory-internal.h
similarity index 88%
rename from include/exec/memory-internal.h
rename to system/memory-internal.h
index c75178a3d6b..085e81a9fe4 100644
--- a/include/exec/memory-internal.h
+++ b/system/memory-internal.h
@@ -11,12 +11,6 @@
  *
  */
 
-/*
- * This header is for use by exec.c, memory.c and accel/tcg/cputlb.c ONLY,
- * for declarations which are shared between the memory subsystem's
- * internals and the TCG TLB code. Do not include it from elsewhere.
- */
-
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
diff --git a/system/memory.c b/system/memory.c
index eddd21a6cdb..f9b34cf4254 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -25,7 +25,6 @@
 #include "qom/object.h"
 #include "trace.h"
 
-#include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
@@ -35,6 +34,8 @@
 #include "migration/vmstate.h"
 #include "exec/address-spaces.h"
 
+#include "memory-internal.h"
+
 //#define DEBUG_UNASSIGNED
 
 static unsigned memory_region_transaction_depth;
diff --git a/system/physmem.c b/system/physmem.c
index e97de3ef65c..d4fbda9310d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -66,7 +66,6 @@
 #include "qemu/main-loop.h"
 #include "system/replay.h"
 
-#include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
 
 #include "qemu/pmem.h"
@@ -88,6 +87,8 @@
 #include <daxctl/libdaxctl.h>
 #endif
 
+#include "memory-internal.h"
+
 //#define DEBUG_SUBPAGE
 
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
-- 
2.47.1


