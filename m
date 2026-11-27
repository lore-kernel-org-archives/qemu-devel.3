Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9B606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=sJ8YbBS1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp5S-0007v5-GI; Fri, 27 Nov 2026 01:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp32-0004aU-EN; Fri, 27 Nov 2026 01:03:05 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp30-0003TU-3k; Fri, 27 Nov 2026 01:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=vJ+dM56NxJFBanapO1cyw/6lUXjU1ZDeOc7MoOQ7i18=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sJ8YbBS17GkcYg26ZTPPDGN79flrpLJQEsw+bpVp1XyJcMRPAioMCaCIqFzi/1xVR
 zBKAz0+bWuk1QHaST+h1+rY4vcV2PRqJfzB6kRCCWGujtzdbk8RPgHDFubB/BmZrPO
 HXZZfRM664aGkVqMx3IZq4tn+4+Qvr/p55MNmvpgZF60OSMY1Jm8z8Z3QUOz7ofBRQ
 pnrLMyoiAiE1x9+On7gDYHk5mu+w3PU4VNT8LTCWjLAV01mSJY+jn/E1Mvrkd9IoBY
 7xei+QrwpqanEjPX/9wCcYF0KvE90m8HfFaTMT7FLnOFn/Mj0ma4aD6I6/NbKr3BIK
 evR2U90R8k33w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 750311EA337;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 72E96469963;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5F38ECF2BE; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 070/152] net/eth.c: In eth_get_protocols(),
 don't report SCTP header off end of packet
Date: Fri, 27 Nov 2026 08:53:28 +0300
Message-ID: <20261127055709.39630-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Message-id: 20261109-eth-v2-5-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
[Reversed the condition and changed it to use input_size - *l4hdr_off]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit a80bcdb2ada5c1d701fdb587dcaf77f1194a6ffd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/net/eth.h b/include/net/eth.h
index 46dc9ed5acd..e10684ed923 100644
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
index a444377fd0a..55d85cecd1d 100644
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
2.47.3


