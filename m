Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E00CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rw-0004Z3-VN; Wed, 15 May 2024 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rt-0004Iw-Dt
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rn-0001cl-9M
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-420180b5898so18898685e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759585; x=1716364385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1Iksx0xg6rkS7/ro1+ykm+RdeutCXftoxj1EQCWqvE=;
 b=AcTCks7ZXlrRoD6k9NYRDtlSlg4MJxXVO3AE/H59mRhvEDIgPu5n+9MGsYjVYfxdsp
 8zPPO12HemaNvjg7iLr6zsfIjdiRL7CUpTxiVzSBeFKHl0UDOitEKBki56KZ1hEfPjzd
 MNWpVcpQA3UIfExMUqozfkrDqKypCLoxrJdXe/p0ZwNq+lksnchkRTEm5BeMUavGjwap
 cJJYzSKxDBIAFcyfLcoyG68otni5AdFvN1gATRIpuGnhzAbR8XBYH/adX2E+SiOdKwVD
 71aBhDQbkxMhGyDX89UVJsXb4VVzVTjgWcDXtwCuWHHVbIAB80SiDUTbLA+BHvDJLLZD
 K1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759585; x=1716364385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1Iksx0xg6rkS7/ro1+ykm+RdeutCXftoxj1EQCWqvE=;
 b=L2OgMa/AE0NC+1OzQdNQJ81N+g9vKT3DjhLZ14hXYJ4LilD8JsmCCK/Z4MOD6g97aP
 gMZtrNhDwz+6G42mAxsqibBATyF2fmppy5VUixYlGkpvAmaGPDAEuWNMYZ4SQker1HSr
 RPNXBbpbCTCYCy2co7i5gR2QABNUIC6GyZQMN+aAwyTUEYo7r+dy3krknjFmBTCb2lye
 M1HY8L+c3FF2RDmXwomlA82fvzbONlipdM1pEnmj/hitI0Y5ThpZVj7PFzvLEszUfYPD
 5iwFcRZrLAUjRJwMofJBm9Wf+9+AtjWpiQZftA6cuNkV7Rbr0dpc1bUmyDjTtmFsJLZ4
 rVgw==
X-Gm-Message-State: AOJu0YzAa7xMfk0E1y+fYKCvldFZOqZIFiGOO7UPFmuFupYMmRK5mRG+
 ZltoUQRVr8excnnA2DAI2cVsNxLJoSFHqtQQg5FtG4jGsxLgBeRZGh91BWNWAIyS2RSLGGG1uhi
 alhM=
X-Google-Smtp-Source: AGHT+IEBpIyLlO16pgWXieYAbkU6dvgAstujjFoyknlqICADJ2UeirTJikohJBuI2D+1s/YmT4fG8Q==
X-Received: by 2002:a05:600c:3582:b0:418:29d4:1964 with SMTP id
 5b1f17b1804b1-41fea539b5amr109852045e9.0.1715759585480; 
 Wed, 15 May 2024 00:53:05 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/34] target/i386: Use translator_ldub for everything
Date: Wed, 15 May 2024 09:52:38 +0200
Message-Id: <20240515075247.68024-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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
 target/i386/tcg/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ed601474a9..76be742580 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -23,7 +23,6 @@
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
-#include "exec/cpu_ldst.h"
 #include "exec/translator.h"
 #include "fpu/softfloat.h"
 
@@ -1579,9 +1578,8 @@ static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
          * This can happen even if the operand is only one byte long!
          */
         if (((s->pc - 1) ^ (pc - 1)) & TARGET_PAGE_MASK) {
-            volatile uint8_t unused =
-                cpu_ldub_code(env, (s->pc - 1) & TARGET_PAGE_MASK);
-            (void) unused;
+            (void)translator_ldub(env, &s->base,
+                                  (s->pc - 1) & TARGET_PAGE_MASK);
         }
         siglongjmp(s->jmpbuf, 1);
     }
@@ -2177,7 +2175,7 @@ static void gen_unknown_opcode(CPUX86State *env, DisasContext *s)
 
             fprintf(logfile, "ILLOPC: " TARGET_FMT_lx ":", pc);
             for (; pc < end; ++pc) {
-                fprintf(logfile, " %02x", cpu_ldub_code(env, pc));
+                fprintf(logfile, " %02x", translator_ldub(env, &s->base, pc));
             }
             fprintf(logfile, "\n");
             qemu_log_unlock(logfile);
-- 
2.34.1


