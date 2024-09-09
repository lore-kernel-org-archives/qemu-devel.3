Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF93EECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC8-0005gY-2Z; Mon, 09 Sep 2024 13:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniC3-0005Je-VX
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniC2-00064v-CW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fee6435a34so39722015ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902929; x=1726507729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9JmBFquTO7CeyCRL5oNRbzXMkFmE+/UIxsMm6VSJ8c=;
 b=SQlPNO0uz2cSyCJvlaVWfJwJyXsQVEJJjQY4PMmKQyA0pJ3nSt1ck830vB4VgCBtlD
 pcgSdnm0mwPnhm6xeueKExAEE7JLR98FF5Q5JJYcy81m2Q2RtW666hud1gUPqBX8vTfk
 6h7ilL9g/OF9vRcSPfvj/bEhgvT0XAl+y1Sdz7k6gwbeWbcKMqsdHpTjpHJy1hgrMN8U
 unL/CsXUlMosdywfcgTVFZOZeCYOSJHkWuWflzcFf2SxKzVL9rEa3Z9VAToeK84L9KMM
 rqHMArA01RcKCSKfPr8fxzIy+lRm8LJ4lAmKc/Qhnbbdf0rkJO+Cz+rOWSmJSd8YCrUo
 1qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902929; x=1726507729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R9JmBFquTO7CeyCRL5oNRbzXMkFmE+/UIxsMm6VSJ8c=;
 b=ZBU39krbZ7MzFVhG1IvlKfGue/tH5bhTFiH5RHtvOpuOKGZnUhjh5wmJFN/ZSoOB7X
 APSDbr3VCfGIwaKW64uqO8AJk3aJnmDHGzXoByhfkv5j9nhR1wve5jjrMLRob17ZJt1z
 NfWMzneRMK7WqqISKTnVbZq5qYsKblCVnXCmk/uOHri7z1Nq7SdvpLT2aCuP8LQDXEXo
 r2GIxZcnlKd1+1G75OLLbtTloWNh/vmW5R5ZKyjsfEUnjl4JROatzkkGmUxe4XbMpQ3m
 q5FEwu5hS9VPmenMLGLXGTdvM6k7Jgj3yMzC0/ek350HwIBP0uJw0u7mtpXohg9HpRWF
 NL0g==
X-Gm-Message-State: AOJu0YzdfvBM+9gDdD0r2dTfh91dZlPl6Cwmso+t1feK1pwkg2YQN1vA
 tlGO0apiU4W/yL+Qwp802wI3nYHC2oFDC7MjF4muPE55LP79vLpOIlgnLFPLk4RMPNZt8ootrfg
 j
X-Google-Smtp-Source: AGHT+IF1Yf0ZzkOWya0YgWQbC/rjqMfhN23KihmUqaQVREOgVUwQGSdXRkP+5DXYNtlbEEsFklURxQ==
X-Received: by 2002:a17:902:e850:b0:205:8212:1f2f with SMTP id
 d9443c01a7336-206f04c7e54mr132341845ad.10.1725902928696; 
 Mon, 09 Sep 2024 10:28:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 25/26] target/m68k: Make vmstate variables static
Date: Mon,  9 Sep 2024 10:28:22 -0700
Message-ID: <20240909172823.649837-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

These need not be exported beyond cpu.c.
Fix a typo in vmstate_fpu.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 188afc57f8..fd6c227820 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -400,7 +400,7 @@ static int fpu_post_load(void *opaque, int version)
     return 0;
 }
 
-const VMStateDescription vmmstate_fpu = {
+static const VMStateDescription vmstate_fpu = {
     .name = "cpu/fpu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -422,7 +422,7 @@ static bool cf_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_CF_ISA_A);
 }
 
-const VMStateDescription vmstate_cf_spregs = {
+static const VMStateDescription vmstate_cf_spregs = {
     .name = "cpu/cf_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -444,7 +444,7 @@ static bool cpu_68040_mmu_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_mmu = {
+static const VMStateDescription vmstate_68040_mmu = {
     .name = "cpu/68040_mmu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -469,7 +469,7 @@ static bool cpu_68040_spregs_needed(void *opaque)
     return m68k_feature(&s->env, M68K_FEATURE_M68040);
 }
 
-const VMStateDescription vmstate_68040_spregs = {
+static const VMStateDescription vmstate_68040_spregs = {
     .name = "cpu/68040_spregs",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -505,7 +505,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-        &vmmstate_fpu,
+        &vmstate_fpu,
         &vmstate_cf_spregs,
         &vmstate_68040_mmu,
         &vmstate_68040_spregs,
-- 
2.43.0


