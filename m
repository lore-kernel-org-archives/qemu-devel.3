Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6A1C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79S7-0004hx-QO; Wed, 15 May 2024 03:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rv-0004SK-6f
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0001dw-4Z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34dc9065606so3632448f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759589; x=1716364389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiNkoAsgvTetR5YHMAeB2w6OV5e9o48b6mfaDP+sgJw=;
 b=bH4iHFd0WylPXXm7lSk2zxin8zZ+RH2Va+pcmE90CUEF/iY6FCxYYW+uci8U4M/UJd
 3zW0+3MQdYzxlBq3dhb7/P8/xazgfeZbVUDyS4+F+t4TPOYiMzT7EtYTnuNU+HMtLT5P
 bg/aPPaaUfkcMrVwOZcLMh9XBcH41ImlFPke6/GXSl47djkZhpQfcwwBGzgEQBzcGQbr
 KaqfJ0sf1BYaa8GAKw9wgXY37lTMRPKYCsc4LoZ0k81LpSoxlvo+F98iiC89H/CZJaKY
 nMUTlrFag44uVe0Hk0jUqVlPCDsMumIDLCa8s7eRHIYqlSdtOdNgBTSAdQMPlAUCFQC1
 DKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759589; x=1716364389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiNkoAsgvTetR5YHMAeB2w6OV5e9o48b6mfaDP+sgJw=;
 b=hKSfkl9HCk7AO9EKoYpL7rn7RPj4cIt/sR+Xu01+azN5Fl+JBdNfhVPCCRSXQYHds2
 6O0UwpbvRYpCo8JnRMSHvPaKf4DQMZdwED9KYFP7qjIKhOnghN2sIGwHvReOdrDRc/sW
 aLmj5zNmAhG6s2wApldlZsOipAeIZiqxAk2MuWR/dIUamvHp7D3aba1//OQ27SD1sFkg
 pYZWPA/mHr3wW8isCsVDEX1GQiCU2nUsHdoH/03K4mO3hXPOSdaFkNU87TeFN3NY+R2H
 ixGEJbzKEhR+sNJ0ILmJF1/aSdxHbUJoTSAlHqEltZ1I+nMa00TBlrO2eW6HjJiJMQd7
 /mQQ==
X-Gm-Message-State: AOJu0Yw3QvDcuM4VPECdXCP55ly48KWx9CCuAkwP7bGUFnpJvlpTnya3
 16hHJilmr9dXPO51dEKxEPt5QX8BXMD8PyEkKlsOOBrHUm9oxBlpq9/MJRDYhWYJ0fNuX7o8Tgt
 Uus0=
X-Google-Smtp-Source: AGHT+IFa5lz+aJFWzWdeNPo+a5lDnJVmqL8ykEb3fgQsqSUOGsekZ4nBrfV2SOvDaRcS0FgBjTO5rg==
X-Received: by 2002:adf:e256:0:b0:34e:3d3a:e144 with SMTP id
 ffacd0b85a97d-35017fe1ed2mr14763582f8f.2.1715759589089; 
 Wed, 15 May 2024 00:53:09 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/34] target/xtensa: Use translator_ldub in xtensa_insn_len
Date: Wed, 15 May 2024 09:52:44 +0200
Message-Id: <20240515075247.68024-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 42109d33ad..75b7bfda4c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -35,7 +35,6 @@
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "exec/cpu_ldst.h"
 #include "semihosting/semihost.h"
 #include "exec/translator.h"
 
@@ -1118,7 +1117,7 @@ static void disas_xtensa_insn(CPUXtensaState *env, DisasContext *dc)
 
 static inline unsigned xtensa_insn_len(CPUXtensaState *env, DisasContext *dc)
 {
-    uint8_t b0 = cpu_ldub_code(env, dc->pc);
+    uint8_t b0 = translator_ldub(env, &dc->base, dc->pc);
     return xtensa_op0_insn_len(dc, b0);
 }
 
-- 
2.34.1


