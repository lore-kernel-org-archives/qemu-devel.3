Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9BEC25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJfs-00080R-S8; Sun, 26 May 2024 15:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfq-0007zi-Ol
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJfn-0006Uy-Uc
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:36:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f4a52d2688so562455ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752208; x=1717357008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YqEh5l5SoncvQ/EKacHXAyZWnb/WEBe8rCSOYFprhk=;
 b=IbjXQGadOJRoLbZxCQ4SzBn4NE8jmE7k2ANEJmsU8GR5C5qOYT8FeP+a9luiUY38Fp
 fdC6GQzm61jCj5InSZlHTZJfZXnDMBzIM468ziD1wkabfrJpOW7YQzBWd36rbWeUsBkQ
 mqjVAXyaATFWiIOykpobGqpludt3bEjzwFjJGMbaoVxdNGsFc5ukA7LdFkqNSp9G5HaP
 xOsFd/b/UHXxtw1r6ihn+FpfcsHOVABXqDiXJPZ4TYQMR+1Uk0IwOzZsIDucn/hbDRkP
 L5MdekvNuszZnYRCf4bbC86AmjS5qBxIlCzCOp/77Dc3WWz6NNsAi1XJwbQpP5Hibual
 8Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752208; x=1717357008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YqEh5l5SoncvQ/EKacHXAyZWnb/WEBe8rCSOYFprhk=;
 b=koJsqV6/E5Nj9zuvs1oTxya4lPLGeNSZ37RsotLM+g+zwooXC+auA2wpBl5gUEl/zo
 nb0OjeoLrAtIH+OtoY6IbaMJhXdUH0A/AbqZe8Oxi0EQApvdsYjoORP22R9pkxeZuV3m
 hS+UCgvBBMSL8tj6NXIkniVPjTkIIy3JkdyMBX0fdvGDsPnENauHg+nl9VY2EjDr7sQL
 gyAI7aDhFUqkvnvQaaZ6b+waxSuYppV6W9iu6qHdEMeihy8Wu/Mak4REgLKYaVv6yJ3Q
 /JM867xaG+AD+Mrbe6rLPk0frn8tfvrPO780AiSSSpqyrh5z3pPxCCMV8fp2v8YlPehc
 M75Q==
X-Gm-Message-State: AOJu0Yw09OVseNeuap/KCs2LQ5wpVf3qK9/WgBbq1BkM6qJGl0MT70px
 4xD3n++ccBOkB8LOE+cpvcNRCDo5pN9PchML1q2q9GwZGaMc0x8dikDUuUH+wQDPkhgqdczE1o0
 C
X-Google-Smtp-Source: AGHT+IGzYLrB6jns3b9jCHSJIkkHZfMd94QgZWvC/YXqs9J1/qwSJlSWc5Lj5/p377gXI8+V5Qph7Q==
X-Received: by 2002:a17:902:ecd2:b0:1f3:38e2:3f51 with SMTP id
 d9443c01a7336-1f4499017a7mr126168665ad.68.1716752207777; 
 Sun, 26 May 2024 12:36:47 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f6155b6sm4943761a91.29.2024.05.26.12.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:36:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH RISU v2 11/13] sparc64: Add VIS3 instructions
Date: Sun, 26 May 2024 12:36:35 -0700
Message-Id: <20240526193637.459064-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240526193637.459064-1-richard.henderson@linaro.org>
References: <20240526193637.459064-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 sparc64.risu | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/sparc64.risu b/sparc64.risu
index 5b90b70..ca7ed35 100644
--- a/sparc64.risu
+++ b/sparc64.risu
@@ -155,3 +155,91 @@ FNMSUBs         FMAF 10 rd:5 110111 rs1:5 rs3:5 1001 rs2:5
 FNMSUBd         FMAF 10 rd:5 110111 rs1:5 rs3:5 1010 rs2:5
 FNMADDs         FMAF 10 rd:5 110111 rs1:5 rs3:5 1101 rs2:5
 FNMADDd         FMAF 10 rd:5 110111 rs1:5 rs3:5 1110 rs2:5
+
+#
+# VIS3
+#
+
+ADDXC           VIS3 10 rd:5 110110 rs1:5 0 0001 00 cc 1 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+
+FCHKSM16        VIS3 10 rd:5 110110 rs1:5 0 0100 0100 rs2:5
+FMEAN16         VIS3 10 rd:5 110110 rs1:5 0 0100 0000 rs2:5
+
+FHADDs          VIS3 10 rd:5 110100 rs1:5 0 0110 0001 rs2:5
+FHADDd          VIS3 10 rd:5 110100 rs1:5 0 0110 0010 rs2:5
+FHSUBs          VIS3 10 rd:5 110100 rs1:5 0 0110 0101 rs2:5
+FHSUBd          VIS3 10 rd:5 110100 rs1:5 0 0110 0110 rs2:5
+FNHADDs         VIS3 10 rd:5 110100 rs1:5 0 0111 0001 rs2:5
+FNHADDd         VIS3 10 rd:5 110100 rs1:5 0 0111 0010 rs2:5
+
+FNADDs          VIS3 10 rd:5 110100 rs1:5 0 0101 0001 rs2:5
+FNADDd          VIS3 10 rd:5 110100 rs1:5 0 0101 0010 rs2:5
+FNMULs          VIS3 10 rd:5 110100 rs1:5 0 0101 1001 rs2:5
+FNMULd          VIS3 10 rd:5 110100 rs1:5 0 0101 1010 rs2:5
+
+FPADD64         VIS3 10 rd:5 110110 rs1:5 0 0100 0010 rs2:5
+FPSUB64         VIS3 10 rd:5 110110 rs1:5 0 0100 0110 rs2:5
+
+FPADDS16        VIS3 10 rd:5 110110 rs1:5 0 0101 1000 rs2:5
+FPADDS16s       VIS3 10 rd:5 110110 rs1:5 0 0101 1001 rs2:5
+FPADDS32        VIS3 10 rd:5 110110 rs1:5 0 0101 1010 rs2:5
+FPADDS32s       VIS3 10 rd:5 110110 rs1:5 0 0101 1011 rs2:5
+FPSUBS16        VIS3 10 rd:5 110110 rs1:5 0 0101 1100 rs2:5
+FPSUBS16s       VIS3 10 rd:5 110110 rs1:5 0 0101 1101 rs2:5
+FPSUBS32        VIS3 10 rd:5 110110 rs1:5 0 0101 1110 rs2:5
+FPSUBS32s       VIS3 10 rd:5 110110 rs1:5 0 0101 1111 rs2:5
+
+FPCMPULE8       VIS3 10 rd:5 110110 rs1:5 1 0010 0000 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPUGT8       VIS3 10 rd:5 110110 rs1:5 1 0010 1000 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPEQ8        VIS3 10 rd:5 110110 rs1:5 1 0010 0010 rs2:5 \
+    !constraints { reg_ok($rd) }
+FPCMPNE8        VIS3 10 rd:5 110110 rs1:5 1 0010 1010 rs2:5 \
+    !constraints { reg_ok($rd) }
+
+FSLL16          VIS3 10 rd:5 110110 rs1:5 0 0010 0001 rs2:5
+FSRL16          VIS3 10 rd:5 110110 rs1:5 0 0010 0011 rs2:5
+FSLAS16         VIS3 10 rd:5 110110 rs1:5 0 0010 1001 rs2:5
+FSRA16          VIS3 10 rd:5 110110 rs1:5 0 0010 1011 rs2:5
+FSLL32          VIS3 10 rd:5 110110 rs1:5 0 0010 0101 rs2:5
+FSRL32          VIS3 10 rd:5 110110 rs1:5 0 0010 0111 rs2:5
+FSLAS32         VIS3 10 rd:5 110110 rs1:5 0 0010 1101 rs2:5
+FSRA32          VIS3 10 rd:5 110110 rs1:5 0 0010 1111 rs2:5
+
+LZCNT           VIS3 10 rd:5 110110 00000 0 0001 0111 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs2); }
+
+PDISTN          VIS3 10 rd:5 110110 rs1:5 0 0011 1111 rs2:5 \
+    !constraints { reg_ok($rd) }
+
+UMULXHI         VIS3 10 rd:5 110110 rs1:5 0 0001 0110 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+XMULX           VIS3 10 rd:5 110110 rs1:5 1 0001 0101 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+XMULXHI         VIS3 10 rd:5 110110 rs1:5 1 0001 0110 rs2:5 \
+    !constraints { reg_ok($rd) && reg_ok($rs1) && reg_ok($rs2); }
+
+MOVsTOuw        VIS3 10 rd:5 110110 00000 1 0001 0001 rs2:5 \
+    !constraints { reg_ok($rd) }
+MOVsTOsw        VIS3 10 rd:5 110110 00000 1 0001 0011 rs2:5 \
+    !constraints { reg_ok($rd) }
+MOVwTOs         VIS3 10 rd:5 110110 00000 1 0001 1001 rs2:5 \
+    !constraints { reg_ok($rs2) }
+MOVdTOx         VIS3 10 rd:5 110110 00000 1 0001 0000 rs2:5 \
+    !constraints { reg_ok($rd) }
+MOVxTOd         VIS3 10 rd:5 110110 00000 1 0001 1000 rs2:5 \
+    !constraints { reg_ok($rs2) }
+
+# Defer
+# LDXEFSR_r     VIS3 11 00011 100001 rs1:5 0 00000000 rs2:5
+# LDXEFSR_i     VIS3 11 00011 100001 rs1:5 1 simm:13
+
+# %gsr not handled by risu
+# CMASK8          VIS3 10 00000 110110 00000 0 0001 1011 rs2:5 \
+#     !constraints { reg_ok($rs2); }
+# CMASK16         VIS3 10 00000 110110 00000 0 0001 1101 rs2:5 \
+#     !constraints { reg_ok($rs2); }
+# CMASK32         VIS3 10 00000 110110 00000 0 0001 1111 rs2:5 \
+#     !constraints { reg_ok($rs2); }
-- 
2.34.1


