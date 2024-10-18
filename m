Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF59D30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n20-0005jd-83; Fri, 18 Oct 2024 09:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1y-0005iN-5s
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1w-0007Q7-JM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELTbiLR5hOhveedIClubmCc02LrhhFa+4jBCPxM+J2w=;
 b=f5Bpxd5PmCI8CI/6RxBnjP6mLBfhdAKbaVrGVy1haNIr0pdZR2MXZaKXelFM4pOpjd4dKS
 t4/voel8SJmIqElW/7hh0VCdGcxn3dH80/lWa3KqcH4+JXpbSER9+WdKRtJ0t8slMTGGNK
 9gsS2mzntH628pPzy0oabndHPMXCHcM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-rywRtPSaO4Oj5RwQFhCRNA-1; Fri,
 18 Oct 2024 09:28:32 -0400
X-MC-Unique: rywRtPSaO4Oj5RwQFhCRNA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB34F195609D; Fri, 18 Oct 2024 13:28:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CCAA1956056; Fri, 18 Oct 2024 13:28:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CD7121E68B2; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 7/9] target/i386/cpu: Improve errors for out of bounds property
 values
Date: Fri, 18 Oct 2024 15:28:22 +0200
Message-ID: <20241018132824.3379780-8-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
References: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

The error message for a "stepping" value that is out of bounds is a
bit odd:

    $ qemu-system-x86_64 -cpu qemu64,stepping=16
    qemu-system-x86_64: can't apply global qemu64-x86_64-cpu.stepping=16: Property .stepping doesn't take value 16 (minimum: 0, maximum: 15)

The "can't apply global" part is an unfortunate artifact of -cpu's
implementation.  Left for another day.

The remainder feels overly verbose.  Change it to

    qemu64-x86_64-cpu: can't apply global qemu64-x86_64-cpu.stepping=16: parameter 'stepping' can be at most 15

Likewise for "family", "model", and "tsc-frequency".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20241010150144.986655-6-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/cpu.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cd0dfd03fd..5267dad850 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -31,7 +31,6 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-visit-machine.h"
-#include "qapi/qmp/qerror.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
@@ -5455,8 +5454,8 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
         return;
     }
     if (value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
-                   name ? name : "null", value, (int64_t)0, (int64_t)max);
+        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
+                   name ? name : "null", max);
         return;
     }
 
@@ -5494,8 +5493,8 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
         return;
     }
     if (value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
-                   name ? name : "null", value, (int64_t)0, (int64_t)max);
+        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
+                   name ? name : "null", max);
         return;
     }
 
@@ -5528,8 +5527,8 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
         return;
     }
     if (value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
-                   name ? name : "null", value, (int64_t)0, (int64_t)max);
+        error_setg(errp, "parameter '%s' can be at most %" PRIu64,
+                   name ? name : "null", max);
         return;
     }
 
@@ -5623,16 +5622,15 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     X86CPU *cpu = X86_CPU(obj);
-    const int64_t min = 0;
     const int64_t max = INT64_MAX;
     int64_t value;
 
     if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
-    if (value < min || value > max) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
-                   name ? name : "null", value, min, max);
+    if (value < 0 || value > max) {
+        error_setg(errp, "parameter '%s' can be at most %" PRId64,
+                   name ? name : "null", max);
         return;
     }
 
-- 
2.46.0


