Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8E1C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbH-00052b-3r; Mon, 24 Aug 2026 01:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZY-0002Z3-0g
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:16 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZW-0002Ok-JP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:15 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so3372986a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550613; x=1788155413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/TGr75vkp0br2SHR4F1+UQxBkhDhZrz6IHZEj1QXJE=;
 b=o+th2Xz/xn5Sf7+MFfSePex/VOAovszK6oYjrfg8hYG+/LaBhJH5lD1DKURHlqjKcT
 6LrcM/J2xajg6QTSgt3Hk0W8aNaGm5/SeWtjDzxIc/b16JucBfwqO4yjKgnJ5+6sEJHf
 jr4UqafVgh3b8CfGHyDggvzvpRMxv8YC8NMvu64TIfiZclxJQ/jl4umb1ZMpvx0py9JA
 1y5rR6XI8uGMJ1xXdS2EWRzv2AfKe5Jh2FB/3itdhLBZ7ac58jwnBkiqP93Ms2l1jsgA
 q0SDokQ6jz9aHRSc3PHHbp2s4D+/eh2a+nXKwe+1MBljfL7tm+JelSjFxd1KkHdK/G7L
 fHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550613; x=1788155413;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2/TGr75vkp0br2SHR4F1+UQxBkhDhZrz6IHZEj1QXJE=;
 b=V7r3cx/WZgM7X7JbCbodSps4HhpojjKrA9pkJg0Lf4Tm8nZcht3WlLTdUvfBgKSZL1
 /6v4PmxJjRD4xw7TxtaZh7m1mnF6NSRJ1UAopv7RdT91/1RjS51QH7tmM4xQi56C2LtP
 58t864JDC6URJXSVCHVuJKMmXvvZuJ+QM57vzgf4RcpuSF8KccGnXpoarUoA+Q59ox0I
 VdGm2rG9uFPA+mwjKr1f8yHCaVeNueahouDsGqrqmOiE7anxN3l0P6RVqqnGWUwa3FGw
 cKmvRS0bGOU9f5UWCO306MtSUMbF8K8njjCfpY2ulwBNLPEIx3nNEqPrNHpAcN75ILzk
 1qnA==
X-Gm-Message-State: AFuF++m5x8WBYssgtImiEQqdPvuLl6g+8VfyEBxQSBlkpSVsi1iFnhZs
 w7kJ3vg6S2WbwT2kMoxSpawpFKs9HqmXxR5Dhm68rUg0zczlBSLFi2/kP/hgTw==
X-Gm-Gg: AR+sD13+0OWttxw8ox9RJihAY/pdmklIcmQd0YplhtseGW81+Ku2qHy5pMHgFoqVgG8
 P7Gog1BM8jxfBw00sduppPxWN4CyW4KnhyDT+jfUz90E3i2EjrIr2ITRyiWW70d7+DbFqRqp8Qt
 pery2u4KFuU/1/JaZyfQqsAo1mRR5+zVt6cKpQM0YzFJx63tEi0hRh5c2UR4HS6YD/GFuOZgQVd
 4wgppS55F65ylxqQWhDa92fG726t7wpw2qLkNQx/ZSYp1R8n+W6mQvvWZdvrDPKozC9mzwsopJ3
 F+NoaujjW2uHceKftgsaUxQtcHPj6/JALqgKZS2VjwsKJRKamO2wE8J1x+InE5TknFdL3QxP862
 MvwTtVu31zTrWqonNlG7WG+SCFDMyTWq+/7262cixkZMeIDwaGho1B39z0ce2N4eSZop0CCCM7S
 rZZta2aB5iE2VVRyXsBAAa7YZYjU1tNiNHLjI0OEO7n0gHGj80t+EozMkdqi31rCSZwq5bEVa5X
 5iglw==
X-Received: by 2002:a17:90b:4b89:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-395deeae6e3mr27425563a91.6.1787550613076; 
 Sun, 23 Aug 2026 22:50:13 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:12 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 36/96] disas/riscv: Tidy dec initialization in disasm_inst
Date: Mon, 24 Aug 2026 15:47:06 +1000
Message-ID: <20260824054806.2790041-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-4-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 012f90fce6..986dc6b752 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5441,10 +5441,11 @@ static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
 static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
                             const RISCVCPUConfig *cfg)
 {
-    rv_decode dec = { 0 };
-    dec.pc = pc;
-    dec.inst = inst;
-    dec.cfg = cfg;
+    rv_decode dec = {
+        .pc = pc,
+        .inst = inst,
+        .cfg = cfg,
+    };
 
     static const struct {
         bool (*guard_func)(const RISCVCPUConfig *);
-- 
2.54.0


