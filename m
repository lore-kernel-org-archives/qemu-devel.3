Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DF1C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VbO-0007qg-AM; Tue, 15 Sep 2026 12:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbJ-0007mI-Sz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:41 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbH-0003Ql-1X
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:41 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254fa663bfso656131566b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488088; x=1790092888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zoG32e47nzyT1+1P/FMtjOhNvC0sbwGB9f+Z9JyESwI=;
 b=KktQxsRp6BXGcR84NAMcy1yYmk0yUcaXbYzGbru/aZnFl2OM3PFiklYEBpRceVllT5
 DhdHzmu29+RAHENKQh7DS0WOz9qVCRxxQnr5EFikqfuwKfBIuSbULwwVSJznJJ3wE5jT
 fDFwCYLD09pMH/+9K9luDbaM3iwNRBDfVwFt+veIL1PPZUVVkY3plAZlld9xqBnJGw7t
 UrnN/rEh6Ylh5ov6CSYBZ8qZjvDtoR/cYNK57uE5AKQrVLg6O3fRABjf3ISL2jDeIhRW
 IFCZkhlF/Es1CQ+RPw9SL1Wu0/uAAaR4dhr45bQh2Lc0zN0ySR57O6lHGtt/qqTO+b8z
 tdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488088; x=1790092888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zoG32e47nzyT1+1P/FMtjOhNvC0sbwGB9f+Z9JyESwI=;
 b=XRSCx23VZPo0vOnA1mWB5YjIm6Yp9HN9KC3PrRd1s7mXvOgIRX1+EHUenIpBALpigV
 xSgBbOfa09A12u9qpHH41168VHHCgBtUZTUOjHa8QBK9pJlRIf7y0rCn2l5Gx/LG6yaF
 ejPqGpkldQf+hIbCF9b/Ai3lvvnhUxo+vsColwPIo7PRlz/UcpUVxsJN5oQGK9pTzXKW
 V9WZLhunebmXAgpiMzyrDNfMDYNdG/V2V05Zbpgw7+BHAPxvmZbtbcTfBCeUipj2P4Ry
 2HZZR/tjPHM8poUQTJUVvgiV+d8nTCtBC4b8TLCqpLlblzoqT1rvl4ZsltqBNaqKeOHI
 /+1Q==
X-Gm-Message-State: AFuF++kr+qVrdVmpiK/25GOTt4C/+zm726n844M8WnxtGQJ2zvz03MOd
 rB6ugzOFT0SpuIocCQ3TJY6B0XNEJ7AAT6Rt2EClm+dWpRs3z1e78gAAUzLTfA==
X-Gm-Gg: AYBFou1psDaVkk1tLU5zYSFZUxnar7CJMQ1Wc+yeBRXzNRxwFsF1g/fQy3YW4uqtLVj
 u9sxBjSWZUUdU4gBZ4HnwrLjK0OhRSkULOsZKSRulzced0LeIe/bmGck5W5k0pTBgIN7Od1T8a/
 ScrfrQRU0RKxM5b8O4can0e5Ix9rLV5cg2k2+uCY6i2gPXb8UKNyrKQWbIMfXEIHmxZCv67SKR/
 Znj60LHo8ZsYMX10a3n1oZtCIZAiy4XNVoCKqKG99hGvVfLsbzS1f2Swet+wgCAfm1wWtXy70aL
 Xk4woh+28q9pIcxMKAW2OxxM6Ir7EueLKK2LwdpwC6kJEXNvUTTpL9Nhl6EFoT0BbNJlNwEv9kB
 k2qudrPiq7hLjGlwfqTCB86YkUrdOmV24te4R6GwPB9/+CN5uo1pIZbnR7TfNv1iXFAk5UUfdUC
 JITgfjULC/Of4w+7xj2UOq1jxCoqgFjvviwWxCV6r8jDz1DNuL54pcwW09McHhhgVjJHnRuUZMp
 q4Td2EhhsK3OmkO/vWM6b/EML34Vf9SmJf3qTcCdKmqsA==
X-Received: by 2002:a17:907:9715:b0:c29:4357:2309 with SMTP id
 a640c23a62f3a-c29b8734d09mr968872466b.24.1789488087437; 
 Tue, 15 Sep 2026 09:01:27 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:26 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 09/20] hw/core: Implement Remote Port time synchronization
Date: Tue, 15 Sep 2026 18:00:33 +0200
Message-ID: <20260915160044.345788-10-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Add logic to synchronize QEMU's virtual time with the remote peer.

The patch uses timers to periodically send sync requests to the peer
and handle incoming sync requests to defer the response if the peer
is ahead of QEMU's current time.

This also adds the 'sync' and 'sync-quantum' QOM properties to
configure this behavior.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port.c         | 175 +++++++++++++++++++++++++++++++++-
 include/hw/core/remote-port.h |  15 +++
 2 files changed, 188 insertions(+), 2 deletions(-)

diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 83515fc89c..4425ba1b08 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -14,6 +14,7 @@
 #include "chardev/char.h"
 #include "system/cpus.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/reset.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/hw-error.h"
@@ -35,6 +36,9 @@
 
 static void rp_event_read_and_process(RemotePort *s);
 
+static void sync_timer_hit(void *opaque);
+static void syncresp_timer_hit(void *opaque);
+
 void rp_rsp_mutex_lock(RemotePort *s)
 {
     qemu_mutex_lock(&s->rsp_mutex);
@@ -45,9 +49,42 @@ void rp_rsp_mutex_unlock(RemotePort *s)
     qemu_mutex_unlock(&s->rsp_mutex);
 }
 
+int64_t rp_normalized_vmclk(RemotePort *s)
+{
+    int64_t clk;
+
+    clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    clk -= s->peer.clk_base;
+    return clk;
+}
+
+static void rp_restart_sync_timer_bare(RemotePort *s)
+{
+    if (!s->do_sync) {
+        return;
+    }
+
+    if (s->sync.quantum) {
+        ptimer_stop(s->sync.ptimer);
+        ptimer_set_limit(s->sync.ptimer, s->sync.quantum, 1);
+        ptimer_run(s->sync.ptimer, 1);
+    }
+}
+
+void rp_restart_sync_timer(RemotePort *s)
+{
+    if (s->doing_sync) {
+        return;
+    }
+    ptimer_transaction_begin(s->sync.ptimer);
+    rp_restart_sync_timer_bare(s);
+    ptimer_transaction_commit(s->sync.ptimer);
+}
+
 static void rp_fatal_error(RemotePort *s, const char *reason)
 {
-    error_report("%s: %s", s->prefix, reason);
+    int64_t clk = rp_normalized_vmclk(s);
+    error_report("%s: %s clk=%" PRIu64 " ns", s->prefix, reason, clk);
     exit(EXIT_FAILURE);
 }
 
@@ -181,6 +218,35 @@ static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
     }
 }
 
+static void rp_cmd_sync(RemotePort *s, struct rp_pkt *pkt)
+{
+    size_t enclen;
+    int64_t clk;
+    int64_t diff;
+
+    assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    clk = rp_normalized_vmclk(s);
+    diff = pkt->sync.timestamp - clk;
+
+    enclen = rp_encode_sync_resp(pkt->hdr.id, pkt->hdr.dev, &s->sync.rsp.sync,
+                                 pkt->sync.timestamp);
+    assert(enclen == sizeof s->sync.rsp.sync);
+
+    /* We have temporarily disabled blocking syncs into QEMU.  */
+    if (diff <= 0LL || true) {
+        /* We are already a head of time. Respond and issue a sync.  */
+        rp_write(s, (void *) &s->sync.rsp, enclen);
+        return;
+    }
+
+    ptimer_transaction_begin(s->sync.ptimer_resp);
+    ptimer_set_limit(s->sync.ptimer_resp, diff, 1);
+    ptimer_run(s->sync.ptimer_resp, 1);
+    s->sync.resp_timer_enabled = true;
+    ptimer_transaction_commit(s->sync.ptimer_resp);
+}
+
 static void rp_say_hello(RemotePort *s)
 {
     struct rp_pkt_hello pkt;
@@ -202,6 +268,52 @@ static void rp_say_hello(RemotePort *s)
     }
 }
 
+static void rp_say_sync(RemotePort *s, int64_t clk)
+{
+    struct rp_pkt_sync pkt;
+    size_t len;
+
+    len = rp_encode_sync(s->current_id++, 0, &pkt, clk);
+    rp_write(s, (void *) &pkt, len);
+}
+
+static void syncresp_timer_hit(void *opaque)
+{
+    RemotePort *s = REMOTE_PORT(opaque);
+
+    s->sync.resp_timer_enabled = false;
+    rp_write(s, (void *) &s->sync.rsp, sizeof s->sync.rsp.sync);
+    memset(&s->sync.rsp, 0, sizeof s->sync.rsp);
+}
+
+static void sync_timer_hit(void *opaque)
+{
+    RemotePort *s = REMOTE_PORT(opaque);
+    int64_t clk;
+    RemotePortDynPkt rsp;
+
+    clk = rp_normalized_vmclk(s);
+    if (s->sync.resp_timer_enabled) {
+        s->sync.need_sync = true;
+        rp_restart_sync_timer_bare(s);
+        return;
+    }
+
+    /* Sync.  */
+    s->doing_sync = true;
+    s->sync.need_sync = false;
+    qemu_mutex_lock(&s->rsp_mutex);
+    /* Send the sync.  */
+    rp_say_sync(s, clk);
+
+    rsp = rp_wait_resp(s);
+    rp_dpkt_invalidate(&rsp);
+    qemu_mutex_unlock(&s->rsp_mutex);
+    s->doing_sync = false;
+
+    rp_restart_sync_timer_bare(s);
+}
+
 void rp_process(RemotePort *s)
 {
     while (true) {
@@ -240,7 +352,9 @@ void rp_process(RemotePort *s)
         }
 
         switch (pkt->hdr.cmd) {
-        /* TBD */
+        case RP_CMD_sync:
+            rp_cmd_sync(s, pkt);
+            break;
         default:
             assert(actioned);
         }
@@ -300,6 +414,33 @@ static void rp_pt_handover_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
     } while (full);
 }
 
+static bool rp_pt_cmd_sync(RemotePort *s, struct rp_pkt *pkt)
+{
+    size_t enclen;
+    int64_t clk;
+    int64_t diff = 0;
+    struct rp_pkt rsp;
+
+    assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
+
+    if (use_icount) {
+        clk = rp_normalized_vmclk(s);
+        diff = pkt->sync.timestamp - clk;
+    }
+    enclen = rp_encode_sync_resp(pkt->hdr.id, pkt->hdr.dev, &rsp.sync,
+                                 pkt->sync.timestamp);
+    assert(enclen == sizeof rsp.sync);
+
+    if (!use_icount || diff < s->sync.quantum) {
+        /* We are still OK.  */
+        rp_write(s, (void *) &rsp, enclen);
+        return true;
+    }
+
+    /* We need IO or CPU thread sync.  */
+    return false;
+}
+
 static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
 {
     struct rp_pkt *pkt = dpkt->pkt;
@@ -352,6 +493,11 @@ static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
     case RP_CMD_hello:
         rp_cmd_hello(s, pkt);
         break;
+    case RP_CMD_sync:
+        if (rp_pt_cmd_sync(s, pkt)) {
+            return true;
+        }
+        /* Fall-through.  */
     case RP_CMD_read:
     case RP_CMD_write:
     case RP_CMD_interrupt:
@@ -446,6 +592,7 @@ static void rp_reset(DeviceState *dev)
     qemu_thread_create(&s->thread, "remote-port", rp_protocol_thread, s,
                        QEMU_THREAD_JOINABLE);
 
+    rp_restart_sync_timer(s);
     s->reset_done = true;
 }
 
@@ -454,6 +601,8 @@ static void rp_realize(DeviceState *dev, Error **errp)
     RemotePort *s = REMOTE_PORT(dev);
     Chardev *chr = NULL;
 
+    s->peer.clk_base = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
     qemu_mutex_init(&s->write_mutex);
     qemu_mutex_init(&s->rsp_mutex);
     qemu_cond_init(&s->progress_cond);
@@ -485,6 +634,25 @@ static void rp_realize(DeviceState *dev, Error **errp)
                            rp_event_read_cb,
                            NULL, NULL);
 
+    /*
+     * Pick up the quantum from the local property setup.
+     * After config negotiation with the peer, sync.quantum value might
+     * change.
+     */
+    s->sync.quantum = s->peer.local_cfg.quantum;
+
+    s->sync.ptimer = ptimer_init(sync_timer_hit, s, PTIMER_POLICY_LEGACY);
+    s->sync.ptimer_resp = ptimer_init(syncresp_timer_hit, s,
+                                      PTIMER_POLICY_LEGACY);
+
+    /* The Sync-quantum is expressed in nano-seconds.  */
+    ptimer_transaction_begin(s->sync.ptimer);
+    ptimer_set_freq(s->sync.ptimer, 1000 * 1000 * 1000);
+    ptimer_transaction_commit(s->sync.ptimer);
+
+    ptimer_transaction_begin(s->sync.ptimer_resp);
+    ptimer_set_freq(s->sync.ptimer_resp, 1000 * 1000 * 1000);
+    ptimer_transaction_commit(s->sync.ptimer_resp);
 
     qemu_sem_init(&s->rx_queue.sem, ARRAY_SIZE(s->rx_queue.pkt) - 1);
 }
@@ -519,6 +687,9 @@ static const VMStateDescription vmstate_rp = {
 
 static Property rp_properties[] = {
     DEFINE_PROP_STRING("chrdev-id", RemotePort, chrdev_id),
+    DEFINE_PROP_BOOL("sync", RemotePort, do_sync, false),
+    DEFINE_PROP_UINT64("sync-quantum", RemotePort, peer.local_cfg.quantum,
+                       1000000),
 };
 
 static void rp_prop_allow_set_link(const Object *obj, const char *name,
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index 2cb070158f..e16661af03 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -17,6 +17,7 @@
 #include "chardev/char-fe.h"
 #include "qobject/qdict.h"
 #include "qemu/event_notifier.h"
+#include "hw/core/ptimer.h"
 
 #define TYPE_REMOTE_PORT_DEVICE "remote-port-device"
 
@@ -69,6 +70,8 @@ struct RemotePort {
     EventNotifier event_notifier;
     Chardev *chrdev;
     CharFrontend chr;
+    bool do_sync;
+    bool doing_sync;
     bool finalizing;
     /* To serialize writes to fd.  */
     QemuMutex write_mutex;
@@ -76,6 +79,15 @@ struct RemotePort {
     char *chrdev_id;
     struct rp_peer_state peer;
 
+    struct {
+        ptimer_state *ptimer;
+        ptimer_state *ptimer_resp;
+        bool resp_timer_enabled;
+        bool need_sync;
+        struct rp_pkt rsp;
+        uint64_t quantum;
+    } sync;
+
     QemuMutex rsp_mutex;
     QemuCond progress_cond;
 
@@ -126,6 +138,9 @@ RemotePortDynPkt rp_wait_resp(RemotePort *s);
 RemotePortRespSlot *rp_dev_wait_resp(RemotePort *s, uint32_t dev, uint32_t id);
 RemotePortRespSlot *rp_dev_timed_wait_resp(RemotePort *s, uint32_t dev,
                                            uint32_t id, int timems);
+void rp_restart_sync_timer(RemotePort *s);
+
+int64_t rp_normalized_vmclk(RemotePort *s);
 
 void rp_process(RemotePort *s);
 
-- 
2.43.0


