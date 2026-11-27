Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EF606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=otS5DYgk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp0n-0001r6-3R; Fri, 27 Nov 2026 01:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0O-0001Ld-EY; Fri, 27 Nov 2026 01:00:22 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp0K-0006UP-Hj; Fri, 27 Nov 2026 01:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758881; bh=UmCKgOQ6+97tAOK7eVCrzV2sYq3Hsqo8A9O9LwjdbsY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=otS5DYgkHO8HUiVLrReaiCaqzSGyPqVYcbsv3iEIW5HcJFkTsIyk39Ba4ehS6q0uL
 yQk0Uea58/1RKNDEyS2S0Tz/iuTlTefz1kjBIUce28lULfjHsGov7tRL8Z+E/xDFLB
 DUSZnSqJnpZfMmwqPUxOBuRzItCDXjUe6AjDulftDR8cgbdNQaBabryX/LDyPVP4e+
 4aSoWrgg1kuFF6nPM78AfV+TFQNRt4TW2xbgumeihrcOX8JaAVmz+fpPnubO4OLgh8
 5MFEOFUEnRdoEee2pl2GaJKBTx2tPzbx/d5mlTk8E6Vp7nNR8n8031wmMlQSSHPf9c
 FpyLn6FkeWDuA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 883E81EA303;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 85E4646993D;
 Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8005ACF286; Fri, 27 Nov 2026 08:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 120/140] net/checksum: Correct handling of
 checksums when IP options present
Date: Fri, 27 Nov 2026 08:53:46 +0300
Message-ID: <20261127055421.39015-61-mjt@tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In net_checksum_calculate() we calculate the position of the TCP or
UDP header in the buffer with:
  tcp_header *tcp = (tcp_header *)(ip + 1);
where ip is a 'struct ip_header' (and similarly for udp).

This only gives the correct location if the IP packet has no options
and its header is the minimum length.  Otherwise we will corrupt some
part of the packet in writing the checksum word.

Fortunately packets with IP options are rare (and often get blocked
by routers or firewalls), so this probably didn't often cause
problems, and the incorrect offset we write to is always inside the
packet, not out-of-bounds.

Use the IP header length value from the packet to locate the TCP or
UDP header, instead of the fixed minimum size.  While we're adjusting
this code, make sure that we don't assign to the tcp_header or
udp_header pointer until after we've made the length check that the
buffer is big enough (the previous ordering of operations was
harmless as we never used the resulting pointer, but not ideal).

This was mentioned in passing in issue #4791 (which is otherwise
a duplicate of #4720).

Cc: qemu-stable@nongnu.org
Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
Reported-by: Alex Meiburg <https://gitlab.com/timeroot.alex>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261114132350.1456994-3-peter.maydell@linaro.org
(cherry picked from commit 811ec415a63c89a88f4ae5c6d24d2128df66abd8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/checksum.c b/net/checksum.c
index 9e4ba1bc910..d6925e9a496 100644
--- a/net/checksum.c
+++ b/net/checksum.c
@@ -62,6 +62,7 @@ void net_checksum_calculate(void *data, size_t length, int csum_flag)
     unsigned int mac_hdr_len, ip_len, ip_hdr_len;
     struct ip_header *ip;
     uint16_t csum;
+    void *ip_payload;
 
     /*
      * Note: We cannot assume "data" is aligned, so the all code uses
@@ -140,20 +141,23 @@ void net_checksum_calculate(void *data, size_t length, int csum_flag)
     }
 
     ip_len -= ip_hdr_len;
+    ip_payload = (uint8_t *)ip + ip_hdr_len;
 
     switch (ip->ip_p) {
     case IP_PROTO_TCP:
     {
+        tcp_header *tcp;
+
         if (!(csum_flag & CSUM_TCP)) {
             return;
         }
 
-        tcp_header *tcp = (tcp_header *)(ip + 1);
-
         if (ip_len < sizeof(tcp_header)) {
             return;
         }
 
+        tcp = ip_payload;
+
         /* Set csum to 0 */
         stw_he_p(&tcp->th_sum, 0);
 
@@ -168,16 +172,18 @@ void net_checksum_calculate(void *data, size_t length, int csum_flag)
     }
     case IP_PROTO_UDP:
     {
+        udp_header *udp;
+
         if (!(csum_flag & CSUM_UDP)) {
             return;
         }
 
-        udp_header *udp = (udp_header *)(ip + 1);
-
         if (ip_len < sizeof(udp_header)) {
             return;
         }
 
+        udp = ip_payload;
+
         /* Set csum to 0 */
         stw_he_p(&udp->uh_sum, 0);
 
-- 
2.47.3


