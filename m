Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F5FF47CA3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyI-0001Dt-AB; Thu, 05 Mar 2026 12:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCy7-0000IK-7G
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCy3-0003lw-6i
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Co0tAYHCrdAqxSu1AS4NaI/owCp75j7aAjwNLCADJx0=;
 b=RppuNHxXYtOFB6lmr2/c4v/HE1klDI4NZfKfUB59XpgmE3mYyUScD0mFDg9lB7xAguPdkl
 6XHGT/BPPtkaWflvf0VGf/6YBxNtp01lFsBxLhdCN/9Qp5DzKWyaA8lOWn9OFOl8HGEqpZ
 F100IJQ/56B4r7+stcK4QJiLV+VQARc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-m07cqy9jMMa_SGPHVbuwgw-1; Thu,
 05 Mar 2026 12:58:30 -0500
X-MC-Unique: m07cqy9jMMa_SGPHVbuwgw-1
X-Mimecast-MFC-AGG-ID: m07cqy9jMMa_SGPHVbuwgw_1772733509
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E349D1800610; Thu,  5 Mar 2026 17:58:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2ACE33003E9E; Thu,  5 Mar 2026 17:58:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/38] hw/i3c/core: Initialize num_sent in i3c_send_byte()
Date: Thu,  5 Mar 2026 18:57:00 +0100
Message-ID: <20260305175711.1119025-28-clg@redhat.com>
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

i3c_send_byte() declared num_sent without initializing it before
passing its address to i3c_send().

Although i3c_send_byte() itself ignores num_sent after the call,
i3c_send() forwards it to trace_i3c_send(). If the target send
callback does not set *num_sent, the trace may print an
uninitialized value, leading to misleading or garbage output.

Example concern from review:
  trace_i3c_send(*num_sent, num_to_send, ret == 0);

If *num_sent is not written by the callback, this trace can report
an incorrect number of transmitted bytes.

Initialize num_sent to 0 to ensure deterministic and predictable
trace output, even if the callback fails to update it.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260303013322.1297499-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i3c/core.c b/hw/i3c/core.c
index 0a266e00a279..168526003dab 100644
--- a/hw/i3c/core.c
+++ b/hw/i3c/core.c
@@ -325,7 +325,7 @@ int i3c_send_byte(I3CBus *bus, uint8_t data)
      * Ignored, the caller can determine how many were sent based on if this was
      * ACKed/NACKed.
      */
-    uint32_t num_sent;
+    uint32_t num_sent = 0;
     return i3c_send(bus, &data, 1, &num_sent);
 }
 
-- 
2.53.0


