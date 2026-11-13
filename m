Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E2606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QiagMsKw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzu8-0003te-LD; Fri, 13 Nov 2026 17:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzu7-0003t3-It
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:37:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzu6-0007pu-3U
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794609473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I6M4dyUT6VoAgxlcqAl38LDA2igusI77Z1konCH45Dk=;
 b=QiagMsKwW+7G8z1BV8QV7E0XOC2yqTEsDe9Cjhm2SMYhUhNB2GL56ukrz4Y/wWYM5IS0Zo
 +T/5O89plFdF0czj4GVVsIh6FCFkJPvkPi1VEzuVOSk5P1owz/kcIyknai4mQtVkxG8CR7
 d29QwK8Gpqil8cor6VN/9QRgm4NWJrM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-DI2YITCfPZ-L6sBNncJLVg-1; Fri,
 13 Nov 2026 17:37:50 -0500
X-MC-Unique: DI2YITCfPZ-L6sBNncJLVg-1
X-Mimecast-MFC-AGG-ID: DI2YITCfPZ-L6sBNncJLVg_1794609469
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B826A1800607; Fri, 13 Nov 2026 22:37:48 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34FF21956086; Fri, 13 Nov 2026 22:37:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, bea1e@proton.me,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/4] nbd: Refactor structured payload interpretation
Date: Fri, 13 Nov 2026 16:34:49 -0600
Message-ID: <20261113223742.2546619-7-eblake@redhat.com>
In-Reply-To: <20261113223742.2546619-6-eblake@redhat.com>
References: <20261113223742.2546619-6-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An upcoming patch wants to reuse the payload of a structured reply
chunk in further code for additional safety checks on the server's
response.  It will be easiest if the initial parse converts the
payload from network order into host order along the way, so that I
don't introduce subtle endian-specific bugs in that upcoming code. A
quick audit shows that none of the current callers of
payload_advance*() were reading a memory location within the payload
after its initial parse.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index e5e16722ba2..052469b3547 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -578,24 +578,36 @@ err:
     return rc;
 }

+/* Consume a field of payload, while swapping it in place to host-endian. */
 static inline uint16_t payload_advance16(uint8_t **payload)
 {
+    uint16_t value = lduw_be_p(*payload);
+    stw_he_p(*payload, value);
     *payload += 2;
-    return lduw_be_p(*payload - 2);
+    return value;
 }

 static inline uint32_t payload_advance32(uint8_t **payload)
 {
+    uint32_t value = ldl_be_p(*payload);
+    stl_he_p(*payload, value);
     *payload += 4;
-    return ldl_be_p(*payload - 4);
+    return value;
 }

 static inline uint64_t payload_advance64(uint8_t **payload)
 {
+    uint64_t value = ldq_be_p(*payload);
+    stq_he_p(*payload, value);
     *payload += 8;
-    return ldq_be_p(*payload - 8);
+    return value;
 }

+/*
+ * nbd_parse_offset_hole_payload:
+ * Parse a chunk for NBD_REPLY_TYPE_OFFSET_HOLE, updating payload in
+ * place to a host-endian description of the region described.
+ */
 static int nbd_parse_offset_hole_payload(BDRVNBDState *s,
                                          NBDStructuredReplyChunk *chunk,
                                          uint8_t *payload, uint64_t orig_offset,
-- 
2.56.0


