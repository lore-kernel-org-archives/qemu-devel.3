Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C730F108E1FA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3COR-0005Lr-BR; Thu, 19 Mar 2026 08:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3COL-0005Ge-V0
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3COJ-0007gQ-QX
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773922939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
 b=RbaFO+7xAfBVLd1Jgdn15zgnqI4bIC8FhlXeuPv256HAYQrfoVzAuVGSavYceB6F1o2zxA
 +8yFE41mnBZuyIIc2KzSlblJocZYiUjAeV2YPLDbyVN6FQ2jdJtvn0+mzrHkEnMWOnqtm5
 xxoCzaKTXNOkx6JomeIohlt1OiExR+Q=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-chrtJA_LMhi6iQsEWl-xBA-1; Thu, 19 Mar 2026 08:22:18 -0400
X-MC-Unique: chrtJA_LMhi6iQsEWl-xBA-1
X-Mimecast-MFC-AGG-ID: chrtJA_LMhi6iQsEWl-xBA_1773922937
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so865228a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773922937; x=1774527737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
 b=JrX0EYK7NOrOV5YuRC7B8Xv5TV9AUgVtfwx7W7/YfhjaWKR+DCVvEJ5NkTrV/IEZj3
 8VMvrYC1lFco49diOlRyrllxiFqPr7lhvyIw97Be9PRuez1HGAbhBiul5mC6mO+os+KB
 IVKRef0kugXKZUL3hmiMUHaL+Qj/cV6qJAiSc4bJXWUnNcd8LnPCHrUz3zkSkPKJ15+m
 ibWTyeDBmXE52/0STDLy14z5qh6M8ADnjO+b+Ql/3oDzDSHVHjFCdroCdpA/GYaZXD89
 4mhnRJU9wXeByYeGGw3IjXQMcOxSO8ytMjN8bdqxsAvRGbqE+lm6qjE7vuTSe8S1by7W
 GitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922937; x=1774527737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
 b=ai7DyIimdNyFHS6F1dey9YjZwZOgk3cKBCPXOOseH2XN0hH5vqbQLfWCTdb2+h3hNr
 YhOxa6Dwa/X/utGDJovx7NVLclbWqilNRVL0kPjMJwqN5LHHtDTMcXG68NBHqlFnAVqX
 zs2+3VUu5aVpfbpv7YHIJj1+9HOMt13Ji6K0XD4xpypai5B8KXXlNSLlpgr0o+eLlOw3
 hbQY+L1Zbt2z117aLeLDYpJrG+9uN+AK+CDM4HNBkPsFQ74khRJU6CcJKm6I2JDYv9y3
 Tr36BI2ogjbWrzQd9OqPDUNnljbC7wKe5bMvJdslvdlbjCnYhTDvZq7rp3QUHhT2rXkK
 pYow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI6xk6qG7dXC6xv+EAfrzxUch6k9t9hpaj9oVaM5OGZ1pgHa+6AOpTwjhOAdXuUp1sgxpYySbJUTx5@nongnu.org
X-Gm-Message-State: AOJu0YxSj5WwS8T2DJRp6lkZ5cu8ltfEZhMlcOVBg1gGlYGH66yR0dk7
 2fxVfqV/eMYDTDaa7W5irgJjzmcyfuQigJejaKIt3R2Ih3r0LFXOdGLHcbTkkcyLOelXxQ+Ks/v
 gvq3s4Vbmt9jiYt3gsYMZVLmnAPs+qWHZN5uEF2Kbnz0Sepkdbr517VEf
X-Gm-Gg: ATEYQzwGOUabuUhipW67QO1maUeVHlRWyIRHzuS7FrfCM5tOIdgavqFL+TP+BUcZnXr
 RcTaCsfVp0O8cRqVLfBpV9udle5wP3sMTE6Sk8kTkPBETG3zLPzBd8IEFBw029IQlLlZBIdTaaT
 urMG2+tBKb6pm8T5QwkJA6E+CQTD3fE2K0a3JXG648oFQuVdYlQSaUoE25ZNwng2YZZIiPL0vCM
 7qn8sLKOxcx/wvvP6QUyX5uwGel8v5nLVwEtE24HftwRa95XsUC/V/zzVpt2pHeYFCCgIoUhkdT
 ylCE8FwDeu7Kc+jl63pfd5JQc8MHMsonpJ4q+Ikve38Ta5uP625C2ExmVjHqxJvZVdWBY5eR1od
 oZ/19x2iaLGibY7hdcs6PUPfnEIAo4HxK4/+mJc/SgHWuPf2kWG1LZng=
X-Received: by 2002:a05:6a21:4781:b0:39b:7f5f:d58e with SMTP id
 adf61e73a8af0-39b99fd74d8mr6939175637.47.1773922936871; 
 Thu, 19 Mar 2026 05:22:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:4781:b0:39b:7f5f:d58e with SMTP id
 adf61e73a8af0-39b99fd74d8mr6939157637.47.1773922936357; 
 Thu, 19 Mar 2026 05:22:16 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbe1ffbsm7876649b3a.43.2026.03.19.05.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 05:22:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, philmd@linaro.org,
 Michale Tokarev <mjt@tls.msk.ru>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH for-11.0 v2 2/2] i386/hyperv: add stubs for synic enablement
Date: Thu, 19 Mar 2026 17:51:36 +0530
Message-ID: <20260319122137.142178-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260319122137.142178-1-anisinha@redhat.com>
References: <20260319122137.142178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Add a new call hyperv_enable_synic() that can be called whether or not
CONFIG_HYPERV is enabled. This way genetic code in i396/kvm.c can call this
function to enable synic for hyperv. For non-hyperv cases, the stub will
be a noop.

Reported-by: Michale Tokarev <mjt@tls.msk.ru>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/hyperv-stub.c |  5 +++++
 target/i386/kvm/hyperv.c      |  9 +++++++++
 target/i386/kvm/hyperv.h      |  1 +
 target/i386/kvm/kvm.c         | 12 +++++-------
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
index 5836f53c23..767a4c7e1a 100644
--- a/target/i386/kvm/hyperv-stub.c
+++ b/target/i386/kvm/hyperv-stub.c
@@ -61,3 +61,8 @@ uint64_t hyperv_syndbg_query_options(void)
 {
     return 0;
 }
+
+int hyperv_enable_synic(X86CPU *cpu)
+{
+    return 0;
+}
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index f7a81bd270..bd3c26d02b 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -24,6 +24,15 @@ int hyperv_x86_synic_add(X86CPU *cpu)
     return 0;
 }
 
+int hyperv_enable_synic(X86CPU *cpu)
+{
+    int ret = 0;
+    if (!hyperv_is_synic_enabled()) {
+        ret = hyperv_x86_synic_add(cpu);
+    }
+    return ret;
+}
+
 /*
  * All devices possibly using SynIC have to be reset before calling this to let
  * them remove their SINT routes first.
diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
index e45a4512fe..a393a5d428 100644
--- a/target/i386/kvm/hyperv.h
+++ b/target/i386/kvm/hyperv.h
@@ -23,6 +23,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 #endif
 
 int hyperv_x86_synic_add(X86CPU *cpu);
+int hyperv_enable_synic(X86CPU *cpu);
 void hyperv_x86_synic_reset(X86CPU *cpu);
 void hyperv_x86_synic_update(X86CPU *cpu);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a29f757c16..9e352882c8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1754,13 +1754,11 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!hyperv_is_synic_enabled()) {
-            ret = hyperv_x86_synic_add(cpu);
-            if (ret < 0) {
-                error_report("failed to create HyperV SynIC: %s",
-                             strerror(-ret));
-                return ret;
-            }
+        ret = hyperv_enable_synic(cpu);
+        if (ret < 0) {
+            error_report("failed to create HyperV SynIC: %s",
+                         strerror(-ret));
+            return ret;
         }
     }
 
-- 
2.42.0


