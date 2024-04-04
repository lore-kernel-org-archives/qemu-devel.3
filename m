Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA7ACD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNjS-0000BJ-1e; Thu, 04 Apr 2024 10:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1rsNjP-0000B4-6p
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:06:19 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@cloud.com>)
 id 1rsNj8-0001CU-66
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:06:18 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6990dd16041so3436276d6.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1712239555; x=1712844355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6wG5hFEWSE8pCJM3CKdCtIfOIpf3B2JFMf25ZTR+uII=;
 b=qCLADDIoPr2X8MO3C1KXU5HJhTySCRVIog2PHSfj3DAqZ6pf01ImIXsnxp2M5Q27Sm
 8kHGgLru7RKnPgWwfJR/JkKfrK4MQneNUdjhEYBh33xy2UYxHkEXYtqJGSYDhlaK5YQH
 5gnDe8JuwKWiCjt0g6zzzEjXNeZC5vJAcabU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712239555; x=1712844355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wG5hFEWSE8pCJM3CKdCtIfOIpf3B2JFMf25ZTR+uII=;
 b=eEfPEWC+nUu2tiyVwlX/Dsoqtx8MneaZOHqZ0moFVPBG+MUOI7F8LlQrElMZ7OgIw0
 wAk+T5u3dAvKimwUeKgL3+RsOyDUEmVzT1KvHcJICd8jcsvORzyiJS1eN+Wjz3x/ufT5
 y4LXc8DmYE6ynUPYsVdbv2OXdufcDEbdra30hVlSXEBzxEmcOUdsfIXliIYYvl/YVB7C
 Y/pyukPc5u/KeP+OASugx2/qzz1jEoJ1VzJ4h4P5KZ+deFRczBDGoQpfeqengTEtOjzW
 hMsR5qfzhbj+tKKfWHNzUQUIgmqB9UPI0AP7fBNz6WrzWo7yW+nEs3GoA1A7rgvDXpQh
 TLxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY8z6rme6a13nwRcWP9AO9765RbKP0bWW+yc+P6k4geH/5fj28XQwFwKpwlh0hOUKL084p7Sup2LIPrLDyc0wQaWdInnc=
X-Gm-Message-State: AOJu0YyHCrghjacZxGKDLDwCFgfx0V4fqWQpSONSHJBOwY5ZERFufU8N
 eDitnLcDphtXebwHV13YucxSWDSkTVUW/Kdkws2WcTC6G94VnN2wy2lqki+hcQ==
X-Google-Smtp-Source: AGHT+IGyY9sw3RGJVfOjgmqlVSv0/p+x+OV/m/Ct2LCHP8v9i+7ycUCSK6tJqaZi3Ko+zn40uXj7ww==
X-Received: by 2002:a05:6214:2465:b0:699:28ee:da99 with SMTP id
 im5-20020a056214246500b0069928eeda99mr2482294qvb.65.1712239554621; 
 Thu, 04 Apr 2024 07:05:54 -0700 (PDT)
Received: from rossla-lxenia.eng.citrite.net ([185.25.67.249])
 by smtp.gmail.com with ESMTPSA id
 fq8-20020a056214258800b0069903766e06sm2688494qvb.124.2024.04.04.07.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 07:05:54 -0700 (PDT)
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org,
 Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] xen-hvm: Avoid livelock while handling buffered ioreqs
Date: Thu,  4 Apr 2024 15:08:33 +0100
Message-ID: <20240404140833.1557953-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=ross.lagerwall@cloud.com; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A malicious or buggy guest may generated buffered ioreqs faster than
QEMU can process them in handle_buffered_iopage(). The result is a
livelock - QEMU continuously processes ioreqs on the main thread without
iterating through the main loop which prevents handling other events,
processing timers, etc. Without QEMU handling other events, it often
results in the guest becoming unsable and makes it difficult to stop the
source of buffered ioreqs.

To avoid this, if we process a full page of buffered ioreqs, stop and
reschedule an immediate timer to continue processing them. This lets
QEMU go back to the main loop and catch up.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/xen/xen-hvm-common.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 1627da739822..1116b3978938 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -463,11 +463,11 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
     }
 }
 
-static bool handle_buffered_iopage(XenIOState *state)
+static unsigned int handle_buffered_iopage(XenIOState *state)
 {
     buffered_iopage_t *buf_page = state->buffered_io_page;
     buf_ioreq_t *buf_req = NULL;
-    bool handled_ioreq = false;
+    unsigned int handled = 0;
     ioreq_t req;
     int qw;
 
@@ -480,7 +480,7 @@ static bool handle_buffered_iopage(XenIOState *state)
     req.count = 1;
     req.dir = IOREQ_WRITE;
 
-    for (;;) {
+    do {
         uint32_t rdptr = buf_page->read_pointer, wrptr;
 
         xen_rmb();
@@ -521,22 +521,30 @@ static bool handle_buffered_iopage(XenIOState *state)
         assert(!req.data_is_ptr);
 
         qatomic_add(&buf_page->read_pointer, qw + 1);
-        handled_ioreq = true;
-    }
+        handled += qw + 1;
+    } while (handled < IOREQ_BUFFER_SLOT_NUM);
 
-    return handled_ioreq;
+    return handled;
 }
 
 static void handle_buffered_io(void *opaque)
 {
+    unsigned int handled;
     XenIOState *state = opaque;
 
-    if (handle_buffered_iopage(state)) {
+    handled = handle_buffered_iopage(state);
+    if (handled >= IOREQ_BUFFER_SLOT_NUM) {
+        /* We handled a full page of ioreqs. Schedule a timer to continue
+         * processing while giving other stuff a chance to run.
+         */
         timer_mod(state->buffered_io_timer,
-                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
-    } else {
+                qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
+    } else if (handled == 0) {
         timer_del(state->buffered_io_timer);
         qemu_xen_evtchn_unmask(state->xce_handle, state->bufioreq_local_port);
+    } else {
+        timer_mod(state->buffered_io_timer,
+                BUFFER_IO_MAX_DELAY + qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
     }
 }
 
-- 
2.43.0


