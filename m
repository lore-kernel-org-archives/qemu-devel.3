Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6ADCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dd-00076q-Lg; Fri, 26 Jun 2026 06:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dX-0006kb-GS
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dV-00059d-BN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJ6Jhva/9BMAzE6GohjBEcGDjyJ5xP7a38OigOy2rm8=;
 b=ZlcIB7+vFVUimU4yT8nmd2EFQUGro74ufx0rEDApDgNjGK4zMP2ug17x0LOjxZgNLLwv5F
 bJ/yak1dAGkLEeaAJpBwPkGXU3s4qtrMstXXF63qNMfA0LFjIFSy2skUmxwqc2X6aUu80/
 uxp82dXpenKAOaK3JEK4nkeyxsrNZQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-XzxnCCHIPFGX_DHC_lSe9A-1; Fri, 26 Jun 2026 06:18:10 -0400
X-MC-Unique: XzxnCCHIPFGX_DHC_lSe9A-1
X-Mimecast-MFC-AGG-ID: XzxnCCHIPFGX_DHC_lSe9A_1782469089
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4924a7ae480so6762635e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469089; x=1783073889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJ6Jhva/9BMAzE6GohjBEcGDjyJ5xP7a38OigOy2rm8=;
 b=Rda13KxWUZcqrXl7QB56ZsA7B1PGn2fDs1YeCFXUTWlmxQkoaMliLBMZtKuXRaQIzI
 /cInjJmVg7u8c9p+6s8WJ9FL1X8MIRGnQjOzLn20Q2BnWnq3D5F9hh6+drS4rjLPQbb2
 UlhjpVq6b+07VTO7OKeA9dAyR33G0Gfs4Suralp8+E6Cj8pheF+D9303PgPoSXrrMRCi
 TJtLIpphAVlmaasjwXMdxDgtIihbr3Zjm0xsAtZXmZgMOrm3ex2bcxVj81jfuaVussi4
 jogViLBczR212qH5SSbShsYN+rZGEGc+T8olVKaLbcjzwikWu+SeCZfcD8ENNjTma0s4
 D/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469089; x=1783073889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KJ6Jhva/9BMAzE6GohjBEcGDjyJ5xP7a38OigOy2rm8=;
 b=P35OVtF3E46ktmXo7C++w6ZNE/4iRM1y6K7hje0lopKbWEKl/XCLmCCt5I5bMjpg/M
 9IveNzOGqjNFKXCiaW25AP8o+Y1ZHpwczI87P9b8MJv+m7Is8a2sflgzGwezYznizr+l
 TfzuaQcHYZ/UvoB31sLCzZfbz2kAhDo6PlAtChx4nF/fNurBN6ZgEiUu6H7aeRlKhQc1
 7yFKTEsBHUHm8m8oPAegwp0+TZbFHdYocsEGnwcWldnOtujYZOGnyJmSxusM6pAiKOOD
 pzz49Vk3wT6EY4ANGsmyaQJbeiIBXXtNuHfEj2zRdx0m3DFOcgIhLtkMh3hZ3O6kJeU1
 qjmQ==
X-Gm-Message-State: AOJu0YxhM8EpPKyIbca73XFtO4PiQZnjEtqgSy4yI0oE+Em9qmFMfNoO
 nF5HB25vKGbYsFEDN0ZZz5krmmNDMO4IcvqxLMYH9SvkcWyrqkLXkU5eM6PjusZ28M5Xk+sEyMU
 Jmy4HefKAYDMK9rZ3HAh2ipbUJI2mQBPT1sX+R+1jycbgQ9s2mqc3wrAWHvJ4Yga5QUcdbw34aq
 wA3KutAWqcvpj5jbH3DrttRuRdJqWservbrkn2UZY4
X-Gm-Gg: AfdE7cn+yGtJFomDOnnwSlFdPANQ2oKbIINr5cmf/rBWvl1GqTCv+xN72P8DLQ/N67X
 fyBN/C9L2TleH/wrT6+UhReDcJwqPzKdZqQtTTjh1pzyTgMUiu0FnVgp0KAMRm0kf8a3qOWjn4p
 j2YblD8SLBrGt5uFQ9DyP/rQjPeE0CccMG47GmwqCzXgEoaA4tYRepWjPGtXJqYf0Bm8ptRnWNE
 M8+mWeW/spM07CNlDptl89aMUnJLfrkiZhGP3bgcbSiqHzVFHfYDIY+KLk6LzCP4fAEAKEDCgj5
 Orh8+lua/4wMbvLjHKrCFxS18xTKrN28O3UfgDvEMaO3Z1GNLo3XkapNPAGtlkB1yxx6IpYbcQ/
 Mhbm6iiw18Z0/QWpAlrqrAoCtSlu782uIdu9zoa9OegXLRgAjYtApamekKktBQccVjsLgjdmDTA
 wL5/PiSpTg09F8PyUV
X-Received: by 2002:a05:600c:6085:b0:490:44eb:c1dd with SMTP id
 5b1f17b1804b1-4926689f39cmr95147435e9.29.1782469088824; 
 Fri, 26 Jun 2026 03:18:08 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:490:44eb:c1dd with SMTP id
 5b1f17b1804b1-4926689f39cmr95146865e9.29.1782469088394; 
 Fri, 26 Jun 2026 03:18:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fd9f2esm60218135e9.5.2026.06.26.03.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 07/45] target/i386/mshv: populate xsave area offsets
Date: Fri, 26 Jun 2026 12:17:10 +0200
Message-ID: <20260626101748.1728079-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This function is copied verbatim from kvm_cpu_xsave_init(), for MSHV we
need to populate the offsets similarly.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-8-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 00b8ac18e46..66733390c3e 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1731,11 +1731,42 @@ int mshv_arch_post_init_vm(int vm_fd)
     return ret;
 }
 
+static void mshv_cpu_xsave_init(void)
+{
+    static bool first = true;
+    uint32_t eax, ebx, ecx, edx;
+    int i;
+
+    if (!first) {
+        return;
+    }
+    first = false;
+
+    /* x87 and SSE states are in the legacy region of the XSAVE area. */
+    x86_ext_save_areas[XSTATE_FP_BIT].offset = 0;
+    x86_ext_save_areas[XSTATE_SSE_BIT].offset = 0;
+
+    for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+        ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+        if (!esa->size) {
+            continue;
+        }
+        host_cpuid(0xd, i, &eax, &ebx, &ecx, &edx);
+        if (eax != 0) {
+            assert(esa->size == eax);
+            esa->offset = ebx;
+            esa->ecx = ecx;
+        }
+    }
+}
+
 static void mshv_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    mshv_cpu_xsave_init();
 }
 
 static void mshv_cpu_accel_class_init(ObjectClass *oc, const void *data)
-- 
2.54.0


