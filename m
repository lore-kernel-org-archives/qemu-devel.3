Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959A8C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 03:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9cuS-0003XJ-6n; Tue, 21 May 2024 23:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuP-0003VZ-6T
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:57 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9cuK-0004CO-Iw
 for qemu-devel@nongnu.org; Tue, 21 May 2024 23:44:54 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f0ecec6411so3258464a34.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716349491; x=1716954291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxIUhxUvrIHw5M1h1VVAS6ldscrCFCVDcfPsbNI5LGA=;
 b=vHS8pXr6ugyFdAQ3hes1i0ob3vbFOOOLh3+6EZ4/EmQ2KpMvVxvtyLi4OlWrnrTHoc
 ZdtNSbIUiXkhqlqu2d+SjBlY02t3CyRMQqul39X0vVGTh9xabFKRklrZ41imqFm6Vj1c
 KVyWBTf/vDbAPJtFg0tMM/ergEVXzNtb/89QWewwniw/6XXRQ4fZ2vaTmduwIfulMvq5
 /dnJrsXIWYRQ7y/utygNRHulA3Yp73NFh3FBvaWJigmg4Xm0IVB67De+DcMoj5aYXZlO
 MMCbCglmjL573alGmEGwGLgX4dBCC6H2nfTQR1kpi8YwFPejEwgZCmn4mxD9I6jS/dXN
 E6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716349491; x=1716954291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxIUhxUvrIHw5M1h1VVAS6ldscrCFCVDcfPsbNI5LGA=;
 b=YpZ8juF5r/gOsVrmLhmrETVpCCum9PkvoOYDCfxTgOvEkeFMSTWv4BFthneDlnOdP+
 LlXsOcUHGA+H04nR+SpGhbsqf+bVrWKHizzEHj10QEl7D3FL4G9OKOTLDfHrtH3B2xiz
 7y3frOS6xVYFUgbcVDX46V6d9fiTM9ilvadMaDTgVKi0yQ1vmiJG/SDAdMoumiykMruY
 kDEXVeJJTFlIBbZWM8a/vDAl9F+3HeMColTpJoGD5enqxGv/MoEgDr2IOA8f6uWntZIH
 8eSn1qIXuz0v44npkEKkBPyuvMTkMNUovY/zDX4s3tzlVXTD5Mf72DOnqYYi5PvnEO9h
 6ebA==
X-Gm-Message-State: AOJu0Yx8EXS0k7OIuNPFpVnaLveMzXeJUI7RsjvJRRBKdULuHfnF/g+u
 eZ5D3z04EcrYi055mdiWrzkL7MnonunJpW9gI3zHri0e7qagGTz8FPPqXBMOAWdpYjMY1l8DZDF
 o
X-Google-Smtp-Source: AGHT+IEhG/IwhSErZV8sLMYdAbq6poewYJ5PdR6tDdg3DRIQhmCCc+gB3LQ61c3S/Ai8BgUEp6l7tg==
X-Received: by 2002:a05:6870:6494:b0:244:bec8:febc with SMTP id
 586e51a60fabf-24c68e86104mr1035918fac.56.1716349491083; 
 Tue, 21 May 2024 20:44:51 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2bafsm21416617b3a.162.2024.05.21.20.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 20:44:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 8/8] sparc64: Add VIS1 instructions
Date: Tue, 21 May 2024 20:44:42 -0700
Message-Id: <20240522034442.140293-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522034442.140293-1-richard.henderson@linaro.org>
References: <20240522034442.140293-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 sparc64.risu | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/sparc64.risu b/sparc64.risu
index b45ea86..10a8510 100644
--- a/sparc64.risu
+++ b/sparc64.risu
@@ -28,3 +28,94 @@ XOR_r           SPARC 10 rd:5 0 cc:1 0011 rs1:5 0 00000000 rs2:5 \
     !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
 XOR_i           SPARC 10 rd:5 0 cc:1 0011 rs1:5 1 imm:13 \
     !constraints { reg_ok($rd) && reg_ok($rs1); }
+
+#
+# VIS1
+#
+
+EDGE8cc         VIS1 10 rd:5 110110 rs1:5 0 0000 0000 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE8Lcc        VIS1 10 rd:5 110110 rs1:5 0 0000 0010 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE16cc        VIS1 10 rd:5 110110 rs1:5 0 0000 0100 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE16Lcc       VIS1 10 rd:5 110110 rs1:5 0 0000 0110 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE32cc        VIS1 10 rd:5 110110 rs1:5 0 0000 1000 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+EDGE32Lcc       VIS1 10 rd:5 110110 rs1:5 0 0000 1010 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+
+ARRAY8          VIS1 10 rd:5 110110 rs1:5 0 0001 0000 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+ARRAY16         VIS1 10 rd:5 110110 rs1:5 0 0001 0010 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+ARRAY32         VIS1 10 rd:5 110110 rs1:5 0 0001 0100 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+
+FZEROd          VIS1 10 rd:5 110110 00000 0 0110 0000 00000
+FZEROs          VIS1 10 rd:5 110110 00000 0 0110 0001 00000
+FONEd           VIS1 10 rd:5 110110 00000 0 0110 1110 00000
+FONEs           VIS1 10 rd:5 110110 00000 0 0110 1111 00000
+
+FSRC1d          VIS1 10 rd:5 110110 rs1:5 0 0111 0100 00000
+FSRC1s          VIS1 10 rd:5 110110 rs1:5 0 0111 0101 00000
+FSRC2d          VIS1 10 rd:5 110110 00000 0 0111 1000 rs2:5
+FSRC2s          VIS1 10 rd:5 110110 00000 0 0111 1001 rs2:5
+FNOT1d          VIS1 10 rd:5 110110 rs1:5 0 0110 1010 00000
+FNOT1s          VIS1 10 rd:5 110110 rs1:5 0 0110 1011 00000
+FNOT2d          VIS1 10 rd:5 110110 00000 0 0110 0110 rs2:5
+FNOT2s          VIS1 10 rd:5 110110 00000 0 0110 0111 rs2:5
+
+FPADD16         VIS1 10 rd:5 110110 rs1:5 0 0101 0000 rs2:5
+FPADD16s        VIS1 10 rd:5 110110 rs1:5 0 0101 0001 rs2:5
+FPADD32         VIS1 10 rd:5 110110 rs1:5 0 0101 0010 rs2:5
+FPADD32s        VIS1 10 rd:5 110110 rs1:5 0 0101 0011 rs2:5
+FPSUB16         VIS1 10 rd:5 110110 rs1:5 0 0101 0100 rs2:5
+FPSUB16s        VIS1 10 rd:5 110110 rs1:5 0 0101 0101 rs2:5
+FPSUB32         VIS1 10 rd:5 110110 rs1:5 0 0101 0110 rs2:5
+FPSUB32s        VIS1 10 rd:5 110110 rs1:5 0 0101 0111 rs2:5
+
+FNORd           VIS1 10 rd:5 110110 rs1:5 0 0110 0010 rs2:5
+FNORs           VIS1 10 rd:5 110110 rs1:5 0 0110 0011 rs2:5
+FANDNOT1d       VIS1 10 rd:5 110110 rs1:5 0 0110 0100 rs2:5
+FANDNOT1s       VIS1 10 rd:5 110110 rs1:5 0 0110 0101 rs2:5
+FANDNOT2d       VIS1 10 rd:5 110110 rs1:5 0 0110 1000 rs2:5
+FANDNOT2s       VIS1 10 rd:5 110110 rs1:5 0 0110 1001 rs2:5
+FXORd           VIS1 10 rd:5 110110 rs1:5 0 0110 1100 rs2:5
+FXORs           VIS1 10 rd:5 110110 rs1:5 0 0110 1101 rs2:5
+FNANDd          VIS1 10 rd:5 110110 rs1:5 0 0110 1110 rs2:5
+FNANDs          VIS1 10 rd:5 110110 rs1:5 0 0110 1111 rs2:5
+FANDd           VIS1 10 rd:5 110110 rs1:5 0 0111 0000 rs2:5
+FANDs           VIS1 10 rd:5 110110 rs1:5 0 0111 0001 rs2:5
+FXNORd          VIS1 10 rd:5 110110 rs1:5 0 0111 0010 rs2:5
+FXNORs          VIS1 10 rd:5 110110 rs1:5 0 0111 0011 rs2:5
+FORNOT1d        VIS1 10 rd:5 110110 rs1:5 0 0111 0110 rs2:5
+FORNOT1s        VIS1 10 rd:5 110110 rs1:5 0 0111 0111 rs2:5
+FORNOT2d        VIS1 10 rd:5 110110 rs1:5 0 0111 1010 rs2:5
+FORNOT2s        VIS1 10 rd:5 110110 rs1:5 0 0111 1011 rs2:5
+FORd            VIS1 10 rd:5 110110 rs1:5 0 0111 1100 rs2:5
+FORs            VIS1 10 rd:5 110110 rs1:5 0 0111 1101 rs2:5
+
+FMUL8x16        VIS1 10 rd:5 110110 rs1:5 0 0011 0001 rs2:5
+FMUL8x16AU      VIS1 10 rd:5 110110 rs1:5 0 0011 0011 rs2:5
+FMUL8x16AL      VIS1 10 rd:5 110110 rs1:5 0 0011 0101 rs2:5
+FMUL8SUx16      VIS1 10 rd:5 110110 rs1:5 0 0011 0110 rs2:5
+FMUL8ULx16      VIS1 10 rd:5 110110 rs1:5 0 0011 0111 rs2:5
+FMULD8SUx16     VIS1 10 rd:5 110110 rs1:5 0 0011 1000 rs2:5
+FMULD8ULx16     VIS1 10 rd:5 110110 rs1:5 0 0011 1001 rs2:5
+
+FPACK32         VIS1 10 rd:5 110110 rs1:5 0 0011 1010 rs2:5
+FPACK16         VIS1 10 rd:5 110110 00000 0 0011 1011 rs2:5
+FPACKFIX        VIS1 10 rd:5 110110 00000 0 0011 1101 rs2:5
+PDIST           VIS1 10 rd:5 110110 rs1:5 0 0011 1110 rs2:5
+
+FPMERGE         VIS1 10 rd:5 110110 rs1:5 0 0100 1011 rs2:5
+FEXPAND         VIS1 10 rd:5 110110 00000 0 0100 1101 rs2:5
+
+# %gsr not handled by risu
+# ALIGNADDR     VIS1 10 rd:5 110110 rs1:5 0 0001 1000 rs2:5 \
+#     !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+# ALIGNADDRL    VIS1 10 rd:5 110110 rs1:5 0 0001 1010 rs2:5 \
+#     !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+# FALIGNDATAg   VIS1 10 rd:5 110110 rs1:5 0 0100 1000 rs2:5
-- 
2.34.1


