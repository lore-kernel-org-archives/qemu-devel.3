Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122E2C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raffD-0001g7-7R; Thu, 15 Feb 2024 12:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeD-0007v0-PP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeB-0003tz-Ju
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fd2f7ef55so13027525e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018541; x=1708623341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jpuc9Tf8aoArJF/7uRkO1Qjromk4Edv2+JcubZCRIDM=;
 b=mQmGyjVtPUC98AzeepiSJUWmNQNOMizMN9X4nxaL6zuiQl8kHMDHX4YFzx6slHcftW
 pU10uyFe0z9gw+b2kPYwZYAGS3TqF2Cmjsq8rCV/r92Siaq8lJqHQvMBAwCdevIV8FKP
 8vyumOcUYYx8weE4fj8TyGSvdaG6nznamplSQQ6mWELKAEgBNm2iJZOJ8KavJX6JH2m9
 XFpy2/35mm68yFVmbUqlJbBTsfZTyhfURPbJvcltXaqgWzFnonO9zMLFegQ/j63rjv8S
 ua1fVouwkBKBaFJjJ/tOc5nzHjfCaHaaUH4FMSk923vjV/dSPaSqhnpi9ogTmdAM/De0
 cdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018541; x=1708623341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jpuc9Tf8aoArJF/7uRkO1Qjromk4Edv2+JcubZCRIDM=;
 b=rc/7Qxw59tVJ0ye+OLzYfDa0OyIJqPvqjND0ngyq1RJSWKGj6NeuivZ+lq9M+xoKUK
 B6EGZt9kQXLXA6qzRaCprjvnpod5cN1N4OEnCp8kRz6jcenMf9SofenTIv65TaiEWbYu
 0j02G2MazLqnrXY0MeHf4C8XjTpLdnrvWQ4S8xe+gAjlPxpS8Q+XcXzEt4Sub8KRMLTp
 lZDdfDRlIHU5xfbg5/3LSnsfcsS+GmxgYPd/nXGsQq85ROr1dkBsCmV5C/TrdLKKjs8S
 ruwrWFNapcqt7zBhmC6YytxERa9JQQNSzudM/CFP2tQHRk59RbD/X+3ax7CqUvoFqDHv
 idDQ==
X-Gm-Message-State: AOJu0YyIIR1VrNu9MFCP2JLofaUpiuuQu1H2oCQyiOf66n397unG5rvr
 8anMhiRjVMpAIy6nXbV8A3edmpM6vvuPQ8lSBzYtr0tk4ViYQnr0cQ8IW8lah0jouyvaPRgAo4M
 X
X-Google-Smtp-Source: AGHT+IGDyVr0f4R6HeZWmsmgyjw+rJ8MB8rq5V1UaZiHAeFS0o/xUQnkJlQ1ZRPVN6SV37LOxEzSNA==
X-Received: by 2002:a05:6000:69c:b0:33a:f503:30b3 with SMTP id
 bo28-20020a056000069c00b0033af50330b3mr3505909wrb.24.1708018541049; 
 Thu, 15 Feb 2024 09:35:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/35] target/arm: Fix nregs computation in do_{ld,st}_zpa
Date: Thu, 15 Feb 2024 17:35:06 +0000
Message-Id: <20240215173538.2430599-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The field is encoded as [0-3], which is convenient for
indexing our array of function pointers, but the true
value is [1-4].  Adjust before calling do_mem_zpa.

Add an assert, and move the comment re passing ZT to
the helper back next to the relevant code.

Cc: qemu-stable@nongnu.org
Fixes: 206adacfb8d ("target/arm: Add mte helpers for sve scalar + int loads")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 296e7d1ce22..7108938251e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4445,11 +4445,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     TCGv_ptr t_pg;
     int desc = 0;
 
-    /*
-     * For e.g. LD4, there are not enough arguments to pass all 4
-     * registers as pointers, so encode the regno into the data field.
-     * For consistency, do this even for LD1.
-     */
+    assert(mte_n >= 1 && mte_n <= 4);
     if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
@@ -4463,6 +4459,11 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         addr = clean_data_tbi(s, addr);
     }
 
+    /*
+     * For e.g. LD4, there are not enough arguments to pass all 4
+     * registers as pointers, so encode the regno into the data field.
+     * For consistency, do this even for LD1.
+     */
     desc = simd_desc(vsz, vsz, zt | desc);
     t_pg = tcg_temp_new_ptr();
 
@@ -4600,7 +4601,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
      * accessible via the instruction encoding.
      */
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, dtype, nreg, false, fn);
+    do_mem_zpa(s, zt, pg, addr, dtype, nreg + 1, false, fn);
 }
 
 static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
@@ -5168,14 +5169,13 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     if (nreg == 0) {
         /* ST1 */
         fn = fn_single[s->mte_active[0]][be][msz][esz];
-        nreg = 1;
     } else {
         /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
         assert(msz == esz);
         fn = fn_multiple[s->mte_active[0]][be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg, true, fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg + 1, true, fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
-- 
2.34.1


