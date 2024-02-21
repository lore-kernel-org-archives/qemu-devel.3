Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2EBC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoak-0001gk-8J; Wed, 21 Feb 2024 10:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcoU5-0000w0-5P
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:26:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rckLa-0000xt-Hn
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708513264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OMHhrbAanmo5lu+1OAkkg62WenW49sTgp4urIrYlrhY=;
 b=Qmrpo/dfpRUGANuWiqRjRNRhq3vsTMxHX+I+kZATBGyTyvsFPGw+oX7/PX7c6QHxAT/1qM
 yk3s7Bsx702q+SLwEEC2AdVkxP0h3fkulSOYPlcWP4mmkTMpQJQA0kAqvE6eK/ikW27D/s
 0DAPWC6CrvTWfWcPNeNsXEhcb/xoKWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-S4ruVI8iNoq71RCxv7i-OA-1; Wed, 21 Feb 2024 06:01:02 -0500
X-MC-Unique: S4ruVI8iNoq71RCxv7i-OA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C13E811E81;
 Wed, 21 Feb 2024 11:01:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C69371C060AF;
 Wed, 21 Feb 2024 11:01:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] hw/intc/Kconfig: Fix GIC settings when using
 "--without-default-devices"
Date: Wed, 21 Feb 2024 12:00:59 +0100
Message-ID: <20240221110059.152665-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When using "--without-default-devices", the ARM_GICV3_TCG and ARM_GIC_KVM
settings currently get disabled, though the arm virt machine is only of
very limited use in that case. This also causes the migration-test to
fail in such builds. Let's make sure that we always keep the GIC switches
enabled in the --without-default-devices builds, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/intc/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 97d550b06b..2b5b2d2301 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -12,10 +12,6 @@ config IOAPIC
     bool
     select I8259
 
-config ARM_GIC
-    bool
-    select MSI_NONBROKEN
-
 config OPENPIC
     bool
     select MSI_NONBROKEN
@@ -25,14 +21,18 @@ config APIC
     select MSI_NONBROKEN
     select I8259
 
+config ARM_GIC
+    bool
+    select ARM_GICV3_TCG if TCG
+    select ARM_GIC_KVM if KVM
+    select MSI_NONBROKEN
+
 config ARM_GICV3_TCG
     bool
-    default y
     depends on ARM_GIC && TCG
 
 config ARM_GIC_KVM
     bool
-    default y
     depends on ARM_GIC && KVM
 
 config XICS
-- 
2.43.2


