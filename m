Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D008ECA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGrT-0007Vh-6s; Thu, 01 Oct 2026 09:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrM-0007Rs-Sd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGrK-00061N-69
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qL159fZtKp7u06YGG825uhx3tm+W5SLrbiiIFzQwURU=;
 b=GrR6Ux+Z9xbBhMIDNrLFgCExriznDOMK7LBhvwp6zAslPp19FkKMb0nB1Kq5U8bedFw4Gu
 rMGU8Jri43xDk4JyOjeogGSapNDPvzY0Vd930C0xMLIQEWA+qn2RSaaXynPIJ/WqIL/DlX
 eXhph0gPn+xmgNvgBXM6Xg0/7SH7rlQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-3ah_9hiGN9OmPKlPl8V4og-1; Thu,
 01 Oct 2026 09:29:59 -0400
X-MC-Unique: 3ah_9hiGN9OmPKlPl8V4og-1
X-Mimecast-MFC-AGG-ID: 3ah_9hiGN9OmPKlPl8V4og_1790861398
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 831EE19772EA; Thu,  1 Oct 2026 13:29:58 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B990146E; Thu,  1 Oct 2026 13:29:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:42 +0400
Subject: [GIT PULL 03/27] hw/usb/dev-smartcard-reader: fix assert on
 pending answers overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-3-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=oqfQZyWAvu53wFDKF++P6kpwZhpc4SiPNvpqAl1WC7s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBHMw/uQxgMcnsHeVEpUn9vnVWh0RM/rkdmm
 BuDWL7/z9eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gRwAKCRDa6OEJdZac
 5QBCEAClA05WQdzXqb6osqMmF3gSEtm/kxo5AOj8yeK5dQMyHxgOq3PIE5sYl/3Khty34gIV9Im
 g5zpd9V8xv+CRNy0FCJSEsxkwD0ecNSvOIsE3hYfG1hXGybSVTIs839H59aLyhojI1evAG3geFo
 ig90V0jNiqv3YYJX3JC8TCm05Kn83wFrVo0ZKBDRXn8LCV26R3Lcw2SjpM66pZPTkNs1nsSZAL4
 qvXqQA579eNzyUQAkyCOXZcjjU0nmu/gutOA7Hr2ddBsYECeWSYRtA7FhuEbIDFY8R+anzZprB+
 bf1+9VQg4uOkXPJpI63gC1yynaeLCXSl8MZiJlV22U3QR4HT6t+EXsKLbh7mb2ekACUZg8A9h6z
 578HjXbSFVXgP73cTyCgA9wmcy8C5Zez1web9/2Ns0Q3pmNUneob2wBDq7M9NyDU579RZOZcoSe
 vm5dZaQUGsXJe8m0w4lB+kxI184omhkV88VFmQ5n1R0wN/4mcLbZTxYyztm5JQj4IZQSrE2OvYA
 BHMg81B4sH8U6/sG2Hbs308ezAvEeCvUxsU49fIb9K6xPceqv3zq/2tG/aCmWuKWPYl9OBIsyxp
 8nGdigRujw3cyC53uef1FLzJHzTF8nBUxnAW358FCR30fRpon+gJVXmvIrERdBFIMsc/dRXwIrX
 6I8eirbb1lLMUFw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A guest can send PC_to_RDR_XfrBlock USB messages faster than the async
card backend can process them. When the pending_answers ring buffer
(128 entries) fills, ccid_add_pending_answer() hits an assert() and
crashes QEMU.

The CCID spec (section 4) states that a slot can only accept one
command at a time. A second command to a busy slot must be rejected
with CMD_SLOT_BUSY (section 6.2.6).

Enforce this by checking pending_answers_num before queuing a new
APDU. When the slot is already busy, report ERROR_CMD_SLOT_BUSY and
send a DataBlock error response back to the guest.

Fixes: CVE-2026-18410
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3997
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/usb/dev-smartcard-reader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index aee966c0c92d..9cbacf08e77d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -166,6 +166,7 @@ enum {
     ERROR_XFR_PARITY_ERROR  = -3,
     ERROR_XFR_OVERRUN       = -4,
     ERROR_HW_ERROR          = -5,
+    ERROR_CMD_SLOT_BUSY     = -32,
 };
 
 /* 6.2.6 RDR_to_PC_SlotStatus definitions */
@@ -949,6 +950,13 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
         ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
         return;
     }
+    if (s->pending_answers_num > 0) {
+        DPRINTF(s, D_WARN,
+                "usb-ccid: slot already busy, rejecting apdu\n");
+        ccid_report_error_failed(s, ERROR_CMD_SLOT_BUSY);
+        ccid_write_data_block_error(s, recv->hdr.bSlot, recv->hdr.bSeq);
+        return;
+    }
     len = le32_to_cpu(recv->hdr.dwLength);
     DPRINTF(s, 1, "%s: seq %d, len %u\n", __func__,
                 recv->hdr.bSeq, len);

-- 
2.56.0.rc0.29.g47ce80527c56


