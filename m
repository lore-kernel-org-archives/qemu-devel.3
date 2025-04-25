Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9F3C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzP-00008V-Ac; Fri, 25 Apr 2025 11:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzK-00007A-Ih
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzH-0003Wt-G8
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso19504445e9.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594949; x=1746199749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X8jl8hB9zMqvOgbv5oC21KdNuLlcY3iJS3hENETS5RE=;
 b=sxFnocQMQ1/0s22SBF3EmA1LaISrE2l4i9183L+zmn7UZca0svqY4bqaB/d7xM+Q0W
 6OLyxRtL6rcQ5SmKa34h3W8ABc3TLD6GqWbQz1tMe0mwoXri4b1TkL7d5x4m8nhvLYqG
 y2B671tIhqPqnHYMnfZ8N0GbCR+Kk7JbXjV7grT+JTh1aFBThULnFIbjCi6OkIaYiWJf
 fmJxcgnyhgJMyobphAchSak4uOzGocx7wVvcnOqYkmKXNi3/m/ABw1L8e+nACx8UifdZ
 6Qt24y+AcZKt9sYxqOWBmhcvpkDEbPRqAEAjaGo3ISOUuzO9FtdaP+Q5Ku+NYZcA6OXX
 Idxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594949; x=1746199749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8jl8hB9zMqvOgbv5oC21KdNuLlcY3iJS3hENETS5RE=;
 b=IFcwEuL57Vcn1NFxfn/5ruAZqOvUYgrEuhNFTrSH9q3UaDLXYI/wDhYJcVt44XsTU/
 gvNlutAT75iqvvNpjEfZrcGYuYzIMBSCaZF63gUOZRF/mXa5HYCD3q7WQy0eKqPJruCZ
 NQPdSht5ySksnk9SSttoGdKtekUUBDzL/OoRIi3gkUM/FxXHwd12gXtpDCOv/Xh7uPFf
 Kk75UVHxeccJrXprly66DfdqcsLwLRyw/Fdqw1L1WYXnfpqGLryz5HHLPANeTgSFWYQs
 4mopObOu+Cw6NNuUtqtk/fmeQWcXQ9cDJLa0F0+fpjxWSLovrieF5xEYCcm5HA6Umi7a
 CZrQ==
X-Gm-Message-State: AOJu0YxugyH8ckkeIjzsknapm7OrP0S6EPbrZDuiPOkd9WiOqUyTN7L3
 H/eLbewR5bnUm4JfFnYrg2rJP1VlyhYqJQ+CfU+rSPqg+YV2s9EnLWjtkUaziuuxXAsoZkaPm5f
 G
X-Gm-Gg: ASbGncsrHkejR8zNs3ZXuzOXuTxp1hr6vS1ult6hvBZdC4Wcurr1qvIygBqj9VTLI6x
 0tuWxyQQrLiK00TJ34sIRsrDdac34e5VKdWhC9oxb+cJ98qXcS6jJd+OaVm0/8pIsAn36veCVWz
 Y+UBGTamU51wkmmBqjWFnQ2003B1ZErfGAuMPk4oWYzdrmTNUXe4t+zo7pPnS2GKGMSkHhH9fKk
 EetVs7GcumaEzYncPKjmfFdYDBqfko9+iT391ifaPGmG9ZgFKqrr7ZdiaEM4xZAFCJxX8mDhav7
 g7op3HUetBotBIAelMT4LqvqNepq0zp8vm6/tdHCxegJTtNYfocp3k/5XoSPLo/CSsUqG3PzhkU
 dOptyv/FQOAszr5w=
X-Google-Smtp-Source: AGHT+IHOW9Vd4u/X9xRjc2m5GQCS/ApbZi6+31HM0P0Q3Dl6EJ/2wE53jMBwH2FAlmDH/WKnLa5/PA==
X-Received: by 2002:a05:6000:144f:b0:391:13d6:c9f0 with SMTP id
 ffacd0b85a97d-3a074f2ef6dmr2717698f8f.47.1745594949437; 
 Fri, 25 Apr 2025 08:29:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca42cdsm2628191f8f.22.2025.04.25.08.29.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/58] target/i386: Register CPUClass:list_cpus
Date: Fri, 25 Apr 2025 17:27:49 +0200
Message-ID: <20250425152843.69638-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Register x86_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250324185837.46506-3-philmd@linaro.org>
---
 target/i386/cpu.h | 3 ---
 target/i386/cpu.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9866595cd0e..54bf9639f19 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2365,7 +2365,6 @@ int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_gdb_init(CPUState *cs);
 
-void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
@@ -2559,8 +2558,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
 #endif
 
-#define cpu_list x86_cpu_list
-
 /* MMU modes definitions */
 #define MMU_KSMAP64_IDX    0
 #define MMU_KSMAP32_IDX    1
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1f970aa4daa..955295fe798 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6319,7 +6319,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 }
 
 /* list available CPU models and flags */
-void x86_cpu_list(void)
+static void x86_cpu_list(void)
 {
     int i, j;
     GSList *list;
@@ -8905,6 +8905,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
+    cc->list_cpus = x86_cpu_list;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->dump_state = x86_cpu_dump_state;
     cc->set_pc = x86_cpu_set_pc;
-- 
2.47.1


