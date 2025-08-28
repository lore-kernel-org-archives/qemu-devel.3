Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA68C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbRd-0002Vc-Eh; Thu, 28 Aug 2025 08:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRG-0002I7-Ni
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:15 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRB-0007Ah-CG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7721b8214d4so471405b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382942; x=1756987742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bpn3ndLl0YF3E946zMM0StCE7xSTLDYDpwSUiHaH8To=;
 b=E4eYy6T58BepEpKWyzzyjlDC565y72QP2fHVye3A18VXZOsk5GbT+VAfFohq0h37xG
 vuuxjs8ctQnkyeaKIJEK7T235tfz3EddlXroJfnleJPPkEksOQcWMEzcPXDBUCH2DfRO
 lwUgLSpbDD8u7PrmkCy/NwVRCRpW7x9zrZA1C+BWZd4Oafzik2vrStgZViO/0q1AzuXz
 2Ehpdii3Z94dlbGCLEMbgRjP029nee+e1qHecUjtr8T3TErj9dmHw/zrJSKKDR80qYu7
 A5yG141E58KUsvZw4XGjFSia47gdJ+axGP3wHuSsTSui40pTL4JDcCXcuzEq2emiGKNV
 1Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382942; x=1756987742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bpn3ndLl0YF3E946zMM0StCE7xSTLDYDpwSUiHaH8To=;
 b=IDvCMPbLEOFF1SwoPrreF2eMlMfyRJ5MbuovrHzlOA982KBNlXgOufbNOo3F/lobae
 S6G+nVyJia9JMmQAmP4SjCbPjLTbUBKXhWnL7V5HLytLfj8bbBc0H/Mon3cFwMLjkXBl
 mvWR3G090+tbC1GBZ7DdJE3DiHWA8SIhZybsI8+8LEvwB31aAQVHbotUSVVZ309Je2oI
 fMw1ptOhhBzqpPfjutaBpt2wnP/zzIbxGIRBt9e86z9NszMxc7vDt4Y9ZBKSNNnNkprC
 S/5yBNaErEhBVoRuIxlaOVTOFwZA7MAiHUGcRFmAeA27ewbwYWzK7udnoYFeKpL268h1
 beEA==
X-Gm-Message-State: AOJu0YxTSIhNrPRyob9pCAWVq54DWBHRFQ679758/twXy7TSmlxAGQWG
 +LojKIxjukDCWaTQHMvdgauwEUvXHM4GZOa5Pwl26Qn+v6tMeUOBaHnMtDKdh0krO6q7THHmGFV
 oZaJ/oCo=
X-Gm-Gg: ASbGncv0w/s/efMqUePWSahHflCc1w9gswf+xEPIVg6Vx3eEh4HQ/6H9Pb95sHhb0ci
 PNutft1c+bEq7FSIAj8XlDxwLiUMe3iLjbEQS5E7xsacU7Sp6FdWpzxHL2k6o3C2jexIMzl9F7L
 IUP/S+OnbuJ7j6MxAsCG+iOtdNhoZcEkBr2DDXVJuJ3XlaawxCS+OSP9zH4raUTU442cu7qcQov
 /DkI7KF+0A+Es+jz0wnQe+w2nPkKiO1sjZtFEX1d/A0s1pmCaVQNTokzyIsaJnVS0EECZtV5W7D
 FvHRIwe4YF0WCAf2x4B73rNczF/iv+WN/s6NddMhrrV0H7NhOvdvy1jLW5SBiZJNyJcfVTbvCbG
 LDRL3IST1wTxU78HiqxKRv3Ekqw==
X-Google-Smtp-Source: AGHT+IFw7XoO5zmgmppy/4xZJhN6VCg2wQtETdX5hIG4bzfB8o1/9vwunZB3KVABiPi0CHXrOZWvQQ==
X-Received: by 2002:a05:6a20:4321:b0:243:b52b:c97 with SMTP id
 adf61e73a8af0-243b52b1499mr1426586637.2.1756382942584; 
 Thu, 28 Aug 2025 05:09:02 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 08/87] linux-user/microblaze: Convert target_elf_gregset_t
 to a struct
Date: Thu, 28 Aug 2025 22:07:17 +1000
Message-ID: <20250828120836.195358-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

While we're at it, drop "pos++" and simply open-code indexes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8fcdb0569b..40a5bcccab 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -623,23 +623,23 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 
 #define USE_ELF_CORE_DUMP
 #define ELF_NREG 38
-typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
 {
-    int i, pos = 0;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[pos++] = tswapreg(env->regs[i]);
+    for (int i = 0; i < 32; i++) {
+        r->regs[i] = tswapreg(env->regs[i]);
     }
 
-    (*regs)[pos++] = tswapreg(env->pc);
-    (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->ear);
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->esr);
+    r->regs[32] = tswapreg(env->pc);
+    r->regs[33] = tswapreg(mb_cpu_read_msr(env));
+    r->regs[34] = 0;
+    r->regs[35] = tswapreg(env->ear);
+    r->regs[36] = 0;
+    r->regs[37] = tswapreg(env->esr);
 }
 
 #endif /* TARGET_MICROBLAZE */
-- 
2.43.0


