Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1093BF47CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyp-00032A-4r; Thu, 05 Mar 2026 12:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCy7-0000IL-A6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCy3-0003m1-5D
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6qU4hDIoHZbeJU4miHApFFtw68jyau+iwJ5Ohe5zWZ4=;
 b=DzYb0fliapqFeEOKDlq5I0GyLt8wKx9Ro9YflkTdmUmqBqruFr7uPn8pK7kHORIc4ZKXOu
 xvv75tiJYWYk7qinus8oX2kiAflAnuDiOUg1EqnD2HwURyToTpgY1rt0JM+8bRpdQTZ9fX
 uew8TqPQ3pH6CrGu2PmRAlle9G/bZ/4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-lRdEH9qlOqGutn8RblhxrA-1; Thu,
 05 Mar 2026 12:58:28 -0500
X-MC-Unique: lRdEH9qlOqGutn8RblhxrA-1
X-Mimecast-MFC-AGG-ID: lRdEH9qlOqGutn8RblhxrA_1772733506
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABA351956052; Thu,  5 Mar 2026 17:58:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8BF63003E9E; Thu,  5 Mar 2026 17:58:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/38] hw/i3c/mock-i3c-target: Set num_sent in TX callback to
 fix trace reporting
Date: Thu,  5 Mar 2026 18:56:59 +0100
Message-ID: <20260305175711.1119025-27-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

mock_i3c_target_tx() did not update *num_sent before returning.

Although some callers may not directly use this value, i3c_send()
passes num_sent to trace_i3c_send(). If the target TX callback does
not initialize *num_sent, the trace output may report an incorrect
or uninitialized value, leading to confusing debugging information.

For example, the following trace was observed:

  mock_i3c_target_tx I3C mock target write 0x12
  i3c_send I3C send 0/1 bytes, ack=1    (expected 1/1 bytes)

This happens because *num_sent was never set by the TX callback.

Fix this by setting *num_sent in all return paths,
including the IBI magic handling case, to accurately reflect
the number of bytes consumed.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260303013322.1297499-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/mock-i3c-target.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c
index 875cd7c7d09c..b99709a08b52 100644
--- a/hw/i3c/mock-i3c-target.c
+++ b/hw/i3c/mock-i3c-target.c
@@ -70,6 +70,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
 
     if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
         mock_i3c_target_ibi_timer_start(s);
+        *num_sent = 1;
         return 0;
     }
 
@@ -86,6 +87,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
         s->buf[s->p_buf] = data[i];
         s->p_buf++;
     }
+    *num_sent = to_write;
     return ret;
 }
 
-- 
2.53.0


