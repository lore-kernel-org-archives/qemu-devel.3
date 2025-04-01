Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600AAC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcCC-0000Um-Ko; Tue, 01 Apr 2025 10:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcC1-0008KE-Sg
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcC0-0000Q9-Bd
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2295d78b45cso18486475ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743516134; x=1744120934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9T3FnIs1Bq+FDkpTsS+3s/kAk1Ff7w/CeCPlPCn7YuQ=;
 b=DJ3D0kpaIkbHmKM/dAMUS/YYsF/pgbJigb2xnkO2gDHB1y1qnqCLtOR27gZOy2DUC8
 oVeJuT3dY0fuFo7pxyN4qYCYYbVYjkmuuVVpipwG9PRK00uzib5UjeTxeDPt+MRAw2GC
 zaVQLKElRuX0AqRD3j6Cc4zAQwaA9Pvd269V+cw7G1IQCtVPpUNxGEVwbara4Soeeskc
 IFgcUYkfUIC7sx4wB6HJ9PhU/Kp/66STIkCTqVdGQyBmHUmToMFGEENVmZBZLSFNxv0r
 EC5WiSO4nu2nTWaXCGWFuKeZl3KCIOT8+qp9FToU2wxNXX7ohrMSmZLV5PvD4gFzJ1CN
 mb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516134; x=1744120934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9T3FnIs1Bq+FDkpTsS+3s/kAk1Ff7w/CeCPlPCn7YuQ=;
 b=p2L/YHcKTpYoLOqo1oecCgfTTxkAEfGnL8nFNU8ffSm/Bc2b3lRVz/bStKMOvbUCXP
 cAkb6M8IWHH9XtUrFiV9t0BqCGqrCiGYQtl1BhDOrki0Ba1Z8hm2maenPEcBs7avihJj
 UjK7LKg6MYrBcMZ9Q6IVo72wpokAKhMDUfBk14eRlaj7lLAWP8+MMpkRSxVINNct6yI2
 O98IrQR6myeUdPpjALZBWHCMs8sibKKjzuTykr0AXZp8QLbkJKpRK/9FU9MC34PHYbUs
 vYoz1BjGjJIyVHzJMYisDa8oh1yhWjBNBvLaSgxg/KoFvog05l0P2VzoAM1A+RE8P0JR
 m+Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCyWvdZR3K3VFcI8L7X5wryntRC2mxEM0t7O179E69ARdnvlD0ZnjYP0tLHsKWKFmPDwzpmkfpLPSQ@nongnu.org
X-Gm-Message-State: AOJu0YxJGgsVzkcpbWIW9L8+q19ZtTMxQ4oCbrrwWf71eHa2jiRDNRHt
 IW4hsTJXbQtbokOPVZSBU61537qAk5WjUbZ2anRJPfCEw6M7LBxnDpcg+A==
X-Gm-Gg: ASbGncuVS9D1GmdWrVfmXRAxTWtwvvi3EcYLX/zxKoDIDSl79ZZVnUHSWDsOOYxBucH
 9w4mSI0xoSYwCoPV3V2cXijSuO4RIYCIUzvE6V5ly9gPuYZ4GCmGJY5Sd0FJ+f9QDzLXdYE45Yy
 VQUs6ikrYkTcwTioOc55u6XXKyxcnfWOTsuUMLVMGTl8Xl+jcBL+d5Rbw6ZchhdBomMHfwWTXjk
 Y13MMCX7UeQ4j+9e8Kw6IAsZxEKIQ2t95jwsan9NEEyoEgI4R5A2uST1xlHIzvUqf4r+OOLNB96
 ii8RPpa+N3Oie+D4if8jwhUhd7hgykqwBaeFg2QlRbe6hwVMiQ==
X-Google-Smtp-Source: AGHT+IF6iwKMreTheZTf8WOqiEtaQHYvGwcPCGEeu3mC/0/y0YX23OmLnH7Shz4uQC3jcQgRizSsBw==
X-Received: by 2002:a17:903:94e:b0:216:2bd7:1c4a with SMTP id
 d9443c01a7336-2292f973fabmr201439305ad.26.1743516133815; 
 Tue, 01 Apr 2025 07:02:13 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f5774sm87768455ad.214.2025.04.01.07.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:02:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] ipmi/bmc-sim: add error handling for 'Set BMC Global
 Enables' command
Date: Wed,  2 Apr 2025 00:01:52 +1000
Message-ID: <20250401140153.685523-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401140153.685523-1-npiggin@gmail.com>
References: <20250401140153.685523-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Mask out unsupported bits and return failure if attempting to set
any. This is not required by the IPMI spec, but it does require that
system software not change bits it isn't aware of.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 98cfab6a455..3c008a3a603 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -235,6 +235,7 @@ struct IPMIBmcSim {
 #define IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(s) \
     (IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE & (s)->msg_flags)
 
+#define IPMI_BMC_GLOBAL_ENABLES_SUPPORTED 0x0f
 #define IPMI_BMC_RCV_MSG_QUEUE_INT_BIT    0
 #define IPMI_BMC_EVBUF_FULL_INT_BIT       1
 #define IPMI_BMC_EVENT_MSG_BUF_BIT        2
@@ -934,7 +935,14 @@ static void set_bmc_global_enables(IPMIBmcSim *ibs,
                                    uint8_t *cmd, unsigned int cmd_len,
                                    RspBuffer *rsp)
 {
-    set_global_enables(ibs, cmd[2]);
+    uint8_t val = cmd[2];
+
+    if (val & ~IPMI_BMC_GLOBAL_ENABLES_SUPPORTED) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    set_global_enables(ibs, val);
 }
 
 static void get_bmc_global_enables(IPMIBmcSim *ibs,
-- 
2.47.1


