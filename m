Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4577FC55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpakX-0001k5-4X; Thu, 30 Jul 2026 20:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakT-0001by-Bn
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpakR-0001Kb-78
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 20:05:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9e0b89e228so200474a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785456307; x=1786061107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bIOHjdIc+QJ9Vm3yysZK+iPa46cyoD24khhSvOPp95s=;
 b=p9VdWkA0nyvqbcZBP6DYrS3tNBTqUkyOra7JooTy/OshjzeFQU0Ecjnaqy/5z7Q61A
 3JHKd68IDgal73nftftnpAOv+LTrMDQkrpL/xiwOC5LOAqcaxcxIrBzcKU3tsRn+kzsO
 Y6Ypfas/rDGvQUv0ocZvigQ9lMYvk+gU0uKY+qgLO8flx/Zn/dM2pRzEWRchtPyuF0v8
 qnxTN9C8BiAIVF+H9JMF6LkWAYXi76BgAgzyfzJ1LsqtFrV0LW3z0aWwpLYTh9ICWco2
 Y0miYhsrKXt+ATiiNjUHIRxE6sA75i9MnYTBYYswMUeJ4/d2MQ5GqsNHMBdzB9JiV+d5
 Ft0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785456307; x=1786061107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bIOHjdIc+QJ9Vm3yysZK+iPa46cyoD24khhSvOPp95s=;
 b=TUKtYOemFZDr1jenfUlPlWg41UptaI2XFsWlROmLtAabE7WCCh7cy6XQMyYCXBbiaC
 fd15+OKHszctqPwrgsDsBloc+ksITcNFaITjueC/6a/fjYI80tMdS8M6hmglco+R8VHE
 tK6Fzmh06lVovPCBbXy38KBHftPVCoyCQdLmRohYwAriQ17F3nKoquIa3LyDpPh8m6EP
 AmYyZs+zYnKCSyA+Jy9z6erzlLSj1nyCHZRNU7fcwXvwpIPiiT1mxyo3o0jkZo5ox1O+
 z/jhGlm29HLxomHs2KtSRvtzJIfWm5OSmY/5IchP1BzD/gGCKt1kFxJaAlmxyNG1XQ+2
 Ekfw==
X-Gm-Message-State: AOJu0YxxXxYqEnjsx0j/idp2khx5NgrN9gBerqM4ioFNMN3hkbBdqVlU
 EfTGvVZBOidR1XFbjZ9BKMb88xv8SjnfTgsFVFoY1anh1FyBLjQSPBsjAeMZ8gSFCwSoKC7h4ri
 yGpyf
X-Gm-Gg: AR+sD11jXueR3ZU2JhN2VIBdvZvcIyMXfjsYeI9mThMsA39pLG7TnACCDKDzijoNmdP
 5gKhdvxxyzV0dqySq0AzNbWbmcoYROdE0iJT7uYnU+AfC7CddJnQRLYWD3tr0y2XwMdiiLjQsi+
 e3/oKnV2MCMzq3itH3POkkhNMwcLs9JVHsDOnswhNgUczkjdLogaJnQ3JuIb7QbjtexeiC1wdRP
 3SpzlXOa2QZA/n9avksQlPo3sH/Go/E6ql7CYdfMLHb3Fuz5lpOlQjapEMOizX19aZ3kT+wXIoM
 2ut9UTj/NSFJb3uKCrGwJUfwXfArmPByQDpaM09v+BGVNwx7ysuipcXeLIb1hDK4RoJGuAmY7u4
 /SIp/OyVRMdh7k4vDx5eFUH4iwEAQql4bVprWjLtStAgqkNZYeEtfMuR86OLx/6eXW4c44H505S
 XHDH6KynMSdsFLuXDRGxwCeV7PMWrGh2sYkHsR+hPqRxrbTDe1bp6dBZKW6w2eO70tsufo2tGDZ
 Pm90yNoKb0N5x38j0ZG
X-Received: by 2002:a05:6a20:918f:b0:3b4:71c1:ab29 with SMTP id
 adf61e73a8af0-3c9006af56amr3762337637.16.1785456306546; 
 Thu, 30 Jul 2026 17:05:06 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbdb7a999ddsm2656460a12.4.2026.07.30.17.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 17:05:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
Subject: [PATCH 02/11] tcg: Add tcg_gen_revbit{32,64}
Date: Thu, 30 Jul 2026 17:04:54 -0700
Message-ID: <20260731000503.170446-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731000503.170446-1-richard.henderson@linaro.org>
References: <20260731000503.170446-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add generic expanders for reversing bits within a word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  3 ++
 include/tcg/tcg-op.h        |  5 ++++
 tcg/tcg-op.c                | 59 +++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fe342db0d..91f59dc11e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -164,6 +164,7 @@ void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
+void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
@@ -275,6 +276,8 @@ void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 96a5af1a29..401ee21cdf 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -115,6 +115,9 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_bswap_tl tcg_gen_bswap64_i64
 #define tcg_gen_hswap_tl tcg_gen_hswap_i64
 #define tcg_gen_wswap_tl tcg_gen_wswap_i64
+#define tcg_gen_revbit32_tl tcg_gen_revbit32_i64
+#define tcg_gen_revbit64_tl tcg_gen_revbit64_i64
+#define tcg_gen_revbit_tl tcg_gen_revbit64_i64
 #define tcg_gen_concat_tl_i64 tcg_gen_concat32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr32_i64
 #define tcg_gen_andc_tl tcg_gen_andc_i64
@@ -234,6 +237,8 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_bswap32_tl(D, S, F) tcg_gen_bswap32_i32(D, S)
 #define tcg_gen_bswap_tl tcg_gen_bswap32_i32
 #define tcg_gen_hswap_tl tcg_gen_hswap_i32
+#define tcg_gen_revbit32_tl(D, S, F) tcg_gen_revbit32_i32(D, S)
+#define tcg_gen_revbit_tl tcg_gen_revbit32_i32
 #define tcg_gen_concat_tl_i64 tcg_gen_concat_i32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr_i64_i32
 #define tcg_gen_andc_tl tcg_gen_andc_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bbcb510c76..02fb3504b1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1244,6 +1244,30 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
+static void gen_bitswap_i32(TCGv_i32 ret, TCGv_i32 arg, uint32_t mask)
+{
+    TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+    int sh = cto32(mask);
+
+    tcg_gen_andi_i32(t0, arg, mask);
+    tcg_gen_shri_i32(t1, arg, sh);
+    tcg_gen_shli_i32(t0, t0, sh);
+    tcg_gen_andi_i32(t1, t1, mask);
+    tcg_gen_or_i32(ret, t0, t1);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+}
+
+void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    gen_bitswap_i32(ret, arg, 0x55555555u);
+    gen_bitswap_i32(ret, ret, 0x33333333u);
+    gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
+    tcg_gen_bswap32_i32(ret, ret);
+}
+
 void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
@@ -1869,6 +1893,41 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
+static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
+{
+    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+    int sh = cto64(mask);
+
+    tcg_gen_andi_i64(t0, arg, mask);
+    tcg_gen_shri_i64(t1, arg, sh);
+    tcg_gen_shli_i64(t0, t0, sh);
+    tcg_gen_andi_i64(t1, t1, mask);
+    tcg_gen_or_i64(ret, t0, t1);
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    gen_bitswap_i64(ret, arg, 0x55555555ull);
+    gen_bitswap_i64(ret, ret, 0x33333333ull);
+    gen_bitswap_i64(ret, ret, 0x0f0f0f0full);
+    tcg_gen_bswap32_i64(ret, ret, flags | TCG_BSWAP_IZ);
+}
+
+void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
+    gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
+    gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
+    tcg_gen_bswap64_i64(ret, ret);
+}
+
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-- 
2.43.0


