Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B910CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLh1h-0008Of-1E; Thu, 12 Dec 2024 06:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLh1b-0008O7-DO
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLh1Z-000374-V5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734001589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JKKe1O7fIVAp2X/jfDGvzroQOsjwRVp4kDmSy7Ems8k=;
 b=E21gPI+F9aJb6NyI4XTV243K82rUkq5+eqVzwN/FHg6HhQQGiUR5qLmqQZjJLd6bZvJ8bb
 GauriYD2GBIuWf5tsq/67pcog9wU9GuvgjZPqcmP8jJq0AF5ZIyDsJHqyMCRY7+YK6+uaz
 jEDJOcYkOiJ2Ra0flaNADYHjR5cFN58=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-xG_BDXU-ODaTHVTFT64Bnw-1; Thu,
 12 Dec 2024 06:06:26 -0500
X-MC-Unique: xG_BDXU-ODaTHVTFT64Bnw-1
X-Mimecast-MFC-AGG-ID: xG_BDXU-ODaTHVTFT64Bnw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A72819560A2; Thu, 12 Dec 2024 11:06:25 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.114])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 810731956086; Thu, 12 Dec 2024 11:06:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/4] qapi: cope with  feature names containing a '-'
Date: Thu, 12 Dec 2024 11:06:13 +0000
Message-ID: <20241212110616.3147676-2-berrange@redhat.com>
In-Reply-To: <20241212110616.3147676-1-berrange@redhat.com>
References: <20241212110616.3147676-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

When we shortly expose all feature names to code, it will be valid to
include a '-', which must be translated to a '_' for the enum constants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/gen.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 6a8abe0041..c53ca72950 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -24,6 +24,7 @@
 )
 
 from .common import (
+    c_enum_const,
     c_fname,
     c_name,
     guardend,
@@ -41,7 +42,7 @@
 
 
 def gen_special_features(features: Sequence[QAPISchemaFeature]) -> str:
-    special_features = [f"1u << QAPI_{feat.name.upper()}"
+    special_features = [f"1u << {c_enum_const('qapi', feat.name)}"
                         for feat in features if feat.is_special()]
     return ' | '.join(special_features) or '0'
 
-- 
2.46.0


