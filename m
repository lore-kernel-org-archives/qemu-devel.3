Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B569BD3C91A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLWa-0007HU-Vz; Wed, 10 Dec 2025 09:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWF-0007DT-L5
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWC-0003CY-Dl
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so89225855e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765378213; x=1765983013; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W+9eovatYCNWom5mEm0uh8DNbPobmT3aho5jVRa8xVI=;
 b=iB5HLCUJ4trVjeGJ3kKhH4BiT4Y8l/ExpFluaQ5zghb0uGrwtn3ug2FYVMvG6Y2XL4
 IVhAWiL8JSujgsTIhiuInQK+rIe5laFSbhWyJ8PGSMT9ONxIuPzQKBHvZTYIU3I1mfmZ
 tcRqodk9chgKa96aBSq3/ACdKI2t+/u99Vt6VvtH1F2KeIfTwr4+DGglnq9xNAG2liwK
 9uU3Xtah1mlZfFcauolGf65Z0Kx2fCG6jnljI4X/mFEdemSKie30i6OY8c/emmJgcxrS
 SLYieTb/R46wf0PXiLk0sg1+xYYFwB+4Hre39xP6VrjBkNEdi10qaVBUewPCToMSr8QM
 wamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765378213; x=1765983013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W+9eovatYCNWom5mEm0uh8DNbPobmT3aho5jVRa8xVI=;
 b=ULM8CdFjznYOGeGGxIlPLZj0+W30ZWdJlag8Zb3hVGwECcBwK3LLIe/vmZzoQwMKa9
 gv5qzUjPUUgrTOk8Y/5A55S111BaHKh2Ps+iL2tDRkGqpNReAML226BsPU6FLnjePZAt
 VwOJeE3OBxa+vDFNH1tfdsW95WkPuDQdasIlh28wqUxpGh1kwmAD36rA6+2gceGYHqbZ
 /+CidmWfUhb8bbaCq/P3tMUaagYXw8MVRd1QBgKt/wj+qMr8dAWw138zpIGLw4j+q8SW
 VAPqynBPqjy7V+XtLCEtgKFlGg6ukQdulQybaaM/Y09jpOqOf/jKUqouEFDckWfmV7pU
 r0sg==
X-Gm-Message-State: AOJu0YyUbF97oEFwP7acuymk9fzq5cQsZnAo6/CVrrUkoNOISY95L4gC
 9gJzRoSmPX6svHlY7+f4jumrJ5etonWP5y71+ZXx6VURfzD/aaQy01QSFJI0p7pZVWA=
X-Gm-Gg: ASbGnctfnvq7x0M0e5LXGD0/N2EJD7Pjj+mBXpCZ1JDxIRyFdi+yY1vzn/WkNSn2JMG
 fuvTut8mph0WgbqEAp+PMYxM5ZoslwVhcLef5HLKi3JcqFWJr0pziwVdWV4Wmn0NRFpyFgT1oMN
 T0g+O2FU93+9McgR8b5VkI0iQ0IdQMgZTYwxfsRE7/M0vjG9JE2EUAB/WRvJzJmfGjJ8UpEFhX1
 IaeVHsmTBZMMWQmgNWA1BtbFl4rV2nXdliv1zseFkz2sGMD9SAmgaI6Svw1oi87U1pdDUEpddKG
 sIHHZqwfI0zBRd7tuPWTKOeXYJJcvRav5/nzWgkvtYA07GU3qJqYK+2UjxuuV3BGRTV6glNSEap
 g6BFKV8FKcVSp4IvvvyyHhBTCaKXXsUH6smHHtUkxSion3o7+lbIsqivz4emEpiM0fdHXCGS9yM
 x/zcJDhuMijPxdyQ==
X-Google-Smtp-Source: AGHT+IFptSoZ8G99WN3dHjBeDAeIyz4SJOraVQnvtGsAqXt2l2bIs0sx9GJpO4J8UfgcAlpT7jU/VQ==
X-Received: by 2002:a05:600c:4e15:b0:479:3a87:2090 with SMTP id
 5b1f17b1804b1-47a837a0478mr22853945e9.37.1765378213129; 
 Wed, 10 Dec 2025 06:50:13 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:62e8:705f:f7a:c7b0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d7f778sm56595235e9.11.2025.12.10.06.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:50:12 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 10 Dec 2025 14:50:11 +0000
Subject: [PATCH v6 1/4] target/arm: Enable ID_AA64MMFR4_EL1 register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251210-jmac-asid2-v6-1-d3b3acab98c7@linaro.org>
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
In-Reply-To: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x331.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..2ba49d8478 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..c20334fa65 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
-            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,

-- 
2.43.0


