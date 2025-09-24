Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD57CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Uo0-0008MB-Ld; Wed, 24 Sep 2025 15:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uly-0006w0-1H
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujx-0007oC-8V
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:21 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so214234b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740472; x=1759345272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xlzJQOFlorrMw5CndfvG4jengOA2DFNt3pdatOiYndA=;
 b=jBtxunwpEslYpEoaaJq2Htbj2sQntCYVHW9G7P6b/TS13fDIRvKrwcbDmZ/R6QR3q0
 MEhCkPGZmFBQ2oDevv1yaOxfUOqaZt07wwhit8u1UswZ+DkFn3pPXItfeT2/KPmJ0suh
 ScQGP0MCcnUZukvD8EpmamorcNpzyIai2ewkRXszvE42IF8tcFugBe1YLHmaoEmWnOYb
 W0IFK27y/BOGAg/lXMy/mHRK+Itg1h4JA7uKwziDwBQMo8qLH9xgbrC9jSR7KNjaAzPC
 I7Pfa+b/PB2a9OpOtUvTKVa9LvXjtSjP/z6qVphCgdErncSHxHpw+ym5XMKN46ceT2OA
 s5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740472; x=1759345272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xlzJQOFlorrMw5CndfvG4jengOA2DFNt3pdatOiYndA=;
 b=fWyiIOW4TuS3kTDyOMnCJ5/DjdJLH69OIbvHCoWjlQMDBd5g8BdZ5yEJvWgfAOeTQ4
 wuZUxEHeH88FMDEH2raWQlDt//DCQ7IEWUYAEvgwHiJioMt4bQhw1vkOwjWCtwsc6xn7
 Tqbvs2pcCFGYeLKMxxAt8rqsDkG6glPhiHxvK1/3izHSgULK+M+aw2lxjdW22ke3x/D1
 F3rH7ejV/lKJQPkuzZk1noeXaSoq+BbtEI8sVl7Ggbacec0ov+h/sQLAeb3E3Q2FaZ0d
 HUSjiQ2ibHHdq4kJnepU99PV9d5f0O5/sgNxZHwFzJbDviDe2hFDTfOmELapxg7Ova17
 ShwQ==
X-Gm-Message-State: AOJu0YyhC71Lm/5/heOBi+n+U4aSrLPTAB7WBdAwR57IwuVwOdFRYq8E
 TvxCWdQU5uTalZUQS9LP97D4PycCCRT7/890VQNorRPFC4Q1JAzBiAZtVvChgG4TLnZATFs1R8G
 hiCcW
X-Gm-Gg: ASbGncsc1KJOUj1K30ocNZnAOEUz5WGH2NtFqKfkO4VilyUJwxgajKY22d5EW6Brghr
 oWjAD0dCdF/oTq1yXLQG/rD/nnWMI8QPnnN4JU6oE9Vfzxi9rMc9PF3yVyUyAZpdeC5GHRr6joa
 NcvDLTK91xQ/Z7b/1GUAsNTM7KtjO+uv7gVFsiP9DMCYrzno+a+vofghFPuVrIEcaCLjN8uVfGt
 zMYc0sqQamxv7ZsUD1DU3/0B8hhZxc+VMNxV+rShHdNbfnjmAePtLwJbzrnG/I8xBdeB9ikMOdc
 SJMeI9mhTmBoslmgYAIKvkiaFDt0LKua4mOiGw0ZGSOc83qmFsSwDlzHtFVt4aqRNcjbL8p+YLN
 2nTzuRGzCdZyfpJd0LE31hyc3Vczd
X-Google-Smtp-Source: AGHT+IF1mo+pVFpoGBzT0gOPLgJO4eZDbacPcxdrukY31f3QgjV+KjwpbRNffDDYYz/IkAZZ3BXQ+g==
X-Received: by 2002:a17:90b:4c46:b0:32e:a10b:ce48 with SMTP id
 98e67ed59e1d1-3342a260f90mr890419a91.12.1758740471680; 
 Wed, 24 Sep 2025 12:01:11 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 06/32] target/sparc: Loosen decode of STBAR for v8
Date: Wed, 24 Sep 2025 12:00:39 -0700
Message-ID: <20250924190106.7089-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Solaris 8 appears to have a bug whereby it executes v9 MEMBAR
instructions when booting a freshly installed image. According
to the SPARC v8 architecture manual, whilst bits 13 and bits 12-0
of the "Read State Register Instructions" are notionally zero,
they are marked as unused (i.e. ignored).

Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3097
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c  |  5 ++++-
 target/sparc/insns.decode | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 336583beab..ece393fffc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2823,12 +2823,15 @@ static bool trans_Tcc_i_v9(DisasContext *dc, arg_Tcc_i_v9 *a)
     return do_tcc(dc, a->cond, a->cc, a->rs1, true, a->i);
 }
 
-static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
+static bool do_stbar(DisasContext *dc)
 {
     tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
     return advance_pc(dc);
 }
 
+TRANS(STBAR_v8, 32, do_stbar)
+TRANS(STBAR_v9, 64, do_stbar)
+
 static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
 {
     if (avail_32(dc)) {
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9e39d23273..1b1b85e9c2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -88,7 +88,7 @@ CALL    01 i:s30
 
 {
   [
-    STBAR           10 00000 101000 01111 0 0000000000000
+    STBAR_v9        10 00000 101000 01111 0 0000000000000
     MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
 
     RDCCR           10 rd:5  101000 00010 0 0000000000000
@@ -107,6 +107,17 @@ CALL    01 i:s30
     RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
     RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
   ]
+
+  # The v8 manual, section B.30 STBAR instruction, says
+  # bits [12:0] are ignored, but bit 13 must be 0.
+  # However, section B.28 Read State Register Instruction has a
+  # comment that RDASR with rs1 = 15, rd = 0 is STBAR.  Here,
+  # bit 13 is also ignored and rd != 0 is merely reserved.
+  #
+  # Solaris 8 executes v9 MEMBAR instruction 0x8143e008 during boot.
+  # This confirms that bit 13 is ignored, as 0x8143c000 is STBAR.
+  STBAR_v8          10 ----- 101000 01111 - -------------
+
   # Before v8, all rs1 accepted; otherwise rs1==0.
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
-- 
2.43.0


