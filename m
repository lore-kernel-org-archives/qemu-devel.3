Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B23CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpt3-0000b0-IQ; Fri, 29 May 2026 01:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wSpsw-0000Zl-BA
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:35:54 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wSpsu-0001UI-1P
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:35:53 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e61da76fd9so4460974a34.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1780032950; x=1780637750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKoS/s0xNHyy9nInwtNN1QXE9qJeNwqmmPW0cDexGxw=;
 b=D28esWQzimBlixKGCzgG5h3I2KF8en1GCmRvhIxkvCdggPBZ2+aTeHB0cDM0/VPq11
 IeIBDMJTG56mhgsw0TEOVVDPsjWKWMtSaj8z9ml14YTTEnSaDJ2bTYpcAWs/u9bgTYPu
 VTznwQ3jqR45vfqQdEtEsOqlK9qqwLvwDxxzyEchha4oQ7tulgm+XO0rMHwUuHaTmUJF
 IfRCWMnLhRuVyoPbGMuMHWKrsZhy7x+XuxJy48DSjXpovnrJPG7CaCC5v3L0Q2RmSkR1
 qI2FEDt2daPnZkDBru1K9GvqVya6qLg8PSXqdOi41ZBP1pNrb3BeYFkz2W+zE3Yo3daY
 rctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780032950; x=1780637750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKoS/s0xNHyy9nInwtNN1QXE9qJeNwqmmPW0cDexGxw=;
 b=SP0jMR+HVBR2DmyIdFEKwrg2Pi0QUxxTI5ArrZTnNAU49X+PyNgnVKQgAhaD4FxMlP
 nwWYTSWCcUj5+t7M6BnrmKtBRUP9DY9i+n6uzY31cMh6/v3IBlVtIb/yiVunMk0W+JG/
 bEzVDG7JJ6JjaI3vMpi4A4C9EuFQqhf4JOa3kQU/syr26FxbQlhiIi2CxViyUKDqaeOe
 VeU2zZpFXto4OOKB2r74qp73MfIvI7TJFP0lraQJYieAmLLdVVHS/LLhGnasmb7ILzyl
 +yjxYE4nULD6BNcyIVT1yvS+ampYT2HHXM3nzKhGT6/WftAa6pUv5hLQrplj51ZTG8w4
 GxiA==
X-Gm-Message-State: AOJu0YzON5J/Xi5jqBijP6fbE/YU9PrvrnP8T60ruWKhN1ph0xkWlJwD
 Mcgw9YA/1OGKTg+MJo6dMGkHIN/xdAPIcFSq5NP4b1V7XecoQJaXr1viIrmPj4F5HXga2gePV41
 QrcJfZpI=
X-Gm-Gg: Acq92OGpp4/ShliI+qmwqedY+6qip21ZTKXn8CIgOpcUBJ4p/QWyUt0U6U5vdcPFFkc
 cc2u3akZmYj73Fk9iYTXAPVKTMn5/AFUo5kAmQqgV2sCPfEWf8j+J6nSoOsbEbt1QMQfSA6GrMm
 wqarGPsLxDuLDgg/A6SR80+gdcucTPwDGsT+E0LLe3HStL33Qzgd/GWhh8B1XSOgZMGHSDC/qCJ
 fzqmfKe1blq4QNI0z3LmEXBr24w//Ori9sA3asVQPi1+jH1VpxlF3J9lb0a8D9VOipzfBNvmDQP
 tbXRh5xdJeue1D2H3dMvfb/n5j7Soo8YOmOTuBdyB/rkYvpCOCyMrc1whrevpfuKc41DEI0zrCN
 ngYhBfrZetzOTk4+VGuy85iNBzPJ70RU56E1Pcnauho5mv6wB78Q8Evut+YU1MOngJoA8pMysth
 gXIm2y9PTpARZnPNvkB+VawmMGSLJ+lfsYjBNpnVtuuZv0E3nUbIRbFlEUo6k9gEJzwX7K
X-Received: by 2002:a05:6830:82b3:b0:7d7:4639:43ee with SMTP id
 46e09a7af769-7e694c1f662mr1088973a34.3.1780032949912; 
 Thu, 28 May 2026 22:35:49 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695d4726dsm742428a34.19.2026.05.28.22.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:35:47 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH 1/2] target/riscv: Print privilege level and ELP in
 riscv_cpu_dump_state
Date: Fri, 29 May 2026 05:35:18 +0000
Message-Id: <20260529053519.1224019-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The privilege level and ELP are implicit state (like virt), so print them
out.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/cpu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 952e34fdf5..b38ddc39ea 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -580,6 +580,22 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
     }
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static const char *riscv_priv_str(uint32_t priv)
+{
+    switch (priv) {
+    case PRV_M:
+        return "M";
+    case PRV_S:
+        return "S";
+    case PRV_U:
+        return "U";
+    }
+
+    return "?";
+}
+#endif
+
 static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -588,9 +604,15 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     uint8_t *p;
 
 #if !defined(CONFIG_USER_ONLY)
+    qemu_fprintf(f, " %s %s\n", "priv   =  ", riscv_priv_str(env->priv));
+
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
     }
+
+    if (cpu->cfg.ext_zicfilp) {
+        qemu_fprintf(f, " %s %d\n", "elp    =  ", env->elp);
+    }
 #endif
     qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


