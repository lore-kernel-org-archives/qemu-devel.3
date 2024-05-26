Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A9C25B7D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlu-0008Eu-5B; Sun, 26 May 2024 15:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJls-0008E1-Ax
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlp-0007ec-Me
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:43:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f48bd643a0so3226935ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752584; x=1717357384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gRl+kJ9r/OgYFfd3fRn/evO0IwNIU7la++WeHVzGO8=;
 b=GNerLgqDh0hnL0yp7ME8D2mo+wBYrTLOGV6+t4U1bwjSmzb9rnCexaOuuf/civ1gzU
 i9ntpAUkBCaDHranjac/K+JQfl9Cv1WH6846pJ/3EcYX9kKREfeG5h1lJM19mLCob/89
 v4wuK8ldseXsrWMsnpeP2n9nsRCILUUaa7dVqAyd5qh+S5PjAGlg9ujh0UKnRUW/xG1C
 A26QSQTn8NVkKEXdHe2idfi2R8XI7vx3osQg1YrIt0DJp7jbMz2O8VNRLJulcajKbByI
 tyzLbm6XBZcaBN+Z5vaUZHT36zqDxcX9EI7DYZjTHxqCjvY3+cMvojDIOo1MMXEwy9Vx
 1arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752584; x=1717357384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5gRl+kJ9r/OgYFfd3fRn/evO0IwNIU7la++WeHVzGO8=;
 b=NvYzVBfWshXQcmJLgkDkPNg7IQvCSWHFsb3MU363I+HgW9m7BfHwCyZvT5PU5NH1Cr
 2JbLUh7a9ldeAJ13MGBNzmYFB1WVxaFMb6m6bfPLokX93B7ZNUTbnditOl9rIz7ycH5E
 G6qLEPh/naFUGpUA81rhPMb+bBhhYcmO+xQKWnAWnaIAtc6tVNqki8zpY64p1ZSjuzB1
 zKAO9q8Rmps5Cv6PSRQHswJkpopZD2fe69b7nUo8T6cHw9oSUD+IyqTsGGUmRSHBZaJP
 3NhshpiFtGEHyPsILWoJTk6P1dMRXx3nVVecObaSWAgMIfeyd+PHNorxlSuvqwp8C4tI
 aV+Q==
X-Gm-Message-State: AOJu0YyzOVt7dAy1ORFUBNlG0RCAuBiK/E2LQJsJx2RSZd+jPpr3s8i+
 R5Fq7kpB6myXnR+DWuyG9m9ElhoqkWeMnNxhoE307kMfJN51m2nXFQYGa6VV9a4yB9+oF51yBR6
 9
X-Google-Smtp-Source: AGHT+IEw9WH4HGm6ZUGPl6xW4hfaRlLPjdaLQce/eBR+GWmErThDDbhhGagXealXfSd1Qy7COZqMbw==
X-Received: by 2002:a17:902:e810:b0:1e4:fd4:48d0 with SMTP id
 d9443c01a7336-1f449900ab9mr90803675ad.62.1716752584214; 
 Sun, 26 May 2024 12:43:04 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:43:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/37] target/sparc: Implement ADDXC, ADDXCcc
Date: Sun, 26 May 2024 12:42:28 -0700
Message-Id: <20240526194254.459395-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526194254.459395-1-richard.henderson@linaro.org>
References: <20240526194254.459395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index 9e5fe905ad..40e245abdd 100644
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


