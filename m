Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D856C4828C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXd7-0000UH-E9; Thu, 01 Feb 2024 09:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcy-0000RR-FD; Thu, 01 Feb 2024 09:01:20 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcq-0005Kn-G1; Thu, 01 Feb 2024 09:01:15 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a366ad7ad45so117171666b.3; 
 Thu, 01 Feb 2024 06:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706796066; x=1707400866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vwz4Tehyk0t8VGMK24WnQkMqQbhlmibzbAS/3Lxw+fQ=;
 b=Ym60dRa6DWBwUzVB+l06ay0Rv/OMbrpTTW7wu/oPOtRubHoJ3QhDAXmJadSiMMtGDp
 1v+M/Kq85mJrdgoqaTTyKjxKU8ccE+vVAu2K9DIMSvifknIJoFmN42rchTei0sE4u+RP
 Y1FFCWKTNZqzkLPOmcUE/hiu7M0FHSCxOoUoTm6UNOVs2mrLjkgnkqNUjsB7Ioxw+q6z
 qqI7i/Hn4bBBxukmelPTvFvUWF8Ac1Gbojp5SLY9YCvBcwSdd8Fqq9OjjFfVm/nRRyS/
 ZT0sfDpdzzRMifow5sFw06FezBuxmhOuAtqr1+Dq6nlYJ7QvW9uVuimbTLT8ZF8dlNFR
 +Y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796066; x=1707400866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vwz4Tehyk0t8VGMK24WnQkMqQbhlmibzbAS/3Lxw+fQ=;
 b=QUlsxc36lNWQy5DlRicZrKFqH5NN13LV8720VCef4/Ip1RR3cYtDXDouWym1BzwACt
 L8vhO4YqPwDdJrTXj98IlDKILhL4yl0NJ6q3fOFa1yV3RqYQAe+8tJufBdIxYV6JhR7R
 5F5g/eLSNfioqVraXiRpCeZ8fN92kiz+tch32LiIdfjx63c8yFdssN0UZe6Dlv1SbXRo
 2wfLU1E5i/JV/YCBGJhrqpZMtl+TH/feAaWG/HKgP/Ar7ClGUsBpm2dx0JfznwXrpTzM
 OcoxSITfEi6lvDK69sx8ndimgdYGHHdLDKyXZW45POEElttDnbgzaml32Ko1FUJvn9Bl
 Ib4g==
X-Gm-Message-State: AOJu0YxpCxkbMwA+pOkKgDVEk8qM1jxpDWtr41rBwlbJLiRqtbW2hbFG
 EhNrRUBKPF8aAVNLN7PIX+1NMaUrucCzcuBa3+UNAurK1W9vSsYy
X-Google-Smtp-Source: AGHT+IHmP3GIaue8NHBmMEFPcimfXyVbN9VAVYSD5bJgE/ErK0LmqkktIm9nUfwYmOXKBXKfKXDO+Q==
X-Received: by 2002:a17:906:4a0b:b0:a27:5446:27d9 with SMTP id
 w11-20020a1709064a0b00b00a27544627d9mr3808395eju.5.1706796066064; 
 Thu, 01 Feb 2024 06:01:06 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUYNPAzWsm2y3Oh0ytQvteFllMIMAJwiPALbrkGP8Ii3YB9FP3V4A8OcAtPnf0pa9yWezxmLTzCZFFIiUYDgTpaXBzG6ZAVjb1FZ/EYc1HfS9CcKPdTutgOPOp1d5qJI/l+5nTZnVpwzcX5SQpl2RDk27iBjE1Socwx7AfqsiKMLasIkWAJnJWpNO5IuSmBUhS18j7vCAXAMloRYcqE9h/3UZ1ac8YlpUrg16vfrHAmeEJ079U44BxGlf94ECbOG+wAcO+LDgDZuqaADDGHKeKpWNmo2uigGeLzhjyieVIm28hVHC3edMTfmqa2RNlxtGtSq7uhpli+Ke4whqUh3wWWbUwdsNogM8zfHwI/yPSgpLmLEwaYPVLs5t8=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 un6-20020a170907cb8600b00a36a7f0f087sm902728ejc.222.2024.02.01.06.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 06:01:05 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Thu,  1 Feb 2024 14:00:44 +0000
Message-Id: <20240201140047.3456114-4-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201140047.3456114-1-me@deliversmonkey.space>
References: <20240201140047.3456114-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  4 +++
 target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e03ff3003f..96b554a00e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -699,6 +699,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+int riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index aedd5bef50..bef7917668 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -142,6 +142,64 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
+{
+    int pmm = 0;
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    switch (priv_mode) {
+    case PRV_M:
+        pmm = riscv_cpu_cfg(env)->ext_smmpm ?
+                  get_field(env->mseccfg, MSECCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_S:
+        pmm = riscv_cpu_cfg(env)->ext_smnpm ?
+                  get_field(env->menvcfg, MENVCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_U:
+        pmm = riscv_cpu_cfg(env)->ext_ssnpm ?
+                  get_field(env->senvcfg, SENVCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+    return pmm;
+}
+
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+{
+    bool virt_mem_en = false;
+#ifndef CONFIG_USER_ONLY
+    int satp_mode = 0;
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        satp_mode = get_field(env->satp, SATP32_MODE);
+    } else {
+        satp_mode = get_field(env->satp, SATP64_MODE);
+    }
+    virt_mem_en = ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
+#endif
+    return virt_mem_en;
+}
+
+int riscv_pm_get_pmlen(RISCVPmPmm pmm)
+{
+    switch (pmm) {
+    case PMM_FIELD_DISABLED:
+        return 0;
+    case PMM_FIELD_PMLEN7:
+        return 7;
+    case PMM_FIELD_PMLEN16:
+        return 16;
+    default:
+        g_assert_not_reached();
+    }
+    return -1;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /*
-- 
2.34.1


