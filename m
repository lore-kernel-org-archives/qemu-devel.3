Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA0DD7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6N3-0000rA-GE; Mon, 02 Dec 2024 08:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GL-00024W-BO
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:53 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GD-0003MI-LJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:50 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385e1f12c82so2553956f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145274; x=1733750074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MX9sc7FmhfylUuxW0cA+BWl3jSlP2Yj9aquR2jby44k=;
 b=PHi2UVs8C6MXAy7NaLDRDBs3OB4EOMXzjDI36Pxn7O/b+WMdWTzdHT/0/czOmlvHAP
 hEiAbjgJJGZ3ZeIfvEdONM7wQduamapb6TpMstAr1rYKUHgsuqZb69lF1G9NZuskSr5j
 pD3XLtHPizADQtUarD38HGkdnh2/NMLqZ0tdjZHGj5D8XDeZ5lHcMBe+kOcckpfBl6Pg
 Xlf4jOFT/lqJMueF81F3+eoYhZeRFMwSITyfykuerKjWcLmuT/a2RYCWQjTpPfCB38Tc
 c/ubzRpLnnp1LZaa/XBfunsy4HOK5fcPeJNsIzhM0t+uXLz9UE0yKLRmgqqdp3em1vm5
 Gy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145274; x=1733750074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MX9sc7FmhfylUuxW0cA+BWl3jSlP2Yj9aquR2jby44k=;
 b=SCYdTJzqQ6JiBubRhCpJcdN2ee74mukY6+Mu4zetuAkiJNRL6IM+pMfE+h85BrmfVO
 qGfb08jGJOtI47xN440biCzt0bfYtYyPCRnvJlVrWxoz9NyNUkRLt5+DSVfOivTpE8JK
 qEoXyLzlOpsm7izcfFEaMrKbkuXZImOcaRIuDbeH9eqIZ5tae8hkqc68tuQzx4X61aQz
 wEl5bsiW9tD7KWb3fF47yfpQNirFevwXIU234mu8hcuGaigyHQYu4kpu7H9IExhsRESA
 zv8zwn1C3ugqazPvF3rSKlSd22OD5JGsWo/aWEl0Zb8RbhAIP3mTsKRgY01JLSGgNnOj
 iKIA==
X-Gm-Message-State: AOJu0Yz04gGGkt2qjEyrjbp6rl7n+fVwQqY1wxnSuYbxGMquXkAiF1BA
 mic0Sih7/X9WG54jjsZj7sE8mwpIQIrkCDmGHGCAbPmL0XRU8ySduHH1ChtCeCyxsS6H34DbZk5
 8
X-Gm-Gg: ASbGncvANOSTMBlDs97+gYnUeZuW3rYo/f5HeWOAbfJaAkLACFGNJEbAf7R3RFSw9N3
 Du9N2ePt/vMDyvuZFsbfEur5wYZYmW4iMSsHB42bmjNkfVH88LnujrKUoRiKNce/cSpM1mpDM7H
 YXyAchbNK3TPdAUAayaEEaI/g+YmMn6ETHGKlUNYuSdLUyzTQWlm0WFZHSILZMCN821LMQzFgVw
 cLwnYDnWJnE9KTLX0OxOXLUal2vKWw5lU/icWh4GzdLSQV/KWpeehI=
X-Google-Smtp-Source: AGHT+IHeY93QBLGrs0ffOfRyNKPIrpV6GdKIJfYknW2MMO399IIrOc891AWxF9xi3vFXcrfgQfo1EQ==
X-Received: by 2002:a05:6000:4020:b0:382:40ad:44b2 with SMTP id
 ffacd0b85a97d-385c6ebba51mr25311409f8f.34.1733145274134; 
 Mon, 02 Dec 2024 05:14:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 27/54] target/m68k: Don't pass NULL float_status
 to floatx80_default_nan()
Date: Mon,  2 Dec 2024 13:13:20 +0000
Message-Id: <20241202131347.498124-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Currently m68k_cpu_reset_hold() calls floatx80_default_nan(NULL)
to get the NaN bit pattern to reset the FPU registers. This
works because it happens that our implementation of
floatx80_default_nan() doesn't actually look at the float_status
pointer except for TARGET_MIPS. However, this isn't guaranteed,
and to be able to remove the ifdef in floatx80_default_nan()
we're going to need a real float_status here.

Rearrange m68k_cpu_reset_hold() so that we initialize env->fp_status
earlier, and thus can pass it to floatx80_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5fe335558aa..13b76e22488 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -76,7 +76,7 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs = CPU(obj);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(obj);
     CPUM68KState *env = cpu_env(cs);
-    floatx80 nan = floatx80_default_nan(NULL);
+    floatx80 nan;
     int i;
 
     if (mcc->parent_phases.hold) {
@@ -89,10 +89,6 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
 #else
     cpu_m68k_set_sr(env, SR_S | SR_I);
 #endif
-    for (i = 0; i < 8; i++) {
-        env->fregs[i].d = nan;
-    }
-    cpu_m68k_set_fpcr(env, 0);
     /*
      * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
      * 3.4 FLOATING-POINT INSTRUCTION DETAILS
@@ -109,6 +105,12 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
      * preceding paragraph for nonsignaling NaNs.
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
+
+    nan = floatx80_default_nan(&env->fp_status);
+    for (i = 0; i < 8; i++) {
+        env->fregs[i].d = nan;
+    }
+    cpu_m68k_set_fpcr(env, 0);
     env->fpsr = 0;
 
     /* TODO: We should set PC from the interrupt vector.  */
-- 
2.34.1


