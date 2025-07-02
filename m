Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C31C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2hZ-0008Nm-IN; Wed, 02 Jul 2025 15:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2h4-00078u-5C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2gx-0003W0-DZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:29 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso3896782f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482821; x=1752087621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tpiuwut0yPfLD1eGlX+EYtVIl2/TnFL9WqDtVZoJUMA=;
 b=gY3DNntqlzHaLuzLJXQDYpLh+WEG6T4KXBUu2xiszkpQXj0QwF9Pncr/rf2sVR+qUF
 wbfg5lRPa8m+QqFOXu1gzqxQx4m+SskWixuQk10cJzEtfhYJYyzQTgDIgyXISlViFuOX
 RwZA1pTPRo3e3R0L54Q0NYmZZ0RmtZ7raFDOj2KQrl1tyDWumsJBhWYbYlcuTYdMa7O/
 gZX6y7JqDuIQmo6rlj7roC7rUUWsyfeXSVotHQWG1fdfvSe8M6vj0IzTt/UjW4pcgiPX
 8LLsKRKEYEK1Sq7U/k6D7cNi//NLhLc9Egx25TWCHgmEO/zuE0KbC672EdLLh1Q6cT+f
 5yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482821; x=1752087621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tpiuwut0yPfLD1eGlX+EYtVIl2/TnFL9WqDtVZoJUMA=;
 b=obHhgHeUq+Dr8MH2zkOajvns0GwHtJ3UV69kpW9fBjLVVLz8reOIiKJi2xlfDpAvW3
 /QgRG0Y63eu3aEnnz+vRvXi/GSwNmyhTPFwAJ0jK3+jrAzwkpTvBp9Th3h2P4HmgTo59
 s/5xVSPjJGfEF//t21A4oCOpRUNogmP4mb06/0/1IPunkW3KDfzgW22fJ5Ut75atHwi0
 t47uuNmZeRSVdmrhn7EIn7yYrpWa3lDr/p06uXefGSCAsxuwY+dFjpCLs31YSjY38o7s
 V13HKq4He8SKimgHCYVpqTX6tA97iaqjotXQ43esUK7r9oL5wCVerbs7GhUbAPxA1b76
 lPjg==
X-Gm-Message-State: AOJu0YzZbfN2iojbjHOVs84Q1nQxfjwNpvGICpqO24OrWeubX+B/Qr/4
 kJ9Rl4LfhsHdBoxTPQ8ki962I81mBEpcBMsmCTiLCEQGnz9EZOqyoAPRMeTNtcgxCva76r8IHe9
 Q/Hsz
X-Gm-Gg: ASbGnctbZfZKVTqyyqCGpRAt9DspN1muYgBkmF37iym7BvHA1WBjanBx0dd9/QGFys+
 XRhPLgcaSk4MWCSbahcrj5o33SaYh2xjmJ0fj/4x1LesAcGKb+R9R4pZN1kREK8Ibs1SUucdC6G
 jUcpk4PSIo7Hfs+NLL1RTsGWb2JrVv6rpm/Jka1GkdvkvXkv+T2xGp6+sQMtzVBkO/Q3S8YPRfH
 2dwAzUZ7p9vBk5Iscgjo6DhducHPkC1yRYq0ZZIDEMQTgtzOTjIg+wuFK0GWNi7eXGTn/2ksSrd
 nsX72x1SYcnZlYGln8TPQeF3n3geMeTCd1B1B5jtyx0/DLxn+fP/uaOBT2uWxYZT57eG+Y30qgq
 ArqxWrsgWZvNGa3bFXQq3X9lktsubS1c+p6GN
X-Google-Smtp-Source: AGHT+IF4lYebmXSJDkkpbBSrLVcnunRXwUEzJB3h3bw75jfnHK3g6xjQIPKWwyLiIUvuXZNP2uw57w==
X-Received: by 2002:a05:6000:1886:b0:3a5:8600:7cff with SMTP id
 ffacd0b85a97d-3b1fd74c4b7mr3684763f8f.1.1751482820568; 
 Wed, 02 Jul 2025 12:00:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e61f48sm16952111f8f.93.2025.07.02.12.00.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v4 59/65] accel: Always register
 AccelOpsClass::get_virtual_clock() handler
Date: Wed,  2 Jul 2025 20:53:21 +0200
Message-ID: <20250702185332.43650-60-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In order to dispatch over AccelOpsClass::get_virtual_clock(),
we need it always defined, not calling a hidden handler under
the hood. Make AccelOpsClass::get_virtual_clock() mandatory.
Register the default cpus_kick_thread() for each accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h        | 2 ++
 accel/hvf/hvf-accel-ops.c         | 1 +
 accel/kvm/kvm-accel-ops.c         | 1 +
 accel/tcg/tcg-accel-ops.c         | 2 ++
 accel/xen/xen-all.c               | 1 +
 system/cpus.c                     | 7 ++++---
 target/i386/nvmm/nvmm-accel-ops.c | 1 +
 target/i386/whpx/whpx-accel-ops.c | 1 +
 8 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 8683cd37716..d5154acc75a 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -82,6 +82,8 @@ struct AccelOpsClass {
      * fetch time. The set function is needed if the accelerator wants
      * to track the changes to time as the timer is warped through
      * various timer events.
+     *
+     * get_virtual_clock() is mandatory.
      */
     int64_t (*get_virtual_clock)(void);
     void (*set_virtual_clock)(int64_t time);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 17776e700eb..cf623a1ea47 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -369,6 +369,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->update_guest_debug = hvf_update_guest_debug;
 
     ops->get_elapsed_ticks = cpu_get_ticks;
+    ops->get_virtual_clock = cpu_get_clock;
     ops->get_vcpu_stats = hvf_get_vcpu_stats;
 };
 
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index f27228d4cd9..dde498e0626 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -97,6 +97,7 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 #endif
 
     ops->get_elapsed_ticks = cpu_get_ticks;
+    ops->get_virtual_clock = cpu_get_clock;
 }
 
 static const TypeInfo kvm_accel_ops_type = {
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index f22f5d73abe..780e9debbc4 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -207,6 +207,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
         ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
         ops->get_elapsed_ticks = cpu_get_ticks;
+        ops->get_virtual_clock = cpu_get_clock;
     } else {
         ops->create_vcpu_thread = rr_start_vcpu_thread;
         ops->kick_vcpu_thread = rr_kick_vcpu_thread;
@@ -217,6 +218,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
             ops->get_elapsed_ticks = icount_get;
         } else {
             ops->handle_interrupt = tcg_handle_interrupt;
+            ops->get_virtual_clock = cpu_get_clock;
             ops->get_elapsed_ticks = cpu_get_ticks;
         }
     }
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 48d458bc4c7..85fb9d1606c 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -158,6 +158,7 @@ static void xen_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = cpus_kick_thread;
     ops->handle_interrupt = generic_handle_interrupt;
     ops->get_elapsed_ticks = cpu_get_ticks;
+    ops->get_virtual_clock = cpu_get_clock;
 }
 
 static const TypeInfo xen_accel_ops_type = {
diff --git a/system/cpus.c b/system/cpus.c
index d32b89ecf7b..6c99756346a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -216,10 +216,10 @@ int64_t cpus_get_virtual_clock(void)
      *
      * XXX
      */
-    if (cpus_accel && cpus_accel->get_virtual_clock) {
-        return cpus_accel->get_virtual_clock();
+    if (!cpus_accel) {
+        return cpu_get_clock();
     }
-    return cpu_get_clock();
+    return cpus_accel->get_virtual_clock();
 }
 
 /*
@@ -666,6 +666,7 @@ void cpus_register_accel(const AccelOpsClass *ops)
     assert(ops->kick_vcpu_thread);
     assert(ops->handle_interrupt);
     assert(ops->get_elapsed_ticks);
+    assert(ops->get_virtual_clock);
     cpus_accel = ops;
 }
 
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 4deff57471c..a2e84cb087a 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -86,6 +86,7 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = nvmm_cpu_synchronize_pre_loadvm;
 
     ops->get_elapsed_ticks = cpu_get_ticks;
+    ops->get_virtual_clock = cpu_get_clock;
 }
 
 static const TypeInfo nvmm_accel_ops_type = {
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index f47033a502c..d27e89dd9c5 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -89,6 +89,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm;
 
     ops->get_elapsed_ticks = cpu_get_ticks;
+    ops->get_virtual_clock = cpu_get_clock;
 }
 
 static const TypeInfo whpx_accel_ops_type = {
-- 
2.49.0


