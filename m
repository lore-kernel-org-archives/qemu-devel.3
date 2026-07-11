Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA22FC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifn0-0007SY-Hh; Sat, 11 Jul 2026 18:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmb-00077M-6l; Sat, 11 Jul 2026 18:02:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmU-0008SY-UA; Sat, 11 Jul 2026 18:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=fYD8Ier1c5QbI/U/nrPzBD2gUia+2eLE+0NOE8uWsVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PbXu9BgpUP9x0zOzqIWzzUWH9VZDuDyvmZFGnwjmUf6cuQrbrv99GYLDezCSN7rnJ
 QQPazoRKs4f3TvZ/1zrYKDtWgJ7OYKjEoOXgLqq0hfQUmiGFf2An2hrh/rMQ1w6qWN
 u1rk3U7tMgiuYvHxDop0pvWujpOTNat6p3agp9vMv2YYgVwUmPmTMdA1OpKC10McHD
 hUKKoVxqvLX1QNsoa9sDZAgHSLpFm6vuY6EUuuNBfIGW7eQ4oZDK+U0gM9RuRUTA6J
 vGWQmG0oHsuf5EuYYCmOK5fFAdxjmk+0tMwGDy6rp1qkk2l4LKp1g0RbXkYC2barXf
 VA3LwIeA9dqCw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D69E41C0AAC;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8C8E03EAF37;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 853D913325; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 33/81] virtio-net: validate RSS indirections_len in
 post_load
Date: Sun, 12 Jul 2026 00:58:11 +0300
Message-ID: <20260711215904.3757-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

virtio_net_handle_rss() enforces that indirections_len is a non-zero
power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
virtio_net_rss_post_load() applies none of these checks to values
restored from the migration stream.

A corrupted save file or crafted migration stream can set
indirections_len to 0.  Even if it also clears redirect,
virtio_load() calls set_features_nocheck() after the device vmstate
(including the RSS subsection and its post_load) has already been
loaded, re-deriving redirect from the negotiated guest features.
When VIRTIO_NET_F_RSS was negotiated, redirect is set back to true
regardless of the migration stream value.  The receive path then
computes

    hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int promotion */

and uses the result to index into indirections_table, which was not
allocated by the VMState loader when the element count is zero (see
vmstate_handle_alloc()), resulting in a NULL pointer dereference that
crashes QEMU:

  #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
  #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
  #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
  #3  nc_sendv_compat           ../net/net.c:823
  #4  qemu_deliver_packet_iov   ../net/net.c:870

The RSS subsection is only loaded when rss_data.enabled is true (via
virtio_net_rss_needed()), and the command path always produces
indirections_len in {1, 2, 4, …, 128}, so an unconditional check
cannot reject a legitimate migration stream.

Factor the validation into virtio_net_rss_indirections_len_valid()
and call it from both virtio_net_handle_rss() and
virtio_net_rss_post_load().

Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and hash report")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260324060100.1997-1-junjie.cao@intel.com>
(cherry picked from commit 32a90850e1e4222091df07b4b46d5f46a8b90d24)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a647..f0e3beb2903 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1374,6 +1374,11 @@ static void virtio_net_unload_ebpf(VirtIONet *n)
     ebpf_rss_unload(&n->ebpf_rss);
 }
 
+static bool virtio_net_rss_indirections_len_valid(uint16_t len)
+{
+    return is_power_of_2(len) && len <= VIRTIO_NET_RSS_MAX_TABLE_LEN;
+}
+
 static uint16_t virtio_net_handle_rss(VirtIONet *n,
                                       struct iovec *iov,
                                       unsigned int iov_cnt,
@@ -1411,14 +1416,9 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
     if (!do_rss) {
         n->rss_data.indirections_len = 0;
     }
-    if (n->rss_data.indirections_len >= VIRTIO_NET_RSS_MAX_TABLE_LEN) {
-        err_msg = "Too large indirection table";
-        err_value = n->rss_data.indirections_len;
-        goto error;
-    }
     n->rss_data.indirections_len++;
-    if (!is_power_of_2(n->rss_data.indirections_len)) {
-        err_msg = "Invalid size of indirection table";
+    if (!virtio_net_rss_indirections_len_valid(n->rss_data.indirections_len)) {
+        err_msg = "Invalid indirection table length";
         err_value = n->rss_data.indirections_len;
         goto error;
     }
@@ -3427,6 +3427,13 @@ static int virtio_net_rss_post_load(void *opaque, int version_id)
         n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
     }
 
+    if (!virtio_net_rss_indirections_len_valid(n->rss_data.indirections_len)) {
+        error_report("virtio-net: saved image has invalid RSS "
+                     "indirections_len: %u",
+                     n->rss_data.indirections_len);
+        return -EINVAL;
+    }
+
     return 0;
 }
 
-- 
2.47.3


