Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB696CF11F5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 14:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syub0-000325-Mz; Thu, 10 Oct 2024 10:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syuaw-0002zY-Q1
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 10:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1syuav-0002m4-5L
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 10:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728572207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lp341gE5AEB1X9InS6vzxwFSt+sabArHeK8SLDvX+fw=;
 b=aHWlJttkxFIS5dRyumbQIX4IMisGCgDBx7W2l+/yEgaAGh4e1ddgg2aD+hTom0MhuI8IC0
 ueKpV+u+I354JL0SxMjee/C/zCGQ7bFCF2VLxi1GQ2FvHC4Em56IEi1c83MvUxQJMI7ELp
 lqFfJkPq6hS8yAk8sGrQzkTaHLbjvg8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-3XDkPId5NA2CmSioqKbeEg-1; Thu,
 10 Oct 2024 10:56:42 -0400
X-MC-Unique: 3XDkPId5NA2CmSioqKbeEg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE9851955F3F; Thu, 10 Oct 2024 14:56:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F329B300019E; Thu, 10 Oct 2024 14:56:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56F5B21E6889; Thu, 10 Oct 2024 16:56:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: xieyongji@bytedance.com, kwolf@redhat.com, hreitz@redhat.com,
 Coiby.Xu@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, mark.cave-ayland@ilande.co.uk, michael.roth@amd.com,
 kkostiuk@redhat.com, qemu-block@nongnu.org
Subject: [PATCH 4/7] target/i386/cpu: Avoid mixing signed and unsigned in
 property setters
Date: Thu, 10 Oct 2024 16:56:27 +0200
Message-ID: <20241010145630.985335-5-armbru@redhat.com>
In-Reply-To: <20241010145630.985335-1-armbru@redhat.com>
References: <20241010145630.985335-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Properties "family", "model", and "stepping" are visited as signed
integers.  They are backed by bits in CPUX86State member
@cpuid_version.  The code to extract and insert these bits mixes
signed and unsigned.  Not actually wrong, but avoiding such mixing is
good practice.

Visit them as unsigned integers instead.

This adds a few mildly ugly cast in arguments of error_setg().  The
next commit will get rid of them.

Property "tsc-frequency" is also visited as signed integer.  The value
ultimately flows into the kernel, where it is 31 bits unsigned.  The
QEMU code freely mixes int, uint32_t, int64_t.  I elect not to try
draining this swamp today.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/i386/cpu.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff227a8c5c..4f8fa60432 100644
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


