Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D68606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=hz3N2mGX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLDU-0001y5-2j; Mon, 26 Oct 2026 09:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLDG-0001IM-Tc; Mon, 26 Oct 2026 09:58:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLDD-0000T5-1M; Mon, 26 Oct 2026 09:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022944; bh=xhlM+mDfSIgRwzNvquW9TmbSe9+AcpM+5pw3HwfgrYk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hz3N2mGXVglMKd4DCmSvwQdX2UqaZHaIo146OmddmVUrazFg3eUrJJoy6w0ndZiAW
 DgF/mjkaQIA/KeOpN48hUdyEeopr6i4qrl5NrPL+FykOucDqXHc/6iweywdIRuBrKK
 zlt9MeG2fiMnpKuITeptaJwhhsi9ra6hcmyGlcs8CiMBaulAOY2jJRmaZyvUGVLLH4
 wYMi7Z4efCGW7A3brEVv1CYZPZmcPsGXm/fq0b/rPnG9P9JmwLu71kGR/3gbyavO+3
 V1rE4JjjwOtpEfcj4RDHxwSf5QfsbO3a9xbrqLgtTE2PUPTmdHPW4TerSWnLDTYj80
 8Kan32mlTIi+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 19CDA1E12A2;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 17D4B44B8F3;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 001BF934CB; Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tommaso Califano <tcalifano@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, Luigi Leonardi <leonardi@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 85/98] hw/usb/dev-mtp: Fix assert crash on
 undersized BULK IN
Date: Mon, 26 Oct 2026 16:55:12 +0300
Message-ID: <20261026135529.1019772-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
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

From: Tommaso Califano <tcalifano@redhat.com>

The EP_DATA_IN result path serializes the queued response as a 12
byte MTP container header followed by one 4 byte word per result
argument (12 + 4 * argc bytes).  The entry check at the top of the
function only verifies that the guest-provided transfer buffer holds
at least the 12 byte header.

If the queued result carries arguments, e.g. RES_SESSION_ALREADY_OPEN
which returns the existing session ID, the second usb_packet_copy()
writes past the end of the guest-declared buffer and trips the
p->actual_length + bytes <= iov->size assertion, aborting QEMU.  A
guest can control the transfer size freely, e.g. TBYTES in the qTD
of an EHCI BULK IN.

A device must not send more data than the initiator signaled it would
accept. Stall the transfer instead, and keep the result queued so that
a subsequent BULK IN with a sufficient buffer size delivers the full
response.

Fixes: 840a178c94db ("usb: mtp filesharing")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3386
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20261012140839.93559-1-tcalifano@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit b17205f23a9a8661394d30148b2c995ffa932019)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index c2d36a73cf9..cbc2be3317f 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1905,6 +1905,13 @@ static void usb_mtp_handle_data(USBDevice *dev, USBPacket *p)
         } else if (s->result != NULL) {
             MTPControl *r = s->result;
             int length = sizeof(container) + r->argc * sizeof(uint32_t);
+
+            if (p->iov.size < length) {
+                trace_usb_mtp_stall(s->dev.addr,
+                                    "packet too small to send response");
+                p->status = USB_RET_STALL;
+                return;
+            }
             if (r->code == RES_OK) {
                 trace_usb_mtp_success(s->dev.addr, r->trans,
                                       (r->argc > 0) ? r->argv[0] : 0,
-- 
2.47.3


