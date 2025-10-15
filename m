Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B0ECCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xeV-00025Q-5G; Wed, 15 Oct 2025 05:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xeK-0001wD-Al
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:24 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xdq-0007Fz-CC
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b463f986f80so402496166b.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519872; x=1761124672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1i0haX05wPH7+qqw20aGMRGdV4gaXbDlVbiQ7m2y5A=;
 b=bYt5vrlz7gFR/4YKUaV3toDZjZ82cvTpzr/5wngk6Tn+fy5QfDDsV68HeQuAyQHui4
 hH1Yp+2ToGLBUz2I1kKPByCDNEzf6p16q8NItJiIG+iGMa19D9UU8hjNLm2UsRFUd3+r
 Ajos5OMsOEnXfPw0ow5P1MhRW93MDHmvLvGv7Th35KmPG09OGCCGFthluCYBrVOwqHf7
 pF3XvSaHcv94m2ThWMY+O9qj5BIkmUDDRbsNKTiyS7pnDdGI+7pXM7MwBQvPnmrVPShy
 fCU93kazZJ6NdVbkDBpEpFLuGP/yP02ELbiXGSlN0+nxz9bWo4V6Bg6X50zlHfwxg9mt
 jPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519872; x=1761124672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1i0haX05wPH7+qqw20aGMRGdV4gaXbDlVbiQ7m2y5A=;
 b=iX414Ez9Zfd7i3ZGmTTl7igrL6oXXkimKHGBmQVqInx2GwZuIj+BX07sKrk8UbZrsa
 E8Ry1LPNvsIC+i6PWC34srOrp2ydSIX6J6jONgDigbjTzP0sAJAXw5hvfcXeogCjICnD
 xJnwdpXaZAllWh1CgnOInqkU50T97ZaQepFyU+5A1TUtcioXpDeOGhYKycws2Rvm4Gwa
 ErBP8aIehnDEwhtN0yP9tEO7vytxbUAPzPHfk3cENbVmdsBV/uDzWBkeGcarFo2hzLod
 I0/X0LG8+K2jwod3bueKp4o0iC1EUnjBsFkvw5VcH0CYPrvjhC6hR4BnXCAPI35GkG+0
 hqSw==
X-Gm-Message-State: AOJu0YzLzWoM+iBdlhRYrb57OPpIFareZnlAB6g6dH6vbTNMRdXbHsiO
 vMZbJazbfbxaX39/KfZ2lUsY3vqdg/mwAbhMcxWIBCF1pTJUfYTQZ7jKGjxY1vwnPmw=
X-Gm-Gg: ASbGncsLA88jOjP2ze/C+AUCydsDrrw0VYOvhPva8CVphDzDGR4tcEbjOFC6GhgbIVW
 HE1L646s3wYpkWRXOYXuE4EGMCxj22CyfoDmRj6V3yeA33FU4AUtkHOQVJLm2hnNODq8MFE8Y1o
 daRLuK92U6k3GtxGabkvXMU/JRH+g/4KOeTj/RKNO7X+SywLCi/QXWnDUWYoPrKIlQ67bd9rgmu
 Uv4Cm9EjfLjHTky6rcd+XJbfy/JvXTvx2BdAFDr7YgiBOGwfx3G1j/iJNFWloXzJXoGelF+GUtU
 qJN+S4Zj0TEJjMZYXG+Ot4v8YFUPv8p/2A8jJVWG+vAa4D9Pst4Pl9b2E3Hh6p6RWz/Fos9nfHr
 mSexx/0J0QDfNUJjQbBFKUnfdd90yy2nvJsZdyoGwaeLBspx9K8t5s5gvioFuCl30qEbpvZuq
X-Google-Smtp-Source: AGHT+IHXQKBdRb7I7nFha4o16yZk3FResaMPTKYJidp8LZvY35n6AKiEnnb1+zy4dDB3WqIZDgVinA==
X-Received: by 2002:a17:906:c146:b0:b49:a5e4:754a with SMTP id
 a640c23a62f3a-b50abfd027emr3087732566b.43.1760519871521; 
 Wed, 15 Oct 2025 02:17:51 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:51 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v3 10/14] hw/misc/zynq_slcr: Add logic for DCI configuration
Date: Wed, 15 Oct 2025 11:17:25 +0200
Message-ID: <20251015091729.33761-11-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62c.google.com
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


