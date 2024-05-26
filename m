Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C5AC41513
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJm1-0008Rk-2M; Sun, 26 May 2024 15:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlz-0008Nw-VM
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:15 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJly-0007hv-AY
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so323505ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752593; x=1717357393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXW/Ltrfsx0MGgRbMt9NN8XXyTF3WwZ3uL7yZtfeN4I=;
 b=g+OLwYBo2tLsJQ1aOxPH26rsvioRlluZ3EsXEQnXV34kUT+q8Z6WuMWrX2s32mlPN8
 wrHWI02oqGUnE4PcxtQmbnQvw4TfjThOqTPrlsFInSFBPjqHVLOXmxqzxEudwsKWi5nV
 GycDdb9ZQqadak+7MWTKT1vnixTiD4Hwh8hygXe/SbnH4ScMdwZGSiOyDCU45QBTpy7B
 uNfHsMxQPJkWG0JGguU3WuZM+yMzbdD6SuBRGnnlrJDUAfaIWlBQ3lajFKmttHKQJ6gW
 J4TTMwHg2EQApjX4RsHKL4Dj7AW8TyyiQBj45Zwo+Pol2kxJ8jDme7eM6PA0hgv7dIDc
 ihWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752593; x=1717357393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXW/Ltrfsx0MGgRbMt9NN8XXyTF3WwZ3uL7yZtfeN4I=;
 b=VkHPobZJl/V8gYXoTIQbbLLo376Nz9cGVZ0P+XjH4aYdV+CjRglBJj+lS+LRCP7T2+
 DTnC7pI0Y0JocQ5OnHnT1IMKTIbKFoiCqDj3ImbXJ+oukOgQlbwnz9G4G6StOylrLer+
 w3mdHR1tlEuJMVoT3mhhyvEAFgZXeD+ITbeT8JN53P1q0ClXb4zaDqKssAqK8lI5bGrd
 lkzSIYJ6PBvsURacayww9Ay2HIKxOMK5nSoe8rc87kApB4IUx87LKmUQ3ODXI8D+YFsu
 IDtZrKn8xtdWFwDGV771Ern/wrFDkKCAWaELH6dgieuPNVDMRBShwQAG/ZOhXNqg98mv
 BYJw==
X-Gm-Message-State: AOJu0Yw+YXSg03+SiddtrJZwpyXWjDbjduZXh6ARZ5/nVBwlaOpwMCxl
 QpWqZwYV37VRjEVicNH/Ua/OwuDxzXexypk8mL02Y26otFaST9y8LKDN2CJyTcIXh/sR9fLVWnd
 6
X-Google-Smtp-Source: AGHT+IGiOe3UDjGAF6aU9HOz3dIxwov5y1Hsp7B73IGobxjOKI6RQu13cO+bgmWxZqxw2E8nYjpOgQ==
X-Received: by 2002:a17:903:188:b0:1f4:9139:e0ff with SMTP id
 d9443c01a7336-1f49139e34dmr17100255ad.10.1716752593012; 
 Sun, 26 May 2024 12:43:13 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 22/37] target/sparc: Implement LZCNT
Date: Sun, 26 May 2024 12:42:39 -0700
Message-Id: <20240526194254.459395-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index fec055910e..4766964893 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -389,6 +389,7 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
 
     ADDXC       10 ..... 110110 ..... 0 0001 0001 .....    @r_r_r
     ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
+    LZCNT       10 ..... 110110 00000 0 0001 0111 .....    @r_r2
 
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e3059f32bb..705fcb028a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -658,6 +658,11 @@ static void gen_op_popc(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_ctpop_tl(dst, src2);
 }
 
+static void gen_op_lzcnt(TCGv dst, TCGv src)
+{
+    tcg_gen_clzi_tl(dst, src, TARGET_LONG_BITS);
+}
+
 #ifndef TARGET_SPARC64
 static void gen_helper_array8(TCGv dst, TCGv src1, TCGv src2)
 {
@@ -3873,6 +3878,19 @@ TRANS(EDGE16LN, VIS2, gen_edge, a, 16, 0, 1)
 TRANS(EDGE32N, VIS2, gen_edge, a, 32, 0, 0)
 TRANS(EDGE32LN, VIS2, gen_edge, a, 32, 0, 1)
 
+static bool do_rr(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv, TCGv))
+{
+    TCGv dst = gen_dest_gpr(dc, a->rd);
+    TCGv src = gen_load_gpr(dc, a->rs);
+
+    func(dst, src);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(LZCNT, VIS3, do_rr, a, gen_op_lzcnt)
+
 static bool do_rrr(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv, TCGv, TCGv))
 {
-- 
2.34.1


