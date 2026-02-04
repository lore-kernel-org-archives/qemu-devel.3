Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB62FE95378
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBL-0000WE-Mu; Wed, 04 Feb 2026 05:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaB2-0000ST-Uo
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaB1-0003yW-Gc
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8GoPy3jKgTWdpyHPRiMnRFnTMsp4NxwY5YOERW/tJV8=;
 b=I1b84uNnxI8uNBO7io053YJ5Ry6mN2CF0qF9hHoE4ca49YMKIGE5CSPI7CqAtqbVm8mYGW
 8fOGM2w7YS5KcJJdKhDHrV1CrtgPIYPKJTy213IDLHj7eF713HK1baoNBftTSd1dBCgSWn
 Quq3IOJ9xyC+7rz2PujbNBXiRy703ak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-J8mHMFX-NcaPcnAt3svAgA-1; Wed,
 04 Feb 2026 05:31:59 -0500
X-MC-Unique: J8mHMFX-NcaPcnAt3svAgA-1
X-Mimecast-MFC-AGG-ID: J8mHMFX-NcaPcnAt3svAgA_1770201118
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48A2E1800613; Wed,  4 Feb 2026 10:31:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 321301800669; Wed,  4 Feb 2026 10:31:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Elhrj Saad <saadelhrj@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/45] hw/adc: Fix out-of-bounds write in Aspeed ADC model
Date: Wed,  4 Feb 2026 11:30:59 +0100
Message-ID: <20260204103136.1795455-9-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The 'regs' array has ASPEED_ADC_NR_REGS (52) elements, while the
memory region covers offsets 0x00-0xFC. The aspeed_adc_engine_write()
function has an out-of-bounds write vulnerability when accessing
unimplemented registers.

Fix this by using 'return' instead of 'break' in the default case,
which prevents execution from reaching the s->regs[reg] assignment for
unimplemented registers.

Reported-by: Elhrj Saad <saadelhrj@gmail.com>
Fixes: 5857974d5d11 ("hw/adc: Add basic Aspeed ADC model")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260126141820.719492-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/adc/aspeed_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index fd3af308296e..3cc75bbcd6e2 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -228,7 +228,8 @@ static void aspeed_adc_engine_write(void *opaque, hwaddr addr, uint64_t value,
         qemu_log_mask(LOG_UNIMP, "%s: engine[%u]: "
                       "0x%" HWADDR_PRIx " 0x%" PRIx64 "\n",
                       __func__, s->engine_id, addr, value);
-        break;
+        /* Do not update the regs[] array */
+        return;
     }
 
     s->regs[reg] = value;
-- 
2.52.0


