Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63025C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH2Q-00037h-Ni; Mon, 14 Jul 2025 07:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzE-0000eI-Rv
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzD-0001ZI-6K
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+jxMWxOlg/biz4eluMLRul34alkCeegIGKe/kOpyn4=;
 b=O1ohlicpyzViFCD4TYj9r0VMhR4QRtl0T17mqCW9cth5exVXkkjKt8nQLodGSlEzhTDtuw
 j5Nh7JTj0Mctibjay8wBtuWlr4bx7trTThP2r7eChoO05MELomx+8IMXRQzrDXhH+Knp2O
 Ay3c13ispup+VRaS/WXVrdV3C4xZGeM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-5Gt_-7QYOfmwFapUq852mw-1; Mon, 14 Jul 2025 07:04:39 -0400
X-MC-Unique: 5Gt_-7QYOfmwFapUq852mw-1
X-Mimecast-MFC-AGG-ID: 5Gt_-7QYOfmwFapUq852mw_1752491078
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4561a196f70so4831185e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491077; x=1753095877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+jxMWxOlg/biz4eluMLRul34alkCeegIGKe/kOpyn4=;
 b=RB0wIoIzP/csLwP3Oj4PAL4xdVhSv+tXpjDPVEXboyupYPteFGWJNx/X43wdbeNFps
 tl+l1p6X8ezrJOYejUY5HSee5I1WUuUh1zcevhatEjsYFBiAh/LDRbHTj3x7sUOzpAEh
 XkBIt5qdW4REg4CDyqnUjygWmTjy/9IXuWj8SYeQRAcQoaa5fxRYRc7MUPsCVTCwaqIF
 6hIS2EzNNet2lXr0Y+E6eZEDWfhuY+2IBfwNhoe8Afc/2hM286hSwKIJJbRKy45R3bh6
 KcNuvPGHxmxHwR70rAsU33+hcJhj0/Y7ZizpK65M8u/G9svuPzxRPKlmjV9Xu52aPVa+
 0NqA==
X-Gm-Message-State: AOJu0YyA6yvOC0ZEyap+eior2kYUcAnVOTFeg0RQk3wcAdGT1JIUmVTa
 5jTprZWlwCoV/9RLD+wSPZ+U24b+oBF1O+8uhsCt94oCqrEnEfq9u8y9zMQOdIOvqfkPmDRJaor
 Eg6suDD3LRdR2B0Qo/btQ55x29LdKGyjfnx1Iq1TO9lcZdhVk+qnxf8yR+hPiPqZc6eXBxN5+2U
 KtagdiBusPVFSdMJdWq/FYrbWZJyDvLeOnKJtI3ly4
X-Gm-Gg: ASbGncvvtYjlCaJSZyukkTBYYv/z4zQZgA8UrDeot/gZeCEQOC3K5SEufkoQ8QLs/Fs
 ixHg9sHTTH4ldmJeUKigayCwGlItI55vdJl+DNPahEkFgSu92aSxbxF9v9xPSRg+RH5e84MJumS
 5BpqGyk6gmUQ9WRWaRCkYjZglZm8mIQOlYAHFYsGTFMd4cvhLolb8Kd1jFQQxMj5VrIxXdkLBje
 IdaHjWXwAnonCj4X1ycreFuqfKjBL3MRIvfIwhjAA+21pPjYKdOIg8Od8cGPaTpV1E8CeK+uhVA
 PRgvUOPnzpN3hdi1ZCbM0smR7y7sMim7u+hRzWQtigc=
X-Received: by 2002:a05:600c:8505:b0:442:e0f9:394d with SMTP id
 5b1f17b1804b1-45565edc90dmr96701625e9.24.1752491077324; 
 Mon, 14 Jul 2025 04:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW+AVS9Z4+gBr7HmI1Bh4NlwERimAcm0B/SOmONmzScXvlN3R5KfsCIRdN66L2fNLLCsqLxQ==
X-Received: by 2002:a05:600c:8505:b0:442:e0f9:394d with SMTP id
 5b1f17b1804b1-45565edc90dmr96701345e9.24.1752491076825; 
 Mon, 14 Jul 2025 04:04:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45615a4551bsm41651835e9.37.2025.07.14.04.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Like Xu <like.xu.linux@gmail.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 10/77] target/i386: move accel_cpu_instance_init to
 .instance_init
Date: Mon, 14 Jul 2025 13:02:59 +0200
Message-ID: <20250714110406.117772-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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

With the reordering of instance_post_init callbacks that is new in 10.1
accel_cpu_instance_init must execute in .instance_init as is already
the case for RISC-V.  Otherwise, for example, setting the vendor
property is broken when using KVM or Hypervisor.framework, because
KVM sets it *after* the user's value is set by DeviceState's
intance_post_init callback.

Reported-by: Like Xu <like.xu.linux@gmail.com>
Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c5cef2c7cc..44178bc523d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6202,8 +6202,8 @@ static void max_x86_cpu_initfn(Object *obj)
     CPUX86State *env = &cpu->env;
 
     /*
-     * these defaults are used for TCG, other accelerators overwrite these
-     * values
+     * these defaults are used for TCG, other accelerators have overwritten
+     * these values
      */
     if (!env->cpuid_vendor1) {
         object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
@@ -9038,8 +9038,6 @@ static void x86_cpu_post_initfn(Object *obj)
         }
     }
 
-    accel_cpu_instance_init(CPU(obj));
-
 #ifndef CONFIG_USER_ONLY
     if (current_machine && current_machine->cgs) {
         x86_confidential_guest_cpu_instance_init(
@@ -9114,6 +9112,8 @@ static void x86_cpu_initfn(Object *obj)
     if (xcc->model) {
         x86_cpu_load_model(cpu, xcc->model);
     }
+
+    accel_cpu_instance_init(CPU(obj));
 }
 
 static int64_t x86_cpu_get_arch_id(CPUState *cs)
-- 
2.50.0


