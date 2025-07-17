Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06754C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucThq-00087q-6u; Thu, 17 Jul 2025 14:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8b-0002tV-Tm
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucR8Z-0002FY-FS
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 12:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752768430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Xv86/Rz+8Kqo5xHCX7FN9w/MZvl13ciifCpIY3ePjE=;
 b=MI4s6AekRDGKVYJKM+2Ef4LFbCF7AjOmDPGebW4Tx5AAJtu3i/+5rhBfrk4hQGyaNHpJoe
 Ixor/qZqymNmLm22jRzahWfVpeRnuUKW3Ityyi0Yl+mWMViwsE1fztZ5tzv23ChwiicOln
 JZP6aeSBvYkL8Qzt0F7GAai7t0LDlD0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-xNmZR99gOsetjEJBYIJwfA-1; Thu, 17 Jul 2025 12:07:08 -0400
X-MC-Unique: xNmZR99gOsetjEJBYIJwfA-1
X-Mimecast-MFC-AGG-ID: xNmZR99gOsetjEJBYIJwfA_1752768427
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5058f9ef4so499401f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 09:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752768426; x=1753373226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Xv86/Rz+8Kqo5xHCX7FN9w/MZvl13ciifCpIY3ePjE=;
 b=vF6yxj1N1Psr9U4suh6jgdglHdWrSNo3KZAxRaBe9dWbTjKcjIT2P13CT7LAx2yE+9
 dV3/PPn9Q15j+tsgmhfN9vswvvlVTD4AUhb0pRCpAZ9UoZ2Amhwr02deoH55xQ0QhZx1
 gJrVKZmB6pvt104Dy8Wb+yCCVNTT6Wf00j4DbUV4EAXI4pqhYT6nHLU3TEXzHqqmZb3x
 OTNN6Koqab8S6jjntkULqJITwP9cuWk4YnS4i5x7GXTLZ/Eeqx5XLeptryn09Nk3wNP1
 QyenZqu+AwFfjeBhb2WLcR+hQktWwm7EmgijRmVF3eSRWXDxYX3DmjLno8epbu9cUp5o
 mkhw==
X-Gm-Message-State: AOJu0Yx0Rf2Q5TPQsPK+Rv3ZWw8Rf3KbHkaj9nCBAf+fQWSScFdo63y1
 /yyJ2beRCOjnUgXW4clD8BwZtSGlbNIt0B29ZXI8CH4snyqRGKP27VgQNREjyy8f7zxXA8PUFN+
 r4I28OmUCFCgz3MYUoZ8S7Hs+DRohyzt5U/yID8+320SHwbvRkk1+YHoSebiKlsNh+UdO8X4l8m
 Ew9FDOTx7oUNCQFVIZ4ZZ/9pRvRFGQLCZtat7Du8ZT
X-Gm-Gg: ASbGncvWl7N8GF7O8AK4MM4AssXIyYO0d3qQUZH61oetlOyIgIsLIMfq22kpjO+d6Nb
 tq6H5+AriVZ2650BHjH5vgY4s1rYcbD75apGsll9hXX0pd+uWN/w4tvH1U1lH9DYwmGnw5Ayv3e
 drfZFZOgO2N6ZdGxbPha+78+e17QS5AJ7j+epSKia5VKBqZ6zjcbkHshwDBUwpmW/GBzkPVwhir
 molQ2fbmngGHR4FQb2VVPo3ei+ucHapjYNXlXsDhHO1+b7gnEmjuy/0RmZ3BWQuCKCWLs3zTb+S
 LaPmFEO1roInC2Wk/GBjCmIrDsDzFhPiS8ewvslbh9g=
X-Received: by 2002:a5d:5d11:0:b0:3a6:f2da:7fe5 with SMTP id
 ffacd0b85a97d-3b60ddc6571mr6272929f8f.55.1752768426091; 
 Thu, 17 Jul 2025 09:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG205Dm1hDo999L732GfedWbc/XMw1E0SZLAPyGDcoIdkGafkDNbYw7deXiimsBZlfSJYMzvw==
X-Received: by 2002:a5d:5d11:0:b0:3a6:f2da:7fe5 with SMTP id
 ffacd0b85a97d-3b60ddc6571mr6272868f8f.55.1752768425425; 
 Thu, 17 Jul 2025 09:07:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b6162a93e6sm1852558f8f.82.2025.07.17.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 09:07:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 2/6] i386/cpu: Move x86_ext_save_areas[] initialization to
 .instance_init
Date: Thu, 17 Jul 2025 18:06:56 +0200
Message-ID: <20250717160700.357384-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717160700.357384-1-pbonzini@redhat.com>
References: <20250717160700.357384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

In x86_cpu_post_initfn(), the initialization of x86_ext_save_areas[]
marks the unsupported xsave areas based on Host support.

This step must be done before accel_cpu_instance_init(), otherwise,
KVM's assertion on host xsave support would fail:

qemu-system-x86_64: ../target/i386/kvm/kvm-cpu.c:149:
kvm_cpu_xsave_init: Assertion `esa->size == eax' failed.

(on AMD EPYC 7302 16-Core Processor)

Move x86_ext_save_areas[] initialization to .instance_init and place it
before accel_cpu_instance_init().

Fixes: commit 5f158abef44c ("target/i386: move accel_cpu_instance_init to .instance_init")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250717023933.2502109-1-zhao1.liu@intel.com
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index da7d8dca633..251d5760a0b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9619,6 +9619,16 @@ static void x86_cpu_register_feature_bit_props(X86CPUClass *xcc,
 }
 
 static void x86_cpu_post_initfn(Object *obj)
+{
+#ifndef CONFIG_USER_ONLY
+    if (current_machine && current_machine->cgs) {
+        x86_confidential_guest_cpu_instance_init(
+            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
+    }
+#endif
+}
+
+static void x86_cpu_init_xsave(void)
 {
     static bool first = true;
     uint64_t supported_xcr0;
@@ -9639,13 +9649,6 @@ static void x86_cpu_post_initfn(Object *obj)
             }
         }
     }
-
-#ifndef CONFIG_USER_ONLY
-    if (current_machine && current_machine->cgs) {
-        x86_confidential_guest_cpu_instance_init(
-            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
-    }
-#endif
 }
 
 static void x86_cpu_init_default_topo(X86CPU *cpu)
@@ -9715,6 +9718,11 @@ static void x86_cpu_initfn(Object *obj)
         x86_cpu_load_model(cpu, xcc->model);
     }
 
+    /*
+     * accel's cpu_instance_init may have the xsave check,
+     * so x86_ext_save_areas[] must be initialized before this.
+     */
+    x86_cpu_init_xsave();
     accel_cpu_instance_init(CPU(obj));
 }
 
-- 
2.50.1


