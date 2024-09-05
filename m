Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F14DCE7A81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHxA-0002MW-TZ; Thu, 05 Sep 2024 15:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwe-0001yX-VE
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwd-0000P2-BR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725563702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alUAEDr3D8kX1ExQZOYYr6lYY+YVKOMO3eYCTi3IEFU=;
 b=TJgqAvng1Ja1QtiZUZnkxxgYEdk/IPGOwJX7HTvZg2Z7DGCI2aexA4xRj7KlzwoGpn/ryD
 pFVQJCGtX7DWc1mIWJjGI16TLrNeKyY+1CBFYgYnurJvNjgswSgAelMqvnxOdp/OB74Znv
 SxlnXIAiS3ro2DYz71RS3miqWFU+P5Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-LhFqtFulMJOMH_Emw00psw-1; Thu,
 05 Sep 2024 15:14:59 -0400
X-MC-Unique: LhFqtFulMJOMH_Emw00psw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF441955F79; Thu,  5 Sep 2024 19:14:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 166BD1956056; Thu,  5 Sep 2024 19:14:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] Revert "target/riscv: Restrict semihosting to TCG"
Date: Thu,  5 Sep 2024 21:14:33 +0200
Message-ID: <20240905191434.694440-8-thuth@redhat.com>
In-Reply-To: <20240905191434.694440-1-thuth@redhat.com>
References: <20240905191434.694440-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This reverts commit 10425887ba54241be1ce97f8935fc320332b531c.

Using "imply" instead of "select" is causing a build failure:

 /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o: in function `riscv_cpu_do_interrupt':
 .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined reference to `do_common_semihosting'

Thus revert to fix the build.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index c332616d36..5f30df22f2 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
+    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
+    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
     select DEVICE_TREE # needed by boot.c
-- 
2.46.0


