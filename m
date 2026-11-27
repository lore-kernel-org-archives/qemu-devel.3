Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iXq2uMz3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWovA-00038L-MT; Fri, 27 Nov 2026 00:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWov5-0002yy-Hy; Fri, 27 Nov 2026 00:54:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWov3-0007Vb-7a; Fri, 27 Nov 2026 00:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=IMtvWrmyIq62TYFd2YZgi8wVG7+y8HuYp1pxYyK7U14=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iXq2uMz3t2QwLBORSZ/cNxrEkWy/HrRBCL48oM3RLlpRrvIQIJb/9nZ1yvXnNfbS8
 1ULU0UrwxUY2iXvNJmLUUcR8R9clAZG5TOeZ8aL9x29Qs3biQYBm0vbFWTAaoXuvUg
 5rdah2OwD03OJyqwyI0VnG1tMg6a2+nx3ResqSi0mFQN7Yjr/pbq/i0I+R5qs2xipr
 z6ik+5ZWJDZ8KJ2LREe2ptOHGXpa52cK6/RxMdQn7mrF70rBVLMqDXdwNSDgRpwMxI
 xGeJKX6zzKoVlJh6QRG4UFXglGo7l+K1kBfNJ23qtGoONXum4AsoDXTm7Tdtm9m5la
 fHAotQrbnXF/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD6EB1EA2C9;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B7E44469907;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A5895CF21A; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Lazymio <mio@lazym.io>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 066/140] net/eth.c: In eth_parse_ipv6_hdr(),
 fix check of input size
Date: Fri, 27 Nov 2026 08:52:52 +0300
Message-ID: <20261127055421.39015-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

We already have some L4/L5 header bound checks. Add the missing
coverage for IPv6.

The IPv6 header parser incorrectly derives L4 offsets greater than
actual values. Adding a bound check without fixing it would reject
valid packets while fixing it without adding a bound check can result
in an out-of-bounds access, so fix it along with the bound check
addition.

One fixed problem of the parser is that extension header size is not
properly computed for the Fragment Header and the IP Authentication
Header.

RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
4.5. "Fragment Header" says the Fragment Header has a fixed size.
The byte represented by ext_hdr.ip6r_len is reserved and "ignored on
reception".

RFC 4302 "IP Authentication Header" section 2.2. "Payload Length" says
it specifies the length of AH in 32-bit words (4-byte units), minus "2".

Another fixed problem is that the parser continues parsing extensions in
noninitial fragments.

RFC 8200 "Internet Protocol, Version 6 (IPv6) Specification" section
4.5 "Fragment Header" says the noninitial fragment packets have the
Fragment Header containing "the Next Header value that identifies the
first header after the Per-Fragment headers of the original packet"
followed by "the fragment itself."

Therefore, the data following the Fragment Header in the noninitial
fragment packet must be treated as a fragment instead of another
extension header, regardless of the Next Header value the Fragment
Header contains.

Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Fixes: 75020a702151 ("Common definitions for VMWARE devices")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
Cc: qemu-stable@nongnu.org
Reported-by: Lazymio <mio@lazym.io>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-6-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
[PMM: fixed typo in comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 4828fff27b5b895791f9e258a92f31701fbc9a44)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/eth.c b/net/eth.c
index d2d0b86d9eb..1e279787f39 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "net/eth.h"
 #include "net/checksum.h"
@@ -473,7 +474,9 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
     struct ip6_ext_hdr ext_hdr;
     size_t bytes_read;
     uint8_t curr_ext_hdr_type;
+    uint16_t buf;
     size_t input_size = iov_size(pkt, pkt_frags);
+    bool subsequent = false;
 
     info->rss_ex_dst_valid = false;
     info->rss_ex_src_valid = false;
@@ -513,25 +516,73 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
             return false;
         }
 
-        if (curr_ext_hdr_type == IP6_ROUTING) {
+        switch (curr_ext_hdr_type) {
+        case IP6_ROUTING:
             if (ext_hdr.ip6r_len == sizeof(struct in6_address) / 8) {
                 info->rss_ex_dst_valid =
                     _eth_get_rss_ex_dst_addr(pkt, pkt_frags,
                                              ip6hdr_off + info->full_hdr_len,
                                              &ext_hdr, &info->rss_ex_dst);
             }
-        } else if (curr_ext_hdr_type == IP6_DESTINATON) {
+            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
+            break;
+
+        case IP6_DESTINATON:
             info->rss_ex_src_valid =
                 _eth_get_rss_ex_src_addr(pkt, pkt_frags,
                                          ip6hdr_off + info->full_hdr_len,
                                          &ext_hdr, &info->rss_ex_src);
-        } else if (curr_ext_hdr_type == IP6_FRAGMENT) {
+            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
+            break;
+
+        case IP6_FRAGMENT:
+            bytes_read = iov_to_buf(pkt, pkt_frags,
+                                    ip6hdr_off + info->full_hdr_len + 2,
+                                    &buf, sizeof(buf));
+            if (bytes_read < sizeof(buf)) {
+                return false;
+            }
+
+            /*
+             * Per RFC 8200, the Fragment header does not have the Hdr Ext Len.
+             */
+            info->full_hdr_len += 8;
+
             info->fragment = true;
+
+            /*
+             * Detect a subsequent fragment per RFC 8200.
+             *
+             * A subsequent fragment contains no extension headers while the
+             * Next Header value identifies the first header after the
+             * Per-Fragment headers of the original packet.
+             *
+             * The subsequent fragment is detected by checking if the Fragment
+             * Offset is nonzero.
+             */
+            subsequent = extract16(be16_to_cpu(buf), 3, 13);
+            break;
+
+        case IP6_AUTHENTICATION:
+            /*
+             * Per RFC 4302, the Authentication Header has the Payload Len
+             * instead of the Hdr Ext Len. The Payload Len specifies the length
+             * of AH in 4-byte units.
+             */
+            info->full_hdr_len += (ext_hdr.ip6r_len + 2) * 4;
+            break;
+
+        default:
+            info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
         }
 
-        info->full_hdr_len += (ext_hdr.ip6r_len + 1) * IP6_EXT_GRANULARITY;
         curr_ext_hdr_type = ext_hdr.ip6r_nxt;
-    } while (eth_is_ip6_extension_header_type(curr_ext_hdr_type));
+    } while (!subsequent &&
+             eth_is_ip6_extension_header_type(curr_ext_hdr_type));
+
+    if (input_size < ip6hdr_off + info->full_hdr_len) {
+        return false;
+    }
 
     info->l4proto = ext_hdr.ip6r_nxt;
     return true;
-- 
2.47.3


