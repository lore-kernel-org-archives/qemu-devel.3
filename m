Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E041606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=TiVqvVEp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp5m-0000cG-LB; Fri, 27 Nov 2026 01:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3U-0005Ue-V7; Fri, 27 Nov 2026 01:03:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3S-0003Wr-Ui; Fri, 27 Nov 2026 01:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=6W3E54SAsdBGnFD8Hi3y2usG+4Q7d+BCA8Su+8HRgSE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TiVqvVEp0KMDabCS/ZGbmYf7htOetTO0iS0vbHFUjwEMIYkHbJDaoNf/OrROd6IoN
 BT838rrOeTP9KtOClERsIUePAyhuJRhM6OH5J17DlilFSOA5u0+eOyEG8UuDdC8Bkt
 tQ08IMq84CPiZyhue7svpD2XxqZz9iznApr0CX5m26zWDZdC24n50KLp88xeCfo0x9
 JnWHv4AmX+QHfsIl9YcpWgMU9oOyQAHnBbnqY8JvaQnawEkwgnw5fXqDR+j7N5v3XX
 a8oPxaj2eYe18rUuWPVI84kSOVb1iyIp4sSyDsgToEbyJK1O576mQ73GZZjen3vKOF
 +jqR7d3IxrLfw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8CCD61EA33C;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8AC94469968;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6DDF2CF2C8; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 075/152] include/net/eth.h: Make
 eth_get_l2_hdr_length_iov() check protocol
Date: Fri, 27 Nov 2026 08:53:33 +0300
Message-ID: <20261127055709.39630-12-mjt@tls.msk.ru>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In eth_get_l2_hdr_length() we return sizeof(eth_header) for
any protocol other than VLAN or DVLAN. However, in the iov
version of this function, if the packet is larger than
the ethernet header but not large enough for both the eth_header
and the vlan_header we'll end up returning the actual packet
size rather than the eth_header size. Fix the "not enough
data" return case.

This will only cause issues if the caller isn't already checking
offsets and sizes, so this is defence-in-depth.  It also in theory
corrects the result for the hypothetical case of an ethernet-level
protocol that allows a payload of less than 4 bytes.

Cc: qemu-stable@nongnu.org
Fixes: eb700029c783 ("net_pkt: Extend packet abstraction as required by e1000e functionality")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-10-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 5251fee208ac4981dc5ac2e4438ed38955fdad43)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/net/eth.h b/include/net/eth.h
index e10684ed923..3e83f5d68c0 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -321,7 +321,7 @@ eth_get_l2_hdr_length_iov(const struct iovec *iov, size_t iovcnt, size_t iovoff)
     size_t copied = iov_to_buf(iov, iovcnt, iovoff, p, ARRAY_SIZE(p));
 
     if (copied < ARRAY_SIZE(p)) {
-        return copied;
+        return MIN(copied, sizeof(struct eth_header));
     }
 
     return eth_get_l2_hdr_length(p);
-- 
2.47.3


