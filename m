Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07805CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvL-0004eU-Kr; Mon, 13 Oct 2025 08:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvA-0004Vk-RB
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hv1-0007vo-No
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9vgsJ6bfc1NYPsE3zN5lYySPC6wzDYbQwka3TMd7pQ=;
 b=cCPArEot1Ezk4ktKQcyNJmPP5Z5PqqdjC/me58yJ5FXd4b4fMsvozK1WLaRqNBslP6TJEH
 JnMrtQFsp6WOtzDcSy6AZAyfUGhFbXjFUM3YCUrDTH4lciIaop/zXdao3APEGISFLnVaGM
 S+ASSYDIuZmSK6T983ieKtQZnwcKIuc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-EEYH1uyiMuaM28RLlcOMJQ-1; Mon,
 13 Oct 2025 08:44:47 -0400
X-MC-Unique: EEYH1uyiMuaM28RLlcOMJQ-1
X-Mimecast-MFC-AGG-ID: EEYH1uyiMuaM28RLlcOMJQ_1760359486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7845B18004D4; Mon, 13 Oct 2025 12:44:46 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06BE0180047F; Mon, 13 Oct 2025 12:44:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Wang <wangzq.jn@gmail.com>
Subject: [PULL 11/29] aspeed: Deprecate the fp5280g2-bmc machine
Date: Mon, 13 Oct 2025 14:44:02 +0200
Message-ID: <20251013124421.71977-12-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

There are no functional tests for the 'fp5280g2-bmc' machine which
makes harder to determine when something becomes deprecated or unused.

Since the machine does not rely on any specific device models, it can
be replaced by the 'ast2500-evb' machine using the 'fmc-model' option
to specify the flash type. The I2C devices connected to the board can
be defined via the QEMU command line.

Cc: John Wang <wangzq.jn@gmail.com>
Link: https://lore.kernel.org/qemu-devel/20251007141604.761686-4-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/arm/aspeed.c           | 1 +
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f6410037ead2..98361f5832dc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -304,6 +304,14 @@ machine using the ``fmc-model`` option to specify the flash type. The
 I2C devices connected to the board can be defined via the QEMU command
 line.
 
+Arm ``fp5280g2-bmc`` machine (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''
+
+The ``fp5280g2-bmc`` machine does not rely on any specific device
+models, it can be replaced by the ``ast2500-evb`` machine using the
+``fmc-model`` option to specify the flash type. The I2C devices
+connected to the board can be defined via the QEMU command line.
+
 RISC-V default machine option (since 10.0)
 ''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 0707a760fda6..e73185eeb35c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1626,6 +1626,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->desc       = "Inspur FP5280G2 BMC (ARM1176)";
+    mc->deprecation_reason = "use 'ast2500-evb' instead";
     amc->soc_name  = "ast2500-a1";
     amc->hw_strap1 = FP5280G2_BMC_HW_STRAP1;
     amc->fmc_model = "n25q512a";
-- 
2.51.0


