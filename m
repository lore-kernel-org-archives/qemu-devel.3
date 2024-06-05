Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98926C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMH-0006ET-0k; Wed, 05 Jun 2024 13:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMF-0006DB-IX
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:31 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMD-0003xq-TW
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c2283707b3so66376a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608208; x=1718213008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lGzoPsZRmPScWxThSjP+3q3DF2qUkZ0NxX72PayX2e8=;
 b=oRpW+Wo9hLQi+ETHYrA8fXx/FtHwknvZhwey0OFpd8s9mcByheYx6BIiXHBexDDrCl
 1Gfj3QwZfIq+PoIvUxz0XKoZKLoxJXTpurtufOHYkveZSsfo/Jt0v90SDBXwdxlb21Vd
 SgHFg/973KcRHo3cWAwqpxOPJjV9gD+3x1cli0TUHuR5tRjsSe7JKxdyPkxcSPB6jdNt
 oVxF/lTo4s+8c8p6aJbjS5317aInSMQGQSkQBPZAlrkn57DrTP0jjmjb91bPtaL+7z9F
 YVlmdTH1LpiLYCBh5/ukZBumAFMwj0dxBe0hhvZznnbT3ckGEEqVOMLwQ3VjjWcicanO
 jQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608208; x=1718213008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lGzoPsZRmPScWxThSjP+3q3DF2qUkZ0NxX72PayX2e8=;
 b=XdE6HENNTN+J8e464ZLfuTrtBClmvskzjnd7xiD5yCNMVQQ5yAGS+4fBDr6HIVIwCs
 VszY3StedUVoYFO0KWqGf5uVdn3eRCAhHDs9JIuFj8WBWspShuXnkDAlrlog/wThbcXe
 LUxTKUdnQanNd7VN7qBhP4O0522bEFNxn4y131rJCP05S1U6RXD1s7+3p9+U0dmei5Vb
 DmkgpivzFY/vgHZvQACqeZiWTuLw+G5FIPAhzmRHpH2SKtXh57pdZ1Ux4kSSM324EF1V
 75YPi2rFDSq6ys88TZPn8/JFthdNWMQrDrg7qJqmd0tqTYEGFdFgwUMal+Am7cbcIe4p
 qtkw==
X-Gm-Message-State: AOJu0Yw50avAkBRhlmPzzhRCZJ31RdFmbTNLaLNqxOYciE5RGBDI2KYt
 U9cMrRwOcrO2QI8DTgA5xDypjzqjBNAYCquOC5sNmQbK7Ynm689Rss6YQG/SOr5fYvwRD11O7oV
 4
X-Google-Smtp-Source: AGHT+IFEgk152lg9mPqTt2/Yx4XCugGafZiWOZjy2Vrc45W15oAPBMMr3g6FH8fXrNZTI3huJFmF4w==
X-Received: by 2002:a17:90a:a10a:b0:2c1:9cd4:665b with SMTP id
 98e67ed59e1d1-2c27db22aa5mr2991865a91.28.1717608208555; 
 Wed, 05 Jun 2024 10:23:28 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/38] target/sparc: Implement MWAIT
Date: Wed,  5 Jun 2024 10:22:51 -0700
Message-Id: <20240605172253.356302-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 target/sparc/translate.c  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a7720560f8..fbcb4f7aef 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -124,6 +124,7 @@ CALL    01 i:s30
     WRTICK_CMPR     10 10111 110000 ..... . .............  @n_r_ri
     WRSTICK         10 11000 110000 ..... . .............  @n_r_ri
     WRSTICK_CMPR    10 11001 110000 ..... . .............  @n_r_ri
+    WRMWAIT         10 11100 110000 ..... . .............  @n_r_ri
   ]
   # Before v8, rs1==0 was WRY, and the rest executed as nop.
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b10936a61a..6d0ad38fd5 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3344,6 +3344,17 @@ static void do_wrpowerdown(DisasContext *dc, TCGv src)
 
 TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
 
+static void do_wrmwait(DisasContext *dc, TCGv src)
+{
+    /*
+     * TODO: This is a stub version of mwait, which merely recognizes
+     * interrupts immediately and does not wait.
+     */
+    dc->base.is_jmp = DISAS_EXIT;
+}
+
+TRANS(WRMWAIT, VIS4, do_wr_special, a, true, do_wrmwait)
+
 static void do_wrpsr(DisasContext *dc, TCGv src)
 {
     gen_helper_wrpsr(tcg_env, src);
-- 
2.34.1


