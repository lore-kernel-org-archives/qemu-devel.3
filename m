Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9474E776C4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRiV-0008AH-5d; Wed, 24 Dec 2025 11:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRiI-0007yq-17
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:52 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRiG-0003sE-Bm
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:27:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso61596085e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593666; x=1767198466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTDf6gXgcB1jO6b/88BcaLI6db2PR4zQsgUSxotS1SE=;
 b=pICJk4fiRRWlL3jdHZmbDsLvuFO3SR4VI93CKBaWusOGePk6wpQGeRxv7v+wdoPTo8
 4NOvmCeNzxgG5BED7C4eJtihmimP1rBe0zbaHQdkEIuQDxDmpFpBHWT56gmTcSSo+KTV
 InLhkK95XOQloKwtUsk8GaYQAtaYysW4RlhOqmlGtvmiTA1RR0ifYHynkUb7auphzONa
 6TNrT5ssFnjPNl9aM2NXcg88SIJM1/3V5EBvF6K2hRv6S7/O/YyRGa/gkkCI6EDLabga
 LLk6X1unxmtgo6KSz7uemeLUEm1h5tD2GBeeM73GMBu3m1s8fHrwjoOzO4+mt1e/WutC
 O9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593666; x=1767198466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LTDf6gXgcB1jO6b/88BcaLI6db2PR4zQsgUSxotS1SE=;
 b=sBRP//JU/VRe8n/v4T0dt/UtlLXGbAhLIAiq+HMDMUTX5RuXX++15RwiO+ORvzJ0aj
 WRf5MFCyQl1kbf9x4jvpOcfpGFd6S25WLRF+gVK/WcV13BnFR/IQXSNZ6y0arwTByvDQ
 2yLWAVQWaSvnqDIxb3QZDNfqLZNShzU3onNW9ufNycLnbztlT62NLYYTzEpUjw0Zm6+6
 7hnN+9ui569vtMINSb02/fex4lv53n7MvaReaWVbLxxxgXSgWGBxB62CDhVkgllW2qIa
 y47A1GVCFyMnmB4fcls4WwGucAwzo5exNXJbmpjVsvtZjHS9iCXW39ZF6hocN6qmKzSx
 6SWg==
X-Gm-Message-State: AOJu0Yw0ESsc2Kj+b2xK2cSZrT8gNKP/qVYWMKzKBYWtYfOKnHLTqQBq
 86/lV8DzaVqKeHJffWvXzX3VJ/CrR3y0LTR833BpCDq9Ysck4TyZ/q2mZBzet5KsZDyHoCKH9IH
 YCbNJN/4=
X-Gm-Gg: AY/fxX7c9tfnzIlo1FICxxQrzAmawhPoOy5mBMdBb8VA/cIyBQ6dXGd+lVbgLobnFPk
 nSUrH3rjHD12e6KJPTT/XByNdYKhmf2a5SPVy0G+RZ9IUzZ7Blt7l9lETNRJQHP7tWsSy+F3Uju
 r3AWdxe4RUCfph1PMyGVfLtpZaIzZd0/QSr8j318Pys6zmyNY6uULcZtAaG4/x9hrk9OMjnSZ1j
 9TDSFzCYn0pL0GHwDq7UwSamO0Yi1twXsfWqn+Z9DU2NV4NyDo6vIwkHt760OrQoITcM6aKqk/o
 U4aTHomBDNBLZNwcrRMGv2SAzw1cIQYOg2rVQFMXAB4c3wO60GSAIbaX0IgOyoa2vNH8aZ1BaNs
 O3WlFTPF+okEB1Ye1eF8g48LUfpZglntwr8iw72ULG3iIhdYJbdA38JA2hH8tFlrN5PsqNsAx6S
 hzrQL1uGCCPDPkfc+Wpt1l2W111qbJtb4GugAECIvRJym4RATm1np1NQwMrAfgB4V7IA==
X-Google-Smtp-Source: AGHT+IGM4yy3qjYhYGpBjQgkWRJGO4Ed5v9u0Y/nYnfYihIxsR+2/oMa/4SiyS6Uwh9P8aTt2//6+A==
X-Received: by 2002:a5d:5d08:0:b0:42b:55a1:2158 with SMTP id
 ffacd0b85a97d-4324e4c9e43mr16959078f8f.17.1766593666250; 
 Wed, 24 Dec 2025 08:27:46 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82f6asm35931384f8f.27.2025.12.24.08.27.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:27:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/9] target/sparc: Inline cpu_ldl_code() call in
 cpu_do_interrupt()
Date: Wed, 24 Dec 2025 17:26:39 +0100
Message-ID: <20251224162642.90857-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162642.90857-1-philmd@linaro.org>
References: <20251224162642.90857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

In preparation of removing the cpu_ldl_code wrapper, inline it.

Since SPARC instructions are always stored in big-endian order,
replace MO_TE -> MO_BE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/int32_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index b29f693a6bf..d6bb3fa1e54 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -149,9 +149,11 @@ void sparc_cpu_do_interrupt(CPUState *cs)
          * mimic delayed trap delivery as if by the subsequent insn.
          */
         if (!env->fsr_qne) {
+            MemOpIdx oi = make_memop_idx(MO_BEUL, cpu_mmu_index(cs, true));
+
             env->fsr_qne = FSR_QNE;
             env->fq.s.addr = env->pc;
-            env->fq.s.insn = cpu_ldl_code(env, env->pc);
+            env->fq.s.insn = cpu_ldl_code_mmu(env, env->pc, oi, 0);
         }
         env->pc = env->npc;
         env->npc = env->npc + 4;
-- 
2.52.0


