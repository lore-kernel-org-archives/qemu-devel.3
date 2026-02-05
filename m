Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6153FECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VE-0006cE-Nq; Thu, 05 Feb 2026 14:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VE-0006bp-0o
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:00 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VC-00035D-1h
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:58:59 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so1427559f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321536; x=1770926336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSJ8tOiInHZajPxuGqsMt9qE3I/cEaWxjUiyrEukxUo=;
 b=AzQeLg+8sHNwBGtQ4jN3JbxSwQgjVExpl1bqZpax1j1NBem7BJ/KnuaFqRs/mmUV13
 XQI2/e5BwWreY+8E9lUS8hLeN5RUcqR0uoC2ivKsOUcB++oLrLCQ5/tC4P6g9hwiECcl
 DHGcSFkUYpQqVUjnF6P2zmEzovrSFRCggO4fTQKyiCih616GHzQe4qzVpA710bDkemOa
 gTAz3XGUvLmGB6PNVMyiOs1/FiDi4YgNJ/hJgNJVoC7/6M/hy31/ucsnaMWSya+gNcat
 F5d47GSMagucVUPBvW8lq86imkX4b3SLQfcQ14ZYGcPuZYL1/O1wLv0NR4xEBMt6G5Ab
 z4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321536; x=1770926336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CSJ8tOiInHZajPxuGqsMt9qE3I/cEaWxjUiyrEukxUo=;
 b=FA47F5fxm/s3FG1beo3S6gv9VLJoAO64RVnqLlEkKXgRlHC71UFs6iS843p8I9ZU3x
 PUf1mVRFuXRBUOW5nHBFIJ5kB3G5Mi1HtmZ1pcCvyzo6op7jK6/Vo1EFoEhNETh40UTo
 q77Ugk5O4pXWiy8n4oxdNbq8v0kSDClWAlMdVieC04aiYBDvcXwixvsLgp/5EdbvcQnT
 69zAGfhySo5rdehvvzScVGE+ayB7rqhJ3OS2prH66SO6BWW03cTxOKwE1QdjdadO68SP
 fffuIs1hRaigcnV6RhG4rjFyvfNqptPxLO5clWNRaeqQZgLfGmKN5noPQgHEvdVdRKX0
 6gKA==
X-Gm-Message-State: AOJu0YyuPaYDn6OeGKeb/Csy0BLW3MhvxiY/p2SRLpzrcMf0mUzLJlVt
 Khmcz5OP9aXwoa7p4zv57n9o6I7wgo4+7yb3AnkhOqSbDCKjhIIds5qISVWN0qK4mYw=
X-Gm-Gg: AZuq6aJJ8jkVRWLITZb7Yfk8EzmO78Ene7kHY0cgbe4ihCxSkUez/l4ab/S6SeF/wNU
 CXx202Q4PUNaX1uXbjnu8uKQAidddks35oPlZQUY/hxtWbdqKef5YBJrl0cFuRHdrsoAdFYanDD
 2Pd6APXw7Nds58rg6R9nXmxYLyd7K3XSs0QIuyCGWP2v8iu/s3ALusBRIOFJr6CUB9dkhavRVwe
 4Z/j1eDOtqQR13pxX6+4pLxJBzOtT/9dMtlZcjkXD7NEkThmUmu/qTP6CTiRiQyMrfOOvCXO9Yh
 M92NdxSNSH0G6YogwkeZb21HPYmea73/IAU3Zos5hZsWutVyJq1ouBwZ+ZuNDudHh/I8hKbalPn
 U6Aai/PHmTnFs8s9U8s/WdUOto/oS8cjMRlPMTDMIVg4dH8sB2WxIrwFTVGpmnHvTYkwO/jzF25
 NTnAVXR4BvTcqt3OKdd6o=
X-Received: by 2002:a05:6000:250a:b0:435:b089:4f46 with SMTP id
 ffacd0b85a97d-4362938c2f5mr675837f8f.50.1770321536056; 
 Thu, 05 Feb 2026 11:58:56 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:58:55 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 09/29] hw/core: Add Remote Port protocol thread and handshake
Date: Thu,  5 Feb 2026 20:58:04 +0100
Message-ID: <20260205195824.2610192-10-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x431.google.com
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

Introduce main execution loop for the Remote Port protocol.
Creates a dedicated thread to manage the communication lifecycle.
This includes logic to read packets and manage RX queue.

Patch also implements handshake logic to verify protocol
versions and negotiate capabilities with remote peer.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port.c         | 190 ++++++++++++++++++++++++++++++++++
 include/hw/core/remote-port.h |  22 ++++
 2 files changed, 212 insertions(+)

diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 5154c1bc2a..91b0682884 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -52,6 +52,88 @@
 #define REMOTE_PORT_CLASS(klass)    \
      OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
 
+static void rp_pkt_dump(const char *prefix, const char *buf, size_t len)
+{
+    qemu_hexdump(stdout, prefix, buf, len);
+}
+
+static void rp_fatal_error(RemotePort *s, const char *reason)
+{
+    error_report("%s: %s", s->prefix, reason);
+    exit(EXIT_FAILURE);
+}
+
+static ssize_t rp_recv(RemotePort *s, void *buf, size_t count)
+{
+    ssize_t r;
+
+    r = qemu_chr_fe_read_all(&s->chr, buf, count);
+    if (r <= 0) {
+        return r;
+    }
+    if (r != count) {
+        error_report("%s: Bad read, expected %zd but got %zd",
+                     s->prefix, count, r);
+        rp_fatal_error(s, "Bad read");
+    }
+
+    return r;
+}
+
+ssize_t rp_write(RemotePort *s, const void *buf, size_t count)
+{
+    ssize_t r;
+
+    qemu_mutex_lock(&s->write_mutex);
+    r = qemu_chr_fe_write_all(&s->chr, buf, count);
+    qemu_mutex_unlock(&s->write_mutex);
+    assert(r == count);
+    if (r <= 0) {
+        error_report("%s: Disconnected r=%zd buf=%p count=%zd",
+                     s->prefix, r, buf, count);
+        rp_fatal_error(s, "Bad write");
+    }
+    return r;
+}
+
+static void rp_cmd_hello(RemotePort *s, struct rp_pkt *pkt)
+{
+    s->peer.version = pkt->hello.version;
+    if (pkt->hello.version.major != RP_VERSION_MAJOR) {
+        error_report("remote-port version missmatch remote=%d.%d local=%d.%d",
+                      pkt->hello.version.major, pkt->hello.version.minor,
+                      RP_VERSION_MAJOR, RP_VERSION_MINOR);
+        rp_fatal_error(s, "Bad version");
+    }
+
+    if (pkt->hello.caps.len) {
+        void *caps = (char *) pkt + pkt->hello.caps.offset;
+
+        rp_process_caps(&s->peer, caps, pkt->hello.caps.len);
+    }
+}
+
+static void rp_say_hello(RemotePort *s)
+{
+    struct rp_pkt_hello pkt;
+    uint32_t caps[] = {
+        CAP_BUSACCESS_EXT_BASE,
+        CAP_BUSACCESS_EXT_BYTE_EN,
+        CAP_WIRE_POSTED_UPDATES,
+        CAP_ATS,
+    };
+    size_t len;
+
+    len = rp_encode_hello_caps(s->current_id++, 0, &pkt, RP_VERSION_MAJOR,
+                               RP_VERSION_MINOR,
+                               caps, caps, sizeof caps / sizeof caps[0]);
+    rp_write(s, (void *) &pkt, len);
+
+    if (sizeof caps) {
+        rp_write(s, caps, sizeof caps);
+    }
+}
+
 static char *rp_sanitize_prefix(RemotePort *s)
 {
     char *sanitized_name;
@@ -105,6 +187,108 @@ static Chardev *rp_autocreate_chardev(RemotePort *s, char *name)
     return chr;
 }
 
+static bool rp_pt_process_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    struct rp_pkt *pkt = dpkt->pkt;
+
+    D(qemu_log("%s: cmd=%x id=%d dev=%d\n", __func__, pkt->hdr.cmd,
+             pkt->hdr.id, pkt->hdr.dev));
+
+    if (pkt->hdr.dev >= ARRAY_SIZE(s->devs)) {
+        /* FIXME: Respond with an error.  */
+        return true;
+    }
+
+    switch (pkt->hdr.cmd) {
+    case RP_CMD_hello:
+        rp_cmd_hello(s, pkt);
+        break;
+    case RP_CMD_read:
+    case RP_CMD_write:
+    case RP_CMD_interrupt:
+    case RP_CMD_ats_req:
+    case RP_CMD_ats_inv:
+        /* TBD */;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+    return false;
+}
+
+static int rp_read_pkt(RemotePort *s, RemotePortDynPkt *dpkt)
+{
+    struct rp_pkt *pkt = dpkt->pkt;
+    int used;
+    int r;
+
+    r = rp_recv(s, pkt, sizeof pkt->hdr);
+    if (r <= 0) {
+        return r;
+    }
+    used = rp_decode_hdr((void *) &pkt->hdr);
+    assert(used == sizeof pkt->hdr);
+
+    if (pkt->hdr.len) {
+        rp_dpkt_alloc(dpkt, sizeof pkt->hdr + pkt->hdr.len);
+        /* pkt may move due to realloc.  */
+        pkt = dpkt->pkt;
+        r = rp_recv(s, &pkt->hdr + 1, pkt->hdr.len);
+        if (r <= 0) {
+            return r;
+        }
+        rp_decode_payload(pkt);
+    }
+
+    return used + r;
+}
+
+static void *rp_protocol_thread(void *arg)
+{
+    RemotePort *s = REMOTE_PORT(arg);
+    unsigned int i;
+    int r;
+
+    /* Make sure we have a decent bufsize to start with.  */
+    rp_dpkt_alloc(&s->rsp, sizeof s->rsp.pkt->busaccess + 1024);
+    for (i = 0; i < ARRAY_SIZE(s->rx_queue.pkt); i++) {
+        rp_dpkt_alloc(&s->rx_queue.pkt[i],
+                      sizeof s->rx_queue.pkt[i].pkt->busaccess + 1024);
+        s->rx_queue.inuse[i] = false;
+    }
+
+    rp_say_hello(s);
+
+    while (1) {
+        RemotePortDynPkt *dpkt;
+        unsigned int wpos = s->rx_queue.wpos;
+        bool handled;
+
+        dpkt = &s->rx_queue.pkt[wpos];
+        s->rx_queue.inuse[wpos] = true;
+
+        r = rp_read_pkt(s, dpkt);
+        if (r <= 0) {
+            /* Disconnected.  */
+            break;
+        }
+        if (0) {
+            rp_pkt_dump("rport-pkt", (void *) dpkt->pkt,
+                        sizeof dpkt->pkt->hdr + dpkt->pkt->hdr.len);
+        }
+        handled = rp_pt_process_pkt(s, dpkt);
+        if (handled) {
+            s->rx_queue.inuse[wpos] = false;
+        }
+    }
+
+    if (!s->finalizing) {
+        rp_fatal_error(s, "Disconnected");
+    }
+    return NULL;
+}
+
 static void rp_reset(DeviceState *dev)
 {
     RemotePort *s = REMOTE_PORT(dev);
@@ -113,6 +297,9 @@ static void rp_reset(DeviceState *dev)
         return;
     }
 
+    qemu_thread_create(&s->thread, "remote-port", rp_protocol_thread, s,
+                       QEMU_THREAD_JOINABLE);
+
     s->reset_done = true;
 }
 
@@ -124,6 +311,8 @@ static void rp_realize(DeviceState *dev, Error **errp)
 
     s->prefix = object_get_canonical_path(OBJECT(dev));
 
+    qemu_mutex_init(&s->write_mutex);
+
     if (!qemu_chr_fe_get_driver(&s->chr)) {
         char *name;
         Chardev *chr = NULL;
@@ -249,6 +438,7 @@ static void rp_unrealize(DeviceState *dev)
 
     info_report("%s: Wait for remote-port to disconnect", s->prefix);
     qemu_chr_fe_disconnect(&s->chr);
+    qemu_thread_join(&s->thread);
 
     close(s->event.pipe.read);
     close(s->event.pipe.write);
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index 0f40018cdb..b88e523894 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -56,6 +56,7 @@ typedef struct RemotePortDeviceClass {
 struct RemotePort {
     DeviceState parent;
 
+    QemuThread thread;
     union {
        int pipes[2];
        struct {
@@ -66,9 +67,28 @@ struct RemotePort {
     Chardev *chrdev;
     CharFrontend chr;
     bool finalizing;
+    /* To serialize writes to fd.  */
+    QemuMutex write_mutex;
 
     char *chardesc;
     char *chrdev_id;
+    struct rp_peer_state peer;
+
+#define RX_QUEUE_SIZE 1024
+    struct {
+        /* This array must be sized minimum 2 and always a power of 2.  */
+        RemotePortDynPkt pkt[RX_QUEUE_SIZE];
+        bool inuse[RX_QUEUE_SIZE];
+        QemuSemaphore sem;
+        unsigned int wpos;
+        unsigned int rpos;
+    } rx_queue;
+
+    /*
+     * rsp holds responses for the remote side.
+     * Used by the slave.
+     */
+    RemotePortDynPkt rsp;
 
     const char *prefix;
     const char *remote_prefix;
@@ -80,4 +100,6 @@ struct RemotePort {
     RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
 };
 
+ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
+
 #endif
-- 
2.43.0


