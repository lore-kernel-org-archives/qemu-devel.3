Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87312CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mul-00072Z-IL; Thu, 16 Oct 2025 08:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuA-0006PY-9C
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mtx-0008Ad-PE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so6096425e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616968; x=1761221768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NfxBcgO17M8tjqMzSh6qKBBU3m8HNLtT0bm7HHfbtsE=;
 b=zgtKlDsM+IJTwle49QkIS7Hwwx8hV9gf6CZpvu9VJA70aUtX9mxFBWefivpwQafHTQ
 Q0RGfCHtaxn1IQ1kNuO9MxqxDRE/Fde3pzhF6VtXqY+5llETcS3W3xs5mGZJO16xiSiX
 Ei5ScJFXCRQY9vZyMmYa5z2iPCA2gxBueUwHqtgwvwL3+iBcM0ncyWoM3EGf+3Xd6/ub
 R6F/E6U7T+djHb3PM/eS+9Bw17pPaUiBn+OWavhw3a+G0C9fDDHmoLDF3JsOn3OEMfY8
 MNCdlMSGV0CxDynd6jja30wJEpBzX4K7LKvjfEPybOfaHm7diEKmc2pKsSJjnQxG1ra7
 Ap8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616968; x=1761221768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfxBcgO17M8tjqMzSh6qKBBU3m8HNLtT0bm7HHfbtsE=;
 b=AjRp7SzpiNpUFG7nVyjLmUYqAtHf7BJcuspK3BjMlV1YAHg04vT0PfOPNlDbmzKCBT
 Fy2V0a0QPhnObU7LIZ9+PSXzWMpHII8J0PrjScL813KcmC3ggIlAyVdJxbsagkowQivz
 p0O1SXu3NmAm0qDnxn2eA8N0n+GAsWhk1BWedkdfiDT4Fe8ADd2qwwcSSVZe6JfhX3TU
 JjxXkKpDqH5kWMxD3OBpnCaireytupGEdCqjT+0NGjCfi4L1DgmA3vvncpNvkwyOqsZL
 InUgnVd+VIKKbbwg8Z05I0VrlAXOI0TJqBS1Rgxqo+3V3f3R4Np9mqnX99QOGbhOnzpz
 Sj/w==
X-Gm-Message-State: AOJu0Yx2oncsonkCsdvtLY4ifQ/6FBpwQk4IFV63q8EqW+F9/zxvmPdb
 jDSffJyGHaZEWObMc0OXJ9U3zK8ldQcTo79c+Ju+MnSEat8gm3AlRWbPmQKs2z5a5Foq91VVJrV
 Dar4GjwE=
X-Gm-Gg: ASbGnctCnSO34he9qabu6nDVO4tY+UYG5e0Y1p5+vPRum9CujsVK/TPlmbxGREyRv0V
 MunH57PWOGja45uxa3vWg05gVdGISwIrKjKgc6eUtcUkWvLLs0QF5CePV7h6mTwvb2CV06m8rRk
 3MOzvxb5FTlj8WMoqLa/HHN1EX7c/nsg40Ih8hftze4MBZcFmocEXtb5eTIcXcnzRgl2v/OnN7h
 JBW/0vzmYl3KbkSwQFY+2IDtD0h60OqvRVqzDlnDaoPpAhnyqzazjItN1WmS494XN5tYSfB14bm
 232j8q+FhOAwhi40aeL6Eg5QKfft45cggbDxWb349/NPBc6RdE82aNNwKiXhWwa4ypnJ5g399+5
 bnhG9C/OGEkB9TQLfMbWfFC//lEX8ma1CkW7BmapnabdUqabxG5avO4pv8q8EWO1ncEA672k6kG
 AcvQmQ0/WFr6K+6rGb6g3D+vDY8vp+WqVwUkf5wdZv22zMXm/OsOoWfA==
X-Google-Smtp-Source: AGHT+IHMdyh3IcsAeIUS4HYPUYexCWSP/PdYZfAqYsDcjHf7DlpcHRA3I7ihyUwAR0bCM1iDxPGwZw==
X-Received: by 2002:a05:600c:8b76:b0:471:989:9d85 with SMTP id
 5b1f17b1804b1-4710989a0dbmr29749605e9.19.1760616968238; 
 Thu, 16 Oct 2025 05:16:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144238easm24968805e9.4.2025.10.16.05.16.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/75] target/hppa: Conceal MO_TE within do_load()
Date: Thu, 16 Oct 2025 14:14:23 +0200
Message-ID: <20251016121532.14042-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009101040.18378-5-philmd@linaro.org>
---
 target/hppa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 859c6cf5f9b..ee0c874342c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1676,7 +1676,7 @@ static bool do_load(DisasContext *ctx, unsigned rt, unsigned rb,
         /* Make sure if RT == RB, we see the result of the load.  */
         dest = tcg_temp_new_i64();
     }
-    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, mop);
+    do_load_64(ctx, dest, rb, rx, scale, disp, sp, modify, MO_TE | mop);
     save_gpr(ctx, rt, dest);
 
     return nullify_end(ctx);
@@ -3302,7 +3302,7 @@ static bool trans_ld(DisasContext *ctx, arg_ldst *a)
         return gen_illegal(ctx);
     }
     return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
-                   a->disp, a->sp, a->m, a->size | MO_TE);
+                   a->disp, a->sp, a->m, a->size);
 }
 
 static bool trans_st(DisasContext *ctx, arg_ldst *a)
-- 
2.51.0


