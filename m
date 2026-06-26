Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EECD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dV-0006hQ-Jc; Fri, 26 Jun 2026 06:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dR-0006ge-L1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dP-00058c-IF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwzXuwEdB0BbvXaBC7AB+nn3Hymet5lsLzgBQBOt6m0=;
 b=Jhz2JqywBIXEUJl1gHFYc2BDET+OPzOYBZzOQfkTAxtU08142uiUAtP6EijPyzOm2UURms
 fqkirywK1bUpeQ0cBaTFlt1ZtEqpKhv0/cv1ZVWvv3lya3jQI1zdYgvdjjudOVWaKmyedA
 N3TMKa3xKWyBP5NAW7I9AhclWqRrzqM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-x_oe0q7iNkapuwzKdROMvw-1; Fri, 26 Jun 2026 06:18:04 -0400
X-MC-Unique: x_oe0q7iNkapuwzKdROMvw-1
X-Mimecast-MFC-AGG-ID: x_oe0q7iNkapuwzKdROMvw_1782469083
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49244130073so5946735e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469083; x=1783073883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwzXuwEdB0BbvXaBC7AB+nn3Hymet5lsLzgBQBOt6m0=;
 b=PtDe6EhAloduQyGpOeEO0b+JiFMnkVcPZDDkX8vtlqmsqD9f3jx1W3+LSh6raNLmcw
 beMAo/OYlR0+XWvFQGa6UsGz8A4G/l8TV1vrRa3r9khwypdSAc1jOt37VqpBuOxEt1kt
 LeusXZ60HZ6FCPddp398OvmF9qeea1/GAEdFnUvc6nl1nS42ASAJM6iy5s/+pvEdIYDN
 WcjhWcu/ferz7i9kBF+ls6m5+QqRfHCQi6GgmoZm7tVwMucRj3mls1hathYZZodtZ378
 lqB3j3Hzuu6AThl2Wy/gyuwXs5/1vojYCu6VWw7TMVWQOkaHb9OiGpZQa9+OPvZOXjFW
 1cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469083; x=1783073883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AwzXuwEdB0BbvXaBC7AB+nn3Hymet5lsLzgBQBOt6m0=;
 b=gBBdE1DvtC5eGtv39pX+hPA+kIv2LQA2ja/6qIJ0XCUv73UYU4ROpaDDJqs7I8WC0Z
 6RffoUPK9i0hkzHGEJZr9qZCuxgGsgQ73XdG4VOfCdcQRMyFhZ1ahV7VMQLTMy3GCqE2
 s3Cl6sqKR6ioPIEsTY5hW4FGx9742VHQlqHW6s6juRLBCnq5UBOteSOzdmXPM0cU1hV0
 BhAkCItAdUp9pLsic2KR45hQBrX0HncCVpQ2SzA2NRtuiEiOl9/gHngRg3ywutgBln9e
 +B6CitNtLWVoKMLBv8WobjNFAQf6/pJiWUpX21nehAbyWFyd8Z6micKf4/Zzo2mMlCIG
 1ISw==
X-Gm-Message-State: AOJu0YwtbsL0F5WnddRvCPK2k19JXIByKMSeQqbcK9JQsW1w/1NMr9i7
 n6JUdO89xlynUsdpAT3DqIhve/XfAhhGrnhbb101PZ/w3ZehCsVMJSiA2hnDxHvNSPkWB8m0TWl
 HCLIqw1cab8u5Rl/L7bzmHEiSVatRDoP74FyH8uIPXs9aCkM6AXsAVEtLBj4ap6SP6vFpk4CFI/
 CYDVOtzl3F2dvM9Q+VEWWxYoDTkj3Xvx8UE/2+EvD6
X-Gm-Gg: AfdE7cnRA5VKXAgubYnjW3EbeukWU2ZlHpt93USfg0vBUWLp0OlZgtmf3d4x3N/aFBg
 ZempRp0PrxqokN4GWI5MYUGQpBbDSZj7SAvydIqlJaVKPVa9lmZ5+afj4FA0lnukhZP7z4+MIDh
 iGClFTS42Wo/uVXzB1gocUdV6oybPPj1CxPr5rTjgYUyjIucsTmLhCnQlwcpY6bQ6iOb925QrDl
 H7Hjb/CviBaS5TzvThGHHEoBw4z42dXoPutw1f+B3CKE7wOOS4SJZ/haV33k18kFJlMaVuNqsOw
 Q/ipedv5dzHTR5on1zaYma020Y3xbT9A1Kb5rIXPJckh/CX+jRt7fkLW97RVpzSZwZLWvzo0Th2
 gdTF40hcLk+zn0MU90x8b5U7SIYV++6ptdsERs4CkXBvfrcSXN1oDqxFMIdARs4907FB5ADsFoG
 mswxMtsvXV7Phg3xDk
X-Received: by 2002:a05:600c:4e4b:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-49266872cd7mr83715865e9.10.1782469082904; 
 Fri, 26 Jun 2026 03:18:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4b:b0:490:e196:eaee with SMTP id
 5b1f17b1804b1-49266872cd7mr83715385e9.10.1782469082347; 
 Fri, 26 Jun 2026 03:18:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ffe204sm69038275e9.7.2026.06.26.03.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 05/45] target/i386/mshv: set cpu model name on -cpu host
Date: Fri, 26 Jun 2026 12:17:08 +0200
Message-ID: <20260626101748.1728079-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

By registering a cpu_accel_class for mshv, we can report an accurate
model name on -cpu host.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-6-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2ee46bd7025..d65cba5de15 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -24,10 +24,13 @@
 #include "hw/i386/apic_internal.h"
 
 #include "cpu.h"
+#include "host-cpu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
 
+#include "accel/accel-cpu-target.h"
+
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
@@ -1700,3 +1703,31 @@ int mshv_arch_post_init_vm(int vm_fd)
 
     return ret;
 }
+
+static void mshv_cpu_instance_init(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    host_cpu_instance_init(cpu);
+}
+
+static void mshv_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = mshv_cpu_instance_init;
+}
+
+static const TypeInfo mshv_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("mshv"),
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = mshv_cpu_accel_class_init,
+    .abstract = true,
+};
+
+static void mshv_cpu_accel_register_types(void)
+{
+    type_register_static(&mshv_cpu_accel_type_info);
+}
+
+type_init(mshv_cpu_accel_register_types);
-- 
2.54.0


