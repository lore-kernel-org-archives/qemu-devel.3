Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C36ECD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 12:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKxUY-00005m-Pd; Thu, 07 May 2026 08:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKxUL-0008V4-Ro
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:05:58 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKxUK-0002CW-EC
 for qemu-devel@nongnu.org; Thu, 07 May 2026 08:05:57 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-83659d38e38so290755b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 05:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778155555; x=1778760355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6f/BxqM4oPn2RXFraAVD3TGlPXbRYNoGHUCSl7Ed+w=;
 b=UecgS1XmZCx5uy0YsgSwuYzels+aumMybTpEbqSQ2Cg0VGLDFEWN44ReY981USPbGF
 HKKWFS8pZd0Oins8Ka8okrobNjl7ZbxIZjcUW9SNDYU2QAsMvky3GYvNoECD71ac7UhA
 U3sxnCSTTm883c5zEnYCMKKUvjg70FHeLw1lmmw+ab+zdP3DBHLOpsh8P9MBicAG9SSI
 hFP7cgiXN6WDtNlySgGe2Zcym7z0ZcUzT9HWIxb7oymuZcRB3M4/ZnB/mqWTG5glwrxB
 tLBMP1KU7QMYVLGEKuCNobVoTziy7lDXNhO1eHDMn7q3NYTAE2IjXj1djdXPUfmQz7Kf
 bDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155555; x=1778760355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z6f/BxqM4oPn2RXFraAVD3TGlPXbRYNoGHUCSl7Ed+w=;
 b=eYbXQpZmudkaln9UZO3ciV3JQPoDiSMsbk3K4mJodnGgL15wYoTV4k5F9wvn4rjx+Y
 4jzkBguFOPkDox7nkPNKhBEkuvBq1F4iObTxIOAzvnU/MVr8qsN0SNVD2RPEH4XW3Noh
 ZeQKOJS1cvOu3CwFgZF88lJE7AEXwlRoly7B5gHc2jop+so9oRAhwJXe1h8vrD9v3iZK
 ZBOfEZ+3zXQ454fj5JYwIMnAcrUkQoSKd5buq3Sv5yB9iQk2XArgMABR8XCX24GcDDV3
 Zv0y3/LSC+/KztKNC4khJPyLnnQVb2LgNoJXpbDfEPQxfLhmIRWPwYAAIaU0mBSXhREz
 F1JQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gy+x8jgtLJO97BFik9WYECNMQom3DYYyaNwTE0D/vOxPV1GiE6t10oCobrUGbEDqSVlPnjNpIYZnj@nongnu.org
X-Gm-Message-State: AOJu0YzIxqq5md6CCb0KjNyvGS1oaiiKVIfJdInmpl54vN+tl8xOtQNC
 umJ2UiG37MhIQR79xNPKi3jO1AK6BiBmKwpdbhuyPjyWbUejq9CtS7GA
X-Gm-Gg: AeBDietPPtkzLbqFoNp2KvE1/00UjxAk+lsprWLuiro7ieSsSd7T1v3DwuQoU99BJSA
 zvg9XaUZPv36tqL1ovtKo4SvRxWqrOAOBffpTzfX4rS2R/K+j7thOkLOy5xunJ751eqpNgaeVRq
 GljfiORTVr1G7SXX687tca64ZGBPSwgUbvHoYzoR68r10di6k9cJkd6d1gUPC2+4KLAFpFxM666
 tpdTRVdLsUGi5ty4YSo/rrf0DFPOkl1UNE0EzUTjQYYIQOJMsy1WAI4IZ4bFnAlFxtJj3KUZC7U
 6e58PEQnUdAPn3mLxuYztgGSBWta0HQjpmTzOuC79ByZogekyEKNA/JEkZ76iH1yYiNYu9y4gBU
 8MFnIwQKJBz1fEBu842pAWS49HKsm8MddIucI9Ne6SqG9wALSVN1VBoY7g2ZOZnckudqmi002qv
 bMcLnFCRynyuy8HPgFSqI+1/ahZISybAGgRsefTZGuxwlZdJvTVDzQrFqAqKy2HulmYUTAjoXiO
 V+VIKOoyWe82apP1rw=
X-Received: by 2002:a05:6a00:408f:b0:829:8c08:d1f4 with SMTP id
 d2e1a72fcca58-83a5dd577f2mr7942689b3a.39.1778155554521; 
 Thu, 07 May 2026 05:05:54 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945c1bsm9028002b3a.15.2026.05.07.05.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 05:05:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] [RFC] hw/i2c/designware_i2c: add SMBUS_INTR_MASK
Date: Thu,  7 May 2026 22:05:22 +1000
Message-ID: <20260507120524.111056-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507120524.111056-1-npiggin@gmail.com>
References: <20260507120524.111056-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QEMU complains about access to unimplemented register when Linux
inits the controller. It is the SMBUS interrupt mask which the
driver unmasks. Since the model implements no SMBUS interrupts,
the mask can be implemented trivially.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/i2c/designware_i2c.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i2c/designware_i2c.c b/hw/i2c/designware_i2c.c
index b7be4d68c4..cc37bde2ae 100644
--- a/hw/i2c/designware_i2c.c
+++ b/hw/i2c/designware_i2c.c
@@ -142,6 +142,7 @@ REG32(DW_IC_ENABLE_STATUS,      0x9c) /* I2C enable status */
     FIELD(DW_IC_ENABLE_STATUS, IC_EN,                   0, 1)
 REG32(DW_IC_FS_SPKLEN,          0xa0) /* I2C SS, FS or FM+ spike suppression limit */
 REG32(DW_IC_CLR_RESTART_DET,    0xa8)
+REG32(DW_IC_SMBUS_INTR_MASK,    0xcc) /* SMBus Interrupt Mask */
 REG32(DW_IC_COMP_PARAM_1,       0xf4) /* Component parameter */
     FIELD(DW_IC_COMP_PARAM_1, TX_FIFO_SIZE,       16, 8)
     FIELD(DW_IC_COMP_PARAM_1, RX_FIFO_SIZE,        8, 8)
@@ -610,6 +611,10 @@ static const RegisterAccessInfo designware_i2c_regs_info[] = {
     },{ .name  = "DW_IC_CLR_RESTART_DET", .addr = A_DW_IC_CLR_RESTART_DET,
         .ro    = 0xffffffff,
         .post_read = dw_ic_clr_intr_reg_post_read,
+    },{ .name  = "DW_IC_SMBUS_INTR_MASK", .addr = A_DW_IC_SMBUS_INTR_MASK,
+        /* No SMBus interrupts are implemented, Linux updates the mask */
+        .reset =      0x7ff,
+        .unimp = 0xfffff800,
     },{ .name  = "DW_IC_COMP_PARAM_1", .addr = A_DW_IC_COMP_PARAM_1,
         .reset = /* HAS_DMA and HC_COUNT_VAL are disabled */
             ((2 << R_DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32_SHIFT) |
-- 
2.53.0


