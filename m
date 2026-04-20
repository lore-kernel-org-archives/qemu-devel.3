Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65FCF588DE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEpGu-00033V-R1; Mon, 20 Apr 2026 10:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGn-00031D-3l
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wEpGb-0001Oh-9R
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 10:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776693982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EM1XmILPw6VzQiNknH3uHKB72whXoHpWgRXJ1BwNEY=;
 b=W4p5lg7NuSecCjR+iHS4qobY7ysCJZaLuhei9XNSEMJunOwqcAS6mTgCPYsvz1/d1L1Lnc
 U7mh5/a4cesoYRQZBtctrWkW8/ufhTvcxmHbal1wTdurZg4moHBWBNTjozCywAghrpwCuZ
 xAWdFm/z1WNLGYH5sDCWeOUo4KAbUzY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-3eLOvclhPVu2KyZ8aRGTYg-1; Mon,
 20 Apr 2026 10:06:18 -0400
X-MC-Unique: 3eLOvclhPVu2KyZ8aRGTYg-1
X-Mimecast-MFC-AGG-ID: 3eLOvclhPVu2KyZ8aRGTYg_1776693973
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C14271955DE2; Mon, 20 Apr 2026 14:06:13 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.74])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15F841800349; Mon, 20 Apr 2026 14:06:09 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v10 3/7] target/arm/machine: Handle ToleranceOnlySrcTestValue
 migration tolerance
Date: Mon, 20 Apr 2026 16:03:53 +0200
Message-ID: <20260420140552.104369-4-eric.auger@redhat.com>
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

Pass the value of the incoming register to
handle_cpreg_only_in_incoming_stream and check whether there is
a matching ToleranceOnlySrcTestValue tolerance.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/machine.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 8a698f601c6..35f1e4327f8 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1081,12 +1081,15 @@ static void handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
  * no cpreg mig tolerance is matched for this @kvmidx
  * Return true if the migration should eventually fail
  */
-static bool handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx)
+static bool
+handle_cpreg_only_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx, uint64_t value)
 {
     g_autofree gchar *name = print_register_name(kvmidx);
 
     if (arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
-                                          0, 0, ToleranceNotOnBothEnds)) {
+                                          0, 0, ToleranceNotOnBothEnds) ||
+        arm_cpu_match_cpreg_mig_tolerance(cpu, kvmidx,
+                                          value, 0, ToleranceOnlySrcTestValue)) {
         trace_tolerate_cpreg_only_in_incoming_stream(name);
         return false;
     }
@@ -1139,7 +1142,9 @@ static int cpu_post_load(void *opaque, int version_id)
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
             fail = handle_cpreg_only_in_incoming_stream(cpu,
-                                                        cpu->cpreg_vmstate_indexes[v++]);
+                                                        cpu->cpreg_vmstate_indexes[v],
+                                                        cpu->cpreg_vmstate_values[v]);
+            v++;
             continue;
         }
         /* matching register, copy the value over */
@@ -1162,7 +1167,8 @@ static int cpu_post_load(void *opaque, int version_id)
      */
     for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
         fail = handle_cpreg_only_in_incoming_stream(cpu,
-                                                    cpu->cpreg_vmstate_indexes[v]);
+                                                    cpu->cpreg_vmstate_indexes[v],
+                                                    cpu->cpreg_vmstate_values[v]);
     }
     if (fail) {
         return -1;
-- 
2.53.0


