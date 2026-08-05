Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14230C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wraAR-0004vV-C2; Wed, 05 Aug 2026 07:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAN-0004up-PV
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wraAJ-0006lW-Jo
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785930726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoRToi6De8b+7zMk0CxW4wYsMhcGUvA7Ejv3EsBE6sQ=;
 b=GcVOFQ4rmPN5uzMACirSu56I9BgMucKiRqCo5LKrhSeCF9TCKbG+MzsPw25Kg5vnTK7oJu
 IhZ/lwqEtTPJQPzMnsj5A6P/3xwZ19ho7ramw2WK2ygDR6voJC2KvArGmd0z0gDaO1HI3f
 dVOcBPR6+Eks6r1+RDPj3dniQA7gAIU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-90fqFw8WO32U-YwFz1DY4g-1; Wed,
 05 Aug 2026 07:52:00 -0400
X-MC-Unique: 90fqFw8WO32U-YwFz1DY4g-1
X-Mimecast-MFC-AGG-ID: 90fqFw8WO32U-YwFz1DY4g_1785930719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5251318004A9
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2026 11:51:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9514130001A2; Wed,  5 Aug 2026 11:51:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 05 Aug 2026 15:50:54 +0400
Subject: [PATCH 04/27] hw/usb/dev-smartcard-reader: decode bulk-out length
 as little-endian
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260805-smartcard-fixes-v1-4-187ee9122441@redhat.com>
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2059;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uf4mSWY4qqASiRvsnqXRiU1XB++MZ6NGlJsVLANpeDY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcyOsfiKHkrwzPonYHtLVq0rDbH5PM4qI2h8u+
 R25Wc8ZOtmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanMjrAAKCRDa6OEJdZac
 5ZNgD/9TP6zN0k5NJRiTPkd+YO/1PCGi19/c0xiNrcNg7OoMj8wtFSXJ/JVc7uaAYcaN9HVHrEq
 yii0EZRx9T8HvB8QlbLQR8TeMDcRkOLsG/AVaNeqppUpY8rZVcAQz8fNbnTwpH6Fsgx67Z0DRSb
 YRXHT1bL72YkSAQKodNABEibmLgPDUo7btAbWp4ve+yQGMGGY+UpRcnAZYGmuzUfNAKOFtBY8QQ
 Acle1ey1lhTYxYgYDhq1BzovXzE3oUg9+n88WdldFvUdXo09NbjTZYfgRIjZ4lbKfVPcHIqhkxM
 I8dK7nE4CE9IjME9XNNsP+JYZJwdLIwtukQgQlX1u9Ymo/8GaGMcz9/g61fOKUD1RcSm9gCQ1l5
 G99TmQqgt3I1ju8VNP90g2fa0Jq2/hWkdAqRs8xNl84tS2GDnGcLrKejb1xxJLRlfAaQ6gsOW/6
 tti9sdsIb0Fk1aZGY51S0DpTb0KA1UAd9iS575FaXGvg5kDTMmVRmAiB/9moVUdLr0AgJI4wANR
 kLFNf8AnOSpkqwd3s5wUTSyAJzulaEI2gG7qtiEkD6O9Od+dK5dfKkrMj3LcOM7MNs1OwDOF+al
 a2QU0ccaXIr4Bv9fjFvD+8sXwt0sEJ6mikAIguBHAPwhJokeTCxIvrYr3Cfc38Jge4urjgiZubn
 cvJwry+xETlUpvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The CCID Rev 1.1 specification states in section 1.3, Document
Conventions, that fields larger than one byte are stored in
little-endian format. The bulk message header's dwLength field is a
four-byte field described in section 6, CCID Messages.

Decode dwLength with le32_to_cpu() before using it to assemble and
validate Bulk-OUT messages. This fixes message handling on big-endian
hosts.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/usb/dev-smartcard-reader.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 9fc6bbca0f2d..3580465df368 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -989,6 +989,7 @@ static const char *ccid_message_type_to_str(uint8_t type)
 static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
 {
     CCID_Header *ccid_header;
+    uint32_t payload_len;
 
     if (p->iov.size + s->bulk_out_pos > BULK_OUT_DATA_SIZE) {
         goto err;
@@ -1001,17 +1002,18 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
     }
 
     ccid_header = (CCID_Header *)s->bulk_out_data;
-    if ((s->bulk_out_pos - 10 < ccid_header->dwLength) &&
+    payload_len = le32_to_cpu(ccid_header->dwLength);
+    if ((s->bulk_out_pos - 10 < payload_len) &&
         (p->iov.size == CCID_MAX_PACKET_SIZE)) {
         DPRINTF(s, D_VERBOSE,
                 "usb-ccid: bulk_in: expecting more packets (%u/%u)\n",
-                s->bulk_out_pos - 10, ccid_header->dwLength);
+                s->bulk_out_pos - 10, payload_len);
         return;
     }
-    if (s->bulk_out_pos - 10 != ccid_header->dwLength) {
+    if (s->bulk_out_pos - 10 != payload_len) {
         DPRINTF(s, 1,
                 "usb-ccid: bulk_in: message size mismatch (got %u, expected %u)\n",
-                s->bulk_out_pos - 10, ccid_header->dwLength);
+                s->bulk_out_pos - 10, payload_len);
         goto err;
     }
 

-- 
2.55.0


