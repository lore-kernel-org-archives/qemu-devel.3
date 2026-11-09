Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA4606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=INupjwy8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzh-00075i-Dw; Mon, 09 Nov 2026 00:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzA-0006uE-WA; Mon, 09 Nov 2026 00:32:15 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHz4-0006HR-Mf; Mon, 09 Nov 2026 00:32:03 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtT046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=nS68T1K5GUo+z5Wjd++UxQEFBoXWihDWYIw4jTHswF8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202295; v=1;
 b=INupjwy8cJfbcV5P+coDWeiSIvXTPX5FI8b0S9SKZQggsvZ+z8mscAL/wZiB6Ezr
 U6URNaWvu3Qp8/RqLBhHgBt8MISTcq1YpzkBmqhRAQ/W9P5uyQRFQAPsgixeUrWh
 LHNTidAp4Jyp11U4ROkybO332CjNWvxtp3npuEdbruhuoN8AkiDxGDGmehnlfO7K
 Fsij6gRIdmc7aGCKH35GqhzTf95yVJERgX9J8GwKEIO9LasHgEzttrTzdEHo+5fS
 oSKY51LL5ac210/O8DGI5U2fQ/Z6nPCGsZpCgURDz8JqbIE9zFyvFCUekItD9NJZ
 gIf7RAC52jO8qPDicN2Jdw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:50 +0900
Subject: [PATCH v2 05/14] net/eth.c: In eth_get_protocols(), don't report
 SCTP header off end of packet
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261109-eth-v2-5-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=GCsYSzzEBAWyDhzuwEVw27E2a4WMsyhsSjArDIzihX0=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqMXn5R6tOxS15ihfTvyDvMhjvy8ejK4Mk/9epugmv
 Ohm6qnjHaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABMJfcbwV8QxU3rxr5zA21qi
 K07dsT6//fWlNwELziue0DmfYeNb+pzhn8LmPC1rD+uQmxKduiJRDWfz9WeurovvSz7yaomtZfh
 JDgA=
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

From: Peter Maydell <peter.maydell@linaro.org>

eth_get_protocols() parses an ethernet packet and tells the caller
about various offsets into it and other properties of the packet.
For the L4 protocol, in both the IP_PROTO_TCP and IP_PROTO_UDP
branches we implicitly check that the packet does contain a whole TCP
or UDP header at the l4hdr_off offset, because _eth_copy_chunk() will
fail if the input packet size isn't big enough for the whole header
we are copying out of it.  But for IP_PROTO_SCTP we don't copy the
SCTP common header.  In this case we should still do the length
check, so we don't set l4hdr_info->proto to say there's an SCTP
header present when there isn't.

This shouldn't have any visible effects if the downstream consumers
of the l4hdr_info are conservative about checking before they access
into the packet, but checking here too adds defence in depth, hence
the cc to stable.

Cc: qemu-stable@nongnu.org
Fixes: 907209e3111d ("igb: Implement Rx SCTP CSO")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
[Reversed the condition and changed it to use input_size - *l4hdr_off]
---
 include/net/eth.h | 2 ++
 net/eth.c         | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 46dc9ed5acd9..e10684ed9234 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -394,6 +394,8 @@ typedef struct eth_l4_hdr_info_st {
     bool has_tcp_data;
 } eth_l4_hdr_info;
 
+#define SCTP_COMMON_HEADER_LEN 12
+
 void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
                        bool *hasip4, bool *hasip6,
                        size_t *l3hdr_off,
diff --git a/net/eth.c b/net/eth.c
index a444377fd0ae..55d85cecd1d6 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -223,7 +223,14 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
         break;
 
     case IP_PROTO_SCTP:
-        l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
+        /*
+         * We don't copy the SCTP common header into l4hdr_info, but
+         * don't report SCTP as present if the packet isn't big enough
+         * to actually have an SCTP header.
+         */
+        if (input_size - *l4hdr_off >= SCTP_COMMON_HEADER_LEN) {
+            l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
+        }
         break;
     }
 }

-- 
2.56.0


