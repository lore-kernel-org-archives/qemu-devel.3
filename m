Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F8CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay9-0006Lo-8S; Tue, 23 Sep 2025 17:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay6-0006KT-3o
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay4-0003jN-DZ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24457f581aeso60505845ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664475; x=1759269275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3tkOqHK5ejgU7JIInVN+rKgDfoWboky6FhXhkFrd/5A=;
 b=IiPHP9Ws22ffgZ0/bs2NfR+x+igKL5hLp8ArkBclhXKUw2bxQzHdGZI4860DU3Qn71
 ag84k8r3hhzmGOln9uGMfBaD82lMoJfoHqW6V9ArRLimiKGCqeX8gTlgesO9Tc+rqszt
 DCmpVAAdW4DEY6qjs3nbnzsSymwKCwscVqzTmVdyrgK4cxBJG2ZV0ePuaown/nE+qirt
 GHs79o78gD+UweDRCRYvW2tP8WUFnPTRtm55igTV3XNynR2nN7NZxhlp7raApZqo3tmz
 tmoMABhgT37Tkynqoa+zwF4QclQsyLGl2yyeUL2CihqlfCICrU6eBDQaQwi8AHpIRmn9
 T0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664475; x=1759269275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tkOqHK5ejgU7JIInVN+rKgDfoWboky6FhXhkFrd/5A=;
 b=lXDc5htdIvOhE1tT2VFv9EqUvyCdcN3YRJQAb/fiUX1p7fplv4SVKGeN7xxvYr33vn
 s2dRSSGcYSLSR3n5ghRzcGA67ClsWQyQer66Nxy7G6vxjfkBdF/GqHKmhj/wYm/elPRI
 nV/2lUmAui8owD9bTv7Vw1f7Ot86iWDiNV5DMEkht/+ZZ7JR8Mq2U2LgQkcOpH+X2MgW
 cNfKaV8Cq+4duq+7a4p/4tutniYN0CxltEXntT9R/q6/7o0qrowFoGLtyu0tGZleTlSV
 GvZyLT9lwUPl8Xpj2PTo/J5VbGqN0gvfr/19sjatljQz5o857V5W6womZ+nc4NBW/sjI
 n5qg==
X-Gm-Message-State: AOJu0Yz7jde7NLxzuZ6idR7C+L/RikfeeDQRHM/F2jchvyIZ9X8r4R5T
 i78FjEJgO4S1wpuiT8OpLjD7kdlxod5FaPUP6TcftfhrFM+engPTaWx+1b68PfnVEGNGe9EYJTP
 m7Qf5
X-Gm-Gg: ASbGncv+R2gPdJzOjz3ZLYsv/+BbOoJoONe5r78h4Mww1r/laHxlpIZMTV76wdKVtOH
 5qTsqQT127B2XABJo5iPNrMkpd809CWfKEhU7wtu7093zLR6PJnaqsMfiffELjaJ6vIVwe1wQMz
 eHfB6qQswVKxWaa9O+hUGCGSoJGGyCBvsuPkQN1RVxPLFFW5tFuzSPsE+fu18nOgIMo2cHaqgiW
 Ib6FJR+0vkJz+2IOetFuxQSxZiR94QmysvtjkfTTqwLIG69UYnoPwCu99GTOWezNIz3KDPb9TAB
 U/uDkzqVONpJ3oLvWVtAPK5aYHDyf/sOsbW5zSj8J2skLSkpOpAqe79PZAJlN21dpZcgjoqM0Wy
 pmfzT/YTV1lP6cBWAFoiBptiaJede
X-Google-Smtp-Source: AGHT+IHRJgiKIW6ISvVJIrNpGL51FXSlJ3tm6v5g1PhoZ/EziWy+Ll9Q46Db0pJGvBxKrMVWYwzj5Q==
X-Received: by 2002:a17:903:22d0:b0:248:ff5a:b768 with SMTP id
 d9443c01a7336-27cc09e4465mr40093885ad.10.1758664474299; 
 Tue, 23 Sep 2025 14:54:34 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/10] accel/tcg: Improve buffer overflow in tb_gen_code
Date: Tue, 23 Sep 2025 14:54:24 -0700
Message-ID: <20250923215425.3685950-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
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

If we only have one vcpu, or within cpu_exec_step_atomic,
we needn't jump all the way back out to the cpu loop to
empty the code gen buffer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 31bc0f8bc5..da9d7f1675 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -289,6 +289,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     tb = tcg_tb_alloc(tcg_ctx);
     if (unlikely(!tb)) {
         /* flush must be done */
+        if (cpu_in_serial_context(cpu)) {
+            tb_flush__exclusive_or_serial();
+            goto buffer_overflow;
+        }
         queue_tb_flush(cpu);
         mmap_unlock();
         /* Make the execution loop process the flush as soon as possible.  */
-- 
2.43.0


