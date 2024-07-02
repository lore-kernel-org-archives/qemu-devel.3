Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11158C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 08:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOYRo-0006LE-4g; Tue, 02 Jul 2024 04:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOYRj-0006Kn-N2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOYRg-0005jJ-TC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 04:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719907259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZDjAYdWEq9lylzH3r+bf49l7/u64ItWJffn1TpvICQ=;
 b=DbTojvMK/Rg6jIQRb0zEVfVVegqszQUMj6uELgCsXiQX+XGeWkSbn0ITbwuBjgOXBmKO69
 v2Wims0UgYK3JD6r1o3BklOzVe0Lzn2q2QHD9tS9RdlbybqK0wyqgrOEbvMMoeAr4VcWPZ
 MlsM7MySx6Vt56vwnznRjy3h8ICJFKo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-FXacV_lnNkSosm10QHw3SA-1; Tue,
 02 Jul 2024 04:00:58 -0400
X-MC-Unique: FXacV_lnNkSosm10QHw3SA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AEBB19560B3; Tue,  2 Jul 2024 08:00:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.90])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70D6C19560AA; Tue,  2 Jul 2024 08:00:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jamin_lin <jamin_lin@aspeedtech.com>
Subject: [PULL 3/6] aspeed/sdmc: Check RAM size value at realize time
Date: Tue,  2 Jul 2024 10:00:39 +0200
Message-ID: <20240702080042.464220-4-clg@redhat.com>
In-Reply-To: <20240702080042.464220-1-clg@redhat.com>
References: <20240702080042.464220-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The RAM size of the SDMC device is validated for the SoC and set when
the Aspeed machines are initialized and then later used by several
SoC implementations. However, the SDMC model never checks that the RAM
size has been actually set before being used. Do that at realize.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Jamin_lin < jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_sdmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 93e2e29ead87..44da085e10cb 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -271,6 +271,12 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
     assert(asc->max_ram_size < 4 * GiB || asc->is_bus64bit);
+
+    if (!s->ram_size) {
+        error_setg(errp, "RAM size is not set");
+        return;
+    }
+
     s->max_ram_size = asc->max_ram_size;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
-- 
2.45.2


