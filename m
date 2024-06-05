Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D30C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuME-0006CE-J1; Wed, 05 Jun 2024 13:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMC-0006AS-7A
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:28 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMA-0003wJ-8K
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:27 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so20525a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608205; x=1718213005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NE3KV6Li9kGzQFCPbwah62llja+X88iRB27jiAmAxwo=;
 b=AuVarOZzzpzTI7FD1wzRG/0pf64yAfnP+pIXOKvtGzpBvqptPf1WHTnPwKREEqK4Wf
 b68SisLsYfN7fy8n2K0ak4jd6VIAp7/geAIZHPfrhUG6sH+l3Ou9lmbAITK8/N0j9GUn
 Rs7TtQRmhtDNlsZDtqF89RCQf5XE1Clt3r5DZLmkMcYgH3o0zTXHhMZ7RCuwyaExOqcB
 WDCQxLaomyBU0VUoicD0LGuRcrUIIcMFqCga4cdk6TRTo1hYNyi7xEab/Pvc3A20l2Gy
 nLGH0qz+WAhHkhTFTzkgfmx+LwFgCEvCXW/Ves0aFAh31oeXiagsRg3lf9m4jhMA8VYB
 RIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608205; x=1718213005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NE3KV6Li9kGzQFCPbwah62llja+X88iRB27jiAmAxwo=;
 b=YwwscJnNLXtoKP/DcXP60L8Hz482T8zfll81F9yQHRjCFyfk4cUVLJX+Me8iyezyQY
 3i36n72ERc3pcyx+1GGZS9JjaGAg/7vbhI1OZWfOimV6CFDfaeLPQwXOjvfg6Gk4HlSI
 Q+xRWy1PMEA3SYdBUS/M9m7hjeoY/7pJmAK32nrAhPMilFQgCtmQMhfnW1G4CNrblRxe
 7vrigFnHu1JgWTTpAkDKEBFFm2wK0D30dw23dw6BsOV81ZHwagwlEY3EebeTaKdiQ0WX
 ahhrlMLaXj7Ew/o3+sykqcyoj8VOoacqnRr2s6aG6KGqFnk47gW+92jeOlOF1b3lSgkR
 K7BA==
X-Gm-Message-State: AOJu0Yz0xKEjmgznrrhN+yF4WKBpBnaVp7+5teQYMfnW/lJtOogmC3JE
 Hj07sCba0dXAQbb3yhhBPf3aUpxWRWcP/MQC7mm81J+12YU8xO6+j8NiLMWYU8n0/ZeiMCMEmRM
 u
X-Google-Smtp-Source: AGHT+IE1yHCkyituDB0N6bmocB5Fvs4dZuvHsdWKbi/lli+K039+QQbg3MOcGz7C1odnurPn3fF5Vw==
X-Received: by 2002:a17:90b:896:b0:2c2:5774:d52b with SMTP id
 98e67ed59e1d1-2c27db119aamr3249132a91.20.1717608204955; 
 Wed, 05 Jun 2024 10:23:24 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/38] target/sparc: Implement 8-bit FPADD, FPADDS, and FPADDUS
Date: Wed,  5 Jun 2024 10:22:47 -0700
Message-Id: <20240605172253.356302-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
 target/sparc/insns.decode |  9 +++++++++
 target/sparc/translate.c  | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0913fe7a86..80579642d1 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -509,6 +509,15 @@ FCMPEq      10 000 cc:2 110101 .....  0 0101 0111 .....    \
     MOVdTOx     10 ..... 110110 00000 1 0001 0000 .....    @r_d2
     MOVxTOd     10 ..... 110110 00000 1 0001 1000 .....    @d_r2
 
+    FPADD8      10 ..... 110110 ..... 1 0010 0100 .....    @d_d_d
+    FPADDS8     10 ..... 110110 ..... 1 0010 0110 .....    @d_d_d
+    FPADDUS8    10 ..... 110110 ..... 1 0010 0111 .....    @d_d_d
+    FPADDUS16   10 ..... 110110 ..... 1 0010 0011 .....    @d_d_d
+    FPSUB8      10 ..... 110110 ..... 1 0101 0100 .....    @d_d_d
+    FPSUBS8     10 ..... 110110 ..... 1 0101 0110 .....    @d_d_d
+    FPSUBUS8    10 ..... 110110 ..... 1 0101 0111 .....    @d_d_d
+    FPSUBUS16   10 ..... 110110 ..... 1 0101 0011 .....    @d_d_d
+
     FLCMPs      10 000 cc:2 110110 rs1:5 1 0101 0001 rs2:5
     FLCMPd      10 000 cc:2 110110 ..... 1 0101 0010 ..... \
                 rs1=%dfp_rs1 rs2=%dfp_rs2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f51ce2ff2c..973c0cec07 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5025,17 +5025,28 @@ static bool do_gvec_ddd(DisasContext *dc, arg_r_r_r *a, MemOp vece,
     return advance_pc(dc);
 }
 
+TRANS(FPADD8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_add)
 TRANS(FPADD16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_add)
 TRANS(FPADD32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_add)
+
+TRANS(FPSUB8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_sub)
 TRANS(FPSUB16, VIS1, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sub)
 TRANS(FPSUB32, VIS1, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sub)
+
 TRANS(FCHKSM16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fchksm16)
 TRANS(FMEAN16, VIS3, do_gvec_ddd, a, MO_16, gen_op_fmean16)
 
+TRANS(FPADDS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_ssadd)
 TRANS(FPADDS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ssadd)
 TRANS(FPADDS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_ssadd)
+TRANS(FPADDUS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_usadd)
+TRANS(FPADDUS16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_usadd)
+
+TRANS(FPSUBS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_sssub)
 TRANS(FPSUBS16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_sssub)
 TRANS(FPSUBS32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_sssub)
+TRANS(FPSUBUS8, VIS4, do_gvec_ddd, a, MO_8, tcg_gen_gvec_ussub)
+TRANS(FPSUBUS16, VIS4, do_gvec_ddd, a, MO_16, tcg_gen_gvec_ussub)
 
 TRANS(FSLL16, VIS3, do_gvec_ddd, a, MO_16, tcg_gen_gvec_shlv)
 TRANS(FSLL32, VIS3, do_gvec_ddd, a, MO_32, tcg_gen_gvec_shlv)
-- 
2.34.1


