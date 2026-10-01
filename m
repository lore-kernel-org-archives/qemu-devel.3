Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B318CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCGsf-0000Fs-U6; Thu, 01 Oct 2026 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGs0-0007vm-EF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCGry-0006MG-5q
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 09:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790861441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44HJKj1mJ7KiXnS7tnBe4UNBUJE2H93VKcl32AM2Z94=;
 b=fBDGh+oMHJ98MXqiXxbCFdXm+jMktGGX/pe/+BGvG6mWnII8vgqyMXBuqYmjJUE4UphPS+
 L1KVnIYKlHJP4IlkJ5GNH+MAUY+WjZdTnQC3T5pNwf0wRaJ7vFje867ZkqaHIQ+Os2qMas
 3h3Y9qrJ2dKnlJR7d76vQ2Pp6z34+gM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-FEMQdYQkOpeSIAs-iNtNaA-1; Thu,
 01 Oct 2026 09:30:34 -0400
X-MC-Unique: FEMQdYQkOpeSIAs-iNtNaA-1
X-Mimecast-MFC-AGG-ID: FEMQdYQkOpeSIAs-iNtNaA_1790861433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A832189F8E6; Thu,  1 Oct 2026 13:30:33 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4ECBD1956095; Thu,  1 Oct 2026 13:30:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 01 Oct 2026 17:29:52 +0400
Subject: [GIT PULL 13/27] hw/usb/dev-smartcard-reader: reject oversized
 responses safely
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-smartcard-fixes-v1-13-ebb5a40dd497@redhat.com>
References: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
In-Reply-To: <20261001-smartcard-fixes-v1-0-ebb5a40dd497@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=53GOMWzaeNc92zmGKilDJvLKPMjcZbBHd7Lc58zXUDw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvmBIMHNa/GCZYOTj1BICShg4fU/FTwJadZ2fx
 fJsyo6OUFyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5gSAAKCRDa6OEJdZac
 5YjPD/sHSiCqPGafyTWKMYKrBiadu8XmM0uqH4W1yWkT/1c4nUnVtoskJFgq75bif9uS7oOaUwr
 V5sLCqBeNaFLnwfTtJEG5cn7ilevKCZIxGEwNK1rPjDmTI+5AOd+X4MllMHnzj3EAgs+QOP9UWU
 7rKYMivQWaOkE/6QhNIz4A8TzhxtCFWmH+rYfJMvvST7cPa263YdfptbULfeov+yd1t5PonrIRS
 nCFLj3Kb/1tno4+Y7msB402qWfodQ74P09AR7Ji4116OfcI3pz5N9/0iUYe52uRSbVunKAePlQA
 9WA6UzqKKSQ6nOwUUUpuMzFvwDM0P5fefryfUuA37Kfgm/9u3yvh31D5XM3WasEUr/5SYFc4ZIP
 uKL8xIspn324AymcAgZ5xDP52yTL4wFufzRWNs88EZFfrlQxhxgc+c9UpTeTdow14lfWKjAlk3h
 R402CFtGb//yRHSzUXxHHhpJf+DZ3Btcs+hYmILcgGMiUojXNQHFuIWolRtXLE8Hc0Bt/KCZTM4
 0/l/pK1LVailJme1VXxOdby5nOvDxL7xrZbQ0fp7eFQhtDhWrP4gjSde1qMa8iKQgHtDDJQmQVD
 O5hxli4Uom20vNSPhdDohGkjH7tMRc/64/XUtfLa34SdOoQ0ql6tL5t2jkcpffXj8nw1PagEriM
 dBx+XMg52Ls1Uxw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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
Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
2.56.0.rc0.29.g47ce80527c56


