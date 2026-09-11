Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C6FC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54IP-0005q7-JP; Fri, 11 Sep 2026 12:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54IN-0005ll-Rb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54IM-00072u-48
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xZxsb+MXYVOcFZg8ztTLLylkyJWXaelgAGqcUYHEZA=;
 b=EhgNO97Sc2HYjsmdxKlqkf5+ph25OgLAxTMPQY2vprDWWLBZ8CM1XRJvNZZ0satgFnE6Jl
 dVuLrxKlWxLnw0wf8za1O6aocbJv1B6lq2zGFNMf7foiLmkQkoCg3uD3URIts2jfglmU+r
 wYRfbRpV1YcsUnU1TJPqAmSpmZun2fc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-peq_1-_3NaqhbrIqU3dZGg-1; Fri,
 11 Sep 2026 12:40:06 -0400
X-MC-Unique: peq_1-_3NaqhbrIqU3dZGg-1
X-Mimecast-MFC-AGG-ID: peq_1-_3NaqhbrIqU3dZGg_1789144804
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65DDE1953964; Fri, 11 Sep 2026 16:40:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87C741800351; Fri, 11 Sep 2026 16:40:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:16 +0400
Subject: [PATCH v5 42/62] hw/s390-virtio-ccw: convert loadparm property to
 QAPI-aware registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-42-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+wSBO6Yrs9Pd23pJ8FlEO+Ge0DCPAboQHJQxxLgvCf0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC27zp/YBc9UWc3jKZsW95seUNcz0EC6K+8k/
 yXdW5RJ8mqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuwAKCRDa6OEJdZac
 5ThcD/sFf/ndHKBZJl5ymyLs1wz+/DiGz+rcH3xR2XvzWGiDw9BZOZADP3bRSCVrY/X8aJ/3fd6
 YDRCVvJ51JrCmNaRwRqIPAdRynQdcO0lsvNfXoeKYC0m9wK8+PO/sd0Ise/zvTODetEJgB8v5N6
 GLGIc1srwHIWkUQTZxHzHiPqE77KvkwkTTFH7ri0H0SuiOy1BIZ5OQNAoMMdwhHvud/1yr4ttjm
 O8IiQd752Ngc1nnt130TE46igX1BC40okboJE28G4FOfXAqpQHzgNCbcVTRZ8B4epS0UxY+0RjS
 yTGNx2mEmEdoyBBxG2Fmwrdtkfu7qsDatCzFQTGQlHXCexJzuiWmL21HT5RAa213LOuhNjqUZa+
 gE2E1IzTNYQauUlzzDrzLcSitJzYk349+XP3MTWTRsl8nrtBK9xFop4txH3MmjAUPVZve71O2zu
 0U7N1yCRXJs9Y3lq4rJ5EIvMv0cuCoqaJqYm4b8xO3g3ca2iGoE+kGML9ptm5COG6elqFbb1JxC
 l83YFDPJFkb5tow0Wed8Yf6kETscD4/JqvOU9pq0w2pj3EFtDGqUmf8Rpi67zOVViSiZBL4/v/0
 Dq9CtVl2Z/RRigjhZE7FjylSg7eIbKFJbiVNJmH4XskzZ7KSXEq0pt+qcr4Z3Sdslh69C5S+zZL
 uxUegMLYWIPVIow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QAPI type is actually a string. Here also, if we had typedef support
we could expose a more specific type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 17266779a6c1..1c8838aeabb6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -43,6 +43,7 @@
 #include "system/hostmem.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-machine-s390x.h"
 #include "hw/s390x/cpu-topology.h"
@@ -901,7 +902,8 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dea-key-wrap",
             "enable/disable DEA key wrapping using the CPACF wrapping key");
 
-    object_class_property_add(oc, "loadparm", "loadparm",
+    /* if QAPI learns to typedef str, we could expose a more specific type */
+    object_class_property_add_qapi(oc, "loadparm", &str_type_info,
                               machine_get_loadparm, machine_set_loadparm,
                               NULL, NULL);
     object_class_property_set_description(oc, "loadparm",

-- 
2.55.0.543.g5ebe2ebe4ea8


