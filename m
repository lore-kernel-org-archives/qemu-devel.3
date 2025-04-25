Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CD5C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3K-0002k3-5J; Fri, 25 Apr 2025 11:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L32-0002OI-Qs
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L30-0004Eb-Oe
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:04 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso1553749f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595180; x=1746199980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HzI8gGipoVaB4EVnZUPvSAO/vYv62G6fw3dAAJKjSvM=;
 b=W8g9+65DsXLVr2O7HZbxiAksre2ohk0VuF2R3X+LwpYmgNkhy+XoyxwVl2SuoNY40r
 mOIGY/T/Ex3wyrUIYeU8PNIM8NPsTWwHo/7MlOWmGZNHACkJsBtpTemlJewxsD2DPgJ8
 hKnfnWpbAudMf7micv6vi18ecvVzhGfO343WlCXW1QKwQJ1TudTxoi9ILzRX4Z+D2C9g
 M/o/XcXEd/+oVpPs+TQa14d93rM+0+rLHQcbhfyUdRK+cSH6KqtDdGPNYsyBM9pF0lNp
 uW4jcvEqZheAxIF6j8Bl1XOHgfHe3xPv8Wxygyaak7NpARi5TQy5meRtOQ4+ALZHJP2h
 Jr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595180; x=1746199980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HzI8gGipoVaB4EVnZUPvSAO/vYv62G6fw3dAAJKjSvM=;
 b=mwIZgD09X3niOewZR7Xk8hV5yL39Xmi/lPC3QowaX9kAT8yNvtrBBIMHaYWwungoH4
 QCSLUjZ2t6oIVS78KVsOIyzVP2AQZK65LaxDtcmuvUE5eiWAWgQXrA+Tm0dubpCwEefi
 WM6ceka5CZSYpmFwzaen/rAib1fwVnfwwItPRO7FgZwKWn/SCWvNe2J4jdey3H66S60p
 fhZ1d27Tk6FFLMQ7baAavTVJAqbW3EYiDpNnnkpe7xVWJj767DQdMiowzQJomQjHHb3H
 IEdpb9sjlzg5nzQhFlgaDFkmp70wPBrI/H1WHegHJONjKcPMMDQPdFIFUxKp7Cn4WsRc
 hx7A==
X-Gm-Message-State: AOJu0YxuD2VvqTXr0QSqmMePC9qFx+ImLEL3QRglqGzS9EE+hL5NrLB5
 vh/ZvhgnD/zKoAjXp5tTwGri6ZlrDPv8VHCg0bCbXxAUPH5FACKtoyEMQ7iWSjd1PbbEIdpWmb4
 5
X-Gm-Gg: ASbGncu81vfPOjHDij2NATyJ6a6xlFt0MWMMIEYZpmotTFjVSTbHcBXUaJ6fd2bruJd
 hoShxIM/gcAZZy+SNnFd7lioyi2VuseorpcXKh2ESXh39Gck2Ildu9sVPsw3xvz2OVznXdeGE4s
 G4e5/rqeU/iYktb7nDIdsd89Spw00BDTuCSKfMvyqya97uf4ItYovh3/vz4JBlVyWotlNhnwmAs
 DqsLm5yKXmmsuUtR+kCC9B3BFHH4KplbbWmVrJHWlklJGWEISV8KRFSzBsHQm5nIYjTrk6zexH8
 8N3fJmExtdk0D2lRDlgiyWjrFmLdO8UeQdxgp2eh78C3og5HJVk14livVRwKQYJ0YCcy4R7Ig63
 rbe4jrDS2kQ4c2rus+uS2zzzKKA==
X-Google-Smtp-Source: AGHT+IHpK54WLHi3opyzqgov9RjP6R3E1Ei3AE6BgML9vyhrpqpnsPNXDaRueN8GkZPJyFtRBTPhwA==
X-Received: by 2002:a05:6000:2211:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-3a074cdb972mr2462517f8f.1.1745595180483; 
 Fri, 25 Apr 2025 08:33:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca5debsm2715870f8f.38.2025.04.25.08.32.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:33:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 52/58] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
Date: Fri, 25 Apr 2025 17:28:36 +0200
Message-ID: <20250425152843.69638-53-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Replace the target-specific CPU_RESOLVING_TYPE definition
by a call to the target-agnostic target_cpu_type() runtime
helper.

Since the big "cpu.h" is not required anymore in tcg-all.c,
remove it, using the tinier "cpu-param.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250417165430.58213-3-philmd@linaro.org>
---
 accel/accel-target.c | 6 ++++--
 accel/tcg/tcg-all.c  | 5 +++--
 cpu-target.c         | 7 ++++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/accel/accel-target.c b/accel/accel-target.c
index 33a539b4cbb..08d4e450bde 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qemu/target-info.h"
 
 #include "cpu.h"
 #include "accel/accel-cpu-target.h"
@@ -88,17 +89,18 @@ static void accel_init_cpu_interfaces(AccelClass *ac)
     const char *ac_name; /* AccelClass name */
     char *acc_name;      /* AccelCPUClass name */
     ObjectClass *acc;    /* AccelCPUClass */
+    const char *cpu_resolving_type = target_cpu_type();
 
     ac_name = object_class_get_name(OBJECT_CLASS(ac));
     g_assert(ac_name != NULL);
 
-    acc_name = g_strdup_printf("%s-%s", ac_name, CPU_RESOLVING_TYPE);
+    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
     acc = object_class_by_name(acc_name);
     g_free(acc_name);
 
     if (acc) {
         object_class_foreach(accel_init_cpu_int_aux,
-                             CPU_RESOLVING_TYPE, false, acc);
+                             cpu_resolving_type, false, acc);
     }
 }
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 40d73649796..0ce34ac912c 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -35,6 +35,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #if defined(CONFIG_USER_ONLY)
 #include "hw/qdev-core.h"
 #else
@@ -43,7 +44,7 @@
 #endif
 #include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
-#include "cpu.h"
+#include "cpu-param.h"
 
 
 struct TCGState {
@@ -89,7 +90,7 @@ static int tcg_init_machine(MachineState *ms)
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
     bool mttcg_supported = cc->tcg_ops->mttcg_supported;
 
     switch (s->mttcg_enabled) {
diff --git a/cpu-target.c b/cpu-target.c
index d68cbab5da9..c2dd590d48a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target-info.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
@@ -37,7 +38,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 
 char *cpu_model_from_type(const char *typename)
 {
-    const char *suffix = "-" CPU_RESOLVING_TYPE;
+    g_autofree char *suffix = g_strdup_printf("-%s", target_cpu_type());
 
     if (!object_class_by_name(typename)) {
         return NULL;
@@ -63,7 +64,7 @@ const char *parse_cpu_option(const char *cpu_option)
         exit(1);
     }
 
-    oc = cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
+    oc = cpu_class_by_name(target_cpu_type(), model_pieces[0]);
     if (oc == NULL) {
         error_report("unable to find CPU model '%s'", model_pieces[0]);
         g_strfreev(model_pieces);
@@ -92,7 +93,7 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
 
 void list_cpus(void)
 {
-    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
 
     if (cc->list_cpus) {
         cc->list_cpus();
-- 
2.47.1


