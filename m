Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15665D58CAC
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2026 21:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Qo4-0003jA-Pr; Sun, 22 Mar 2026 17:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4Qnw-0003h0-5H
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 17:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4Qnu-00074f-Q6
 for qemu-devel@nongnu.org; Sun, 22 Mar 2026 17:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774216669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+zR4CHZKqEzE6EWL7+Cb/iO18yqfAa7R5SdF4FE98I=;
 b=QJUbM72ZPx3QFaBUOYDgCYltuOd0z6gSwl+qxVkTbFNSqN7je361xcmJfkaMrgLfnU3STO
 dwzg5q2CC/piLM8nsC2luvrkXmOf6YMXyS2sOqAQFjCJ3gKd0vUfrWvCEQfcVetNgAo3jD
 JDdAYzKEwOhmR6C2Px9ml0eFSTyx7Js=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-fkfgBn5lOLmpknpw40_tTg-1; Sun,
 22 Mar 2026 17:57:46 -0400
X-MC-Unique: fkfgBn5lOLmpknpw40_tTg-1
X-Mimecast-MFC-AGG-ID: fkfgBn5lOLmpknpw40_tTg_1774216665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68202195608B; Sun, 22 Mar 2026 21:57:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 665D019560B7; Sun, 22 Mar 2026 21:57:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/3] hw/i2c/aspeed_i2c: Remove assert
Date: Sun, 22 Mar 2026 22:57:32 +0100
Message-ID: <20260322215732.387383-4-clg@redhat.com>
In-Reply-To: <20260322215732.387383-1-clg@redhat.com>
References: <20260322215732.387383-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


