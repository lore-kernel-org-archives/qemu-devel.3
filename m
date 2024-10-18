Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB293D3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n20-0005ji-BT; Fri, 18 Oct 2024 09:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1w-0005hw-HV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1u-0007PX-4t
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUpLyhDsLisQTXQlAbiU+CV4+/OCPpHi4uqHDEttUjo=;
 b=deMmZpCqrtM/ljHqe06pawYLVFba8zqzCYNEW6gz7EGUvk43rj55n54NMuR6GT+D6pEiXh
 wSNLf9QSHsLmSfTvzQ9kRMRdte9399OgdYkRtUVkYutDiRsR/BLgH58kUvjjJzExshziub
 zq8+G5vDfG3VBgNM6T6Z+V87vPyv/VI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-OySbELc-NcSu4Mops0s_sQ-1; Fri,
 18 Oct 2024 09:28:31 -0400
X-MC-Unique: OySbELc-NcSu4Mops0s_sQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C8461955F40; Fri, 18 Oct 2024 13:28:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CC7B19560AD; Fri, 18 Oct 2024 13:28:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 607F621E68BD; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 8/9] hw/intc/openpic: Improve errors for out of bounds property
 values
Date: Fri, 18 Oct 2024 15:28:23 +0200
Message-ID: <20241018132824.3379780-9-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
References: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The error message doesn't matter much, as the "openpic" device isn't
user-creatable.  But it's the last use of
QERR_PROPERTY_VALUE_OUT_OF_RANGE, which has to go.  Change the message
just like the previous commit did for x86 CPUs.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20241010150144.986655-7-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/openpic.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 32bd880dfa..cd3d87768e 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -41,7 +41,6 @@
 #include "hw/pci/msi.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
@@ -1535,9 +1534,7 @@ static void openpic_realize(DeviceState *dev, Error **errp)
     };
 
     if (opp->nb_cpus > MAX_CPU) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   TYPE_OPENPIC, "nb_cpus", (uint64_t)opp->nb_cpus,
-                   (uint64_t)0, (uint64_t)MAX_CPU);
+        error_setg(errp, "property 'nb_cpus' can be at most %d", MAX_CPU);
         return;
     }
 
-- 
2.46.0


