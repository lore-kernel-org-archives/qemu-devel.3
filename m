Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50A9C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjt-0002YJ-0B; Sat, 02 Mar 2024 00:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjr-0002XE-Q6
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:47 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjq-0007Zb-4N
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:47 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-299c11b250fso1957064a91.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356604; x=1709961404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezQMK+llLfRLQ91YJ8mCm3WDoIQicf2yyAeX5SZzp54=;
 b=JosCyprxSjq0IN0Ff2Kbf8lydi9uRvRdiQIpzXU8hQtkav1bNIxTnSpfbHc9YaDJLs
 nmwz2PVju2IHOb8HS14bTulsEralHiXpAG+tMa+brsnkUkYxc8FyqTIt6TzEs5q9Kn7w
 U6PW4z3+eWiGkScy+ZX+1UigYoAik3YOWurG0PWjIxQeI9fr0MLV345TojyJmy+m9G6z
 MDiE2Lz/VTXw+nO3E0fkaiecY3r6zGu38bYQQsl2PS+5pQ9XkQ9oLhTlBAb20TSjrD0d
 XKsR+BX0GdiK2iA2bMUopCKFM8IqQZynAJ02WjXP8SD6Nd4pdhDIyx4bYC+M5651bo3V
 2X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356604; x=1709961404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezQMK+llLfRLQ91YJ8mCm3WDoIQicf2yyAeX5SZzp54=;
 b=Z0eHfm35aTDJ+h7tbwoDfj2cF9IqqvPsET8Jxv4k+vRETqTHNI4PD0lh4rMImLYl07
 lytv7w9znpmgsWDuDlZBnhV+kr72BOzgUyw3USm03oepVfHgFpGbHEgMjoYGzcfUnYs9
 hy5RdAcoUrgpOoCePx2VIz5iuqTcujnHl1V+vEgZjHbf2k+/i5MQFTpGmNdVBLsCwRbZ
 wyLXn+4smr8urqPXc9VDkh80KUx3JFFurVm5bSRzFut9W4y0IipRl/1A/YbHom6yVMLd
 sru57kOxRiqp6iTW228ATqfWlUFk0g9qopLLKvHOknUFZxSPwDMnUj0AJ5+BxQgh5Lfz
 TCmw==
X-Gm-Message-State: AOJu0YxagVpfTbNzZU8PwCgIyiUA+AVlEAiOFidP/mguMdMQW8i/VroX
 J0ucNIo4LmJuGElEu23REQ6dIdMGcupMD6LNFaiD17UXlJECz/aTM+0996hsOw/qiTFvT6NK4Ss
 n
X-Google-Smtp-Source: AGHT+IGuxfJXdyGYHo1i4IleQeJTtp+5zbAX5kRhcq3ikChkGJfXIUzvjn5hGdK8dS0GfIiwKKlIKA==
X-Received: by 2002:a17:90a:1049:b0:29a:264b:8853 with SMTP id
 y9-20020a17090a104900b0029a264b8853mr3212210pjd.12.1709356603864; 
 Fri, 01 Mar 2024 21:16:43 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 23/41] target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8,
 FPCMPUGT8
Date: Fri,  1 Mar 2024 19:15:43 -1000
Message-Id: <20240302051601.53649-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/sparc/translate.c  |  9 +++++++++
 target/sparc/vis_helper.c | 40 +++++++++++++++++++++++++++++++++++++++
 target/sparc/insns.decode |  5 +++++
 4 files changed, 58 insertions(+)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 8a5191414e..fb52f31666 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -123,6 +123,10 @@ VIS_CMPHELPER(cmpgt)
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
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0dc02a3d6e..bc8c314d4c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -65,14 +65,18 @@
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
@@ -5018,6 +5022,11 @@ TRANS(FPCMPNE32, VIS1, do_rdd, a, gen_helper_fcmpne32)
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
index 93a6239f41..2d290a440e 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -221,6 +221,46 @@ VIS_CMPHELPER(helper_fcmpeq, FCMPEQ)
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
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 602b4cc648..c94007bf95 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -408,6 +408,11 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_d_d
     FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_d_d
 
+    FPCMPULE8   10 ..... 110110 ..... 1 0010 0000 .....    @r_d_d
+    FPCMPUGT8   10 ..... 110110 ..... 1 0010 1000 .....    @r_d_d
+    FPCMPEQ8    10 ..... 110110 ..... 1 0010 0010 .....    @r_d_d
+    FPCMPNE8    10 ..... 110110 ..... 1 0010 1010 .....    @r_d_d
+
     FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @d_r_d
     FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @d_r_r
     FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @d_r_r
-- 
2.34.1


