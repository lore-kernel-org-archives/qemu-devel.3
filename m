Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2A7CFC5E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 16:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sywS9-0008B2-Ez; Thu, 10 Oct 2024 12:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sywS5-0008Ae-R1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sywS4-0000ZN-3B
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 12:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728579346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=XBfZZa0Bj0Ph0CoBbr6Ixqccz4iCxg/EHl3zIVDQ5rs=;
 b=XrJG1zLgpUc+pXjGtLI7Dm3MmcApP0OnIX4JYBm8+ENTEo5FVshYMfsA5768kCEa7mWR/t
 sMNU+B1rmkzHyIwMFwMW9tsc0PWKSkX8q5zDQ9I/8Jrbg7Mlymm1Jc0pralCkHROAs/PSm
 oLwTouSvu6Y1x2kPs6q1B4Y1FRii6hE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-CkX644gYOJ-XsMse0WtW4g-1; Thu,
 10 Oct 2024 12:55:43 -0400
X-MC-Unique: CkX644gYOJ-XsMse0WtW4g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7871955EA8; Thu, 10 Oct 2024 16:55:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D95F419560AD; Thu, 10 Oct 2024 16:55:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9132921E6A28; Thu, 10 Oct 2024 18:55:37 +0200 (CEST)
Resent-To: michael.roth@amd.com, xieyongji@bytedance.com,
 Coiby.Xu@gmail.com, eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 philmd@linaro.org, qemu-block@nongnu.org, qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 10 Oct 2024 18:55:37 +0200
Resent-Message-ID: <87ttdjhp86.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Thu Oct 10 17:01:44 2024
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 26CB621E688F; Thu, 10 Oct 2024 17:01:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org, philmd@linaro.org
Subject: [PATCH v2 5/7] target/i386/cpu: Improve errors for out of bounds
 property values
Date: Thu, 10 Oct 2024 17:01:42 +0200
Message-ID: <20241010150144.986655-6-armbru@redhat.com>
In-Reply-To: <20241010150144.986655-1-armbru@redhat.com>
References: <20241010150144.986655-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
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
---
 target/i386/cpu.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4f8fa60432..de2c7041c5 100644
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



