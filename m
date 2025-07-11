Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162D6C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA9a-0001AQ-8E; Fri, 11 Jul 2025 05:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA9J-0000zT-Br
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA9H-0007As-Ed
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNxk96Ugqfn83itWttqsRHrcsZRRr/vZLQS2KZV1YB0=;
 b=VNJ3VSnX5XTGjnoXpdil4iTRP4RufJfG9Iy/QgmLtBGGuVyOWGLwREibatK55zQePu7qWB
 h3pmbpCpc9vKa2uoIVeEBazKkn4tQMOdsQKrJ9vhre/RkVFqX2LaTsNFDNdo4xoaLazAeB
 KBgOaQZOA7detSZoglC8UJ9GGAD9vs4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-Hc7QCq_JOuOlg7rfHkXgyg-1; Fri,
 11 Jul 2025 05:34:28 -0400
X-MC-Unique: Hc7QCq_JOuOlg7rfHkXgyg-1
X-Mimecast-MFC-AGG-ID: Hc7QCq_JOuOlg7rfHkXgyg_1752226467
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEA5D18001D1; Fri, 11 Jul 2025 09:34:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 642BC19560A3; Fri, 11 Jul 2025 09:34:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/15] target/s390x: Have s390_cpu_halt() not return anything
Date: Fri, 11 Jul 2025 11:33:40 +0200
Message-ID: <20250711093340.608485-16-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since halting a vCPU and how many left running do not need
to be tied together, split the s390_count_running_cpus()
call out of s390_cpu_halt() to the single caller using it:
s390_handle_wait().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250708095746.12697-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/s390x-internal.h | 2 +-
 target/s390x/cpu-system.c     | 4 +---
 target/s390x/helper.c         | 4 +++-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 145e472edf0..56cce2e7f50 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -239,7 +239,7 @@ uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
 /* cpu.c */
 #ifndef CONFIG_USER_ONLY
 unsigned int s390_count_running_cpus(void);
-unsigned int s390_cpu_halt(S390CPU *cpu);
+void s390_cpu_halt(S390CPU *cpu);
 void s390_cpu_unhalt(S390CPU *cpu);
 void s390_cpu_system_init(Object *obj);
 bool s390_cpu_system_realize(DeviceState *dev, Error **errp);
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 2fa8c4d75db..709ccd52992 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -214,7 +214,7 @@ unsigned s390_count_running_cpus(void)
     return nr_running;
 }
 
-unsigned int s390_cpu_halt(S390CPU *cpu)
+void s390_cpu_halt(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
     trace_cpu_halt(cs->cpu_index);
@@ -223,8 +223,6 @@ unsigned int s390_cpu_halt(S390CPU *cpu)
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
     }
-
-    return s390_count_running_cpus();
 }
 
 void s390_cpu_unhalt(S390CPU *cpu)
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 3c57c32e479..5c127da1a6a 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -91,7 +91,9 @@ void s390_handle_wait(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
 
-    if (s390_cpu_halt(cpu) == 0) {
+    s390_cpu_halt(cpu);
+
+    if (s390_count_running_cpus() == 0) {
         if (is_special_wait_psw(cpu->env.psw.addr)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
-- 
2.50.0


