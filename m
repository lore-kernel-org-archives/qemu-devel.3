Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9071FC982DA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 10:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8F9G-0007Kl-7i; Sun, 20 Sep 2026 06:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x8F9D-0007KM-Aa; Sun, 20 Sep 2026 06:51:51 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x8F99-0008L7-I5; Sun, 20 Sep 2026 06:51:50 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68KApAii096270
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 20 Sep 2026 19:51:32 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NhBDs/uPg1cu8Czy08WkRZ35uPuDx9lgK2puUnlGdXE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789901492; v=1;
 b=lOm7pmYMDayufBLcA+EYxdrD159Q5zgXsHbkKE+5I4Cl58nZl0w6asLm/8NdU3Z1
 NxvIAGwAXupaNLxYpPMhB9+nEpKEIWEwaAs8mhbdm60vh62qa/CX9vWhR8OJAn94
 Wj9SuaafJKNsRajCsG0wTzH/GhzeqrdlgDw4DuafQ3QcyrYMDZ7vFUsjqts8NOl9
 XOcWlDUS+HPgVWMxohHMZHvmHuUiu5E/qtuhXTrlLT5klwpmpWtFei5MSw3+wXSH
 r5zRcazBOzkFOcnaso8Ih1LPp/M5n6Glx0h+/X8J3nyUHhjizmMa93soZVkkp9s3
 JXGFuf/tuFz34TUBVhtFGQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 20 Sep 2026 19:51:00 +0900
Subject: [PATCH] net/eth: Add missing L4/L5 header bound checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMD3dSSDF0DIyNjE8u0lEQj81QloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AHzrZF2cAAAA=
X-Change-ID: 20260920-eth-022349fda27e
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-stable@nongnu.org,
 Lazymio <mio@lazym.io>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6274;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=TJ7W9zbaA+RkHrQK94QOkKSm5ZgtVZrY89wbJliTYJg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b6XTPduPlsFezFMg+obTFO9vWuFDMz3LyoKG3mbYepV
 +Ye2OncUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBHvv4wMX6ZnVx1Zet5yllJn
 nrdKks2zmKUtJ/8eurNV3v4mv4XKXYa/cs/Vv15NZp6lrCbXf1SO63/Ih5/FxeZ+O6p8ONNuPlv
 OBgA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We already have some L4/L5 header bound checks but they were not
comprehensive. Add the missing coverage.

The IPv6 header parser incorrectly derives L4 offsets greater than
actual values. Adding a bound check without fixing it would reject
valid packets while fixing it without adding a bound check can result
in an out-of-bounds access, so fix it along with the bound check
addition.

One fixed problem of the IPv6 header parser is that extension header
size is not properly computed for the Fragment Header and the IP
Authentication Header.

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
---
 net/eth.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 12ec316e240e..96d3f871f4bc 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "net/eth.h"
 #include "net/checksum.h"
@@ -156,7 +157,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
 
         copied = iov_to_buf(iov, iovcnt, *l3hdr_off, iphdr, sizeof(*iphdr));
         if (copied < sizeof(*iphdr) ||
-            IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4) {
+            IP_HEADER_VERSION(iphdr) != IP_HEADER_VERSION_4 ||
+            *l3hdr_off + IP_HDR_GET_LEN(iphdr) > input_size) {
             return;
         }
 
@@ -188,7 +190,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
         if (_eth_copy_chunk(input_size,
                             iov, iovcnt,
                             *l4hdr_off, sizeof(l4hdr_info->hdr.tcp),
-                            &l4hdr_info->hdr.tcp)) {
+                            &l4hdr_info->hdr.tcp) &&
+            *l4hdr_off + TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp) <= input_size) {
             l4hdr_info->proto = ETH_L4_HDR_PROTO_TCP;
             *l5hdr_off = *l4hdr_off +
                 TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp);
@@ -456,7 +459,9 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
     struct ip6_ext_hdr ext_hdr;
     size_t bytes_read;
     uint8_t curr_ext_hdr_type;
+    uint16_t buf;
     size_t input_size = iov_size(pkt, pkt_frags);
+    bool subsequent = false;
 
     info->rss_ex_dst_valid = false;
     info->rss_ex_src_valid = false;
@@ -496,25 +501,53 @@ bool eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
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
+            info->full_hdr_len += 8;
             info->fragment = true;
+            subsequent = extract16(be16_to_cpu(buf), 3, 13);
+            break;
+
+        case IP6_AUTHENTICATION:
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

---
base-commit: 28e7aad52202c7e6210e0e05d4f60360aaf8d027
change-id: 20260920-eth-022349fda27e

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


