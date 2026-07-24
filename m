Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D14C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCVw-0003Jh-Uq; Fri, 24 Jul 2026 05:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVu-0003Ie-Qz; Fri, 24 Jul 2026 05:48:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVt-00059x-9s; Fri, 24 Jul 2026 05:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784886463; bh=7yxIdw9pIhOAMkkgE7ZM1Jdt4fCXj6Y2Rbh5xcT6uyI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jm3XILG0O4kOq/FVDS8bLkepz1GWC6lwnbKA8zI7vx/CSMLx0nVlN3jVG1fD8n1hs
 qSB2PJgMa34qotQMkF0esnPVO1TFJuFd0Zb7NxZB8ITy/ZTsKKUdAqja9PRVKG/A5I
 MpyyU3CcMRU5pPQRqXeov1HxlcFJW5ORuN86mMUPTal2XeHo+ba24J2AsdC+wDOPJ7
 KyXSOOoby4gO8UTm9Te3FxKvQoyfnBcPbdyb7enPX9Un1dCG9M0Rv/+vqWsbFWnscv
 KEjJdoFGvrDlgCcm3PO9oMoPrOZ94bjOaIRX5EHqdDjdXIGeeTaY9/G5oTvBI5nelQ
 HyisIPHELdh4w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B5A51C4577;
 Fri, 24 Jul 2026 12:47:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 664A93F46B6;
 Fri, 24 Jul 2026 12:48:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4E28F1854C; Fri, 24 Jul 2026 12:47:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Ziyi Fu <ziyi.fu@cyberus-technology.de>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/7] hw/usb: record async control completion for parameter
 transfers
Date: Fri, 24 Jul 2026 12:47:48 +0300
Message-ID: <20260724094754.1053970-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724094754.1053970-1-mjt@tls.msk.ru>
References: <20260724094754.1053970-1-mjt@tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ziyi Fu <ziyi.fu@cyberus-technology.de>

Record the completion side of parameter-based control transfers when they
complete asynchronously. This lets pcap captures include descriptor
response data for requests such as GET_DESCRIPTOR from usb-host devices.

The synchronous path already recorded the completion, but the async
SETUP_STATE_PARAM path was missing it.

Signed-off-by: Ziyi Fu <ziyi.fu@cyberus-technology.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Fixes: 0f6dba145a4b ("usb: add pcap support.")
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 9572a870cc0..d71204c5c80 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -345,6 +345,7 @@ void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p)
             p->actual_length = 0;
             usb_packet_copy(p, s->data_buf, s->setup_len);
         }
+        usb_pcap_ctrl(p, false);
         break;
 
     default:
-- 
2.47.3


