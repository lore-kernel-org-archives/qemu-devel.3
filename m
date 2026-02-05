Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44984ECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VH-0006el-JX; Thu, 05 Feb 2026 14:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VF-0006cd-IS
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VD-00035X-NL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso11993045e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321538; x=1770926338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3w+4r91XUMpNZ+u0m8QgKhjEv84szY9BFvzEKdmRv4w=;
 b=Nr8bFFPz3FfH+ZRFcNov9KL66+302VeS/QAHmsdFyHAg6ljcbZlY4TnFapMMJ2bm2v
 EZFGlsgGC+3VNbe7k6zq7spoTtynlFjNAEul5pEtFEJ1m7GYhwRskme1t02HlxrbLdwB
 iyHoc1Y/iN43GHoq54+pEnFQ2KmBrEzQ0X0GnnEcSBjWHZu4isQOwpmlHmKKyYX7jjUh
 pAKVDGnMR5YviMGFRpUlS1235HGjFgjCwiTGb/SWbZFO4z1oUJ8Sf2l/K0M44Mz1ufph
 oB9Q2+RTAdOIzLy8g6ICwSqbjGXC2VvZHte9GH7XZUpufenmKFQ39OsEfHTOAM+mOpk6
 N3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321538; x=1770926338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3w+4r91XUMpNZ+u0m8QgKhjEv84szY9BFvzEKdmRv4w=;
 b=AOfE7Pj6ry2Mgjr8RjaJFeETz02/Hg2pg2/M51FdVPTUTBi9fsPrDS4895XR4COQ7k
 m7uuyBwqkFqKqDcMxchqyvGTMl2dvM5Dvo81Ok9c1rwfEcoISO0Lel10FDgzD6zgn6bR
 ehJLmtsv7cbmzbumVdUh8Jw2CGmt7++fgvC/JTgnuG+LF6hP+QNAJqv/g66Az5AXclNm
 wC+3e/aZOl36KeWUQ10WzB0qdCvwE4yfYmaRgiZVZcdQAFWUhGDhjCP//hVEzoGrNBxF
 pB5jX5U5hF5hbNZbrIsGlZToBS9EkEhTpUxq6OqCzxb0O/0ovUVE+ylmpUEq95awm7j2
 M7pg==
X-Gm-Message-State: AOJu0Yxrc1XiBumRe3FMm4xPuw5ZJc0jSi8yWDBv9opWxQsJvjC49uwi
 mtUWD7RoXFsmhrRnbMz/h4IAq7TOiu0YaphTAmHDWvzEGgHhdyB/+ZzlerK0myhlrqI=
X-Gm-Gg: AZuq6aJhtpInTFpyUYeGB711QkuIHukhYUq/n6PnkD9aY05C9SbTH/7aXlKEPHzE9FU
 MfHujHzdXzoJiDHRmVEezjRx5OaeF7X1rs78oAcECnmil4knl4R1cOfPZlMn5kUZCFMfFQrAUC1
 eH75SuOnHdSib5/Q3EuNZuTq3CgP99yH5YXDNXtVXxRVsNkORuYLTffQkSRqEHpzAbqfqWXcyZE
 taq+1vMOzbsYb7ZLawc1zrAl/aA9Y9QQC2gHmTzu+FjMpfiRm32CIn5whfRSyw0c3dXUbnL7bO5
 4vLlvv2DQUhu7T2Tm9IrGiHRO/0vgAisajo9uZ2YbFbTAmu4t2VBihdLdCv4qvQqSR2rN3KbDNV
 xHIEEPDjhfMkHjp7C6GUTN910szKzbLxn6dwPRUZ0usrXvv3lFJdw0k1tbjAcOBdWsC4zhbPbK5
 zRmejIX+6drufJukoLRWk=
X-Received: by 2002:a05:600c:5307:b0:480:4a4f:c36f with SMTP id
 5b1f17b1804b1-4832096671dmr757915e9.21.1770321537557; 
 Thu, 05 Feb 2026 11:58:57 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:57 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 10/29] hw/core: Implement Remote Port packet dispatch logic
Date: Thu,  5 Feb 2026 20:58:05 +0100
Message-ID: <20260205195824.2610192-11-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement the mechanism to transfer packets from the dedicated
protocol thread to the main QEMU execution loop for processing.

The patch adds the following features:
- signaling logic using internal pipe to wake up the main loop
- the rp_process handler, which retrieves packets from queue and
dispatches them to the target Remote Port device.

This enables QEMU device models to handle remote events.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port.c         | 148 +++++++++++++++++++++++++++++++++-
 include/hw/core/remote-port.h |   5 ++
 2 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 91b0682884..e44d9249c3 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -52,6 +52,8 @@
 #define REMOTE_PORT_CLASS(klass)    \
      OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
 
+static void rp_event_read(void *opaque);
+
 static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
 {
     qemu_hexdump(stdout, prefix, buf, len);
@@ -96,6 +98,12 @@ ssize_t rp_write(RemotePort *s, const void *buf, size_t count)
     return r;
 }
 
+static unsigned int rp_has_work(RemotePort *s)
+{
+    unsigned int work = s->rx_queue.wpos - s->rx_queue.rpos;
+    return work;
+}
+
 static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
 {
     s->peer.version = pkt->hello.version;
@@ -187,6 +195,135 @@ static Chardev *rp_autocreate_chardev(RemotePort *s, char *name)
     return chr;
 }
 
+void rp_process(RemotePort *s)
+{
+    while (true) {
+        struct rp_pkt *pkt;
+        unsigned int rpos;
+        bool actioned = false;
+        RemotePortDevice *dev;
+        RemotePortDeviceClass *rpdc;
+
+        qemu_mutex_lock(&s->rsp_mutex);
+        if (!rp_has_work(s)) {
+            qemu_mutex_unlock(&s->rsp_mutex);
+            break;
+        }
+        rpos = s->rx_queue.rpos;
+
+        pkt = s->rx_queue.pkt[rpos].pkt;
+        D(qemu_log("%s: io-thread rpos=%d wpos=%d cmd=%d dev=%d\n",
+                 s->prefix, s->rx_queue.rpos, s->rx_queue.wpos,
+                 pkt->hdr.cmd, pkt->hdr.dev));
+
+        /*
+         * To handle recursiveness, we need to advance the index
+         * index before processing the packet.
+         */
+        s->rx_queue.rpos++;
+        s->rx_queue.rpos %= ARRAY_SIZE(s->rx_queue.pkt);
+        qemu_mutex_unlock(&s->rsp_mutex);
+
+        dev = s->devs[pkt->hdr.dev];
+        if (dev) {
+            rpdc = REMOTE_PORT_DEVICE_GET_CLASS(dev);
+            if (rpdc->ops[pkt->hdr.cmd]) {
+                rpdc->ops[pkt->hdr.cmd](dev, pkt);
+                actioned = true;
+            }
+        }
+
+        switch (pkt->hdr.cmd) {
+        /* TBD */
+        default:
+            assert(actioned);
+        }
+
+        s->rx_queue.inuse[rpos] = false;
+        qemu_sem_post(&s->rx_queue.sem);
+    }
+}
+
+static void rp_event_read(void *opaque)
+{
+    RemotePort *s = REMOTE_PORT(opaque);
+    unsigned char buf[32];
+    ssize_t r;
+
+    /* We don't care about the data. Just read it out to clear the event.  */
+    do {
+#ifdef _WIN32
+        r = qemu_recv_wrap(s->event.pipe.read, buf, sizeof buf, 0);
+#else
+        r = read(s->event.pipe.read, buf, sizeof buf);
+#endif
+        if (r == 0) {
+            return;
+        }
+    } while (r == sizeof buf || (r < 0 && errno == EINTR));
+
+    rp_process(s);
+}
+
+static void rp_event_notify(RemotePort *s)
+{
+    unsigned char d = 0;
+    ssize_t r;
+
+#ifdef _WIN32
+    /* Mingw is sensitive about doing write's to socket descriptors.  */
+    r = qemu_send_wrap(s->event.pipe.write, &d, sizeof d, 0);
+#else
+    r = qemu_write_full(s->event.pipe.write, &d, sizeof d);
+#endif
+    if (r == 0) {
+        hw_error("%s: pipe closed\n", s->prefix);
+    }
+}
+
+/* Handover a pkt to CPU or IO-thread context.  */
+static void rp_pt_handover_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    bool full;
+
+    /*
+     * Take the rsp lock around the wpos update, otherwise
+     * rp_wait_resp will race with us.
+     */
+    qemu_mutex_lock(&s->rsp_mutex);
+    s->rx_queue.wpos++;
+    s->rx_queue.wpos %= ARRAY_SIZE(s->rx_queue.pkt);
+    /*
+     * Ensure rx_queue index update is visible to consumer
+     * before signaling event, to prevent lost wakeup
+     */
+    smp_mb();
+    rp_event_notify(s);
+    qemu_cond_signal(&s->progress_cond);
+    qemu_mutex_unlock(&s->rsp_mutex);
+
+    do {
+        full = s->rx_queue.inuse[s->rx_queue.wpos];
+        if (full) {
+            qemu_log("%s: FULL rx queue %d\n", __func__, s->rx_queue.wpos);
+        if (qemu_sem_timedwait(&s->rx_queue.sem, 2 * 1000) != 0) {
+#ifndef _WIN32
+                int sval;
+
+#ifndef CONFIG_SEM_TIMEDWAIT
+                sval = s->rx_queue.sem.count;
+#else
+                sem_getvalue(&s->rx_queue.sem.sem, &sval);
+#endif
+                qemu_log("semwait: %d rpos=%u wpos=%u\n", sval,
+                         s->rx_queue.rpos, s->rx_queue.wpos);
+#endif
+                qemu_log("Deadlock?\n");
+        }
+        }
+    } while (full);
+}
+
 static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
 {
     struct rp_pkt *pkt = dpkt->pkt;
@@ -208,7 +345,7 @@ static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
     case RP_CMD_interrupt:
     case RP_CMD_ats_req:
     case RP_CMD_ats_inv:
-        /* TBD */;
+        rp_pt_handover_pkt(s, dpkt);
         break;
     default:
         g_assert_not_reached();
@@ -312,6 +449,8 @@ static void rp_realize(DeviceState *dev, Error **errp)
     s->prefix = object_get_canonical_path(OBJECT(dev));
 
     qemu_mutex_init(&s->write_mutex);
+    qemu_mutex_init(&s->rsp_mutex);
+    qemu_cond_init(&s->progress_cond);
 
     if (!qemu_chr_fe_get_driver(&s->chr)) {
         char *name;
@@ -413,6 +552,7 @@ static void rp_realize(DeviceState *dev, Error **errp)
                         s->prefix);
             exit(EXIT_FAILURE);
         }
+        qemu_set_fd_handler(s->event.pipe.read, rp_event_read, NULL, s);
     }
 #else
     if (!g_unix_open_pipe(s->event.pipes, FD_CLOEXEC, NULL)) {
@@ -427,7 +567,10 @@ static void rp_realize(DeviceState *dev, Error **errp)
         exit(EXIT_FAILURE);
     }
 
+    qemu_set_fd_handler(s->event.pipe.read, rp_event_read, NULL, s);
 #endif
+
+    qemu_sem_init(&s->rx_queue.sem, ARRAY_SIZE(s->rx_queue.pkt) - 1);
 }
 
 static void rp_unrealize(DeviceState *dev)
@@ -436,6 +579,9 @@ static void rp_unrealize(DeviceState *dev)
 
     s->finalizing = true;
 
+    /* Unregister handler.  */
+    qemu_set_fd_handler(s->event.pipe.read, NULL, NULL, s);
+
     info_report("%s: Wait for remote-port to disconnect", s->prefix);
     qemu_chr_fe_disconnect(&s->chr);
     qemu_thread_join(&s->thread);
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index b88e523894..21dfbe89cd 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -74,6 +74,9 @@ struct RemotePort {
     char *chrdev_id;
     struct rp_peer_state peer;
 
+    QemuMutex rsp_mutex;
+    QemuCond progress_cond;
+
 #define RX_QUEUE_SIZE 1024
     struct {
         /* This array must be sized minimum 2 and always a power of 2.  */
@@ -100,6 +103,8 @@ struct RemotePort {
     RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
 };
 
+void rp_process(RemotePort *s);
+
 ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
 
 #endif
-- 
2.43.0


