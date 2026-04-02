Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDDED39403
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Eiw-00079C-En; Thu, 02 Apr 2026 05:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eiu-00078j-6d
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eis-0008T0-4y
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sPFlzk9ZLlZHPOcJhaP/VkTFHtoZ9xuGlVYtWm9rC1k=;
 b=MNK30biTDm96fwJ578FEh6uuymQ3y0mKKphVd/ne+oEx/YzOR5l1W/7UkR1yc58hXB32wD
 TpzKdwJX5FLY/aJz1iqVdZJmKJlg4AJl4IpGF/H5ouhC9nYhr0JCasBWz9/5Sho1AOPgAf
 b1itlgAt1IE8Z5jtC7TO/K7H/hq1/FM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-1vhEy7nAPBuHaAth0OIBwQ-1; Thu,
 02 Apr 2026 05:52:12 -0400
X-MC-Unique: 1vhEy7nAPBuHaAth0OIBwQ-1
X-Mimecast-MFC-AGG-ID: 1vhEy7nAPBuHaAth0OIBwQ_1775123531
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4325195609E; Thu,  2 Apr 2026 09:52:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C847819373D8; Thu,  2 Apr 2026 09:52:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 08/10] hw/i386/isapc: Adjust the check for valid CPUs in the
 isapc machine
Date: Thu,  2 Apr 2026 11:51:30 +0200
Message-ID: <20260402095132.29245-9-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Now that we can run in both, x86_64 and i386 mode with one binary,
we must not hard-code the suffix of the CPU names here anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.h |  1 +
 hw/i386/isapc.c   | 18 ++++++++++--------
 target/i386/cpu.c |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 38309773ea8..78f2dadc2e3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2722,6 +2722,7 @@ void mark_unavailable_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                                const char *verbose_prefix);
 void mark_forced_on_features(X86CPU *cpu, FeatureWord w, uint64_t mask,
                              const char *verbose_prefix);
+char *x86_cpu_type_name(const char *model_name);
 
 static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 {
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 1ba9ae22cc3..c772b7f533a 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -43,13 +43,13 @@ static void pc_init_isa(MachineState *machine)
 
     bool valid_cpu_type = false;
     static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
+        "486",
+        "athlon",
+        "kvm32",
+        "pentium",
+        "pentium2",
+        "pentium3",
+        "qemu32",
     };
 
     /*
@@ -59,8 +59,10 @@ static void pc_init_isa(MachineState *machine)
      * a warning if anyone tries to use a deprecated CPU.
      */
     for (i = 0; i < ARRAY_SIZE(valid_cpu_types); i++) {
-        if (!strcmp(machine->cpu_type, valid_cpu_types[i])) {
+        g_autofree char *valid_cpu = x86_cpu_type_name(valid_cpu_types[i]);
+        if (!strcmp(machine->cpu_type, valid_cpu)) {
             valid_cpu_type = true;
+            break;
         }
     }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 98e03cb9a88..a8ff1b29f33 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2274,7 +2274,7 @@ void host_cpuid(uint32_t function, uint32_t count,
 /* Return type name for a given CPU model name
  * Caller is responsible for freeing the returned string.
  */
-static char *x86_cpu_type_name(const char *model_name)
+char *x86_cpu_type_name(const char *model_name)
 {
     if (target_i386()) {
         return g_strdup_printf("%s" I386_CPU_TYPE_SUFFIX, model_name);
-- 
2.53.0


