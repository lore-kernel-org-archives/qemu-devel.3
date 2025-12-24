Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2C3E776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRa0-0007Aa-8k; Wed, 24 Dec 2025 11:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZP-0006zK-Jf
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:49 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRZO-0002Fg-4y
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:18:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso32675965e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593116; x=1767197916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=80eIc4DjrOU7auVm5Rkv4MvDkt9/G8asUqt6MOnMzSQ=;
 b=myrAJXKxYSXGvuEAgpnBNdCj+7nMqq2u/z1oVydOSgv7OdWhCFx9Wo4F+dCncdmRKR
 u5vosMIb2qLd9d2DVnZ8gb8wh4vtMEi2nj9tKsyso/LEZA9phLqAxNKffKQghQk4+58+
 CRIqe+75S+8LKRElhPRHadU97gkaTUTcHSccGywvzSUKGMWBRKXFhye/eZSh742bqnF9
 wXfWwG1qo7KFCaxyJq49zmLAXDSu2C8+JIbnrRcj8/X7IQsrBJ6mY21l+fWLzNxzaEck
 NeOF2JVAck9kaeghibdSQohDYvICX9eXZ4eSy9UlXhFuoL105gHRxOxGEvr7FadNVnxc
 RKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593116; x=1767197916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=80eIc4DjrOU7auVm5Rkv4MvDkt9/G8asUqt6MOnMzSQ=;
 b=xDd4fuDVKftM8izr/zuT9ryBqdH5p5jtzhSx2jMDN9oe71vdua7t+4zeE3Fog2wZAd
 EIEX0Uz6OoztqDWkmiwrIff2IeakL0KemuZtUKDC5y6OVh05YIFlDwkpOm5H2r4r03A5
 OOP2ozJbcPWtzDzFkITCR/9hAD+1oT5UDeBQbTVnAGYLBjxF14Iwf2r7IMOU5eHR5en2
 2fh+LUTpCEl/gyW87JcWQRWhjMbjzXxMF/ERQSPX0yM9oqyGg6RCo1LSPaxaCqyeoFqC
 aOpnbbIrcFa1fWMQkJXnIsJeYArEmRTmCL4Rr3J9qDctJW3S5YqawAuGJNOdcriREiM8
 xK0w==
X-Gm-Message-State: AOJu0YxVtF3ohO0893UyysIWa6ofNT+n+GR5acHyQmUhw8hyKKxvLid+
 QrIQ3k3MIzdB0g76J2nuj3++L3HymE/ZNkwXEYCElTx9Y6E9bUW1R/iEnl5yWk2Oxhm5hDrBZeH
 neYcchAI=
X-Gm-Gg: AY/fxX7SB0OLCBItM9n8LYLAiuZA9IEhLsvPM5WsKjRcSHhw7TMu0kZbCN+T1gc9T5r
 znLdGuehhr0oqlqNK6BChsC7T4ECDehzIEc23dpju/YCCpMXxCKgXOzIYinGM4kHP4tWuTFPBJN
 u+rUcaMSJBxBjpNDe7w7OH9Q69vV0rVn/vTasQn/f7nUetge2c4bNjLcVOAVkST0hiBitQo9ckX
 os3JlNzbMaFaYDmrTkiKk0c+sCM3qQKMo4ZUsgR08LaDzVh/8rlJvuAeiZOZ+RFK02G+jeOji77
 bn7pwqHcn+7kj/RsUZq+6uzgIIpWLQjef97U4H5dzLHj/ceHB3pquknXl4idsy0Ni35mtljiVd/
 MBDyE6O5X4Ml74ehHRMmYAz5+E76S1LcMekk69sI9t21PLGaECsU3ybx60tPhwTSXSOCgW9FU4A
 cOfZAHWlWdpS1CVttNhrD7lHHgmxuWfigfJ3liUbAz7cDzn7kqVtn18so=
X-Google-Smtp-Source: AGHT+IEnv1An57y0TFuUb9UU39ZzHVeulUK4Z6Ksd3z6V9FEQCoVO6ONpJvgxprsjvR/2PRhN16gNA==
X-Received: by 2002:a05:600c:524f:b0:479:3a88:de5e with SMTP id
 5b1f17b1804b1-47d19593ca8mr159150555e9.37.1766593116375; 
 Wed, 24 Dec 2025 08:18:36 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm35634395f8f.38.2025.12.24.08.18.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:18:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jia Liu <proljc@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/openrisc: Inline translator_ldl()
Date: Wed, 24 Dec 2025 17:18:03 +0100
Message-ID: <20251224161804.90064-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224161804.90064-1-philmd@linaro.org>
References: <20251224161804.90064-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

translator_ldl() is defined in "exec/translator.h" as:

  198 static inline uint32_t
  199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
  200 {
  201     return translator_ldl_end(env, db, pc, MO_TE);
  202 }

Directly use the inlined form, expanding MO_TE -> MO_BE
since we only build the OpenRISC targets as big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/openrisc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 6fa4d6cfa70..a6d550bbc2e 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1558,7 +1558,8 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    uint32_t insn = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
+    uint32_t insn = translator_ldl_end(cpu_env(cs), &dc->base,
+                                       dc->base.pc_next, MO_BE);
 
     if (!decode(dc, insn)) {
         gen_illegal_exception(dc);
-- 
2.52.0


