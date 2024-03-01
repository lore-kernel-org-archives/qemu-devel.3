Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA15C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxy7-0003Hy-AQ; Fri, 01 Mar 2024 03:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxy5-0003Ha-3B
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxy2-0006lG-Vp
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709280606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cCdf7f1T+r4pVrPujKD3HOYu9xi0RFQUEBpK5PJk+I=;
 b=XWSzHPD8npV+C1m8tndJ2uFpuC4xk0lASWt4PdcBpXD7sTok1+7n7hNv3S6E4zAIJXrKei
 v/JofZAXuFxah7XH/a0bRXO1RT2+DOEas+5B+vH1fpZ7YqY79x6NRviTkIs5+/A8HmGeL5
 IcQ/YcQuNyuiG3Qk1CLONJu06p9vN+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-FiEjlB4qMz2_MXl9Sn-81Q-1; Fri, 01 Mar 2024 03:09:59 -0500
X-MC-Unique: FiEjlB4qMz2_MXl9Sn-81Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4828E8477A4;
 Fri,  1 Mar 2024 08:09:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31FE120227BD;
 Fri,  1 Mar 2024 08:09:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 3/6] hw/intc/Kconfig: Fix GIC settings when using
 "--without-default-devices"
Date: Fri,  1 Mar 2024 09:09:50 +0100
Message-ID: <20240301080953.66448-4-thuth@redhat.com>
In-Reply-To: <20240301080953.66448-1-thuth@redhat.com>
References: <20240301080953.66448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

Message-ID: <20240221110059.152665-1-thuth@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
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
2.44.0


