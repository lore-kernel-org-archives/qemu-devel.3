Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C90EE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvJ-0005p4-83; Thu, 12 Feb 2026 09:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvE-0005fK-A2
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvC-0006DU-HD
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UnAQ+JDnymETfg+WiYDLUt8ZapEKgk2VtyvzlE9mJ/M=;
 b=GfxJDlvXiiDdjh6da8kaO5RqC6bLu4cGzPyhS8UNtDNcI34L5fOPBST4nWcaazHgt5PXDC
 QnUEhQJ7Ay3EvNHDaC0XkrE1hmOd7cTm2/iES/pvtWsIUe0YqDW5uJS9RP8D7D4U6RQdGg
 SRDhutCHq/Q+frxauYEcaS2N198mCe0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-jst3qz-oOKGw_bwysf0dJA-1; Thu, 12 Feb 2026 09:43:56 -0500
X-MC-Unique: jst3qz-oOKGw_bwysf0dJA-1
X-Mimecast-MFC-AGG-ID: jst3qz-oOKGw_bwysf0dJA_1770907435
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-480711d09f1so43114625e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907434; x=1771512234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnAQ+JDnymETfg+WiYDLUt8ZapEKgk2VtyvzlE9mJ/M=;
 b=bdNBEG/kXgO40HW8vMhekRQcvp4ayMokgxXxml/uZGiC/m8iVBQLkuV93oT7VltmNX
 M6xQR+D2roEbucQUMYNmPuMF5PBuoD4/PHGYxu49dDffFfVt6fgDxuwiKaZ7crTbdBHm
 VgWr3FX8GfAxD4JJVy5eXKuZm3+y82Zj2WilkPIkxmt9ge9TXpphY4j6oCBSsBh2CgFR
 DJ6hPQZ3M4ZCHiwpVLhbZKp/mm02NJWI2+Krtf3uLVhRMAYRwxFHiAblMH0we5pVt1vU
 XyGE6X87m0Tc0sYjYnJ0s0VOGrq8gVT9YVgPOXWLPdb4qkwLextNtuDJvt2EV4eGtKDj
 2K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907434; x=1771512234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UnAQ+JDnymETfg+WiYDLUt8ZapEKgk2VtyvzlE9mJ/M=;
 b=ZDDsjMS/5sLCFIp+oOoeFMCillV7Z9cxj7cj4HWAszuNeYTLddvZ6DwFGUnEKPFLqa
 H8BOHjoGdKv66Cms22wkyJ9Mtoc3NPgf8oUtLV1x5/kh/TjzCWSftSWOWreClOtdUMq5
 KB4MuYRS+mbzXO9S5eGd1xsWhCwyXH8g5/Dl9dhnuvDrxX16YgsHevrh8o9sfKKoAVOT
 SJi626FQ+XnfVDnqGG2V+3uVab1Deg08GJp+62KvSJ3iNQoddkzTxxxvWZPIB+nwAKRH
 zU3WGNxEzTxNDto71xUCg5iYjeSdfT59JG08s2q5isYC7EQUIVsjlSwhdPtdyGCcT0gS
 5blQ==
X-Gm-Message-State: AOJu0YyUL9Xs1YHLMqLAmf5Z4IK7krO1VJbBdeVopopYg/0uJhOGsEm8
 jhRQqKs5KLFJSY92cN5Q4wgvJNpqpYcf6Kpvy+3s/gZB6OhWbn8f5vjxWfmk+thksBXoKxKBx+F
 JD+Ibi3EfYyjq9DBlWWznExVB8ALG7GtlIuIBHogLZ2CY/7BkRXTJ+I8+Xi01NB23DdkqQ3w1lT
 I6IaZNIbVb+EiK/mcA4yiVC3VYwgjhdj4xQCTM/+Nd
X-Gm-Gg: AZuq6aKG1a13BbN0jOuobyXOFMmMbW7nOI6wU7GnKRHGzIbVbMNq9UEA4iEg3qQArga
 xXSiH9e62xqVhYaQteEYRGG/vtrFJTnrU/zryOtgTaoK5lcJ5HppLX/P1n4GwwUc/ePCZRT2hDO
 WbRUa5Cv8v4czTKNdAXaWU+xQuHxKvqBR7bBWEudiIGLKKGtRbfrO4WKAx9VtMLOEMAypwRNKR3
 v9ZwCh2QoIwyIsYydo9nW34MVynLr9CzSL8sMeDGjow5JuMcqRX5DWNO3SUVAqtIBW+LqdgDf1r
 3nxdI4XPl/zfybCCYioSXcdVOqRT9feArkCHBtkzwBiURnYB+Wzx8lFAjEfqFqoO7ItLn++AB3x
 zIHZWT1P0//X9TQ53qNNR4UmYW0w9+Sq5YyPfJs8mM4oZ0mkd4ga3wKR11yCWBYLE1DqLXlUIsp
 lTyabKo9NIvBBb7HQwpgiZgDPVpQYAWEs4dxdaNO8f5CZ9euAb+ow=
X-Received: by 2002:a05:600c:350f:b0:483:4807:210c with SMTP id
 5b1f17b1804b1-4836715a2bcmr39802635e9.24.1770907434206; 
 Thu, 12 Feb 2026 06:43:54 -0800 (PST)
X-Received: by 2002:a05:600c:350f:b0:483:4807:210c with SMTP id
 5b1f17b1804b1-4836715a2bcmr39802065e9.24.1770907433753; 
 Thu, 12 Feb 2026 06:43:53 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a60ee40sm99570605e9.1.2026.02.12.06.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Zide Chen <zide.chen@intel.com>
Subject: [PULL 30/41] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is
 configured
Date: Thu, 12 Feb 2026 15:42:32 +0100
Message-ID: <20260212144244.22579-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongli Zhang <dongli.zhang@oracle.com>

Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
there is no way to fully disable KVM AMD PMU virtualization. Neither
"-cpu host,-pmu" nor "-cpu EPYC" achieves this.

As a result, the following message still appears in the VM dmesg:

[    0.263615] Performance Events: AMD PMU driver.

However, the expected output should be:

[    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
[    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled

This occurs because AMD does not use any CPUID bit to indicate PMU
availability.

To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
when "-pmu" is configured.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20260109075508.113097-2-dongli.zhang@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0c940d4b640..69748420fd6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -178,6 +178,8 @@ static int has_triple_fault_event;
 
 static bool has_msr_mcg_ext_ctl;
 
+static int pmu_cap;
+
 static struct kvm_cpuid2 *cpuid_cache;
 static struct kvm_cpuid2 *hv_cpuid_cache;
 static struct kvm_msr_list *kvm_feature_msrs;
@@ -2079,6 +2081,33 @@ full:
 
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
+    static bool first = true;
+    int ret;
+
+    if (first) {
+        first = false;
+
+        /*
+         * Since Linux v5.18, KVM provides a VM-level capability to easily
+         * disable PMUs; however, QEMU has been providing PMU property per
+         * CPU since v1.6. In order to accommodate both, have to configure
+         * the VM-level capability here.
+         *
+         * KVM_PMU_CAP_DISABLE doesn't change the PMU
+         * behavior on Intel platform because current "pmu" property works
+         * as expected.
+         */
+        if ((pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu) {
+            ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
+                                    KVM_PMU_CAP_DISABLE);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "Failed to set KVM_PMU_CAP_DISABLE");
+                return ret;
+            }
+        }
+    }
+
     if (is_tdx_vm()) {
         return tdx_pre_create_vcpu(cpu, errp);
     }
@@ -3390,6 +3419,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
+
     return 0;
 }
 
-- 
2.52.0


