Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA64CC41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm0-0008Or-7W; Sun, 26 May 2024 15:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlx-0008Is-Us
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlw-0007gU-4O
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:13 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f47f07aceaso6020925ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752591; x=1717357391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3TrWiWfbhfRDglMbr7omJW7rWrBNKn4wgYmHvr3JBc=;
 b=xUYTa2CIidydHlhW2FszT6MikE0n8KiffJNH6YrXlfVxTdRwOYrF3l7Zo6A4pGQnt7
 VbXspHqd4Zs+g4w24PKxmFo5onQrAClitU5XkLmsxuaJD4rOoJkdt81CG1AouEK5eKpW
 8j4lG+uDATLHVzo5y+o0hhMtYaLgf2l9HKsyGP0gfLmBGHD0AFHBVK9VLHQN+Echcvbf
 HtqTfn8Hi8/nCxma3+bOK41+wONbExZE0kDDVTI18sjFP+yeNy2WP57RLpxE5sdVqr0H
 iwMCuWaec0pddDM8kyZwrVv8Jytn3EwHrichUMSBzPHPwgfXsk7BEolhYjT2ODxgYNSl
 cBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752591; x=1717357391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s3TrWiWfbhfRDglMbr7omJW7rWrBNKn4wgYmHvr3JBc=;
 b=gr49x/BvammhUwhdihu0OpxgcF5cLV3C3NqqKvAGJoerAds5thZ+AGHpnTRApQrNus
 r0tXyhu7o9RH1jVRI8mybbWGwHjZ9mYjI6+1vawmqd/L80w28p8TJcHy5YUzA3BHKSh1
 MeUUA2FCycXZnG3JIhfNmkqmiPgmR/mb19HSuOApA7FLWlx7SS+Spauq8otJpPyF/See
 Spq9Y2qJnKq4cTJ6iFTDiuncKOnoxWDEIiO+OfUekXOi5QiQDr/IfJi9LhJwgFek6uYm
 e0iBjfmZxRM3uRgHKLCLxOaHRxRldMGZlmUmyAWab8IDbkMZnwyP1cOMAs+deZCeci4P
 rPxQ==
X-Gm-Message-State: AOJu0YwMmCc516oTyPT21Em15uFU6bsh9vCw3RdWFwTTBS057zhRnwiI
 VhLonX6iBtoZRJYlk9lgjw53pNzh2c1KPotQWPefDU+TCP8BwpqhmXCsm/2lJBRvdS6QS+vq7Hu
 z
X-Google-Smtp-Source: AGHT+IF4mmT6RT8g0R8Zj5O/rZwqCc97hcJXpPqzyRAuJ0WH+8a6ddvC/wZ9GzlOS1PB9vrql3fSnQ==
X-Received: by 2002:a17:902:f689:b0:1f4:7737:ce3b with SMTP id
 d9443c01a7336-1f47737d735mr41285175ad.64.1716752590767; 
 Sun, 26 May 2024 12:43:10 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 19/37] target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8,
 FPCMPUGT8
Date: Sun, 26 May 2024 12:42:36 -0700
Message-Id: <20240526194254.459395-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  4 ++++
 target/sparc/insns.decode |  5 +++++
 target/sparc/translate.c  |  9 +++++++++
 target/sparc/vis_helper.c | 40 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index f1b84dc9b3..ed295c01e0 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -128,6 +128,10 @@ VIS_CMPHELPER(cmpgt)
 VIS_CMPHELPER(cmpeq)
 VIS_CMPHELPER(cmple)
 VIS_CMPHELPER(cmpne)
+DEF_HELPER_FLAGS_2(fcmpeq8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fcmpne8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fcmpule8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fcmpugt8, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 #endif
 #undef VIS_HELPER
 #undef VIS_CMPHELPER
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b6553362eb..295fc36128 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -408,6 +408,11 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_d_d
     FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_d_d
 
+    FPCMPULE8   10 ..... 110110 ..... 1 0010 0000 .....    @r_d_d
+    FPCMPUGT8   10 ..... 110110 ..... 1 0010 1000 .....    @r_d_d
+    FPCMPNE8    10 ..... 110110 ..... 1 0010 0010 .....    @r_d_d
+    FPCMPEQ8    10 ..... 110110 ..... 1 0010 1010 .....    @r_d_d
+
     FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @d_r_d
     FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @d_r_r
     FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @d_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b9e932496e..7a20e79b7e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -64,14 +64,18 @@
 # define gen_helper_cmask8               ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_cmask16              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_cmask32              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpeq8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpeq32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpgt32             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmple16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmple32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpne8              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fcmpne32             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpule8             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fcmpugt8             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
@@ -5021,6 +5025,11 @@ TRANS(FPCMPNE32, VIS1, do_rdd, a, gen_helper_fcmpne32)
 TRANS(FPCMPGT32, VIS1, do_rdd, a, gen_helper_fcmpgt32)
 TRANS(FPCMPEQ32, VIS1, do_rdd, a, gen_helper_fcmpeq32)
 
+TRANS(FPCMPEQ8, VIS3B, do_rdd, a, gen_helper_fcmpeq8)
+TRANS(FPCMPNE8, VIS3B, do_rdd, a, gen_helper_fcmpne8)
+TRANS(FPCMPULE8, VIS3B, do_rdd, a, gen_helper_fcmpule8)
+TRANS(FPCMPUGT8, VIS3B, do_rdd, a, gen_helper_fcmpugt8)
+
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 6ef36755c3..5a5da17132 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -238,6 +238,46 @@ VIS_CMPHELPER(helper_fcmpeq, FCMPEQ)
 VIS_CMPHELPER(helper_fcmple, FCMPLE)
 VIS_CMPHELPER(helper_fcmpne, FCMPNE)
 
+uint64_t helper_fcmpeq8(uint64_t src1, uint64_t src2)
+{
+    uint64_t a = src1 ^ src2;
+    uint64_t m = 0x7f7f7f7f7f7f7f7fULL;
+    uint64_t c = ~(((a & m) + m) | a | m);
+
+    /* a.......b.......c.......d.......e.......f.......g.......h....... */
+    c |= c << 7;
+    /* ab......bc......cd......de......ef......fg......gh......h....... */
+    c |= c << 14;
+    /* abcd....bcde....cdef....defg....efgh....fgh.....gh......h....... */
+    c |= c << 28;
+    /* abcdefghbcdefgh.cdefgh..defgh...efgh....fgh.....gh......h....... */
+    return c >> 56;
+}
+
+uint64_t helper_fcmpne8(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpeq8(src1, src2) ^ 0xff;
+}
+
+uint64_t helper_fcmpule8(uint64_t src1, uint64_t src2)
+{
+    VIS64 s1, s2;
+    uint64_t r = 0;
+
+    s1.ll = src1;
+    s2.ll = src2;
+
+    for (int i = 0; i < 8; ++i) {
+        r |= (s1.VIS_B64(i) <= s2.VIS_B64(i)) << i;
+    }
+    return r;
+}
+
+uint64_t helper_fcmpugt8(uint64_t src1, uint64_t src2)
+{
+    return helper_fcmpule8(src1, src2) ^ 0xff;
+}
+
 uint64_t helper_pdist(uint64_t sum, uint64_t src1, uint64_t src2)
 {
     int i;
-- 
2.34.1


