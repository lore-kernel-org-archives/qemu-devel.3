Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51DAC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUrp-00054p-2K; Wed, 22 Jan 2025 02:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUrf-0004tg-2Q
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUrd-0008MK-MV
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737529765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a5zRK4w93ha2FoItkWXVYXXXZYKCxwCxJZ1l8gtg9Sk=;
 b=FrI8KKJbrmjI9dUwfo6LAFNcdIpNsz2kj9z8drW77LztbHIrR+qbT/f5AwrW81AsKPbKSD
 BK+7/mghbRmC3DHg4OgWYLiG6yR74p7dM24nlwnFpMFYFCw5Cceq4FIAzubZwf1u9xW7tt
 QyvUG9IFMnezYd5BEF67RAJvMYwbj6w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-QdS95OjrOSutfgnV-LUefg-1; Wed,
 22 Jan 2025 02:09:19 -0500
X-MC-Unique: QdS95OjrOSutfgnV-LUefg-1
X-Mimecast-MFC-AGG-ID: QdS95OjrOSutfgnV-LUefg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B03CB1956050; Wed, 22 Jan 2025 07:09:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C3763003E7F; Wed, 22 Jan 2025 07:09:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/9] aspeed: pre-PR for QEMU 10.0 (RESEND)
Date: Wed, 22 Jan 2025 08:09:00 +0100
Message-ID: <20250122070909.1138598-1-clg@redhat.com>
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

Hello,

Here are the changes I plan to send as a PR for QEMU 10.0, this week
or the next. The last 3 patches still need a review. An Ack would be
appreciated.

Thanks,

C.

Cédric Le Goater (3):
  test/functional: Update the Aspeed aarch64 test
  test/functional: Update buildroot images to 2024.11
  aspeed: Create sd devices only when defaults are enabled

Jamin Lin (5):
  hw/sd/sdhci: Introduce a new Write Protected pin inverted property
  hw/arm/aspeed: Invert sdhci write protected pin for AST2600 EVB
  hw/timer/aspeed: Refactor Timer Callbacks for SoC-Specific
    Implementations
  hw/timer/aspeed: Add AST2700 Support
  aspeed/soc: Support Timer for AST2700

Kenneth Jia (1):
  hw/arm/aspeed: fix connect_serial_hds_to_uarts

 include/hw/arm/aspeed.h                     |   1 +
 include/hw/sd/sdhci.h                       |   5 +
 include/hw/timer/aspeed_timer.h             |   1 +
 hw/arm/aspeed.c                             |  15 +-
 hw/arm/aspeed_ast27x0.c                     |  17 ++
 hw/sd/sdhci.c                               |   6 +
 hw/timer/aspeed_timer.c                     | 263 ++++++++++++++++++--
 hw/timer/trace-events                       |   2 +-
 tests/functional/aspeed.py                  |   2 +-
 tests/functional/test_aarch64_aspeed.py     |   8 +-
 tests/functional/test_arm_aspeed_ast2500.py |   8 +-
 tests/functional/test_arm_aspeed_ast2600.py |   8 +-
 12 files changed, 303 insertions(+), 33 deletions(-)

-- 
2.48.1


