Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DB4C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2p8-00058e-Rt; Thu, 24 Jul 2025 16:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p5-00055e-IA
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:51 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p2-0007Mk-3L
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:51 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af51596da56so1275694a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753389939; x=1753994739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTTq9wgcgDFhDutfJJC82sCVw2rH7HCJB+ChDzBs1bA=;
 b=Pzk9xKTSClPB5ZsDemF5998jIZVPDoZfQxE1n4dRLpjv1Xe1xw+KlZXiacwpKm5vnK
 3enwe3omtpS6E5O8uU1BHLV4YQ23rENVat1RaOeriu2nM4Lqrsa7Nqy4TnRRwLB84ojJ
 oMkHk8GBC3Kz9Y8r6irn08KW3gy2SyTnWpeg1VDqxlv3/W2ticajsLdQwUjEe7vllTju
 1MFp1jSfrN5NrOxMc2iKxOBbMK1JA7s39DGiRA+lJbuNidAwSy4/3/JeOzjxZKRWTZ73
 mLLGK+xCUnTCtOy37ZlFjaoiiml3d4Taxm6oMTi77qFjo5El6xre9IH56d8N9Qyocc4Q
 TxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753389939; x=1753994739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTTq9wgcgDFhDutfJJC82sCVw2rH7HCJB+ChDzBs1bA=;
 b=s9hFsc1voxT/NzBa2MjiJFE9Du1nB7uOdC0Ty+Y1mJHiLP6hLFe8S9mdgbyB0zA4xD
 a3GwcEPP56bBtnXoNPTCPCdugniz5F0IcGkgugGgLIeXrGrHvtX1lhX260Thf4NSsuCk
 Hsj9HGt2M32JjtFwF8tpc/RG7ijHvCsx3dEHEir8A0TVS+dP4C8160QF0fwa9k4gDw8F
 Ol5ExKgxzAdsvrNTJgI1jx8naENiRJzt4jairIKZcOApcLoBhzEaqSUSNObdtmWHwebT
 2Q/douUV1DdRDB7FmHiPH62JRyC14uGeiyBnz8TYYjjdbsBcjAvlXAXdVLBECGexLBe7
 DiPQ==
X-Gm-Message-State: AOJu0Yx/Gy+DV0CruOwySIu+7QkyRzc7X80azkbRB8cNW+PwwbDbEijV
 2dUJJE107GSv1DvExd9oTwE+hNbzYCt1gT8Z1fOKrUhY7CBHFXzYMVPa+g0Mbeasv4LxW/weJPG
 L7tEA
X-Gm-Gg: ASbGnct5JuKegKx1VWEn75dNVjwoSSvWJUkhk+oJsL35JHpibdqb2BVmuwfesSGGlab
 nJF8j5M24UNka1NVtt6TxFAz8Dat0PEFaT9miPY6eCXJ9X2+/SII7HNsHHxI0wDVP5UsmUp9ju/
 6aR2t68Qw4GZ6yljm731OEIiJWqTBuRL6UvuYXVNL9ilZMkEyhIvzWXlu5+tSqQhuk95GGCL6R8
 5Sg61R/aaAkhov4NxN/5sTc612Cm9SwYpDHxi1JQz6CZjCUgpFupPldIsZY1VyUAcXQv7JwEADL
 CAY2fWavtSnNr7YeTCmzfTrqjdJpUfoZmMHvPOvHOTwA4zTsmcM/RDJah3klDWcDGYLjEUdCe41
 +15ile2anLWOW6crRPoQnLw==
X-Google-Smtp-Source: AGHT+IFrvehQdGDp6Ce10p9Emd+/01d8hzFSDocTN91FBpFX2LIxQ5phLrKiYOHtXoELqCh9syO6UA==
X-Received: by 2002:a17:90b:35d1:b0:312:26d9:d5b4 with SMTP id
 98e67ed59e1d1-31e50818b0emr13395434a91.17.1753389938624; 
 Thu, 24 Jul 2025 13:45:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662f6be0sm2008849a91.35.2025.07.24.13.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 13:45:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 4/7] contrib/plugins/uftrace: add
 timestamp-based-on-real-time option
Date: Thu, 24 Jul 2025 13:45:23 -0700
Message-ID: <20250724204527.3175839-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

usage: timestamp-based-on-real-time=[on|off]

Instead of using number of instructions executed (which is per vcpu), we
use the wall time for timestamps. This is useful when tracing user mode
programs as well.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index bd4219db693..9211f273700 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -94,8 +94,28 @@ enum uftrace_record_type {
 static struct qemu_plugin_scoreboard *score;
 static uint64_t trace_sample;
 static bool trace_privilege_level;
+static bool timestamp_based_on_real_time;
 static CpuOps arch_ops;
 
+static uint64_t gettime_ns(void)
+{
+#ifdef _WIN32
+    /*
+     * On Windows, timespec_get is available only with UCRT, but not with
+     * MinGW64 environment. Simplify by using only gettimeofday on this
+     * platform.
+     */
+    struct timeval tv;
+    gettimeofday(&tv, NULL);
+    uint64_t now_ns = tv.tv_sec * 1000 * 1000 * 1000 + tv.tv_usec * 1000;
+#else
+    struct timespec ts;
+    timespec_get(&ts, TIME_UTC);
+    uint64_t now_ns = ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
+#endif
+    return now_ns;
+}
+
 static void uftrace_write_map(bool system_emulation)
 {
     const char *path = "./uftrace.data/sid-0.map";
@@ -454,6 +474,9 @@ static void cpu_set_new_sample(Cpu *cpu, uint64_t timestamp)
 
 static uint64_t cpu_get_timestamp(const Cpu *cpu)
 {
+    if (timestamp_based_on_real_time) {
+        return gettime_ns();
+    }
     return cpu->insn_count;
 }
 
@@ -866,6 +889,12 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "timestamp-based-on-real-time") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
+                                        &timestamp_based_on_real_time)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.47.2


