Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD9FC54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonRx-0002zr-S3; Tue, 28 Jul 2026 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRp-0002tM-E2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:42 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonRn-0001Lj-S4
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:26:41 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso190814a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266797; x=1785871597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
 b=FZN5u+02W5PUw7NV/1b252l9Nh2zGGrTHZvsaz86b3ISaKXTa3LaqVOeSzgbI59hlp
 rHWQnTqqV9As5tFpT1n5EqXPUMz1UOXKQwBXQ1nDNT0qJxwtHIy6muqUrSZ3pkxadU1K
 HqsIPYR+i9o+4Lcttrk+9Cu6Nd1xikhFdtygOCSzJcNd1nVVHJiGIBlpyNbU9kPNhZW5
 B3OHYPsotRHS6Yj+iTD/2kzvlsfXXhl5mwKNIGtAXzwwDKdULgsdf9Iv6Qfpzt5R05jQ
 uEeIXM07gOuTYHI0aFZJ3C9ZWxwnc9jW6fx5GcHdQXNlCryi+DgFgd1KGPxdb3NhSPIY
 +7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266797; x=1785871597;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
 b=FYQ2FDgjcj0KspxQ3clJNRdUH6VXnsvxcv3EOE5JOURDODNA2he2KnqoeTBt+G++tk
 3GxPGKh+tQ+pHhVSwethI7IT8WgQ0t0yyoaesyo8j0vBAhQ0EujvmlH92Rup/s94zGW9
 XgALFo0gZdMyMakY1JBvTxFxMR6iLSEXPEfXn/4af2J0b2ErpJ5/QTYfK46I/i1l1EFO
 J/l/oZbBjdDUqxSeS0AI9aYyGTaDzdVX58Tb31mL60OzVgwBU0cFeG9L7P0xZwzpHseB
 GkPJ+Xj7WsEgDaqZEIxugERPg8lb6jwos45NgfXeZqPTEqI35ulx6E3+Rcr9K/2U7BN1
 GOaA==
X-Gm-Message-State: AOJu0Yw+DgGAMiSchQN96M4nSfHYAzrWF91G1QGeqIl7AzBtflOt42+B
 U/+vK8HbSS51MvxNrtY+7jEYlp8uZGfvEwmi3qo82bDRYuh7IBsCtQvg9u/cUe6PmrM=
X-Gm-Gg: AR+sD10jW3WiSpadmltNaj/F4t2wT1ltF9Sv7Vn4JpCDoliVmiN9V719dHEePlwNdfK
 GDek9z8tc3W5CKSpYkvZ9DQsnK3xnIfZy6amu7WS2Fy0NmpxhVX8+erIRI7+Br/swqzRnXCIZXf
 6O2W10aF8IxJ/2euJIASDvwiUkOjatbFhMJydG0aRqyzsq+RlOCXBa1/JhyKq6zGQMvA2GGDhc4
 bE3UVWzAB/KlmpXERfw89+XWwYUHOPQd1mAeDbTdvEA/D4fqPg4QUozpvwRIjBR8CBZRXMFIpLr
 Hikgt2xX8xryHgrF/ltGAQNI/QDbwtKUGP2BOmbiJDzkQzuuRpE4hF89YoZZ2B7sI0k5WHqeeVI
 cF2Z/3karrEiVnAaDPcx6Dw/8mqaQi05DTpb6cEyBPwCNHcT/RLrHYHoRtgUb3iMyBfEKmkAvLw
 hRRRAgAh8KdroQi32n4Jcab/nIK8uGBkMYSTLD++YwtbeZgh3ikspte1+2N0QZdTZOdrFNdixmY
 te8SlHAQeC9Brg=
X-Received: by 2002:a17:90b:2d87:b0:38e:5ce1:ae30 with SMTP id
 98e67ed59e1d1-38f6a336e0cmr3477306a91.14.1785266797109; 
 Tue, 28 Jul 2026 12:26:37 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:36 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 02/24] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Date: Tue, 28 Jul 2026 13:26:08 -0600
Message-ID: <20260728192630.240375-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102a.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


