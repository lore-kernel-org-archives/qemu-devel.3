Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F1CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpt6-0000cd-ET; Fri, 29 May 2026 01:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wSpt1-0000bB-8m
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:35:59 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wSpsz-0001Ut-19
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:35:58 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e6061b3fd7so3876459a34.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1780032956; x=1780637756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZWpgE7C1GVlusaJBkGbSPYhr5f5uVmFrg4V7xjHwEY=;
 b=go+TQp9P99uaz2hZK0gmmCQ3jwR+T0nkx3iJBiRgjiXJk8Mtrs1MS4lpiimMJGVFYN
 cgkPX/wgdgqqm3g9JDy8IJJ4yjEbbu/45Vyex8n0N0bqXeCJBvnEwozhWmLISdLUD9tZ
 6JON8y7yyx44IhjdO7FcvyZAYaI9dM+5V1Uv8uAaLkz7Ea1CKCM+JX1dYWMtZBF5au/d
 Vz8RTtZr2FQ1h3hh3ICnoVgDbxI2FTvdCu/smqMT0QryVh5js6vKBVQStJDUcypr6lh5
 hE/+2INNT7d0N49QeABs4TtjB7CaPvzeUxxBj+2M/yAa7diC7wInddVanUONo+FLc+Be
 1Grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780032956; x=1780637756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GZWpgE7C1GVlusaJBkGbSPYhr5f5uVmFrg4V7xjHwEY=;
 b=mODoqWX3NtuJUZtU7ZjX5h5QJBrxhDofa9VxYwwIkSMSn1GaWv/c3gdkcSEndo7Hkp
 GrqUUfNHXR8MM3bLpr5l0XcRwxlV1vQu371WSP1+evztdHaTPRJsCXvc29vJl1j6zn5k
 DjPnypbUAioTFEHEuxEg7vCg+bngsqNW8Va4k4j2aAvYdxsDuLuFBDumGD0RUApUehfV
 xsLVhRjL4SSMu1m0q3sr4R/linPabGAwP17W8pIhQrPl7YNLK0G9xgRgi/bj1uxUbCOP
 Tl6nKfbbUzkzwrrOccyCxfPHtdjrZ7p467JTOcu+0cizpEe5aQVKia7kiHJHqwAA5xML
 6zTQ==
X-Gm-Message-State: AOJu0YzVdvp6q0EgWCtok3UNuf4tDphmOC/kziEzcdrEssWSMnzrcfCn
 lzmifTsKWCpgk+rJNWjNPH4CtyxwBwQzg9HTjve4/Ari3GdT6pVqRk622tkGOb9tGEMgxPd1DvS
 jfKx7Nhw=
X-Gm-Gg: Acq92OEH+nqxagGYzaEWNAOjIUr089nzqrWUvXKldv/4P8HFZbKLfsQs8ZuF4TBcJEv
 J8xv3nW7y3+7GOeBcgJ18kAw3YjGV2HDCx16LdvoPKsD7jMlYIXHoER3HSJG4McG19gAkWBxOCJ
 qmK8ypKc7nzFjCGrVMZQWNIGDmI1/HAgYseiHaj6f1V3qN8eaQrrsqHc/4VnZu8NyKh0b3y8GKP
 8TNPnM/TWWC4kbrgS28GktW744wruoJV6LIChPEQGpvA55+VPm1SWqw8Bzkym5Z+5T0chcs7FFk
 4RucMcdMfi6I+FH3yLlEA1ZXI7sVI6Gp/29oD6u0f37NbKLcdEmfJIhETIGrfE7sK00efHgMgij
 A2OP9K2vf5/lijMcuT0YuZ8BoUouChFWDMP3iSqpFVwYleOIP5LCxgMM9mO+Gv9tWJpSX5aRa4b
 T1BazPUGixQc8E1jAV0NvoUZHqQnG3jxAcfOsA6w/R9qYayUZdOGHxpRTkZ3c564ptU+G8m5Gof
 NpjfTQ=
X-Received: by 2002:a05:6830:67cf:b0:7d7:e57a:bcd with SMTP id
 46e09a7af769-7e694d484c4mr948045a34.20.1780032955804; 
 Thu, 28 May 2026 22:35:55 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tail89d63.ts.net ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695d4726dsm742428a34.19.2026.05.28.22.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:35:54 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH 2/2] target/riscv: Improve alignment in riscv_cpu_dump_state
Date: Fri, 29 May 2026 05:35:19 +0000
Message-Id: <20260529053519.1224019-2-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529053519.1224019-1-antonb@tenstorrent.com>
References: <20260529053519.1224019-1-antonb@tenstorrent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=antonb@tenstorrent.com; helo=mail-ot1-x32b.google.com
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

Align all the CSR values. mcountinhibit is the longest CSR name at
13 characters, so use that width for PC, implicit state, and CSR names.
Also remove the redundant '=' from the implicit state lines.t

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

This makes it easier to read the output in my eyes, but I wasn't sure if the
format is set in stone. Feel free to drop it if so.

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b38ddc39ea..883aa906a1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -575,7 +575,7 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
      * to do the filtering of the registers that are present.
      */
     if (res == RISCV_EXCP_NONE) {
-        qemu_fprintf(f, " %-8s " TARGET_FMT_lx "\n",
+        qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
                      csr_ops[csrno].name, val);
     }
 }
@@ -604,17 +604,17 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     uint8_t *p;
 
 #if !defined(CONFIG_USER_ONLY)
-    qemu_fprintf(f, " %s %s\n", "priv   =  ", riscv_priv_str(env->priv));
+    qemu_fprintf(f, " %-13s %s\n", "priv", riscv_priv_str(env->priv));
 
     if (riscv_has_ext(env, RVH)) {
-        qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
+        qemu_fprintf(f, " %-13s %d\n", "V", env->virt_enabled);
     }
 
     if (cpu->cfg.ext_zicfilp) {
-        qemu_fprintf(f, " %s %d\n", "elp    =  ", env->elp);
+        qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
     }
 #endif
-    qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
+    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
 #ifndef CONFIG_USER_ONLY
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
-- 
2.34.1


