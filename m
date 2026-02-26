Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069FCFC591C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYDF-0003jc-Hl; Thu, 26 Feb 2026 05:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYD4-0003c8-KS
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vvYD3-0000aX-4O
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772100182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kufE9pPfhEf1yUFIFrxcGPy83C/DSKq8tZO7XjOggeY=;
 b=aa/PiFYrsQXFqUGj5iXd1yKy0wmGUYc/FB88IYovRXNPZ0eJQUapa7QvezLk5LSdNEkATV
 vybVGhfBM2TOcrWCOBNCBp246qfHublp8FRxjl0c5cFzzfVP5cyxbUSYeA2paPK5BY3K/d
 16K+1i51WDRdebG8+YFLwbcm41AXBNk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-cMAhiU7KMwiXJvdxLBxpkw-1; Thu,
 26 Feb 2026 05:02:58 -0500
X-MC-Unique: cMAhiU7KMwiXJvdxLBxpkw-1
X-Mimecast-MFC-AGG-ID: cMAhiU7KMwiXJvdxLBxpkw_1772100177
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71EB418003F6; Thu, 26 Feb 2026 10:02:57 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.35.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07DBF1800370; Thu, 26 Feb 2026 10:02:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 sebott@redhat.com, peterx@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH 5/5] target/arm/machine: Trace all register mismatches
Date: Thu, 26 Feb 2026 11:01:33 +0100
Message-ID: <20260226100232.500781-6-eric.auger@redhat.com>
In-Reply-To: <20260226100232.500781-1-eric.auger@redhat.com>
References: <20260226100232.500781-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

At the moment, cpu_post_load() exists with error on the first
catch of unexpected register in the incoming stream. Let the code
go further and trace all the issues before exiting.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/machine.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index ee68e752ea9..7a3b5a87932 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1050,6 +1050,7 @@ static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu = opaque;
     CPUARMState *env = &cpu->env;
+    bool fail = false;
     int i, v;
 
     trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
@@ -1082,13 +1083,14 @@ static int cpu_post_load(void *opaque, int version_id)
      */
 
     for (i = 0, v = 0; i < cpu->cpreg_array_len
-             && v < cpu->cpreg_vmstate_array_len; i++) {
+             && v < cpu->cpreg_vmstate_array_len;) {
         if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
             g_autofree gchar *name = print_register_name(cpu->cpreg_indexes[i]);
 
             warn_report("%s: %s "
                         "expected by the destination but not in the incoming stream, "
                         "skip it", __func__, name);
+            i++;
             continue;
         }
         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
@@ -1096,12 +1098,18 @@ static int cpu_post_load(void *opaque, int version_id)
 
             error_report("%s: %s in the incoming stream but unknown on the destination, "
                          "fail migration", __func__, name);
-            return -1;
+            v++;
+            fail = true;
+            continue;
         }
         /* matching register, copy the value over */
         cpu->cpreg_values[i] = cpu->cpreg_vmstate_values[v];
+        i++;
         v++;
     }
+    if (fail) {
+        return -1;
+    }
 
     if (kvm_enabled()) {
         if (!kvm_arm_cpu_post_load(cpu)) {
-- 
2.53.0


