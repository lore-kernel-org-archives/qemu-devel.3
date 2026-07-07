Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141A2C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 22:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whEVg-0001EC-J9; Tue, 07 Jul 2026 18:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVf-0001DH-Bg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:23 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1whEVc-00044r-G2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 18:43:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c9b1edf2bdso1108015ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783464194; x=1784068994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R71DJ1s0zDCfKOKIafJMIMtfyKJnrf0v9yatLVZyeqA=;
 b=n7N7mfMvtXuaAlkWm0RiROqcX5mX7Ibl1cgUKSf489djjERAAlHDSiUR/YiA8GRwAB
 6YmASsjFZz2+qUOIbnXoLdZS3krx8EG409uCxhhA89pUN4/jo75Xa369E1z1g2/qtIDX
 4mrE96zt8xI7bFZeE7t6Hge9JMklK4CbZCk9/znr15eK4EwRDkK0RvjtgXDS59SM9RXD
 KxwemFUJY634nFbRa4309gLAUlUGsBYVcd9H2Jlr/knKthTDyNahxqzlKiWSVJOZA1sU
 1yj0wJW3Je0yEt8M7mgGreePhSSvyzjsV0JwtAq/m8lsi8KE/RU+6VUuV/5sSby7W4N6
 8eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464194; x=1784068994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R71DJ1s0zDCfKOKIafJMIMtfyKJnrf0v9yatLVZyeqA=;
 b=Xew16/3fPLArbXANCRlFHQYl5VbeyuD1+Dbws9eiqOd1VusUBD2SI8yCvbi0v8T/qN
 eJ/5qRERT5/viN0IBxv94yUOzGu6E13CY4CH8Ne4qSomTn5lmWazOdmSCJS9Z/T2d+Pf
 srjv8mM5e5Cdv5HOyj7xs8L1D7/AwMWprQZXuVRo610EzxAqVoGUvLnb+n3p7PUoQD+O
 ni4gESdRXcZwebpARM7o328w0tzE+evaM/wyoV7Htq6ROsHghneWPq8kTum8fREBxY6P
 hl9fEly/CgU0ct47j9HgxPz8m4h9KLa9E+vAWv1sdpNdteSWr0pm1jlGd3mm9K+VBy8M
 IGwA==
X-Gm-Message-State: AOJu0YxGrUErHicAHNf5p1B7b8uzRgLFu/RsxR3BpGV32RrmjqpbEPql
 8HcDQb0LOVYVsBaJSfeUeWDKXK+NMDMOwSDG2zv2bmOa9oqRtBYqlgWpBdxUhXoeGjE=
X-Gm-Gg: AfdE7cluPkuptCUyhSfw3UuEfqhGasNTZmYW229oj55Fx0/jN7Da9nUOH3Ox1cHMsCu
 w3laTluUh2Qum8iP0Hlamw9nZJbd4AEgtCLEKStSVDh7vSvX7EGzMIBjjblBoxTHN7mDRS0QUHY
 PzHR4/4W9CYGz9OCul8YQY+ej3dTUIaS2JBzhzXSSSIZDhEs7B4SsBPjPrvvnodrVPVwDmgfXSu
 yE4JvfHTf6eTqJjL0exMrjp81gIdgXc44Hn5OBIzgO66WRhCXoeW7a6gjgIAyIGaAyxDa0B4I8q
 /HhtFD3lGODSwyM0ctTEaKmoOYSXvBs+Uk6qrDT7hfRQbC3plYBvMK618zt8Mtrhm444P3w3yQK
 YHooX8ypPkVLtCh4qdVp8oS8x5YoAHYIOK9nMGhzgljORNKQmivl5U6N5A2ieLp43T1hmvJr3mB
 friN9joK2VQJWs/PPDAlSzzOb7MWJjjppaoaswgLM=
X-Received: by 2002:a17:902:d4d1:b0:2cc:d192:50b5 with SMTP id
 d9443c01a7336-2ccd19251e8mr33153885ad.34.1783464194073; 
 Tue, 07 Jul 2026 15:43:14 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:43:12 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 02/25] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Date: Tue,  7 Jul 2026 16:42:43 -0600
Message-ID: <20260707224306.1202330-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Leave the `ret` variable in the function scope because it will be reused
when adding RME support.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index d40a6a985914..ed99be7fd80c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -596,7 +596,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
-    int ret = 0;
+    int ret;
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -618,7 +618,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -640,13 +640,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             warn_report("Eager Page Split support not available");
         } else if (!(s->kvm_eager_split_size & sizes)) {
             error_report("Eager Page Split requested chunk size not valid");
-            ret = -EINVAL;
+            return -EINVAL;
         } else {
             ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
                                     s->kvm_eager_split_size);
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
@@ -659,7 +660,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);
 
-    return ret;
+    return 0;
 }
 
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
-- 
2.43.0


