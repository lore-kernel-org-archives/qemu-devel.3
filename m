Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DABC10F16
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 15:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0kQa-0002gq-M4; Sat, 27 Apr 2024 11:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQY-0002g0-Ir
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:26 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0kQW-0005Ib-S8
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 11:57:26 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2df9af57b5eso13349151fa.2
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714233443; x=1714838243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YCHViXrIvsiDzRF1J1rW6k7RCjgqLKR+ps9Q4CzIQQ=;
 b=CkY/JMTh2NJIoU7Gr6hidQKc1gbD14HXWIg22szKaX43oKbjIVg7nnnE8D5STxQOSc
 PbR+6dN1nXuis5KFkwCKzEya06aauO18Pw/b50pfM6kDjO5zpmdo1xQyK4+p1PfjqSBT
 R5vo9sxZeUi58hNqfCGcBQqHNCZs27EVmjfHdJy6zIuJc5KmWLoGQY68Rwn74/KLm1R+
 TXk+FYzM8zPQR4Z1iqEKhNwt6+TwreTQd9cUEUulKni8NmDSWLkZscxfgc71XGcWROyA
 wAOrSU/cNIs2Pd74P5uEOo/mvEcA1OIvlgjVhoOYdiPVx1MjW3+VZX8a+tm0f+7rD23X
 NSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714233443; x=1714838243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9YCHViXrIvsiDzRF1J1rW6k7RCjgqLKR+ps9Q4CzIQQ=;
 b=w5T7eYvaBip2f4LfqWtEnuySnGOpPf2mcRw7jFmMvjJmhf54CzOWyg5C0RQpl2ljx/
 Vr2taiun+TWjTUdakIYvDnvUJ7VO4erYJqly6u1dn+1PCVlYD7A1Y5zODRukI338tD2s
 6QzE5cmuxEPME+Q0JfPvurnbHG3IjI8wzz742B+CzmOL3fW6fmyobivZdrjr9tIc6AwM
 ou4dLVggecHsQ8x2H2vIPoZRdw6X9VB2bu27LjTa9xT8cealTst+Fex1vd1NnJ+1rvEM
 uEMhtV0G7vk+VeMCDM2jh06pRl1QVtVj/rUYTZCW7XIMwb7u57Uj5FsdJSNbGbuVMNTm
 2bzg==
X-Gm-Message-State: AOJu0Yxc93MOFtvo3IhRG6pD0HMo/TMiit4gmUGCGV1TbGyWBUVNWDY8
 RIyCmA7+bgN+f8QeMIHQuCCv9WsnitafXqk2O8sCOE//dykJmGe2Ydv1TA0TdgGMt8Q5Aru55Tc
 o+Zo=
X-Google-Smtp-Source: AGHT+IGsHSfc24SrPh6cg/B7UKn924iJRfnY2xBonr4uUv9gDlDg3VMxxxarCZtY8YivSXNQw+XjjQ==
X-Received: by 2002:a05:651c:199e:b0:2df:81a1:70fa with SMTP id
 bx30-20020a05651c199e00b002df81a170famr3663020ljb.20.1714233442651; 
 Sat, 27 Apr 2024 08:57:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.2]) by smtp.gmail.com with ESMTPSA id
 p14-20020a05600c1d8e00b0041bab13cd74sm4957207wms.17.2024.04.27.08.57.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 27 Apr 2024 08:57:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/14] target/i386: Simplify get_memio_eip()
Date: Sat, 27 Apr 2024 17:57:01 +0200
Message-ID: <20240427155714.53669-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240427155714.53669-1-philmd@linaro.org>
References: <20240427155714.53669-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

The single call to get_memio_eip(), in cpu_report_tpr_access(),
is protected by a check on tcg_enabled(). Since the call only
exists when CONFIG_TCG is defined, we can slightly simplify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/helper.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 23ccb23a5b..a3e70a630a 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -512,9 +512,9 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
     }
 }
 
+#ifdef CONFIG_TCG
 static inline target_ulong get_memio_eip(CPUX86State *env)
 {
-#ifdef CONFIG_TCG
     uint64_t data[TARGET_INSN_START_WORDS];
     CPUState *cs = env_cpu(env);
 
@@ -528,10 +528,8 @@ static inline target_ulong get_memio_eip(CPUX86State *env)
     } else {
         return data[0] - env->segs[R_CS].base;
     }
-#else
-    qemu_build_not_reached();
-#endif
 }
+#endif
 
 void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
 {
-- 
2.41.0


