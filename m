Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7671CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbR2-00025t-AX; Thu, 28 Aug 2025 08:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQz-00024D-UF
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQx-00077q-NZ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:53 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-32326793a85so753255a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382930; x=1756987730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsirV2GKPgHnqs4+QGNqjVOSgh24YvjEMX/IQK9m7yI=;
 b=zFAQ2ep8KNEMNVcbN8r1kUdI9sJuToQv+d42YPPAMGxfJ1qwGZ75d4GRY5s6Py2ec8
 m6h0mt8rF43zHMDQ+s3cuPN9JYURJR4pJcUmkjHqSxXRZx6mil578YLOqpy/NieakO3H
 E9rsvMFAJE4dSjiXVppXB0xoQUchefUWFfhjnTPgc0RKHGNSobiLkB7DusnUx5EBL1Lx
 DbkgojvB9csJXewTRCoyd9cs2BYMCmFQ/a0383Whcrltsw1TQbyBfYYfv+0xHimZ0cCx
 tLALLcGKMtwArbcfegAIOqTOvyF+cp+P5rmaYiefPOAd95ddSgj3bpJiwfrnaDBuh9KN
 S1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382930; x=1756987730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsirV2GKPgHnqs4+QGNqjVOSgh24YvjEMX/IQK9m7yI=;
 b=BMkVGZDBUOySw7rMtGeM7rt73w14HhInlDjQifHnSfRK46wLjUKHVgZAb9ZicGVaJe
 dVyr94lWHJqyWAywi/MhsD0HmGJnOL5N7EYEct/P2RCbOF2SjlIUE4c0gnD6IezBC79S
 wjkAHFzuOAvngCshkRKkTWAKxiORr65p4lURNlMY03jjX1xFv+TpXNcO4Fr3gQnpoOim
 zW7+fiYDtXFQ1AYs+LU40JkoBcMSt3FXaKjHjFxCq4ll3c6ocFVdUHrUC8wsx/YrChhX
 lAMNPzu583V2B3563mOfx9j810r/xGoF7GrAvtQLLCuLpsJ5hVVwJsHJj9vFYKLZxR9w
 kQ6A==
X-Gm-Message-State: AOJu0YyjPdK2IN415TcxlAVVpL5s3JWAYLaQ/mY+IU9edPalx5McBfN3
 dvmyO/u7K+feYUoA1JX2BCCQAc472/QC5rTx3w9XqEOTIm2HpRYyeBKkLrGHNPkt3nGt7+Al/ED
 0rVM06yM=
X-Gm-Gg: ASbGncsUjAqcJDtGS+kmchgZOitp5ov3ENTbrOLGHQXQnwGw58wofuAhNEwBB9w2WNq
 pbITmt4w31MqjcLy+IdzF+OSSrhOo9L8+Plxcn9BrAMBosdhVhM/1RlNEXXIFIv+vQGfazA6rLo
 f68P8xWbCguTchLddIDdN+e+vJXWHfUIQfEXteV4jo2U/cxZ4xG0lZQEMEV1YUZL9TEPHuzNMlA
 h6Ki8ozFnHkVUzzc8T35iHzqSYxEXVxKDl8x3hkTbZYkRhzyZok6KNTMaSkPimUi7baBVQfhDgD
 EgWbkfkS78QOhksUyT5nLvXKvefNBSDLpQhiMKYtVXK7MSLbs3LSZLOenG3oa8KcrDcXWD/RsdW
 0Jo5W99GWW+umpaqSGzxOqu0v/yQBYCvntZjHqxp9i9uTLd4=
X-Google-Smtp-Source: AGHT+IHtpd0qGJiRtgTFSBNPBeE5rneqEsH5828VmmeXccicg/k6vELyeieBufjr4Hm2eGqTewLoKQ==
X-Received: by 2002:a17:90b:3ec9:b0:327:5360:5b0e with SMTP id
 98e67ed59e1d1-3275360615cmr10338410a91.30.1756382930051; 
 Thu, 28 Aug 2025 05:08:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 03/87] linux-user/arm: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:12 +1000
Message-ID: <20250828120836.195358-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

While we're at it, loop over the general registers
rather than open-code them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e8a7f040ed..0180f6063f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -296,29 +296,17 @@ static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    18
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUARMState *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
-    (*regs)[0] = tswapreg(env->regs[0]);
-    (*regs)[1] = tswapreg(env->regs[1]);
-    (*regs)[2] = tswapreg(env->regs[2]);
-    (*regs)[3] = tswapreg(env->regs[3]);
-    (*regs)[4] = tswapreg(env->regs[4]);
-    (*regs)[5] = tswapreg(env->regs[5]);
-    (*regs)[6] = tswapreg(env->regs[6]);
-    (*regs)[7] = tswapreg(env->regs[7]);
-    (*regs)[8] = tswapreg(env->regs[8]);
-    (*regs)[9] = tswapreg(env->regs[9]);
-    (*regs)[10] = tswapreg(env->regs[10]);
-    (*regs)[11] = tswapreg(env->regs[11]);
-    (*regs)[12] = tswapreg(env->regs[12]);
-    (*regs)[13] = tswapreg(env->regs[13]);
-    (*regs)[14] = tswapreg(env->regs[14]);
-    (*regs)[15] = tswapreg(env->regs[15]);
-
-    (*regs)[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    (*regs)[17] = tswapreg(env->regs[0]); /* XXX */
+    for (int i = 0; i < 16; ++i) {
+        r->regs[i] = tswapreg(env->regs[i]);
+    }
+    r->regs[16] = tswapreg(cpsr_read((CPUARMState *)env));
+    r->regs[17] = tswapreg(env->regs[0]); /* XXX */
 }
 
 #define USE_ELF_CORE_DUMP
-- 
2.43.0


