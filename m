Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622B8F47CA5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyp-00036Y-5d; Thu, 05 Mar 2026 12:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxj-0008Mr-Fe
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxg-0003hr-Sk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmgP8TE8GIWwc2Q4Cz3wkd7/Lsgjw21GHVlLYkczrRw=;
 b=dFlrfxPP/ZPdhCyExsQcpeC+B8532x9EQaqke9IER7Hr6ugAHK3I/5+2vkJWK6lEzLepR6
 zpb709gn4MXPTb2R7rokNVwGKPBOnxXOUviTEWgN1ZMly0kkcDHAsgE72Z7l2BzohpDZLx
 FiVD7Gl14ZzjuT+NByYxlhdD5cZEWqw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-oT9jGLcvNTCqMUTufLFQKA-1; Thu,
 05 Mar 2026 12:58:08 -0500
X-MC-Unique: oT9jGLcvNTCqMUTufLFQKA-1
X-Mimecast-MFC-AGG-ID: oT9jGLcvNTCqMUTufLFQKA_1772733486
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DFF11800359; Thu,  5 Mar 2026 17:58:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03A963003E9E; Thu,  5 Mar 2026 17:58:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/38] hw/i3c/aspeed: Add I3C bus get function
Date: Thu,  5 Mar 2026 18:56:51 +0100
Message-ID: <20260305175711.1119025-19-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

To retrieve the I3C bus object normally, the order is Aspeed I3C -> DW
I3C[n] -> bus object, so make a nice wrapper for people to use.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-18-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/i3c/aspeed_i3c.h | 3 +++
 hw/i3c/aspeed_i3c.c         | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
index b8827d31d753..42c9eedd8590 100644
--- a/include/hw/i3c/aspeed_i3c.h
+++ b/include/hw/i3c/aspeed_i3c.h
@@ -31,4 +31,7 @@ struct AspeedI3CState {
     DWI3C devices[ASPEED_I3C_NR_DEVICES];
     uint8_t id;
 };
+
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num);
+
 #endif /* ASPEED_I3C_H */
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index 2700c5f4cdeb..bac8c55bb091 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -153,6 +153,15 @@ static const MemoryRegionOps aspeed_i3c_ops = {
     }
 };
 
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num)
+{
+    if (bus_num < ARRAY_SIZE(s->devices)) {
+        return s->devices[bus_num].bus;
+    }
+    /* Developer error, fail fast. */
+    g_assert_not_reached();
+}
+
 static void aspeed_i3c_reset(DeviceState *dev)
 {
     AspeedI3CState *s = ASPEED_I3C(dev);
-- 
2.53.0


