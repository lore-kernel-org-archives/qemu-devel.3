Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2C2D42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuZs-0003eG-Nq; Tue, 12 Nov 2024 12:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZQ-0003Hn-66
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:52 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAuZO-0003jJ-GL
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:20:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso4298332f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 09:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731432048; x=1732036848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QIhpCSRwl2fVScf8FsXFWIoCYKOkrY+ZXmkFDjrKtuw=;
 b=GuIgiIaCvHeINsh1a2ZFAHMkQ2DWIp+CyBhyqECRzfjIFy4Wl90LPGoKn5a6c7vbef
 asIuva54pL51+U3KLvVNZgUpTp5nKzHPGRgh94XendGsr/0sNLR3TSHfNHGFRCBS6zNx
 TrojrKW7OmrG+QXntLOVCM4pOBRgkURn0Ihq7s8nMCJhV2kQIJ4g5rRo+llYoUMFWjEp
 LQqs3TKTtKeUKe1dcW3OpWhrTj3h+T0KIfXWLw5uztEviZokziUwb8sS3eFTurk/ZvhD
 9SVvWnmhPMqVpozHChwlNjW4aebl8W6ZxZhbQpzDtBul7KaEUVO7cNU8KNVQEZ9tsgAc
 kkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731432048; x=1732036848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QIhpCSRwl2fVScf8FsXFWIoCYKOkrY+ZXmkFDjrKtuw=;
 b=IHKpPKc+Ycx5QmYGFgrTCbeevMbFz4z3xcqG+fuAAw0LXVoTcu/9vn1QiIs7If4cmR
 sdFDCRq9NrEPxEEIeJBi0YWC4mtlS+znApNADuoa6QJ6zlsAR61XMBXXcMfusyip+euD
 Eot4IO2uC3ZJ0oPufztj4R+oIstv5xOpYbLUlqznxLO1R2OVnyUJnmZHsDD6TxMsLRbz
 SvFMTIJj7cRnJqHO1gVAuP719Nc/FU9u+ApybrBe6LjADqOzLlZ8bhRDttdBQ9K61DGa
 id4BXmMAbWlAgIycZPx4pIP4PFHHIibELDjSajKGQ4GRb9OIEFVaBaJYoUuzM9Vx1oDe
 uk8A==
X-Gm-Message-State: AOJu0Ywz0sfGqopW2wi5H78nYWdwniWhzkgYPjxbw9+b/KKJuZ/OrwKK
 9m9FVifVD52JOvCS5OvEXYSG6nLJCXsqgT44PAVWZ4I4Cs3cA2dE4Wd/fuxR5L8IlT0YLzKd1ht
 a
X-Google-Smtp-Source: AGHT+IE84tm4FTx6OU96SJz3YlDaapG+iBQ4mS1K8wLcmxMmves4w7a+PBCk7kfEm2CEXjKlLdpC2Q==
X-Received: by 2002:a05:6000:1885:b0:37d:47d8:5fff with SMTP id
 ffacd0b85a97d-381f188582emr14499737f8f.37.1731432047813; 
 Tue, 12 Nov 2024 09:20:47 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed987d33sm16160546f8f.43.2024.11.12.09.20.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 09:20:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 4/6] target/mips: Decode LSA shift amount using decodetree
 function
Date: Tue, 12 Nov 2024 18:20:20 +0100
Message-ID: <20241112172022.88348-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112172022.88348-1-philmd@linaro.org>
References: <20241112172022.88348-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa.decode       | 3 ++-
 target/mips/tcg/rel6.decode      | 4 +++-
 target/mips/tcg/msa_translate.c  | 4 ++--
 target/mips/tcg/rel6_translate.c | 9 +++++++--
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/msa.decode b/target/mips/tcg/msa.decode
index 4410e2a02e..798e8c401a 100644
--- a/target/mips/tcg/msa.decode
+++ b/target/mips/tcg/msa.decode
@@ -21,6 +21,7 @@
 &msa_elm_df         df  wd ws       n
 &msa_elm                wd ws
 
+%lsa_sa             6:2  !function=plus_1
 %elm_df             16:6 !function=elm_df
 %elm_n              16:6 !function=elm_n
 %bit_df             16:7 !function=bit_df
@@ -29,7 +30,7 @@
 %3r_df_h            21:1 !function=plus_1
 %3r_df_w            21:1 !function=plus_2
 
-@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
 @ldst               ...... sa:s10 ws:5 wd:5 .... df:2       &msa_i
 @bz_v               ...... ... ..    wt:5 sa:s16            &msa_bz df=3
 @bz                 ...... ...  df:2 wt:5 sa:s16            &msa_bz
diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
index d6989cf56e..a9031171b5 100644
--- a/target/mips/tcg/rel6.decode
+++ b/target/mips/tcg/rel6.decode
@@ -16,7 +16,9 @@
 
 &r                  rs rt rd sa
 
-@lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+%lsa_sa             6:2  !function=plus_1
+
+@lsa                ...... rs:5 rt:5 rd:5 ... .. ......     &r sa=%lsa_sa
 
 LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
 DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 82b149922f..75cf80a20e 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -780,7 +780,7 @@ TRANS_DF_iv(ST, trans_msa_ldst, gen_helper_msa_st);
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -788,5 +788,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 363bc86491..2522ecae2b 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -11,6 +11,11 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static inline int plus_1(DisasContext *ctx, int x)
+{
+    return x + 1;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-rel6.c.inc"
 
@@ -23,7 +28,7 @@ bool trans_REMOVED(DisasContext *ctx, arg_REMOVED *a)
 
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
-    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
 
 static bool trans_DLSA(DisasContext *ctx, arg_r *a)
@@ -31,5 +36,5 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     if (TARGET_LONG_BITS != 64) {
         return false;
     }
-    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa + 1);
+    return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
-- 
2.45.2


