Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6824FE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVE-0006J8-NA; Mon, 09 Dec 2024 15:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVA-0006FH-9U
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:08 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV8-0003ES-Ks
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:08 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso885673266b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776625; x=1734381425;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xw6Nq/8rslxJnUqkSeXiT5oto8WsRm37mAQv6Zrh7Zo=;
 b=10BtnBuKV4kcVgE0DHwEefoen9gFWctr/d3uBG9O7EByyHzpVxQzesF7Pg5mFXMOPf
 FEhsP8kG99qJNyTx0aPJpsFSLSKFEcPwkKfOFE2s5nxFcux16gmU0xV3UMjP/Ki8Tca5
 Zu5I/VNbG5F14JZCPGujjnXW3aMSYIG4XVXob9rycbkG9Ec2ivok9bhQLRb/fECDEqxy
 lSXhT8k/uzJzDBzx6euLGnWV92XpdT/40REo/zpwQcgXKvfO3GMl1XvMqC5nA0TVSJQy
 J+Z2+XnGt0iLYiNeemp/qIluX4ArIh1cSqjk4Ia6AbYFyK2Nj62PRG60eeUvYYnHXKoL
 xjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776625; x=1734381425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xw6Nq/8rslxJnUqkSeXiT5oto8WsRm37mAQv6Zrh7Zo=;
 b=kIJl6RbyJ76mA2elpCECbGMWn1I7fUMQJ4RYlllYEyWpWLWIJE1MdRp6PvtNbyUr6W
 /wiDr5H951vJEkLtXoMETa5kizu9qyoiS8JM4QZ0zcNWH9/KQjV9XmBEerQWN3oDowBJ
 JBBfBrzP17TcSBIlf9aJ6cpPVtSJWMV4EvfFo5mtExb+VrMNlWkj4AOZssDnBNMbyNYV
 1iUkF/vfId/8QtyxJVdlZgkdnfwK3y2Xi8mwbgNNpY9Jn8GygPS/i6YLRV7l23LAy+Sl
 EhkVkeo/PsJVBjr66cr5ArWwcguwcJ6H8mDVd0EmmVh93YWYi4jEsWoZz1PO5rsTy+fL
 V/+Q==
X-Gm-Message-State: AOJu0YwI74v73fzWDoZaQZGy/GtqwZWiP25iwFX8BU/wftZ4VocyZLUm
 3M5RKnn+xwr6UngY+3sPRLkTxxxSX+aXRbUlhvx9PNTq5WC3al+ljppPvu/9L77mk/Rj+t3T8HM
 e1g==
X-Gm-Gg: ASbGncsaDy1vs5DUi4qyncum+fPxrGCVYoM/CcUZ0+Bn6vnHPM6lKokF46mrhEPOYSP
 r1P2R4G0Sz1Ic0iK8igpUsa8pDAjfjMtLKeyEXsDXAY+GorPVdmmTJRA7o3KcFrdZc+f9QvAhbV
 9S4oEjkEBEXW7p+dNwifX5y45gAo6ktLDhwUXJ4iiCgAyjaTxLzIbOxNW29sf6+jIbxWOL7Zvzh
 VgeTmh1D0K4j5OFDFz7yNgXMtBLeJeA26fNadrMO9wjJVOTfwa2NeGWjrq4OlQLu/b0gCYjQQ/i
 e1z74pn1dRlms7CfhYz1PP6aT4WdLQ==
X-Google-Smtp-Source: AGHT+IHMg8u6xatM3JB2nocPT1UsXkGcZR+sI4zYs81yAcFM4A0d7QHtdMwFv1r1VAuu+oR+0IFR5A==
X-Received: by 2002:a17:907:1dc4:b0:aa6:6c08:dc71 with SMTP id
 a640c23a62f3a-aa69cd8131emr196188866b.23.1733776624887; 
 Mon, 09 Dec 2024 12:37:04 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:04 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 07/11] i386/hvf: Enables APIC_ACCESS VM exits by setting
 APICBASE
Date: Mon,  9 Dec 2024 21:36:25 +0100
Message-Id: <20241209203629.74436-8-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62f;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

This change activates virtualised APIC access VM exits so the new
fast-pathed implementation will be taken.

Two parts are required for enabling APIC_ACCESS exits rather than
falling back to "regular" MMIO EPT faults: Hypervisor.framework
needs to know the current APIC base address, and the APIC access
virtualisation ctl, VMCS_PRI_PROC_BASED2_CTLS_APIC_ACCESSES,
must be set in the VMCS. The latter has already been set in QEMU's
HVF accel, but setting the APIC base address has been missing.

This change calls hv_vmx_vcpu_set_apic_address() before a vCPU
runs for the first time, and whenever the APICBASE MSR is modified
and the xAPIC is enabled. Additionally, the APIC access ctl is
toggled when the APIC is enabled or disabled, or changes mode.

In addition to making APIC access VM exits occur at all, it also
makes APIC relocation work, at least on the fast path. (QEMU does
not currently support different address spaces per vCPU, which
is why the purely EPT fault based software APIC - and thus the slow
path - does not properly support relocation.)

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c     | 11 +++++++++++
 target/i386/hvf/x86_emu.c | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2a13a9e49b..a7b8d124bb 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -341,6 +341,17 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
 void hvf_vcpu_before_first_run(CPUState *cpu)
 {
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    hv_vcpuid_t vcpu = cpu->accel->fd;
+    uint64_t apic_base;
+    hv_return_t apicbase_result;
+
+    if (cpu_is_apic_enabled(x86_cpu->apic_state)
+        && !is_x2apic_mode(x86_cpu->apic_state)) {
+        apic_base = MSR_IA32_APICBASE_BASE & cpu_get_apic_base(x86_cpu->apic_state);
+        apicbase_result = hv_vmx_vcpu_set_apic_address(vcpu, apic_base);
+        assert_hvf_ok(apicbase_result);
+    }
 }
 
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 197fa155a0..88a946cb0f 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -797,10 +797,28 @@ void simulate_wrmsr(CPUX86State *env)
         break;
     case MSR_IA32_APICBASE: {
         int r;
+        hv_return_t res;
 
         r = cpu_set_apic_base(cpu->apic_state, data);
         if (r < 0) {
             raise_exception(env, EXCP0D_GPF, 0);
+        } else {
+            uint64_t pbc = rvmcs(cs->accel->fd, VMCS_SEC_PROC_BASED_CTLS);
+            uint64_t new_pbc;
+            if (cpu_is_apic_enabled(cpu->apic_state)
+                && !is_x2apic_mode(cpu->apic_state)) {
+                res = hv_vmx_vcpu_set_apic_address(cs->accel->fd,
+                                                   data & MSR_IA32_APICBASE_BASE);
+                assert_hvf_ok(res);
+
+                new_pbc = pbc | VMCS_PRI_PROC_BASED2_CTLS_APIC_ACCESSES;
+            } else {
+                new_pbc = pbc & ~VMCS_PRI_PROC_BASED2_CTLS_APIC_ACCESSES;
+            }
+            if (new_pbc != pbc) {
+                wvmcs(cs->accel->fd, VMCS_SEC_PROC_BASED_CTLS,
+                    cap2ctrl(hvf_state->hvf_caps->vmx_cap_procbased2, new_pbc));
+            }
         }
 
         break;
-- 
2.39.3 (Apple Git-146)


