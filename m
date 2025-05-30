Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F03C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu0I-0000BU-GI; Fri, 30 May 2025 03:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKty0-0004cT-QS
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxz-0007Go-22
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bsGR6P2n2nWwYZ3I9TiiEhwHVTQVz9r029nSNBwgYg=;
 b=UytwZEWPlQIU0Fix2y9ghjwQEo3OPyRB4RE8tsdX9y3BShCbui7/DJ971fk2iOEC/hJVT1
 sOtIuM9zQuqeRrhe/hVEc6oPElifzYry5c71UTkRuqdPz2bJPRoRh20XSa7sarjmPbstZT
 eDV8nGajyMcZdzAUkSJDkSCcE5fW1mM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-EWtS7k6RN6qSMWK2sFEzyA-1; Fri, 30 May 2025 03:15:45 -0400
X-MC-Unique: EWtS7k6RN6qSMWK2sFEzyA-1
X-Mimecast-MFC-AGG-ID: EWtS7k6RN6qSMWK2sFEzyA_1748589344
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad556f5f1a9so128308266b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589343; x=1749194143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bsGR6P2n2nWwYZ3I9TiiEhwHVTQVz9r029nSNBwgYg=;
 b=oyvuQHYtiQ+t2z0sYN2k8XhwEbx9HYTTyPcs12J9SrRgYXGsM135LMSL2WoST348cP
 e4EB/goJpNU+6akn/zV9FSjEfKHt6wxKRNf/BnDSUfScvPQ9EcWK04DVt76Jy8GPV5tf
 9xFmMYO53ewqi1EzWyPSvPP9aesWig2jnUB0Qyop+/Tpyt8BVaZgGQwzgJEard7rOVVe
 /Ty/oPUXlyQZvV54cylb3B3nD+vDrWLRs4x7ph3yuh4DNKkNlWD8u8jjxSxmQ6swB6VK
 GGCeux7OQXq52G+nBI0ZG1HsvhVSoitOZaxFLlH5vcI2Oka6MLTyCeMnPug5cVBKD0hs
 BJlw==
X-Gm-Message-State: AOJu0YwMNa2GjfFLznBZMjmGP/FaS9P3gicbQpgVimNDP30SH4L7FOsO
 QJBQjVkY3Dn8/O7IZfgfL2nw0bO8V75kqBTU/2O7DmFJBneiVZJrzKGqL1W7fQSEMcBeoPxq/6C
 esMLVffDAs/UOrneVEqahpjULLHa472lGhnktOjLPBInd6gpbgzh8+AJyaAvgfJ4xJSG3OwUBbn
 B9scyXmhrIPoD8yAJmHELPy5vr7BRauW4fmjZ5CFE6
X-Gm-Gg: ASbGncsThuyIGRyACVkZV+xCSW/3WD5HTgksK2dOc/jEdR8+8K7PzMi6zAGIb67lh4b
 R1jO/ZWXNrcTB6vsiI31I4dF/nOL2mkcjJ6kB9/QOiCu9FgUtanVZG7fbCov5aVW6mSwlnQAXY1
 B+096uShECSmBhB83pR34UrjOI8ZGDt6xsNcK0Shm1yoQzvqYB/GeK1KXT34nFMFCyo3SjqlYSL
 DvAYdwg5DNxQo9r1xgM1JTJNvP3YQppv2bq0FNwf/PtNQEVgctMKre4qXiR0lGgHP/Z0bDvVD0K
 +nRL2S0a6lrrdw==
X-Received: by 2002:a17:907:3e1c:b0:ad5:4440:23 with SMTP id
 a640c23a62f3a-adb3244b548mr161464366b.50.1748589342827; 
 Fri, 30 May 2025 00:15:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcwtoLiqn4UmGr7lqYCAECSHXW5ARWf40vNak2UAoKB92TjnZBdACRka9zVV3Ulk5LBfpDYw==
X-Received: by 2002:a17:907:3e1c:b0:ad5:4440:23 with SMTP id
 a640c23a62f3a-adb3244b548mr161460266b.50.1748589341764; 
 Fri, 30 May 2025 00:15:41 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad3dd27sm274095466b.160.2025.05.30.00.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 68/77] i386/tdx: Validate phys_bits against host value
Date: Fri, 30 May 2025 09:12:38 +0200
Message-ID: <20250530071250.2050910-69-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

For TDX guest, the phys_bits is not configurable and can only be
host/native value.

Validate phys_bits inside tdx_check_features().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-55-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.h | 1 +
 target/i386/host-cpu.c | 2 +-
 target/i386/kvm/tdx.c  | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
index 6a9bc918baa..b97ec01c9be 100644
--- a/target/i386/host-cpu.h
+++ b/target/i386/host-cpu.h
@@ -10,6 +10,7 @@
 #ifndef HOST_CPU_H
 #define HOST_CPU_H
 
+uint32_t host_cpu_phys_bits(void);
 void host_cpu_instance_init(X86CPU *cpu);
 void host_cpu_max_instance_init(X86CPU *cpu);
 bool host_cpu_realizefn(CPUState *cs, Error **errp);
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index a2d3830f5bf..7512567298b 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -15,7 +15,7 @@
 #include "system/system.h"
 
 /* Note: Only safe for use on x86(-64) hosts */
-static uint32_t host_cpu_phys_bits(void)
+uint32_t host_cpu_phys_bits(void)
 {
     uint32_t eax;
     uint32_t host_phys_bits;
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index a55ab436ad9..0a21ae555c5 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -25,6 +25,7 @@
 
 #include "cpu.h"
 #include "cpu-internal.h"
+#include "host-cpu.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
@@ -879,6 +880,13 @@ static int tdx_check_features(X86ConfidentialGuest *cg, CPUState *cs)
         return -EINVAL;
     }
 
+    if (cpu->phys_bits != host_cpu_phys_bits()) {
+        error_report("TDX requires guest CPU physical bits (%u) "
+                     "to match host CPU physical bits (%u)",
+                     cpu->phys_bits, host_cpu_phys_bits());
+        return -EINVAL;
+    }
+
     return 0;
 }
 
-- 
2.49.0


