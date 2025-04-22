Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDFEC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JNU-0002HM-HH; Tue, 22 Apr 2025 15:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLb-0000Rj-NG
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:59 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLZ-0006cK-BK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:59 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22da3b26532so315025ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350316; x=1745955116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEj8DRwl0sBMiNx3GlTORUB7tXRrga1o2uCtdvfn7gU=;
 b=Yb/K2L0m1h9Z2tuhq+7CTFWq+CiIwf838nVo/LARGpP68hITBwX6LRauuN7iwU7T0A
 ququQLI11cT8Q/gA57IKvEPjKLhSQhJlf2T5/AeiRlKP13D6u9qwmP9d14slZmvuUcfM
 9DHIzgCFqQHuYO7gqbQOxx9aJym9FRg7aZR1vpSiTNU4Rxc6qY16HXIxpiVHyGEiyjci
 V0XSP7OeUnPxljy5NWjBaVpcRiY9RUkIUCQjIilgjEJkhjckmvEKM2k90swojdkVl6QU
 qSbf7swMRRDcRygZ58WLA3QGQUSmW+TY4a0+8mwFPyZ9sOJjWfdxzzkKkPl2oj2DI52q
 JLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350316; x=1745955116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEj8DRwl0sBMiNx3GlTORUB7tXRrga1o2uCtdvfn7gU=;
 b=dvdx9jm3Ben71NgpgX4iufNZGRJNxpeFKc2y9g1lG/UHzGTC/UDnHck2Nix9gMxoyy
 KgLjF4lQ2EIT7zAJG2wCgwg25tbppOB4a/TP8eMQMCxutts+xaFMx/vK2YcY395G5X13
 KIESTgZ5IuZS0Q856YCpb9GwcjYn1EU9xfM1eCLd1IsCd/eGz9aqMMjQm2+HTonCZ4r0
 +Z2L0GvOReq7YdCKnE/if7KkmalhiQHqgjKWs3ERIkmPRWTcC5rTSPexjSgnHASSsSgL
 JyiWk3/OuQ8czqOYzK64Y6nz7osDpliK90ykZKg1REalOvYbgxuGvZxi+4e8vQgA5qrT
 uqLw==
X-Gm-Message-State: AOJu0YzrBZOXd8k4m7JmSTqHcmZt9vqZqh5ImseG7pBivJD8o48jvxeE
 qVTksCGZo+Txq0C73lTJ2ksd1IgFzlUGqKhl5sqdT7yYjdXvYCfcQ210pa5dDtgG8/DOd48udz5
 l
X-Gm-Gg: ASbGncuY7S5JUsDyXR19bbGKA5+9szcYNKTRubuyrFsTR/4wKOlK3uqU3vWS+LGVFkh
 gQQDflpb0rm9e+713qKLS+Z4ZwvXvNcyE5oNKn0jN65tbXsn/rddgPCZEsTnqUTY5IvdAFlrr8C
 TwWsUZF5xTawoWNg2mTiNwhgImdlAhcY5gfkn7OVIai589/KuLDoi9PzFsCJ5uEF37KKrMlzUct
 kHHRueypexRd0JMrFb83IU50vhFyWhXK8UJez9gUSp5zqvV+MKjN5aFyIPSLG6qRzQER0cErQYx
 8ZRKaaxwy+klV4QafIMvjUzFEEKUuAD8eyP8YfkZDBZiVgOvXZgOXMcRSTTGchKiLNCHnrF1Ni8
 =
X-Google-Smtp-Source: AGHT+IHG8gSzTv2fFDZgH6bG9alPznE0yotHGGv3OMtBDF1FDLg0n3+oz2q/f4QekNA1BoUCaJ0P7w==
X-Received: by 2002:a17:903:1a6b:b0:224:c46:d167 with SMTP id
 d9443c01a7336-22c53581853mr236385015ad.16.1745350315873; 
 Tue, 22 Apr 2025 12:31:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 053/147] include/hw/core: Drop ifndef CONFIG_USER_ONLY from
 cpu.h
Date: Tue, 22 Apr 2025 12:26:42 -0700
Message-ID: <20250422192819.302784-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
index 37cb7d1531..6dcee5d0ba 100644
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


