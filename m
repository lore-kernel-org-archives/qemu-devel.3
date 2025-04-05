Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA43C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 08:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0yW9-0004Qi-0e; Sat, 05 Apr 2025 04:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u0yW7-0004Ps-Kb
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 04:04:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u0yW5-00059A-6a
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 04:04:39 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7359aca7ef2so3728843b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1743840275; x=1744445075;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bU5FeqUk1dIY0D8apNIOZ7CAMIxGh2gWBLkbDvZYz4k=;
 b=aUItryyu+/0r//JaGV7QlquejmQXmhUoePEZp8k1OAWmBtnUF+V94oZMLEmN/lTBEL
 fQ+jm0Xxx26P1+KznBn2SpDM6DjZFwR3aK3Mmtr8DLvbmgd4JDMvZ7YWP3NSG5fqUinr
 8fPKLolgsp5MGKq743q1r87ex5PGWHHbKkV4vpHRB48NZ6nnpyD6oTGyRC1pKnjWokMZ
 +lVXt4sSFWChqx4fLCHSwJyu0EsGrBCaD3X2Yi/sWfZyzJhtJsAGfdFkniFdFV+ZwIjG
 mwbKycAWgu33nyfU0ARyxHLTP01xYIbzMO9Lgv1l6zL19+OdK8vEBP7r5yeb8gGBdkW3
 z7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743840275; x=1744445075;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bU5FeqUk1dIY0D8apNIOZ7CAMIxGh2gWBLkbDvZYz4k=;
 b=kIGxgHyNU7O3oqAJm9b4b779rk+AlETzQkRfqVE1Fluy1Y/omZazcOoyceGI7D6zby
 m15xxBM1xwTNyKGv1Yhi9MnoQtBEQFtxrnwROz6LypMl38nModcIQ35Z9wUSNc5KnadN
 1XBWcvvGBj9j0uMOkhwVbAIdcVJFIhANmrr5vTadOR4dsyCzqFWgmMX6BjgdPuWDR6sH
 p0rNymGKJG1cvhcQZcqxXdv1k5uz/tHC5p//9MloWNWujR9R0k7O09fmO5HnmoQJyVcs
 NmfIONqF1xJzjERusrbn63TnGkQCxGfIhAyUgvU/DeKdwDFWSsR8tIs800d+oFKLWF4t
 Bs2A==
X-Gm-Message-State: AOJu0YwuOhNk2PE9CIvEJG9ulVHcBP/KnBHvJ3MB3jGzWO+haPs8Empk
 NKf0Aok1uxPuB3o/ptCbJePTDh6ktu5yNuveQQf10zWg6MGFa0GWQd08RzYqc4E=
X-Gm-Gg: ASbGnctN3LYl+RUGSYXOXDUdBWFP2j6a8A94ljhWmFdJJp6oh4Bw1AJocZ9Mios0L06
 Hw2uYL1VK98wUlP3ky0F9/M1U+2oq8MgDze3C8EK46aZPeEz7P55HSsWbK+mVtSzsaekvy1Hdhj
 XsjbSGYYhSM4fZEeWW8J8k/L6CoBUO0s7G+0jzXu6LYqFwF0W1mYdu6iOkFncM8Ru7JDA7s0scY
 Dt/wtSuTl7IvKm6UP0o2ObAO1WpSed6q1Nl43dIGja7m4HQTv/Q8vUyM0IsxWoJMq5/rXttPpm3
 KMBfubWTtGuNR/aD23sVQ8C+CrHphc3pZ+ALv3dAuH1JXWdd
X-Google-Smtp-Source: AGHT+IGECaRChUu+ZxEldDAQpDDyt7cqrwJhujD5bhmalfxkxNdQ2+NmfJbMMvd83wPfPTcKGei61Q==
X-Received: by 2002:a05:6a00:885:b0:736:5e6f:295b with SMTP id
 d2e1a72fcca58-739e705de3fmr8632277b3a.12.1743840275477; 
 Sat, 05 Apr 2025 01:04:35 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-739da0b3f5asm4838918b3a.131.2025.04.05.01.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 01:04:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 05 Apr 2025 17:04:28 +0900
Subject: [PATCH] virtio-net: Copy all for dhclient workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250405-mtu-v1-1-08c5910fa6fd@daynix.com>
X-B4-Tracking: v=1; b=H4sIAAvk8GcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNT3dySUl0LY5MUk2Qzo2RL42QloMqCotS0zAqwKdGxtbUAi1gqlFU
 AAAA=
X-Change-ID: 20250405-mtu-834d4c62c93c
To: qemu-devel@nongnu.org, Antoine Damhet <adamhet@scaleway.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com, qemu-stable@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The goal of commit 7987d2be5a8b ("virtio-net: Copy received header to
buffer") was to remove the need to patch the (const) input buffer with a
recomputed UDP checksum by copying headers to a RW region and inject the
checksum there. The patch computed the checksum only from the header
fields (missing the rest of the payload) producing an invalid one
and making guests fail to acquire a DHCP lease.

Fix the issue by copying the entire packet instead of only copying the
headers.

Fixes: 7987d2be5a8b ("virtio-net: Copy received header to buffer")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2727
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
This patch aims to resolves the issue the following one also does:
https://lore.kernel.org/qemu-devel/20250404151835.328368-1-adamhet@scaleway.com

The difference from the mentioned patch is that this patch also
preserves that the original intent of regressing change, which is to
remove the need to patch the (const) input buffer with a recomputed UDP
checksum.

To Antoine Damhet:
I confirmed that DHCP is currently not working and this patch fixes the
issue, but I would appreciate if you also confirm the fix as I already
have done testing badly for the regressing patch.
---
 hw/net/virtio-net.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadffe1..a920358a89c5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1687,6 +1687,11 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
     virtio_tswap16s(vdev, &hdr->csum_offset);
 }
 
+typedef struct Header {
+    struct virtio_net_hdr_v1_hash virtio_net;
+    uint8_t payload[1500];
+} Header;
+
 /* dhclient uses AF_PACKET but doesn't pass auxdata to the kernel so
  * it never finds out that the packets don't have valid checksums.  This
  * causes dhclient to get upset.  Fedora's carried a patch for ages to
@@ -1701,7 +1706,7 @@ static void virtio_net_hdr_swap(VirtIODevice *vdev, struct virtio_net_hdr *hdr)
  * we should provide a mechanism to disable it to avoid polluting the host
  * cache.
  */
-static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
+static void work_around_broken_dhclient(struct Header *hdr,
                                         size_t *hdr_len, const uint8_t *buf,
                                         size_t buf_size, size_t *buf_offset)
 {
@@ -1711,20 +1716,20 @@ static void work_around_broken_dhclient(struct virtio_net_hdr *hdr,
     buf += *buf_offset;
     buf_size -= *buf_offset;
 
-    if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
-        (buf_size >= csum_size && buf_size < 1500) && /* normal sized MTU */
+    if ((hdr->virtio_net.hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && /* missing csum */
+        (buf_size >= csum_size && buf_size < sizeof(hdr->payload)) && /* normal sized MTU */
         (buf[12] == 0x08 && buf[13] == 0x00) && /* ethertype == IPv4 */
         (buf[23] == 17) && /* ip.protocol == UDP */
         (buf[34] == 0 && buf[35] == 67)) { /* udp.srcport == bootps */
-        memcpy((uint8_t *)hdr + *hdr_len, buf, csum_size);
-        net_checksum_calculate((uint8_t *)hdr + *hdr_len, csum_size, CSUM_UDP);
-        hdr->flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
-        *hdr_len += csum_size;
-        *buf_offset += csum_size;
+        memcpy((uint8_t *)hdr + *hdr_len, buf, buf_size);
+        net_checksum_calculate((uint8_t *)hdr + *hdr_len, buf_size, CSUM_UDP);
+        hdr->virtio_net.hdr.flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
+        *hdr_len += buf_size;
+        *buf_offset += buf_size;
     }
 }
 
-static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
+static size_t receive_header(VirtIONet *n, Header *hdr,
                              const void *buf, size_t buf_size,
                              size_t *buf_offset)
 {
@@ -1736,7 +1741,7 @@ static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
     work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
 
     if (n->needs_vnet_hdr_swap) {
-        virtio_net_hdr_swap(VIRTIO_DEVICE(n), hdr);
+        virtio_net_hdr_swap(VIRTIO_DEVICE(n), (struct virtio_net_hdr *)hdr);
     }
 
     return hdr_len;
@@ -1907,13 +1912,6 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     return (index == new_index) ? -1 : new_index;
 }
 
-typedef struct Header {
-    struct virtio_net_hdr_v1_hash virtio_net;
-    struct eth_header eth;
-    struct ip_header ip;
-    struct udp_header udp;
-} Header;
-
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                       size_t size)
 {
@@ -2002,8 +2000,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             }
 
             guest_offset = n->has_vnet_hdr ?
-                           receive_header(n, (struct virtio_net_hdr *)&hdr,
-                                          buf, size, &offset) :
+                           receive_header(n, &hdr, buf, size, &offset) :
                            n->guest_hdr_len;
 
             iov_from_buf(sg, elem->in_num, 0, &hdr, guest_offset);

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250405-mtu-834d4c62c93c

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


