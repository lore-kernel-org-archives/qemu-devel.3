Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7628DC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZVu-0004Z1-Gz; Wed, 12 Mar 2025 23:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVp-0004Y8-2z
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:37 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVh-0007a5-97
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:34 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so967871a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837528; x=1742442328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHsIgh54rCX5/hydGwZuN61eydlk+oWTosomBsdyD50=;
 b=qHXtAHrv/1o9DXbJx3G6CqXyhidymj20nh7B1eu5oxbGO0n6+LUpBhHu6biaPjKy//
 SOs/tumImdeHrr+wPpMK6SDZyYE0Xxf/NuESCNkeed1Ohakcex1zZHqRzjj7+Y1C35hL
 3FRpOEOOaxIFaX7gNJYPOidgT8Jy/hmQ1Jols0Tor/gPg2O2IndOTzTiBb2i9ZUO3Ybv
 iB00p4fAcd2onz4i5SZZWVKbvKxehz3yDCbbw3OEcf8P258VuTw+X5ky/LpF4kQweEc2
 1CWhahHukjL4HmB94DeJ+NmDlKsNvmeXAKkhTSopXFUAa9jhPjGSHdiDsJBlmMEVl8Bu
 Co9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837528; x=1742442328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHsIgh54rCX5/hydGwZuN61eydlk+oWTosomBsdyD50=;
 b=Pv+8gV1jC94NExl9VqXx7G4FugKkiIU2o/oAwQCYaIPREHbGCe0EfEtLDNkMJmt3GR
 p0B47le56Axf0TGaMq6eie9pYM8UbjB4WIOl3BSENdHWWcG5v13hKtJiys1GznrSJTpE
 OAAol+3G9PevRuvRe1oXXBl7wcnJk1NqrTZpAwWx6F5PuoO7nqn1+qPWxfb4qRF+GBoy
 xL30+LZP2eEFh2L9VZnC1VZcdb7QBx28sfHwVVwG7qwbimtHccXVSsUXjHVF0ZBL4t4A
 7xumo3o61MXhL5+MQmIlgldf4Hmg+thQFDIAkrKVohOXZ6DEwQVWVFykMyidDcNUnwwW
 7+4Q==
X-Gm-Message-State: AOJu0YwZY+tCWozMdvtBcNB1Os73gfcnXgLSyMWbaod3EARIXVBcwWmY
 XkdbbgAMp7tPNetZuOh99NGlPh2rzQ0KVciObepZirVRIqqYPjSjBVC6viPuFKoyYla2mhmZcFC
 n
X-Gm-Gg: ASbGncsTiJZQO30LLjXMYYJdfFkuCFfj7HRaAXSocwWcYs9QzsTUlRESh8WqxnZ9FAY
 tBtkquWw8KMrTYT62Pc7V5tiM5WJLMrbv32Mh2S82Rk1KMtFn5fKBU1Vy32Cuk5FkQTzSeFOiov
 7DsI3DNNTAws1iSv2XBBE4EdcGepb5FLaAhsjMgJ+j9DYArMnvWn+LVx+Qn/ak9Ss3wTbF9oIzO
 gJYtw2pV0zi5w8wxVB+rTOcd9ajYFymZWhxND7k5lccxrNJDzsFUaCiW0VFg5dlL/SQhJROwvU+
 Q1F09T5+RcCAPX5KY9C/XXsgKOKGrmJYWAV4wYoKHYSEYgr1QtaNs3PyqnxL2hCIINM9SNOZF3r
 a
X-Google-Smtp-Source: AGHT+IH7E8axiazUVf+6HTre592lFDR8WCTOzfAYscQzlK40/ChajYaxsoYLuD+inFQ0C4tkYPJbvQ==
X-Received: by 2002:a05:6a20:6f90:b0:1f1:432:f4a3 with SMTP id
 adf61e73a8af0-1f544b19bd8mr38915686637.23.1741837527740; 
 Wed, 12 Mar 2025 20:45:27 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 02/37] accel/tcg: Build plugin-gen.c once
Date: Wed, 12 Mar 2025 20:44:42 -0700
Message-ID: <20250313034524.3069690-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

We assert that env immediately follows CPUState in cpu-all.h.
Change the offsetof expressions to be based on CPUState instead
of ArchCPU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 13 +++++--------
 accel/tcg/meson.build  |  7 ++++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 7e5f040bf7..c1da753894 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -22,13 +22,12 @@
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
-#include "cpu.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-temp-internal.h"
-#include "tcg/tcg-op.h"
-#include "exec/exec-all.h"
+#include "tcg/tcg-op-common.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
+#include "exec/translation-block.h"
 
 enum plugin_gen_from {
     PLUGIN_GEN_FROM_TB,
@@ -89,15 +88,13 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-                   offsetof(CPUState, neg.plugin_mem_cbs) -
-                   offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.plugin_mem_cbs) - sizeof(CPUState));
 }
 
 static void gen_disable_mem_helper(void)
 {
     tcg_gen_st_ptr(tcg_constant_ptr(0), tcg_env,
-                   offsetof(CPUState, neg.plugin_mem_cbs) -
-                   offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.plugin_mem_cbs) - sizeof(CPUState));
 }
 
 static TCGv_i32 gen_cpu_index(void)
@@ -113,7 +110,7 @@ static TCGv_i32 gen_cpu_index(void)
     }
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+                   offsetof(CPUState, cpu_index) - sizeof(CPUState));
     return cpu_index;
 }
 
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 14bf797fda..185830d0f5 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -3,6 +3,10 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
 ))
+if get_option('plugins')
+  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
+endif
+
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
@@ -12,9 +16,6 @@ tcg_specific_ss.add(files(
   'translator.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-if get_option('plugins')
-  tcg_specific_ss.add(files('plugin-gen.c'))
-endif
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
-- 
2.43.0


