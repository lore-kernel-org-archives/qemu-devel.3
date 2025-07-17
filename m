Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D51C83F38
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 18:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucTCn-0004eW-Ia; Thu, 17 Jul 2025 14:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSM-0004cI-Tw
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucQSF-0004JO-HA
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 11:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752765806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Xv86/Rz+8Kqo5xHCX7FN9w/MZvl13ciifCpIY3ePjE=;
 b=M4PoIYi6jcoP5/kxMXGg8JiU8E/v395pFo2/+Rx+o6nuoBEbNj1Qy5PbH8j7zX+3hqPgc/
 vGI5KZeYRKSamyqguIB90vY23rKOzt1Z9ZVB3ZaMI4rtip9X01rJjBx3ktB9pnMjL1aNn3
 zkHAjF0yW+9agdrakmpO4V/0zpNP61U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-Dj8toFnjM8aeb2ghobf33g-1; Thu, 17 Jul 2025 11:23:24 -0400
X-MC-Unique: Dj8toFnjM8aeb2ghobf33g-1
X-Mimecast-MFC-AGG-ID: Dj8toFnjM8aeb2ghobf33g_1752765804
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451ecc3be97so5630435e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 08:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752765803; x=1753370603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Xv86/Rz+8Kqo5xHCX7FN9w/MZvl13ciifCpIY3ePjE=;
 b=NR5IiF3+y2t8ekzRI/zOOOzApwylu2ju5i/N6zd+lZrp73PxVD29kYphCit0fHnYJ6
 YNHkxdv4JM27HO4hw5r2JOigxmRoSfd0bWP0a17RBVCTyXzGL91w31GFZDSKoEMcCzX5
 iLJnmqQr5mbbk06GOK7kcV72e70K53RqbuijC38FmCALoD0Z5rvgk0Dobdp2/hEf5rml
 5Lndk3MjmOk7I2RAH67owRP5+qKK5eUyDM52Hy0jtSyZQgf6SrfIte98+DbgO1mlzXib
 +7o6YWcZbsIRrI8cJ3LSgvsOK7AjEfw1qB3zG1WY5xjxWqT+cMjxdio4n6vpdeYkIgaa
 AfSA==
X-Gm-Message-State: AOJu0YwQj/12zcd0eSSaLDBI2h8QfYodt22Z3HRvnGF8/Oqo2ZFBi7Ph
 GepUgDzYdg/K1YzNJIQkVnL957P2EeG0Li9ADSF1sDnaHoXwWBFd5elHx5DLa8PPHMJ8drVhObc
 TH17uF41MJ0sgHUo71ss8VFELnxWBRb+d6E7GGDTuyqxtKWFc7yhXiR9078Elgne6gF9KScMZdw
 ZcK1sL9tTz+c8EARHudTcHd5n4SBBJcgHS12L/YFRw
X-Gm-Gg: ASbGncu8GCJ59gzIBFpVCqX3R58vGMUbbp+oaVUDw868jQ85TRte/8pDNvvjw2W7oS4
 DJbl7tAoh4FF8NzU2i64IwWNbFTMLsgCEBofqUpe367fEyzk67ubEqtctpxaR7VaJegoe0YJbsg
 gebx2tN1P2bsZm2/vQSPThPmVPKyoRoH2WwdXj7mUBIUl/j+0w8hSBU3ISO3clQt+0aWuTvXQu5
 wnVQCJCIXucDDciZ603YnTZ1eq73ab1z/93kzSiiDGxSEwgeH0bb0AfEQfiX1D+3nOd+nQzsguM
 p2hGRrFcj2lrPmfuCcC8rNtkR8pthUS9wW11WrznDDo=
X-Received: by 2002:a05:600c:1c11:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-4562e274934mr82607785e9.16.1752765802785; 
 Thu, 17 Jul 2025 08:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg2fJ0nfaWBUJ7ETJWQ7F0WDZ0q+rmglZ+3V/8Vv7YyA9j32WSBiYDzx6mf2uUBCvA3Ljl0g==
X-Received: by 2002:a05:600c:1c11:b0:43b:ca39:6c75 with SMTP id
 5b1f17b1804b1-4562e274934mr82607415e9.16.1752765802262; 
 Thu, 17 Jul 2025 08:23:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45627962384sm46960205e9.2.2025.07.17.08.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 08:23:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 2/6] i386/cpu: Move x86_ext_save_areas[] initialization to
 .instance_init
Date: Thu, 17 Jul 2025 17:23:12 +0200
Message-ID: <20250717152316.353049-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717152316.353049-1-pbonzini@redhat.com>
References: <20250717152316.353049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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


