Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBCDC02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1t-0003zK-6U; Fri, 17 Jan 2025 13:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1r-0003wr-SG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:11 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1p-0007qm-Sy
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:11 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21654fdd5daso44789195ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138307; x=1737743107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHTGG97acyPD34Tp+rqh/MGzijUGRlOPz3TDCzFvbmE=;
 b=wvDgaX1CZMgqETr9C8DS0SFJaEHe1T0EuKoYjBQ00VXt50/0TttO3veqRA8Xr6xcfA
 SlBzReCiJ/6EkIOo0MuN5k0RBvz0KDAAPyvXQiRxP7aIA2YLf03huxEYejxzsRlpIHi7
 I1dWEQCsddLODszYqrxrJRjE/CH0pXEmpu2+PDTcjkm9ANKWb3/ziR7/R8HxVsDsCM+W
 2pKRZIccdv4y0b8bd//VaPh/GaE1JppCvVsRDIQ2uw7SXim7usIzRT+LUoHycSLz3S/z
 wefFfoGvF8jjaoWZJrRdSATxAWUrUh0V/adRr7lClXiutZ6sP9iggR+7Yqs1ebV6cq1/
 EJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138307; x=1737743107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHTGG97acyPD34Tp+rqh/MGzijUGRlOPz3TDCzFvbmE=;
 b=cpiBWcDOFXHjMqLIBFCA0v/RJU5yeOximVsQr2GdXHx1BDfdMl6pM1dgayfW5TJBp3
 duXR412Dy+AW+RH8LEN9UlJ4WZBnWTnu/1C3wE7M8xWZfHd8Q8Z8EborzcwxnM6n2PG7
 fQ4K3sgILPzHKv56S6jJwrR/lKFQj/zzNXhs5mP06mgHr50pObnpsLjgSwazrdtz0bWa
 ZfyJ9GuQp/VeE+mpiQtKIIgZVC4emVsi1iitv5VwBvIP2ZFYzXOyZvUwFZZt3DXI1/KU
 cynVo3J+2cqGLzkwc5nkWXpd0KkYsXZDvdx6hXRc/yWxngg1aiVt40MY+OECbNnTllE2
 GtBQ==
X-Gm-Message-State: AOJu0YyaYVdWPOahXAPwSwSKFIP3x3klMD+9xXhO02r3PbBDaXRRcp0K
 o0hwejSfiMuItH/vMh44p9bL02epUXN9FDypmBZv54Por5LWjwKQJn4eaot0fn/pLTxZAa6QfBK
 e
X-Gm-Gg: ASbGncsEcdwwzMbIJZsRWs7ab1uG+JshekY0jNM+RCYbD/sIuIbG7OHqTBTNj988H87
 rF8nd7hgMM/taYday1YiT9ALURez3r9YXeFkY7e/ZP+RdX7EIToNIgF5Zduyb+1I4W1FwGC7AOk
 ECr0bgdUrm34OAGxs2qTdYEtnqV+fjsiGWgWGA05s9BZ7iyd7HfUitPN73cRCJ4dI1TA8+ryEsA
 L53mk7Ar+R7isQ7lxZxeZDaTcOv7sgae6uz7GlYclAGQ8u5CkVnIGhT3lgijG6K+XxFjwkBJ9Oz
 cIcfdHou4gsBtyY=
X-Google-Smtp-Source: AGHT+IHz8XHiQyiyX/3oWdzP6xm5F2W+GU5ucJk340ib4Vahr3CDF8aMbknt2mg9T4tePdrt76lBpA==
X-Received: by 2002:a17:902:db10:b0:215:a2e2:53fe with SMTP id
 d9443c01a7336-21c355c7a3dmr58479905ad.40.1737138307566; 
 Fri, 17 Jan 2025 10:25:07 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/68] target/i386: Use tcg_op_supported
Date: Fri, 17 Jan 2025 10:24:02 -0800
Message-ID: <20250117182456.2077110-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Do not reference TCG_TARGET_HAS_* directly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a2b940a5c3..f305640182 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -24,9 +24,9 @@
  * The exact opcode to check depends on 32- vs. 64-bit.
  */
 #ifdef TARGET_X86_64
-#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
+#define INDEX_op_extract2_tl            INDEX_op_extract2_i64
 #else
-#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
+#define INDEX_op_extract2_tl            INDEX_op_extract2_i32
 #endif
 
 #define MMX_OFFSET(reg)                        \
@@ -2993,7 +2993,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_ld8u_tl(s->T0, tcg_env, offsetof(CPUX86State, xmm_t0.ZMM_B(vec_len - 1)));
     while (vec_len > 8) {
         vec_len -= 8;
-        if (TCG_TARGET_HAS_extract2_tl) {
+        if (tcg_op_supported(INDEX_op_extract2_tl, TCG_TYPE_TL, 0)) {
             /*
              * Load the next byte of the result into the high byte of T.
              * TCG does a similar expansion of deposit to shl+extract2; by
-- 
2.43.0


