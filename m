Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6D1E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQuw-0003Zg-Eu; Sat, 27 Dec 2025 04:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuT-0002Fn-PS
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQuR-0006tM-BV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:48:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/Vz2CUHAmSaLIK8YaLXzjbxqiWBCQcRlEKeuVHl6Oo=;
 b=Rqchk4xRwHx5apkXWHTmnhUtEDo8gssATV2GeqMUct0I1wsGcPAbPEqtEK7p5O4pN4mdVs
 THIXBijLc8D0MoKmbD/T08nRtG7T7czRJj69HQxEnpStQseYBaRNRwFJHwkGSWO79uwBtU
 PTFmAmzXooInJsDHpI01YVM0aHv1JUo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-2slGkurSM-iX9Kduw2JBIg-1; Sat, 27 Dec 2025 04:48:25 -0500
X-MC-Unique: 2slGkurSM-iX9Kduw2JBIg-1
X-Mimecast-MFC-AGG-ID: 2slGkurSM-iX9Kduw2JBIg_1766828904
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so65312525e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828903; x=1767433703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/Vz2CUHAmSaLIK8YaLXzjbxqiWBCQcRlEKeuVHl6Oo=;
 b=Jkv7PkYl4sEU19h5wwyEvbRC1QGvW8KfPnwCnEiV40vWGgXELhAGjp7RCUVVJzZLGj
 e7+TevrfKfx4i1l/k+/wogwnGGvuqxAj4cCGFDY86GZXQrqR3itK+vf9EYSvu+iAapTj
 5jS7pe5FyLn962sMTTZAS7IbW1H1EBgfXwXvSpmvlH8xfojPrToDegshfcqz0cMXXes5
 3HdgolN63KMdaj/SP1NWln28D0mCK5v8+EVi+b2bHaiGARjDVSQC5LplLmdA0J5R+1BW
 nkHgCmXnh7OUX97J5PnwOlES9YUeW+dxYrPphcV7GQzbE7i4SZ0MCFxSxORkkeOEiEl7
 9H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828903; x=1767433703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r/Vz2CUHAmSaLIK8YaLXzjbxqiWBCQcRlEKeuVHl6Oo=;
 b=jHG5JlhgFXMe2EqVmAQ6B6cS8UpvvULie6GLvKc1w+txJuHc9Qxi1BZqa/F/iIqgJ2
 Tzp6U1q2BCUN8FfWZ/wPmWqL/Vc703REyX18VSS75T+yxeN5VfN57KVCZ98jGrgVXXK5
 Fy0Zn6CD2koX9Tj37H87vUfu8W/sTchkpwq9DasgUxtNns3P7Xs/2eTb9btqnri8DuY8
 JumFrVwmqkXARLU9Y0QNzvmkuEjdx2fiBvZ4psmTOEwrtaRSS7mZHGz5IVNqu66kb1tc
 EvoJrjhq9Lm8ZHsn+KBbG3LQv2p1UR1W0/wRI1XGFVaGyURcbHnpuht+kV0M9s342Lnn
 kVSQ==
X-Gm-Message-State: AOJu0Yx7lfMSybkLlQJrBGPsXhYqhajsp4qbvYudOsIpdhyhqkpRCr4s
 Cc7Yt1/rXx3CU0yv8rxFnNIEHMO3ouIdlbR3EP5takb1Q6PigicOlFHgK8NXqDqrBc7SG6/rlJh
 trYRh+/6spa/W1+V4Q1a982Koz4ZqmmUFywZi/oUqwwsjkjmP0xVpUfVvN9OfKSZwmbCwwopI8Z
 vbyAyXUTNDJB3MuyjAjZbzgY9D0K3Y0T4/w9yCZckd
X-Gm-Gg: AY/fxX6ivdAsMvJ+Zs75i1YQJv9lsWj85R/iBNfoD0vKHHVcF6Jui/TtZtDwArzJ6Sw
 nuBLzkIFTLMIQV2xZm5WC9EBdEp4csuijKfws8WSAGrsG6srPN3QAcY3xsNDjyMT5NyS7Q0u3ga
 ZJmqWl8kNouMFp2EvrPCd14DndtiKUp3XRID7P0OIscgo39AfEGBq/gaQ2SYKrDTC0AiLxhdrY1
 79tFdxBUiIvt5LUIdiBExgl8XFffKAspdgo5m5UuTd2Yh/eWyQLIeaNfBWJjp9cWyH+1ws11EOT
 21z9KFA0BLxDAOPKjpNsgt261OZLibwWtdWc0H4fVL1908cDLbKIBxPVeKAPNXHWNhwTWWhdYx/
 VgGpP6/MXfy0bLlGlkk5xBgpQBOSSz4up0LaZkke/sWygwFOe/9TeUnQ5Zoz3ZeGIt4RjYdBMyK
 EAm1kdP1tz2li4Qfk=
X-Received: by 2002:a05:600c:3b9d:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47d19555e07mr344065225e9.13.1766828903417; 
 Sat, 27 Dec 2025 01:48:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkXjh17Gc3ONEKcCfBrAFN2l31vqQQnRDnJ4MvwWALmJZ3e0OuL60yRySzT1bcRHFj+7oOcQ==
X-Received: by 2002:a05:600c:3b9d:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47d19555e07mr344065015e9.13.1766828903017; 
 Sat, 27 Dec 2025 01:48:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19362345sm432836685e9.6.2025.12.27.01.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:48:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 "Xin Li (Intel)" <xin@zytor.com>
Subject: [PULL 085/153] i386/cpu: Save/restore SSP0 MSR for FRED
Date: Sat, 27 Dec 2025 10:46:50 +0100
Message-ID: <20251227094759.35658-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Xin Li (Intel)" <xin@zytor.com>

Both FRED and CET shadow stack define the MSR MSR_IA32_PL0_SSP (aka
MSR_IA32_FRED_SSP0 in FRED spec).

MSR_IA32_PL0_SSP is a FRED SSP MSR, so that if a processor doesn't
support CET shadow stack, FRED transitions won't use MSR_IA32_PL0_SSP,
but this MSR would still be accessible using MSR-access instructions
(e.g., RDMSR, WRMSR).

Therefore, save/restore SSP0 MSR for FRED.

Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211060801.3600039-14-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  6 ++++++
 target/i386/kvm/kvm.c | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index a1ff2ceb0c3..84e5cf0ab0c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -554,6 +554,9 @@ typedef enum X86Seg {
 #define MSR_IA32_FRED_SSP3              0x000001d3       /* Stack level 3 shadow stack pointer in ring 0 */
 #define MSR_IA32_FRED_CONFIG            0x000001d4       /* FRED Entrypoint and interrupt stack level */
 
+/* FRED and CET MSR */
+#define MSR_IA32_PL0_SSP                0x000006a4       /* ring-0 shadow stack pointer (aka MSR_IA32_FRED_SSP0 for FRED) */
+
 #define MSR_IA32_BNDCFGS                0x00000d90
 #define MSR_IA32_XSS                    0x00000da0
 #define MSR_IA32_UMWAIT_CONTROL         0xe1
@@ -1970,6 +1973,9 @@ typedef struct CPUArchState {
     uint64_t fred_config;
 #endif
 
+    /* MSR used for both FRED and CET (SHSTK) */
+    uint64_t pl0_ssp;
+
     uint64_t tsc_adjust;
     uint64_t tsc_deadline;
     uint64_t tsc_aux;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e98da47a451..5b8c7550a16 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4009,6 +4009,11 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, env->fred_ssp2);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, env->fred_ssp3);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, env->fred_config);
+            /*
+             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+             * CET shadow stack is not supported.
+             */
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
         }
     }
 #endif
@@ -4496,6 +4501,11 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP2, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_SSP3, 0);
             kvm_msr_entry_add(cpu, MSR_IA32_FRED_CONFIG, 0);
+            /*
+             * Aka MSR_IA32_FRED_SSP0. This MSR is accessible even if
+             * CET shadow stack is not supported.
+             */
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
         }
     }
 #endif
@@ -4747,6 +4757,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_FRED_CONFIG:
             env->fred_config = msrs[i].data;
             break;
+        case MSR_IA32_PL0_SSP: /* aka MSR_IA32_FRED_SSP0 */
+            env->pl0_ssp = msrs[i].data;
+            break;
 #endif
         case MSR_IA32_TSC:
             env->tsc = msrs[i].data;
-- 
2.52.0


