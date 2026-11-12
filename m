Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A5606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=feqS7LZ1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUy1-0004Cm-IU; Thu, 12 Nov 2026 08:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUue-0006fm-56
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuY-0005eD-A2
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Ip4eAmdj7Y2kMjGzT6/KXoFEkOpGrKno1Cfyl1j+v8=;
 b=feqS7LZ1uWVU5foElQjalfYxNx4fBKHg1hoPSAoLg2THKDeejw+Md+IB2mY/LFmwqjp/9l
 RbAaR8whTAEqyRrufBYDAczQRx9MG33YPWeb/84K23kR5lJUzFeniK3RF4V50AZsQ8ik71
 30Ah9jXPeEBsfRrDWsajMIUXNvXYzzk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-d6yODwcKM2ae9wdO6KKSFg-1; Thu,
 12 Nov 2026 08:32:13 -0500
X-MC-Unique: d6yODwcKM2ae9wdO6KKSFg-1
X-Mimecast-MFC-AGG-ID: d6yODwcKM2ae9wdO6KKSFg_1794490332
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C28E118F4744; Thu, 12 Nov 2026 13:32:12 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 582311956087; Thu, 12 Nov 2026 13:32:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 41/48] accel: make TYPE_ACCEL_CPU name target independent
Date: Thu, 12 Nov 2026 13:30:47 +0000
Message-ID: <20261112133054.1977618-42-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The TYPE_ACCEL_CPU QOM type name currently expands to a dynamic
string based on the target CPU resolving type name. So we have
a hierarchy that looks like:

   object
     +- accel-{x86_64,ppc64,riscv64,...}-cpu
         +- kvm-accel-x86_64-cpu
         +- tcg-accel-x86_64-cpu
         +- mshv-accel-x86_64-cpu
	 +- tcg-accel-riscv-cpu

where the middle class changes its name at runtime, so if leaf
CPU classes from different targets are linked together, their
immediate parent will be missing unless the selected target
matches.

The TYPE_ACCEL_CPU class is an abstract base class that does
not inherantly have target specific logic. It is expected to
be subclassed with children from different targets, and only
those childrenneed to have names derived from the CPU resolving
type name to ensure unique QOM naming.

IOW, TYPE_ACCEL_CPU can be given a fixed name while keeping
the same hierarchy structure:

   object
     +- accel-cpu
         +- kvm-accel-x86_64-cpu
         +- tcg-accel-x86_64-cpu
         +- mshv-accel-x86_64-cpu
	 +- tcg-accel-riscv-cpu

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 accel/accel-common.c             | 3 +--
 include/accel/accel-cpu-target.h | 3 +--
 include/accel/accel-cpu.h        | 2 ++
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/accel-common.c b/accel/accel-common.c
index 00a400243f0..05b1c44e1ed 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -132,9 +132,8 @@ DEFINE_TYPES(accel_types)
 
 static void register_accel_target_type(void)
 {
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
     const TypeInfo accel_cpu_type = {
-        .name = name,
+        .name = TYPE_ACCEL_CPU,
         .parent = TYPE_OBJECT,
         .abstract = true,
         .class_size = sizeof(AccelCPUClass),
diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 6feb344e29b..cf33ebd79fc 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -24,8 +24,7 @@
 #include "accel/accel-cpu.h"
 #include "cpu.h"
 
-#define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
-#define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
+#define ACCEL_CPU_NAME(name) (name "-accel-" CPU_RESOLVING_TYPE)
 DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
 
 #endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3c..809b7d21fd3 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -20,4 +20,6 @@ typedef struct AccelCPUClass {
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
+#define TYPE_ACCEL_CPU "accel-cpu"
+
 #endif /* ACCEL_CPU_H */
-- 
2.56.1


