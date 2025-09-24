Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9555DCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Uno-0008CF-QC; Wed, 24 Sep 2025 15:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uly-0006vy-0l
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujw-0007pH-JC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:21 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77c1814ca1dso140254b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740474; x=1759345274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCTrGX3KmloALN2paC3qrevC6P0gXZ2hKVt4HdoqLUQ=;
 b=Fol2lc3b4xKgJRev8tbm4rwmyUvUfVr9rfiQ2P4Y22uZT3ZqLlx4p37d32uyMYw1PU
 nrnGcYnliR2RXJ/2NpZnmLHbNk+AeGGa1zgvromRDfSmzbaajvaoVlSggAG9TSh3HSr0
 7gT2IrE6jXchqAtPWFnlVjOxqsLwXX50kSS/J1uN9jI/8O794+IAVLw5hIiTutQyxjwB
 r+j5iZzDxTw7K0TiEr4VfLfX8dXrjbEKU5ro5T8fz6vDSK5spIVTb5Elw7K3rofBRsQJ
 iINL8CVAPofRThehCRyNtCDpPA2XGKJmq+jkXDSsYyBjpprZAN2QY848vZ5jagbzWnOq
 saxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740474; x=1759345274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCTrGX3KmloALN2paC3qrevC6P0gXZ2hKVt4HdoqLUQ=;
 b=N5uCBvJajndXZEw9OXoTDELEkxNCWDENApCF+3w4r2Lgj7LfyVyVfSqSbmZnYTBF26
 PdDCC9lKgQ3fSLdB1Rl9/Y3fOPYzcsXCpa61l92LKxet7w6I67Ur0/JbNxK4/vRfshDj
 iwfLS+BMsY6ye0UCnEwGuFOlOPYC9PshSIlJtThMw54qSiVdafMx3/o5zhWbG+FCQSAb
 wzhgg/FRLB85mz9VMaZvAxfB/WDSTAEaJbAoD4+RC0kQL1sfcgPHd0LnOcyyX3qCWAyZ
 t/FW5PVzppaZ9TD0IGZ+8FUSgoXsxhgR4B/XHmY2u/45wx3im/YH2pFsnBDEjZ4HtH7z
 03EA==
X-Gm-Message-State: AOJu0YxlutD7EzmwF0IGFAVm+YBLWsYTXXytYavktUE3zLS+R1Y/qT/t
 ll4hRb/Uy/5aZeTOOJoxHITKZFgv3C7WfA8CTy7T2sinHwWhm1GPEtfDasEbDj6KnWJ3u6gBDrL
 P/apM
X-Gm-Gg: ASbGnctKAG8Wh7xkY3oE/ViAwQqYSf8zT7Xha9zDAhbbgSqIrYm6AicKTldNuuFvRPL
 SoXp0HJYPF1+mVBYY+G4s5X/ponQMPoGmfg954ssGNzOUpf82Q2vmx0Gdi1Y4OfZETGDSRWhTbq
 7lzWLlODIyrbchXNY9muvXXd0PHBNcrWJDajCSHxW8FOjjRrUY68lmCKQhPsYBRynlIDspYQwkv
 bUEowweZGxTl5b29E69YKXqhu6s6IfOV84FJyTj+UWvNECWnGVr9aExNMuNVYptNMjXn/er1pE5
 p08XiO0unkVVfmdBBz5mqZaW/RNUCzzKpwWQqYmJwup/csO9XwVp0eGcA3ZHXip1z6G3P5ATWQ/
 4Q3W58q26vr+jOEbbVVTDuSe1kS6y
X-Google-Smtp-Source: AGHT+IEuXC1uuJ/x9a8YgxJ3iAQ4zKOBy+HLE3cv7oFbezhXupBrFAFEtiR2Lov02ZuQCD39w5hgQw==
X-Received: by 2002:a17:90b:1f8c:b0:330:797a:f4ea with SMTP id
 98e67ed59e1d1-3342a2e73d7mr766688a91.29.1758740473971; 
 Wed, 24 Sep 2025 12:01:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 09/32] target/sparc: Loosen decode of RDWIM for v7
Date: Wed, 24 Sep 2025 12:00:42 -0700
Message-ID: <20250924190106.7089-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: 5d617bfba07 ("target/sparc: Move RDWIM, RDPR to decodetree")
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 40 ++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1c6403ad8a..77b2f54fdf 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -180,26 +180,28 @@ RESTORED            10 00001 110001 00000 0 0000000000000
 # UA2005 INVALW
 
 {
-  RDWIM             10 rd:5  101010 00000 0 0000000000000
-  RDPR_tpc          10 rd:5  101010 00000 0 0000000000000
+  [
+    RDPR_tpc            10 rd:5  101010 00000 0 0000000000000
+    RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
+    RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
+    RDPR_tt             10 rd:5  101010 00011 0 0000000000000
+    RDPR_tick           10 rd:5  101010 00100 0 0000000000000
+    RDPR_tba            10 rd:5  101010 00101 0 0000000000000
+    RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
+    RDPR_tl             10 rd:5  101010 00111 0 0000000000000
+    RDPR_pil            10 rd:5  101010 01000 0 0000000000000
+    RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
+    RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
+    RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
+    RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
+    RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
+    RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
+    RDPR_gl             10 rd:5  101010 10000 0 0000000000000
+    RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
+    RDPR_ver            10 rd:5  101010 11111 0 0000000000000
+  ]
+  RDWIM                 10 rd:5  101010 ----- - -------------
 }
-RDPR_tnpc           10 rd:5  101010 00001 0 0000000000000
-RDPR_tstate         10 rd:5  101010 00010 0 0000000000000
-RDPR_tt             10 rd:5  101010 00011 0 0000000000000
-RDPR_tick           10 rd:5  101010 00100 0 0000000000000
-RDPR_tba            10 rd:5  101010 00101 0 0000000000000
-RDPR_pstate         10 rd:5  101010 00110 0 0000000000000
-RDPR_tl             10 rd:5  101010 00111 0 0000000000000
-RDPR_pil            10 rd:5  101010 01000 0 0000000000000
-RDPR_cwp            10 rd:5  101010 01001 0 0000000000000
-RDPR_cansave        10 rd:5  101010 01010 0 0000000000000
-RDPR_canrestore     10 rd:5  101010 01011 0 0000000000000
-RDPR_cleanwin       10 rd:5  101010 01100 0 0000000000000
-RDPR_otherwin       10 rd:5  101010 01101 0 0000000000000
-RDPR_wstate         10 rd:5  101010 01110 0 0000000000000
-RDPR_gl             10 rd:5  101010 10000 0 0000000000000
-RDPR_strand_status  10 rd:5  101010 11010 0 0000000000000
-RDPR_ver            10 rd:5  101010 11111 0 0000000000000
 
 {
   WRWIM             10 00000 110010 ..... . .............  @n_r_ri
-- 
2.43.0


