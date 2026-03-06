Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B01FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWiQ-0006Oj-NI; Fri, 06 Mar 2026 10:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vyWi6-00069i-DG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vyWi3-0003FP-4A
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772809401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p96kQNLPHjt51NI8Jf6fV3SS0XQNmXFWFSJxOsCfe6c=;
 b=RhYt2uBvBb2EujI/3zjbyS0mdBJT5o/OCY+xwefEPf51BBgi1Si48OJkbl1o2N3vrhwQzs
 YuJrxxohBO1LEzkx14lv4mPcnucnsubCQRUz/E9ENaCYYrD6dhMrXyYLf847cWasXF/LNK
 EGptp0euVQS7eDn5JAYJbDUHNMV9gmk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-rCXvBY0jOeeCCnlN2Ajcpw-1; Fri,
 06 Mar 2026 10:03:17 -0500
X-MC-Unique: rCXvBY0jOeeCCnlN2Ajcpw-1
X-Mimecast-MFC-AGG-ID: rCXvBY0jOeeCCnlN2Ajcpw_1772809396
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E6E718005B9; Fri,  6 Mar 2026 15:03:16 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.126])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B72283003EA4; Fri,  6 Mar 2026 15:03:12 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v9 2/6] target/arm/machine: Take account cpreg mig tolerances
 in case of mismatch
Date: Fri,  6 Mar 2026 16:02:20 +0100
Message-ID: <20260306150302.203112-3-eric.auger@redhat.com>
In-Reply-To: <20260306150302.203112-1-eric.auger@redhat.com>
References: <20260306150302.203112-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

If there is a mismatch between the cpreg indexes found on both ends,
check whether a tolerance was registered for the given kvmidx. If any,
silence warning/errors.

Create dedicated helper functions that print the name of the culprit reg
and analyze whether a tolerance is set. According set the level of traces
and analyze whether the migration must eventually fail.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/machine.c    | 21 +++++++++++++++------
 target/arm/trace-events |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 476dad00ee7..fa236431a8b 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1065,25 +1065,34 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
 {
     g_autofree gchar *name = print_register_name(kvmidx);
 
+    if (arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
+                                          0, 0, ToleranceNotOnBothEnds)) {
+        trace_tolerate_cpreg_missing_in_incoming_stream(name);
+        return;
+    }
     warn_report("%s: %s "
                 "expected by the destination but not in the incoming stream: "
                  "skip it", __func__, name);
 }
 
 /*
- * Handle the situation where @kvmidx is in the incoming stream
- * but not on destination. This currently fails the migration but
- * we plan to accomodate some exceptions, hence the boolean returned value.
+ * Handle the situation where @kvmidx is in the incoming
+ * stream but not on destination. This fails the migration if
+ * no cpreg mig tolerance is matched for this @kvmidx
+ * Return true if the migration shall eventually fail
  */
 static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
 {
     g_autofree gchar *name = print_register_name(kvmidx);
-    bool fail = true;
 
+    if (arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
+                                          0, 0, ToleranceNotOnBothEnds)) {
+        trace_tolerate_cpreg_only_in_incoming_stream(name);
+        return false;
+    }
     error_report("%s: %s in the incoming stream but unknown on the "
                  "destination: fail migration", __func__, name);
-
-    return fail;
+    return true;
 }
 
 static int cpu_post_load(void *opaque, int version_id)
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 2de0406f784..8502fb3265c 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -29,3 +29,5 @@ arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid
 
 # machine.c
 cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
+tolerate_cpreg_missing_in_incoming_stream(char *name) "%s is missing in incoming stream but this is explicitly tolerated"
+tolerate_cpreg_only_in_incoming_stream(char *name) "%s is in incoming stream but not on destination but this is explicitly tolerated"
-- 
2.53.0


