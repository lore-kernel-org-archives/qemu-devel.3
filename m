Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29523C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 19:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugpmD-0005Xn-IG; Tue, 29 Jul 2025 15:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugnoV-00061O-G5
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugnoT-0008JB-Hj
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753808908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVsTL8c/Zy1jiu7dZzMiPv8OokP+7Lkgukc+5rOJh+Q=;
 b=gt34KPSoJfVucKl7CEo1SoTlwfAD2DUxctpd8DF6D2G9QrI8ntqRcuFV8bTL0JsrWsvQPn
 IjDkgDwUUeznSD4QdTckYD3BEiqnkeZX+jC0207+aKme5B18tHNeh7xXcerLHom12vTHTd
 9Cq3ToGuH0taf/TckGKFIvrGgL7rHnk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-sAd19ctvNZCmfSkstSZWOQ-1; Tue,
 29 Jul 2025 13:08:24 -0400
X-MC-Unique: sAd19ctvNZCmfSkstSZWOQ-1
X-Mimecast-MFC-AGG-ID: sAd19ctvNZCmfSkstSZWOQ_1753808903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6F131800446; Tue, 29 Jul 2025 17:08:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABECB1800242; Tue, 29 Jul 2025 17:08:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/3] roms/Makefile: build ast27x0_bootrom
Date: Tue, 29 Jul 2025 19:07:59 +0200
Message-ID: <20250729170800.678363-3-clg@redhat.com>
In-Reply-To: <20250729170800.678363-1-clg@redhat.com>
References: <20250729170800.678363-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3052
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/607a943a587248fbe0ff0897de80aee98a093caa.1753654515.git.mjt@tls.msk.ru
[ clg: Removed make CC= workaround ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 roms/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index 6af68a922f30..4c8793c5bd45 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -68,6 +68,7 @@ default help:
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
 	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
 	@echo "  npcm8xx_bootrom    -- update vbootrom for npcm8xx"
+	@echo "  ast27x0_bootrom    -- update vbootrom for ast27x0"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
@@ -200,6 +201,10 @@ npcm8xx_bootrom:
 	$(MAKE) -C vbootrom/npcm8xx CROSS_COMPILE=$(aarch64_cross_prefix)
 	cp vbootrom/npcm8xx/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
 
+ast27x0_bootrom:
+	$(MAKE) -C vbootrom/ast27x0 CROSS_COMPILE=$(aarch64_cross_prefix)
+	cp vbootrom/ast27x0/ast27x0_bootrom.bin ../pc-bios/ast27x0_bootrom.bin
+
 hppa-firmware:
 	$(MAKE) -C seabios-hppa parisc
 	cp seabios-hppa/out/hppa-firmware.img      ../pc-bios/
-- 
2.50.1


