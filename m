Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA4AD7497F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdUO-00044w-J6; Fri, 19 Dec 2025 11:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdUA-0003hl-6K
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdU8-0000Wb-O0
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so4933025e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162262; x=1766767062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTDf6gXgcB1jO6b/88BcaLI6db2PR4zQsgUSxotS1SE=;
 b=OOoR3EIAwGQsPsayI7xVn+azQV3bLNj7iJ8T6wVvykBDsZD4SGiWPL2AByQFjIGBeT
 CApuizXHkerGXbcdlc1ZxwpKD3umJxp/L6nh/83httrvwj4S/FBkL+0NDt6iWfWmu/lU
 +GcYunxCqgO4GpWKzMvo6m1szklIAMygqfl4xsbOydx2jTQ/AP6GsdQFrKGKOx1Hno6F
 A95bAvNhTuVhCawHHlg5URLqBovHO5QRRtsyTHELNi823zOiq7jfZtAU03NbS9mfYSHi
 0WVZOjG94n6JDmfVF1yP4kOZWePJdD7pPq25Qz47QkXyNtwzvaU0iX28oGio8jD3DnZf
 w5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162262; x=1766767062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LTDf6gXgcB1jO6b/88BcaLI6db2PR4zQsgUSxotS1SE=;
 b=YuhDqwYw4zah/5ZdhlhbVQq2W/mpzvyNWXhG9r+g+WXvSPlgRwp0WtFsAgdZuvSQtj
 BqQ71xgcAeUP3rTl3piZblezGgTlNUIKjmwW3wzjuiqTMFsUp4tg7jcrCWF8NlpCx599
 k0YUg1x/jvBPE+FTMDKG/qhqwvA1ezyIr/rxjO+ZLh2rardiq9Wy9Q/g9+4uaBBxMf1j
 n0NlSY/LA0kigC9ETCmMI9OuzG3ey0o/e7rq8uOFhPgzJpqiitk+AQfqm0aT72npMG2n
 roi5VPM0AS7/lPTuLqRF+09OSrddJb7oU8cR8EXD4JMyPVgL3qNlnKmGJkNkPKYc2mwR
 S9bQ==
X-Gm-Message-State: AOJu0Yz97/2HNGN6yWov3me8v08RvKBsxZ2dtU+QfQcZU+BM22++/Qyk
 UHJWNJTNxMOIg29etR5SVS6AciYUfxAOUugVn38dj5ohtYtTIOjEiooALSWcKoIll21A2aQmjP6
 Ghd4LTpg=
X-Gm-Gg: AY/fxX6JG+NtI3arU5PY7SG/jpH/StAvm4clyNTqhFbdceeXq8NzNJM2OvXmJnTppLt
 lp4dnw0SU6Mu424lVeuYwxE2jEWs8HEdpWIKd1VCgERFk9+jh6dMhUpPNO7dOS1UTlOEkuXJ9ym
 xhRTF4f+L0D0q+QjymDmj1zZuBpZw/3s8mKaIt7/vwYs9ntsGZluAeuQ/rPCF5ac9GH+GzDfLtx
 e7EZQkkf3XUngNt/XC2QsxEYdWrvtGs680T4U3E4HKBtxdpdrxRXRomoYXOSxiU6T6qSteMwyph
 PZHOC95SED++hu54eVeudiJSSDlZi51I/bjamUtc+53mdSyBD6OMKnvGMfUs1T6QbFCUSGXFFEj
 Po7UX2tVsBhG6CINDxHTVvZvQqny+n2O1qSIlLcILbgbjsgc3anJpXt+4ZwMLHhQo05K+SsfW0n
 mR8llbfERi2IIdMkruG9JqJoPX+IOSZ/4T/fUyahb/XpyQGgP8HfBeaQigI7TC
X-Google-Smtp-Source: AGHT+IGVn0ryBojkRANNbMa0by1PAI80OdH4kFiFgu7XXa6cp5auA1Lqw7bFrQtJ+VKdG9RLjZ0CCA==
X-Received: by 2002:a05:600c:4447:b0:477:9a28:b0a4 with SMTP id
 5b1f17b1804b1-47d194c6a2fmr28339435e9.0.1766162262332; 
 Fri, 19 Dec 2025 08:37:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82feasm5885047f8f.24.2025.12.19.08.37.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/9] target/sparc: Inline cpu_ldl_code() call in
 cpu_do_interrupt()
Date: Fri, 19 Dec 2025 17:36:47 +0100
Message-ID: <20251219163650.74303-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


