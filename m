Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1848C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79S8-0004zC-Vk; Wed, 15 May 2024 03:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79S2-0004fI-54
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rj-0001cY-F3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-420157ee56cso23482175e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759585; x=1716364385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Buz2rJGX38jbC3oBTd0wt7g7ce1h+CXiegaHhEfcdIs=;
 b=fi+UYFtRn992lcx7VFcftWDW8cgUimkL+lkoLOFEoQESPB+8Mi/Op+dIifBH//yYTP
 6WzUknvzYVEq2SC1aEUNJl8rolvEp2g7j8WIgSmwdJ91Zx6ZFRou5s7cYRVm+v/gJDzI
 kjz6fgXY2rGsAgGQpboaysbIvl8oxtC66gckGOmCp8MOCe67UnF2GMstUC3bEpDF3WYu
 KM8ABOYOV8xHgfGyp4lTh1sUvA/BjoBduec0kczWJcjpci/SWNEDfNvwQIWLCQbLkpL9
 Uo3lTtzkU5u/SltG9RwPaJMx3ue4PogaMc3rK4GAmN2GeCoyZjIAwO/p9jDQlX/scYk9
 gJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759585; x=1716364385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Buz2rJGX38jbC3oBTd0wt7g7ce1h+CXiegaHhEfcdIs=;
 b=mA7b5SV4LD2MIogkJcxeZcz90a1S/9kAcVrE53oJQmww/JMSv/wpqHr4u7RZDDKNZW
 hgEYmrHQd3q6jVhyg83li9rHNTp5w2LdPWnq+xvfHwhLOAJi51DYDuJqGFNgcYtFSPj2
 HAUwmTtNwm69IOpvYA4BPg1awk7Vx2/gjhM/4diid3T6trJe9+NI15NlYg+b4gyCDJKN
 EeYJWXNnPTgsLBQ38MLewXdRiBOMQ7eEl8johS8zP74LoodhMLwh0nKGrzFM/hLHMu3/
 pYGoXBWzp3/WwWTWFb603D3YVJy6O5Fm7Id149Z6Hy6HIYJ/tBSM49X2QnJH2MkxFz2u
 5AcQ==
X-Gm-Message-State: AOJu0YxlAf7ZUx9NWq795ZZ2k9VTNfCQflcx3xteLwrjUjmYpK7BiltQ
 BKRotqgYCfym3Mbyh9s9m9a18jIRwrI2qIhENS+Jq8XUVXKta4DpfBi8210tERTXMkkS2ojzFdW
 0i6w=
X-Google-Smtp-Source: AGHT+IEvG6KUX9ZYs3fUnzYjoltUOmqG0CyWAdl/z0IbAxaD4I8bbCYOGEv6KD1evtjs1EHrnHd25w==
X-Received: by 2002:a05:600c:3c85:b0:41a:1b3f:b465 with SMTP id
 5b1f17b1804b1-41feac55fb9mr114327895e9.26.1715759584963; 
 Wed, 15 May 2024 00:53:04 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/34] target/microblaze: Use translator_ldl
Date: Wed, 15 May 2024 09:52:37 +0200
Message-Id: <20240515075247.68024-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9746a6d479..4beaf69e76 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -25,7 +25,6 @@
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "qemu/qemu-print.h"
 
@@ -1637,7 +1636,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     dc->tb_flags_to_set = 0;
 
-    ir = cpu_ldl_code(cpu_env(cs), dc->base.pc_next);
+    ir = translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
     if (!decode(dc, ir)) {
         trap_illegal(dc, true);
     }
-- 
2.34.1


