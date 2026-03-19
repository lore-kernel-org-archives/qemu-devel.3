Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB281075294
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3AM7-0001bb-I3; Thu, 19 Mar 2026 06:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3AM6-0001bB-2A
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3AM4-0007ba-MA
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 06:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773915112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
 b=ZBHKeiegwTQ0lPcWS1dHjjwoqvUY3bFYSoQ6uema7B+dtcEfAgw8CEhGpFYn6DEbwgSzFx
 8cQmc/WXWQTfkDua6MErtOowMNwV/CUaJzbyTxl9Zh7YTFdSXKTSj4iCf9ESrHgcu185iw
 Y/oJYri/BeF5u9Z5vazGUWnEGcJS0KE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-IRJvkzmJMwutjRshAtIpeA-1; Thu, 19 Mar 2026 06:11:50 -0400
X-MC-Unique: IRJvkzmJMwutjRshAtIpeA-1
X-Mimecast-MFC-AGG-ID: IRJvkzmJMwutjRshAtIpeA_1773915110
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82a73ec7290so746482b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773915109; x=1774519909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
 b=ERnuRCbaDn5Mg8NeuV1ChAkbTaM3fAk9HiMG07eFBp3f+nvKauqZz/OYxaMZcGMpaX
 NESFSiea8zqtzCP4NZpVqKqM9QSh891XKovON0MSu1y77gyRknAa9h/3aF6HJLehgpr+
 ZGVef2to24MMumAOhpXioMKGdf/s+cx8jk8xxLYS4fzWdM1J5AjUvG3evvcTaPK6doQ2
 cCx90SOTBTrQ282Cb3VfQ065p9YoBPaZ4euKP2FzQbNzeLZr4bor+aYjlF0WiOOnGFXP
 LWSBzOp3f/x/wtblflgkkGe6MGKH9Vx8nJ95RlmzMODG/GD26TCN4hSOpaHaNa0ndZYR
 6hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773915109; x=1774519909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
 b=n96XKTwUpXPsyHAEU8D8TdR5Fxd5l9sSV29lW6y5eNq7I5xeaF0FoOYwhybQJYr0jB
 M3K/Q8bDu971TtQatvgbhg3ptG9NiEmXV2UGY9Ina2WErRO3LaRD2u005SEHTs+2ooZV
 Uwc7wkHWLV7dqicUb+8kteLCsocudPFvCr40fbYon8avxdKG00yxHHb7hbXWqjiY8l+B
 eCx6Iuk6JBjB47IXBlaKRN95rGxUnKxDWYgLpJzOwRP63K7CUlJA9RU1q6ANxf58jGRV
 vzycgS8KkObxzufCwvF48k4kJZDYB6qhmder6IK/zrTA62MEs7RwkoEmZo1kvPvwSpIo
 CyDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6Zfgc8St7xT+hC+OwpwtEBaUBbDLTzWtCIEQXcQA24mOdwW3OxjyYGSQU2STy6UocX69egm69Eou+@nongnu.org
X-Gm-Message-State: AOJu0YyksfG3/DaSIL+o2W6nMYWsl4puF1LeRQjL7mk4/23boUC0V3af
 lxQv1XBjaaUDjrTPKZIH2jtuUzUWuEavBysX2kXNImGx+/f9ASdqRarIaweCRePOqTKttmBqAwh
 WLCYVK3CoN97TW7jMcPSptC1QKli7ZOkgaZSE6OpSNvWsfxoemVZPWSQu
X-Gm-Gg: ATEYQzzTmlKw5ACNi5k+wSnYQnHRQqTUyFttaUYRZ38TRzrHQcJhqy1VqlAPeI3xU9y
 rPJKBSANmNB+PPEvteI9/l7pcqA3gyylWp2FbEKOcYcGeWhm92CAd5PZNNcjpIVL1h85bvM6xj8
 y8srcKjyhJnZFQSfuL2qQddYaIhet7HXX0gdCZYc5CV/U5E7gUPJc0IWpriAgX/JBFf1+nJzNsZ
 O6mal0S+Knau48fkMP5ypZr/P1ZApmykNlWq5UFMi+xz5uVW0oFA1Ay71IEE3uH8SbHlfivYcjR
 TMwZtedkV3RnmDBvqZ6TH3GF8rnuIjV4xQQoqOPDFkZce90EnN+0nKLfmpXU4iunjseqzMySBTC
 5KrcPrBZPn5qKhlatS5MUHWKMNDK0wLHiIp0lPq3Fz7XAmOliGz9cneM=
X-Received: by 2002:a05:6a00:a85:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-82a6ac3a360mr6470390b3a.1.1773915109488; 
 Thu, 19 Mar 2026 03:11:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:a85:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-82a6ac3a360mr6470368b3a.1.1773915109099; 
 Thu, 19 Mar 2026 03:11:49 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbb2f34sm5594319b3a.30.2026.03.19.03.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 03:11:48 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, philmd@linaro.org,
 Michale Tokarev <mjt@tls.msk.ru>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH for-11.0 2/2] i386/hyperv: add stubs for synic enablement
Date: Thu, 19 Mar 2026 15:41:28 +0530
Message-ID: <20260319101128.116301-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260319101128.116301-1-anisinha@redhat.com>
References: <20260319101128.116301-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


