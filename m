Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514C4CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwqo-0004W2-OV; Fri, 29 May 2026 09:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wSvfi-0001Nq-5F
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:46:38 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wSvff-0007qi-96
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:46:37 -0400
DKIM-Signature: a=rsa-sha256; bh=HoYjQMioxlAGOACGmSx2CWxi4LDr+wY7Wb1jlqsGtq8=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1780055188; v=1;
 b=mMCILNdUoI2RjefkATVCYCz43YeTZjuke5ME//1OpjHapwEiQs8Xc7tBgPqo/9nb5MVWLhUW
 cijXOxOUHKKUwe8gTtPpQBrepMxVQwdAsGexPhg4fzRAGgfQ4dV5oUUK5GiPjC0ZZ5M3xzAzZWs
 3jk6SmmKKl5lju8i/iREOeuqU61FTUrikV0gw3pNnrZ1xxaZfU1IRRiky/jAPvByixTgi+G+ZHg
 uTdquZfk/hB5yQD+Mt4s+CUEoiculGpeUVcpTFzU98KvTPT5hZXRAyb9jLX6D943ljUIx0nQRS6
 IVZ+rLAXstyu/G0qZPHEpWhQhs2e/BXwZL9L5bONuNrKg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id D13E4211B3;
 Fri, 29 May 2026 11:46:28 +0000 (UTC)
From: ~ziyi_fu <ziyi_fu@git.sr.ht>
Date: Thu, 28 May 2026 15:42:55 +0200
Subject: [PATCH qemu] hw/usb: record async control completion for parameter
 transfers
MIME-Version: 1.0
Message-ID: <178005518883.3620.4401726215216550971-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Sergei Heifetz <heifetz@yandex-team.com>,
 BU Embedded <bu-embedded@cyberus-technology.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 29 May 2026 09:02:08 -0400
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
Reply-To: ~ziyi_fu <ziyi.fu@cyberus-technology.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ziyi Fu <ziyi.fu@cyberus-technology.de>

Record the completion side of parameter-based control transfers when they
complete asynchronously. This lets pcap captures include descriptor
response data for requests such as GET_DESCRIPTOR from usb-host devices.

The synchronous path already recorded the completion, but the async
SETUP_STATE_PARAM path was missing it.

Signed-off-by: Ziyi Fu <ziyi.fu@cyberus-technology.de>
---
Tested with a usb-host HID keyboard on qemu-xhci. Before this change,
the generated pcap contained GET_DESCRIPTOR submissions but not the
corresponding completion payloads. After this change, the pcap contains
the descriptor payloads and Wireshark can associate endpoint 0x81 with
the HID interface.

 hw/usb/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index 9572a870cc..d71204c5c8 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -345,6 +345,7 @@ void usb_generic_async_ctrl_complete(USBDevice *s, USBPac=
ket *p)
             p->actual_length =3D 0;
             usb_packet_copy(p, s->data_buf, s->setup_len);
         }
+        usb_pcap_ctrl(p, false);
         break;
=20
     default:
--=20
2.49.1

