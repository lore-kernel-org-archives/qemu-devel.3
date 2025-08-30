Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8FECA1001
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNyz-00077h-5p; Sat, 30 Aug 2025 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERE-0007Ox-4L
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:45 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERC-0004zG-Fp
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:43 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b482fd89b0eso2396331a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532861; x=1757137661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Puj47LzXnLjLJ6PpXBaEU69J8yF1nDWaKunYAxIVNeM=;
 b=caLHPpigPcRosc0If56qfxy63FjsQny19BHCIL+l491tiCk8TSa3jTggA+NdUBnxfm
 Fi4MJAlrhhPwY4tsIdXNy8OUx5IHVVUI1m/28fiowest1Dqlj5l3JkEaRyqpemIMWAcJ
 MK1BdOSWniBYfd4a/+REPq/EOCyVaxLIvuPGmm9BbM0rqLbvF7s3V4of+B9Zymfoo4gV
 S3qF3MbUo8zSW151+wvymgmvOKBlgLKsofinOd0Lmrj4ZoTSX11ykWxwfFYAKWWZDzMG
 WlAQxikHuJ/4RVZJr/Fbz6r6iLu+IiLWRmma2CULAeyor9PbKowbLDpI1xnMNtMEmAxU
 eoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532861; x=1757137661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Puj47LzXnLjLJ6PpXBaEU69J8yF1nDWaKunYAxIVNeM=;
 b=xSakogs9iXt5W0j251st5wW8zQ5K88jLm8W7aoIRH8CgVjkrvTepjaL3K3Igo8xqf9
 x7J9SQ9FjzvpZ/T+0ur6z4KfV3gTdQ9kvyS7yDkAnG8l73BxRidhqrq9kH9z+iAo7bLT
 tx2FQMrWboQ4vyRn/teZ+NdF23aTID/wC4gHlJcmBmKc5affNNxjTbkNa2itgPUf8aCB
 6cwo8SRFpJLhZmXobIiJCmfORGikUPEIGxGdXgAm7bvymZvS0MEfTxK6mS35cSgZa8Zl
 htBLw11Ee9PvimKkXORfgb6I9T/JSfUgbPu9L7Pzcc59OL0Namm3NamYehyhuVUq7gh5
 8lfw==
X-Gm-Message-State: AOJu0YzJDd60fB8OWRV1lugPvL5eVpH775QG1Y4knKeGT+p943nwRxmD
 45rZuKbObAspU0MfjNxdZHrNwSFA3F/BBEQGISn14521C3djLLP4JNS4AQJ1jUotyGLRTqx8GjZ
 JzWGzxCM=
X-Gm-Gg: ASbGnct4mE50aBoPnC3mblCB2MfVKMbDNY1zKnImOV9q2HnZ7P0xykiadnNTWe5P7k+
 Xzo6lrBCk7vqnGAS39ldkLHgETTvPsbC5duq18QiB2MzaCFySoN+lNrfwlSobtKEl1edLtG9gKZ
 nVcdFzO4DLBxrZDNbivxq2JSz01Bt20WgDMPHPv0PVJxTm0yiRmOXVHfQbkM8v0p7PdNPfZTz26
 q7Wg2n0BFr499tCHqGSrXhVwFaRclIYiP1B4rGzXTxPQECXNJDencEM0yZRZRpzIMDStYdhz/gv
 U0h+43iqJT6mEFe+SIK7uvNBakhTOAIWTVztGZyJiNzqAAz4KSRLON+Uku8h9nKiKGf782zBNjA
 XQq5qa+4BdcuXPWWekYTec3ks/N6HvzaSoSVGDwWtxD6ka3AUyKIjGLx1i/RpJnans/yQwQ9qbQ
 ==
X-Google-Smtp-Source: AGHT+IHsQIH00eycoTvaTg8dyKi3F5s1YOBCHYHdHD5dI4kh9ptsi7e8PfHV5hlMpsJXTxtv8Q55TA==
X-Received: by 2002:a17:903:41c9:b0:249:147:95bb with SMTP id
 d9443c01a7336-249448de13fmr12519985ad.13.1756532861081; 
 Fri, 29 Aug 2025 22:47:41 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 66/84] target/arm: Add gcs record for BL
Date: Sat, 30 Aug 2025 15:41:10 +1000
Message-ID: <20250830054128.448363-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 481e748ce0..336aac9d1e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1678,7 +1678,14 @@ static bool trans_B(DisasContext *s, arg_i *a)
 
 static bool trans_BL(DisasContext *s, arg_i *a)
 {
-    gen_pc_plus_diff(s, cpu_reg(s, 30), curr_insn_len(s));
+    TCGv_i64 link = tcg_temp_new_i64();
+
+    gen_pc_plus_diff(s, link, 4);
+    if (s->gcs_en) {
+        gen_add_gcs_record(s, link);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 30), link);
+
     reset_btype(s);
     gen_goto_tb(s, 0, a->imm);
     return true;
-- 
2.43.0


