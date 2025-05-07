Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A3C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm4p-0006Ak-8B; Wed, 07 May 2025 17:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4m-00069c-KP
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4k-0006DG-TT
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso460240b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652389; x=1747257189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UxEDBljyfqsOJ/6sF4OYF0K5MA05WdNFxTdb/zwknQ=;
 b=ZlgJfrqog7xom+psuYkS6UV1Qxw4NpMfkeO8FPs7Zmwa+2bzPyonJlwijdAfgk4MM4
 cQGSOI8caBHqnokwsgxk+nQm/KDz27RkdmtLHqdtQcaVgO/VTt2kWLwLmEA5rK58mhVy
 YZ6x0fhl591R+sy/IEIWQ+/vE4x0yokHLc8qJIQwmQ+PqAxwBPAs2Uv1hqvKbP4neONi
 pdODvuGZSVOIbSPa7rswnwFwmmGb81aT8NKyaFQgEr4R2hiUdHaIFGeARmBsrCPpzdBB
 07l56OMPr/FKV5vGqBwimQsRmySV7zqe2DI4A9jhk2wBjCKVmUVggW6sghAVCWqMoUNL
 ifMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652389; x=1747257189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UxEDBljyfqsOJ/6sF4OYF0K5MA05WdNFxTdb/zwknQ=;
 b=HEdzToJCzDo+7MfHtUC6Ietw7APK7zQPhaU/j0vsghgEdPbmpMOd1DTJPaC7B8U50q
 H5XO9scYqMp7kJPUl8H94sklvJZdU0s55spvqyQqiG46pjiMdFBhC2pm05oMqQGsX+ic
 2yxLh37YMcP+nB9SRCYdnZ2wGIq82ic1+cQyKwdFXeVsWk10dPl8rNKPZhf8a/8MU9UO
 nOxig+QKFjIlNwsIep002pQO4rYbLdL0SILFYhAEvR+VdzxSkITp/o2zNl/Od1V6CGvQ
 IJ3YPpdVKebia31OKwxMwPmckDtgRCT8toS5m2Kiu+2VZQ2il3IxmQ9gqNTFlomggPU7
 IRjg==
X-Gm-Message-State: AOJu0YwX8uRDNfQcYFcgvUN43q3oKtvR7x9iMz3B3rKO3Rnf4nbB/19X
 upSQCuUEuXRHSkbuzrDTh3CYdHEMIBPPFhWIyVZLIRISMoXq0C+DbBBbiW7rFL3Um/U/enEUGfl
 9
X-Gm-Gg: ASbGncs2atfyvQPBOMsEKygI7Mx0wmt05N/CkkFw5+qKu/SKZyoafbY05kvxDEFoqxw
 s8ckdBxLrR7YC+rF4NHTrQPdH3FZ+wZyvE99KvczSMde3RagNA65xhJLR7e/Ujl+bcKVLTyjLj+
 nmfe3HnDGZuuDt6WP38W0fGeGMkn6vCxyXY6md4YxLBmgyN3YyA4/4QH4jLLN4mxAp+rmPNrMfO
 KNkf4eNerJh1suozoegBGIY0kDMhR4U8cxXN8RBOVuFfHWBy5jQmFZKoQNaJXnnUe3jDqpke2CH
 PcjFF2g1ov//R7v/TW/wjhPRb1yjmqy9heBBcOnJMUxOaetDUgAGwYX872s2+rzbfhiy3TCcYR4
 =
X-Google-Smtp-Source: AGHT+IEtqZrRFaq0Ik5Qo5CiUzyyjwPRC2hAGM77bxOKMu/pxPbssHuDvjeOowjMOfXgKY9I2TAB2A==
X-Received: by 2002:a05:6a00:4489:b0:73c:b86:b47f with SMTP id
 d2e1a72fcca58-7409cf1e48bmr6679258b3a.4.1746652389540; 
 Wed, 07 May 2025 14:13:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v5 09/24] target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
Date: Wed,  7 May 2025 14:12:44 -0700
Message-ID: <20250507211300.9735-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

For LEA and PEA, while the manual says "size = (long)", it also says
that the pre-decrement and post-increment addressing modes are illegal.
For JMP, the manual says "unsized".  OS_UNSIZED is the way to signal
gen_lea_mode to reject those addressing modes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f87eff3b10..b6d46c3bdb 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2561,7 +2561,7 @@ DISAS_INSN(lea)
     TCGv tmp;
 
     reg = AREG(insn, 9);
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2658,7 +2658,7 @@ DISAS_INSN(pea)
 {
     TCGv tmp;
 
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
@@ -2909,7 +2909,7 @@ DISAS_INSN(jump)
      * Load the target address first to ensure correct exception
      * behavior.
      */
-    tmp = gen_lea(env, s, insn, OS_LONG);
+    tmp = gen_lea(env, s, insn, OS_UNSIZED);
     if (IS_NULL_QREG(tmp)) {
         gen_addr_fault(s);
         return;
-- 
2.43.0


