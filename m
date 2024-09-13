Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9549FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80W-0003Am-70; Fri, 13 Sep 2024 11:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80C-0002Ke-VW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:29 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80A-0007on-Ps
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374ca65cafdso737796f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240465; x=1726845265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6+ekIP5EhwsMQkc0KPYhWA2QQ3zCgXheY3Ga311k4tc=;
 b=es1ZfF4gUaq/QRXmMCFzkI6NsXy/xtbb3FfYaIcHQGp5TLRxK6ynGhN1Vfr7iFpim2
 XFtnqBNOnxeDBLJd7cOlkSou9t915e3e2KgLKFaC2wiukRmzXpmqJvGMW12lJ6qvjdP9
 sJd0OAq4GnqEPlVaeU8ajsKk+VSLuBIHuRhhW3LpwMIUbM/+Nlxs/s3k37M+xwcxYp6F
 oqR3NCYBAQKrtISO8wvmFSvBJgMaEzjSy5L+p58OrznOiyN+GUabK0OCXM5ZiIuOE4bY
 IWJ3vngccrPh56GmrQMF6TPKDcM8ODA2ocLbVNnYH76yM4HGIxiqWHPIMOsOyyvFFCYJ
 jTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240465; x=1726845265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+ekIP5EhwsMQkc0KPYhWA2QQ3zCgXheY3Ga311k4tc=;
 b=DgfpFZ8C2Q2O9bAwCW1sNbMD5xKlwQXkPhd9zJuMFKP5fENYQtiOGTS6EeMXnO6scG
 w/GR0smRzxaZlN2m1xsxGDr2UKGknwzGOxDdZSXhZyeYbxDJtV5k/U5QhKHyDlpYfAi0
 jQcL7Y4Ohs9aoDJaJ1ZlKI0hXeEJSqGHBmo+U1D/vS+K5hfP2QYJYvh9s7zvuLitP8AI
 UeIsUzZyQv7ykbuxkpPkP1XtlYK4KSiO+UPj5JpKRWJQPW8KfLB3TMGtFh1dYQt3EM32
 B2IA0VYvZ3m+CJKK5FP8+5Wpocmkg48WtAmcTnqjo5R0p2lGx/QC+JPyCY/nGfyjvM95
 Iang==
X-Gm-Message-State: AOJu0YxCMn3q3WTJ5abR5MAXBGhbN1cWMtQ7PKGxE7Q07q4cq8iNSwxw
 9lTEikRt0JlwMEYpS5HklG/fZC1dLVxXm1MNHJ8K3oGLYof3z8gc/zVQgxB6RyN/kCenMtkDsOr
 h
X-Google-Smtp-Source: AGHT+IEGCqfuMUnQnzywgdGBpNeeIt6ToglrZlldGZsL10TXeiS/6d7c6YfnyWw3etiUbv+iSrWciA==
X-Received: by 2002:a05:6000:1e4c:b0:371:8db9:939e with SMTP id
 ffacd0b85a97d-378d6253634mr1779374f8f.51.1726240464837; 
 Fri, 13 Sep 2024 08:14:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/27] hw/net/can/xlnx-versal-canfd: Fix byte ordering
Date: Fri, 13 Sep 2024 16:14:05 +0100
Message-Id: <20240913151411.2167922-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Doug Brown <doug@schmorgal.com>

The endianness of the CAN data was backwards in each group of 4 bytes.
For example, the following data:

00 11 22 33 44 55 66 77

was showing up like this:

33 22 11 00 77 66 55 44

Fix both the TX and RX code to put the data in the correct order.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Message-id: 20240827034927.66659-6-doug@schmorgal.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 9fba5b9dfc5..bcfffee1cc2 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -951,7 +951,7 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     }
 
     for (j = 0; j < frame->can_dlc; j++) {
-        val = 8 * i;
+        val = 8 * (3 - i);
 
         frame->data[j] = extract32(s->regs[reg_num + 2 + (j / 4)], val, 8);
         i++;
@@ -1093,19 +1093,19 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
             case 0:
                 rx_reg_num = i / 4;
 
-                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
+                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
                                           frame->data[i]);
                 break;
             case 1:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
-                                           frame->data[i]);
-                break;
-            case 2:
                 data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES1,
                                            frame->data[i]);
                 break;
+            case 2:
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
+                                           frame->data[i]);
+                break;
             case 3:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
                                            frame->data[i]);
                 /*
                  * Last Bytes data which means we have all 4 bytes ready to
-- 
2.34.1


