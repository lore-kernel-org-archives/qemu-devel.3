Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72EE606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=KOvBcO1Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzW-00070k-Jl; Mon, 09 Nov 2026 00:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzA-0006uD-Jz; Mon, 09 Nov 2026 00:32:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006Hy-Ma; Mon, 09 Nov 2026 00:32:03 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtU046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2YZ5lsUQbliaXH9gSRAgRrIfi5uICm2+yllFRphNaD0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202295; v=1;
 b=KOvBcO1YvcB6GaTay4FCPsUPleOWAOVqAIUgFsik9VOLjahn+Su2YE9enbRRprwO
 QDT9deuA0KNoaDZbadEfjKVgzRBqDYceA4RS0gNQyqtB4Z5JNAgfsvIKJIOmspJB
 DQjoLxl5cOH5wnPGctnmYVD/63YfvSqP3RGjMS73kNzUSMDPfNbGIVOG0iHsn/Rp
 kz6tZuFj4rvQ50Ur0+XKqlHL5g64AtFIzW6SrlWSq01FFpkRDwDMNQHEO8vpiVxh
 C5paC9HqndoFc4DYQCx0nA6pWTOm4lRj/Ses0zqLYK61gnA4gujZv82df2hBfict
 Z2nKr+sQGHBXk6XaC/iJ2w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:51 +0900
Subject: [PATCH v2 06/14] net/eth.c: In eth_parse_ipv6_hdr(), fix check of
 input size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-6-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org,
 Lazymio <mio@lazym.io>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5849;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=5o0B0rhTWpkt2UipV4PHIfwO3xnoQvhtLsHZm/dsLuc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqMV8Ow7cW/o+IZWhxzCrRnDGhyO9D456RdxbmDB/m
 qjL1g7RjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIks+s/wzz7vYeOPsLA3Oec3
 KlT9Zc+5wHi6sT/O81/JyWNudvfvPGRk+He79JPDTN/1u85+lRCdt9xIYeHDk9fXmV/p4e1z0r9
 ymxEA
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
---
 net/eth.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/net/eth.c b/net/eth.c
index 55d85cecd1d6..ba0e964b97b8 100644
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
+             * A subsequenet fragment contains no extension headers while the
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
2.56.0


