Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70778606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=ZIPXf0+h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzY-00072D-Tv; Mon, 09 Nov 2026 00:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz9-0006u4-4U; Mon, 09 Nov 2026 00:32:07 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006Hj-Kv; Mon, 09 Nov 2026 00:32:02 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtO046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:34 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=HDyB3k49QBdp6HJd80F+Du0KGnlusvDnhj61+z8p8ww=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202294; v=1;
 b=ZIPXf0+hUGCaAFs9IFPr+RYHsYfKkf0MA3r+2Vl+5hlRra8nCjHNLYGgNGLyWq4v
 e6l0+9NysS8MzmjWayU/0gSxPicZvg48zgkWM9svw8SvHgMDJnmb27cvG3r0+vIa
 ycBGj7RmysTRc1taKIr9MzX6iN2MXw5eR+lm8TLfMAiz/iYTZY7POKmRiceDwpZS
 W9ydzuga8sfEh/Z0m0izNDB0DYI/k4/7fmAJvlhkd55PvLMMKePZl5CoL2ubOC9j
 gIOrVoZXUQV0tMJx1BTW/441nqWvipU4dk8JlOzTq9oLgBjeekRmo+zOSZDPO8TR
 RmwVVbVWGDztrUxf5VcumQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 00/14] net, hw/net: Validate header lengths and harden
 packet handling
Date: Mon, 09 Nov 2026 14:23:45 +0900
Message-Id: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/1WNywqDMBBFfyXM2oQ42odZ9T+KC5uMOhaMJFEq4
 r8X7arLC+ees0GkwBTBiA0CLRzZj2AEZgJs34wdSXZgBKDGq65QS0q91IhFWbWuwRtBJmAK1PL
 ntDzr347zayCbjutB9ByTD+uZWfKD+zcuucylc05fLGF5L4tHiJ2yrFjNMvn36lVj1TBBve/7F
 0ZXG9a1AAAA
X-Change-ID: 20260920-eth-022349fda27e
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3660;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=j1XxGO6Ont9FJX9nQETo7hrU7T4BXR2auJNGM/y5jJM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqJmbWIUYdizqi14QceRDKguX3YX2eVr26Y3v+ZtXa
 i+wvHK9o5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCLLDBj+cLGePld3XfbfcRfH
 9RY7mxR5EvYaTf7f+TGBee+q67Z1VowM+9lPBk2wu6KZl/R08Y9pRp/ND9p4/p2xOS/TfLm9imY
 xIwA=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Supersedes: <20261102201828.1879576-1-peter.maydell@linaro.org>
("[PATCH 00/11] net, hw/net: Harden common code against bogus offsets")

This 14-patch revision combines the IPv6 parser fixes from v1 with ten
patches from Peter Maydell's networking hardening series.

The series tightens L2, IPv4, TCP and SCTP header bounds checks. It also
corrects IPv6 Fragment and Authentication Header lengths and stops
parsing extension headers in noninitial fragments. The checksum and
segmentation changes guard against length underflows, invalid GSO sizes
and header-length overflow.

The Type 2 Routing Header length check is also moved into the RSS
destination address helper, alongside the Routing Type and Segments Left
checks.

The IPv4 and TCP bounds checks precede the IPv6 parser fixes, so that
correcting an IPv6 header offset does not expose an unchecked TCP data
offset to callers.

The IPv6 parser fixes replace Peter's separate IPv6 bounds-check patch.

Both this series and the igb patch series [1] have been stalled on the
mailing list for a while. Jason used to submit pull requests for
network patches like these, but he hasn't been active recently. Could
someone please pick these up?

[1] https://lore.kernel.org/qemu-devel/20260623-igb-trl-v8-0-c9b1fc6c3304@google.com/

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Changes in v2:
- Split the IPv4 and TCP bounds checks from the IPv6 parser fixes.
- Add L2 offset and header-length bounds checks.
- Adopt Peter's IPv4 checks, including the minimum header length, and
  use subtraction for the IPv4 and TCP bounds checks.
- Incorporate Peter's related parser, checksum and segmentation
  hardening patches, correcting the SCTP header-presence condition.
- Move the Type 2 Routing Header length check into the RSS destination
  address helper, alongside the Routing Type and Segments Left checks.
- Add comments explaining the Fragment and Authentication Header length
  rules and why parsing stops at noninitial fragments.
- Link to v1: https://lore.kernel.org/qemu-devel/20260920-eth-v1-1-ddd05ce24843@rsg.ci.i.u-tokyo.ac.jp

---
Akihiko Odaki (4):
      net/eth.c: Check for undersized L2 headers in eth_get_protocols()
      net/eth.c: In eth_get_protocols(), don't report TCP data offset off end of packet
      net/eth.c: In eth_parse_ipv6_hdr(), fix check of input size
      net/eth.c: Move the Routing Header Hdr Ext Len check

Peter Maydell (10):
      hw/net/net_rx_pkt: Handle bogus l4hdr_off when validating SCTP checksum
      net/eth.c: Check for undersized IPv4 headers in eth_get_protocols()
      net/eth.c: In eth_get_protocols(), don't report SCTP header off end of packet
      net/eth.c: Harden _eth_tcp_has_data() against short lengths
      net/eth.c: Tighten size checks in eth_get_l3_proto()
      include/net/eth.h: Make eth_get_l2_hdr_length_iov() check protocol
      hw/net/net_tx_pkt: Sanity check GSO headers in net_tx_pkt_build_vheader()
      hw/net/net_tx_pkt: Sanity check virt hdr len in net_tx_tcp_fragment_init
      hw/net/net_tx_pkt: Sanity check L2+L3 header len in net_tx_pkt_parse_headers()
      hw/net/net_rx_pkt: Check for overflow in _net_rx_pkt_calc_l4_csum()

 include/net/eth.h   |   4 +-
 hw/net/net_rx_pkt.c |  22 +++++----
 hw/net/net_tx_pkt.c |  20 ++++++++-
 net/eth.c           | 125 ++++++++++++++++++++++++++++++++++++++++++----------
 4 files changed, 137 insertions(+), 34 deletions(-)
---
base-commit: 74f7bf4c59e6b6d50dbc6e124d93440be8be4386
change-id: 20260920-eth-022349fda27e

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


