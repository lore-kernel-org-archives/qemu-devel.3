Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B47D3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n21-0005ki-Qx; Fri, 18 Oct 2024 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1y-0005iz-JY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1t1n1t-0007Oo-PE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlQmu/jBaqVvffDbQ3FpNPvwuk8rFn+3FbqwIY4nfdc=;
 b=WX1l3IF2Lfb3QoLTTItOC2JemaalahIsU30I3TyiVNuIdnDV2YGyKCPsMbqFbF6Z7JWoBC
 iERe+QTJnXs14FZjwPjxdciMFmxRHyJ2QZyVRVZot7XwePmgEGDjgrnlzbeh2KjFOFL4o9
 JPb2FhoemuQ/jXreNMM+e/iIVpmZ0Y8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-lMMfIUOzPBCuN3ZjjsHh-w-1; Fri,
 18 Oct 2024 09:28:31 -0400
X-MC-Unique: lMMfIUOzPBCuN3ZjjsHh-w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4E27195608F; Fri, 18 Oct 2024 13:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.150])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5DA7195607C; Fri, 18 Oct 2024 13:28:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 58EF221E6891; Fri, 18 Oct 2024 15:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 6/9] target/i386/cpu: Avoid mixing signed and unsigned in
 property setters
Date: Fri, 18 Oct 2024 15:28:21 +0200
Message-ID: <20241018132824.3379780-7-armbru@redhat.com>
In-Reply-To: <20241018132824.3379780-1-armbru@redhat.com>
References: <20241018132824.3379780-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Properties "family", "model", and "stepping" are visited as signed
integers.  They are backed by bits in CPUX86State member
@cpuid_version.  The code to extract and insert these bits mixes
signed and unsigned.  Not actually wrong, but avoiding such mixing is
good practice.

Visit them as unsigned integers instead.

This adds a few mildly ugly cast in arguments of error_setg().  The
next commit will get rid of them again.

Property "tsc-frequency" is also visited as signed integer.  The value
ultimately flows into the kernel, where it is 31 bits unsigned.  The
QEMU code freely mixes int, uint32_t, int64_t.  I elect not to attempt
draining this swamp today.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20241010150144.986655-5-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 target/i386/cpu.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0d30191482..cd0dfd03fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5433,13 +5433,13 @@ static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
 {
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
-    int64_t value;
+    uint64_t value;
 
     value = (env->cpuid_version >> 8) & 0xf;
     if (value == 0xf) {
         value += (env->cpuid_version >> 20) & 0xff;
     }
-    visit_type_int(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
@@ -5448,16 +5448,15 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
 {
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
-    const int64_t min = 0;
-    const int64_t max = 0xff + 0xf;
-    int64_t value;
+    const uint64_t max = 0xff + 0xf;
+    uint64_t value;
 
-    if (!visit_type_int(v, name, &value, errp)) {
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
-    if (value < min || value > max) {
+    if (value > max) {
         error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
-                   name ? name : "null", value, min, max);
+                   name ? name : "null", value, (int64_t)0, (int64_t)max);
         return;
     }
 
@@ -5475,11 +5474,11 @@ static void x86_cpuid_version_get_model(Object *obj, Visitor *v,
 {
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
-    int64_t value;
+    uint64_t value;
 
     value = (env->cpuid_version >> 4) & 0xf;
     value |= ((env->cpuid_version >> 16) & 0xf) << 4;
-    visit_type_int(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
@@ -5488,16 +5487,15 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
 {
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
-    const int64_t min = 0;
-    const int64_t max = 0xff;
-    int64_t value;
+    const uint64_t max = 0xff;
+    uint64_t value;
 
-    if (!visit_type_int(v, name, &value, errp)) {
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
-    if (value < min || value > max) {
+    if (value > max) {
         error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
-                   name ? name : "null", value, min, max);
+                   name ? name : "null", value, (int64_t)0, (int64_t)max);
         return;
     }
 
@@ -5511,10 +5509,10 @@ static void x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
 {
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
-    int64_t value;
+    uint64_t value;
 
     value = env->cpuid_version & 0xf;
-    visit_type_int(v, name, &value, errp);
+    visit_type_uint64(v, name, &value, errp);
 }
 
 static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
@@ -5523,16 +5521,15 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
 {
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
-    const int64_t min = 0;
-    const int64_t max = 0xf;
-    int64_t value;
+    const uint64_t max = 0xf;
+    uint64_t value;
 
-    if (!visit_type_int(v, name, &value, errp)) {
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
-    if (value < min || value > max) {
+    if (value > max) {
         error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
-                   name ? name : "null", value, min, max);
+                   name ? name : "null", value, (int64_t)0, (int64_t)max);
         return;
     }
 
-- 
2.46.0


