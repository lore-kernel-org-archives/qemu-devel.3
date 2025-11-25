Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61400D0E6F0
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNu0I-0003ov-6C; Tue, 25 Nov 2025 09:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNu0G-0003mg-SU
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:26:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNu0D-0003Ny-U5
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764080804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PqlH0f1x/cKcYceC6NAoDFuSjaLJIjQacXn2fB++HBs=;
 b=GLkqbX4CPcd8IvlVhAflcnNEw9zSLhU1rP7JVt7Ja6w8zt3I1TVUSBwB6k/QLOSck7wX1F
 ysEnr5MEX6hmd1jrWB/DAJwF1TfjXje9k0fPwCInR6nfsirFhkDYrlIjF6XplCuBdNC6oa
 yki43Gk6M0UY/W+nZVvpksuaDV2WvKI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-hT-Dt9CaNWCoAzmVucahAA-1; Tue,
 25 Nov 2025 09:26:40 -0500
X-MC-Unique: hT-Dt9CaNWCoAzmVucahAA-1
X-Mimecast-MFC-AGG-ID: hT-Dt9CaNWCoAzmVucahAA_1764080799
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75383180047F; Tue, 25 Nov 2025 14:26:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 370B7195608E; Tue, 25 Nov 2025 14:26:33 +0000 (UTC)
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] aspeed/{xdma, rtc,
 sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN
Date: Tue, 25 Nov 2025 15:26:31 +0100
Message-ID: <20251125142631.676689-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-to:  =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
From:  =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When the XDMA, RTC and SDHCI device models of the Aspeed SoCs were
first introduced, their MMIO regions inherited of a DEVICE_NATIVE_ENDIAN
endianness. It should be DEVICE_LITTLE_ENDIAN. Fix that.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_xdma.c | 2 +-
 hw/rtc/aspeed_rtc.c   | 2 +-
 hw/sd/aspeed_sdhci.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 31662ea0f5cc..d9afb0cae1f7 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -113,7 +113,7 @@ static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps aspeed_xdma_ops = {
     .read = aspeed_xdma_read,
     .write = aspeed_xdma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index c4feea23a0b3..6793e253f472 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -131,7 +131,7 @@ static void aspeed_rtc_reset(DeviceState *d)
 static const MemoryRegionOps aspeed_rtc_ops = {
     .read = aspeed_rtc_read,
     .write = aspeed_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_aspeed_rtc = {
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 7217e20c2a98..339a8d12df26 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -124,7 +124,7 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps aspeed_sdhci_ops = {
     .read = aspeed_sdhci_read,
     .write = aspeed_sdhci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
 };
-- 
2.51.1


