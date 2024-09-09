Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F41ECE584
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniC4-0005GP-Ci; Mon, 09 Sep 2024 13:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBv-0004ip-Jp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:43 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sniBu-000636-0o
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:28:43 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7da3794b778so518484a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725902921; x=1726507721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wt4kGF8GHbs588bZ69TT9rn29gOCtaGr5vvJ3Kk3h8A=;
 b=iSpym8J6rnjRg0kjZjMQHs2cISumBSYkE6XUJwujHm7Qv10U/y6fDh/iehtjXCC55q
 0AOyjRgO20CscmqH/9JuscrVAGPcPCRWW3n8WFZvjVe7awpODO6Hw9m/zg2bcEnQV5V4
 4H2CTLU3SYJNrhjehpteS/m4xxTSmOqphfPr43iKljsCMUSkdadmebSj+kMbMlR5xGY0
 d8G3y3CQ2ckeDJP3Bn90TRAjfo0QeMRaSGaCk5SWK8A3lWgLS6nwRe/ncWxDmVzjIhAB
 XCoHjfc/4l2slycZrBI1RVv3GHaPhHmkpmKZcfBjdeZOKyDZN5yl4eR6Li5ykJkPTY0d
 SMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725902921; x=1726507721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wt4kGF8GHbs588bZ69TT9rn29gOCtaGr5vvJ3Kk3h8A=;
 b=PqaghrPgPRgpBpLQMm7bbMj9WTR2KUDnGdqj1Y5mwwXq2i7AyYuqx0m/T2UwWTSMZb
 BrLoxN9mIyUqOoxgVyZxe8ome3MB2AJmbANgfOUOlgl2wDRnfrb4GhUKCTg9DHRR2vUT
 8OnQsLDUMTVPHyQUBK28Y4lnPqS+F209HVj1k7UPiQrXsWnYO+tJqoJ9VQqbcpxbdcz3
 3WUFEIG+Gll8Va3AlCDy+JQ3LxUJFaqhYh4bPEARZsh3otM5U9i0HSdCItny2yFEau+o
 u4pae8T2CB8kVPK/TWZYGjB4IcsBOhRj69dt98mG1pvoQv0GhscOReEYxqq/b8R9Ttsi
 6ruA==
X-Gm-Message-State: AOJu0Yz6PMNcs2SBIIhIuIfKbq/9GwmxaJnEIdInvX0wp1MDvVKm/kQ0
 b7+q2Eh7pYP0s0Kbiq4VCyBwqqy/6dKBUujbAIuKpp1cXLP2mB/qT+6zxd3arve6xKnRnEVcL2n
 r
X-Google-Smtp-Source: AGHT+IH6VRJvSlEz623/dxfL5QA+l85CmSEaUhXzygox/V1pSLd8BMXNuoNZlh3hJjI4T6z1ZEGiQQ==
X-Received: by 2002:a17:903:230a:b0:206:c486:4c33 with SMTP id
 d9443c01a7336-206f0522330mr155438205ad.30.1725902920626; 
 Mon, 09 Sep 2024 10:28:40 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e11e02sm36539875ad.14.2024.09.09.10.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 10:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	daniel@0x0f.com
Subject: [PATCH v3 17/26] target/m68k: Remove env argument to gen_store_mode
Date: Mon,  9 Sep 2024 10:28:14 -0700
Message-ID: <20240909172823.649837-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909172823.649837-1-richard.henderson@linaro.org>
References: <20240909172823.649837-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Use the env pointer in DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a3452ace96..8a96b38682 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -843,8 +843,7 @@ static TCGv gen_load_mode(DisasContext *s, int mode, int reg0, int opsize,
     return ret;
 }
 
-static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
-                           int mode, int reg0, int opsize,
+static bool gen_store_mode(DisasContext *s, int mode, int reg0, int opsize,
                            TCGv val, TCGv addr, int index)
 {
     TCGv reg;
@@ -1334,7 +1333,7 @@ static void gen_exit_tb(DisasContext *s)
 #define DEST_EA(env, insn, opsize, val, addrp)                          \
     do {                                                                \
         TCGv *addrp_ = (addrp);                                         \
-        if (!gen_store_mode(env, s, extract32(insn, 3, 3),              \
+        if (!gen_store_mode(s, extract32(insn, 3, 3),                   \
                             REG(insn, 0), opsize, val,                  \
                             addrp_ ? *addrp_ : NULL, IS_USER(s))) {     \
             gen_addr_fault(s);                                          \
@@ -1703,7 +1702,7 @@ DISAS_INSN(abcd_mem)
 
     bcd_add(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1737,7 +1736,7 @@ DISAS_INSN(sbcd_mem)
 
     bcd_sub(dest, src);
 
-    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
+    gen_store_mode(s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
-- 
2.43.0


