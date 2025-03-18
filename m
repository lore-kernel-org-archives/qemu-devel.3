Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2135BC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWib-0000Oy-Tx; Tue, 18 Mar 2025 09:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiJ-00084M-Nh; Tue, 18 Mar 2025 09:10:42 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiH-0003g0-Pg; Tue, 18 Mar 2025 09:10:35 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so1046306866b.1; 
 Tue, 18 Mar 2025 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303430; x=1742908230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G7hSFteNb8Ei9umQoeYx+vzWa3qyKqrpQiR8QrHJCs=;
 b=duHA4i6Jn/MaNjF/a6zZNKSTcXYcQ8vIGTPIxkrNkXvt54FixtUyKxF9LgVmNSRet/
 TVZ4ln6PmdJG2IKLP7WcSIhZeKpqIl3Y7d/xiHMG3XiqNmvk3u52uVBZz7UcaPQUSHEs
 aZ21BviM+98+Y3JpXrqV9wihsIvbw75TYrOUh+vRQAZkpW9GUmJCmAlE4hNBFZ9hTZSn
 +xV/C551WRJKg2NhSBuSvNM9VQqg6EMDm0yzq0tDFFEqR25EiRhws7Q2fLwJFdbIl+HB
 WO9te9O2tr9mraLg8y9wE0RROQyg1gYQGoXYGbwEs61F3wL+P0mf8nwkI49H0DARrnF6
 tjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303430; x=1742908230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1G7hSFteNb8Ei9umQoeYx+vzWa3qyKqrpQiR8QrHJCs=;
 b=FlyyNAkSHufQfwcTRd+jYMeYT2yz7J0+vUsd+vLuOgGWASm46n+H9+8Y8v09P1aR+a
 i2vrAhwBYCQq6G2RV0I7levX/irgTosYveY9SoTgJXHDn1jF/c3EzPrUz5EcLCmkkyqt
 jcJBs44/woP+1XvXmqXgaI2RfR22lYAEJbJAyBZLLyGuivHBmoLVIUlnHyKnffjIFdjn
 ftKxB8OJeGsVRLnco1VrGFENDvlneubgmlSyekNrisWFB/yR08RIh+Ey1XQO6+7vP7cp
 iLn2tp9Xyhbt9DIsXV7BrlpB9laZHV+nEH9SSBNQDuvrGCPiklSbldrQFhHPUsvJgMeX
 udyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFT80MLp6MegScCrTA9QcfVdR8lZs8EOXzX94sJOT6txODUcchrirDtzvzPatCNsAVPxFwy5TT9Q==@nongnu.org
X-Gm-Message-State: AOJu0YzcUTgA3L4+BPYb9zbmAFnDuemwNRambKIw4Yhp9Kf6I14g5Cy6
 jNlQhFKe55O3eVlBdQc9byz98T/8NrtiMUVlhnawdEB6mu10W0oC+jv/syog
X-Gm-Gg: ASbGncvb2UDAts3GiJIOj8B5qHenSjXT/bDaZP4HyhGIBgG/X8CSYALGFa25Gw2O2OQ
 S/BZHSaMfPD5bRTw21bHPWbTmR7HOX8aPLRpBBqXw08OHd1X6O9e3EM9kv+pWV9rJhXW0rBiE8W
 z/7Zx7ZKXgSvbw6sCevuYKQ8rYYnou/W9X88KOTFSKAPxkmaYfVs2feywkESdj1Smh6HR1BECmf
 Es8N0hX5e3G74xmCzl6U+FcMicXJzrgxZAYgRweuwLUYeFjKRiLRsAiFWf74vJaNyxGyT02SK4b
 /WjFffAHPLEr0YYezaSLPOBkZtO6dvFTB1bw20gUSXStQR1AylMoZ+WffyzvYfm/Aoo=
X-Google-Smtp-Source: AGHT+IHfFobVjvuuug6M3ImzyoJ7UeMyS3NRx2uUbsMvRum4kfiIaMbCen3uCkRrcGqJCw88XHPG7w==
X-Received: by 2002:a17:906:6a0a:b0:ac2:9c7d:e144 with SMTP id
 a640c23a62f3a-ac3303f770amr1898767966b.40.1742303419230; 
 Tue, 18 Mar 2025 06:10:19 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:10:18 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 06/21] hw/dma/zynq-devcfg: Simulate dummy PL reset
Date: Tue, 18 Mar 2025 14:07:57 +0100
Message-ID: <20250318130817.119636-7-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x630.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

Setting PCFG_PROG_B should reset the PL. After a reset PCFG_INIT
should indicate that the reset is finished successfully.

In order to add a MMIO-Device as part of the PL in the Zynq, the
reset logic must succeed. The PCFG_INIT flag is now set when the
PL reset is triggered by PCFG_PROG_B. Indicating the reset was
successful.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 611a57b4d4..c44b802b22 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -49,6 +49,7 @@
 
 REG32(CTRL, 0x00)
     FIELD(CTRL,     FORCE_RST,          31,  1) /* Not supported, wr ignored */
+    FIELD(CTRL,     PCFG_PROG_B,        30,  1)
     FIELD(CTRL,     PCAP_PR,            27,  1) /* Forced to 0 on bad unlock */
     FIELD(CTRL,     PCAP_MODE,          26,  1)
     FIELD(CTRL,     MULTIBOOT_EN,       24,  1)
@@ -116,6 +117,7 @@ REG32(STATUS, 0x14)
     FIELD(STATUS,   PSS_GTS_USR_B,      11,  1)
     FIELD(STATUS,   PSS_FST_CFG_B,      10,  1)
     FIELD(STATUS,   PSS_CFG_RESET_B,     5,  1)
+    FIELD(STATUS,   PCFG_INIT,           4,  1)
 
 REG32(DMA_SRC_ADDR, 0x18)
 REG32(DMA_DST_ADDR, 0x1C)
@@ -209,6 +211,14 @@ static uint64_t r_ctrl_pre_write(RegisterInfo *reg, uint64_t val)
             val |= lock_ctrl_map[i] & s->regs[R_CTRL];
         }
     }
+
+    uint32_t pcfg_prog_b = FIELD_EX32(val, CTRL, PCFG_PROG_B);
+    if (pcfg_prog_b) {
+        s->regs[R_STATUS] |= R_STATUS_PCFG_INIT_MASK;
+    } else {
+        s->regs[R_STATUS] &= ~R_STATUS_PCFG_INIT_MASK;
+    }
+
     return val;
 }
 
-- 
2.49.0


