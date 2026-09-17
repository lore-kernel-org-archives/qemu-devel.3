Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C32C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jnt-0002Y4-1R; Thu, 17 Sep 2026 17:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnp-0002XG-My
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:57 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jno-0007b6-4h
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:57 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d9004a1ac0so533275ad.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681075; x=1790285875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4hVwuMuu99BWPwGHzeBU3e4L/rPchl7P0/CAAhG1YDs=;
 b=PUMUSpPZH35Cs9cr2L7XJBgrcJ2OCN6cMaUAyMIyFYBTw/lJLBPnParSu2VB7qujQ7
 cuFtBxdG9EeK8+eZYGZUb8IJbAkePvwW+N3Qcdlzr4hwTDxa0s6ud9g2nKEFSgCfDqOO
 I4lH+Eu2uuTiukMP6GwuN5EhU3Tdl40lp7/mKVfDns7RB5slCvp1ujew27FytRKTN/GD
 xODtONdsAMqp4Fit63POIusHNiTE8OFn+rOxQKHwWUeMkv1J53FCZx2PYweVDe9LArVc
 Q97ssoMtU+8uGEZbBytOpZbRahkxrFA8dHs3ghdv3gf3kPJvbUZ1lB2U6UOGkSx2xKMx
 0eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681075; x=1790285875;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4hVwuMuu99BWPwGHzeBU3e4L/rPchl7P0/CAAhG1YDs=;
 b=CoqMMHIRXjrEezTLzW9xHrEHjj9jnwxnrOzQSEs/AODgt1mOKKR9NoJHSx9m0B2QZH
 S5QtIvrLfoOjrmbWhRi8sgIHK+APOxD67aX0rxQ7aezA1qT0bjJknqoWJV5KGGJoDWK+
 CltMNivTdg+tjWAOfF9SLFpcO9pG4q6/4NU1xmUEaHa8hDb0I7UM1yRj64bI2+EwayL1
 b2zLQQ5ucGqlPG2l42j6LkedQvNrpYEvmpDpfqSNX22tT8fXi6gedxCnrFHd6qc89Fj5
 n8eZX0hfNqpeVmdgIvT3RAlg2S8/7H7xHIDcCkE+3o+qCuZltWhAs/NOh0QQRe9EWEbX
 WTSQ==
X-Gm-Message-State: AFuF++mcNDuwdKolcgR4gCvvlPdrU7AI4Xqz2MwPZo1viy38j8Z1ZMrX
 9SpZNBDDwxHGc5vyTb316hfuZW+Ps5bLhOzhmeL4I4RwsieaX2N9yWOjCo51An04Qzy1ZEjw/5G
 GpimtjVs=
X-Gm-Gg: AYBFou1VE8E8ppKFkjAsGE7yi1AA2SC24f8YNMrYtZwD9sfSNzxyp/WCY0FnXKebRMn
 VtRUOYN16Q0yUb+fi2q6Fkvgzv58ZiHPSTcx1rVfH3zRIG1XP6PLSVHikxiWV87JMQaZMenmpZ8
 vWuNjm0VKEh/lIZUkpa6D9d1HMod3JazLBCthCebHnJaAkRbrAPrRqI5/afzrZptm85OwoIbnUZ
 CX6BvlPu9iyaGED4KltWGK2/IBjVhoQH/Av6Gasc7I2GGL2irraICTnO40KXvap1C1mW7ubrM+Y
 aYEkdL3JUa11E2kMBsrfJb7GcYnUTphS6bDlM/SihaU3/CPmbC6GkLzixZemvzLKe9IHBqsZnfD
 KG62mgUZs8nhDsN2DCoy6gJ64BE6aqPY92S5KlLMWJmGjZZu1UixS7zbLWyi2yhC4R74Iemv1Rg
 q/TZaB7I80G9eBhP+uOrTFYvtECnBJrO1w40hYw2tG24UwTRI/ZIutZRmGgQNM17qSsgC3fwm7a
 RZLFyU=
X-Received: by 2002:a17:902:c945:b0:2dd:ad74:ac26 with SMTP id
 d9443c01a7336-2ddb1b9a0fcmr9047885ad.24.1789681074689; 
 Thu, 17 Sep 2026 14:37:54 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:37:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 02/15] target/s390x/tcg: Convert op_ld8u to op_ld
Date: Thu, 17 Sep 2026 11:37:36 -1000
Message-ID: <20260917213749.36756-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-3-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 target/s390x/tcg/translate.c     | 6 ------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index be698ee0022..403992460be 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -523,10 +523,10 @@
 /* LOAD LOGICAL CHARACTER */
     C(0xb994, LLCR,    RRE,   EI,  0, r2_8u, 0, r1_32, mov2, 0)
     C(0xb984, LLGCR,   RRE,   EI,  0, r2_8u, 0, r1, mov2, 0)
-    C(0xe394, LLC,     RXY_a, EI,  0, a2, new, r1_32, ld8u, 0)
-    C(0xe390, LLGC,    RXY_a, Z,   0, a2, r1, 0, ld8u, 0)
+    D(0xe394, LLC,     RXY_a, EI,  0, a2, new, r1_32, ld, 0, MO_UB)
+    D(0xe390, LLGC,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_UB)
 /* LOAD LOGICAL CHARACTER HIGH */
-    C(0xe3c2, LLCH,    RXY_a, HW,  0, a2, new, r1_32h, ld8u, 0)
+    D(0xe3c2, LLCH,    RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_UB)
 /* LOAD LOGICAL HALFWORD */
     C(0xb995, LLHR,    RRE,   EI,  0, r2_16u, 0, r1_32, mov2, 0)
     C(0xb985, LLGHR,   RRE,   EI,  0, r2_16u, 0, r1, mov2, 0)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4a0573820d2..f3f990b669c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,12 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld8u(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_UB);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld16s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BESW);
-- 
2.53.0


