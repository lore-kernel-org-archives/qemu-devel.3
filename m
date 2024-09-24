Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFFBCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4ty-0003Jh-MN; Tue, 24 Sep 2024 08:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4tx-0003EM-20
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:21 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4tv-0005sh-By
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:20 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-502c8f50c5dso1498379e0c.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727181858; x=1727786658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZnjQxTMhjoEY0Z6cRJChvJCZU9mx95m8bwJRe3bcaw=;
 b=d613en6drmUlETcKBZH2Bn/wlcIUO7wgRefGJWcRCiEJ50wiCUwyEzrya64leQqz7c
 uNaAjKaRo8ajLf6aPNJKGJNollXqDEOm8XKWdcbrwZ+44xa3w5l4CNjinO2OVuyjqEmy
 KmcDcObHOsDLwe0pcrggE8GKa0YkohXKHycFS/VSbem+sphxOjyfzkhQeOk5eqFfYoR+
 aQB1iP6ZsePTCJPgt7tGq33j8pKFN+Om9DgFh+wVrlgC5eMervmLScdQUQDk7yOMmUCp
 4xQSt3rzYqw5IRXOLAukaMXIyoGARlfSj9yqIP9SNckRIMieNRBLWnXIxXSi+KIGtA04
 4V2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727181858; x=1727786658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ZnjQxTMhjoEY0Z6cRJChvJCZU9mx95m8bwJRe3bcaw=;
 b=jUvmCoGC10XxEtBAZLi4+5qzxkz214HwEPDXn+Jsb8rkvBDwTS8BrDCeFgELA0LNgo
 b+KVYH4bZwJrLIDMBcChg49To8aoVrIyY9PTdAbg3DbotA/oxaO3k53IbVyghuPxaQvF
 tzsFLqDnW8fdYceGtsWMnpBK6AqlpdCFAPrmNKGewu+Qo2ukOIcudmAZTY0SLwYrok6q
 CA5I9LpqEPmYuttebCQ7+DQvKlh1fTFNQZ7r3RRF5vnNSaebEHq1rZfgwkq4ohD6SzWD
 7y0QYoUf/VbCYDgf+R11sRuG4xzFKKlsfGMsqT0LI+No5YSyu5ldQo8c4aBkalkw6uJ/
 6h+Q==
X-Gm-Message-State: AOJu0Yxj1wtgBl4XrKitzxAiCMgIr3GSZeY5iCvEUwsRaTqpilfjnjCE
 VtyBLuyi4t9Vzvh/8Y9oYV9+4dJYw5rOEsalvueYCvGVs2Cj8jGJMDC5AXq0NVvDP16XRa98I0F
 7
X-Google-Smtp-Source: AGHT+IHG5jeRz54hOcUW+zhSXcsCGwMuwqIxtZolEqAZoN93XKg17gUk2dqeUrsvlSpMBihoP0DSUA==
X-Received: by 2002:a05:6122:2020:b0:4ed:12b:ec99 with SMTP id
 71dfb90a1353d-503e4076f7cmr8912241e0c.3.1727181857901; 
 Tue, 24 Sep 2024 05:44:17 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-505aa10a8fbsm767830e0c.49.2024.09.24.05.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 05:44:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/4] target/riscv/kvm: set 'aia_mode' to default in error path
Date: Tue, 24 Sep 2024 09:44:04 -0300
Message-ID: <20240924124407.766495-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924124407.766495-1-dbarboza@ventanamicro.com>
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When failing to set the selected AIA mode, 'aia_mode' is left untouched.
This means that 'aia_mode' will not reflect the actual AIA mode,
retrieved in 'default_aia_mode',

This is benign for now, but it will impact QMP query commands that will
expose the 'aia_mode' value, retrieving the wrong value.

Set 'aia_mode' to 'default_aia_mode' if we fail to change the AIA mode
in KVM.

While we're at it, rework the log/warning messages to be a bit less
verbose. Instead of:

KVM AIA: default mode is emul
qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode

We can use a single warning message:

qemu-system-riscv64: warning: KVM AIA: failed to set KVM AIA mode 'auto', using default host mode 'emul'

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 341af901c5..970a7ab2f1 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1711,18 +1711,26 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         error_report("KVM AIA: failed to get current KVM AIA mode");
         exit(1);
     }
-    qemu_log("KVM AIA: default mode is %s\n",
-             kvm_aia_mode_str(default_aia_mode));
 
-    if (default_aia_mode != aia_mode) {
+    if (default_aia_mode == aia_mode) {
+        qemu_log("KVM AIA: using default host mode '%s'\n",
+                  kvm_aia_mode_str(default_aia_mode));
+    } else {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_MODE,
                                 &aia_mode, true, NULL);
-        if (ret < 0)
-            warn_report("KVM AIA: failed to set KVM AIA mode");
-        else
-            qemu_log("KVM AIA: set current mode to %s\n",
+        if (ret < 0) {
+            warn_report("KVM AIA: failed to set KVM AIA mode '%s', using "
+                        "default host mode '%s'",
+                        kvm_aia_mode_str(aia_mode),
+                        kvm_aia_mode_str(default_aia_mode));
+
+            /* failed to change AIA mode, use default */
+            aia_mode = default_aia_mode;
+        } else {
+            qemu_log("KVM AIA: setting current mode to %s\n",
                      kvm_aia_mode_str(aia_mode));
+        }
     }
 
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
-- 
2.45.2


