Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8C3CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglK-000662-Ps; Fri, 05 Apr 2024 06:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglI-00064t-RJ
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglH-0004nI-Ad
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ecea46e1bfso1725836b3a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312730; x=1712917530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BwnXL0PuupABmOqDiTYjL1lyGImoPKlNTGPB4Zwgso=;
 b=PkyYjQfXQ5NIUp06rercROu6//7PbPqNI1FqoBB8shDdEftgEGw94YgbfYKKuEzuA1
 4j3a/b+/hIKJXvsGc+0SNojRGlUKajg4yHRDH3hzGYIgAfoFYMkxrmd6JFbBHT4yoBZU
 33L2Uxie5nagtHhjthB5sKiyBLoTbHKFYt1WY1KF1OKHgppDD+21zbsNFTFmQYTVBK/V
 78nce/cYbfGa3ThoPiKeTVQjzBx5CsJcbPMmbjO9oCysAddcvBQeg3oDLmX0M5oBXnxc
 zStle1a+bqWtn7DWPnFYQ76PveL+DU0dgVA/7zDrPOkVHR4VZooT8T5u8xFgzO+wzds1
 BUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312730; x=1712917530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BwnXL0PuupABmOqDiTYjL1lyGImoPKlNTGPB4Zwgso=;
 b=g4B2yJ+hA06Hpg5OPsGhTHU1Z7sBfoJGQvp+f8U3yAuoDXDeHLcFup09oyTPZcpkKY
 Uq+eQd7PSklAP8effsP8EI+TtJYdxoaXObtn0vDFW7o0W+KVCepAXmn7WKR3cskpEj79
 8diye+FK3LyMhq3pcuUvc5J11wYjW58UgRDeEVbCkIolPOQIAEEKf8/Lsz7m0gjcDgzu
 +N1+IN8PpJ62TVkwg4i+ODI1E7bj2uFQ1HfZFrNxY7ixFSyq2pNQw0512+kWap05Lf3v
 eTWS/C3+mokPdfSYLSCrMv1/2GHWXyJV2mPWgcePF6iy4VdssqVuS7jw007xF0ccIdiQ
 6nBg==
X-Gm-Message-State: AOJu0YwOCN8XNbkdNYFAeJtT2EoZie4bQRZs41+jM1qlk9SHyb6wsIdP
 9rDODmrgYcWlorehOV4tQnE//saSQOVr/LBICBQenNRJix1Z0aBqNfNTutgweOQgCWMriWS7sfw
 J
X-Google-Smtp-Source: AGHT+IFEdW+U4+O5cK9ipcEsbuT1Gdjx3nn5ZJO0UmTLyWtJ5uzxso4YOsQTnngjBqbRa5AjdQ6VGA==
X-Received: by 2002:a05:6a20:54a3:b0:1a3:5d2a:4001 with SMTP id
 i35-20020a056a2054a300b001a35d2a4001mr1175925pzk.44.1712312730150; 
 Fri, 05 Apr 2024 03:25:30 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PATCH 22/32] target/s390x: Disassemble EXECUTEd instructions
Date: Fri,  5 Apr 2024 00:24:49 -1000
Message-Id: <20240405102459.462551-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Cc: qemu-s390x@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c1614b8264..fed326b136 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6527,8 +6527,9 @@ static bool s390x_tr_disas_log(const DisasContextBase *dcbase,
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     if (unlikely(dc->ex_value)) {
-        /* ??? Unfortunately target_disas can't use host memory.  */
-        fprintf(logfile, "IN: EXECUTE %016" PRIx64, dc->ex_value);
+        /* The ex_value has been recorded with translator_fake_ld. */
+        fprintf(logfile, "IN: EXECUTE\n");
+        target_disas(logfile, cs, &dc->base);
         return true;
     }
     return false;
-- 
2.34.1


