Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C985C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUs6-0005Lc-D9; Wed, 22 Jan 2025 02:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUs3-0005JU-E7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUs1-0008RA-Uv
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737529789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t8xLV1oAxbTo2485dr0ahXFjfD7BJskv2TEDI49Ohs=;
 b=R7kjZizRG8ISu6rZCiAOjHPgs3ZcJ47Hfw0x+/fSRhiV6FvPH8t+UPXVyqlWFM5Y5X8OlU
 pKKlpgO4SIeedkmK1E81BvcXCvW56iL4Qb+BYs54gJdLLGF2NtEZALPJVuUxvu7tsQ035Q
 rzFtOPhNV465TFWeRMkSvHlW8BNVrDU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-EaxTZQRuMymnzKaOw4H5zQ-1; Wed,
 22 Jan 2025 02:09:45 -0500
X-MC-Unique: EaxTZQRuMymnzKaOw4H5zQ-1
X-Mimecast-MFC-AGG-ID: EaxTZQRuMymnzKaOw4H5zQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A5F21956070; Wed, 22 Jan 2025 07:09:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F0613003E7F; Wed, 22 Jan 2025 07:09:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 9/9] aspeed: Create sd devices only when defaults are enabled
Date: Wed, 22 Jan 2025 08:09:09 +0100
Message-ID: <20250122070909.1138598-10-clg@redhat.com>
In-Reply-To: <20250122070909.1138598-1-clg@redhat.com>
References: <20250122070909.1138598-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When the -nodefaults option is set, sd devices should not be
automatically created by the machine. Instead they should be defined
on the command line.

Note that it is not currently possible to define which bus an
"sd-card" device is attached to:

  -blockdev node-name=drive0,driver=file,filename=/path/to/file.img \
  -device sd-card,drive=drive0,id=sd0

and the first bus named "sd-bus" will be used.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 53a859a6e4aa..d9418e2b9f2c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -456,14 +456,14 @@ static void aspeed_machine_init(MachineState *machine)
         amc->i2c_init(bmc);
     }
 
-    for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
+    for (i = 0; i < bmc->soc->sdhci.num_slots && defaults_enabled(); i++) {
         sdhci_attach_drive(&bmc->soc->sdhci.slots[i],
                            drive_get(IF_SD, 0, i), false, false);
     }
 
     boot_emmc = sc->boot_from_emmc(bmc->soc);
 
-    if (bmc->soc->emmc.num_slots) {
+    if (bmc->soc->emmc.num_slots && defaults_enabled()) {
         emmc0 = drive_get(IF_SD, 0, bmc->soc->sdhci.num_slots);
         sdhci_attach_drive(&bmc->soc->emmc.slots[0], emmc0, true, boot_emmc);
     }
-- 
2.48.1


