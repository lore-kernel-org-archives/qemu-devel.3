Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41880C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA9V-00013L-LE; Fri, 11 Jul 2025 05:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA9H-0000wT-KM
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA9E-0007AS-Us
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWtEievjG9A7ikyV0ztzfsTqBUu4QLZA7wK7q31oSXY=;
 b=QMCoS/9YG4i7o4A4U5qMaRDAlSMwxbN2nq1F+Akra/gNMKbewImsbmOBGkPIFHQ/4esP8J
 Q3gTPzWYyy1zJCeohMJ0nVoosxTyp/SL0omaCU55+4xsSkUKo2sRQ3pwCROJN8vjrNTbIp
 ZRfCmPIJzdoV0WkYI7K5mhovcPV6I7o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-yAGZslTFMKe8CMwwxIDpNA-1; Fri,
 11 Jul 2025 05:34:24 -0400
X-MC-Unique: yAGZslTFMKe8CMwwxIDpNA-1
X-Mimecast-MFC-AGG-ID: yAGZslTFMKe8CMwwxIDpNA_1752226463
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CB6E19560AD; Fri, 11 Jul 2025 09:34:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A298E19560A3; Fri, 11 Jul 2025 09:34:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/15] target/s390x: Expose s390_count_running_cpus() method
Date: Fri, 11 Jul 2025 11:33:39 +0200
Message-ID: <20250711093340.608485-15-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

In order to simplify the next commit where s390_count_running_cpus()
is split out of s390_cpu_halt(), make its prototype public as a
preliminary step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250708095746.12697-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/s390x-internal.h | 1 +
 target/s390x/cpu-system.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 6894f0a2569..145e472edf0 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -238,6 +238,7 @@ uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uint64_t dst,
 
 /* cpu.c */
 #ifndef CONFIG_USER_ONLY
+unsigned int s390_count_running_cpus(void);
 unsigned int s390_cpu_halt(S390CPU *cpu);
 void s390_cpu_unhalt(S390CPU *cpu);
 void s390_cpu_system_init(Object *obj);
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 9b380e343c2..2fa8c4d75db 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -196,7 +196,7 @@ static bool disabled_wait(CPUState *cpu)
                             (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
 }
 
-static unsigned s390_count_running_cpus(void)
+unsigned s390_count_running_cpus(void)
 {
     CPUState *cpu;
     int nr_running = 0;
-- 
2.50.0


