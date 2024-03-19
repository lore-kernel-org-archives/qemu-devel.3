Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7D9C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSyq-00068l-Oo; Tue, 19 Mar 2024 02:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyp-00064e-KI
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSym-0005ge-S2
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41409fd8b6bso18479615e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829783; x=1711434583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioEuKggDYI9Ff6Tz/WlVRONFn4WVhfyxodNulYLHoYg=;
 b=u4b51JvOpgJlLelLd4XOlSrmP5nBL1RaoQru3+FWnFkSrEJvPe1qqeiK877AmBaGxk
 +qpzfx3ftWuy7XKPLjPN8sIJvbLl6sZKIT9fuaWw2UmdajIla13XyAdhzGiMbz/n8MoM
 pF6vhIbO7cviT3aHqy+5ttrKzXsxk12cRkPCIcv3oBHTcPjujtphZwvG7Txeb1lvxu42
 QJN/LvnkVSP8XZD9lqkZ+Vgz3FLJPdPeMxeubhLJAgorrc1hlO4UnmVP1TZfzgs61cJR
 1lmRp3z5Jg5p4QHUcPvMUecFAR/7Gy3efrhTK2cPIY/q73y/0GhDEfCI2PH+D2nt3w99
 b4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829783; x=1711434583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioEuKggDYI9Ff6Tz/WlVRONFn4WVhfyxodNulYLHoYg=;
 b=rlCb94kcSs6/WIE3sU4VdasBtT0HOjV0lZAmN/fTlXs4lsg0YYs6pFyArpvTNoAv1+
 i2w1UT1UYR0pecrKWzuYKIiOJ5PY/GjPf5aLmchOkgyHeAYmy1qEdcZSUMa8tZj4zT61
 n/FZ1cHbUnYnINhVRBar6Kx2TPfs6Cl6OCbM22Mha+J8xrYyEL/IsaQOyycylo7ugSO3
 PpqlnSa9NfnoOhEqosDlrfBrLXddo34T5jJhnr5SbKyRcCORt8zy4yPoumAkw7SoCq4a
 msChcOlbAGQ3svNkCF36yDYiPnK1jd37QX7Kaz59YRWlPk61beKtMOEGi5pGfKudlST1
 fpTA==
X-Gm-Message-State: AOJu0Yze7Bzg0uVEASc19zAV3WJ+PovdY8IkRYz/ImZDteKh21IgqflB
 ro+K1tqd4hMORFh5jceRdnGpzz3/TlAvT/ouZLJ0IRLy7z70dGWjx406xpOkh+ICGLPOAy7zJRw
 O
X-Google-Smtp-Source: AGHT+IFt0w/yQtP/92+2ssXuMyzs5I8HpsPU6alFwtMOYeIkHHdmAGPOeY5ZUSgYaI005s5ciyZzEA==
X-Received: by 2002:a5d:6803:0:b0:33d:fb3:9021 with SMTP id
 w3-20020a5d6803000000b0033d0fb39021mr8936257wru.54.1710829783095; 
 Mon, 18 Mar 2024 23:29:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d4dc1000000b0033e99b7cfa8sm6353382wru.13.2024.03.18.23.29.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 8/8] target/microblaze: Widen $ear to 64-bit
Date: Tue, 19 Mar 2024 07:28:55 +0100
Message-ID: <20240319062855.8025-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Exception Address Register is 64-bit wide.
User emulation only access the 32 lower bits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.h       | 2 +-
 linux-user/elfload.c          | 2 +-
 target/microblaze/gdbstub.c   | 2 +-
 target/microblaze/translate.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index c3e2aba0ec..a9f93b37b7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -251,7 +251,7 @@ struct CPUArchState {
     uint32_t pc;
     uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
     uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
-    target_ulong ear;
+    uint64_t ear;
     uint32_t esr;
     uint32_t fsr;
     uint32_t btr;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 60cf55b36c..4612aef95a 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1498,7 +1498,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
     (*regs)[pos++] = tswapreg(env->pc);
     (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
     (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->ear);
+    (*regs)[pos++] = tswapreg((uint32_t)env->ear);
     (*regs)[pos++] = 0;
     (*regs)[pos++] = tswapreg(env->esr);
 }
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 09d74e164d..147d20c3e4 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -63,7 +63,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = mb_cpu_read_msr(env);
         break;
     case GDB_EAR:
-        val = env->ear;
+        val = (uint32_t)env->ear;
         break;
     case GDB_ESR:
         val = env->esr;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 493850c544..19b180501f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1835,7 +1835,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 
     qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
-                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
+                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
                  env->esr, env->fsr, env->btr, env->edr,
                  env->ear, env->slr, env->shr);
 
-- 
2.41.0


