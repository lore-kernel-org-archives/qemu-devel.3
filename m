Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA9C55ABF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraA5-0004gC-Qz; Wed, 05 Aug 2026 07:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraA3-0004fY-VK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraA2-0006jT-7G
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hCRmnSWXK6YF43RdUv6ID/tYdpsLJqbm/2L6HherxKo=;
 b=iwyxaCSiUFVSYqWLjv+gP3e8pwETmflYca2UaBGdAqD9IDFEHwi9L+lmOKG35fXZMckUY5
 P5NukPKNb77Zg5yr4y7kdXsFEdL+k8Gkw/N7bqtEOplN2KVV4gb0v3VN1YbTq/bjGlklXO
 YQoQ+vDfjy9elDGaHVR0IVTuDzmXk0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-wwD4HWDiPymAFZBnJn_ofg-1; Wed,
 05 Aug 2026 07:51:48 -0400
X-MC-Unique: wwD4HWDiPymAFZBnJn_ofg-1
X-Mimecast-MFC-AGG-ID: wwD4HWDiPymAFZBnJn_ofg_1785930707
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AD141800614
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:51:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94138434; Wed,  5 Aug 2026 11:51:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:53 +0400
Subject: [PATCH 03/27] hw/usb/dev-smartcard-reader: fix assert on pending
 answers overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-3-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8r1WrMY8qvKHYq+sLpf/U+GdQK/1XkWNkVF/NDHIznQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOrW6lTCHcKxj571Xaq3/3c0uLdUT6C9Onoc
 OX5Q6ELouCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjqwAKCRDa6OEJdZac
 5fcoEACWByCum7kJvBFX/QeQ20/SleprKetoGWyUOpJwR3d7YCdUwK/YXbeUhQhjOajgbtztfdl
 t3hp0TU8dY4q5z6fDZLJMtZq2ZfDt6kVerhaNkErHDVEn0rDIWmJSLuzYjl0q1MxCSi5Y9fM1ZF
 /Ccqu8Nt9aM42QLRigUfTARGKfYFowtRPhXy8BUTVpGzVzf8O72nvtMkTMr8m+u4X1+4gr3b97n
 xbpzciO0X4h1d7tWLadB0+3nZ7/VrkpXiKiVO/CmKly4R75/6G8KYICJCpX+49TyvxO3nlpzVMb
 auHmz2CHhenLeFKgeav/KXaopOvYZD1yISfayoLkdJB3wjqSU3IX2TO3lWcETGm3ZKoQdwU1JtO
 576/iRgl8yuqIi2htcGCsKdwayGIltVYpsOPcwrBnjk0QGgMf8az9Qyj/p5UCjthuHRKxUUrLg6
 QgWkFHWH8aKR6rVz6R5VOrOUJgsBTZKOHW8nyrLcEdYuce1mRlna8og6HOOFiQPrR2R3OtHjAFh
 0M0dchlRLQFfbugLl/3dxFyk7xLwLLUtDYHPravGaG+M9WOk/IWOOuCF7/EU8dZK9jXnG9c+nw/
 CcZT7BbyJnQW4ncB/y7vXS+rTqPmyTXdDJm+MP+O1/w8JBMWcpZgTy9CjiDMrtWpqIOSDVGiypK
 dUEKW9Xk2QbB3vQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/usb/dev-smartcard-reader.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 8241cd07648d..9fc6bbca0f2d 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -166,6 +166,7 @@ enum {
     ERROR_XFR_PARITY_ERROR  = -3,
     ERROR_XFR_OVERRUN       = -4,
     ERROR_HW_ERROR          = -5,
+    ERROR_CMD_SLOT_BUSY     = -32,
 };
 
 /* 6.2.6 RDR_to_PC_SlotStatus definitions */
@@ -945,6 +946,13 @@ static void ccid_on_apdu_from_guest(USBCCIDState *s, CCID_XferBlock *recv)
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
2.55.0


