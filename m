Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC54EC0219D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgR6l-0000wB-WE; Fri, 07 Feb 2025 11:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6V-0000u9-Tj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6U-0007ei-D0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738945277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLnalPDK5Dw5CE83Liep9DcgASL15xi5RCTTFoM4WJU=;
 b=emWCn9pzDIU104CxssBtyb+dus5e+QDZpUgCDSm0bE8CYYNkemFxA2eN8rXGFIgD4I44sX
 uOg78+O2D90SX4IldgMgoulsdp3CEU6dG7F30Bm6qWLWpISpFTkwjw5w7M0gzxAtaYC7xm
 WmIY5CJrJ4Pwr9qLE0KO0hZ6ej5ozHg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-E0q3J-dVOxqFu9AHSp0k1Q-1; Fri,
 07 Feb 2025 11:21:14 -0500
X-MC-Unique: E0q3J-dVOxqFu9AHSp0k1Q-1
X-Mimecast-MFC-AGG-ID: E0q3J-dVOxqFu9AHSp0k1Q
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4B6719560B9; Fri,  7 Feb 2025 16:21:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 613A31800878; Fri,  7 Feb 2025 16:21:10 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 07/10] accel/tcg: Simplify use of &first_cpu in
 rr_cpu_thread_fn()
Date: Fri,  7 Feb 2025 17:20:45 +0100
Message-ID: <20250207162048.1890669-8-imammedo@redhat.com>
In-Reply-To: <20250207162048.1890669-1-imammedo@redhat.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Let vCPUs wait for themselves being ready first, then other ones.
This allows the first thread to starts without the global vcpu
queue (thus &first_cpu) being populated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 accel/tcg/tcg-accel-ops-rr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 028b385af9..d9eadd5ec4 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -197,16 +197,19 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
-    while (first_cpu->stopped) {
-        qemu_cond_wait_bql(first_cpu->halt_cond);
+    while (cpu->stopped) {
+        CPUState *iter_cpu;
+
+        qemu_cond_wait_bql(cpu->halt_cond);
 
         /* process any pending work */
-        CPU_FOREACH(cpu) {
-            current_cpu = cpu;
-            qemu_wait_io_event_common(cpu);
+        CPU_FOREACH(iter_cpu) {
+            current_cpu = iter_cpu;
+            qemu_wait_io_event_common(iter_cpu);
         }
     }
 
+    g_assert(first_cpu);
     rr_start_kick_timer();
 
     cpu = first_cpu;
-- 
2.43.0


