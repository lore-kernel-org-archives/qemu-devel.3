Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B63F43699
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDhyG-0005Uu-Vs; Fri, 17 Apr 2026 08:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wDhy4-0005SU-Fu
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:06:42 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wDhy2-0006eV-MQ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:06:40 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-68be75dc734so155827eaf.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 05:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1776427597; x=1777032397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D7Rc6tnNGYnMJDZo//oFhE/boIZ5aw0YgE9oBeIZlIU=;
 b=TWVNkpxkRsuGqcH8Lk9l1/9T2z13e3eXhTWi8Xzzwh02L0nQGVc1kA7KYVZ9e/2IbG
 oo3bCovJotSsMr4bJD8BvAgLemnDJqwVIBifs5nNarmZEk5vqWUFiI/7UWUiSkjv66f3
 hmwfEgCG+q5q0LDZKE/sj1IpqNQt/8y8koHplW63YtfXbLhX1dwk6t2GQP01huxaiKhn
 48Sx0FV+rYHID3Pf5uJMd+8xBKsdOnFnGb/fHqaTeeBl11/hUWnieSqf76I5QPhYmgTB
 A2zHqPU38H7fR/3/1cpmwEurdv9C+F26yfbkyb2Mcu5EpduCwzA6/9mdSkxqzoPIT2No
 jZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427597; x=1777032397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7Rc6tnNGYnMJDZo//oFhE/boIZ5aw0YgE9oBeIZlIU=;
 b=RbQLkuooVvalUz1mL1fdG66MJDYYmcAutHrJ8Rkul2Yhx8tHH7XNM/SWaJ9gVKoLbA
 nliuEWg7btlqjGLPcFykFAlea0Yf0xtsMEEz92p2WXR0U5Sgq3V+hIoHintoPDahygMC
 DnwHr6ZoLGYIJx27QQdys5+iKjcfai68IR8yI8NQ8wDs3IWcStOZlZrIa3DnfxowoI4v
 7GBmLpxaC6qPkBnjY0Dsx+lIgjh62iYik4NRbWWBxtQ7mH1sTFbKEkWvah4ZJ04o31VB
 wGaA0i24rj6r2u2KNnWi4VR6AuC7PwEjuuET5SkNiYHSHvYmJjOf/Ae62kUVWK0r8012
 zaHQ==
X-Gm-Message-State: AOJu0YzSNFpYbf87jekib+sxyQVXk3kH8KUubOa/PSD7JBp4USVkK5gn
 ayVN0R+/3xqxA9BeRuooM3VWaU2moU1BcLVsO02FsP8OfqN79i2F+zZHdbXfCSpUwiFpIigl0hu
 hiO+xJPk=
X-Gm-Gg: AeBDievy6qqoGe2WOsi5KYWG9Gq9KSyzSF68qHkd6m4bI2iCrNm7DD6A/TBnle2VoD3
 zJmEdpZNZK3g9JCfF8+qKnXz1dFk0rfa9Lllg6MfgiaE16uL3o7Apl8gMK4lG59rkmE1I+vBYNp
 XjtDu2dwicA5fHWfzQxvZrVsFBBnumFIw3gYkxi8VNHgmuNilJ9wj75PxE8nq+CJeE04FqI09ub
 Cbv6BJgfVYhMcdo+iYQuYLENI9Pp9B7PNRoQMvF6720s9lpDlsHpD/HKdIRluIxb20dofz44Gjl
 qaPITHdQG94CKXea1Q/ijTJByfQF1Pkf1U+4yjMe3KTkmtXoMm8qHq35+FgoN6hcozea0r7GQFk
 Tsbhss27xvWSk9JcOXfsz+X/SrE30vaHz+ncmxU/FQlw3q64YLRd3UoGSmT4CBzgvZpvQ17+fBD
 E43PkqSDEcUUXY26F7ETrLUEQI+ZHBHwDvUTxUVi9m97BlHxNdExZp147G55FDhws++6fnfOPBZ
 jCp7g==
X-Received: by 2002:a05:6820:3092:b0:692:9c90:8e9a with SMTP id
 006d021491bc7-69462f2036dmr1185825eaf.45.1776427596686; 
 Fri, 17 Apr 2026 05:06:36 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69464fe4084sm744062eaf.12.2026.04.17.05.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:06:35 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 liujingqi@lanxincomputing.com, max.chou@sifive.com,
 Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH] target/riscv: rvv: Handle mask/source overlap of vector
 reduction instructions
Date: Fri, 17 Apr 2026 12:06:26 +0000
Message-Id: <20260417120626.77415-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=antonb@tenstorrent.com; helo=mail-oo1-xc30.google.com
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

Masked vector reduction instructions must not use v0 as a source register.
Check rs1 and rs2 against the mask register when vm=0.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index d9a0027e0b..6e8d32636e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3046,6 +3046,8 @@ static bool reduction_check(DisasContext *s, arg_rmrr *a)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
+           require_vm(a->vm, a->rs1) &&
+           require_vm(a->vm, a->rs2) &&
            vext_check_reduction(s, a->rs2);
 }
 
-- 
2.34.1


