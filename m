Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC51C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6g-0007mH-Tf; Sat, 15 Feb 2025 19:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6L-0007fW-RS
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:37 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6J-0006Ik-NN
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:37 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-221206dbd7eso1308555ad.2
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664089; x=1740268889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFWOgm7cwZ/f43Ltoxf8K/SGg9Wf6xR2m2O9XTNwnuM=;
 b=Du3YMUDDAU9DHfAYt+BZigKH+MB0+ix3jczOLTtlya4pEGPQDfYgfxtlKoFVzeLbyC
 sXGLPSXseRkifvZSye8y982p3JBorLEVENCPbDBK5WqLlJoEt9AFMHwIXxajRWNyhAFx
 yQed3YCwggUKEcYMy8qK6s5bH7WNA609lys5myRHcGGLo14YKcqFtOIariv1bktSjy5Z
 rAU8SuW4FwB7hBuswAuiLWecUUzq7JQOfnS3olxtz3CEouJRFRv3WVvLL5QmbTi276Cg
 WO23XEvUhGyHQnFLiw/Ex+9/BmAGPOvIIyZF7K9qIL8CGSm4gsZoccr2gYEYc8f2clTa
 OIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664089; x=1740268889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFWOgm7cwZ/f43Ltoxf8K/SGg9Wf6xR2m2O9XTNwnuM=;
 b=u9QmtcYuABt5Me8jlw7kmLdRj3ba6Ad+5w7Lz7pmGn7104+HEvbvnxiJkcwzbb4ayW
 inCp0aNCufD/86Uwu+xAcr2oQYcW0o78SI9BLCWcNOQY08MZ3KWOGloPJCxENT6qZJgr
 RkoI7mAkyEPb5TXSkHvnsJdWI4yAzqg+XququYTBPcnmY58vy1w8C1uvN8e9k6RfMSr9
 +87UKXftZLNKWvRPWI4tD1fdcizy8Nkva8Wdm3Tr7x7FfKhThNbGat8wQBE0u9mbicuP
 +BbJ+7R2y/y4dBH9aAF4lLyGs+4Acz7szfWduInPJEFfDuXRhRuO19+Zpx/+kA/Exi88
 nAlw==
X-Gm-Message-State: AOJu0Yyn+0QQbEij0LbgiNPlmMpHX7NHYNF8m85AWWWeuV4zj1r9a5Gf
 xKfjR8k+YbeiMFQ3mhqcn6Xmo6BXTCqWjpJ9dnbodlLn/dPDoSeJTYjIcGZMeuEzuLsRFdcrUfA
 X
X-Gm-Gg: ASbGnctqxM3nrs6IaETQvj2x2Gy6Il26XtroM6UecY0YXg8gVm7aO4d+4lijNejPOSL
 rEsMznO6+ZGsX0QRK7jlH0xa9qdi4GDCZuTA/WHOr6BSxzKSqRpXQCodXy8FBG6hiDIB8Gfz1/H
 XgerIblhWN/+YEDmds0r/96ojwx9D/wTf0VuJsHFjFQtF2TCgieAgzhOqaJCSx1sUy+LcTtSdHo
 FXSUiZPgo6y6xlVhhPUtsGrMm9HwhkTyCUk8VNZA5xSn18+f+0DQyzzQl7F/EVbdDKW2D+ughyT
 V8nf1kyLNzAAfrOwmT+wuhJJF9yNc6rFQa6x0nSq+PLTxkc=
X-Google-Smtp-Source: AGHT+IEgmlM7dSBRSe+FEzP7ch77BG1EulgN0F9u7MqTNzIYkQxXVfxcLZQ7t7mogSb2zXsd7iyvlg==
X-Received: by 2002:a17:902:fc4e:b0:216:7926:8d69 with SMTP id
 d9443c01a7336-2210409d456mr80105305ad.47.1739664089098; 
 Sat, 15 Feb 2025 16:01:29 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 24/24] target/sparc: fake UltraSPARC T1 PCR and PIC registers
Date: Sat, 15 Feb 2025 16:01:08 -0800
Message-ID: <20250216000109.2606518-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Artyom Tarasenko <atar4qemu@gmail.com>

Fake access to
   PCR Performance Control Register
and
   PIC Performance Instrumentation Counter.

Ignore writes in privileged mode, and return 0 on reads.

This allows booting Tribblix, MilaX and v9os under Niagara target.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250209211248.50383-1-atar4qemu@gmail.com>
---
 target/sparc/translate.c  | 19 +++++++++++++++++++
 target/sparc/insns.decode |  7 ++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e5c7351cb..bfe63649db 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2882,6 +2882,14 @@ static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
 
 TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
 
+static TCGv do_rdpic(DisasContext *dc, TCGv dst)
+{
+    return tcg_constant_tl(0);
+}
+
+TRANS(RDPIC, HYPV, do_rd_special, supervisor(dc), a->rd, do_rdpic)
+
+
 static TCGv do_rdccr(DisasContext *dc, TCGv dst)
 {
     gen_helper_rdccr(dst, tcg_env);
@@ -3315,6 +3323,17 @@ static void do_wrfprs(DisasContext *dc, TCGv src)
 
 TRANS(WRFPRS, 64, do_wr_special, a, true, do_wrfprs)
 
+static bool do_priv_nop(DisasContext *dc, bool priv)
+{
+    if (!priv) {
+        return raise_priv(dc);
+    }
+    return advance_pc(dc);
+}
+
+TRANS(WRPCR, HYPV, do_priv_nop, supervisor(dc))
+TRANS(WRPIC, HYPV, do_priv_nop, supervisor(dc))
+
 static void do_wrgsr(DisasContext *dc, TCGv src)
 {
     gen_trap_ifnofpu(dc);
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index cfcdf6690e..9e39d23273 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -96,7 +96,10 @@ CALL    01 i:s30
     RDTICK          10 rd:5  101000 00100 0 0000000000000
     RDPC            10 rd:5  101000 00101 0 0000000000000
     RDFPRS          10 rd:5  101000 00110 0 0000000000000
-    RDASR17         10 rd:5  101000 10001 0 0000000000000
+    {
+      RDASR17       10 rd:5  101000 10001 0 0000000000000
+      RDPIC         10 rd:5  101000 10001 0 0000000000000
+    }
     RDGSR           10 rd:5  101000 10011 0 0000000000000
     RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
     RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
@@ -114,6 +117,8 @@ CALL    01 i:s30
     WRCCR           10 00010 110000 ..... . .............  @n_r_ri
     WRASI           10 00011 110000 ..... . .............  @n_r_ri
     WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
+    WRPCR           10 10000 110000 01000 0 0000000000000
+    WRPIC           10 10001 110000 01000 0 0000000000000
     {
       WRGSR         10 10011 110000 ..... . .............  @n_r_ri
       WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
-- 
2.43.0


