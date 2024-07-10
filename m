Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4214CC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY5j-0006lF-IW; Wed, 10 Jul 2024 10:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5h-0006ep-Uq
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5f-0003wL-LM
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3678aa359b7so582882f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620878; x=1721225678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZV038v5PDie+4o0LGXftDcMbGJXn076Mf/fA/l7/zi4=;
 b=Wl/4rzTWaMn0m3bUk3wQobzZlWQuPNzhM54J766v65EdsBhE1CZyq4+jRR1G/O5Vxy
 OQLmAR2D9oS+eXg8qYZRxwsLQSC9q4JJafwTXl3Ri9GVn/eiqgtoXZoWaZAVf4omBCBz
 QLP4QFvVQHe8P1k58/bkaLGNtz2ZF7qEIeITaTQNQeSjXDZXAoAG0g1ce2O0Ekol8q3X
 52wm2PWRL9p8vn2DWKM1AJU/sjzf6pCUmWs/7TdwPUBx3nzB2twpZcQ5kBwUyJG4Y7pa
 JYajJc7YiBYi5J+jYJzfeH8E2Hv5T8yemBzzZsSf+tl/mniwXFQjSZ2+TnteOy4KPByC
 b4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620878; x=1721225678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZV038v5PDie+4o0LGXftDcMbGJXn076Mf/fA/l7/zi4=;
 b=BNCe93dJSfAcu+FQ3V6XXDeOqGBuFQtayeKu2AWxgDpB5o/s4sVC5J8g2EZbZrIkK/
 31ByURMrBt2bKgarkFtDxoCK8yfcMGacSNR66zK0wPKcIBSW7MCuZiW4b0fITLCoEuIl
 yNSpyuHzB8xzX1GRqOY6Ucg/BdSe4sydMOrcqL14NHfCZtoDJp3OiLrqFvtolCaQULKp
 VUuUiGJo6BaIb9p/hdfM9lVxYEGLKji3sBhJeWEgIBZ6Ip71OqbIKFRGM/PrpyeJI8ii
 S/Lf8YuweZFhdaQVOWP61F5/kZs0rkoVaxHn1dmu5EcLrl9sGjF7jjDFNV2/Nl1rx1DU
 0cqA==
X-Gm-Message-State: AOJu0YzeW1x5HEbFQxAxOd5mWorSh1spYMZRLlfCM/yyi2pO2pDV2w7j
 qDqsNFPjmUYM6IDM6lSBGAhF84Oj6PTk29vZ59K7DDKNrKgWvqjRmURD9O9kOLjMg/BVrWqAY5Y
 d
X-Google-Smtp-Source: AGHT+IHhoF0ZPX5AQZ7k/KEXpbpqEQGMlfXRzYVGBIhc3MsQccrq5UXAl/qWfEfM57gSpqpNo1RY7g==
X-Received: by 2002:a5d:4387:0:b0:367:8fe2:7d8b with SMTP id
 ffacd0b85a97d-367d2e78dfemr4492467f8f.31.1720620877886; 
 Wed, 10 Jul 2024 07:14:37 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab1cbsm5493344f8f.100.2024.07.10.07.14.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:14:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v48 04/12] hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR
 handler (CMD3)
Date: Wed, 10 Jul 2024 16:14:00 +0200
Message-ID: <20240710141408.69275-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240710141408.69275-1-philmd@linaro.org>
References: <20240710141408.69275-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0e36b0cc2e..7e17bd0736 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1280,6 +1280,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_identification_state:
+    case sd_standby_state:
+        sd->state = sd_standby_state;
+        sd_set_rca(sd, req.arg >> 16);
+        return sd_r1;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
@@ -2445,6 +2459,7 @@ static const SDProto sd_proto_emmc = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
-- 
2.41.0


