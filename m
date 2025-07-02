Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39352C83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwlu-0006N3-M1; Wed, 02 Jul 2025 08:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj9-00049E-7S
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:16 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj3-00022G-M4
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:14 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6114114daddso2028452eaf.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459888; x=1752064688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9NT9snmBENHol/8ZRjeHJrq4krZJccIaCOsoD+gpXs=;
 b=yERag5xXRMSg+PzRnhvWFyvdP8vAKI3ZjznDSxZx9yETu+brdfeRfEmx1A4ywsd69b
 s5uTsq9CuG6cU1brYpADOGvzuM/a2z7aXYg73n8SjHiIyFnDS67aIrOBecLsGQVKH2PE
 GiK6L3DCPsCwsjiIWGNbZtRnulPEJ+fK+shzZlsYUy9xkPa3PtbunPjwT2M2pb1LZne/
 ab7Cu0xM8/vvUxqxAjKsYiCoBsUdBsexqLvJX6GiOg2HLbk52q/SP5O6tUF/yJx7QfU+
 pI7fF/5hwA+ReCgZnREO9SlzxKTubhdirRHOSbmHeETqLlKdt7YhxYWI4R5g/pfRZE2l
 PMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459888; x=1752064688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9NT9snmBENHol/8ZRjeHJrq4krZJccIaCOsoD+gpXs=;
 b=fzFqJVeYjY7lKHqmw6SFbEjvmCB6W0pkSQQrTD9te4iefE/jmPRctTbrrGqmxfY5AO
 6Ygs10anGwjiOOfU3XtKAp/5FkKlbhgjT7RXsb+xVtEcAOUqkZtm7g+leMOF0m9z68q8
 +2PZFARMasph0/4IH2J4waUCnGQtAWH0wZpRPfa6nRchHBkVqCZprVisd3CblCCDFvUi
 FEGtwowjXnZLyHdB3cqjM6iCLMdMF/qPj1lmYM1uKPuiYnyphIGV+fVyylDSQ9hYGHfX
 TXb2U1/R0ZbnYgVElAfJ4MwfGwlRi4H/M/T3pbsWVbxPXLdRjjoaYW9oHGWB91FEvqky
 jF6Q==
X-Gm-Message-State: AOJu0YzShCg9gglQhYHKmx60K403t7O/ojMyyrNkhBEz2QLy6113kTg2
 cfBySvmtp06SXbjl5558/w3krXmhjVbJBPcvbiq8c3PF1UUOwvF0tLt+2til1viYTIDZOHigvEp
 6frKgZ4w=
X-Gm-Gg: ASbGncuWDXa5/IPw0CEIMCFFcKG/kEgW3AxvkLitfANimj/mw5TQxhlDcOKOAemd2/I
 ZWkKGgFbio/9IHGrXLgs1U6pN9ZJsGZPrpKCC8dHryn7HetRbh3urcu+S7oA7LKu0/mZcJyBi77
 iFfVZyKZ188J9+EiAXLvs0UtmZfWhpyvQg7J2WywjtjKIQlfSnzv43jkkyPFWny+QPx28kYkmuQ
 wRLoUFU1f89cSBPmrHYV2ALGL8Hmj6Un10WocD9vzvWtrsRzt9grHv6Fh1uwbh22o7bgINsvS3X
 iN2qze+/kbA28XoEvoDoWksA1K4aZh5607Sc25U3ra/nMi5dlvwLMPE5MzCjW8PktYCeLQ==
X-Google-Smtp-Source: AGHT+IG/vpUijHIlipHVASfSnW9hhlJwpPjz3oJffqe4gToeun0b731afUreDmipFhx1N9+wh4KP6g==
X-Received: by 2002:a05:6870:9686:b0:29d:c764:f873 with SMTP id
 586e51a60fabf-2f5c7abccefmr2111730fac.31.1751459887772; 
 Wed, 02 Jul 2025 05:38:07 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 44/97] target/arm: Implement SME2 FCVTZS, FCVTZU
Date: Wed,  2 Jul 2025 06:33:17 -0600
Message-ID: <20250702123410.761208-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/translate-sme.c | 5 +++++
 target/arm/tcg/sme.decode      | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d6167eafe1..3bf2b6935f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1365,3 +1365,8 @@ TRANS_FEAT(FCVT_w, aa64_sme_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvt_w)
 TRANS_FEAT(FCVTL, aa64_sme_f16f16, do_zz_fpst, a, 0,
            FPST_A64_F16, gen_helper_sme2_fcvtl)
+
+TRANS_FEAT(FCVTZS, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fs)
+TRANS_FEAT(FCVTZU, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_gvec_vcvt_rz_fu)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 5100ebaeba..79df2dcd2b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -728,6 +728,10 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
                 &zz_n n=1 zn=%zn_ax2
 @zz_2x1         ........ ... ..... ...... zn:5  .....       \
                 &zz_n n=1 zd=%zd_ax2
+@zz_2x2         ........ ... ..... ...... .... . .....      \
+                &zz_n n=2 zd=%zd_ax2 zn=%zn_ax2
+@zz_4x4         ........ ... ..... ...... .... . .....      \
+                &zz_n n=4 zd=%zd_ax4 zn=%zn_ax4
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
@@ -737,3 +741,8 @@ FCVTN           11000001 001 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_w          11000001 101 00000 111000 ..... ....0       @zz_2x1
 FCVTL           11000001 101 00000 111000 ..... ....1       @zz_2x1
+
+FCVTZS          11000001 001 00001 111000 ....0 ....0       @zz_2x2
+FCVTZS          11000001 001 10001 111000 ...00 ...00       @zz_4x4
+FCVTZU          11000001 001 00001 111000 ....1 ....0       @zz_2x2
+FCVTZU          11000001 001 10001 111000 ...01 ...00       @zz_4x4
-- 
2.43.0


