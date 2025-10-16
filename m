Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF5BCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mw0-0001Za-JW; Thu, 16 Oct 2025 08:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvW-0007xb-6b
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:54 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MvJ-0008Lg-32
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so7153845e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617052; x=1761221852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=//mKgxzof/W0xVoERLCS4ck77OJM/9ukAggRxSqvQpQ=;
 b=NrziuyRr6yIl0tK3xS5Su6uM+fw2Go8IJKc0iwxtgwL0uBJIywPZr+2nYVrKmcoWdq
 y/V2MXZMpWY9419qTz8oJtP7IQh9d4pojTN3cZ24yONH7BD2KL8WwKP4duflaXgrCHHi
 qXIk1+FzQlo4oTNj9wBeUJlvazedymBJq2Lylg/jcGPUz71WhxdyYRBZzcUPug3PTspq
 WwxqM7GOudM6qTQ+28xjVHkya2NCQk7X41+phkU+Fy/TuZgDYVC22kXmt9OB9D2oAcAW
 28IScZbk1dwGrZmbLLtnhdcrNlPulNOl/uFWj2YJpstqMNrywn6Y/9CfPkPIzxQjZhyN
 fUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617052; x=1761221852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=//mKgxzof/W0xVoERLCS4ck77OJM/9ukAggRxSqvQpQ=;
 b=Mx6DcupmHb6Z65iKNweP2U8j2e6CLUqvr9Uw/SSrnBIn1MIRWqBRwgPcjsEj48a8Ax
 YYP4N1fqs1AvefWS3u/WqwegLRYMPOWEHrvY6O4xD9EtMj4y6jM/NL9UNwwf0buKfUCT
 MiT9Nuai6+4V6bNBaYXwsElqEOloidYa6toVJF+QtujebNTH4olQ1fB2VRXIMdZ698fG
 w6GL0bDtUPdB4XGqXKTrxKxEKALNHutiTYYfyb6zTH0Jk6+wYIiDnb1Yo2rqp475w9U2
 Tg9H6QwNs/DU4sbVMu0DHwNubfZQUwjjx6DyuSU0Kvskozf5K1dHz0OOWd/tQXbS2KtP
 JN0A==
X-Gm-Message-State: AOJu0Yy7ntcEFfzYU3HQOAhFsFLtA0FVQwq+YH4iKnvujVEJdsU54YYY
 ctUuFT6i/vsVk4Nd4VxfqUqMmGYeTVq6HoGIoZpYwxFxtBrPfEacK0zeeIhqCqLUVgaE8mCMlma
 CqG9l+eE=
X-Gm-Gg: ASbGncv43nLQgbMmQ8YS0p2c824EPDlDUQUTfrR5JefjXwrwl8ItglFfz6B6c7wqA8f
 sezDT9cbdSHUah7WY9A1CJ8E3lV0ux1oaU1rnFO6zxo+MJ5D61+PjNPpac3FWa3vGCAZnyBCXoU
 g/Dxt0ntFFStYSQ0+VSOJRzlOJSFrioFJynCvZMwFHvxHUsRSDOy5F3kQPW7n6LjAYuJaBCT9RB
 Z4gWN75XWFQOv7CWlqFiozyan1JyMzIXH1dw0cTedjpFRfMdE17bE59tHXqsrbKVOS+ITuaSHrQ
 +XBDspJ4Ol9dY2LUCVlxbtvVttk5ZOzqYTdS086eGgGUb5JqXU55dtRFQGFqAcRn2nBq1tUJjqF
 Nrb0jfc9d/Xb1Dyns/il2lBolrgLXIBPJoi3hhX2bReOIzf3QmQOoCUmyO6UywXVDNlVj9/7l3w
 XhXy93iIJsUfizskGD0or6xFIeXxbhkMOR95B0QorH/zQ1ue4lOO/q1krpN6UQRXis
X-Google-Smtp-Source: AGHT+IEawUtiFot9BhpTKaiRpwAgRn5lo39RbFn1Cs4QNlst86APZ33pSKp3fhm9sot/BF7BnOJDJA==
X-Received: by 2002:a05:600c:608d:b0:46e:42aa:75b5 with SMTP id
 5b1f17b1804b1-46fa9a8f636mr238792915e9.4.1760617051474; 
 Thu, 16 Oct 2025 05:17:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42704141cdfsm1162141f8f.4.2025.10.16.05.17.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:17:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/75] target/microblaze: Have do_load/store() take a TCGv_i32
 address argument
Date: Thu, 16 Oct 2025 14:14:41 +0200
Message-ID: <20251016121532.14042-26-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

All callers of do_load() and do_store() pass a TCGv_i32 address
type, have both functions take a TCGv_i32.

Suggested-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251015180115.97493-7-philmd@linaro.org>
---
 target/microblaze/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 1554b9e67b0..ed53848bad5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -708,7 +708,7 @@ static inline MemOp mo_endian(DisasContext *dc)
     return dc->cfg->endi ? MO_LE : MO_BE;
 }
 
-static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+static bool do_load(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                     int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
@@ -726,7 +726,7 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
             mop ^= MO_BSWAP;
         }
         if (size < MO_32) {
-            tcg_gen_xori_tl(addr, addr, 3 - size);
+            tcg_gen_xori_i32(addr, addr, 3 - size);
         }
     }
 
@@ -868,7 +868,7 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     return true;
 }
 
-static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
+static bool do_store(DisasContext *dc, int rd, TCGv_i32 addr, MemOp mop,
                      int mem_index, bool rev)
 {
     MemOp size = mop & MO_SIZE;
@@ -886,7 +886,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
             mop ^= MO_BSWAP;
         }
         if (size < MO_32) {
-            tcg_gen_xori_tl(addr, addr, 3 - size);
+            tcg_gen_xori_i32(addr, addr, 3 - size);
         }
     }
 
-- 
2.51.0


