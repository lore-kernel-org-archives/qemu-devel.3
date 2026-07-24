Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E3CC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCY8-0007cF-VF; Fri, 24 Jul 2026 05:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCMN-0008Ia-HG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:38:27 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiongwm2026@163.com>)
 id 1wnCML-00047e-6x
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 05:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4y
 j940qjx+FeltU9fph5m0Y6GNN8PcoIDW2zyosnPjg=; b=gj9yO5cfTDLSRJiI84
 Eru/s8yvTVCWU2KONQ3DUe82+oYxAjtBBp0iv5q0C26/xyjgrAU8bGoDQ06xLT1b
 mp4h/KOjfYJmNI5T+f7wLEAn1HPopX8vk1XknUhid58l3V74GTagHAyvrG6shvRo
 1rq7s/wwzqYKpt7IYLD1+Q1TQ=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wB3tZ+BMmNqFvnbLg--.65177S2; 
 Fri, 24 Jul 2026 17:38:10 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, mst@redhat.com, virtualization@lists.linux.dev,
 Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] hw/net/virtio-net: Remove dangerous cast in receive_header
Date: Fri, 24 Jul 2026 17:38:09 +0800
Message-ID: <20260724093809.810263-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3tZ+BMmNqFvnbLg--.65177S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr17CFWkJw4fZry3CrW3KFg_yoW8GFyxpF
 n0gF4Iqr4rXF13Ga1rAFs5X34jy3Zaka43CrWqq345uFZ8Ar1DtryY93W8t3WakFWkAF1I
 9rWFqFy5JF1Du3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAl19UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgIgr2pjMoLlmQAA3G
Received-SPF: pass client-ip=117.135.210.5; envelope-from=xiongwm2026@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 05:50:27 -0400
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

From: Xiong Weimin <xiongweimin@kylinos.cn>

The receive_header() function contains a "FIXME this cast is evil"
comment. The code does:
    void *wbuf = (void *)buf;

This cast from 'const void *' to 'void *' removes const qualifier which
could lead to unintended modifications. Instead, use a properly typed
pointer and pass it correctly to work_around_broken_dhclient().

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 hw/net/virtio-net.c | 12 +++++++----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1234567890ab..fedcba098765 4321006
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1716,12 +1716,14 @@ static void receive_header(VirtIONet *n, const struct iovec *iov, int iov_cnt,
                            const void *buf, size_t size)
 {
     if (n->has_vnet_hdr) {
-        /* FIXME this cast is evil */
-        void *wbuf = (void *)buf;
-        work_around_broken_dhclient(wbuf, wbuf + n->host_hdr_len,
-                                    size - n->host_hdr_len);
+        const uint8_t *wbuf = buf;
+        uint8_t *payload = (uint8_t *)(wbuf + n->host_hdr_len);
+
+        work_around_broken_dhclient(wbuf, payload,
+                                    size - n->host_hdr_len);
 
         if (n->needs_vnet_hdr_swap) {
-            virtio_net_hdr_swap(VIRTIO_DEVICE(n), wbuf);
+            virtio_net_hdr_swap(VIRTIO_DEVICE(n), (void *)wbuf);
         }
         iov_from_buf(iov, iov_cnt, 0, buf, sizeof(struct virtio_net_hdr));
     } else {


