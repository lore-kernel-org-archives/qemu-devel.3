Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2D606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=axhgbEMr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtt-0005uX-PH; Thu, 12 Nov 2026 08:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtp-0005u7-Kq
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtm-0002Ir-8J
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mD7HEUdihQNVf6P9p46SI4wSm6+WgjyaOYOewM+v5Q=;
 b=axhgbEMrPeFYgnFfs6D8f3C+06ScoUoLo6HV/r0nS9tMmz56BtDey1yNzeTE57qXSZcmlI
 lvt9F9wYSThTViN5BG731ZnOxmOqsJOAIEF00jIS2ypRpcIeFr3tBCfyQKqDSNpTslYI1u
 9qcU+X3nYIic/H8h3f5AckvpuliamTI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-8HxXDR4wON23hrZqWqtkJQ-1; Thu,
 12 Nov 2026 08:31:25 -0500
X-MC-Unique: 8HxXDR4wON23hrZqWqtkJQ-1
X-Mimecast-MFC-AGG-ID: 8HxXDR4wON23hrZqWqtkJQ_1794490284
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3E8918867A3; Thu, 12 Nov 2026 13:31:23 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7658A1956087; Thu, 12 Nov 2026 13:31:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/48] hw/hexagon: convert machines to use AliasedClass
 interface
Date: Thu, 12 Nov 2026 13:30:20 +0000
Message-ID: <20261112133054.1977618-15-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stop setting 'alias' in the MachineClass and instead set
'aliases' in the AliasedClass.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/hexagon/hexagon_dsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index eddf69545ee..584b943cebf 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -38,6 +38,7 @@
 #include "machine_cfg_v81qa_1.h.inc"
 #include "machine_cfg_v85na_1.h.inc"
 #include "machine_cfg_v85qa_1.h.inc"
+#include "qom/object_interfaces.h"
 
 #define TYPE_HEXAGON_DSP_MACHINE "hexagon-dsp-machine"
 #define HEXAGON_DSP_SUBSYSTEM_BASE 0xfc900000
@@ -365,9 +366,13 @@ static void v85na_1_config_init(MachineState *machine)
 static void v85na_1_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(oc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("sim"), NULL,
+    };
 
     mc->desc = "Hexagon V85NA_1";
-    mc->alias = "sim";
+    alc->aliases = aliases;
     mc->init = v85na_1_config_init;
     init_mc(mc);
     mc->default_cpu_type = TYPE_HEXAGON_CPU_V85;
-- 
2.56.1


