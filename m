Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136A6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZB-0007Ph-Tq; Wed, 20 May 2026 14:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYs-000798-6F
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:31 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYo-0000XL-Tr
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3664df30f53so3098544a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301345; x=1779906145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTDmKEyCFm+XxdlQgOIFxPuknFZ6MtDmqSm/llBSgKc=;
 b=yAVv0ChpuPxqN93A4jgVAXeAE4EEebZhyaroV9WyljEpMW5esCrrchF35A2vVFDlYD
 sBNyHE/n+WpXiPtfJYQMuByzeru7tW4nZw4iCEWYDvkPotb7wCYnYvdUSbzL3/pa0NPF
 AAPYSACF3+PqE4Zd03ufg/UAPm0uaYpGoHUPIMKlzlKmRuGLM28coTOQraxfAplPl5Lc
 DqmbSs9W+Tu5Wt7kQjtdSATzzzQDB33Yx7YO+9ydRH6My1I+UHzM9e3auOpzlJPs8Rxz
 vyqy/8KOZa63tUGgBJFvok0hP24qJBX4VrGAF9/LbH7mn7/v+JubRltkROUc0q2+DfT6
 g3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301345; x=1779906145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mTDmKEyCFm+XxdlQgOIFxPuknFZ6MtDmqSm/llBSgKc=;
 b=OBBX4EgRn7kotei/BJ61+bbxG9ZmfQl9c4BSQgUJ553WX587W2+5kJM3Z8hYsVAIaD
 kENtgFD+Nw18KTK3DgPTMuNNRISKQ7U5jMsdYU8ZqZP/OQjf8XQDRtgPbWVOSiNo9WTw
 5gfN/AqlTuQ6K2v1zrO5mKdi19r1cWlf6x0GmffztV40sGV/NznXuEEEcczUyBnp0BUI
 FidHRtX1MC5I2Ggn07viFIczru4L6GXyTYtlp30JpGrtM9mXpMNwlX58xHTMI+iIqWmb
 idmcOWZ7SlIreo/V6Kcs6kw5p4NhBVd0qmAmZYRF4iZn1O6vszwY1F/wLwW76/tRdpjk
 1c4g==
X-Gm-Message-State: AOJu0YziDw46C5rE2COaROy1LxZD2JasksfJ/lDPB5EJm3g69CZX8h/9
 2egWW25CPgKaW85tFCzx2fNPcT2Z65o4PckDY8RGgKaR7ElKc81N8BkyKHQRnuwXM2y8dRvflEP
 ez0v1Tpg=
X-Gm-Gg: Acq92OEnSQiqRPpjMy7nfU+b/Yda8gWlW/hYt7wn5L1w3EQMzI4Xt/hHdg8P35wC2R3
 d9T/MM6IOpZa9+v6RyJA23Fnjo+7xZ7qHt5ktSOqpU48eqm/XaGi7OmMWUkQuuZxbkHFDmQ7gZG
 7XGGyKniiRtSEfSFFxm4YX8A8geJdgQIYQaFY67ghod/RhvbGMzTntAHEvY4Ja7qSvFUDNECYGq
 2228iCs8qQZ+VHz3vXTlfdbx5kxfd5AFOzcSvUx+D+lkRmfUSElfWtoX9PKn5DsRiT/EJbrcwKl
 /725ddMJuuYQew86M54WZQk+xeJTmxf1BJRZdG1QM1ycdmqkuEeyhoENIRMSy+048UPUko9C3/0
 9vuOlzz3RiwZSziSl5mUQ6+kJoLYyJRbB4KMwQwhwX1glljO2nsMCCFaNDK5em6meZTxf+g6P+R
 53GdTa7yjxb9FFp8JUC70+dwJBC/vK
X-Received: by 2002:a17:90b:5483:b0:368:b692:eb9f with SMTP id
 98e67ed59e1d1-36951b8e50fmr25043320a91.19.1779301344973; 
 Wed, 20 May 2026 11:22:24 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 15/64] target/arm: Dump FPMR when present
Date: Wed, 20 May 2026 11:21:24 -0700
Message-ID: <20260520182213.872945-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c47b70ac69..868ba1bccd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -969,8 +969,12 @@ static void aarch64_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, "    FPU disabled\n");
         return;
     }
-    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x\n",
+    qemu_fprintf(f, "     FPCR=%08x FPSR=%08x",
                  vfp_get_fpcr(env), vfp_get_fpsr(env));
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        qemu_fprintf(f, " FPMR=0x%" PRIx64, env->vfp.fpmr);
+    }
+    qemu_fprintf(f, "\n");
 
     if (cpu_isar_feature(aa64_sme, cpu) && FIELD_EX64(env->svcr, SVCR, SM)) {
         sve = sme_exception_el(env, el) == 0;
-- 
2.43.0


