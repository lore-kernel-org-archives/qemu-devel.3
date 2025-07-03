Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036CDC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHjz-0006uH-Jh; Thu, 03 Jul 2025 07:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgz-0000bo-KD
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHgx-00044G-Mm
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:01:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso8482255e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540482; x=1752145282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzJU9cMvdw7qI1DsUYXk4sIGt7aNTKeIdxs9XPIRBAs=;
 b=xXLFjQy8cg/s2I+sZ0BVoHM9G2SuKtVFkN9X+1VBlvcVkK34qId/IEs9KBeOntZcjz
 Ugqt6MmPXugBmK2Ak1YOWDYJaePlyQos3sfHy+AuWU+1gOJa0Oxq7XWGmnH4y7Vsn1tq
 N0+H6KtS9WkmHyJrzbe21QN+YNCCot6VHt6SL8fzJnOdFQqgZ5Myp4r0Ptvo5hu9DiDT
 ek6uwZf2a7wrvBFufs3t4eEJcMIcIf9FkbbZF5YMlUC17jtcyejjwIZEvO1honCVW/ZO
 k9HqN+jkE7HtE34cI9PfOY/wp0zjPGfTiETgYbmwtvrqBuMtfTF3iZSGkqtPX7OwmxIq
 /joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540482; x=1752145282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzJU9cMvdw7qI1DsUYXk4sIGt7aNTKeIdxs9XPIRBAs=;
 b=smojLsWo4TXJzjf4/b2/E8kcTDt3lU+1KucwBQVfDHMzBGn+jP4YXO5apLabT0alZo
 sybuTZt4v9Zuhc4EiXUnG/XgvdMo1dI7jg6EL3l4CL9QFH96ZZrrEiwcRdOiIeIBFKhB
 1BoYRZ27dVBu4SXJ1PP80f1j19DpEMVol058K6IVhXxLW7eB8t+nl2WPH5Jru9BhHSJa
 DX5Mo1sW4CU/smuL9dCFvNN1CaebWlP0grRRRKoRWIJOeV/R/NrTy0ygblMPZ9UGZa+8
 8GQF8UVOvHZO6j6Nppe+XaZYMB62sAEIBrzTuY6NHRDLaocjz3VILyQyWJ52qfkud1Su
 jtOQ==
X-Gm-Message-State: AOJu0YxFS4NjCizCvVmqKgAPLpyPnK0zwf0rdWeTSmTVWf/yKL0bYzjT
 RYuPf+wB8UWu/iqZ4J7hxRlyBosESrn7/a9UbIQxYouRrJyBSX9tWZmj2JWxeQF3jSbLHx/oxLz
 Lm0Vn8LM=
X-Gm-Gg: ASbGnctQM+MwglBXwLStWHD1VwG5vJxOnteIDONcv0H997IHaEhugzUi6vD8CasSrFt
 E/du4LuOAilvu/K5DK2cPXehCXoiwDVFt1XHb8lJw4CSFZmqEa1wcr8bRAViB0tme2pai45QdKY
 skhX2ysSKKM2lLbuWixQf2sGNevWecqKvsKjYnkL+7QxSrWQk9ZxDwRI+ZrKPxN4JwJXVswwo8y
 2KuMGHl4k06p1Mh/ykVdncHTgbhJWiW+E4OMfgvWTY2aWdO5bue6ZUEUxMBAzbhuNjIEwsr70NC
 xnPNrb2qQw6zFYuaeLj4u/3Ig/l5hOMBFXwv6Srpe+qpaicG9Kwb5Mrp9IPWVasL0PV6hxhaTNw
 8KypDTDUcrEE=
X-Google-Smtp-Source: AGHT+IE9gr9T60NDzRkUuqivylovRxkkmt/fAWeG25n0gokPfhcpDnEXTvr0sTrW5HUyGajZcY1CBA==
X-Received: by 2002:a05:600c:4f84:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-454a3e1a96amr69146295e9.13.1751540481514; 
 Thu, 03 Jul 2025 04:01:21 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e72c1sm18152198f8f.1.2025.07.03.04.01.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 04:01:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, xen-devel@lists.xenproject.org
Subject: [PATCH v5 64/69] accel: Always register
 AccelOpsClass::get_virtual_clock() handler
Date: Thu,  3 Jul 2025 12:55:30 +0200
Message-ID: <20250703105540.67664-65-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Register the default cpu_get_clock() for each accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


