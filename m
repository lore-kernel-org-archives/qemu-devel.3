Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C157BC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu01-0007yb-0X; Fri, 30 May 2025 03:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxP-0003b9-LV
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxN-0007DO-Bz
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUwkvJnnoJf5EHLcKjTdm0AouYHJQp5bSzHJz7cc/Fw=;
 b=EvEOHUn9Cb4de1X9yntigKYg+N3PuiNSB6Cr2OiGcQHXUMN5aGOopS2/ykPy1yGLLHIgiJ
 VsPd/bIC7PyqBc8xInI1wSNyVoCTpdOX0H3hQMOh48ufNRfd3It4yVQM06dgytJiO5gDY3
 6XcgqSjzBeTJ0+gBJEsDFz6bUzLo4C0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-vO3q-LCKOcSyZ5m3IaMdzw-1; Fri, 30 May 2025 03:15:07 -0400
X-MC-Unique: vO3q-LCKOcSyZ5m3IaMdzw-1
X-Mimecast-MFC-AGG-ID: vO3q-LCKOcSyZ5m3IaMdzw_1748589306
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad8a2dc92ddso124165366b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589305; x=1749194105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUwkvJnnoJf5EHLcKjTdm0AouYHJQp5bSzHJz7cc/Fw=;
 b=ATjepQI6Hml2+FmP6mGEdLjC2+Pd/qOUsNVDN+qd6Rv9HM99agICdCKazptBzD1RWC
 TswRUKBhFcmLsrhd1chF9NBLIF7KqSN1VaaiS9EtXJshi7R+IdLmuoBeKX7mXd/EAQbr
 Dtfj6wQUjflfuhCqM5/qxD2+0w3jOksMvqKkMJpR2ZG+Xg+HOFRED/S1VyX/1jgLqGOq
 Q0mXvsXPv2oBIMMo+hy76Uxr0nx2u0lnq71JjbzK1mZXjc+jXj7owGaM1SyvoZcW1OG9
 sm6Y9fe6IRyO2kUtLdk3TiM2j2lh0dbVpLVMIQ8h0iPlVY7tfEzG6x5b1kQZxW0jUU3Y
 hxrQ==
X-Gm-Message-State: AOJu0YyIknjtI9OVlmqLdX+UWlP0IZxB6d8cgJtmNdobRKXPefuIfwqL
 rFTwcNCeEt4/PO9xf0csb7iog40jWufIhLaf1X4mON7G8JBgvFaZtUzkw8K4jAQZGynh4qEpEfb
 Y4nNESgJPpueCCeXgr8Co1b1Kt7EYvAX97CMkAfHaGEh+BJWB6uK6c6ZPcEJgTi/jezEHfVNp7s
 BCSOig33nysRpKCTdczXTLWhrn1CktfBJgzNjFc2zA
X-Gm-Gg: ASbGncsRbO9XufAJn621wg31ZzOK8OtRGGlkj5QeDtyiYdaKQOHiv50OdkG5kuFo4Jb
 4GTQzqlCJ3N4Peotnb/L5ktjxAbH1QgyGQYzb1+D4MEQxvITWh2dTJNwzUS5Ktd/OhOUXal4hfE
 l2PsMU5iHBvtTh30rzIvfFdjP59+Q1Od5wb/X7VmacSyfPyaa0XoVtKtiVdu+WAEhFWHfeJuLDj
 UcZJKNYoT3D7EzaJzvjGJZwIgWWDybqWLEKUyANpYOfO+VtFUTU1YzKvBFkwE55i3k7RuUl9tmB
 6856Ax2Ny/0bCg==
X-Received: by 2002:a17:907:3f09:b0:ad8:8d3c:8a73 with SMTP id
 a640c23a62f3a-adb3228d6aemr204216666b.17.1748589304834; 
 Fri, 30 May 2025 00:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAz9rQscQf7LBC9xtlARklz58FsrvLFoS4YiflZDixr11eSBQMYPMai5eDSzZmM4j9ylNxUA==
X-Received: by 2002:a17:907:3f09:b0:ad8:8d3c:8a73 with SMTP id
 a640c23a62f3a-adb3228d6aemr204213766b.17.1748589304283; 
 Fri, 30 May 2025 00:15:04 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd043d5sm275869966b.121.2025.05.30.00.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:15:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 53/77] i386/apic: Skip kvm_apic_put() for TDX
Date: Fri, 30 May 2025 09:12:23 +0200
Message-ID: <20250530071250.2050910-54-pbonzini@redhat.com>
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

KVM neithers allow writing to MSR_IA32_APICBASE for TDs, nor allow for
KVM_SET_LAPIC[*].

Note, KVM_GET_LAPIC is also disallowed for TDX. It is called in the path

  do_kvm_cpu_synchronize_state()
  -> kvm_arch_get_registers()
     -> kvm_get_apic()

and it's already disllowed for confidential guest through
guest_state_protected.

[*] https://lore.kernel.org/all/Z3w4Ku4Jq0CrtXne@google.com/

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-42-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index 39035db0422..1be9bfe36e9 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -17,6 +17,7 @@
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
                                     int reg_id, uint32_t val)
@@ -141,6 +142,10 @@ static void kvm_apic_put(CPUState *cs, run_on_cpu_data data)
     struct kvm_lapic_state kapic;
     int ret;
 
+    if (is_tdx_vm()) {
+        return;
+    }
+
     kvm_put_apicbase(s->cpu, s->apicbase);
     kvm_put_apic_state(s, &kapic);
 
-- 
2.49.0


