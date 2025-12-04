Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7804D1D89F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kq-0001xa-68; Thu, 04 Dec 2025 04:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k7-0001BY-U3
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:21 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k4-0003Ql-TP
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:19 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64198771a9bso1183601a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840914; x=1765445714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1i0haX05wPH7+qqw20aGMRGdV4gaXbDlVbiQ7m2y5A=;
 b=I0gWVUVWnUuZCNeH6WrgDfI7DxaQZMimO4jz0Igm2ZstLOEkUw+aJAxYjE6dbY6VH5
 TVFZXvDTpyQZaCo99XVQeloR/+y/qOzZnQF9OoPrJS2B1dl9J/GzPGIW/OCKvnzQrjkf
 rKr05EdDB15GrGGDQm+QuAT2uXUvFfTEW7wifZrcph2penPM3+hG59rXTI/ecaFZCt8n
 K9/CmT7IKkyDxpi00YACQ/MZNhhuyjD0dpZtLxwPGflpuKnmBq4vxADwk/Zbgw7WpsNZ
 RlZjzd465jpPsR96FHWO6WtzR02I9zAuZea1hoAWrowc8rHBF8psYThymsxq77h/2JM0
 6wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840914; x=1765445714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A1i0haX05wPH7+qqw20aGMRGdV4gaXbDlVbiQ7m2y5A=;
 b=Sy1qkaFgSfD/3UpveQf0Gu3Cdg9rmabFUA04HuhuvCd5T1IoMQ0Or65dr6Ng8TCqrQ
 kzlyj0ARpZUcnwFkePu7TK8E46CDxH76xMECVlGb3OL8NBaz8YXQfG+wA+LZhfk5tZNv
 Em2XvZ3tv4vjbFWgCa/V3sjJKMkPikY1SHYPf/9a2KAPCMCeTfnmYFRSRSSfc9LnpkgA
 8MU+yl+4mVmL0flQ2sAVPMbgZHFrJdvR++sUw/9XMkDFp9j4ebU3Ziw3vF/wS0H/5dn2
 x1h4z/hdRMtJGJ4Gjzxy3IH9rJc51DqSHRV8Jdr92l8DGfiNqZ/gQwhZi7VFAbd/EkEa
 B+Mg==
X-Gm-Message-State: AOJu0YwVb8KryoClldkgLS/IXz6ppXtH+NnuENAhgaiMas1QKTCY4C9S
 /1+wfyA5iJQMKQj82Ix7y9TrcbKf1FD0ik2EqvKrPL6CZC1B4x5wdIKBeRqhFGhK
X-Gm-Gg: ASbGncviwsYZdiYcOzUDvRcaRXIFD2A5macZePExU/LSncA0fWgJpXAuTmGDce5nLJh
 SSXGZ0S1f4FFAhi2RkisyE8GBoji7H/qp4DphUJAFNlEkFMUM53HoxTH9EO8V9LiXTwTkv4r0ex
 YMQZs5M/qKQHFTMgFEFN0TqxlFu0tvN4N83eVRuAr0YBw0R/hZY/I+aeHheYKmknION0kysvLqd
 MQ9gwyoiuV11sEjOafZAjNCxboqdXX/ZU+gmBatNeSNGoZ4OqfKXvZ2fMdBZ/nbk4UxIDJgDtrk
 VxMpDpTTt8xO2aBgHWjvK4gp3Zeqn0VMQ2QUqmsep9CHBm0gKdFZeYTO6YlyclGy9p2M92+mMtC
 rbhBSGE0KiYtL/EyYxz5VKPU/E0XBS2gtx1JLeLhx69mBIaQl551AN4WOwdTk6XDDeQspyjA/LZ
 lSwTSFClUNaoBlqbuN+dWC7wpq2KJ4guA=
X-Google-Smtp-Source: AGHT+IG8rL9464dTajU1ktk2gMR4Mu/f5eNl7PPvNO2woc6gSwfllc8gw5M+wFEdHrnZIddyGLcKVg==
X-Received: by 2002:a05:6402:4304:b0:645:d73e:6f60 with SMTP id
 4fb4d7f45d1cf-6479c41df28mr5000957a12.12.1764840913759; 
 Thu, 04 Dec 2025 01:35:13 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:13 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v5 09/15] hw/misc/zynq_slcr: Add logic for DCI configuration
Date: Thu,  4 Dec 2025 10:34:56 +0100
Message-ID: <20251204093502.50582-10-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
---
 hw/misc/zynq_slcr.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 010387beec..d8702da4ce 100644
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
2.47.3


