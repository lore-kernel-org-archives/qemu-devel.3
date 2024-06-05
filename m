Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14070C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM2-0005yJ-GL; Wed, 05 Jun 2024 13:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM1-0005xZ-62
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:17 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLz-0003rf-7E
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:16 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2c199e37f4eso53971a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608194; x=1718212994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcQXYhfhq3aaJr+Q70eGmHxhtOYXAidZbVoB+nhP4qQ=;
 b=eP3JBLw9iRefjX7FE1Ja3ZrXSWCBMgEzQC+riO6cu6RY4BnpB6iwKkJPL4fLxU4+Wr
 HKSWV7efl2PLy3VFJ5pwbP+2vtHQoHs/pliDsJQdHDEszEiKS85Q/M4nC0ajBovIy/5X
 g2kbptuurEU6s9jy/P9Ad8YWoBppKuOfRUwdifaQ7d2z2hdNenuYrt9tv6sn5BGqIWIZ
 5izEmLur4PSZ5QGYo6Pdw7z3KFU3FdOg8QA5S1kJTsR9NsV9zKhBPqMdMJTL8FAJr8e2
 SAQAOblPb4sluYviwsbQToG/hEQ/9nePAaD91+FwFpur4FTbFzmVw9IZPei6omBmFbpG
 esKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608194; x=1718212994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcQXYhfhq3aaJr+Q70eGmHxhtOYXAidZbVoB+nhP4qQ=;
 b=SfZghkhFsG+ra0hhfiTR0bCiyQjZzhi5MKytDTlLkmF8MwOb3tguSspAtQ5iMrQdEB
 nyvG1LsjCYo/Z2WPgBQQf9T+AScbgwy/wkjq9AHM0fExTJyklUW2qgT2YzgNB+ywripN
 L088PiwrxelLUlc1p11iAQn1O3LNlbaHixWWHAk54+et7ejqqmCu8YRAwWinF5U8ATbw
 KElhqEFnie9oum7xbcy5nI1OvPDmdHYsN4hA2omyp+Yspkyn3dyTJ+ISA5E9i2QZH3kD
 lIhZj+RtCD45Xh/qaQnfCsPdg/F442l1bjheW7G6lM+55i/AW+2nzSqb0pa78otiHfa4
 LuEg==
X-Gm-Message-State: AOJu0YxlPP8EgWN8FqGyEWxS+ym71g+rJ8hHf9oHSfuMP7eTc5mjA6ks
 6zg5c7s9dptxXL1lLrBT2Xc56WZxG3VHXtxgu21HUY3Txiosxjdkk9mUPPWmNbwhw/1ZLYeC+37
 l
X-Google-Smtp-Source: AGHT+IEKvdmhs2CRnyAZFakLqsgU6SMuCg9ouVhWwuPoPoEO2JsSJbj9AxCrL4Aj6NCUMia2VXodsA==
X-Received: by 2002:a17:90b:2ccf:b0:2b6:c650:fb54 with SMTP id
 98e67ed59e1d1-2c27dd591d2mr2910933a91.49.1717608193715; 
 Wed, 05 Jun 2024 10:23:13 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/38] target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8,
 FPCMPUGT8
Date: Wed,  5 Jun 2024 10:22:35 -0700
Message-Id: <20240605172253.356302-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 7a5e8e0a9a..1da40f6db2 100644
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
@@ -5025,6 +5029,11 @@ TRANS(FPCMPNE32, VIS1, do_rdd, a, gen_helper_fcmpne32)
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


