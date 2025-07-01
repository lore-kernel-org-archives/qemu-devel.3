Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346D9C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYIH-0004aF-Gg; Tue, 01 Jul 2025 06:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIE-0004Wd-JF; Tue, 01 Jul 2025 06:32:51 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIB-0002GN-OL; Tue, 01 Jul 2025 06:32:49 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3138e64b3fcso2196931a91.2; 
 Tue, 01 Jul 2025 03:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751365963; x=1751970763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxWORJNR5cWeeNL6wFpxR5xESZhNAoZLn5RWItiQ610=;
 b=XE1LMpodA4PFMcFTZpLfg/uH8A8ZUmy8o+3LLqsLW3MIatvQb+FrRFhTPfmeMJb9QZ
 vUb/6b45mFDN15M4BTPIYH/kKFuOLwu0aKl/bbB7gUyNum/AGCxk4MP4Xi5yAaeumL2k
 EI127pQ4vAJFmarKfBtMhNOYd/5YzfC3ee/sIRoaKFFzrWpONCICW55JzUe7WRSvfVsn
 IIvpeRyyhmAvMYjCao1mKwGxbZMvG09ctldCS7+6Zebt0KaYPghoant9/D3HmjPCPvwS
 RRAfBTV+ksaadp3/E2dVo1+k1cy7QgKQTZ/6U2I3uKuvCI51rLV3AVO3qqQ5AMcncOdi
 2HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365963; x=1751970763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxWORJNR5cWeeNL6wFpxR5xESZhNAoZLn5RWItiQ610=;
 b=TuL0T92NMS0jliRpWBdn9ykZxyOnLPRTufv08NEHaxUSGDEom3n8rrfw3fi7v+5hcy
 N7jpHw5q8b65pLqdfzoV68+5lOD4iiNlacn8V52eG9tj7dDHrrIOG6k0qhzrYyzlvmxV
 H8eCuGoCm1Fdq+thyXzetQUidu9rF9F7A7RR+vbfsIdvuELbCMS61+OCbYyYCkMW1f94
 warNf1523GnflL1eHfCgHgsAZr0Iv3MGkMOMLuMTHL6jP5cWfC+8sSxyTe+YHbhOlj8f
 hqBR63xb8/Tb/i+8BQUaYBqHxXjFAoUTtkCvsc4+TorTaQZyJaSLZUpdLjKr04KFQAIS
 fc7g==
X-Gm-Message-State: AOJu0Yw/6zHg4G/pDDAsymBJHoE6wjexCbmh6dFC6sqsLd9mf/Eaz3sf
 iHg2w73/M8S1jNi5uugk4l2ITzGbqOZyS3jFU95UtX7vK/PaZMXcPG7RcqlZq/DvOXo=
X-Gm-Gg: ASbGncsXZYdH/0Fogkooh3eDWj2ULIzD2LUf91swvBHxLnNE73FbIH3RmbJ1vfAlqrd
 GW99plr4r8X6+IeBZWFXuYwEUJ6L30jiW2nxcbO2aUiMhdcR7Ca8vEf0lc46K/zZlsMmvmPLrQY
 dhBCVcwtCUi+d/eLoppoBr77vRBP3lC5raRIu4X/BRYxC4THPzEoUMdNoXPcpKg+Wx0J0RP5Mvu
 ky5pNnOBviPNn5oLIWRg0H9COV5+/Q0WtzotXc1QDAsV7x1durZNSY+vQN+aavHnQNmtfh2wwqH
 +LdrEwwGkuo3quOi4OheP/DyXO2zNcQ2M4fgOKY0A+FpV45VVYBsc22Vd42/yGW+IhlgZk7alhm
 2FQV89BweyzmYweuqpm1JI/8aS/4JK8gNbwUVx4X78yE=
X-Google-Smtp-Source: AGHT+IGDcxJUxgcHCmT8Qy4Y041NEpkE9gvknd5PWsVcxlnB1QJSG/k8gY7DS5awUjv9faRJd0qxDg==
X-Received: by 2002:a17:90b:4e8f:b0:313:fab4:1df6 with SMTP id
 98e67ed59e1d1-318c9280acfmr21462390a91.32.1751365963281; 
 Tue, 01 Jul 2025 03:32:43 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-315f5382f0dsm17009961a91.3.2025.07.01.03.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:32:42 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 02/12] target/arm: Fix BLXNS helper store alignment checks
Date: Tue,  1 Jul 2025 20:01:49 +0930
Message-ID: <20250701103159.62661-3-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


