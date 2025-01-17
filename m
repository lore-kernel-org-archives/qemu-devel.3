Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C5CC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfL8-0004df-D5; Fri, 17 Jan 2025 00:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfL6-0004dF-Ne
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:16 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfL5-0005tY-7R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso31141105ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093373; x=1737698173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9MI3wwvWzZPtm9HfZbzVXJ1epUGZtSKbQl6ZaMiUfI=;
 b=WGhfSDwvmWNvcfqAtFM9pCOQbfTdcb1ZuExdVFxzlMmBwKw0InmQ8eO2KNDrJL9naC
 Ty6K+h68M+wUhgRwYCmX4h/ua44MsH+S0u1EnVvDSK1IgzzwGxSS9pozgpDhbD3M9C4o
 kytXUJmqnGtG6qMAYq8qoNWFzK4BLzfcI0qmRSRW/MgmKghBKbpFTfr51QQFMDDq+16s
 9jakyoqZOKOwgKcDTpG3fQJ6/c/GH7UMmrGcJrBc+ajHeI5sDwbeNJMKhnzv7WnA9cCt
 ubbcQ5YybUMes5M0o5CXHIWevi0ZQUvofd8sLa0u0FRboh4Bh7m8oOG1IzZFcweLttJA
 LU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093373; x=1737698173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9MI3wwvWzZPtm9HfZbzVXJ1epUGZtSKbQl6ZaMiUfI=;
 b=wUd8W3Wh3hwDprr3sFr761VOYqA3/i3I8oplk9ypg9TBrCzEdes9QSoIdHzb7rRRJx
 9QOl8xNLnbe4AQ/3VI1VaRhWMhyTDyjcvBnec8OoI3Y8xifdw13bkYU9sLrImT7xb9VD
 qNWEtYqiUYR8guoV7H2PNLA11T98yn1O6LXxCo2Z7mpBzfuK7JyP+QswSlANhRSdeMG0
 dIJkehqQoFvJAktFpRWP/XNFCyhxwjfv4mojAHpGv4gnJQggam9/WTyn5lKchX+9DuEU
 pPk1VrN3QUZE3k9TuTjC0QwyJCGwcIwgBSAMq181kEPvPpS4nEJ4P7C1JxK3N/SEP9Hj
 2KIQ==
X-Gm-Message-State: AOJu0Yw1Qf4dPiZP7ZMP2zm4rd5hnqrfwTtwT08skg31brJTuKImQVJ7
 d4sp1ImQ527llwQLT8A1OXBuiuOijnQSQMwWKiE0JFPTfRs4+NUvSRNyRA==
X-Gm-Gg: ASbGncvHV3SP7fOd0BJ9+9+eLIihdbzRObTFRHmt5r8Ys9/T+cti247klpGqTahg8I5
 vTUCygH7O85u93HK6Uc8a46WcI+cEv7G5ECwHyHAf/4TY8TUkt7wAC9dk3W/Rhq2hEa/lt81zVK
 rYiggrLs098nzT/92Etb7GuKEkfbxP0BIDL353NsIvtBGihvkhThLLKCeBWTi3ozCs/iY2crGAx
 VioAtRe+cMcNpzXriLhQSFoEu6/7mNAIQSFNKIqEQxELXEaFJD3OLJZ1B5VvxSwsvCEBUxNUfHT
 wXO9ILf5igRiQi+zirP68p3071fOAsdbDi283bcTRZXlutF0UNNYrBaUG5Mg
X-Google-Smtp-Source: AGHT+IHoU5zzIK9SuE1WJs1x21DX6psUM4dzF1b6R6oMkXV04wXOKohwzjDdl+by3Xz31T0S2MPYrA==
X-Received: by 2002:a17:903:2d2:b0:216:2804:a241 with SMTP id
 d9443c01a7336-21c355bc154mr22134645ad.37.1737093373448; 
 Thu, 16 Jan 2025 21:56:13 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:12 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yanfeng Liu <yfliu2008@qq.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/50] riscv/gdbstub: add V bit to priv reg
Date: Fri, 17 Jan 2025 15:55:05 +1000
Message-ID: <20250117055552.108376-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Yanfeng Liu <yfliu2008@qq.com>

This adds virtualization mode (V bit) as bit(2) of register `priv`
per RiscV debug spec v1.0.0-rc4. Checked with gdb-multiarch v12.1.

Note that GDB may display `INVALID` tag for `priv` reg when V bit
is set, this doesn't affect actual access to the bit though.

Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <tencent_1993B55C24DE7979BF34B200F78287002907@qq.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index c07df972f1..18e88f416a 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -213,7 +213,10 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        return gdb_get_regl(buf, env->priv);
+        /* Per RiscV debug spec v1.0.0 rc4 */
+        target_ulong vbit = (env->virt_enabled) ? BIT(2) : 0;
+
+        return gdb_get_regl(buf, env->priv | vbit);
 #endif
     }
     return 0;
@@ -226,10 +229,22 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
 
-        env->priv = ldtul_p(mem_buf) & 0x3;
-        if (env->priv == PRV_RESERVED) {
-            env->priv = PRV_S;
+        target_ulong new_priv = ldtul_p(mem_buf) & 0x3;
+        bool new_virt = 0;
+
+        if (new_priv == PRV_RESERVED) {
+            new_priv = PRV_S;
+        }
+
+        if (new_priv != PRV_M) {
+            new_virt = (ldtul_p(mem_buf) & BIT(2)) >> 2;
         }
+
+        if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_mode(env, new_priv, new_virt);
 #endif
         return sizeof(target_ulong);
     }
-- 
2.47.1


