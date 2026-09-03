Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7CEC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEY-0001J8-RO; Thu, 03 Sep 2026 15:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEV-0001GU-GP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:25 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DER-00046e-Ub
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d72ae08fa1so1941955ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464177; x=1789068977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
 b=QPLK5h45pUJbVPq3uaax6C8kyOzyhkdzwPDR7o36hs0Ogb2duPBlLDaRYjU34hg3CS
 XcXwTDENNa/t6CNPTt8OsScaz9U7V/bmfCSitSp7znlFl1KNtPoMt0eikzLCvuudy93s
 49b+I0eH8g1ZFLIctjftLo8aRMbJyYD3dmViN4gybXbyl+2Sp1G9YdnLmixD/YO0jqIY
 Hcc8pZ40gxrB8fz0nG1DgdtJjw0BFJAZ6Gk7fnmyHAuSOahCs6iiZo4BF8IHz4zeT6RY
 ufJSb5EqwPmHuKeak5lyPUrQwlCHKIXYLl19PuR857o+1OS0CZFouSMNd12lehLNV2Je
 RwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464177; x=1789068977;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CTa8ol54WmkLiwpxVbLa9gLi/D951jAni9gUZTC/0Gw=;
 b=Q7o6mOJ9/HenP6hW3+QdM5ZNwxupuRAH1lGDPe34AG51QkTwgz0QkqwRGKihEM5f7f
 /8ivHG8CpyKOY1Xs0HOQ+kgi5NmmAR0SXeiJ3tDgs7gS/zdFMNE48ENaFJxNeHQPMJ4S
 ONgDXDlA/j+mW1XyXLWswVYsFAOyeh2CAeeVttpVp41UnuOg/BpjSsle9ELKQ0DJIqTH
 SOg/bCYqkKTgrQDC6duJQ1ZBaRdBzva9LfidHIpKBnpf3XwoF0APwuxEDQfLSHauphH5
 9QillGOgoYU8AZ2XiskOjepqvwz6ZIroSJGjFyQeB++8nMODg7yzphuMGkPHV2Ypu67G
 wAxQ==
X-Gm-Message-State: AFuF++m+v6CSyjNEceMSw+bMVvlBNGT7GpaKPd4qT3lcH3uw/geRmu/U
 BlzqKOQH9pYZ7lICQ1ildK16DLVzSrFl7XRvjys4t02gpyYH/rhShQucR8LQzOslkaI=
X-Gm-Gg: AYBFou27ewqf39/U9+7+igdievYLP6Wuw1trsBpZ29uTtJoHuD9OH8WhtQnos/W1qBn
 HF4nwT95rKJlnQ34nxjthz9YH8XHQNjuQsBstRqbXHSfob7VWceZtm2uAHek05hNabkC7F8BG7Y
 nBQba+VxdXQs3aEGKg58Zn/Tiok8GB8O8KnlkP+oREZACV/IlQ3lR9H5wo3ikVK1TDJAlBPwuxk
 khFefGavSPTEby8rakrzCKykHy3yPTtxOSAW/xkokaJDD4o3Dej35zwZ6iW6k8PsKwqAN7JKwoV
 kl5QbIAYp0h1+fj+NkDa0G5GAxQmcg9vblPqZgWC4UNqyozRAzuGzWqbc2c8DQOjRP/LJYXYkGz
 rcAVewMH/LCx36Gxf9Labj5N26O7K1h/fK2AZHwImbGEY736n2G7nwNUCrtLg8VROSMea/UBCn7
 V8iEWP97lqhPjPksXiqOqy+ZuGoPc2gWgooIHNRcs1Fi7Mo/B/d7vmGCf6PI4IWGFtfOQPis4VB
 8ivUkVI4L6BnmU=
X-Received: by 2002:a17:90b:57cb:b0:398:9be6:f998 with SMTP id
 98e67ed59e1d1-39b262e2139mr1100782a91.23.1788464176850; 
 Thu, 03 Sep 2026 12:36:16 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:16 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 02/24] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Date: Thu,  3 Sep 2026 13:35:49 -0600
Message-ID: <20260903193611.1058589-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62f.google.com
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


