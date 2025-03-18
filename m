Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C27DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZL-0002fh-Ll; Tue, 18 Mar 2025 17:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY9-0001ME-Bi
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY7-0000qg-Jz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225b5448519so118460635ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333554; x=1742938354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ty/7yi7XDMuhRymJcueNnjTkMJ6TF1/wh379eWbHVlc=;
 b=j7S0ZtDYcxeAFgtUtx38K6142eQn0NQR2ZWl5PNIlkpUL3r2XULD3aaD1uvHHy+0AZ
 0ZFRvRe25kty4EusmG3/Jar5vqPVJm8YDB4d0dtrd+nSTUQ9bBpSgyPPMI350IjP6Mot
 Cg2cWgignWL290gqu1FppH6wLUfmHhTlg1kcUSbQmZfEXlOkrK3wFQ+GWD5aayoGALky
 Wj/2dt1Zmu+LuNtgXEM5RHummtOO0D/BADBbkxGR0pZafBuLk8wMbU8kfvutR0Ktdogu
 2307sEpV/61bguqBg4+u1DJCPkxUQvqbRKUKxaTRA3rdfW1GzX/wqjxi8frePBDbFxFk
 JonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333554; x=1742938354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ty/7yi7XDMuhRymJcueNnjTkMJ6TF1/wh379eWbHVlc=;
 b=cZV6dA5kKALZGlRW7OS/gPyLOW/V8VmxujWyF4vFb4hK1OEk5c3ukic56SNILuG+BQ
 Ya/lA75fbkwMj8omcxUfeh5wtVLlspJUmUBvFCfUpW5c7EmkI86UsjA0/CqHYMeaB3sY
 3uQFxi53BoG1OnDRbmPHMOrj1jkqMCO4YN1fG6EXwZpWrvmg8VFRIM79q1HDSmW04LYC
 YDdr2AEXZ3KTrWtFOUKuXvu1S8tIVdHiKztMbzdyo8eQ8wl0145oeNLXLzP2Gdw3csAA
 PDf1KilJq0cm4KsWNombDzciFVhdgvszS/BMIAyhYLDCtnIsxwdNiaE0BOemlRzCCF07
 lmEQ==
X-Gm-Message-State: AOJu0YyGWaooDqdj2O8h+iAkbaFE5JJObZsrMuZ5C8O3wtLK/ML2l7RV
 y+GAtXe199C/BnQwnXMwpfQ79yTGT8DGWPQyp8cZ3oDiIUMJbem55r5cSNjwgWvC8+qFSn2hFf1
 s
X-Gm-Gg: ASbGncuvO+eV+WPxjkgRIBjUfmb+CA+FxmYUsb6Zh9Gpyh3N8XJMxHmFEPxwmp+Hqjn
 vA9oPQsg+UCwRz93twcJTDEJWcZJTWDOU2x9mrTUfk1auC2tHeBK47kiH8+ts4oIiu9k0H56XSs
 uqFRjR+WHrK8AFJiZ5HpJLltKcOocgltp+pdaGiodtuox3DkVVM5xx0kYVuHfNGOkkD6rOz2Eaf
 heNGQEr5RuAqaTB4hhZvRcRb53usx/L3iwNsUEpOlOlwyx3OHzq41kaDia0mBeeWJm6mL/8I+at
 qcNodzsMzLK9LSkXeXpzugi9kQnYR6Zw/sT+vJRsGMYKrzbEVEpQIcrQUdwVWOT4Irb59H0wIR5
 ILteBC2WLb0w=
X-Google-Smtp-Source: AGHT+IFXJU/b16gn0YZ5CraD/IN3QOnnN5+/JWrCWIQ5c/ILnOV7EEke0GX7vV7ZSr394B2aDKj7iQ==
X-Received: by 2002:a17:90b:3e88:b0:2ff:4f04:4266 with SMTP id
 98e67ed59e1d1-301be201d87mr240404a91.23.1742333554351; 
 Tue, 18 Mar 2025 14:32:34 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 34/42] include/hw/core: Drop ifndef CONFIG_USER_ONLY from
 cpu.h
Date: Tue, 18 Mar 2025 14:31:59 -0700
Message-ID: <20250318213209.2579218-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We were hiding a number of declarations from user-only,
although it hurts nothing to allow them.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d1c1fefea3..1c63266f07 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -614,8 +614,6 @@ extern bool mttcg_enabled;
  */
 bool cpu_paging_enabled(const CPUState *cpu);
 
-#if !defined(CONFIG_USER_ONLY)
-
 /**
  * cpu_get_memory_mapping:
  * @cpu: The CPU whose memory mappings are to be obtained.
@@ -676,8 +674,6 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
 
-#endif /* !CONFIG_USER_ONLY */
-
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
@@ -701,7 +697,6 @@ enum CPUDumpFlags {
  */
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 
-#ifndef CONFIG_USER_ONLY
 /**
  * cpu_get_phys_page_attrs_debug:
  * @cpu: The CPU to obtain the physical page address for.
@@ -758,8 +753,6 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
  */
 bool cpu_has_work(CPUState *cpu);
 
-#endif /* CONFIG_USER_ONLY */
-
 /**
  * cpu_list_add:
  * @cpu: The CPU to be added to the list of CPUs.
@@ -1136,8 +1129,6 @@ const char *target_name(void);
 
 #ifdef COMPILING_PER_TARGET
 
-#ifndef CONFIG_USER_ONLY
-
 extern const VMStateDescription vmstate_cpu_common;
 
 #define VMSTATE_CPU() {                                                     \
@@ -1147,7 +1138,6 @@ extern const VMStateDescription vmstate_cpu_common;
     .flags = VMS_STRUCT,                                                    \
     .offset = 0,                                                            \
 }
-#endif /* !CONFIG_USER_ONLY */
 
 #endif /* COMPILING_PER_TARGET */
 
-- 
2.43.0


