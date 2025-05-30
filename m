Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D91C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu0I-0000Be-Q6; Fri, 30 May 2025 03:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxm-0004Ah-3V
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxk-0007FQ-Fn
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ibN3OHGr1sUQmWMu64gMhIByGJ03ScPUHoMcbrYl78I=;
 b=HxqKqn/9CJRtuVcJkFFkKeXrdh2QhixoJvHtN58WLfjmxtG1rdiikoHNr7XBE2OlygH4aS
 nNhkiZWyKcvICKh3cH6fPL+m92fJvg6XAezxlIQFOQiH/1Z64ZLoggDU5lqD/YVc10vvRx
 sSDqO+WymPiD/fWGw0RwMGlTJzDAYLg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-4oeidW4eMZeRXyCrV9XVtA-1; Fri, 30 May 2025 03:15:29 -0400
X-MC-Unique: 4oeidW4eMZeRXyCrV9XVtA-1
X-Mimecast-MFC-AGG-ID: 4oeidW4eMZeRXyCrV9XVtA_1748589329
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso130699466b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589328; x=1749194128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ibN3OHGr1sUQmWMu64gMhIByGJ03ScPUHoMcbrYl78I=;
 b=CdkpcmqIf3i6Wx558ebIbffQ20OkKJaWsHYPLKksXU6mmIZ7fXpaEyxyKQP3CVCsrg
 Zz9aJYYnY4e7hJDH/5RG5uuhcb9FcCZsR1MTFBvoq/Luh9VLHxOAM5SP3u6/8lHNTYpp
 1AUUpKpqI9FSVMCaT/+NPNY9CLWxMHJIMgALE7RYkJ3xJ3LiBmviQJdhKOmNUOJSfe/5
 omdlWElCHcdRKBFmo97b+qaaNO77JPpvzI/ReGxJgwQn8JV7iRjKP5I9n/+5klQokViW
 TKRv9NWqWWLVB4p8yH6i4xbCSP2H3v7JKl28Q2Frf9y+kMzWWIh+vX8EFe7kczISenjZ
 /plw==
X-Gm-Message-State: AOJu0YzKHuA3cDyK+n1aXOCZkm150WwY61bckZ5D3jUmD6Z7up0yTNnR
 N1/cja7gaqQVLdgu1YoAUdnW8t3ulbCZbjGzrU7xKW0kux89FC5D6bCnpXIgm1+AFDdrblKLzef
 NigxNhsCXfJJDDTZSVs/bLe4v5ZSQwK2jxNWiwIys2PvJRRLQDSsK16bmZXqKvy51BT4PCye4ko
 S6Ebj0/bZtrtwkNphhZS6kDT9RzC15H7XAzQkWtn5l
X-Gm-Gg: ASbGnctx9kOgcBPPR5UKmPi88zOoDhzfOBsjWGeiF35IdM5rFXZvCgXYj69rnTlMUdC
 VTYWzTzHL8LmR2GE1KmNDYtbRhULlpXu4d9uwmr/b6EAfU7N5L3QQM70igxyqcYjPppI/Ry7yXb
 9xNgWgci4v2UCqZg8zXeA89KG8UsfMd/FL2UBkqZvIRctY/V2snVjSAUusbs4qWNNxbswszkgmM
 n1W5TlV4IMKPTuWZOXV1i9i6/m7wDg+Sf/sE46LttByR46IHq2RsZjKkWOvbAQF6kwbvVW8AJze
 WFppIvPPKYY5qw==
X-Received: by 2002:a17:907:9411:b0:ad8:93a3:29b7 with SMTP id
 a640c23a62f3a-adb32265462mr203536366b.18.1748589328211; 
 Fri, 30 May 2025 00:15:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8DdsWjDYqSpFKB7Wqw4IcsllGhpCXK8jwHEaReUrpjw+JtoFhpXeJIDVhog7kEwlx0aOLnw==
X-Received: by 2002:a17:907:9411:b0:ad8:93a3:29b7 with SMTP id
 a640c23a62f3a-adb32265462mr203532966b.18.1748589327714; 
 Fri, 30 May 2025 00:15:27 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82becbsm277514466b.39.2025.05.30.00.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 62/77] i386/cgs: Introduce
 x86_confidential_guest_check_features()
Date: Fri, 30 May 2025 09:12:32 +0200
Message-ID: <20250530071250.2050910-63-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

To do cgs specific feature checking. Note the feature checking in
x86_cpu_filter_features() is valid for non-cgs VMs. For cgs VMs like
TDX, what features can be supported has more restrictions.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-51-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 13 +++++++++++++
 target/i386/kvm/kvm.c            |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 777d43cc968..48b88dbd313 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -42,6 +42,7 @@ struct X86ConfidentialGuestClass {
     void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
     uint32_t (*adjust_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature,
                                       uint32_t index, int reg, uint32_t value);
+    int (*check_features)(X86ConfidentialGuest *cg, CPUState *cs);
 };
 
 /**
@@ -91,4 +92,16 @@ static inline int x86_confidential_guest_adjust_cpuid_features(X86ConfidentialGu
     }
 }
 
+static inline int x86_confidential_guest_check_features(X86ConfidentialGuest *cg,
+                                                        CPUState *cs)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->check_features) {
+        return klass->check_features(cg, cs);
+    }
+
+    return 0;
+}
+
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index cd87f5502a3..a6bc089d020 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2093,6 +2093,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
     int r;
     Error *local_err = NULL;
 
+    if (current_machine->cgs) {
+        r = x86_confidential_guest_check_features(
+                X86_CONFIDENTIAL_GUEST(current_machine->cgs), cs);
+        if (r < 0) {
+            return r;
+        }
+    }
+
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
     cpuid_i = 0;
-- 
2.49.0


