Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81539C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuLv-0005uO-F4; Wed, 05 Jun 2024 13:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLt-0005to-Bs
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:09 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuLr-0003pv-ND
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:09 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c20eed350fso56006a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608186; x=1718212986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PklYj+wdRsq+58m+W8oXjEvPOhzPbyCuNlNjiYJbtqM=;
 b=PNGPtg6ZCuml1HQ3k2JGDTUO3H/bn+Hu+ZrlEMtCTVLx0dXFcNQxEf0nW+YNKr4vc7
 7AwH6C6A5CHF1a0JcPIFiQPLYjurNqlpffDWJkXh9dNXK3CV0jCRWK7SWcc4vT3EZ9vc
 /c7nHPSJ0jJ7JRluR7xbWaocSnusDhuG4CllYQi/k9x8hh63C4Oo/+mugBt9A++/05sf
 BRqFHoLeDtUcDZOQs80JAWxf/iQaj3WPEnQeOlnomC5qCJyWyrQsYNRsGHZUWxJHHYzp
 N3d20iFWU0qtnGHKIeKWsf5h9PZFFxfsuErUOvX+CpsVMpHaoHKiQsc8b5qgKCwRcHK1
 HcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608186; x=1718212986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PklYj+wdRsq+58m+W8oXjEvPOhzPbyCuNlNjiYJbtqM=;
 b=xQ2HsL5gqBodNUq/O39cO+qiTMNjXb02VDpTejNHwPvcjK11uuWexjyCeYStJLjzKc
 pOv6TU/bkl4c7PhJQZKPUMqtc2ICUoRwNrQkn7B1v2SH+RrqdT5SFQ48yS1aSP4QU72+
 xgyNA5bWFKyA2vlaGB7cSkifBZlqQgxssr0nzUbaNSUbWh/SVBHl8FYY070wFK0Yu/2P
 veUj2egKI6NcCQuos/Sbw7qjA+lMm2msPmSn80LY7wEGeQbsaoz7s+QjGCdT/CU6xOlX
 2OcGoh3zyQm9SwZvRKyHLyqyfNX0ziXD8dAB5usUNobTTY+lOJIR6RpeunPb6FrqErvO
 Igcw==
X-Gm-Message-State: AOJu0Yxt+5qkfR6evm5GGm3bLJ3I27yTqVqH1d6Q/II0lyuom6JlzLpP
 jnGdTXH6tOASAKQZTAnwZMrMMCUy4dJT818NBvjA5DC6Whtswbzn/nVRmuA6yP9PeqxxQf66Ns+
 P
X-Google-Smtp-Source: AGHT+IFh9bwBevYi+iuDLWUQZrEl2lpNIleqlIKt3fWJRoHYr4+P0iBGFAD0H1TCnIanF61RhNwQ3A==
X-Received: by 2002:a17:90a:b383:b0:2c2:4134:51cc with SMTP id
 98e67ed59e1d1-2c27db11924mr3229359a91.18.1717608186426; 
 Wed, 05 Jun 2024 10:23:06 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/38] target/sparc: Implement ADDXC, ADDXCcc
Date: Wed,  5 Jun 2024 10:22:27 -0700
Message-Id: <20240605172253.356302-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 056fba98f9..5d1c55aa78 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -376,6 +376,9 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     ARRAY16     10 ..... 110110 ..... 0 0001 0010 .....    @r_r_r
     ARRAY32     10 ..... 110110 ..... 0 0001 0100 .....    @r_r_r
 
+    ADDXC       10 ..... 110110 ..... 0 0001 0001 .....    @r_r_r
+    ADDXCcc     10 ..... 110110 ..... 0 0001 0011 .....    @r_r_r
+
     ALIGNADDR   10 ..... 110110 ..... 0 0001 1000 .....    @r_r_r
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 59b922c903..ad12486758 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -433,6 +433,17 @@ static void gen_op_addccc(TCGv dst, TCGv src1, TCGv src2)
     gen_op_addcc_int(dst, src1, src2, gen_carry32());
 }
 
+static void gen_op_addxc(TCGv dst, TCGv src1, TCGv src2)
+{
+    tcg_gen_add_tl(dst, src1, src2);
+    tcg_gen_add_tl(dst, dst, cpu_cc_C);
+}
+
+static void gen_op_addxccc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addcc_int(dst, src1, src2, cpu_cc_C);
+}
+
 static void gen_op_subcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
 {
     TCGv z = tcg_constant_tl(0);
@@ -3692,6 +3703,9 @@ TRANS(ARRAY8, VIS1, do_rrr, a, gen_helper_array8)
 TRANS(ARRAY16, VIS1, do_rrr, a, gen_op_array16)
 TRANS(ARRAY32, VIS1, do_rrr, a, gen_op_array32)
 
+TRANS(ADDXC, VIS3, do_rrr, a, gen_op_addxc)
+TRANS(ADDXCcc, VIS3, do_rrr, a, gen_op_addxccc)
+
 static void gen_op_alignaddr(TCGv dst, TCGv s1, TCGv s2)
 {
 #ifdef TARGET_SPARC64
-- 
2.34.1


