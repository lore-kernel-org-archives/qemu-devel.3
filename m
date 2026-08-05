Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36367C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraBq-0008Vs-Gc; Wed, 05 Aug 2026 07:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraBp-0008Vj-JE
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraBo-0007M6-2I
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vCMv5OovUEb7vaiFSGmLJ0V5SFUkB5yVKJWL8zrwqk=;
 b=VeS47VXhikJP76GaIb/zcReHThCsuYK+L92ErD1qDNj5gQUoR0uMAuKE+kl3s8bhYzy26k
 0P9PT06X4vRJ/oMfCgPncj07b8WvOTNt+diSWVGGaTcHPhnIzhsTTAnaM+EuEqoe3J96aN
 ctEqBp5/BJ/2ffFZ0NZFTG+G+1n27ZQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-QYdQ5m_LOwiRVRZSOLUO-Q-1; Wed,
 05 Aug 2026 07:53:38 -0400
X-MC-Unique: QYdQ5m_LOwiRVRZSOLUO-Q-1
X-Mimecast-MFC-AGG-ID: QYdQ5m_LOwiRVRZSOLUO-Q_1785930816
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D45C195608D
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:53:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D7DE5BC; Wed,  5 Aug 2026 11:53:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:51:03 +0400
Subject: [PATCH 13/27] hw/usb/dev-smartcard-reader: reject oversized
 responses safely
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-13-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=51tZEZWvmdqvOJzg4RDlKTdtEHLsJlHYExzuAp1XPao=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOtFDhQwUbWs+l9xTjmirMS5eF1TwbHPp6LM
 RgTOfRU0lmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrQAKCRDa6OEJdZac
 5Y7sEACoZ9MXM2Ln6UUoPhma9obuhPGQ503YiYiEFw6dhHfU7GV3iHL3D/b6pARoC2amVXn1w0d
 8A/xC5ia2Dk2YhS3T/9kVRypp0yVaCt5Eea8Bz73cDYrslsTV2RAeWOVC2mEjPSJbwKVB2bCfXC
 WHPaSzzFG4USXjharxjm0P+PVPuVAAfvzo1YPk3LP2Tp8vVeGNeJUNC2I6FuSwNr5BenU0KIyXh
 NTRJb2DujQ9ZmrbzVt1vNV7bEWvdhPAoReOUt4UDCmTA9zrdfoxMePtUD3N+0YQzWQc5AA4gs7a
 c27LXFfINXvUtngWY7woEDXyWGLY9rOJIX7h994GJXBlNhOJuWYN5SE34d1X+c1UBEvBnvw0LFq
 yHgnBZc66pvWrtuOxocQ3mWkcAmbGlp/XcQRcraf+KHQY/jtEUXF9Cf66asWLj3exuJBkotS41y
 CAjXL3iNHaoS/EtGn7aQWZ0VNz/sZN/ugHhzYb5oUgXxqENR2Xsk2QSDzKxabp0zdpGsXqgs0ge
 1szi5apKF/XFqvwTsKHjFcT/8x1al5TxRaxfpMs2/pwhZQXC/5Iw0xG1Rpkd1GHW5e2H3y8BGcw
 UWRPSPS/Hen9W7XvvxmA91vihSIjYRX3Kp2nAU6Es37JyVENOWqUjv3DcSinnNXXkceBJq5TZpz
 CXegXnnRhtwxQfA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

ccid_reserve_recv_buf() takes a uint16_t length, so the result of
sizeof(CCID_DataBlock) + len silently truncates when the sum exceeds
65535.  This could bypass the BULK_IN_BUF_SIZE check inside the
function, leading to a buffer overrun on the fixed-size BulkIn.data
array.

The response length comes from the card backend (passthru chardev or
libcacard), not from the guest, so this is not guest-exploitable but
still worth hardening against a buggy or compromised backend.

Fix this by adding explicit overflow-safe checks in both callers that
add a header to the payload: ccid_write_data_block() returns false on
oversized input, and ccid_write_data_block_answer() reports
ERROR_HW_ERROR to the guest and sends a zero-length data block so the
answer queue stays in sync.

Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 16f248a0969f..d91376826c5c 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -769,7 +769,13 @@ static void ccid_write_parameters(USBCCIDState *s, CCID_Header *recv)
 static bool ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
                                   const uint8_t *data, uint32_t len)
 {
-    CCID_DataBlock *p = ccid_reserve_recv_buf(s, sizeof(*p) + len);
+    CCID_DataBlock *p;
+
+    if (len > BULK_IN_BUF_SIZE - sizeof(*p)) {
+        DPRINTF(s, D_WARN, "data block is too large (%u bytes)\n", len);
+        return false;
+    }
+    p = ccid_reserve_recv_buf(s, sizeof(*p) + len);
 
     if (p == NULL) {
         return false;
@@ -813,6 +819,14 @@ static bool ccid_write_data_block_answer(USBCCIDState *s,
         return false;
     }
     answer = ccid_peek_next_answer(s);
+    if (len > BULK_IN_BUF_SIZE - sizeof(CCID_DataBlock)) {
+        DPRINTF(s, D_WARN,
+                "APDU response is too large (%u bytes), returning an error\n",
+                len);
+        ccid_report_error_failed(s, ERROR_HW_ERROR);
+        data = NULL;
+        len = 0;
+    }
     if (!ccid_write_data_block(s, answer->slot, answer->seq, data, len)) {
         return false;
     }

-- 
2.55.0


