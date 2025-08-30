Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555FACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNyT-0006Qb-Me; Sat, 30 Aug 2025 11:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERP-0007Um-OS
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERO-00051M-7b
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-248de53d12dso16179395ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532873; x=1757137673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5dGKmFEigKAhdoQrKYKjmoib66tUCQFbD5Z0usNefI=;
 b=AG5NFcRrIsDwQou6sr6EnNvPiFQEZRSLZ0imRb/4ZlfS7j0cByJMMI2+Om+i5RJUlT
 P84Hrb/6UP955qrnawHH8LMxCHUvnUOgOsolgQILPed/sMQ9CYgVRTsgQsWreCx5tv2/
 N8ojkg49bDg+QjDVqorntjNOsH34Px5gVarmkwYPsEHiR6g7UOTAav10WyLnIo4QY743
 nCl2OE3hjCne7HBiC4J8CNzaaAvh6CxCVe4+lidwKT8ljiapjMCE1/cu68GqaWrjklkD
 py4inNlBc3Piwnz68ZcYNfLKwPg+23WsczghDNAM+3fGR2W8IaIE28tI3SjWIsky6lE3
 J3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532873; x=1757137673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5dGKmFEigKAhdoQrKYKjmoib66tUCQFbD5Z0usNefI=;
 b=kRHLL258pk0w4HEH2A0zYuPUsDyxONz+581PYSua1COb+4r+hmJOx6BEORfpDomWKx
 JSfnMVOAgwiNsbZSgagjK3MFdVlN+t7i2nqYRI/3y7hLpzliDjBjkABg3iZrVqBCC5E0
 V0Cr77pSij2WAR0+cwVOBOjfM2+yC0hX2hnX9xQg5JlqdthAmiX/+nsgJSiRIpIIFAqj
 amCtYYNt7f2CWWZGzDLqZem7epdkNy2RIWKWR0yRqsX2joerSFaDXkLWm1ODYOjCkgQz
 MuZGMcwp86r/B9NprTKQQfTJT3U7QQd5VKwE3E1fxZUfQ0UUuVFIjjDN2AoXAL/W7sCE
 Q0Tg==
X-Gm-Message-State: AOJu0YzMNycmDMnVo9H5zjClWpZdlYwxfttiO9zcg4P3/ej6003JJ9nt
 ABjWdwPlMDo8CorVLiZsgRnx0dYR/Mv+SkwJ9P2h0opz4wW0x/5aBFS8M6MVvpoCUbbD39nrsHz
 ZqiQ1Er4=
X-Gm-Gg: ASbGncubAMWvCnLjqf/Xj9fozgx0pFaA5lXwPm1qlQDBAcSmU9FuVop/gSdA0sZ16iG
 2Zi9HsyCBPk5Upskzrwj1Z2GpJtRBGKU9ywLYwCMb/ugevOwXJdw98DICyfE717XuEyOOS342fm
 dbkUUZ9oQ3FzwiAeFMFUPegurd4f8h4cAN9IMML1MujufX2CBDSYkYTeZcOvsPO5T3O8a57EZaf
 Wr/2xGe5Oy0AbYTbNvlyd8ucnupAhrQ6xHiJeUj2a8BvLkjeyPf1yhWSdYq9nfPa6mpRtLaw3mT
 Hfun5AvjMpT7elvq5oM2fdMIoGPz+jbBarsRw+0+k90HrSPugtVraSVYDXo7hPBFVy2PPb/CYTh
 3jvWKSgM9yPPT1m8VYG3mfksAhq2UMPIVMduI0h1n7FVOgNp653+iIuq+08h26Uk=
X-Google-Smtp-Source: AGHT+IHpwILMW1la4GLgqESLwjm3qtO7EzCqTpBu9haw6gJD6o3f6ILGnCbECz1Y/fdEmAclAIAwiw==
X-Received: by 2002:a17:902:ce8b:b0:248:fc2d:3a2c with SMTP id
 d9443c01a7336-24944a0e28dmr15210635ad.26.1756532872717; 
 Fri, 29 Aug 2025 22:47:52 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 70/84] target/arm: Load gcs record for RET with PAuth
Date: Sat, 30 Aug 2025 15:41:14 +1000
Message-ID: <20250830054128.448363-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3ddf4bb018..95d9842a4f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1898,7 +1898,12 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     }
 
     dst = auth_branch_target(s, cpu_reg(s, 30), cpu_X[31], !a->m);
-    gen_a64_set_pc(s, dst);
+    if (s->gcs_en) {
+        GCSInstructionType it = a->m ? GCS_IT_RET_PauthB : GCS_IT_RET_PauthA;
+        gen_load_check_gcs_record(s, dst, it, 30);
+    } else {
+        gen_a64_set_pc(s, dst);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


