Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA27BC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKty6-0004cr-H3; Fri, 30 May 2025 03:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwz-0002pV-NA
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwy-0006zz-2u
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PwZVoCOHIB/52C9EF+XqubWfnZl+ifPa0w9UOgqMjCQ=;
 b=LO3zniNIqkqgULCGX2Ye9/XNIXa7wFTaUvKEr2+w6iZQ8RNd6MpfuOfooz0hHzUgRImjI4
 dN6IuAbAoWSpr4KcX5kt+WF+2QR74y1bTU3nPn60j9cnEXE2mSzERu5VuwXux/IU4io+sK
 bI0sntTDkSzn9hAPslvPZ9GM1lsOwNk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-uhdKweS0NhOWDu7NyKwCcg-1; Fri, 30 May 2025 03:14:42 -0400
X-MC-Unique: uhdKweS0NhOWDu7NyKwCcg-1
X-Mimecast-MFC-AGG-ID: uhdKweS0NhOWDu7NyKwCcg_1748589281
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-603f71f6432so1478169a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589280; x=1749194080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwZVoCOHIB/52C9EF+XqubWfnZl+ifPa0w9UOgqMjCQ=;
 b=ZRgRRnBuiB9ZhFYcmQSNqUVgyk3eSlTpZegp+TVfDxsoIcnkRwiHLotOo6ljl49fn8
 oDHj8Cefjxr0/XpEOy/0/oOmqfshyLog+Vrc/1Y/8bYkCZi7Y6EpTICuKG9MC8N3SqPX
 gIwS5wIxC48FqwCvjdJuM1B2DRVBnMQh9cdcNHo5lGdTQXiDmpw1idyAWfn9QhDpz4+t
 l3UTY24mWVIe3mDtEU0gokp9wh4x1mile+fjYhBGynGQ+e5Dz6ymtyUHGm73R6yAaZ7F
 MUglKp8jZxl8tc35P3LO5xG0sBwr9Q55j+unRbn7VlHeKTx/Rxgvjm37++a3bleIJAWZ
 Xb5Q==
X-Gm-Message-State: AOJu0YxI+a+oBexFHuOaD7Rvceo1IpDvX6jqdmMYCDl9XC9ioVm7Noas
 qTHUEpmdlKppm/tvuokyursmOtGvqxSGVXeeA0J7jNq70PtwFoZo8yefE8ApGRhS6sIrb5hPZj7
 ken/JmT04+PtRukctimdM07u22jBreebGAmA3aIFMyAwA11NUCfLYcw1mhqDbJe3NVPA4lKY2ER
 XiFEVbqIjxCMzyjAgjsSCD39FyasGv1+GPE36wW8mG
X-Gm-Gg: ASbGnctqCbUNYSv2UY4ztB6FcJbyMBZ00ZipQEYQ05lm6b/MDxzQUk/47PAwILdEnN/
 fBUrazdiknCGDt9IoUPexmIY7gON5ftIX3xAdexNstf0jT12M7WQtTYM0WIFb5C74v8b5l/IZE+
 RCh0KHmKlKDE/7YEVxMoPUhfIvKRNW3Bn7EqGBOLCocUNZ8aQQ0kRcJIq3oK1oFBzD6+f2OIoJA
 QPluNSxvEFI9yNV++U/j1rjfJSQsM6wxe/veC3DlalLLEEjB07JSRLMVp4EHdA+7+vMBYJq9TZQ
 9zEmLTjQZHTuV/xifFAnUyBJ
X-Received: by 2002:a17:907:3e05:b0:ad8:9ff4:c02f with SMTP id
 a640c23a62f3a-adb36b2377bmr106449666b.19.1748589279930; 
 Fri, 30 May 2025 00:14:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqhohebExsT4I9eo0WN/53RLQXCP/BwHmngV95FKmTdLu/qlNvyd++YM3FRvq0uk5YShCWJg==
X-Received: by 2002:a17:907:3e05:b0:ad8:9ff4:c02f with SMTP id
 a640c23a62f3a-adb36b2377bmr106447866b.19.1748589279491; 
 Fri, 30 May 2025 00:14:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fece0sm277015166b.3.2025.05.30.00.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 43/77] i386/cpu: introduce
 x86_confidential_guest_cpu_instance_init()
Date: Fri, 30 May 2025 09:12:13 +0200
Message-ID: <20250530071250.2050910-44-pbonzini@redhat.com>
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

To allow execute confidential guest specific cpu init operations.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-32-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/confidential-guest.h | 11 +++++++++++
 target/i386/cpu.c                |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/i386/confidential-guest.h b/target/i386/confidential-guest.h
index 164be7633a2..a86c42a4755 100644
--- a/target/i386/confidential-guest.h
+++ b/target/i386/confidential-guest.h
@@ -39,6 +39,7 @@ struct X86ConfidentialGuestClass {
 
     /* <public> */
     int (*kvm_type)(X86ConfidentialGuest *cg);
+    void (*cpu_instance_init)(X86ConfidentialGuest *cg, CPUState *cpu);
     uint32_t (*mask_cpuid_features)(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
                                     int reg, uint32_t value);
 };
@@ -59,6 +60,16 @@ static inline int x86_confidential_guest_kvm_type(X86ConfidentialGuest *cg)
     }
 }
 
+static inline void x86_confidential_guest_cpu_instance_init(X86ConfidentialGuest *cg,
+                                                            CPUState *cpu)
+{
+    X86ConfidentialGuestClass *klass = X86_CONFIDENTIAL_GUEST_GET_CLASS(cg);
+
+    if (klass->cpu_instance_init) {
+        klass->cpu_instance_init(cg, cpu);
+    }
+}
+
 /**
  * x86_confidential_guest_mask_cpuid_features:
  *
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9689f6374e6..4a7c319bb9a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -37,6 +37,7 @@
 #include "hw/i386/topology.h"
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
+#include "confidential-guest.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "system/address-spaces.h"
@@ -8543,6 +8544,13 @@ static void x86_cpu_post_initfn(Object *obj)
     }
 
     accel_cpu_instance_init(CPU(obj));
+
+#ifndef CONFIG_USER_ONLY
+    if (current_machine && current_machine->cgs) {
+        x86_confidential_guest_cpu_instance_init(
+            X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
+    }
+#endif
 }
 
 static void x86_cpu_init_default_topo(X86CPU *cpu)
-- 
2.49.0


