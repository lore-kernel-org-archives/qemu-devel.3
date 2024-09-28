Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11712CF6496
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 09:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suTI6-0002Fm-HI; Sat, 28 Sep 2024 04:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTI4-00026I-S0
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1suTI3-0002Nc-AG
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 04:59:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37ccf0c0376so1623558f8f.3
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1727513937; x=1728118737;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOWzCZU6EONhTxEcdFH/GqPe9aBoTYc8FD382em+uNI=;
 b=RtlXr1xj0cNIJGlyP1P731C1zEm8BiTXkxY+W9JpOHw+IMzCfiVzT//oirRPqRCTKy
 qEktvMHu784cfhkX2rzvpZ+kN6mXSx1hnT7B6awmuS06OW2cvCyi7NhgojiwDQ0Y0loZ
 HhzC8ex1TJGYjcYzJjc3a3D67Jwsgs9Z10WwbCzmvnRYtpo7nSzY3GOBgYvBwQVNLQtJ
 iyk0PpRXymSf2/jRk5qiAn0rTTK9mVX1TVqPcyszDF952BcaLMHWCfQob/CJVYcvkA6A
 rdwLNMvGzkB/DeP3oQlPXPYatqMF3tqKoRKAD4BSlkZ6ROIzxs+3R+7A74+WtVg10dpc
 kF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727513937; x=1728118737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOWzCZU6EONhTxEcdFH/GqPe9aBoTYc8FD382em+uNI=;
 b=pAeVRSHwa/Q5C46kWLkj8CCH5fcYVig8Bl5Be5LCiVqu1EqFFymvCGODdS2LrJmR+E
 soC3CiQEI7VKs38w0ohQcCdnjM2X1hIQOKluzrP/nr2w1Nrp88KcZbYBxw0ykLiqA6jP
 tCYgWcoJ+nAuTR/stnhVRLGC9CKwd+Lt4sve3QFCX209XqinLUG/PD7uNulI+B64QaD2
 9sdaApScFvtyOZMP+VWm+Rk7Ok3z4Fod1EYyoZien/zr4s+uULkV8kLCPh7POk7OCjLc
 i5JpV9b9bVIwmnqdmcmpB0aunukbm6SxO/zPeHhgypZ2B7C18tHACeO72HIH9C17XD7I
 o7mQ==
X-Gm-Message-State: AOJu0Yx3Vz0tYKsPRYz5HDSVORKiT4c4m0vIqQqkL7OkOL320Ln/7hhH
 6tzE/DLCUAN6idlSwqAqsSKHDlAfV+VROWQzaG6SDLiW3LI1SOrEKe5DFTNZUvobD4jCqWyTjhL
 Lqg==
X-Google-Smtp-Source: AGHT+IFdJhZkpTqSEsQyt6nAzQa71DaG9Yi1zGT/J/DoVgoZHV7t37V+ZXSl+fuZAWzHQVO8tpg4uA==
X-Received: by 2002:adf:a2de:0:b0:37c:cd71:2b96 with SMTP id
 ffacd0b85a97d-37cd5ae07a7mr3333315f8f.36.1727513937248; 
 Sat, 28 Sep 2024 01:58:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bb8:2ae:e42d:7dbb:76ba:120d:8a28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57423afsm4313167f8f.90.2024.09.28.01.58.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Sep 2024 01:58:56 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v3 08/14] hvf: arm: Ignore writes to CNTP_CTL_EL0
Date: Sat, 28 Sep 2024 10:57:21 +0200
Message-Id: <20240928085727.56883-9-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240928085727.56883-1-phil@philjordan.eu>
References: <20240928085727.56883-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::42b;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

MacOS unconditionally disables interrupts of the physical timer on boot
and then continues to use the virtual one. We don't really want to support
a full physical timer emulation, so let's just ignore those writes.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/arm/hvf/hvf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 6cea483d422..b45b764dfd0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 
 #include "sysemu/runstate.h"
 #include "sysemu/hvf.h"
@@ -184,6 +185,7 @@ void hvf_arm_init_debug(void)
 #define SYSREG_OSLSR_EL1      SYSREG(2, 0, 1, 1, 4)
 #define SYSREG_OSDLR_EL1      SYSREG(2, 0, 1, 3, 4)
 #define SYSREG_CNTPCT_EL0     SYSREG(3, 3, 14, 0, 1)
+#define SYSREG_CNTP_CTL_EL0   SYSREG(3, 3, 14, 2, 1)
 #define SYSREG_PMCR_EL0       SYSREG(3, 3, 9, 12, 0)
 #define SYSREG_PMUSERENR_EL0  SYSREG(3, 3, 9, 14, 0)
 #define SYSREG_PMCNTENSET_EL0 SYSREG(3, 3, 9, 12, 1)
@@ -1620,6 +1622,13 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_OSLAR_EL1:
         env->cp15.oslsr_el1 = val & 1;
         return 0;
+    case SYSREG_CNTP_CTL_EL0:
+        /*
+         * Guests should not rely on the physical counter, but macOS emits
+         * disable writes to it. Let it do so, but ignore the requests.
+         */
+        qemu_log_mask(LOG_UNIMP, "Unsupported write to CNTP_CTL_EL0\n");
+        return 0;
     case SYSREG_OSDLR_EL1:
         /* Dummy register */
         return 0;
-- 
2.39.3 (Apple Git-145)


