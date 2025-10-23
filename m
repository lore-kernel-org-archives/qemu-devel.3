Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44EFCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwjU-0004h0-79; Thu, 23 Oct 2025 10:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjR-0004fl-Jv
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:01 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBwjP-0005XS-K2
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:56:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4270491e9easo646541f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761231358; x=1761836158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Iwwkz/XEUnaoRbOD3xTaSXtf1OLteT17dQkKxAUMJSc=;
 b=Xe0vCXSIj8QrTLXQwYJ8fH3L6O+6m8F+ExYDoh9v3CMVPAQ/ZLIODdcQYVTuTXKie4
 MKv9toGifRHOiXDOILRmivQ8BJ+sfLTnuYnA+VnHqR/Lc3x18PzDcpqhPyA5sG6gT1XS
 v6T0j2n6Ub4dTJhac2pY7Vh/hnMWkU4JstkNpTQkP3HjphXSD1VkmG/EJMsWJnIGTzsK
 RFfSjCQjH/gewrrIfGRTbWmskNR3vUPMrJVsEShvLtFyeXMZoPye/wTJmjW5/sny3r6H
 lYtWBC+K9gknZ5zPCqTwnBFSQj5cPJdXXJyDCCgCjTV8Tt55NM/UMQ1vNHOuVE3qvJyG
 7YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761231358; x=1761836158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iwwkz/XEUnaoRbOD3xTaSXtf1OLteT17dQkKxAUMJSc=;
 b=ClXwlZuaCC286KOVoW7tiqQLb8wY0weTFpKKFy4oig/AN+ZLUFP4hDZpy86jzI4gL9
 t4MDjf72tpPW/XqRjXWJmtdyHsEtASDAcNedVaRbcNiLaP6zkM5+OFoBLJ8+U2aCtrlw
 PHvTgcT7exhAqvIlvxRldVfI7JC/OW7RY72u8s8NbnTRIq8LsbTzreXZEG3+CDIBd6iF
 v8r4sFGCeeO98zXKLlIVvCsVxcdyDo7JR0gan8FflnOG3lR7YWfNnIB2w2siirPLBpde
 w0BpQPY85hPIZltsjAMAmBV9mAofY0cT9up24bAK3iPkX4b/Hnp6losEyIJDsx55WP0f
 lzYg==
X-Gm-Message-State: AOJu0YysZW4C/Vapww3Fo3JLa6tw34ooRlm66gQIncRI9z/PkTC5XYuc
 Qvb3UCUK+WSgIQeCSznEC3TYW+cHOIqcnFOL1fcH+mb+wJk3dyYS8z3+QIdvjpnh3E+ViunUqJY
 3AFTA
X-Gm-Gg: ASbGncv8Mv3wZP0ovxUMxhFCE7SDYZprRL2DaBAwpbX1Oi0hMBbsYmS2j4E1/cjRghV
 L6Kox2/IdcaPSJNKr91DsGqxC2lm2IYzLbWx4VxwG3ueUFZ2BSCCGcg8LkuBJ8WoCADFDeW4nzd
 7iXG0RzseEfAUZK5pI/xb2hnkG/p0rPQAvhnb7JV4MnwowJw9AOlfE03LOD4TYeT8qmewzIcz0C
 hzY7qHMq+nuhneeKB8POyY2GtP/CXb2+d7eM8ehzxokFK89yPcO87fgvu4kLfkCDBpXrnagzs9T
 zIJu1WGIvf4f0vP66YjHmQqsFbVwE8LUV2dsjzwsLqtUvrspv1e3zwtX1apX/9cMOC77Md4aVMN
 KKO4WtaB2MbIKc++IEbwWfAIuOy9G0iaYT2gzaUFoupKjDKfxTzrI1GI9TrWU+4eXv/pcPEaxEH
 Rp0d0uyY0ooiaJFPFY
X-Google-Smtp-Source: AGHT+IHM8JZQ/BjDOUfl4H8oGMM2Ok6i7KLfCodxwS18SN5FPIIeateVWFU7JM6Q+m6am4TXKzZ49w==
X-Received: by 2002:a5d:64c4:0:b0:40f:5eb7:f234 with SMTP id
 ffacd0b85a97d-42704d442f9mr19022748f8f.5.1761231357625; 
 Thu, 23 Oct 2025 07:55:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898acc63sm4398465f8f.27.2025.10.23.07.55.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:55:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
Date: Thu, 23 Oct 2025 15:55:39 +0100
Message-ID: <20251023145554.2062752-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023145554.2062752-1-peter.maydell@linaro.org>
References: <20251023145554.2062752-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

The GIC distributor registers GICD_TYPER2 is present when the
GICv4.1 is implemented, and RES0 otherwise. QEMU's TCG implementation
is only GICv4.0, so this register is RES0. However, since it's
reasonable for GICv4.1-aware software to read the register, expecting
the zero for GICv3 and GICv4.0, implement the case to avoid it being
logged as an invalid guest read.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/intc/gicv3_internal.h | 1 +
 hw/intc/arm_gicv3_dist.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index bc9f518fe86..fc586524f56 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -31,6 +31,7 @@
 #define GICD_CTLR            0x0000
 #define GICD_TYPER           0x0004
 #define GICD_IIDR            0x0008
+#define GICD_TYPER2          0x000C
 #define GICD_STATUSR         0x0010
 #define GICD_SETSPI_NSR      0x0040
 #define GICD_CLRSPI_NSR      0x0048
diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index d8207acb22c..a7d10ed9493 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -431,6 +431,15 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
             (0xf << 19) | itlinesnumber;
         return true;
     }
+    case GICD_TYPER2:
+        /*
+         * This register only exists for GICv4.1, which QEMU doesn't
+         * currently emulate. On GICv3 and GICv4 it's defined to be RES0.
+         * We implement as read-zero here to avoid tracing a bad-register-read
+         * if GICv4.1-aware software reads this ID register.
+         */
+        *data = 0;
+        return true;
     case GICD_IIDR:
         /* We claim to be an ARM r0p0 with a zero ProductID.
          * This is the same as an r0p0 GIC-500.
-- 
2.43.0


