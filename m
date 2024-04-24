Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2CDC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5v-00062I-Em; Wed, 24 Apr 2024 19:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5o-0005zG-4Y
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:32:00 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5m-0003kw-3Z
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:59 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5f80aa2d4a3so374670a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001516; x=1714606316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFwVHeO0xdQZE4q/p0sWN9ZrSqg0kbbJP7VPGYxlODk=;
 b=aKN/BtH7f0SwgqWPEu9bNYSFZ5duD4NI1gtb8SudsqpXHgT95y3IT73UdrcwLtVZd3
 vLs/FHsGP5gu6eaZRPAgoHi+hgju/e2bU3/lcg/GbfgxkKljmkngcnmvsllHB9G5O7QK
 iEKT0iKu3qenQPZv9wEKGZxblxG03XiNRLjrelfJ6U9hBdP3q66TF7X0GU87/8rj9F/V
 XmjZN7CqHoHSYy6QNlp3kOGjhBN0+iDPvuQQFlXsINqq6hJQvlKz90GbhjeJHMa2U4of
 M9davGxNgSHmY3MQDT7I/tTFa1AwfGP6JSlXy8++cTfDVHh5e9tpELvQfC6sDZzFLIVH
 POAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001516; x=1714606316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFwVHeO0xdQZE4q/p0sWN9ZrSqg0kbbJP7VPGYxlODk=;
 b=thqBm6cbKEepfo3EGdKOrWFwVJ0gsKSmICYJ8aiDv7sUWPTozLMhqaeu/dnDZ+MjYb
 FUE7F2ij4UsaGJvZKQLY2v0PSCPE4G0msDjxFkx7CfujTfksFN9NK3PJMO4IwanBBMmz
 44N+mr73xtp+e2LKIcn/kL4ZRv7ML9BV/CapGMsUtQIeHSBarhfdHFrbWn4jLEA1d3bv
 4gk8pw4kdoPwAGNEtmGxlC3j3hSQIXE0lv5lGWGEHFCHzjENoHlc+LyIctsvq/ug0Co2
 hEwIfEyPT5PZGk0kPCenmHWVoMoxYIE/H37Vdc2B7JE8ONZnlRv28ypk4AaAQzcmkHhA
 5xZQ==
X-Gm-Message-State: AOJu0Yzqu5b+isNA3XjOJ8HsRzhPRHIiQjqdKvnwSsPSB4fRCNqKQxOX
 a/k3/Pib/XHEffYPBNVYOHmhHuiwwyDcQgaB7WvsMuHNbuVkMdJLL2B63MOmPielQAz8sEvKdkz
 g
X-Google-Smtp-Source: AGHT+IFaWhXWjDuTEJ8mgLBztbul2vSHTmordR/CcoN44RzPAgXfqSlULJouRb5UkgzxzmkdWgPkYw==
X-Received: by 2002:a05:6a21:880a:b0:1a3:65af:9baa with SMTP id
 ta10-20020a056a21880a00b001a365af9baamr3714878pzc.62.1714001516676; 
 Wed, 24 Apr 2024 16:31:56 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 27/33] target/cris: Use translator_ld* in cris_fetch
Date: Wed, 24 Apr 2024 16:31:25 -0700
Message-Id: <20240424233131.988727-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b5410189d4..bb2d6612ba 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -222,37 +222,28 @@ static int sign_extend(unsigned int val, unsigned int width)
 }
 
 static int cris_fetch(CPUCRISState *env, DisasContext *dc, uint32_t addr,
-              unsigned int size, unsigned int sign)
+                      unsigned int size, bool sign)
 {
     int r;
 
     switch (size) {
     case 4:
-    {
-        r = cpu_ldl_code(env, addr);
+        r = translator_ldl(env, &dc->base, addr);
         break;
-    }
     case 2:
-    {
+        r = translator_lduw(env, &dc->base, addr);
         if (sign) {
-            r = cpu_ldsw_code(env, addr);
-        } else {
-            r = cpu_lduw_code(env, addr);
+            r = (int16_t)r;
         }
         break;
-    }
     case 1:
-    {
+        r = translator_ldub(env, &dc->base, addr);
         if (sign) {
-            r = cpu_ldsb_code(env, addr);
-        } else {
-            r = cpu_ldub_code(env, addr);
+            r = (int8_t)r;
         }
         break;
-    }
     default:
-        cpu_abort(CPU(dc->cpu), "Invalid fetch size %d\n", size);
-        break;
+        g_assert_not_reached();
     }
     return r;
 }
@@ -2868,7 +2859,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
     int i;
 
     /* Load a halfword onto the instruction register.  */
-        dc->ir = cris_fetch(env, dc, dc->pc, 2, 0);
+    dc->ir = cris_fetch(env, dc, dc->pc, 2, 0);
 
     /* Now decode it.  */
     dc->opcode   = EXTRACT_FIELD(dc->ir, 4, 11);
-- 
2.34.1


