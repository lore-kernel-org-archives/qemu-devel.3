Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25F5C54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvv-0000ah-M1; Fri, 30 May 2025 03:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvt-0000RS-O5
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvr-0006r7-0C
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eJzC3ndxVWwhNaQSNztZeEsUlT2wjQb7K2bqFf3xRyU=;
 b=Y3LNCy9LDKbZ13HAf2cVUQlLeteAFoIegwB11t/eob56z1t+yvTBelZJjNMNkIZS2g4SO8
 cccu89AgmWFRD+OvgImJrsI1jVwDbUnqKffMT4IY0TgLL3Pdxfk34M0d+COfpoPZJJd2BA
 2LAy93wl1PCUvOcVSZLHeIgFtXpmN/Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-U45m12qONqGmaT7u5rUhHA-1; Fri, 30 May 2025 03:13:33 -0400
X-MC-Unique: U45m12qONqGmaT7u5rUhHA-1
X-Mimecast-MFC-AGG-ID: U45m12qONqGmaT7u5rUhHA_1748589212
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad8adc22e88so165980566b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589211; x=1749194011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJzC3ndxVWwhNaQSNztZeEsUlT2wjQb7K2bqFf3xRyU=;
 b=sufuLtwLBwfZoUeYnOh30Jh84vcqcpeN9GXv9ENnjScf+3OPp4PbpbBjeo5/wHbXl9
 KICzfRHetxbRCaevvRg1dV7MTmOklat/siolTO4P8LBu1iFJSHCXeuL+8Xdycj3BbkWW
 AKYL1ZjH+gcr1CLjxk+zEDwp0068ezuxSqDStBuS8ZA5M4XZSA+OUrR9Oi8SEwyfeZRZ
 qFjoSCDx7iI8bM6RMO5U6pvn03z++Xm9JfxLGtGg9ZGa4Aaq3eiyJE7YnJFIXaKoE5sy
 UJ0X+DabdY+sMt31XdRVpWoHskbceWcmvy5Ab8GFsixhRRNtPT1B8V1irh3NZSruJVkB
 ShBw==
X-Gm-Message-State: AOJu0YwcdgN/1J6n+XAn6MeqHv7sk+j4T6K00zK/wN/WJW5cgtnbv3hw
 TTjeB+7Or7dAzBVMZWo77Nr6Zn7BggxF2Ce/uPVQSS+QsErz7xpi96lbCySF4A6eU4Pm4s4OvUB
 m/gAmc3Yigg1Hf7YweE+3YhdvQ9J4EDc56yhO7PXemi8jSRnqoXm+hM97rsvu/LMyneLWX98XyW
 ldav1ooKUbRsncfITJGLHltLUosT0RMOz4WOdxYAp6
X-Gm-Gg: ASbGncvFADPAUGbXE/y+1QJVA6h3avV4FkUQHU42/Domi7iuv/KTZxFOqsaOBxVXM9z
 zVYmShHI//RGBKTnOIvCeTBO3oel1QX++gUlfiCWi4rf+cu3b3pkJJehzHQ/ziWn/aoHhNtslgt
 cFXko0e+Avm5Roj3IGj0SjcYI23UMNLkpxgcRkPeSMg3dppdvNa0YOKH5PN1xFJiUv6kOUzxxZO
 vNCAF6bGVnc6QsuLZqGE97CRkYIHdno8gCZW31Lzgmg23GNP3Cz0tUZovVf+5hb7ZGXtf3bzWl+
 OMmEr8lJrJ/FxQ==
X-Received: by 2002:a17:907:7285:b0:ad5:1bfd:30d2 with SMTP id
 a640c23a62f3a-adb36c07bd6mr93238966b.55.1748589210831; 
 Fri, 30 May 2025 00:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0kDjpjiBxbJ8yWBpKQ1sz0QeLSgIj+nXxecM5RmuehKEtnyn1zZ53WNFxQP/ZcaNphknakA==
X-Received: by 2002:a17:907:7285:b0:ad5:1bfd:30d2 with SMTP id
 a640c23a62f3a-adb36c07bd6mr93236566b.55.1748589210273; 
 Fri, 30 May 2025 00:13:30 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb318db274sm119107966b.162.2025.05.30.00.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 16/77] i386/tdx: Implement tdx_kvm_init() to initialize TDX VM
 context
Date: Fri, 30 May 2025 09:11:46 +0200
Message-ID: <20250530071250.2050910-17-pbonzini@redhat.com>
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

Implement TDX specific ConfidentialGuestSupportClass::kvm_init()
callback, tdx_kvm_init().

Mark guest state is proctected for TDX VM.  More TDX specific
initialization will be added later.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-5-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 11 +----------
 target/i386/kvm/tdx.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 653a8f46c2f..d29376c5992 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3207,16 +3207,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     Error *local_err = NULL;
 
     /*
-     * Initialize SEV context, if required
-     *
-     * If no memory encryption is requested (ms->cgs == NULL) this is
-     * a no-op.
-     *
-     * It's also a no-op if a non-SEV confidential guest support
-     * mechanism is selected.  SEV is the only mechanism available to
-     * select on x86 at present, so this doesn't arise, but if new
-     * mechanisms are supported in future (e.g. TDX), they'll need
-     * their own initialization either here or elsewhere.
+     * Initialize confidential guest (SEV/TDX) context, if required
      */
     if (ms->cgs) {
         ret = confidential_guest_kvm_init(ms->cgs, &local_err);
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 21a4f877565..2b060fb52b9 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -12,9 +12,17 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 
+#include "hw/i386/x86.h"
 #include "kvm_i386.h"
 #include "tdx.h"
 
+static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
+{
+    kvm_mark_guest_state_protected();
+
+    return 0;
+}
+
 static int tdx_kvm_type(X86ConfidentialGuest *cg)
 {
     /* Do the object check */
@@ -49,7 +57,9 @@ static void tdx_guest_finalize(Object *obj)
 
 static void tdx_guest_class_init(ObjectClass *oc, const void *data)
 {
+    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
+    klass->kvm_init = tdx_kvm_init;
     x86_klass->kvm_type = tdx_kvm_type;
 }
-- 
2.49.0


