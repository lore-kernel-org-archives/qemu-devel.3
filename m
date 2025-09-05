Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F56DCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuWqH-0001gl-IG; Fri, 05 Sep 2025 09:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWqD-0001et-0Z
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:51:01 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWq2-0006XD-MW
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:51:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8846FC108E;
 Fri, 05 Sep 2025 16:50:43 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id foiXcl3Gh8c0-sl5GhG6P; Fri, 05 Sep 2025 16:50:43 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757080243;
 bh=M+LwSX/uuPa2gM4twysLBZZ64QwQ6Num9jQnfd3A3y8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=V6lAPmdt+NFWWRJxYDVZdclezaHe8WZ4qVVSYd+NXtJ2W37tDoePm2FrGo7/UyVoB
 Uc+psfaKCxhUfwx8AT/ieBKBgqifvB+V7n1s23PeAOm3XXbSNaNZY+tk02KkqhiN1T
 9VPmna1m5ipUG2oMjx+S34J8W21Uo+vMEXu2wNTY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v3 1/9] net/tap: add some trace points
Date: Fri,  5 Sep 2025 16:50:31 +0300
Message-ID: <20250905135039.2202924-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 net/tap.c        | 10 ++++++++++
 net/trace-events |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index 2530627a9a..151fb73820 100644
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
@@ -199,6 +203,8 @@ static void tap_send(void *opaque)
             break;
         }
 
+        trace_tap_send_packet(s->using_vnet_hdr, s->host_vnet_hdr_len, size);
+
         if (s->host_vnet_hdr_len && size <= s->host_vnet_hdr_len) {
             /* Invalid packet */
             break;
@@ -980,6 +986,8 @@ int tap_enable(NetClientState *nc)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     int ret;
 
+    trace_tap_enable();
+
     if (s->enabled) {
         return 0;
     } else {
@@ -997,6 +1005,8 @@ int tap_disable(NetClientState *nc)
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     int ret;
 
+    trace_tap_disable();
+
     if (s->enabled == 0) {
         return 0;
     } else {
diff --git a/net/trace-events b/net/trace-events
index cda960f42b..a8921763ab 100644
--- a/net/trace-events
+++ b/net/trace-events
@@ -29,3 +29,9 @@ vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asid_num) "
 vhost_vdpa_net_load_cmd(void *s, uint8_t class, uint8_t cmd, int data_num, int data_size) "vdpa state: %p class: %u cmd: %u sg_num: %d size: %d"
 vhost_vdpa_net_load_cmd_retval(void *s, uint8_t class, uint8_t cmd, int r) "vdpa state: %p class: %u cmd: %u retval: %d"
 vhost_vdpa_net_load_mq(void *s, int ncurqps) "vdpa state: %p current_qpairs: %d"
+
+# tap.c
+tap_receive_iov(bool using_vnet_hdr, uint32_t host_vnet_hdr_len, int iovcnt, size_t iov_len) "using_vnet_hdr:%d host_vnet_hdr_len:%u iovcnt:%d iov_len:%zu"
+tap_send_packet(bool using_vnet_hdr, uint32_t host_vnet_hdr_len, int size) "using_vnet_hdr:%d host_vnet_hdr_len:%u size:%d"
+tap_enable(void) ""
+tap_disable(void) ""
-- 
2.48.1


