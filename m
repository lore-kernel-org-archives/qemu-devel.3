Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AF5CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHkE-00058B-TC; Wed, 24 Jun 2026 03:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjp-00055a-73
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjn-00034q-KC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84236f9b638so382112b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284970; x=1782889770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lo3KDUXnmI1WFH1r1IpwCFbofsm72XzCt2U1uX/RYQ=;
 b=HIP2YK3ul+1vsMnNM23am3VdxRLBh+NBILPgoMSBncZQe4LOQPe9Yfp/mDWmilGISc
 LhJnUmtV9s47nSQsOY79PzazKE9jo7RBIuWn86N6qz6sdE5VuWPuzLDAmMJlUTIRBDbj
 d4PBmwHx5gCvCPE6pNho6KQykOMjAzvBGZywgOp1DNBbgMmQBRrt+Q3SCpO40uI+E56u
 xW1IucS/UEmjRv90Mz88lRrvBkRD8cTCYWp9rYJVGcbwZJKQIFCwR1HIJGE499p+a0HR
 M2iJHj47roQ5lZOuolTzldDCf8jZ0fF4L06R6mdZJonvwXYBaS/8pSIOoT74jWnE44Ql
 Bldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284970; x=1782889770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8lo3KDUXnmI1WFH1r1IpwCFbofsm72XzCt2U1uX/RYQ=;
 b=lYTHt3Xwp9QitTPXIbfXzPq2lTWHoKiyz/cMkXcJcw3mPPBx10Ki2MCsr/1OREHjXK
 ka4n91jD00apZMxcodo8eS6SlMMM/p//Gf2cI8CUQFGAt5TjCCNI8M29kmyx6H0m0+bd
 xz1F7fLdJ08CKGcpdtxsl4Mr4HahfEgQupIsbR+2tyJrc/etZYv3jk4K11ObqhL8yPBp
 7KIKE8rmhHCGX9PSh0zVpwQGnVLNgWn2okK4szBUlkmCY/4aTN7/mDxcktqwVdeH3xJM
 g8OC7q7YOrZzo7UiZA+/Aky+F4rbPZ72vkx2AyP4RHDnjOM5LIPkYqRl+voXXiRHx1Yg
 TtCA==
X-Gm-Message-State: AOJu0Yy+5fT9odIwstuDxQD2dXHVfliEL3UaY/jsdbP81e1eBl+l8s3q
 Hvv+GeUY0NHMr1xzylm2MeqaJv15lexYbj2lV/AseTDdbEMX1Qk+a5wU+oLFESz84cM=
X-Gm-Gg: AfdE7cmGsnkkJj4ot0G4siYLo/fTEYbwDCSBn5KmJbRcSPFc8D10Tbxo96mCPrtLGob
 NTLzp+PmExkj11F1xBe4kMhrgPYvzVCmVfjHUQVo1Oo/zvNEDX1r4FJoPHcOts/L9ibfkm5iXjG
 p+KTOXUav9s0FF7uYpPOujSZ4QAoAE9orgWXR9jFzR/HFV8NrUl83EKHoHH+35DeEcqAP8vaQqI
 hD1m8VYqZ/XKTwgB6eDoaZ5zDGYJXR4/EAnWEK8usZTUHQ7m/i0J1v5vV6Y6ySngKAHeTJPCniM
 7xsbdZQFE3zvigp9H2KppIQ+ZcVN0gfpUmE9KfH22rC7/kJ72YbIMBa3Xsi3bVK/k/8D+SLTprN
 4yFOiesvkuzBXDMUyOsPZObOYln6JBOYhjmxD+FSnEnqZFWD1i745Rb+YbbsQ9Lw2/7Oy8V/f4s
 kBI+Mn8lFWuNPTNP9Nsh+2GP1Hm/VKagu97JZ/LWPSTfM03YHlDJgJ
X-Received: by 2002:a05:6a00:cc2:b0:842:83d1:ee6d with SMTP id
 d2e1a72fcca58-845a28d45b0mr3139630b3a.45.1782284970226; 
 Wed, 24 Jun 2026 00:09:30 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:29 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 07/17] monitor: support iothread ref/unref for anonymous
 monitors
Date: Wed, 24 Jun 2026 15:08:41 +0800
Message-ID: <20260624070851.13342-8-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Implement iothread registration and unregistration within monitor data lifecycle
helpers using IOThreadHolder.

When an explicit monitor ID is missing, fall back to utilizing the chardev
label as a safe identifier for iothread_ref/put operations. This enables
accurate tracking for anonymous monitors while keeping 'mon->id' as NULL.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 65749f931e..c3eec8c069 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -612,8 +612,18 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 {
     mon->id = id ? g_strdup(id) : NULL;
 
-    if (use_io_thread && !mon_iothread) {
-        monitor_iothread_init();
+    if (use_io_thread) {
+        if (!mon_iothread) {
+            monitor_iothread_init();
+        }
+
+        /* Setup the chr->label as the backup ID for iothread_ref/unref */
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
+            .u.monitor_name.monitor_name = id ? (char *)mon->id :
+                                                (char *)mon->chr.chr->label,
+        };
+        iothread_ref_and_get_aio_context(mon_iothread, &holder);
     }
     qemu_mutex_init(&mon->mon_lock);
     mon->is_qmp = is_qmp;
@@ -624,6 +634,16 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
 
 void monitor_data_destroy(Monitor *mon)
 {
+    if (mon->use_io_thread && mon_iothread) {
+        IOThreadHolder holder = {
+            .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
+            .u.monitor_name.monitor_name = mon->id ? (char *)mon->id :
+                                           (char *)mon->chr.chr->label,
+        };
+
+        iothread_put_aio_context(mon_iothread, &holder);
+    }
+
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
-- 
2.49.0


