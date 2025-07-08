Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED461C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFJl-0000ch-S7; Tue, 08 Jul 2025 16:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZEYu-0007q4-2u
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:05:14 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZEYq-00047q-Ir
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:05:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae0bde4d5c9so989000666b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752005102; x=1752609902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+TqTY3yHXS8e/i0KnNKmn40UXfWJZswqZbcAaZ/doVk=;
 b=yFbP4whiflbEQy27I9v04KBg0SZBb0K7OePlfyDdDfujaCh3LW0pVtTJPxbdOwfIql
 DKjlyYoZ+gJSGmFaZVY8x/TyBN+YUi2L6TykWuj9/l7C0IErXITptqxyg3ID5tc/jnfF
 vL4JARsjmxqkOTezNvmWn26qa3MdKndBNUvWUJpeZughVTI+AfICqhNRzPNPiNsIfSPl
 SdmbAZYFLoCHmGvnD9f71VHsVgJFjoDcvsVNKONAQmr1Hu4AE2YYX09NQDvDTTR0xU7C
 gadIjF3R4OaJIFskg9EoxjFvqs3SspUjl8H1SPG28RcxNDO2yiJcUMumCIUIhY8duZgb
 YnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005102; x=1752609902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+TqTY3yHXS8e/i0KnNKmn40UXfWJZswqZbcAaZ/doVk=;
 b=vxui/1BPsd6M/4YJsGjM378WBSOzJs2m7Cp63u3+rJrxWjpOBooaPDcT2g/noUq2dT
 /C8F/7zmdSk6q6540fJw9RH+gD+S+lKCpIRxpx4WEbKTXAmfYdTkS69gPn3p5TnEQnCT
 KY8yDv7ppxyWw9IHsb7Dg2V8Y7oiAF4fFPhfxvvk0jcjnGsZVqbAqbk/t7WSYcpx8Y1w
 5mExJ9eNIMfsaZ9ZXyTl1MMCZKRdzXGFrgXIlzWG9XB4fCWeZHagtCkDvh9/Bz1a31GE
 WxbGzQ9TbtSRx0mUlKyzJsMBPa8A8XY7YFRI9L0zVjyX4e8aTHN6b7mOhX/zC/gqbaXn
 IckA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXNsBODRN8I5r1XAyuqxAQ7l6OJzo9LFeTuARif7ER0blmaqXl+aLR8T7Ek8WiYcrNrABK82tBxDir@nongnu.org
X-Gm-Message-State: AOJu0YxtCr4XOiRAW4pGGu8LDSWo3+tBlHpA+lP/FiqyZ8Z7JVNNfXJl
 3d9x7hrDeTKgH0MPh1kUU6naxZ/fHCR99NzotpimjUVOxOBNUEk5DTw9JAkF/nypwMIqnkNRsn1
 8Wo4v
X-Gm-Gg: ASbGncuPJoS04fF0G+e+huUu8T3VyU14o0uaxVCzw5Y4AcfM1GuIgzRG2Q3XoVenJp3
 DQP/G7b6PgPCvJ8uspuVtlJ7IWTzlhidNkS0s8k1EXrLm0qUS0s/RDEMLqEI7aK/6l6+Q94zmW7
 0hv/S5IPTgbSDdLrVEIO1im/ehn1DO9COksNyt3zIYd1/noKjVjcdnwDc2ugustXMWu6J8sjRKc
 WxAJL16TFlmxam+Lqplt58ZWbtYAdRU8ubFH12aJwhQ13AUYSlh9NcLcE171jFd9ii7L50Ck+KO
 46nHnAomEU9x1ayBLYx401jcFgevlu2+aVfVaqTjDaDrdzftPs1SdNTeWB6RuEAnm1QwugAOyeJ
 vt2Y=
X-Google-Smtp-Source: AGHT+IEeE4OHrunj85O3Z4W0/4U0TYcYJkE0DZDU+67WQU2UmN9o1V0yDvDLIGgq3N6+42cCxlr+rA==
X-Received: by 2002:a05:6000:2588:b0:3a5:1cc5:4a17 with SMTP id
 ffacd0b85a97d-3b5ddedc49cmr2575326f8f.42.1751983851091; 
 Tue, 08 Jul 2025 07:10:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030c2e8sm12872264f8f.3.2025.07.08.07.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 07:10:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Correct encoding of Debug Communications Channel
 registers
Date: Tue,  8 Jul 2025 15:10:48 +0100
Message-ID: <20250708141049.778361-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

We don't implement the Debug Communications Channel (DCC), but
we do attempt to provide dummy versions of its system registers
so that software that tries to access them doesn't fall over.

However, we got the tx/rx register definitions wrong. These
should be:

AArch32:
  DBGDTRTX   p14 0 c0 c5 0  (on writes)
  DBGDTRRX   p14 0 c0 c5 0  (on reads)

AArch64:
  DBGDTRTX_EL0  2 3 0 5 0 (on writes)
  DBGDTRRX_EL0  2 3 0 5 0 (on reads)
  DBGDTR_EL0    2 3 0 4 0 (reads and writes)

where DBGDTRTX and DBGDTRRX are effectively different names for the
same 32-bit register, which has tx behaviour on writes and rx
behaviour on reads.  The AArch64-only DBGDTR_EL0 is a 64-bit wide
register whose top and bottom halves map to the DBGDTRRX and DBGDTRTX
registers.

Currently we have just one cpreg struct, which:
 * calls itself DBGDTR_EL0
 * uses the DBGDTRTX_EL0/DBGDTRRX_EL0 encoding
 * is marked as ARM_CP_STATE_BOTH but has the wrong opc1
   value for AArch32
 * is implemented as RAZ/WI

Correct the encoding so:
 * we name the DBGDTRTX/DBGDTRRX register correctly
 * we split it into AA64 and AA32 versions so we can get the
   AA32 encoding right
 * we implement DBGDTR_EL0 at its correct encoding

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2986
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 69fb1d0d9ff..aee06d4d426 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -988,11 +988,20 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
-    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_BOTH, .cp = 14,
+    /* Architecturally DBGDTRTX is named DBGDTRRX when used for reads */
+    { .name = "DBGDTRTX_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
       .access = PL0_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32, .cp = 14,
+      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_tdcc,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    /* This is AArch64-only and is a combination of DBGDTRTX and DBGDTRRX */
+    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_tdcc,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * OSECCR_EL1 provides a mechanism for an operating system
      * to access the contents of EDECCR. EDECCR is not implemented though,
-- 
2.43.0


