Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB4BC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ku5-0006U7-M5; Wed, 23 Apr 2025 20:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktO-0005j6-Df
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:45 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktM-00054Z-GZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:42 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so333592b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456198; x=1746060998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTTbJUYSutthRAHWERBfaY61+pWxicGlAYRiaD9+MBo=;
 b=Qp2Y9nqybqJqiicuKpqxwj3PVd6fWOtoymXUhxwg6mHS+QIUTqPms/1cfyY3NBtxLi
 pmqUebGCA5hv9wK+zZZomqjSqY6Chw/XAtIDrAEtPuvzVapL/MUlnR7wLRvVvOurjDGn
 qEiW+2JLgrs0ew/X8WD9ZTJ/MYZf72We6qKMLunPWqMIjSeCs4VKVeobKZ3jSFbTo9SB
 Xy8P71GA1ASelezUzfXja0NVuY2qSGsBl3Mrb5L2VfqT0tTeqYSpy24qWcF02tjaWRfq
 +lGd0tLnrKBH5jHG66KbTn+pu2FoMp53Lflqsn1J1NwbgcTH2CrSIQYJSPFs/OiokSrZ
 tkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456198; x=1746060998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTTbJUYSutthRAHWERBfaY61+pWxicGlAYRiaD9+MBo=;
 b=bxwp8x2bwtNMzPRvDekMTxpmK3jfpsCsKEUNKtYOGuk7oOjqHCM4xqivfzkol4fk8D
 OW0HuP+MoGZdZ7H2eyxzn3fr9QvzioPbTXZMSsEdARbgXmWX911R08gWlStxieFUCEw7
 LmuFNqcScOWHdD7DbPBADnqnUFwjrBR1Zrbl0Bc3ISB+HbIigK/604Uh65ZbPdEr/dtw
 y2xbTATAQAQE9F3AooR106DBfstTrE7rX5qm0g/QdmZ1D5k7ESadA4g/9BDwXIjjKTN7
 O0LIDXvnlhdWQQB6nj4Ex0wGmfvhv6aLRaxqKi/tbcVRBsfgGjD8FAj0gkktqual+PdU
 EFIw==
X-Gm-Message-State: AOJu0YxNPeU1kIg9MDHguOuKa0qS6Juc6HigPTkoUBu/N42hcsv5SWzB
 CVfNhH5DuxaVm0Qh3VNt5TouybtbGuxisNYfJ5j2Hp/xtCIGir50V7bJtJSkntrDUYfqgfJou+o
 9
X-Gm-Gg: ASbGnctZC2HnWp32CHJChzfNH3F2P6RIL8rJ9bIiK0TAU+DvDXTiPApbSE10gMmIE3Q
 wR+mJbtggfiaUR3LVjvlWiEhxNEUkslHqpeAPI6zq5OWPOQ4S4BiLtez6pOKXXgey13CQLMPItY
 zCRVxYuiJk+0jq6tCDtmanW2JpjSn23luGp+glzjXQaKhbvHqEnMWLHJmgrjYrTVHBFA6xnD0Yp
 dfKjaeGqVIPkjNkXw4Wenkf5fmIaVpzmWWzpOCTqr38uzOj+89TVJLJD9FKhyn0oWxpv4C18pN7
 gi2HMBd+QqVApAmS003btRX1oa/ZMKXremlPCR9B4hDdXSuAG+tBX1CYt2+g9+FT3zB5jY2eigM
 =
X-Google-Smtp-Source: AGHT+IF60DJEe4UakaoApjqvhIPrCKONWLQOL98iuUKSwSVi5/qyfDfe5dyn1zrm1xriHhiLLsLHfg==
X-Received: by 2002:a05:6a20:1587:b0:1fe:8ffe:9801 with SMTP id
 adf61e73a8af0-20444ebe04dmr839253637.22.1745456198415; 
 Wed, 23 Apr 2025 17:56:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 086/148] target/ppc: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:31 -0700
Message-ID: <20250424004934.598783-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Convert CPUClass::mmu_index() to TCGCPUOps::mmu_index(),
restricting ppc_cpu_mmu_index() to TCG #ifdef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-16-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 17f0f3d3ff..fd8c42069e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7216,6 +7216,11 @@ static void ppc_restore_state_to_opc(CPUState *cs,
 
     cpu->env.nip = data[0];
 }
+
+static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return ppc_env_mmu_index(cpu_env(cs), ifetch);
+}
 #endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
@@ -7225,11 +7230,6 @@ static bool ppc_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return ppc_env_mmu_index(cpu_env(cs), ifetch);
-}
-
 static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -7482,6 +7482,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
+  .mmu_index = ppc_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
@@ -7518,7 +7519,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
     cc->get_pc = ppc_cpu_get_pc;
-- 
2.43.0


