Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5DEC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHkD-00035O-HD; Sat, 02 Mar 2024 00:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHkB-00034q-Rz
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:08 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHkA-0007cY-9p
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:17:07 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bb9d54575cso1939885b6e.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356623; x=1709961423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpCW2bFOaVG6PHAgK8CQB4NCBtKP041BEGPtL/bAsq4=;
 b=Nir37rqwzDE0IpInJfFgLpQ92bLjCQuVPr4Q1HQ0xtzbRd7fNC0b2xTefSh20J44Ts
 EIn1DdkdAcvCt9KrKZq7Z1QHJsEJxXzTxQ+SJd37MONay9BgAT5Fx+/XYxePlYarBVe5
 ED/r+gg4pLSgfcTrKfoDnkEFpKhiqnIx6EqQiKKC3ct8TWC/gzNOACbnr4Y4/FKaml8h
 h/PMZCyrM14tZtxkP/WZVw6Gs8m4zdCp0vUJtGvTFVc1h0B8J4beLnxhqhbV1UzgG3nq
 CL6u0yU+tK+MeQlozCx9n3grNsluN/Ry4fa7199UsL4yVaMEimWTBsoaK2q1cxNck5Vg
 T3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356623; x=1709961423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpCW2bFOaVG6PHAgK8CQB4NCBtKP041BEGPtL/bAsq4=;
 b=Ct0b+SBt58ZNilyW4DC4j2xTFs5V3yBaYGWdK+AWUgF9fabHpgvi65pRhsBtYotKD7
 j76PfHM7s/Wr+mrozpTyLtLSCtSkYPqA/indFXlglWBo+L6GJZWJcBiFc54Bl5VDHKFT
 WCoUSZFmbE1cntAFDVkLxdh6xMdVqbuygfJtMZhfAaUPSfN3xGkjdNs2MGmrWT1PUUYJ
 kHihAiuzhmL0W6zq9w9aiMlCKCtN8LEQr1UiZJTDalTe0vmWjfJni1fhgQA9sol3jOd5
 GFx92C84loK7HemspQ9UH5TJ3yE4QFo/IGYKqQhMPy2OWiJ+L3lN7LxdlRzKvREL1zfI
 chKg==
X-Gm-Message-State: AOJu0YzfLjTInQHBBhz9kXqW3WkhwvKPlJNCjGB2Tzq04veXcPkZka0p
 vnhAWAmN/M9Vuaunp8IL22vKr4cG/wSnAg9f8plDBos1zKMvl/PPfB9GyWxj1xSB0C30+WClgbQ
 E
X-Google-Smtp-Source: AGHT+IF9UqrqxUMIp1WT9hENcBzWzQEX77ATv4o4ncslEI/tqswMJUsRMK2kX2Q8NMzS7Hc5au+HXA==
X-Received: by 2002:a05:6808:1188:b0:3c1:82ae:d61a with SMTP id
 j8-20020a056808118800b003c182aed61amr4135978oil.14.1709356623467; 
 Fri, 01 Mar 2024 21:17:03 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:17:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 38/41] target/sparc: Implement SUBXC, SUBXCcc
Date: Fri,  1 Mar 2024 19:15:58 -1000
Message-Id: <20240302051601.53649-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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
 target/sparc/translate.c  | 14 ++++++++++++++
 target/sparc/insns.decode |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8eda190233..4775e39240 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -524,6 +524,17 @@ static void gen_op_subccc(TCGv dst, TCGv src1, TCGv src2)
     gen_op_subcc_int(dst, src1, src2, gen_carry32());
 }
 
+static void gen_op_subxc(TCGv dst, TCGv src1, TCGv src2)
+{
+    tcg_gen_sub_tl(dst, src1, src2);
+    tcg_gen_sub_tl(dst, dst, cpu_cc_C);
+}
+
+static void gen_op_subxccc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subcc_int(dst, src1, src2, cpu_cc_C);
+}
+
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
     TCGv zero = tcg_constant_tl(0);
@@ -3959,6 +3970,9 @@ TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
 TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
 
+TRANS(SUBXC, VIS4, do_rrr, a, gen_op_subxc)
+TRANS(SUBXCcc, VIS4, do_rrr, a, gen_op_subxccc)
+
 TRANS(UMULXHI, VIS3, do_rrr, a, gen_op_umulxhi)
 
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index b7b4bfe92c..1f9e07e526 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -447,6 +447,8 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     PDISTN      10 ..... 110110 ..... 0 0011 1111 .....    @r_d_d
 
     FMEAN16     10 ..... 110110 ..... 0 0100 0000 .....    @d_d_d
+    SUBXC       10 ..... 110110 ..... 0 0100 0001 .....    @r_r_r
+    SUBXCcc     10 ..... 110110 ..... 0 0100 0011 .....    @r_r_r
     FCHKSM16    10 ..... 110110 ..... 0 0100 0100 .....    @d_d_d
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @d_d_d
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @d_r_r
-- 
2.34.1


