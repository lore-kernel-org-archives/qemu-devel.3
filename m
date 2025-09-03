Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6946CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utngE-0005N9-0T; Wed, 03 Sep 2025 09:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfu-00059R-Q9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:23 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfp-0004tH-Qf
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EFC90C0197;
 Wed, 03 Sep 2025 16:37:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BbgRSa3GomI0-S0T2KLBN; Wed, 03 Sep 2025 16:37:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756906633;
 bh=vTD8jN8GgnHxP7miFMJzCoDR8mpWlWdzUIe3poEf6UQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=PEqWXXBV6BmEKO1CTYhh61qfBngaROTC+QHAwReNsM75Gp/JeJdgSiK9+ZxE44Vlt
 ANIbSdfhSbZG/28oFtkbZRiQoSqJJi/41i/sEgy18Aw/wQ06anV6vir2EwgLJknugy
 RCY1Wb6rNL8NCp56vQF2sCEJxpd9wlPpNCXoesUw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v2 1/8] net/tap: add some trace points
Date: Wed,  3 Sep 2025 16:36:58 +0300
Message-ID: <20250903133706.1177633-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add trace points to simplify debugging migration.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/trace-events |  7 ++++++
 2 files changed, 65 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index 2530627a9a..224fb37310 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -43,6 +43,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "hw/virtio/vhost.h"
+#include "trace.h"
 
 #include "net/tap.h"
 
@@ -148,6 +149,9 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     g_autofree struct iovec *iov_copy = NULL;
     struct virtio_net_hdr hdr = { };
 
+    trace_tap_receive_iov(s->using_vnet_hdr, s->host_vnet_hdr_len, iovcnt,
+                          iov->iov_len);
+
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy = g_new(struct iovec, iovcnt + 1);
         iov_copy[0].iov_base = &hdr;
@@ -183,6 +187,49 @@ static void tap_send_completed(NetClientState *nc, ssize_t len)
     tap_read_poll(s, true);
 }
 
+static char *tap_dump_packet(const uint8_t *buf, int size)
+{
+    int i, j;
+    char hex_line[80];  /* Enough space for hex pairs + spaces */
+    char ascii_line[17]; /* 16 + 1 for null terminator */
+    GString *dump_str = g_string_new(NULL);
+
+    g_string_append_printf(dump_str, "Packet dump (%d bytes):\n", size);
+
+    for (i = 0; i < size; i += 16) {
+        memset(hex_line, 0, sizeof(hex_line));
+        memset(ascii_line, 0, sizeof(ascii_line));
+
+        /* Build hex line in groups of 2 bytes (4 hex chars) */
+        int hex_pos = 0;
+        for (j = 0; j < 16 && (i + j) < size; j += 2) {
+            if (i + j + 1 < size) {
+                /* Two bytes available */
+                hex_pos += snprintf(hex_line + hex_pos,
+                                    sizeof(hex_line) - hex_pos,
+                                    "%02x%02x ", buf[i + j], buf[i + j + 1]);
+            } else {
+                /* Only one byte left */
+                hex_pos += snprintf(hex_line + hex_pos,
+                                    sizeof(hex_line) - hex_pos,
+                                    "%02x   ", buf[i + j]);
+            }
+        }
+
+        /* Build ASCII line */
+        for (j = 0; j < 16 && (i + j) < size; j++) {
+            uint8_t byte = buf[i + j];
+            ascii_line[j] = (byte >= 32 && byte <= 126) ? byte : '.';
+        }
+
+        /* Add the line in tcpdump-like format */
+        g_string_append_printf(dump_str, "\t0x%04x:  %-40s %s\n",
+                               i, hex_line, ascii_line);
+    }
+
+    return g_string_free(dump_str, false);
+}
+
 static void tap_send(void *opaque)
 {
     TAPState *s = opaque;
@@ -199,6 +246,13 @@ static void tap_send(void *opaque)
             break;
         }
 
+        if (trace_event_get_state_backends(TRACE_TAP_PACKET_DUMP)) {
+            g_autofree char *dump = tap_dump_packet(s->buf, size);
+            trace_tap_packet_dump(dump);
+        }
+
+        trace_tap_send_packet(s->using_vnet_hdr, s->host_vnet_hdr_len, size);
+
         if (s->host_vnet_hdr_len && size <= s->host_vnet_hdr_len) {
             /* Invalid packet */
             break;
@@ -980,6 +1034,8 @@ int tap_enable(NetClientState *nc)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     int ret;
 
+    trace_tap_enable();
+
     if (s->enabled) {
         return 0;
     } else {
@@ -997,6 +1053,8 @@ int tap_disable(NetClientState *nc)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     int ret;
 
+    trace_tap_disable();
+
     if (s->enabled == 0) {
         return 0;
     } else {
diff --git a/net/trace-events b/net/trace-events
index cda960f42b..b51427f539 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -29,3 +29,10 @@ vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "
 vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_num, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
 vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int r) "vdpa state: %p class: %u cmd: %u retval: %d"
 vhost_vdpa_net_load_mq(void *s, int ncurqps) "vdpa state: %p current_qpairs: %d"
+
+# tap.c
+tap_receive_iov(bool using_vnet_hdr, uint32_t host_vnet_hdr_len, int iovcnt, size_t iov_len) "using_vnet_hdr:%d host_vnet_hdr_len:%u iovcnt:%d iov_len:%zu"
+tap_send_packet(bool using_vnet_hdr, uint32_t host_vnet_hdr_len, int size) "using_vnet_hdr:%d host_vnet_hdr_len:%u size:%d"
+tap_enable(void) "tap enabled"
+tap_disable(void) "tap disabled"
+tap_packet_dump(const char *dump_str) "%s"
-- 
2.48.1


