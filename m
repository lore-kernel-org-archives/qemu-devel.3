Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E4AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXTL-0002xq-UV; Thu, 18 Apr 2024 15:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQd-0002P8-BQ
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:16 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQa-0007jF-2K
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-347c197a464so864178f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468488; x=1714073288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hca3+XmwqR0YOlaHOdTYyVt5U6rBmejaVD76pmxE3UI=;
 b=U+62dtAQYNMKJwbQefk4ISLFHpeNHmL1Te0MJWqzNfXZEF0rTZHRzYuPj4YhZEHMMa
 r0LuvJ0KYTUbsg6ovg9wb8qdJ4JRL62m+Y21kPaBtLg5E1tG0QaudMbBexhkUhFJMW8a
 n+bF6a7xxTugAFPyioN/F9lsTWTaOFRjJIjL8Ju5QXrUUNBFx8/M/8/XjuxPGsaTy+xZ
 ER4F347ydE9OkgffZftt89c1OlMk9AhciLYP2KZpQR4d+612P3fAT4q28crMCMqLFYVT
 39t9YLO1cQC+Qr9VqK6WvV94Bi3u1AYIK2jlJ+FjE/9V4RsPJHLbcqBQwaxq8UGqq/zb
 vlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468488; x=1714073288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hca3+XmwqR0YOlaHOdTYyVt5U6rBmejaVD76pmxE3UI=;
 b=frGCHFT6kJy5T/iqanE1P6BJP82dYSZ6wt9vb4htBObApddYBygIR/8iuWxpQRK8Bw
 TtqYKDkuFI05KgGP/iqeo9zMh2DXYI0T0ocG6lw6t7jf0iJF1k+X0ZesVCPgkuptHpRL
 ak8iSWnmPoQC9hMhXVQso5ETMVud9vESxxfmKUHPFdcPEoe8Zxk399r2HRC2BO5TJ0Qq
 1Gj2xv12leMvW/2d8O77M9UlI3LfX3Yw11Yxv4nBHcXQoL+4uLDhzyQ2R6wnH8Acz34g
 F8eL5rTWqkUUejytRuUEeE7Z9NBDqvjTnLTUbHcyfbPWXvR7tAEAXQ4qfSQFCzxQUc9x
 NwbA==
X-Gm-Message-State: AOJu0Yz7DfQnSxYAO50+CvFVbPlOMtvVXmDMRqwe7/oq+A4EY07X0FIE
 TMtd69pAZWhnG7IOsDFpBhfKp0Pz01cVabIADJSARp/7JH/IASGDaVa8gn1S3ya+zC+NlX9myLJ
 X
X-Google-Smtp-Source: AGHT+IFY7dL6kQPENW/Gj6CBDv/d1qDFxnP7kZvuVmZ8Q0jxIs8r9dKZcEdctT8ubfxSRPUALhnlPg==
X-Received: by 2002:adf:e40e:0:b0:34a:3eec:c379 with SMTP id
 g14-20020adfe40e000000b0034a3eecc379mr650087wrm.67.1713468488275; 
 Thu, 18 Apr 2024 12:28:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170906138500b00a5531e61002sm1247131ejc.206.2024.04.18.12.28.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:28:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 21/24] plugins: Un-inline qemu_plugin_disable_mem_helpers()
Date: Thu, 18 Apr 2024 21:25:20 +0200
Message-ID: <20240418192525.97451-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

"qemu/plugin.h" only include the huge "hw/core/cpu.h"
because qemu_plugin_disable_mem_helpers() accesses
CPUState::plugin_mem_cbs. In order to avoid including
it, un-inline qemu_plugin_disable_mem_helpers().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/plugin.h | 6 +-----
 plugins/core.c        | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 41db748eda..28467c4a28 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -15,7 +15,6 @@
 #include "qemu/plugin-event.h"
 #include "qemu/bitmap.h"
 #include "exec/memopidx.h"
-#include "hw/core/cpu.h"
 
 /*
  * Option parsing/processing.
@@ -227,10 +226,7 @@ void qemu_plugin_atexit_cb(void);
 
 void qemu_plugin_add_dyn_cb_arr(GArray *arr);
 
-static inline void qemu_plugin_disable_mem_helpers(CPUState *cpu)
-{
-    cpu->plugin_mem_cbs = NULL;
-}
+void qemu_plugin_disable_mem_helpers(CPUState *cpu);
 
 /**
  * qemu_plugin_user_exit(): clean-up callbacks before calling exit callbacks
diff --git a/plugins/core.c b/plugins/core.c
index 11ca20e626..b25092abb5 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -493,6 +493,11 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     }
 }
 
+void qemu_plugin_disable_mem_helpers(CPUState *cpu)
+{
+    cpu->plugin_mem_cbs = NULL;
+}
+
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              MemOpIdx oi, enum qemu_plugin_mem_rw rw)
 {
-- 
2.41.0


