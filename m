Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71645C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6ph-0002Wo-Mo; Mon, 17 Feb 2025 14:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6pC-0001zW-4l
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:45 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p7-0008RJ-WA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:37 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2210d92292eso55117045ad.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820631; x=1740425431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFWOgm7cwZ/f43Ltoxf8K/SGg9Wf6xR2m2O9XTNwnuM=;
 b=py3+qOk7syXPF+Vx8Yd9T7Jc2VAx+HQzwY9K9G+ICJYyFYTI3MSoY0231at7mUpISc
 zoAST2QxxB2Pfb5tUY63OhibXzvA7/4P7+trJXUiD4jDhvWcBiqlR82Uaxub3MW8ni+v
 QBcSQCW4R10lo7daNCSJs6a2P2VIVYgZmnZApIuZvIpZl0AEv9w+8tflEHoiEG8JcJah
 O/um5DdoCSxPguxUr7bLTqUFjxYxQvjyr8JEZb9x5DO/T5SQ0B3DaroparLMvb/8z7hY
 VKkkdtEK9OCktClLCu0GPet9/yLByLSQ1onlxDvd+knpDG+lMDU6TRGlFWb0MsDvpm4F
 ts8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820631; x=1740425431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFWOgm7cwZ/f43Ltoxf8K/SGg9Wf6xR2m2O9XTNwnuM=;
 b=SFjRj9WRU/dmciCUsPwj/4DQBGtsx7mi5AUHpvRUIQXfGJcxjIw+k8IvwLxkW56CLY
 pVowv36C9SNPI/bRf+qxCB6WcLBL0vC4KJiYBteYGlBFqDW2IeGzIQd9wTtkwz9yMkJA
 QGzP/5HF9I2Q373AGrSFT1tSc0S7Tiq3/EnM9RELLUBoaYE1JPl/8eT2Lommike4VCAX
 3B/+qbiUu8g26+xqbDZ6jhYsWGfDl5ChiYgCLWA/ipXttIzaLiNHYjcM1KK6OkERhjTI
 r6U7B5tKxAjPKUUSHAuTAv7uLXJVDURlEaJlq2OS5kN095vhrertO11sb1f2TEeqmOZp
 2c7g==
X-Gm-Message-State: AOJu0YyRO/VIOPfROQvRx5MToSLfoo07Bb3zkVZXmGXBq3Erbi5oI07X
 F8T3cBmB3rwdFvzs3k+6495in3fkK5IOlRbckJSN9L9gf8fq3j4/FgihC0H3cXnx2dmNrZzuWtn
 +
X-Gm-Gg: ASbGnctMcxeu1hdJPJ7+xz6s+hhvLFxlKDhvwyHnPyb72x6vaWzvF16vMoqvLt/Ll+I
 VIlhjp4Ttuzdq2opdX0Ere/XcLHvXJRE2u+xjh/PnxjeS7/BBTe3aa9ctp3IgW2PXxdPWeYhaH7
 3YgAkFPsNxNgezP8VyhbbiJJ9WqnI1b/YfeZdmk2kx4Jb6iFvDOKoqcYUPRX9nJ7iVqVxeDhk56
 rik1iZ1GLM0EdrKU4HYqr2N8t4ExwdP+ApiXNkLhRMhs4+EGElL7iezBLLtUNAZOIh3fZ2P6/Sa
 kQqd1XEsOnzFC2xqKnOYpq3gIRGZlcrHD2o3ozVaJb+qYgM=
X-Google-Smtp-Source: AGHT+IHrWc0FTXB1+oHnU5YY/o7KhQhHBKN6AFcNMEVrvrf/KGVXTU91Va1YimTyAtkvWKOfhyqLQg==
X-Received: by 2002:a05:6a21:999e:b0:1ee:3b8e:3439 with SMTP id
 adf61e73a8af0-1ee8cbe597cmr20099790637.38.1739820631380; 
 Mon, 17 Feb 2025 11:30:31 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL v2 25/27] target/sparc: fake UltraSPARC T1 PCR and PIC registers
Date: Mon, 17 Feb 2025 11:30:06 -0800
Message-ID: <20250217193009.2873875-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

From: Artyom Tarasenko <atar4qemu@gmail.com>

Fake access to
   PCR Performance Control Register
and
   PIC Performance Instrumentation Counter.

Ignore writes in privileged mode, and return 0 on reads.

This allows booting Tribblix, MilaX and v9os under Niagara target.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250209211248.50383-1-atar4qemu@gmail.com>
---
 target/sparc/translate.c  | 19 +++++++++++++++++++
 target/sparc/insns.decode |  7 ++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e5c7351cb..bfe63649db 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2882,6 +2882,14 @@ static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
 
+static TCGv do_rdpic(DisasContext *dc, TCGv dst)
+{
+    return tcg_constant_tl(0);
+}
+
+TRANS(RDPIC, HYPV, do_rd_special, supervisor(dc), a->rd, do_rdpic)
+
+
 static TCGv do_rdccr(DisasContext *dc, TCGv dst)
 {
     gen_helper_rdccr(dst, tcg_env);
@@ -3315,6 +3323,17 @@ static void do_wrfprs(DisasContext *dc, TCGv src)
 
 TRANS(WRFPRS, 64, do_wr_special, a, true, do_wrfprs)
 
+static bool do_priv_nop(DisasContext *dc, bool priv)
+{
+    if (!priv) {
+        return raise_priv(dc);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(WRPCR, HYPV, do_priv_nop, supervisor(dc))
+TRANS(WRPIC, HYPV, do_priv_nop, supervisor(dc))
+
 static void do_wrgsr(DisasContext *dc, TCGv src)
 {
     gen_trap_ifnofpu(dc);
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index cfcdf6690e..9e39d23273 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -96,7 +96,10 @@ CALL    01 i:s30
     RDTICK          10 rd:5  101000 00100 0 0000000000000
     RDPC            10 rd:5  101000 00101 0 0000000000000
     RDFPRS          10 rd:5  101000 00110 0 0000000000000
-    RDASR17         10 rd:5  101000 10001 0 0000000000000
+    {
+      RDASR17       10 rd:5  101000 10001 0 0000000000000
+      RDPIC         10 rd:5  101000 10001 0 0000000000000
+    }
     RDGSR           10 rd:5  101000 10011 0 0000000000000
     RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
     RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
@@ -114,6 +117,8 @@ CALL    01 i:s30
     WRCCR           10 00010 110000 ..... . .............  @n_r_ri
     WRASI           10 00011 110000 ..... . .............  @n_r_ri
     WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
+    WRPCR           10 10000 110000 01000 0 0000000000000
+    WRPIC           10 10001 110000 01000 0 0000000000000
     {
       WRGSR         10 10011 110000 ..... . .............  @n_r_ri
       WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
-- 
2.43.0


