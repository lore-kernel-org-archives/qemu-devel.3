Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA2E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQyR-0007Oi-J7; Sat, 27 Dec 2025 04:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQy1-0006oJ-5O
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxy-0007Yt-SE
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eS1GeSZ0xe9AFhAHjPjntAzyLnEM9NmXyPjZRoek4o8=;
 b=GwEPylT59l+LbF2G3NDw5uZ9+2eEEQNgLhCAjMpHSBBoOWiJgpdLN0NzfR2zqHbV1e3ZDN
 tOnVRqyxhFuIWJMAdjOjuM5f879qxrIUhMV3PZYzI1nneuxf39ETUQhow655cb87MZ8iqS
 bcP2hdU/R5vVpm/Qu7aTlc235R5X/Gw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-_qGNQqDzPsSPZtimfaB4hQ-1; Sat, 27 Dec 2025 04:52:01 -0500
X-MC-Unique: _qGNQqDzPsSPZtimfaB4hQ-1
X-Mimecast-MFC-AGG-ID: _qGNQqDzPsSPZtimfaB4hQ_1766829120
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4325b81081aso3890525f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829118; x=1767433918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eS1GeSZ0xe9AFhAHjPjntAzyLnEM9NmXyPjZRoek4o8=;
 b=ADjFiuA/6oIjwga3B86MTN0/ogeu3OsWNVXfXX6XY6rYs7ZfgphRgggrRxEZEBquiU
 0+QoWSUQbYlo9FvKHQe5uWAxzCmfvoAKQsWVA0Ayasm3nueaHbXhqqK4qGrjpXuBUbP0
 mE22XUC7HZAxuLhCggI5h+IoKWljVqetJaM95LynYpBxF9RjEWxtYEkQW8Dha1P6hJbq
 r/aqfDXkHUnONXImNJIjdvmupDyZp8ANC/4W1p3UUHP2G7JLUJpdngk+dMWTPadD4c0v
 gOAIeCpeH6ItgwkPGEP+1hQrlQp5ISYo7ZkuU0A9X4ri/DwSvdb4Yhxo3tPFjjbgyryg
 RMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829118; x=1767433918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eS1GeSZ0xe9AFhAHjPjntAzyLnEM9NmXyPjZRoek4o8=;
 b=g596A9k+PhVrp8m0M/pnh6h+IXvGlLxb4i90wSy3OTZsee3tlm5EFYiPcuhahxdFXi
 LyqGZviGnnNZTsFQKwfzOHsha4l4miJhH8VhD3w5bePdrQq4IqQA4a+IA1Vx8sBmPCgx
 dHa3FQdyZq7lGExDlEkYqhj8dUL99qxxucMbTdoqfHOx/NrckJU1XE2ltoQ7P+Z/DSJ6
 KUw8X01h/OTGP5aCb4ozUXpd12JJyJAFw+MBlHcc+TThj25Wyf2LMCBxMAkWe3o15ZTN
 JkTaSVgzSCf/kWVTKPAjdNlv7S0Zx/6cphc7iy9FlDtO/b/tvu8YMoTAwlBWyv+MG5Tj
 yJrg==
X-Gm-Message-State: AOJu0YzVZu6hTYUxR+Oaaq16isd4NLiHQzgHCRZ9AcpdZQzpsWn0NfJG
 T/2XXBEOU2tWDpdpZcz3dhGzATzE8aii9I/o8zIG75MbJtdQ5UTDeUsSKVLk+rABpmdp6RKvK/b
 fYou0TiVwcZT/iXiSYZXShZ74Iyztafz2ijcFptfBA04/M+3BvHuipkSCII9wJZ+ICFsH63j0CS
 GYLT/rq/sRdK1A8SHktx3m98SZqifJ8SBzjJ8uAbUe
X-Gm-Gg: AY/fxX54YXxbr8mVrpydmTf0gp0aHGAC1buX5W2ubnP4MoGfg/BEAdIFncQatjRDUga
 ghyiBhU3sHmVVzlSqklBpUdVSq7JLiaZOzoplg6+ErgPPlwwo4U6vG/jqyb5EJAexRjNGPYl42P
 dJ4OH+MNIdb+dzuaJ9IurI3d9R2/AyYkzp/5+9DULdpzt58I9tjlkmyE2XedPenvnSrcnM4V1z2
 OaCyZyBFHtf+09Wt3fe0ThZMsNUpXWec37iGSSqp6qv8NZrAZRjj16zZEEb3NAj5Bjc1jJvXTik
 pwIawQIwsfFXV+gpRGzY762Z5olaHUN+wXVm3R5k9mz1qk9oBCRcbY+vWK4TZjNcugRcu4au4vf
 xFQmNN+f3/5TQwglcV+DUryQhPBgzAAP9liTMHHAWOAfYyr0oNUuI0A/q7PgPAdjZfNFPfwtnq0
 3lNqElz5u1fjrFRGI=
X-Received: by 2002:a05:6000:420a:b0:431:864:d492 with SMTP id
 ffacd0b85a97d-4324e50600dmr28887764f8f.36.1766829118374; 
 Sat, 27 Dec 2025 01:51:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0xA6nGHJ/NHqEKKKIymO+eyyOIqalkg235ZTkV0WAtD2zOJHU/uJwmCWxAZslhSf40Lt1wg==
X-Received: by 2002:a05:6000:420a:b0:431:864:d492 with SMTP id
 ffacd0b85a97d-4324e50600dmr28887743f8f.36.1766829117942; 
 Sat, 27 Dec 2025 01:51:57 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa64cesm50754325f8f.35.2025.12.27.01.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 153/153] block: rename block/aio-wait.h to qemu/aio-wait.h
Date: Sat, 27 Dec 2025 10:47:58 +0100
Message-ID: <20251227094759.35658-79-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AIO_WAIT_WHILE is used even outside the block layer; move the header file
out of block/ just like the implementation is in util/.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                        | 2 +-
 include/block/block-io.h           | 2 +-
 include/{block => qemu}/aio-wait.h | 0
 block/io.c                         | 2 +-
 blockjob.c                         | 2 +-
 io/channel.c                       | 2 +-
 job.c                              | 2 +-
 net/colo-compare.c                 | 2 +-
 net/filter-mirror.c                | 2 +-
 util/aio-wait.c                    | 2 +-
 util/vhost-user-server.c           | 2 +-
 hw/display/apple-gfx-mmio.m        | 2 +-
 hw/display/apple-gfx.m             | 2 +-
 13 files changed, 12 insertions(+), 12 deletions(-)
 rename include/{block => qemu}/aio-wait.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index efceed9fe52..2f34b921784 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3072,7 +3072,7 @@ F: util/defer-call.c
 F: util/fdmon-*.c
 F: block/io.c
 F: include/qemu/aio.h
-F: include/block/aio-wait.h
+F: include/qemu/aio-wait.h
 F: include/qemu/defer-call.h
 F: scripts/qemugdb/aio.py
 F: tests/unit/test-fdmon-epoll.c
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 7925e2241e6..d34d846bb2a 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -25,7 +25,7 @@
 #define BLOCK_IO_H
 
 #include "qemu/aiocb.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "block/block-common.h"
 #include "block/graph-lock.h"
 #include "qemu/coroutine.h"
diff --git a/include/block/aio-wait.h b/include/qemu/aio-wait.h
similarity index 100%
rename from include/block/aio-wait.h
rename to include/qemu/aio-wait.h
diff --git a/block/io.c b/block/io.c
index c4a43013210..cace297f226 100644
--- a/block/io.c
+++ b/block/io.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "trace.h"
 #include "system/block-backend.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "block/blockjob.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
diff --git a/blockjob.c b/blockjob.c
index db7c3a69a0c..f3b11cc7a19 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "block/block.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
diff --git a/io/channel.c b/io/channel.c
index b7966abc4f0..cc02d997a4d 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "io/channel.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
diff --git a/job.c b/job.c
index 0653bc2ba69..e7479084726 100644
--- a/job.c
+++ b/job.c
@@ -28,7 +28,7 @@
 #include "qemu/job.h"
 #include "qemu/id.h"
 #include "qemu/main-loop.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "trace/trace-root.h"
 #include "qapi/qapi-events-job.h"
 
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 95018b47049..c356419d6a8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -30,7 +30,7 @@
 #include "migration/colo.h"
 #include "util.h"
 
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "qemu/coroutine.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 8e01e98f405..d2bfde42e85 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -20,7 +20,7 @@
 #include "chardev/char-fe.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 
 #define TYPE_FILTER_MIRROR "filter-mirror"
 typedef struct MirrorState MirrorState;
diff --git a/util/aio-wait.c b/util/aio-wait.c
index b5336cf5fd2..53913c4bd1b 100644
--- a/util/aio-wait.c
+++ b/util/aio-wait.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 
 AioWait global_aio_wait;
 
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 1dbe409f829..1536d97baf8 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -11,7 +11,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/vhost-user-server.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 
 /*
  * Theory of operation:
diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 983fc1724a0..58beaadd1f1 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/irq.h"
 #include "apple-gfx.h"
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 174d56ae05b..e0a765fcb1f 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
-#include "block/aio-wait.h"
+#include "qemu/aio-wait.h"
 #include "system/address-spaces.h"
 #include "system/dma.h"
 #include "migration/blocker.h"
-- 
2.52.0


