Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E06D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvh-00088E-4I; Mon, 02 Mar 2026 03:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuq-0005Ny-2v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyun-0001wg-13
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGbW5Lswy3D/DLPTw7v4xtq/OZ5sriiLYtlBVzlRKco=;
 b=LsjRlqpr/ZbkMj9/+NFfslF8ixGnlvVZNIoCrgk8U0o4ws6pGn9qK22bKmc0Yld274TUTE
 7uEnRPC/zHXBVXBM/gr93jxGOnWmciYNfbAVYrMTTQzLTb3pEVjBXkXc+qfLqYO0kxeMfS
 +lAhahzekMYbCrfXkm1YTcw3zmVxmfM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-jBcBIU5GMzuc_0VK_BmxiQ-1; Mon, 02 Mar 2026 03:45:55 -0500
X-MC-Unique: jBcBIU5GMzuc_0VK_BmxiQ-1
X-Mimecast-MFC-AGG-ID: jBcBIU5GMzuc_0VK_BmxiQ_1772441154
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48071615686so32875165e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441153; x=1773045953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGbW5Lswy3D/DLPTw7v4xtq/OZ5sriiLYtlBVzlRKco=;
 b=hUDLbgDZprcBG5u8Os5HCc+O6708BPVk65+ntvo/q8XkQsud94mo2ryhWDdWzUkN65
 ehxOATb1umSO1Y/BxZe3vrZHRVucbfnjk33aW38TE09er0+FmKNsf5UpAi6TyhMCJtK1
 FhtoTKNnI5SomWh2DO4nl+GffPtfDlD3QO0/d4X/bRtBxrevXakkjIIFq0nZ8Yt2YS17
 rk70Llgu0moKetbsMnmuanw4u0bTQKNnq+r55I+7CEI8mH2yIjXsxxt0frJSwA/JAYag
 +D+/vcMIDNNDCD/uMQ9a9QXe0xSjRGHVGnQ7EzkDYHwRLE7lQ3nbIYNK/8CgUE6YGcOP
 jkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441153; x=1773045953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KGbW5Lswy3D/DLPTw7v4xtq/OZ5sriiLYtlBVzlRKco=;
 b=XFqNPacBauLCRHgwFzUDYj7sdutpq9EAxLcXMiOwfyrEtZ1J3tiVWxL9F07EKE+dce
 uYKpVg3SvzLV9SA+OrMX4CohGRCglxZEggHnILPtKJMsum74UBTSAtFy5unQci+/IKBq
 zHYJGltCD79EP5dK0RR668nDHN/gsCxLSnXw82FNOhcLpF3dSIAwfETxtDy3d20ZDiM7
 ycCW5aiYG1YfYsH6X4QaGBfQNUQAWwO7Fy7WsCgFRUxMFVC0EiMakikttUBLRF+OwL5t
 4Gso38nTTAsiJlfi6TosJRoA6qY+9oDjl2qvD/Yt4VfnjCoF6yZ6CtWDj6p3yYYP4bkU
 z0Zg==
X-Gm-Message-State: AOJu0YyPDFo6tr5jbL4W0JJyAYu832U/mm1V18nMlLniXINJT8KyFViK
 0Ygww7V6logZFLPCZGApzEZ7K4i6AjTkVne078HPaXamzpMgi5zyE1COzonVwTQeV3/cEy1YI1h
 ZWM3Fi2TZ2/G0ymJPgR6rtDoz3jtCoaDdNAhsBONf6klWauRemfhTd6dB5vbGYbK5Agz7QxQuai
 uAKpfW1rDbO7rfku/sBQkeh7qtUHhElFU7CSkgt0RV
X-Gm-Gg: ATEYQzyBWkp0j2HsrCqC3Pa90bc/oH9rvb/wVfCjpgIEXK6b6NSonf/aAM/gQf9cq/1
 0NrZuF6PuZrKgVsYQsOAErmhOjZg4rJPrgOLkGIkrnGkV9ZfI5foW5yv8WafQpBbm0G1SLnnTyp
 AbSaJdTUn7wmeQfdWinJjOLcMSii2k1FFWupte4I5PyZ7v8qq8Q53HUZe/6kEC6+rlUab2t64kQ
 SqJUTWgJ5eqTKPGK4XhlLGv4Vt+z53hLLb3uQORrYCyjGcuYLBZwTPkq96/ftB13cpf5qQHtR4S
 cLxU1iXYT/gV+E4tefPha0t/yrqQdW3KahK1/g7nX6UodX5nyUdoVIC0W4+W12eRF46sNaKjf7E
 pwzYNOJRinEb/u5/+/2F/qpJj1Vec36SY7O27RprZZxuS6BlK1JplJUgGsil56om6Do05owDl4Q
 BrmX7WrsfBIsArbgTcOLycv4fTGYU=
X-Received: by 2002:a05:600c:621b:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483c9babe69mr198735745e9.11.1772441153592; 
 Mon, 02 Mar 2026 00:45:53 -0800 (PST)
X-Received: by 2002:a05:600c:621b:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483c9babe69mr198735385e9.11.1772441153081; 
 Mon, 02 Mar 2026 00:45:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b770c2sm262546525e9.10.2026.03.02.00.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 050/102] i386/kvm: unregister smram listeners prior to vm file
 descriptor change
Date: Mon,  2 Mar 2026 09:42:45 +0100
Message-ID: <20260302084338.473368-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

We will re-register smram listeners after the VM file descriptors has changed.
We need to unregister them first to make sure addresses and reference counters
work properly.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-10-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 524b5276a68..8edfbb834c6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -112,6 +112,11 @@ typedef struct {
 static void kvm_init_msrs(X86CPU *cpu);
 static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                           QEMUWRMSRHandler *wrmsr);
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp);
+NotifierWithReturn kvm_vmfd_change_notifier = {
+    .notify = unregister_smram_listener,
+};
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -2885,6 +2890,17 @@ static void register_smram_listener(Notifier *n, void *unused)
     }
 }
 
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp)
+{
+    if (!((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    memory_listener_unregister(&smram_listener.listener);
+    return 0;
+}
+
 /* It should only be called in cpu's hotplug callback */
 void kvm_smm_cpu_address_space_init(X86CPU *cpu)
 {
@@ -3538,6 +3554,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
+    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
 
     return 0;
 }
-- 
2.53.0


