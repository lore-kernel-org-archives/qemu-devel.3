Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5ADCD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRX8N-0002Y4-9w; Mon, 25 May 2026 11:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRX8L-0002X3-8m
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:22:25 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRX8J-000486-Lh
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:22:24 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7bd6f65c781so78786067b3.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779722541; x=1780327341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0pwRnUQG5G8uwv/oKxV1XNUAJ2yGqwgSq3EJ/vrqD0k=;
 b=DOhv38ZhIxApBDQ6Pcei9TQO5UCNb3jV9fdaurqgJMpzw1a/7qJ1PodZiEcQQ7qrod
 lyJ+tixYdn1ZCe03zgog9B7ri/gbvw+J4qsRj4GNBy9FI9COB0j1jGR6R3i+TygFxtRY
 Bk31dApHMiqFfEY/CASiOVlAukvRaGg3wsd47rmBh7P/0x8j1d54MICoHNds+5m6igdK
 dawkAu7AEVGvM57oRjC6Swoh8uplij6zBFml/o5XzgzuKMYPlFDM+3C8Qclx6XiespmN
 dlvvV95n2KjCe2oZwSpVv8Ctnj2xVriTtIjfqHrG58FMEF9jLhOtUQy7Slbk6fpn6cGG
 uGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779722541; x=1780327341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pwRnUQG5G8uwv/oKxV1XNUAJ2yGqwgSq3EJ/vrqD0k=;
 b=VJW4bGFV70fbwSiip/YjDoAnB/PfSaiyzbH9x4ewHEpzn1rbsCAkvnTn8yFjVqvLaS
 3jtG4KQYuERYQz1niAWNLJMuFLs7+alpQquXfykuh5cqU44QB3rfLMuxEkDc76J2oRyf
 wWwOvVdvuOAxuksSQXdYD8LUOSnF8xGsSfKB64jlEbtTTfNh8XLP6MsINIudA5ROAIsL
 XPldEnp5Y6wK9XfcV56pOIaJZuUlDFhiK//eGTKTp+PNzPuPnEkd7SIZ2zyIGiJvZO4W
 rc+tYYchjUTO+ISDQYknoSNf7icVIJP9l/vHZVWEAjjjRjWavp7iQ6eIBa+qgcFllJxN
 hSXw==
X-Gm-Message-State: AOJu0YwMO1496gNzRN4Sd2qI5djDOVapPTibpVmVvZe8cOK60AJ/qzrY
 e3e26pZ20znv5aJqJouVaA/qespPQZ/HK5ZgfGGUsZwE0161jdbuDhM9KOKAPXpN
X-Gm-Gg: Acq92OHB+zyFrYEzMblqJp5vCEcm9xvex+nYzCYpwuRqXXNJJET29XS7Zv38uOKpodr
 iYFHBVYgwQOeBcwtEyt6L1TgWGKAspkBQg8KV5IVATE6Oe+7b1nXVwSOmSY8bknOz+Nhf7DTACI
 gizUGEZUqEmLLzO2RqigFAsGuoWgLCUiab3AS6+rBsdI+In1FkXiHeeO5SNuqwDc2w1UMMk1R6g
 9Z3+5mMN9WyTKHEh+u7yT6lCeBDpQo/EqxvzH8X0Jq1hTM+fl+sPjr2CXS/RIi50Zyb7Xr6ZFts
 7qiIR5DWcAPonfBQ1LwatOfqmGgjN5U7nNhsBbJiJZMqsmy+Azk11QBXXp/xHIzfMQKsS4YiYNC
 b15VHKSfBuM24gwBJsctHTlwurVbM3lYC7sV7Z2xxK6ykOtnaTosl7sKKFX6vm5V6tAU05Y68wD
 1kZJgR6BxJoJtS1za8ECEErEhEQeqRU47WH5sMnajmNc8RGqF2SOAKr5ltQlbjuQHCTCCCyK1sz
 4Y=
X-Received: by 2002:a05:690c:288:b0:7d3:14db:a1db with SMTP id
 00721157ae682-7d314dc0518mr126733667b3.32.1779722541115; 
 Mon, 25 May 2026 08:22:21 -0700 (PDT)
Received: from localhost (107-220-129-194.lightspeed.chrlnc.sbcglobal.net.
 [107.220.129.194]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d389e12925sm47928927b3.20.2026.05.25.08.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 08:22:20 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matt Turner <mattst88@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH] linux-user/s390x: restore fpu_status rounding mode from FPC
 on sigreturn
Date: Mon, 25 May 2026 11:22:10 -0400
Message-ID: <20260525152210.4119543-1-mattst88@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

QEMU keeps the s390x floating-point control register (FPC) in env->fpc.
The rounding mode bits [2:0] of FPC are reflected into the derived
env->fpu_status via set_float_rounding_mode(); every architectural
write to FPC goes through HELPER(sfpc) which keeps the two in sync.

restore_sigregs() restored FPC with a direct assignment:

    __get_user(env->fpc, &sc->fpregs.fpc);

This wrote env->fpc correctly but never updated env->fpu_status, so on
sigreturn the interrupted code resumed with whatever rounding mode the
signal handler last installed in fpu_status.

Factor the two-step "write fpc + sync fpu_status" logic out of
HELPER(sfpc) into cpu_s390x_load_fpc(), declare it in cpu.h, and call
it from restore_sigregs() in place of the direct assignment.
cpu_s390x_load_fpc() omits the specification-exception check that
HELPER(sfpc) performs; raw signal frame restoration does not validate
the saved state.

Fixes: 2941e0fa05 ("linux-user/s390x: Save/restore fpc when handling a signal")
Cc: qemu-stable@nongnu.org
---
 linux-user/s390x/signal.c     | 6 +++++-
 target/s390x/cpu.h            | 1 +
 target/s390x/tcg/fpu_helper.c | 6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git ./linux-user/s390x/signal.c ./linux-user/s390x/signal.c
index 96d1c8d11c..28ad80bde4 100644
--- ./linux-user/s390x/signal.c
+++ ./linux-user/s390x/signal.c
@@ -332,7 +332,11 @@ static void restore_sigregs(CPUS390XState *env, target_sigregs *sc)
     for (i = 0; i < 16; i++) {
         __get_user(env->aregs[i], &sc->regs.acrs[i]);
     }
-    __get_user(env->fpc, &sc->fpregs.fpc);
+    {
+        uint32_t fpc;
+        __get_user(fpc, &sc->fpregs.fpc);
+        cpu_s390x_load_fpc(env, fpc);
+    }
     for (i = 0; i < 16; i++) {
         __get_user(*get_freg(env, i), &sc->fpregs.fprs[i]);
     }
diff --git ./target/s390x/cpu.h ./target/s390x/cpu.h
index 3acbe83f0f..f55b79ef8a 100644
--- ./target/s390x/cpu.h
+++ ./target/s390x/cpu.h
@@ -895,6 +895,7 @@ void s390_init_sigp(void);
 /* helper.c */
 void s390_cpu_set_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
 uint64_t s390_cpu_get_psw_mask(CPUS390XState *env);
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc);
 
 /* outside of target/s390x/ */
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
diff --git ./target/s390x/tcg/fpu_helper.c ./target/s390x/tcg/fpu_helper.c
index 6ca0b7162b..b1c61d73d7 100644
--- ./target/s390x/tcg/fpu_helper.c
+++ ./target/s390x/tcg/fpu_helper.c
@@ -1087,6 +1087,12 @@ static const int fpc_to_rnd[8] = {
     float_round_to_odd,
 };
 
+void cpu_s390x_load_fpc(CPUS390XState *env, uint32_t fpc)
+{
+    env->fpc = fpc;
+    set_float_rounding_mode(fpc_to_rnd[fpc & 0x7], &env->fpu_status);
+}
+
 /* set fpc */
 void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
 {
-- 
2.53.0


