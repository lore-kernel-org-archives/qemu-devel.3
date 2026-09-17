Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B28C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jnr-0002XV-ID; Thu, 17 Sep 2026 17:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnp-0002X4-15
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:57 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnn-0007aC-C6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:56 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ed6d6eso811395ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681074; x=1790285874; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MFRCYfHDHQ9HYh9CXi1GX7LcZ2WDioZ1guxkF49zPWA=;
 b=S0YlJM0XRX5YX97TyGyeN3SRqA3a+nhPJu6V2CWwJiKLv0YQwbcoTOmcnZ4akMM3SU
 4MHMq+loRCgsgufoRmZFH4KABjFG9SSqXy7yCwC7ynQ9uDAU9qN8EyOsJT+NjREv40BF
 SkFwYIOw1ICbX/WRq9fyG1UpJcLEj8d2OGixSoU3auMYfnUAzF00w5ohjO7CYFoG7wNl
 RMsqqC63pLfPdsvCp9zzzmxOUuRFybolzkYDcPxV5eQFTuFzvMPV0kIJgeqGS4Ms1QSt
 SFXIJT4Imp7J+5ZzlMC9+HnWOv+wGHrjVckIPbe+MuZwGsui+iw1uzt/ey0uSitI+Xn2
 v05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681074; x=1790285874;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MFRCYfHDHQ9HYh9CXi1GX7LcZ2WDioZ1guxkF49zPWA=;
 b=DDho1yGuP+x+f38ZrRkgh0tsk8cTuB7tP7iww8OqC93uevCSRKFywEkT/tqhz8iMJj
 kvJrAkzEPElz8z0qxVjD7++PgMHiwkUZhlbzHntc7sXCoPPHN/K4jdTllascpgKKS9ct
 ZYRnX1ADbz2RGP0FYzzmnyeEM/GBFZ5H7UtzyIk4+d1jDFqJnH6cJM+1fvA9b69hrByc
 WnSjwG88Yo9WLvAoEEm+wK1W/zejR6Vw+P+CPClADqWDdtgJ6bA1VOh0BpDgtk6ExXCo
 F+IGELxnjzr/3g4cilgISoQrcb4IPUEUlfLab1k7u6phicvNteTxicJH+GkoBlxOXdkB
 +zXQ==
X-Gm-Message-State: AFuF++lmJOdMFLyMTiVYzToV/4E6gdVFeMVd467cykXPQAmjrRIlH9Pl
 1X/cgBlK9Ol5M76ebuvY79j8c/hvZaCQ2+JAkHvGUYAHm/MulDhol+XyLpuMyCfY1AeQTzAs5Xi
 dclU3z6I=
X-Gm-Gg: AYBFou2ajLq9BI/PrPeaNFF7rHOdjY+OxCGcBo1bKKxlGpWsABdWNf+TWsjdgEJTcbY
 FDkk6pAJ09jJL5O4uAwxx2RJIEZHM7rzvRfGk4+jLn8u4unGhuIDAaY2GMYVLOwVEVfOrCp/HNo
 Ed3OUber9HYVt835qS4oPJJpVx7JQ2RX9poEu6eXol2URzDQsLC2P1y9lu/9aLrmre3MnSjjzEu
 b8sd6oHp5lOEHmIFM5FK34DSBgUvRze/FobJfwzihqYMCtAI1zvCS/OS6jfjyAgavP9AVEtn/8f
 v87DtKbj2Y25IYRj8vPwDsuaV/NAqZgJYkaWx+czkIw+LX9W3Utstysh8zQajSRtR/vXKz07Rt/
 C2YDth4MJUDVXu00XwVmwpJqSRXRqRRZ04WR8ihVmPSEoDqno+50Mv2fKkFO8vJrVElVgrosIoM
 2sVxx1D3Afz4sU3TotfzGUyj1zhDNVXClUueyu8qKcXBYStjYkvgdNt05mCr+E6T4sPDToIlLAh
 PoF98c=
X-Received: by 2002:a17:903:bc2:b0:2dc:fcfc:bdeb with SMTP id
 d9443c01a7336-2ddb1b9852amr6025435ad.22.1789681073520; 
 Thu, 17 Sep 2026 14:37:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 01/15] target/s390x/tcg: Convert op_ld8s to op_ld
Date: Thu, 17 Sep 2026 11:37:35 -1000
Message-ID: <20260917213749.36756-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Begin unifying load operations by storing MemOp in insn->data.
Start with op_ld8s.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-2-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 target/s390x/tcg/translate.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 1ea72248a6a..be698ee0022 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -481,10 +481,10 @@
 /* LOAD BYTE */
     C(0xb926, LBR,     RRE,   EI,  0, r2_8s, 0, r1_32, mov2, 0)
     C(0xb906, LGBR,    RRE,   EI,  0, r2_8s, 0, r1, mov2, 0)
-    C(0xe376, LB,      RXY_a, LD,  0, a2, new, r1_32, ld8s, 0)
-    C(0xe377, LGB,     RXY_a, LD,  0, a2, r1, 0, ld8s, 0)
+    D(0xe376, LB,      RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_SB)
+    D(0xe377, LGB,     RXY_a, LD,  0, a2, r1, 0, ld, 0, MO_SB)
 /* LOAD BYTE HIGH */
-    C(0xe3c0, LBH,     RXY_a, HW,  0, a2, new, r1_32h, ld8s, 0)
+    D(0xe3c0, LBH,     RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_SB)
 /* LOAD COMPLEMENT */
     C(0x1300, LCR,     RR_a,  Z,   0, r2, new, r1_32, neg, neg32)
     C(0xb903, LCGR,    RRE,   Z,   0, r2, r1, 0, neg, neg64)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 1b6023168bb..4a0573820d2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2749,9 +2749,9 @@ static DisasJumpType op_llgt(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld8s(DisasContext *s, DisasOps *o)
+static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_SB);
+    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), s->insn->data);
     return DISAS_NEXT;
 }
 
-- 
2.53.0


