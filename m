Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6FDC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn0j-0000vW-Ga; Mon, 24 Mar 2025 14:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0h-0000uy-CF
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:58:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0e-0001NG-SG
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:58:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so36958385e9.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842731; x=1743447531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zf76aMsp0+6jr1JxvVNGTxTaiF5oL0/9z9OpNWiIMMw=;
 b=HClBqcV1MHHLmJHJ3zjh5i5/vsDeJ/qPEjSvqSBpJhKq/y9EUOsJTkp+S4BP33BS2F
 XSOcZSCTDQ1/MxyfawIFo61cvnultNQk0fTDtlqT/XYKfEfXQD1bI7OLFTTIJJ+93iec
 292YdWrIwXC3qVwUcqqRbML1kN/gdvVlFbG9fthiIx2b9jZ3SBaPYwRuVGeWO8twYiLP
 SLi3CeZ1WZC2ElVyxEmqvWKaLR7DM5YkY3YD2miMNNaK0Z1sxJ3MkNwU9lUep0tLxeN0
 //+DVxKLPM9ewTcKSVg+UtLl+9sc1v8d669/iz12aKTjhqdb6UTL2eTNmi9Dr8yE//Tr
 Q+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842731; x=1743447531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zf76aMsp0+6jr1JxvVNGTxTaiF5oL0/9z9OpNWiIMMw=;
 b=oiH8H3QH1kWequYWzfO4nh9HoWlMbhazOch8PN1AEne0pza9ZVwUyayS90hX38O4O9
 4vZUJbkYq4MjCf7A9MUs4p/xt7tLeDRok2TSqmXodV8IyNJE5NhyvGxryYp7wqkoemo7
 8ntnz9/1B3C4jVThn4ZkQtSkcQaPLvGKmgj807Bv1wFVvxa/+6brApTHB6aDqVPkhec6
 Sy9ob9izo68LEic8DZRhEvLG6gHTcMbNVK4sCPoYvNneQWrqFcHw4Fce/EgQJYQwICeg
 wd1IrzK3OCt0BIPz2uPqyjh09S8l2flyZeLx8PtIEZuja9wN0j5JH239tTYpMRAfYHwM
 CqaQ==
X-Gm-Message-State: AOJu0YyJF0w2FzuKedOPNrNhy+8nju6wW0NgsD/9+jEQGvpVMq69WCXI
 XJofoDTHriqJvvR9PJN7XQNrFtmyXNMcgCp+AMUpqdqv+6jQX+FNGE0oNybvyqDj+iMTFDgTiwf
 D
X-Gm-Gg: ASbGncsznBn8C+KLq/aNUESKk8fzq+rh3GirswspRh5U0YCZOBMDYefMTIS9Ocbhv1v
 eSV0cdfkzgH1v3VgUU2FLoMSw/AmSBr7q+olhA8VJ7ZLxkji7LSTiX4yyMOQmD2MVrm0y1QZ5zP
 EZ/ebBsbvowd+CkOqdGEEZRDRPL+13/m6ziAAdbDIZI1gaHOcXskmT7UlVdnxCjsK3vw+xaKT/5
 L/uxtOSjLjnX6FvaX2R/URYNt63BOMyt9qfoISy7GEFV5hwQXEdC9WPLh4zqU2Gir4YXD5/e/KQ
 oGTduzCstYq1XnwsCzvFLtiSCL96OTiin/UQQtE45FO+frsdcVid0p6zb3jN0m25p4AZ3YPLMHA
 4w/356fxuIF1nGose3Ckq+9fL
X-Google-Smtp-Source: AGHT+IFOicsgb0wuNYXRf5ldauB4oye4QvfRUDHqdeU7L0xTvxteDxyS5sgw8f+ozV2h1B2NFA1d3A==
X-Received: by 2002:a05:600c:42ca:b0:43c:f680:5c2e with SMTP id
 5b1f17b1804b1-43d491be155mr136243045e9.13.1742842731028; 
 Mon, 24 Mar 2025 11:58:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957d9sm11627959f8f.9.2025.03.24.11.58.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:58:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 2/7] target/i386: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:58:32 +0100
Message-ID: <20250324185837.46506-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Register x86_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 3 ---
 target/i386/cpu.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 76f24446a55..28011eff0a8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2367,7 +2367,6 @@ int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_gdb_init(CPUState *cs);
 
-void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
 #ifndef CONFIG_USER_ONLY
@@ -2561,8 +2560,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
 #endif
 
-#define cpu_list x86_cpu_list
-
 /* MMU modes definitions */
 #define MMU_KSMAP64_IDX    0
 #define MMU_KSMAP32_IDX    1
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba4..1f502587c96 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6305,7 +6305,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
 }
 
 /* list available CPU models and flags */
-void x86_cpu_list(void)
+static void x86_cpu_list(void)
 {
     int i, j;
     GSList *list;
@@ -8924,6 +8924,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->reset_dump_flags = CPU_DUMP_FPU | CPU_DUMP_CCOP;
 
     cc->class_by_name = x86_cpu_class_by_name;
+    cc->list_cpus = x86_cpu_list;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->mmu_index = x86_cpu_mmu_index;
     cc->dump_state = x86_cpu_dump_state;
-- 
2.47.1


