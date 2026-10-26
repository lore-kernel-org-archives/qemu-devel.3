Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60322606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=unq20bO6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLAy-0005gW-Va; Mon, 26 Oct 2026 09:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAx-0005eu-C1; Mon, 26 Oct 2026 09:55:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAv-00009c-Oc; Mon, 26 Oct 2026 09:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=YM7/rTNDFRnZ79loc6Sdl7pcpB9WC71ZG/zasFGF2Tg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=unq20bO6WJ5x3AXYJhpsBdvH7arz/PqcI1E/ZJP6cidR3eYqvLeS7YZqGjzXRxx1+
 ajgpSnE++dZ2tec9Hb0z7krXeBvDZ/idxmDI+HwvXMwC15W6fJOH+2z7/+UAu58E6n
 TBSTdgv7ejCoBhXvbUyXeYK1PiLOBNHiJUFX7cWCzAfYGq3pvIGw9l5DKJWSa5Krih
 hM+z2NzhUsULFEC8oLqeF8+q3yo4i2ls3GU3JCWj3bbXZ9CcJ31sUAwbMAl+nBaTUC
 eC1DvlWP3ehH/whKKedyJ7Csc+GqYUrQR+qe/9UuhUgoPmq/9E885LnAFzeO1CFnzd
 BSplveCaWv2cg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC56B1E1283;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B71E244B8CF;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9D78693495; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 77/91] hw/usb/hcd-ohci: Assert isochronous TDs are
 never deferred
Date: Mon, 26 Oct 2026 16:54:20 +0300
Message-ID: <20261026135441.1019505-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 7b1eba96aecac32d186d4c16b81c7b4681186844)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 2974819a2da..9ec9d8a462e 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -747,11 +747,10 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     usb_packet_setup(pkt, pid, ep, 0, addr, false, int_req);
     usb_packet_addbuf(pkt, buf, len);
     usb_handle_packet(dev, pkt);
-    if (pkt->status == USB_RET_ASYNC) {
-        usb_device_flush_ep_queue(dev, ep);
-        g_free(pkt);
-        return 1;
-    }
+
+    /* The USB core guarantees to never defer ISO TDs. */
+    assert(pkt->status != USB_RET_ASYNC);
+
     if (pkt->status == USB_RET_SUCCESS) {
         ret = pkt->actual_length;
     } else {
-- 
2.47.3


