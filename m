Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9534BD4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagQ-0005C3-VD; Thu, 15 Jan 2026 22:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagN-00059T-QD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:31 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagL-0008S3-Rf
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:31 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29f2676bb21so15495015ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534768; x=1769139568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqHIEExBUi66KFxM/MRoC2fNgQMXmj+1KcwcA/FBGKk=;
 b=OTt8hAdEq86ijjGYbOq5KhhPhyiaOH02WmjJlXZ6jCuHyJ+7a+P0ntEQcakHHXAzuT
 d+qYYHQM/IVfftu3HvrpN8+Ej/REpqQ0xEr7icTlOjDoi+8trIOxD8US3IeSb9qcLMnu
 aaK69GXGQdnGUctLPd0aV2CLibwhaEJb5pUjnpmW99PsinVZpPBfMslU2FgcjbSqOPvc
 6cQjZfsR24z5JniizYsa931sn3y3XH1jqGzRVDroUPgHDbW0+LoPQeLDy2ludMaTkeiW
 oEAWBYWU0zlUIER9n0MyrpF5HUvl+L8ghXRDnxQV34K03diD0Syf1nPTDAry9k88lUhS
 35nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534768; x=1769139568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RqHIEExBUi66KFxM/MRoC2fNgQMXmj+1KcwcA/FBGKk=;
 b=DVwcxVzDSmF96X4pmIoaDnmBeGvRw9aQbAbAD7jtkM7j7Ruh1ojkt5L1ceRyBe2fkR
 aHrin4c44SrbJ7A+KC7rVnbp4BSgSPYq1YWF5f5AhEezJqr/wzyoc0aarggLmaJWsL/N
 28snwPM4CT6xdgJ57hmjfZQ/Ku0sg5mgZZPWbQQbQ1rIbWmfx42rbhD6zs0RKnbmAwlC
 xOiqZarx+UfmmBzwCR8rDNkJtpG2318zb4HR5tX68nv5/ALeV45/bl7cLLD4FV11OsXK
 TuRsqXVBrjpbyBPh8OacTFpqZh6uKFOHStQtMmZE+N8ayFImTk3IN8WaZzXLS4TGBEhK
 pYVA==
X-Gm-Message-State: AOJu0YxUB+JPWsSDie2gyyjbiRkt/ivL5omtvSW0J/i/E0D7mPEpybR/
 ATMH14UAgi9Vyth4U+pd69fyQLSPfHC9VSQD04udCzeIzuM25N22gvGvbfhkOoojwhUGybLKARt
 YnZOYXqdCYQ==
X-Gm-Gg: AY/fxX41pl0Fnz4exD/PrMPZilikAdj/XivVTiiqdzBC+P7nVVit9GM5nMlMMEfRk2V
 lDr3W9AxUFEh13yRRzFeJ/Dw/gHz8xsF36BVkc7DG6C9SjTvtEp0nxdEaDhIK1bKJMyi85qb2zH
 LVZZ0+SFEG2yEmKhsnWBWneHAIZy+jgOGlDB9in0CLqmKccarfxR1SciCY2YHW74Kv19apGWSpS
 CnWp8FZSLnEMe+wRL40QxSWBAexHejH6MVF2P4pPLyRd3okpvoMb6ubTY9RjRrlMoheSWOjLe0s
 gLKczUicYIR+knwEwsWxOuqB31ENt0wHuirZnqXFAKNvn74Rfakwd9RDsCvYm0K1y+E6YPqKydS
 sirusDwGRkbiP2et14cDDFucDWDrUBKUbtwJmJ70WN2uWOcSsaYnapT+Heh2vBFIt6CuNejDZ+8
 AzVoevQfZuz/m5/WtfUg==
X-Received: by 2002:a17:902:f64c:b0:297:e3c4:b2b0 with SMTP id
 d9443c01a7336-2a71894325amr15315125ad.54.1768534768273; 
 Thu, 15 Jan 2026 19:39:28 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 50/58] target/m68k: Drop CONFIG_ATOMIC64 tests
Date: Fri, 16 Jan 2026 14:32:56 +1100
Message-ID: <20260116033305.51162-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/op_helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index a27e2bcfbc..f7df83c850 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -816,14 +816,11 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
     uint32_t u2 = env->dregs[Du2];
     uint32_t l1, l2;
     uintptr_t ra = GETPC();
-#if defined(CONFIG_ATOMIC64)
     int mmu_idx = cpu_mmu_index(env_cpu(env), 0);
     MemOpIdx oi = make_memop_idx(MO_BEUQ, mmu_idx);
-#endif
 
     if (parallel) {
         /* We're executing in a parallel context -- must be atomic.  */
-#ifdef CONFIG_ATOMIC64
         uint64_t c, u, l;
         if ((a1 & 7) == 0 && a2 == a1 + 4) {
             c = deposit64(c2, 32, 32, c1);
@@ -837,9 +834,7 @@ static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
             l = cpu_atomic_cmpxchgq_be_mmu(env, a2, c, u, oi, ra);
             l2 = l >> 32;
             l1 = l;
-        } else
-#endif
-        {
+        } else {
             /* Tell the main loop we need to serialize this insn.  */
             cpu_loop_exit_atomic(env_cpu(env), ra);
         }
-- 
2.43.0


