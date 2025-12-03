Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9D3D1BDD1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrxK-0007jF-Fn; Wed, 03 Dec 2025 13:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrxD-0007bH-4E
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrxB-00013e-2G
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764787911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOHEKYT4pyWLpkUTHzbPky15P6Jkd4KrLjQiaUa4++c=;
 b=IMwybbPx17hbPP+ujeXJEl0l6wgmTfhMDhJK3Klrv5XbRD3epJLMNwgGcyd+Mupvm5/6zL
 VPHLar2+0N5PRZQg9mPr+gI6DfWOx1vgvLd5e7rJboh0k4P5pKTaJIZmv9PbCTaCcQERmO
 SYFNvf3DIEhQWTGUkZ90mcHWMNRe04c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-92zQ_BsePkuXFVc5gWAlOQ-1; Wed, 03 Dec 2025 13:51:50 -0500
X-MC-Unique: 92zQ_BsePkuXFVc5gWAlOQ-1
X-Mimecast-MFC-AGG-ID: 92zQ_BsePkuXFVc5gWAlOQ_1764787909
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42e2e50cfaeso68933f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764787907; x=1765392707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOHEKYT4pyWLpkUTHzbPky15P6Jkd4KrLjQiaUa4++c=;
 b=JsllujVPoslRJK6cudTJAfHkPsd6iZe4/YWT0d7NRYKPyn7iwoKg+mm5/xYravaWYB
 UKvwSAhz1aF8GXExAhuCpVpdjHhbcu3mz8tJwL8xYSXGRUfGcQP/cq8jIy+578Rnqkj0
 Zrg6x//SO+EuJq6cAfZllCTHiv/MZLXwElXPLybshILdF3XgFJb7DfHRbmfzBUtN94YN
 z2beT4wnCTnwvbFp7NVx78sW+7GDDh4xMFhtrjF2XPue4sqMRXuqX0WIS3yn9V6qMz5P
 kYd4DCyamlyN3McmP/5zqSq9fs/L5p85jL/t53Q4fCKDFBqPaSv1QcmhkVTiJYgLW/VX
 TwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764787907; x=1765392707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rOHEKYT4pyWLpkUTHzbPky15P6Jkd4KrLjQiaUa4++c=;
 b=hPtuaVvx5Ti7Jm0zrtHV98uOOoadHkpRijatLZiQZHxKIBP0hnAD3+f7pOlpJfC828
 W+NgKY4fXpCkBKgVikgqm3jcgPAM0J7avc/yVu/Cz+DpqInYcw+EGadYcMj97qI7g+gc
 +HNjAcNzDAcYS7jJBOVI6hPQhVVY+Ai20WTDLAkb9nGHUpL/vU1J1/YRYOhf/6U+p/2D
 VIOOoeeylz4xrwH7T3q9znmow9Jr9WzPD2ytCXtONFCKRREDL4i0jeHz28fJBJbu4+3Y
 92vhx58jYKHosABlZ0+Vi3XOIpTdy9RpHlvEWGgcbSDztiCGhnA3BmbBg3WFlJi7egjv
 l/OA==
X-Gm-Message-State: AOJu0YxLavOsQ/Z7uAKCr29u+jFSv7RWKwYelN6I0+6qRsa2r1+Y6R1H
 2uM+NXPigQqbNRG61gZAelhiZgEd/r6XsD02BLATESe6RoyVajSKIZXUtXW40qf94MvyIDI0MG4
 ObuQu4eoMDVhU/dO2Tzh832BgbCsrmdsji7EQtHNU7QOhTghm5gtjVlMfveYWuAriuSwh6tZzYH
 gtkIR2L2TdcPygYLKRB5sEoZYbNBylS6gbiAwj+OET
X-Gm-Gg: ASbGncv35y3T4lPdTjek8WD8M5IrXOvaKHn2RHglEYPicryPt9PWQ+vn665QG6dIYPE
 ysXfEAlMpUyw/lNesnKh5u+txds3DVjJjifTv04UFh5+pPss7ScFLDk0z/lWT0CRVuuVH/aZdPW
 7ptBkZ/bsDhexAlpUAFQICspG6l6UCwySVYQzoyzM/Td6HelWxk8IYmBRX95VC6yEwpOED0sEuA
 nvErYgWNf1+zxXeSdjXaKEoipvkAeIveUFAUCiNFAnPQNqs3I5Swpfu1ccRMmanJhrPUEWwvLBn
 fOIi4CLsXwvUDqPyKsGve2EbooOyn+o1+ipR8CpJUdmEBeRKRPLfOgJnSiXNzA2rSDWYze57Bho
 m/YBFRMTIk32tboM9P7e5GA5xPrD/GgcV0K2k+13GBUEFQHmTc9Bk+fFWta3gQZMYDRTOZFf+0D
 EgU5RB/ZZCVVrLTr8=
X-Received: by 2002:a05:600c:4f54:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-4792f3954f4mr1223185e9.26.1764787907160; 
 Wed, 03 Dec 2025 10:51:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHL9g7PkzdZcODNM84vuAtPVz/gXvLoexhpoolPnNGezQDDuivly5miPVsLBT6jzPSwgEwnAA==
X-Received: by 2002:a05:600c:4f54:b0:479:1348:c614 with SMTP id
 5b1f17b1804b1-4792f3954f4mr1222805e9.26.1764787906619; 
 Wed, 03 Dec 2025 10:51:46 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a8ccbfesm63249675e9.13.2025.12.03.10.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 10:51:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.omc
Subject: [PATCH 5/5] block: rename block/aio-wait.h to qemu/aio-wait.h
Date: Wed,  3 Dec 2025 19:51:33 +0100
Message-ID: <20251203185133.2458207-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203185133.2458207-1-pbonzini@redhat.com>
References: <20251203185133.2458207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 24cf2946e77..4582c5f72a9 100644
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


