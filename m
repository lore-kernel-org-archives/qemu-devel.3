Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47012C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH2H-0002kR-Nh; Mon, 14 Jul 2025 07:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzG-0000ez-9X
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzE-0001Zp-3R
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6nTEsoCuSJ3UH4OjROxuNbEuTg0QB24XVyppadmgMI=;
 b=b5D9Q5jQ37ot49aACGv98FIK6r+qUB5ASuB/fYCxfvHLj+R6nngcsO+GJgRuXi5UydKpV9
 B8OxZRi0HqhgBjkYeXEcoDdnpK/HZoPJ4SVz2RIbF5I88Ux0c8THQpm5KbIXsJMdccSmZ8
 wEAvmfI1CfUpd4YxW310h4wbE0rPDpY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-BpY4cs5HOK6y-O8KMhXIbQ-1; Mon, 14 Jul 2025 07:04:42 -0400
X-MC-Unique: BpY4cs5HOK6y-O8KMhXIbQ-1
X-Mimecast-MFC-AGG-ID: BpY4cs5HOK6y-O8KMhXIbQ_1752491081
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2145258f8f.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491080; x=1753095880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6nTEsoCuSJ3UH4OjROxuNbEuTg0QB24XVyppadmgMI=;
 b=Qk67iAhgfLJqSSxc8FZRANNLs0clomFKvhnMIMoytiXaXvw4uG5b+UPSQzV35AgxBw
 LsvQLomob4U8/IEFxzgdEkDu4qRppyQld66vofRL9KFj2wMG0Mr68GEqexdcQi7jDtN3
 4bbbOlggREyc5RqQcwu7ebuij2YVL685NvCfDZV+Aenkhf6ceckubmZ5ELmIuwv86N6/
 0ZbmGhYSsJpMTBbgXOG1NL+8Y6jihhV09xSqLAigD1029h5aRHJgYg7/+VhMihc+BMbF
 krxsLsM7sF/mIj36xSfNbZlCxV+Au2HzHGoE97/fCBEySCkxux9A0wknZvihj5pxBv8Y
 WXTQ==
X-Gm-Message-State: AOJu0YzXLnuA6NuUpFrtLs4gUGtGU5LmWPsX5qjwWx4yrAh/N2Uet88U
 huV/xMa2emIzDd9BslBsbqq0WmQHv4Lk2h6uCtzzAVY4H3UEa/YvjiSzKW+Eaoyq8cx1O6JKkFE
 RiyfVpH0koZCa5eYdt+x3B/zSlsVetc715Kjpq2J2U/+F6IcSVNuDMR1BAhwxi1JwM3ePaAuK6M
 HPbpZd3aDSDAx+LH6yVSbzmtb7s71sXn6hEpT7eF8f
X-Gm-Gg: ASbGnctQcVKTKP0c7vPaTEAlJQfzbRpWHMyyrnaXzGiA/zLurTgcJCqOloa9t3cMY0B
 9aM7PBWA2eRHbX6YdsV6wM79QUWixmAHdmPNeGI+I4hpp2HMSlNdKmzwLoPlqXT5/U3zLPLmcoQ
 sRrCt3REMCu04aWIbjq09fFiPskgUwD8EwVrTVlEHMJ4ff7RsN4dBc6m2KB7V86riA1hYI4ubaQ
 FgjZvIQQQLavUPE0D8PmkkhftNNDUibrxpUR4ZKZi1srt+ztWiUmRFPvu8nu5jGLK2XkrTVoiij
 wP5oRcEC2PvOMwD7TEOV19vKSgLNb6uVrhIhCz8E0qM=
X-Received: by 2002:a05:6000:2888:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3b5f187adbcmr10705905f8f.8.1752491079827; 
 Mon, 14 Jul 2025 04:04:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOcx/Ts0EgDTHeuvCpdOtPWZD2PmI/y1hY9FF6IXW8kMqAreSs5tl34RgiPmJ5SfFAKt0EmA==
X-Received: by 2002:a05:6000:2888:b0:3a5:3b15:ef52 with SMTP id
 ffacd0b85a97d-3b5f187adbcmr10705879f8f.8.1752491079315; 
 Mon, 14 Jul 2025 04:04:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561323a488sm46946605e9.1.2025.07.14.04.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 11/77] target/i386: merge host_cpu_instance_init() and
 host_cpu_max_instance_init()
Date: Mon, 14 Jul 2025 13:03:00 +0200
Message-ID: <20250714110406.117772-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Simplify the accelerators' cpu_instance_init callbacks by doing all
host-cpu setup in a single function.

Based-on: <20250711000603.438312-1-pbonzini@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/host-cpu.c    | 28 ++++++++++++++--------------
 target/i386/hvf/hvf-cpu.c |  2 --
 target/i386/kvm/kvm-cpu.c |  2 --
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index 7512567298b..3399edc1ad0 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -132,27 +132,27 @@ void host_cpu_instance_init(X86CPU *cpu)
 {
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
 
-    if (xcc->model) {
-        char vendor[CPUID_VENDOR_SZ + 1];
-
-        host_cpu_vendor_fms(vendor, NULL, NULL, NULL);
-        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
-    }
-}
-
-void host_cpu_max_instance_init(X86CPU *cpu)
-{
     char vendor[CPUID_VENDOR_SZ + 1] = { 0 };
     char model_id[CPUID_MODEL_ID_SZ + 1] = { 0 };
     int family, model, stepping;
 
+    /*
+     * setting vendor applies to both max/host and builtin_x86_defs CPU.
+     * FIXME: this probably should warn or should be skipped if vendors do
+     * not match, because family numbers are incompatible between Intel and AMD.
+     */
+    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
+    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
+
+    if (!xcc->max_features) {
+        return;
+    }
+
+    host_cpu_fill_model_id(model_id);
+
     /* Use max host physical address bits if -cpu max option is applied */
     object_property_set_bool(OBJECT(cpu), "host-phys-bits", true, &error_abort);
 
-    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
-    host_cpu_fill_model_id(model_id);
-
-    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
     object_property_set_int(OBJECT(cpu), "family", family, &error_abort);
     object_property_set_int(OBJECT(cpu), "model", model, &error_abort);
     object_property_set_int(OBJECT(cpu), "stepping", stepping,
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 2b991f2fc8e..94ee096ecf7 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -21,8 +21,6 @@ static void hvf_cpu_max_instance_init(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
-    host_cpu_max_instance_init(cpu);
-
     env->cpuid_min_level =
         hvf_get_supported_cpuid(0x0, 0, R_EAX);
     env->cpuid_min_xlevel =
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 6fed353548e..a99b8764644 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -109,8 +109,6 @@ static void kvm_cpu_max_instance_init(X86CPU *cpu)
     CPUX86State *env = &cpu->env;
     KVMState *s = kvm_state;
 
-    host_cpu_max_instance_init(cpu);
-
     object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
 
     if (lmce_supported()) {
-- 
2.50.0


