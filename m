Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1458F4613F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w515R-00081E-Hz; Tue, 24 Mar 2026 08:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w515E-0007xr-Fx
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w5159-0001SY-8t
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774356115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9A5fNyiv6TZ4cvjVNXiQmQCUaFdXzzcLB+89+/mZ9Y=;
 b=iZeAXkUAmcpvbCBgqgQESaVDpu7hz3uc2GbYxAtZQAVciQmgnc4p49SCj2E1VV4foyOvYc
 Qh1Jj8YvdU4YwA54/+Pj4rNieUCLtEKR7iC/Zz/3fAih5gJez4fm8pbx0gXXwYmeByM+4W
 d/meMn1a774K6Ox6gQWG/IkHEJEK7WM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-9wN3C78OPXO4VmUWd94BmQ-1; Tue,
 24 Mar 2026 08:41:52 -0400
X-MC-Unique: 9wN3C78OPXO4VmUWd94BmQ-1
X-Mimecast-MFC-AGG-ID: 9wN3C78OPXO4VmUWd94BmQ_1774356111
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EEC81800561; Tue, 24 Mar 2026 12:41:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B56201955D71; Tue, 24 Mar 2026 12:41:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PULL 5/5] hw/i2c/aspeed_i2c: Remove assert
Date: Tue, 24 Mar 2026 13:41:31 +0100
Message-ID: <20260324124131.1053711-6-clg@redhat.com>
In-Reply-To: <20260324124131.1053711-1-clg@redhat.com>
References: <20260324124131.1053711-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

According to the Aspeed datasheet, the RX_BUF_LEN_W1T and
TX_BUF_LEN_W1T bits of the A_I2CS_DMA_LEN (0x2c) register allow
firmware to program the TX and RX DMA length (TX_BUF_LEN and
RX_BUF_LEN fields of the same register) separately without the need to
read/modify/write the value.  If RX_BUF_LEN_W1T and TX_BUF_LEN_W1T
bits are 0, then both TX and RX DMA length will be written.

When setting the RX_BUF_LEN field, the TX_BUF_LEN field being set is
not an invalid condition. Remove the assert.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3315
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260323125545.577653-4-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i2c/aspeed_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index ad6342bec0d4..5d18f8d49ea4 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -780,7 +780,6 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
         bus->regs[R_I2CS_DMA_RX_ADDR] = value;
         break;
     case A_I2CS_DMA_LEN:
-        assert(FIELD_EX32(value, I2CS_DMA_LEN, TX_BUF_LEN) == 0);
         if (FIELD_EX32(value, I2CS_DMA_LEN, RX_BUF_LEN_W1T)) {
             ARRAY_FIELD_DP32(bus->regs, I2CS_DMA_LEN, RX_BUF_LEN,
                              FIELD_EX32(value, I2CS_DMA_LEN, RX_BUF_LEN));
-- 
2.53.0


