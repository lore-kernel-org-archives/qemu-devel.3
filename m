Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC93ACD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgg-0001Y7-JG; Fri, 29 May 2026 07:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgf-0001WG-1x
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgd-0008C8-2V
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so10351917f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055253; x=1780660053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qB7fQp4x+McFQYtKQptrI3Tcb3Zfy5XaCtc15S7Ao0g=;
 b=ulIICacvKhG/fcQunQ5clnK4ZuPk5e2Qs+/S8qa8L95h7LILZxg+/7BLqU/EHKh98B
 goejqjyyOWHsrlcZaXh8EAnlHnsju4L5Qtf+5TQ0aWM5piEsADLpJju4hPsffh8SBp9u
 iO8LIl/MxeNePG2L4fHF1pUKhDUHmU3K8Iquf++ecid31GmMHQ5wyxY8Kf7rBjmpSXV2
 V5ktoRv18zdHYOGXGvRyszvLl/ZALFL5GJuRdTT4CmFcZEk2Sh1dAYDZvnfMBq/CRj93
 hbA/2RMoGIDIN47v8DAX2dl9CCZO4i4ankGH0Y/pLFGvW0ccU3hk8L8DPYwSBINIWeve
 GigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055253; x=1780660053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qB7fQp4x+McFQYtKQptrI3Tcb3Zfy5XaCtc15S7Ao0g=;
 b=H6z5VCClmdimApX1joxxjzM94bVcpQ3Vq472K2XCGjQuD59TRvbLvMGQ3YhRNfVcUX
 AIJFnliRPu0wDmxnEWKC4yLgcSmurQYuC9UpMn8aipNkUW0S1K5UBedraeLIDTv/o0o/
 fZlvmAaiujDwoJhPMNs2k6ZihG6q0YU/UGL/wC5ww0krtJNZYkVAkymU27tVu6NoGide
 oPtYWS4QvupiUy24Gkx7MxWu6QT2gJfe31tf/wJ1SpEV/Hl/TX172gZKuVw1d2Kwbw8M
 8qr5d+yhKlCWKVSSW67ieRRDepgM236OIVR+V1egG8LKG6Jw9Qj9sAciiV2I30Jd0kLD
 3tcw==
X-Gm-Message-State: AOJu0Yyb5fST2s+SfkJZ4LfVEms566lv2MuD+pa+7r4M2A4s27leRIGv
 1U1eojW4iX/6n1YIlVaqVZo23jEPU3Fwa/eldYTlpjNtgzBd4xSBnAv5FCB4QzomffcmKtS7yOB
 kJGr5
X-Gm-Gg: Acq92OH4VrxIgPFg6RHy1w0tNafJGAAmEc5aGTMpRjDWSF61N3OMXL/cU3yX3dQ2lL3
 Ko8I84z0X0iItEW6zXx04Wg603JYUbD90VDxIAnrtzRv3LtBF2bWyJE0s9+ixANgalA8uFczZVp
 uqBcwqg7i6PpzBLiHCyU7EBB0PIlg8jIB/KzA4vN2X1b7v6YqVcTWaOKpNgrR8AEUjieOexSMr7
 NvvPMCX7WI8bNrpooLZTPbmols2SVlKD3MxNXvzWC+dk6hj4QG0yF9uu0hNyYm64LbxnnGuTtoC
 rXAPtgUkQn1jIu01LbKEDEupYfhvApauiGXJElSvZDPuMy3Wv2tEQETv+xWsuG913FTjryBNG4C
 YCdBa+zPtrICISkgbGBRNqoVli2WaeVDIIL7HOGpMy+9w6xfu+6Wh613lDEM/+d1ZF61eiYpOxk
 OFBe4gbiht/P+nfCHSL23iyIS/aA0XBi317ly2PJdi9FLpkOXymJZ6hbc3O6O64xsiGdMkmVZ0T
 U2aVXPX3GickQcWsZOAA6OSgvZ+Mky6D59u44PVRw==
X-Received: by 2002:a05:6000:4615:b0:455:70bc:216d with SMTP id
 ffacd0b85a97d-45ef13f7a47mr4846772f8f.12.1780055253406; 
 Fri, 29 May 2026 04:47:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] hw/misc/zynq_slcr: Add logic for DCI configuration
Date: Fri, 29 May 2026 12:47:09 +0100
Message-ID: <20260529114723.42040-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

The registers for the digitally controlled impedance (DCI) clock are
part of the system level control registers (SLCR). The DONE bit in
the status register indicates a successfull DCI calibration. An
description of the calibration process can be found here:
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/DDR-IOB-Impedance-Calibration

The DCI control register and status register have been added. As soon
as the ENABLE and RESET bit are set, the RESET bit has also been toggled
to 0 before and the UPDATE_CONTROL is not set, the DONE bit in the status
register is set. If these bits change the DONE bit is reset. Note that the
option bits are not taken into consideration.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20260518073401.11279-8-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/zynq_slcr.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index faae98fa02..0ae5d607be 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -180,6 +180,12 @@ REG32(GPIOB_CFG_HSTL, 0xb14)
 REG32(GPIOB_DRVR_BIAS_CTRL, 0xb18)
 
 REG32(DDRIOB, 0xb40)
+REG32(DDRIOB_DCI_CTRL, 0xb70)
+    FIELD(DDRIOB_DCI_CTRL, RESET, 0, 1)
+    FIELD(DDRIOB_DCI_CTRL, ENABLE, 1, 1)
+    FIELD(DDRIOB_DCI_CTRL, UPDATE_CONTROL, 20, 1)
+REG32(DDRIOB_DCI_STATUS, 0xb74)
+    FIELD(DDRIOB_DCI_STATUS, DONE, 13, 1)
 #define DDRIOB_LENGTH 14
 
 #define ZYNQ_SLCR_MMIO_SIZE     0x1000
@@ -193,6 +199,8 @@ struct ZynqSLCRState {
 
     MemoryRegion iomem;
 
+    bool ddriob_dci_ctrl_reset_toggled;
+
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
 
     Clock *ps_clk;
@@ -331,6 +339,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
 
     DB_PRINT("RESET\n");
 
+    s->ddriob_dci_ctrl_reset_toggled = false;
+
     s->regs[R_LOCKSTA] = 1;
     /* 0x100 - 0x11C */
     s->regs[R_ARM_PLL_CTRL]   = 0x0001A008;
@@ -418,6 +428,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
     s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
                           = 0x00000e00;
     s->regs[R_DDRIOB + 12] = 0x00000021;
+
+    s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;
 }
 
 static void zynq_slcr_reset_hold(Object *obj, ResetType type)
@@ -554,6 +566,25 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
                 (int)offset, (unsigned)val & 0xFFFF);
         }
         return;
+
+    case R_DDRIOB_DCI_CTRL:
+        if (!FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) &&
+            FIELD_EX32(s->regs[R_DDRIOB_DCI_CTRL], DDRIOB_DCI_CTRL, RESET)) {
+
+            s->ddriob_dci_ctrl_reset_toggled = true;
+            DB_PRINT("DDRIOB DCI CTRL RESET was toggled\n");
+        }
+
+        if (FIELD_EX32(val, DDRIOB_DCI_CTRL, ENABLE) &&
+            FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) &&
+            !FIELD_EX32(val, DDRIOB_DCI_CTRL, UPDATE_CONTROL) &&
+            s->ddriob_dci_ctrl_reset_toggled) {
+
+            s->regs[R_DDRIOB_DCI_STATUS] |= R_DDRIOB_DCI_STATUS_DONE_MASK;
+        } else {
+            s->regs[R_DDRIOB_DCI_STATUS] &= ~R_DDRIOB_DCI_STATUS_DONE_MASK;
+        }
+        break;
     }
 
     if (s->regs[R_LOCKSTA]) {
-- 
2.43.0


