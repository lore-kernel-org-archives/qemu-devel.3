Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32602C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jnt-0002YL-MP; Thu, 17 Sep 2026 17:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnq-0002XW-Vu
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:59 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnp-0007bQ-BG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:37:58 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so21892a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681076; x=1790285876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n4WCxTUogcOh2fA/Ia8OvzsJEVhHn8hs6z/vSKlDtUE=;
 b=ditsplTv+t0L8T34zMQPtSe9pqxkqktJHGIDwyQWA8Te2vKWXwI+mici1L78tHgrgN
 Az7twVwo02paJK0O1XR1jC+p0yD3BrpsnEh7wf0C/R1X2/ycnXB6vAwPbMkRUTPRRQA+
 cNj3qewZbKw274z46Bda5J5O5bYfl9r/kW18iGNYnqleJmWuFC7VA7jbU4K9cqRrkEc1
 bSjOpJzoijADns7YdkOFlK7xixLKvmOG9opDcetfsVWSQwIPgYMIHpYZ4UOJWMde4WeG
 8vo/MkG1Ew2S0tA1XkM7uaBx7HbMwXGO717xoN1pmvcODPAzBpRQn8gLyIlo+77gP16g
 tG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681076; x=1790285876;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n4WCxTUogcOh2fA/Ia8OvzsJEVhHn8hs6z/vSKlDtUE=;
 b=zc8rr+M/irlaeeIqUEWFa8Sw5GbeAETzb7C9Nuv8cS6cvZjjgnxyhHwuZ08eDAqeNO
 FvXIJ9OSzk/fG0gna8IyWuU29RbFdk4p+8e/0d6hY9oDP+PxwMJwqbOqEUc6oIF6SNj9
 kUY5S6qddjAmhxsfElgDVwyD5MqTorA/Iwg+Km6vYKQjQJ8NbR//blew97obqgBoUNiJ
 GadvOMyoufPkVeswfzBB7I3NIygIAVt+cwc06Lb/q8Pwbkwq7yprhROpcqHvPhvgOKkW
 7UCJPJS0uQ0qL1mDReDBiqCscDoRS09z2hCcSsyvFAtv+iQSIos4Ik/TanTfYRvF2YNt
 BGXg==
X-Gm-Message-State: AFuF++l7Vdn9mWcNCN6E0gx3RzXHF76D+rpSoQRvPkdzheSharG+TYhm
 RQ03M+3PADYRNKUch56gD1G1lVQQjTigDsQNmO6lAXusfhpZ2oWBbkNS+3ABBOxFsEaz/4sHaq5
 MIbmAWmk=
X-Gm-Gg: AYBFou1I5hjVJVGSa/o9PPU/mqLpisqTQsx39ohPJJuWnXcLhWd/nhR+JePEyzd21WV
 i/Kf7VJXyPlhYyrG1rO6C7kXz6zsvTElBTMJOoISA1hFBklRNJSWopY24eKFytAI6nQDWyXRK3x
 QsdVP50ZbwLTJ4o5EFrw8IKJScw4s2v2KItIjR1ABXkTNNCPAz0IPpkV466oE013dIdEPS2iFxs
 lld+INHMGWo5uabESYU+EDamQq1tZXrESzGPR7WmwUgRuuFk6zfUKxc5HaosNf57I3A+w1nW/v6
 Qm9UvR51K079uX0t0jv3k2FYarjjBegEo9uRwkqg10gz/x+ki77LC5eDirQe/gbObqeVzrNVvVU
 ULni3HymQaelz3fcCpS4Pza8up/Ju0h063yDUxPYsqk2RdB7z1+9YRcAsz96jnJbQrl5iswCQDs
 qeM64I9eVQokp4z7kfSHR9cPEpgkwy6icLqXwjMdx0/dK6YQGAqkZTcGCGprSR/WTFE+kZwPYuS
 OOclAA=
X-Received: by 2002:a05:6a21:4987:b0:3a2:c9a1:2c26 with SMTP id
 adf61e73a8af0-3dd7251144fmr5970497637.7.1789681075765; 
 Thu, 17 Sep 2026 14:37:55 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:37:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 03/15] target/s390x/tcg: Convert op_ld16s to op_ld
Date: Thu, 17 Sep 2026 11:37:37 -1000
Message-ID: <20260917213749.36756-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-4-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 12 ++++++------
 target/s390x/tcg/translate.c     |  6 ------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 403992460be..68ce6c2b198 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -498,17 +498,17 @@
 /* LOAD HALFWORD */
     C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
     C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)
-    C(0x4800, LH,      RX_a,  Z,   0, a2, new, r1_32, ld16s, 0)
-    C(0xe378, LHY,     RXY_a, LD,  0, a2, new, r1_32, ld16s, 0)
-    C(0xe315, LGH,     RXY_a, Z,   0, a2, r1, 0, ld16s, 0)
+    D(0x4800, LH,      RX_a,  Z,   0, a2, new, r1_32, ld, 0, MO_BESW)
+    D(0xe378, LHY,     RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_BESW)
+    D(0xe315, LGH,     RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BESW)
 /* LOAD HALFWORD HIGH */
-    C(0xe3c4, LHH,     RXY_a, HW,  0, a2, new, r1_32h, ld16s, 0)
+    D(0xe3c4, LHH,     RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_BESW)
 /* LOAD HALFWORD IMMEDIATE */
     C(0xa708, LHI,     RI_a,  Z,   0, i2, 0, r1_32, mov2, 0)
     C(0xa709, LGHI,    RI_a,  Z,   0, i2, 0, r1, mov2, 0)
 /* LOAD HALFWORD RELATIVE LONG */
-    C(0xc405, LHRL,    RIL_b, GIE, 0, ri2, new, r1_32, ld16s, 0)
-    C(0xc404, LGHRL,   RIL_b, GIE, 0, ri2, r1, 0, ld16s, 0)
+    D(0xc405, LHRL,    RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESW)
+    D(0xc404, LGHRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESW)
 /* LOAD HIGH */
     D(0xe3ca, LFH,     RXY_a, HW,  0, a2, new, r1_32h, ld32u, 0, 0)
 /* LOAG HIGH AND TRAP */
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index f3f990b669c..31239866180 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,12 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld16s(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BESW);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BEUW);
-- 
2.53.0


