Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A31C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuM6-00063t-0R; Wed, 05 Jun 2024 13:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM4-000618-5E
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:20 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuM1-0003sU-UZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:19 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-6c4f3e0e3d2so29696a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608196; x=1718212996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZeHEsoR9DNVGyATdmd+Zd8qaYj7z+UBk+cUU+SO+Fg=;
 b=Mf6UFrLgIPMWcAH/q1isDCfVxoliYGOQwh7gBn3wPaYrGrtpz//+8sycAUoAy6HeC+
 spWRe9jYsh00aUVdVIm3QQKFmTWs/DXQ+lYe48qfQnqV7d7VHJEBQVjrmc0mveS+pgBt
 cFCjqIqgkqS7obV/QUwmB8rIW8rYD2VpZPxENk4qznbUvicQHMcePJwv0q6pagKS3o+/
 6iS3xzGdsNyeicUzVNYdfDtJkbl7BI4LM5UYb68enG5JtcVDSe0EWdjpDdNbH6h/zXDW
 sURifiV3sprJqzDeAWmv/5D4n4kGeBX4xEdlHZ0HAYVNboYS4STwBZ2kZoafY8t7MNzm
 aR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608196; x=1718212996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KZeHEsoR9DNVGyATdmd+Zd8qaYj7z+UBk+cUU+SO+Fg=;
 b=xU/0oVkFBXUs6csVA+3vr9b2ZlK+nhyJYOXCPU2uADST1uWgK9Wop3Ydb2/V8hp+Yq
 CaDck3uXTGQWoqHtp6yACrU1knVT/sOpK1tpUejsIguFXf8tG3Abq5rC/b+LyHPdH2pQ
 bBjJk4iqIuXLiWIOj/V1el7rAB0dFNRmD5CFC9v0pjwye8YoIjRcTpceb7isVUpVTgVq
 lUkKNSR0Yo5vsFazCwtsA7gBQytRPYUwqFr842Pf58Y31W0rOLwak4QVfIH6O/EDZJjz
 mBLlC1EWlHyjLw9xI5k+7py43MTeflW5dRiLpNY47kHO7SsHfwRAnW2qHcCZQB+/1V+i
 kxtw==
X-Gm-Message-State: AOJu0YzV9T713amvur5rzKoNJZKIrEB3NmkS2vIjepn5QBuWJhUPR+Bj
 gikiPBwIw6/zvOIjYVdYISSbuaynYaYVrLqP55r4/oY/MNjaHacUyzzSfZAHmyKI85N7HJintt3
 Y
X-Google-Smtp-Source: AGHT+IGPvpfACf0ylLX0h0kirfhADIEtrHE/uEU9MRRnmlbnizxSTaM3h3oq5GdpomhEZa9Vaphjhw==
X-Received: by 2002:a17:90a:f412:b0:2c1:e3c6:3b90 with SMTP id
 98e67ed59e1d1-2c27db68d40mr3325080a91.46.1717608196547; 
 Wed, 05 Jun 2024 10:23:16 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/38] target/sparc: Implement LZCNT
Date: Wed,  5 Jun 2024 10:22:38 -0700
Message-Id: <20240605172253.356302-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
index c40992df96..a12cc9f796 100644
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


