Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2241E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK39-00020g-EZ; Fri, 10 Jan 2025 13:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2S-0000Ii-Ae
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2P-0001Ai-9T
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8MQ2MjMB7jb1D3OQnYs66viar17UNTxK/JIEnyWAIok=;
 b=X4WZKvKqzk054hlKaD5YVIkn6oG+2KnX+lXmHVweLbDA0CSuZyXU3IKe5fOC9sb3YkhwxO
 4XQRQMZRIV65W5xYiA+7bkFFEHUwghnZ2gQ8NnXUshA8hQsR1kVZV/P/ORr7M6MTeyAu9R
 htzy6wKbD5xbAwRQeYYIBE77EiOLTfc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-cpqEE92TMOmb_du2iKJR_A-1; Fri, 10 Jan 2025 13:47:14 -0500
X-MC-Unique: cpqEE92TMOmb_du2iKJR_A-1
X-Mimecast-MFC-AGG-ID: cpqEE92TMOmb_du2iKJR_A
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa6b904a886so229341266b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534833; x=1737139633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8MQ2MjMB7jb1D3OQnYs66viar17UNTxK/JIEnyWAIok=;
 b=RjBBoOZQj3NfeQMDaMbBHjGpd/XORkEgfllJHTNpBJYWed2d5s3JoNN9i+c+gVBEM0
 81+yTgc9Zd4aB8QOkT+GfTOhpKzaGQEQS/GsNJB+DZu3f0BOhgVaflDvem7ByOvZhB3e
 apbYxihn/o64RxsABO3qmXYsus1JK3gP8A/saelrw6/LL+atiL/EKpqrdWBQ1PnE3/7b
 kWS6kerSY/t1foU0d5hE7tMH4hZWcKQVQxpLwUC9mEVngsJFy0IX2Sm9HU32So7EGh12
 S3im3cc8oi1tOIJSrSlkImBuZ9zZfJgjruVn1v+TpIK/Som6Z8xgZft5mmHhR32f18zN
 SW0g==
X-Gm-Message-State: AOJu0YwWpcvC/YefDJ3y8n00gfSRUgm2B+aiC351dfqDKUWwb3DD93W8
 dotx5vjHLpflsSIwG0OzXA64dXTaw/MNpECloKIQ9BBvwfku3aCcsxKxaR8NB75bboH/EA7i+SG
 7zDMdZf0NsPJl9qQoXFUjyMmxS6+fNK6MYXEfju92RIY9CI6A1kJMf92Fx/q4aDhOuqINxCe46b
 GB0XXA/uwsaegusjVYzwGx/hcG1Oww46tNqdgPwVs=
X-Gm-Gg: ASbGnctujpfI7eZ51h6WQAE6uInZfCzIFmToj6uTJTURoB6KCFQ/OSfxTcDGk51RvQk
 1i9re+ExVUKuRlWJ7lq2rsNZ6GN9ZtPu2i3maQmtHzrfedily2vZEvL8lEd2tS8OTZEtFXZX/PJ
 TeH+EZaqnFAXqMx19zMUtQpWZyP8rogxcswW6HBc4yw1cZZesc9Gx7pnXBHuK6oUI9BWycq/ZVb
 zkRPegHRpYrrMTHv+T773ymG9szjp+R04UPrLQ3gzDWF2f2P9W3/qVzC5o=
X-Received: by 2002:a17:907:7b8d:b0:aab:7461:fbe5 with SMTP id
 a640c23a62f3a-ab2abdc0a98mr1140708766b.45.1736534832983; 
 Fri, 10 Jan 2025 10:47:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ94RtGDZN63sOroT2lh+YsP0P1ThWnpxMz7Wr20WQT9DSuEFB27/AqLzPxBjLnM7VMQOEZA==
X-Received: by 2002:a17:907:7b8d:b0:aab:7461:fbe5 with SMTP id
 a640c23a62f3a-ab2abdc0a98mr1140706366b.45.1736534832563; 
 Fri, 10 Jan 2025 10:47:12 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9060e27sm195956366b.13.2025.01.10.10.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Zide Chen <zide.chen@intel.com>
Subject: [PULL 22/38] target/i386/kvm: Only save/load kvmclock MSRs when
 kvmclock enabled
Date: Fri, 10 Jan 2025 19:46:03 +0100
Message-ID: <20250110184620.408302-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

MSR_KVM_SYSTEM_TIME and MSR_KVM_WALL_CLOCK are attached with the (old)
kvmclock feature (KVM_FEATURE_CLOCKSOURCE).

So, just save/load them only when kvmclock (KVM_FEATURE_CLOCKSOURCE) is
enabled.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20241106030728.553238-5-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7870820a2b6..7536a3c9fd0 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3973,8 +3973,10 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
      */
     if (level >= KVM_PUT_RESET_STATE) {
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
-        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
-        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
+        if (env->features[FEAT_KVM] & (CPUID_KVM_CLOCK | CPUID_KVM_CLOCK2)) {
+            kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
+            kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
+        }
         if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
             kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, env->async_pf_int_msr);
         }
@@ -4451,8 +4453,10 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 #endif
-    kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
-    kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
+    if (env->features[FEAT_KVM] & (CPUID_KVM_CLOCK | CPUID_KVM_CLOCK2)) {
+        kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, 0);
+        kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, 0);
+    }
     if (env->features[FEAT_KVM] & CPUID_KVM_ASYNCPF_INT) {
         kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_INT, 0);
     }
-- 
2.47.1


