Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B995C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krT-0004KD-RK; Wed, 23 Apr 2025 20:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqB-0000y7-Ne
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:25 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpu-0004g6-Ke
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso534844b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455985; x=1746060785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1b+/2Cx7hhPD9NBA8Adtti5AvmLRjcSTlsgUHFgyOs4=;
 b=Ix2gjNOdWkuh01aPKTvOS2Z0zcMkdSzXc+lfqkfdbvdKHQXV8FmGMAe1E1oILY0VnI
 z8WhJYy/lWgpVups8VEnI9FMGaZzi4fH0AZDZOIJwUqma/7RY5YMht4MGj7XQlryDu8b
 bgtCSHb8fL+8AXEYSjJelOLgQmS3B5uzruQNSa00mkULMX8zIIPYEw1CVUPYdHRLCXcA
 7fHQhcXGwxwpX+ots3kmKluKMvD2ecz8qZAQEJUr5ZTdHoR2TE9y2rEoNfrC/HsqNSEM
 mAv9f+Kph6ySnllqy/+uXUHgDWrl/HNx1VxHbomatJwaN+eMycxfL6pSTKaIyPe/RS0y
 +6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455985; x=1746060785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1b+/2Cx7hhPD9NBA8Adtti5AvmLRjcSTlsgUHFgyOs4=;
 b=Wx8fZQ2hs06caG7uY7WIYen9/X/3zObEkQRpQnAI480fgiFqyZ47PiO3BHqlM1N2Rk
 n74v6QIeLbs5W9Xi6EhQoU7JZr/AbrzldEZtNgTJZ8SuiOqo1B6tejUUP7nitO6+6TBf
 nPbJ3dh9LYgntg1VS1mz+uiHe6sE614qXtGkbN9Iq4hSkJnGhBzhmQuLfOXA3DjCpp+x
 7cziDFuYK4lVPkGJAqrbwhNj6gQuPpqREAf2KHOB8kgZUOvA6yH//84xkjP7wAULyQGL
 vU8CYfZji9GiPVjBfjZpbDS73vLjf7T1/hyyyKaqjpC80vDkRVukGvEdUDKsvajkG0u3
 jf5g==
X-Gm-Message-State: AOJu0YzQ1lf86EzTHbUBun8yvCbMd2yAjYtOoByWTKPl1Nd9OFbnzOcm
 ul3veXHmhS/NNyQECUXZLKIDfwfpI/sptpGE68XETwZAL2cf3PRi18w7hiJtRvnP5MrOCDd8k5O
 G
X-Gm-Gg: ASbGncu7gRrGyWHZky8IbwpGiLHUVP3qsdWyoUpgfFit6RjLXZy7Dt2lmfan9oT9CvK
 TRdmk3mf0KbeuHbyr7Ql7EplrwJQmCbIg6OWWIcQg10oPIFbt3PlKY6d8YNXlMXl5aeNkGJy5jj
 gO5/Zeh+1JwgbXOihBCDjyja2kz+55ddlIlLpICRNZLkIJGu7FeJ9FhstDlhLVFw4NEfhjhHmoq
 TbVa2uWJNvn+OLHh539bxXDwieg94wayRltGw894/ZQ0M2KRcQ0360/T7zSpGBcH7lyVPs8k80r
 hXO3XB3P4AS9dlod74HaiaD8BUvn6OIK3skBD8ltysAiwgKRHQKlGFObweBqHgkHmpaNOFw2RXY
 =
X-Google-Smtp-Source: AGHT+IGcKPYjDstA5l0z91VdGhy46j3mAcy3uyFLwAzI/uaSzZ+sWxWrUlnbg7C+KenUADd5LrfZ+Q==
X-Received: by 2002:a05:6a20:9d8e:b0:1f5:58b9:6d9b with SMTP id
 adf61e73a8af0-20444f003bbmr835763637.12.1745455985162; 
 Wed, 23 Apr 2025 17:53:05 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 040/148] exec: Restrict memory-internal.h to system/
Date: Wed, 23 Apr 2025 17:47:45 -0700
Message-ID: <20250424004934.598783-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Only file units within the system/ directory need access to
"memory-internal.h". Restrict its scope by moving it there.

The comment from commit 9d70618c684 ("memory-internal.h:
Remove obsolete claim that header is obsolete") is now obsolete,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317161329.40300-3-philmd@linaro.org>
---
 {include/exec => system}/memory-internal.h | 6 ------
 system/memory.c                            | 4 ++--
 system/physmem.c                           | 3 ++-
 MAINTAINERS                                | 2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)
 rename {include/exec => system}/memory-internal.h (88%)

diff --git a/include/exec/memory-internal.h b/system/memory-internal.h
similarity index 88%
rename from include/exec/memory-internal.h
rename to system/memory-internal.h
index c75178a3d6..085e81a9fe 100644
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
index 6a5d853071..7e2f16f4e9 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -24,8 +24,6 @@
 #include "qemu/qemu-print.h"
 #include "qom/object.h"
 #include "trace.h"
-
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
@@ -35,6 +33,8 @@
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
 
+#include "memory-internal.h"
+
 //#define DEBUG_UNASSIGNED
 
 static unsigned memory_region_transaction_depth;
diff --git a/system/physmem.c b/system/physmem.c
index 307d0764b6..16cf557d1a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -66,7 +66,6 @@
 #include "qemu/main-loop.h"
 #include "system/replay.h"
 
-#include "exec/memory-internal.h"
 #include "system/ram_addr.h"
 
 #include "qemu/pmem.h"
@@ -88,6 +87,8 @@
 #include <daxctl/libdaxctl.h>
 #endif
 
+#include "memory-internal.h"
+
 //#define DEBUG_SUBPAGE
 
 /* ram_list is read under rcu_read_lock()/rcu_read_unlock().  Writes
diff --git a/MAINTAINERS b/MAINTAINERS
index ba885010c5..661a47db5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3129,7 +3129,7 @@ F: system/ioport.c
 F: system/memory.c
 F: system/memory_mapping.c
 F: system/physmem.c
-F: include/exec/memory-internal.h
+F: system/memory-internal.h
 F: scripts/coccinelle/memory-region-housekeeping.cocci
 
 Memory devices
-- 
2.43.0


