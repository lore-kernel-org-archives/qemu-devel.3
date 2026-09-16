Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B629C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNe-0007HH-Vt; Wed, 16 Sep 2026 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNF-0006k4-KO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:37 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNB-0001Qh-OP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:27 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6b1ae6a9960so807270eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564104; x=1790168904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7LYdt6m7FB14qiKEL+WXglE6YcOPLNsRWr1SK6gRz3s=;
 b=HK5SONtugIkTNqb7r6rmNdCb4TULOjrr70zX8vUnxwcB9TNbHT0btsTjVjDCvsdY7x
 ByB9T3EVHHuMeCrnxM5uzgxgAoS8uqd9I2G5f7E+bqIL6aYnOMjrBnRVLkt4xWl5k2Iw
 eYIewI9u6Uj2x2CsKTmg5A+i8cEooM77weHsnoGD4nJaHxYlWCQJ6w9BaumwlpkHrVJv
 +jNidbolHnEfQcU7Re2HqWzaCsr4P3CpFljxED1PiX8nwg69qtxWvtCjLpep/KdujsEz
 ICNqp230Lmwm4eN1K37vB+H5uDuYBGkp2EoeqDca12sMTtPfCuwmDuEo/CYENTo7P00k
 LFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564104; x=1790168904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7LYdt6m7FB14qiKEL+WXglE6YcOPLNsRWr1SK6gRz3s=;
 b=d24bDYmw9hWIy7LyHGQ/xrT0ZAWk+E/6cEQDJqnnEh04k7c4xAANszyvohVCj1+p8/
 Vd5j5PyqAsCGtdmmWGof62JYW3Khz7oXpbhCcc4qe7nYsrNPDjfI9jHledpCPoan3GCw
 IA3oHegoRd+ahc/j+5kTeyHW8Qsv4E6FHMZ65hFvL0n8e91n1ETuhl1Emj52Mh2WIj5z
 8MQbrD8n7k5F4qvvAcQz0XNngdvG9qwtKdZ02VZwk8fkBAU0BnPLzkL7AygzMAb7mr7S
 N4OHa+WWzNJ2QiersROzMNXI+9etiCgqS3zDohT75AxnuJNp2M1H3Jo3DlOCl8JCFH2j
 +8jw==
X-Gm-Message-State: AFuF++kAPRtQyQC/44Pck4LksL84a7JL7UMSYdAfuRW/a90ixmdeTW5+
 0BT0kKcLbGbrFHBeVuRGms+9IUgJ29a9kioiBZoONYOnXpa7fLMrOdaJYoxXZWL/6Yw05jEePIx
 YObcYSdc=
X-Gm-Gg: AYBFou2cCjDKa39jVQGcWlVacBKINiRXuyBYc9q4NrZzsdj6ImLojt3XaWEF4sGIqmx
 bZP01UksAU3G+2moaEwcx6vXXXUJeDxSxUxLwtTwV0QhySSjuCtBU6LcrUVVu9Q5c0xuqjXv0Fw
 ljkFDhYpMA9SS6US0KJahA8G+0MPakNTlk24yDCoQKf4UlAyieW3TUdRQLF2MMB7NNXtu6sH/K5
 /Qo0SChro9thZtyFKV9NxCP860HfyET/dtOd1PldrLHBIGqrPpMJomPmMfCKkt2M9dKIIVdtMwR
 UlMA2KO/tIY0eKxYpDQNuZ1eebyNgT3OzT5YiKycGPcu5IUsF/SuCNw9sPWerdE9LWfj2kr3IYP
 KmOfq5ypmn46/wb+Kc+coaolaT02aYKGHTYonpvlTBAw9GmBhAAlD+Mt6q3amWvO+Z1CVvWspWe
 HjIN8yW4dfUgEj3PBRSxbhBm8XU364Uq0DBQnPG9GD0+WCFxaBbQFifw9ltKSQM61fKenEtz8y/
 tnKU2s=
X-Received: by 2002:a05:6820:f02d:b0:6c7:cd95:f107 with SMTP id
 006d021491bc7-6c7d1bc8413mr3007242eaf.21.1789564104035; 
 Wed, 16 Sep 2026 06:08:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 50/92] tcg: Split out gen_ext_i32_i64
Date: Wed, 16 Sep 2026 03:03:25 -1000
Message-ID: <20260916130409.3382710-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0c.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 710483f6778..6c106122f6c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -413,6 +413,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
@@ -551,6 +552,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_ext_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
@@ -2307,8 +2313,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_ext_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
-- 
2.53.0


