Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CA3ECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VK-0006iG-2v; Thu, 05 Feb 2026 14:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VI-0006gO-Pb
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:04 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VG-00036F-TL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:04 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so915083f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321541; x=1770926341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9GRLpbU+w5RLZs68eRIVOxMR5IAudT3xSniNO4i5TI=;
 b=TSn5wWvaLcvln52i2FtyYJd/KInnGBUKI4O9JfnDwhM0H/YS4fXd4/8HV54En49Hj3
 fneAEDMAJjWzlSRib9lpj2N+9iYFuehStMZu8VNGvnubJHsuIR+fwizNyY5xJ8GjDXp3
 tNKUbLqUpzq96d1tG0ez4ArJjwAxD2DsOMiC4BbPfW7QxVMOK0bOJ2QQneJhNLqv/QW9
 jyu07gDemp+RJDMGLKGaQA82+V4DWCWdAxv5NhAKLFuGxM+Gt/GjF2E9imT5T7akN0Zh
 cX1CL166ZzeelZNfJpwnK2j35HpwAz3ZLZuMx9dVLWlXXb4h1J0GQ4UKKyZ8E+dI3BOG
 FKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321541; x=1770926341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9GRLpbU+w5RLZs68eRIVOxMR5IAudT3xSniNO4i5TI=;
 b=XOdIlFb/oDryt9o3UJw/sGgS4Gxi/5j3H8ZSguC8C8hGWaqhHyNmApGXW5lEDutO0T
 W4WoM3ghvu7N4a5/grekwH9rh0V/9l0WJwihTlLYHCmG8eLA4PqfpC+ItK8QLEiJrqKA
 +3znxyaAo5Abhy7jiTdByI6LRJGpeL9Z4KlVI+Sb8SpH3p0RLnkeyazu3IOKSkrB10CP
 zea2tidmr4XIsPwhoUatk28eorg/ffZ6ZCX+SUZyX5aIl3wwkult594rd+/tZQ+Fi1ZM
 j1q9BaSlr1WWCLeK5T1oBj148oj4H0oYG82OEbJRpwHq7pNeh0dD7qqo7rfbA2FwEljV
 URjw==
X-Gm-Message-State: AOJu0Yy1Y97dzKdLlw7mcahQKYKzJ3WbDjoFZqSgtnG2qCUR9gT9rpAp
 /52+c7FuYfuijQbMP3gtxtLC6u2qt4YsS/jw+K9EF70H8uBYFWE2PdN4PfclAKrPxQA=
X-Gm-Gg: AZuq6aJjqNI8th9QRb2OuHATqQSCO9fDX/1zcMLqJ7rdPUfpoVSRNMzV29beSKpOJ+P
 +N42j7kio3vWoUoWT2AXL4Sk6DyEFpmqZF5d+n61l0Zhk5EtPRTrRIfXZFbOmu6/i0zcJhq5CxS
 6KSHag5gohf3Y3l+aY/A8Rn5E9OdoGxvmZjUc2PTIZocyl2JWKkauDUafraMXGYIH1UlVUkcFJL
 SfUwCQP9QQ1pTGcs2IkiXXR7kiJ4yKHE4efiWeAZRGJV2FGKTLaVrt2BPiU+ZJgRTK51GZZX0C6
 dME6gsCKeSvr9nOjrnAEcaHta8YkSoiF4U73IaUOUehlXWGvQs6JteAbzuwlfP7iY0uTq+cxweq
 WhL5EJAFFFMiAwpKlkiY257LeQny1B/7Jd5cgZsdIvuznzrJINP6VlRCY37Y9VHuckVhrklwwX3
 q2uaRFFSrJakS5RcGkJaU=
X-Received: by 2002:a5d:5f83:0:b0:435:a3c5:a526 with SMTP id
 ffacd0b85a97d-43629658283mr524308f8f.14.1770321540754; 
 Thu, 05 Feb 2026 11:59:00 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:00 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 12/29] hw/core: Implement Remote Port time synchronization
Date: Thu,  5 Feb 2026 20:58:07 +0100
Message-ID: <20260205195824.2610192-13-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x429.google.com
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
 hw/core/remote-port.c         | 184 +++++++++++++++++++++++++++++++++-
 include/hw/core/remote-port.h |  15 +++
 2 files changed, 197 insertions(+), 2 deletions(-)

diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 00c9529348..6a1933a5a6 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -13,6 +13,7 @@
 #include "chardev/char.h"
 #include "system/cpus.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/reset.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/hw-error.h"
@@ -53,6 +54,8 @@
      OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
 
 static void rp_event_read(void *opaque);
+static void sync_timer_hit(void *opaque);
+static void syncresp_timer_hit(void *opaque);
 
 static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
 {
@@ -69,9 +72,42 @@ void rp_rsp_mutex_unlock(RemotePort *s)
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
 
@@ -205,6 +241,39 @@ static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
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
+        SYNCD(printf("%s: sync resp %lu\n", s->prefix, pkt->sync.timestamp));
+        rp_write(s, (void *) &s->sync.rsp, enclen);
+        return;
+    }
+
+    SYNCD(printf("%s: delayed sync resp - start diff=%ld (ts=%lu clk=%lu)\n",
+          s->prefix, pkt->sync.timestamp - clk, pkt->sync.timestamp, clk));
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
@@ -226,6 +295,56 @@ static void rp_say_hello(RemotePort *s)
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
+    SYNCD(printf("%s: delayed sync response - send\n", s->prefix));
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
+        SYNCD(printf("%s: sync while delaying a resp! clk=%lu\n",
+                     s->prefix, clk));
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
+    SYNCD(printf("%s: syncing wait for resp %lu\n", s->prefix, clk));
+    rsp = rp_wait_resp(s);
+    rp_dpkt_invalidate(&rsp);
+    qemu_mutex_unlock(&s->rsp_mutex);
+    s->doing_sync = false;
+
+    rp_restart_sync_timer_bare(s);
+}
+
 static char *rp_sanitize_prefix(RemotePort *s)
 {
     char *sanitized_name;
@@ -318,7 +437,9 @@ void rp_process(RemotePort *s)
         }
 
         switch (pkt->hdr.cmd) {
-        /* TBD */
+        case RP_CMD_sync:
+            rp_cmd_sync(s, pkt);
+            break;
         default:
             assert(actioned);
         }
@@ -408,6 +529,33 @@ static void rp_pt_handover_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
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
@@ -462,6 +610,11 @@ static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
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
@@ -560,6 +713,7 @@ static void rp_reset(DeviceState *dev)
     qemu_thread_create(&s->thread, "remote-port", rp_protocol_thread, s,
                        QEMU_THREAD_JOINABLE);
 
+    rp_restart_sync_timer(s);
     s->reset_done = true;
 }
 
@@ -571,6 +725,8 @@ static void rp_realize(DeviceState *dev, Error **errp)
 
     s->prefix = object_get_canonical_path(OBJECT(dev));
 
+    s->peer.clk_base = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
     qemu_mutex_init(&s->write_mutex);
     qemu_mutex_init(&s->rsp_mutex);
     qemu_cond_init(&s->progress_cond);
@@ -693,6 +849,27 @@ static void rp_realize(DeviceState *dev, Error **errp)
     qemu_set_fd_handler(s->event.pipe.read, rp_event_read, NULL, s);
 #endif
 
+
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
+
     qemu_sem_init(&s->rx_queue.sem, ARRAY_SIZE(s->rx_queue.pkt) - 1);
 }
 
@@ -727,6 +904,9 @@ static Property rp_properties[] = {
     DEFINE_PROP_CHR("chardev", RemotePort, chr),
     DEFINE_PROP_STRING("chardesc", RemotePort, chardesc),
     DEFINE_PROP_STRING("chrdev-id", RemotePort, chrdev_id),
+    DEFINE_PROP_BOOL("sync", RemotePort, do_sync, false),
+    DEFINE_PROP_UINT64("sync-quantum", RemotePort, peer.local_cfg.quantum,
+                       1000000),
 };
 
 static void rp_prop_allow_set_link(const Object *obj, const char *name,
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index c1b21eb573..1d8b64925a 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -15,6 +15,7 @@
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
 #include "qobject/qdict.h"
+#include "hw/core/ptimer.h"
 
 #define TYPE_REMOTE_PORT_DEVICE "remote-port-device"
 
@@ -73,6 +74,8 @@ struct RemotePort {
     } event;
     Chardev *chrdev;
     CharFrontend chr;
+    bool do_sync;
+    bool doing_sync;
     bool finalizing;
     /* To serialize writes to fd.  */
     QemuMutex write_mutex;
@@ -81,6 +84,15 @@ struct RemotePort {
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
 
@@ -131,6 +143,9 @@ RemotePortDynPkt rp_wait_resp(RemotePort *s);
 RemotePortRespSlot *rp_dev_wait_resp(RemotePort *s, uint32_t dev, uint32_t id);
 RemotePortRespSlot *rp_dev_timed_wait_resp(RemotePort *s, uint32_t dev,
                                            uint32_t id, int timems);
+void rp_restart_sync_timer(RemotePort *s);
+
+int64_t rp_normalized_vmclk(RemotePort *s);
 
 void rp_process(RemotePort *s);
 
-- 
2.43.0


