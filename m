Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F22C83F07
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvVn-0007Z2-7M; Wed, 02 Jul 2025 07:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVh-0007XX-U8; Wed, 02 Jul 2025 07:20:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVa-0002HZ-B1; Wed, 02 Jul 2025 07:20:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-235f9e87f78so43792535ad.2; 
 Wed, 02 Jul 2025 04:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751455208; x=1752060008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxWORJNR5cWeeNL6wFpxR5xESZhNAoZLn5RWItiQ610=;
 b=OnqKUPDEu0cEUxjRuYZRUx9E4koqOvlq/ApDLfCQDifZWVBgFxwEin5dguNdMUgcn0
 9h9sWqxiq6wTbBF0U5cs8heRCBa5bYpoxKgrOZ3QIwIuMXMG90ycWAsgHh+A1w8VOWYt
 XcWG+xhK4hjQ4nQRhTZTkJT4Rf6V7grMayPalCDBW/UC0V5p61q6NcmvZg7rSGmHTkbg
 3ULj9obA4uPyhE6tZtnz/y2Ygei0tEmp1Hd75R9bByXTCK+kCIChkHZPj+87WSOji7Vj
 toDICEljHVc2SkYUdI9Br1k0/N595AO1V1roBUDMDds2l4iGpyRUJ5ZOmzOeGyFtqCcx
 0WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455208; x=1752060008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxWORJNR5cWeeNL6wFpxR5xESZhNAoZLn5RWItiQ610=;
 b=QPF1Iqd4rco84rgOeiEpgmz/XgCpFDuKGjPiQ5ToNpLjS5kkAl5efc6WNkq2UoWm4Q
 AMAEb027lTfBljjZ/uKnRUogIHAmOQjEv3ulM63foeIZiosBKb0YCzvackFCP5kNprbL
 vjb1/A7JVrKhS/jiT4QWaFM0OoPzrvAomAIgWFsqtWf77M62ED9SOC26F6Q6GFERJW8J
 3wakxF0IwgBoJuAWH2JehceTY/hvm80sSC7i9PpN9YglSdPqkWGBfvKvCBWk+BDFrbLF
 u9d58AXe2KmW6wY+pYs+E2nHG7NC3N+sLGC9vySBXVnkhASf8D8evoMccP13vLEXITuw
 GJUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQnyR8dKHjRTZaUAg+HSnOZAADDl2bBb9KDVMRdnfDegXgo/3jvsz1C1XQoyXfBSFLb3XYij9MYw==@nongnu.org
X-Gm-Message-State: AOJu0Yy7ZXuRpzAYok/AqCOvVClTUnlesEod9caLU4AobzfWZKxCLkRw
 xIVhwQZG+T0JWy0OxiaIHJp/ahHf8phB4kmq7q2eZKBHSPKfLj0GtrnXoxjXUvGVvQQ=
X-Gm-Gg: ASbGncvODxZht45UJ5QigCzjNxR0DT4SmR6IT/yHfGeFfgiC+zpXWySehPuytnskXio
 hCIzGf2h1vx8IGzilrrzlvcb5D8mObzHUf7VKpEV4lpJhXioHzqYdRbqbYX8BI+4l7Ob91duKZ0
 liIlFJgr4T8BT9qlWFO3mxMzphm+ELCddDA1CULfPE47zJJYzvjfmcZlkvWxDIlM/JjtgMl85Hz
 NFh5UYWhoCAdZYsb9Z3/lPMPCYpWstx5qfEJwzSK2CJxiMJj0Ah8WVnociAN+RkMhoiXzy7kVUy
 cG8uOOiSJ2EfOhIFNg6LqSrXjhIQEPfOCBHXvUHBzRNuAkH9AfDOC0f7urS5JwF6thmgTCtL0GD
 PbnM4j4tTPA7Af4l2eMRjrw5NXAAS2aNhXYgxC573/EU=
X-Google-Smtp-Source: AGHT+IHvHNx5HU2xaNXOcLWj6xgR7jZOUnmnNeddmrZDTNSusAG2WFVC8O83sXbD6jUipZbmUJfrXQ==
X-Received: by 2002:a17:903:1ae3:b0:234:d292:be95 with SMTP id
 d9443c01a7336-23c6e56f58bmr34420655ad.42.1751455207675; 
 Wed, 02 Jul 2025 04:20:07 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb3b9344sm133618575ad.192.2025.07.02.04.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:20:07 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v3 02/12] target/arm: Fix BLXNS helper store alignment checks
Date: Wed,  2 Jul 2025 20:49:44 +0930
Message-ID: <20250702111954.128563-3-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

This patch adds alignment checks in the store operations (when stacking the
return pc and psr) in the BLXNS instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/m_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 251e12edf9..f342d93489 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -632,8 +632,11 @@ void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
     }
 
     /* Note that these stores can throw exceptions on MPU faults */
-    cpu_stl_data_ra(env, sp, nextinst, GETPC());
-    cpu_stl_data_ra(env, sp + 4, saved_psr, GETPC());
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
+    cpu_stl_mmu(env, sp, nextinst, oi, GETPC());
+    cpu_stl_mmu(env, sp + 4, saved_psr, oi, GETPC());
 
     env->regs[13] = sp;
     env->regs[14] = 0xfeffffff;
-- 
2.48.1


