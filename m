Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B1606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VM4TYTut
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqA2-0003Vw-VU; Thu, 22 Oct 2026 06:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJqA1-0003VT-FC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xJq9z-0007lK-QD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mApZOr2CweZ/S3eePcKqkjr3cKAXptRSFdPEcfe60NE=;
 b=VM4TYTutl6AZGZQrVecA2ZYDJvoXBe2PB2Wo+ZQKFCMip2bfjIWq8wv9bxWHTaIpN1bYpx
 mjyP8aYiUf0m8DsahRn1aJvmTz992ke5Ksma93F7ez9GTc5WuAk4hDH0qmAVRiJA9N6u3s
 C+qUdAHcNQFIgmKhdxa9uv58Umeu4lU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-W9mPkbdWMx-lJDhajqTIWQ-1; Thu,
 22 Oct 2026 06:36:32 -0400
X-MC-Unique: W9mPkbdWMx-lJDhajqTIWQ-1
X-Mimecast-MFC-AGG-ID: W9mPkbdWMx-lJDhajqTIWQ_1792665391
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A6361955F21; Thu, 22 Oct 2026 10:36:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 081C530001B9; Thu, 22 Oct 2026 10:36:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Tommaso Califano <tcalifano@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 01/11] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
Date: Thu, 22 Oct 2026 12:36:12 +0200
Message-ID: <20261022103622.1151089-2-thuth@redhat.com>
In-Reply-To: <20261022103622.1151089-1-thuth@redhat.com>
References: <20261022103622.1151089-1-thuth@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
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
---
 hw/usb/dev-mtp.c | 7 +++++++
 1 file changed, 7 insertions(+)

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
2.56.0


