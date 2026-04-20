Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C9EF588CA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpGz-00034D-4p; Mon, 20 Apr 2026 10:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGZ-0002zs-MP
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGS-0001Nm-Fg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776693975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p01fZPFdY51Zmpaz9NyifZyaadu4zisCZRuTPFsPKmk=;
 b=DJ+H5oPSzMyJAM56m8Vi1z7OhEBVDp0M34CrygUnrtp3hCta9F7XzufzFuV1IprNLx6Btl
 x5rKBwm8GJWFZRA3GdFjnHx5vZ9jqDdg7IeepBgZ6D/4fDLtX2Ckc0HacBcXcU5PE8Xv3Z
 h7+17XDyS58zOFlZPiX4kbxuVQzJvhg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-exluTlvPNZ69tqYtia2L2Q-1; Mon,
 20 Apr 2026 10:06:10 -0400
X-MC-Unique: exluTlvPNZ69tqYtia2L2Q-1
X-Mimecast-MFC-AGG-ID: exluTlvPNZ69tqYtia2L2Q_1776693969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 992C319560B9; Mon, 20 Apr 2026 14:06:09 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5791F180047F; Mon, 20 Apr 2026 14:06:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v10 2/7] target/arm/machine: Handle ToleranceNotOnBothEnds
 migration tolerances
Date: Mon, 20 Apr 2026 16:03:52 +0200
Message-ID: <20260420140552.104369-3-eric.auger@redhat.com>
In-Reply-To: <20260420140552.104369-1-eric.auger@redhat.com>
References: <20260420140552.104369-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

---

v9 -> v10
- s/shall/should
- remove obsolete desc about helper in commit description
- Added Peter's R-b
- Reworded the commit message
---
 target/arm/machine.c    | 21 +++++++++++++++------
 target/arm/trace-events |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index b0e499515cf..8a698f601c6 100644
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
+ * Return true if the migration should eventually fail
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


