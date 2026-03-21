Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2AA1099B56
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 00:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3kWm-0005SL-Vw; Fri, 20 Mar 2026 20:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWj-0005Rn-Ci
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:49:17 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w3kWg-00026E-Ik
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 20:49:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so30079435ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774054153; x=1774658953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFmstGmcFWszN/qiAw2otwmThWAyPfpEPK+SFVFBwqs=;
 b=PKrglVy/MtOr4PyV7WgavzHpVtUmS6gciLR0jjTlxxcLPefwdKk/gEsjWnyS8BRd/i
 0qcJKz+XOpltNx6ie1uJSf8H0rbF+qKXg76LmbJUfp6t6mob1ZUpBbqqbZcdje5a/AwZ
 arkGtrq3Xu5AOdotaRH+7zLZchtiJLU0U7Pg2NBSOYPGySDrQpTSS3Ay4tO6fO9qUYeX
 +b3t9jEmAF0qkFHLQMkPE2UjoI0Inh/b/xutB2dw3dTePjY9D5aWK01/P/J2xIy6xsdI
 Ab5lXpLJ8FN26wYsJknDEcu8DMcAtJJTmI8FW6Tqflbrkgf5yYt5Fw8Fp5NiqTVwM9Jm
 GgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774054153; x=1774658953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hFmstGmcFWszN/qiAw2otwmThWAyPfpEPK+SFVFBwqs=;
 b=ARUVahir3k+B1EMO/BM0hAUt4//2MvtlayvaaVVi3Jr0VcqxKxU9QXWhakFz/9RRaL
 rw5sCrMoqPPZwVANOfzKmEojRYDNm94kOL68v+HUf/ZQItt1TLz/j933mJomRI40a2nF
 Kq9is00VdITZwZ/r4jRkRLppg/Cmd4yympYPwctDB92xwYt0rqRnztElRutm9rtwN6YE
 JcIntN9MjraP5lH/OeU/v0yeW709G8vT7WbTHl59tbJcHj648rSbympVj5X5r6sYOKVR
 horJDBFgsbSxUoLJXB+Vke0XtELmlhymWV9vUhIJyVPL0pFcqEOLyRYm7bf//ujTBzdd
 qqGA==
X-Gm-Message-State: AOJu0YyhkzDA/dTABP8DMebVL+kKgCqIrr7J00uceZ8CQjoCiCzK28u9
 26qF9DXYRu1AwzebVn5iaFTEPG30AdO3qjphU8ORL6gdwQunH4He0yfUcVZAnw==
X-Gm-Gg: ATEYQzzA0B1toHZnrJjs8pUevZMyZdCMs+MOXPLcQFtVq6ep78Dfa/8zxBiLO1P07JC
 IvGtxFrHbHXBznfnUJQ8TWmM8PhcSSYRv3rPA/a0gvNiyQv/BGyu0UGXClfjmmadBTKEnhtG790
 9jdwQQKhUadUPt/6PqhSp0EnZlQaTNztQO3H6hYHYvOjuCtsXfPoFvliYvGXFXRffJZ2QwOe9VL
 t5njyhsOJs6AEpg3lf6IwNejNaSuU5KdratVdkINdAb5nkqzcBQI+Oa3QL/mwmifs+VHScij+1C
 sMn4uJqafn9mxTC1fo431BcIuZ47n5ZdL2O/zw8VwWAudwlgDH2BbwJLr6HqGIQhihUi2hejQIV
 4tlNcIXF8AdqI17a64Byvz1BgAkm81mhzVFG1tYuLoV3X7BghTiTc9XPkxC2CMGL/cNhp9MYIIi
 cjfxXJ9Uovd+7Gwg08YP8b54xUqYCSUbZDigG9Ww/s3V6UMdzkzhGBi2/ArmWxrKcPmcG1
X-Received: by 2002:a17:903:8c3:b0:2ae:4aa8:cab8 with SMTP id
 d9443c01a7336-2b082702646mr36963335ad.4.1774054152740; 
 Fri, 20 Mar 2026 17:49:12 -0700 (PDT)
Received: from lima-default (103.95.112.190.qld.leaptel.network.
 [103.95.112.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083527f84sm34637685ad.18.2026.03.20.17.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 17:49:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Subject: [PATCH 3/3] linux-user: riscv: Fix signal frame user mapping
Date: Sat, 21 Mar 2026 10:48:36 +1000
Message-ID: <20260321004836.500390-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321004836.500390-1-npiggin@gmail.com>
References: <20260321004836.500390-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

riscv signal frame setup is missing unlock_user_struct().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 linux-user/riscv/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index 358fa1d82d..22b1b8149f 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -126,6 +126,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
     setup_ucontext(&frame->uc, env, set);
     frame->info = *info;
+    unlock_user_struct(frame, frame_addr, 1);
 
     env->pc = ka->_sa_handler;
     env->gpr[xSP] = frame_addr;
-- 
2.51.0


