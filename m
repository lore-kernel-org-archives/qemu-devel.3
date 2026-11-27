Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C7F606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=u92Q4A0W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp50-0007LR-Gy; Fri, 27 Nov 2026 01:05:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2y-0004YN-Iq; Fri, 27 Nov 2026 01:03:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp2t-0003SV-P4; Fri, 27 Nov 2026 01:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=7ck7EAS/VJ5cMDOatQobGu59jKEMmUWswoc8ywLq23Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=u92Q4A0WmEsAVrSsNdGyjORVMf8ZCVtPXQizJkIrL2fmh83x8DLHf25pR1qvUWVcp
 zzsa9JWfRGDrxKiHbxjDtpqlXJkZvGQRJsfFOOzh2VhFmbI4nZ9DlnqJz0StCXGX5h
 N/K2MH/SiFmN9Eoyp3SCCC76zurTPNSdeIXIFEUYXIGYbMlv6kYWq6RoGuBakr/mAg
 D6dAk4gV/YExcmdZK9Q7zSi6nio5/aRzwakgZ4H4Rez8nxiADwsQBkKfCe15LXfOHz
 /0JL8UP2fH5poe+yS7Daxbn8Rk2sDxGrWOYMFqo5dHAyIiIfpk2CcoQfo+qWRJQHti
 S/kjeHmbejvGw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 709161EA336;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6E68A469962;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5C3E7CF2BC; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 069/152] net/eth.c: In eth_get_protocols(),
 don't report TCP data offset off end of packet
Date: Fri, 27 Nov 2026 08:53:27 +0300
Message-ID: <20261127055709.39630-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
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

eth_get_protocols() already rejects some out-of-bounds offsets found in
packets. Add a missing check for TCP data offset.

Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4155
Cc: qemu-stable@nongnu.org
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261109-eth-v2-4-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit c27a586b8bd8b75ac5781d84e84657f94c2d7599)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/eth.c b/net/eth.c
index 038f7d889c3..a444377fd0a 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -197,7 +197,8 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
         if (_eth_copy_chunk(input_size,
                             iov, iovcnt,
                             *l4hdr_off, sizeof(l4hdr_info->hdr.tcp),
-                            &l4hdr_info->hdr.tcp)) {
+                            &l4hdr_info->hdr.tcp) &&
+            input_size - *l4hdr_off >= TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp)) {
             l4hdr_info->proto = ETH_L4_HDR_PROTO_TCP;
             *l5hdr_off = *l4hdr_off +
                 TCP_HEADER_DATA_OFFSET(&l4hdr_info->hdr.tcp);
-- 
2.47.3


