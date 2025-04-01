Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08462C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 12:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzaVI-0007b8-Vl; Tue, 01 Apr 2025 08:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzaV9-0007Yi-0H
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzaV6-0007sP-Nx
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 08:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743509630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHyWBfhwSvn5fV1jNQgsMLAgbi4pwho06ghsplW9RKI=;
 b=XUaEZAlDvRr+P5BR7LuLQV0q23gszm12VGPHPdZf6nHgp2ggxv5QKBTaFFiiRNi9q3dElR
 KNJdG05ttQVoR8maSo5uI7B1mbAnbbWGVBifaNviC6EzUiV7JNjC6rzHca2uCyeSGyBD8o
 Mb7lmEMyeS1JE45rCpMwH0E+7p+n1XU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-DK7ZRI85MBKg9khoL4qM0w-1; Tue,
 01 Apr 2025 08:13:48 -0400
X-MC-Unique: DK7ZRI85MBKg9khoL4qM0w-1
X-Mimecast-MFC-AGG-ID: DK7ZRI85MBKg9khoL4qM0w_1743509627
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AB3E1954B38; Tue,  1 Apr 2025 12:13:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DF3D180B488; Tue,  1 Apr 2025 12:13:43 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/2] hw/misc/aspeed_scu: Correct minimum access size for
 AST2500 / AST2600
Date: Tue,  1 Apr 2025 14:13:36 +0200
Message-ID: <20250401121336.788924-3-clg@redhat.com>
In-Reply-To: <20250401121336.788924-1-clg@redhat.com>
References: <20250401121336.788924-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Joel Stanley <joel@jms.id.au>

Guest code was performing a byte load to the SCU MMIO region, leading
to the guest code crashing (it should be using proper accessors, but
that is not Qemu's bug). Hardware and the documentation[1] both agree
that byte loads are okay, so change all of the aspeed SCU devices to
accept a minimum access size of 1.

[1] See the 'ARM Address Space Mapping' table in the ASPEED docs. This
is section 6.1 in the ast2400 and ast2700, and 7.1 in the ast2500 and
ast2600 datasheets.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2636
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Troy Lee <leetroy@gmail.com>
Message-ID: <20241118021820.4928-1-joel@jms.id.au>
[PMD: Rebased, only including SCU changes]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Link: https://lore.kernel.org/qemu-devel/20250331230444.88295-3-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 6703f3f96914..1af1a35a081c 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -443,7 +443,7 @@ static const MemoryRegionOps aspeed_ast2500_scu_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
@@ -787,7 +787,7 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
+    .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
 };
-- 
2.49.0


