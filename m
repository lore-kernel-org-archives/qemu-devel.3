Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B28BE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOffe-0005oU-UI; Fri, 20 Dec 2024 11:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffV-0005mt-6P
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:01 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOffT-0006KG-J3
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:16:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e3621518so1145823f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711358; x=1735316158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seqdfG2PRiYYURL9Ss7VXuVcjxxxymFItOGOa4qRTio=;
 b=Wp0HY9J+vSUe+LDfFTbNLMusngbaqxNJr8ynSbPHDVZ4zD50VvlwUV8ypxjrJfGtI6
 GUdVtS1jPmHt4j0QS17wJnqqLRxQXyV35iPy7cYMJRMWYhn9uY03U9d1Gpg7RqG53Jb6
 mMHv16wNE+E+I17E2cs218Z8INveZK66ACBoVB5of/MDCgcSMiFtoGeyLTK4uf90pNik
 mfWG1LkCWaFE8zjOuwk92ZN9z27FfQrgJTPdn1uE0+3hrpsmQXwNUW3gIXe3gafy0znd
 +CT93H8ao+8SH7RcapSk8LCyDYjGvgCuju9z4pj2nMibOKCrDDN5O4HbQCoPNSRRTBjL
 uMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711358; x=1735316158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seqdfG2PRiYYURL9Ss7VXuVcjxxxymFItOGOa4qRTio=;
 b=F8Szrfnn8e6Hqi+EcnpKdnzBlgSzMVYm+2C0D1Byoon1W4MG0rinRhI6zAZebRUS4o
 EY9LjDKZgDBsMH2xH84PlPJoonnRF0j93Z/33h8FfpmDWycnW6N38PHyg8PbhTXFulmx
 v8ZIC/J7dDZyibdvpggG4SKMqcjPVRHqVdVLFCT2Kkfyyy6bxd939HpW0A+zRUpJ3xtu
 8aqsZH0Nm6APcNw+DKGtx5hwftidcwT05qFedk9/Wq8MWDyu+OAMvauJwKulZH1imX8D
 gEl6U14Y1JZsh4Kf9+1Wf3pkKHZbnK0bBrkU0PK04aCZr0CFeFfluGJkJcaHfQj+fzz/
 wXkw==
X-Gm-Message-State: AOJu0YwJb3//PsIPTjzkIbZgPSI2DnKCLFHdeJnpmhEhwYtUabhkcBMr
 kXAjiTjj9XQnobeMu2RgM8cJhUKxo0G84m2THGW8pqllkSLPi/zJigZ/JFxy+NhPGba5qcu/z0S
 l
X-Gm-Gg: ASbGncuNLJ/qVfOCXhPEc6YxBomN3Mfv7mqjfLfeXQa2r7AfdQ+D+BGcUNaXZMhr19g
 dP9oDw9tsUWgmk4xfx06GOYzyUEDnsfA8VuhBIN9LhE8UL7XjgLLhCj/ypShGv/CruwR/9kkiXC
 EfzN3lSUOnZZctc0Ax33tYKPGM4eMuzmfzHHjvztJi/H2oUVPzIP7voduLpiVxkPiNLv3ymnj47
 M6wG1SdPyAgeFU17fj1qHEsh9UMER+gjjkJRHKdKaVuEn4mS85/WKtBN4FgJkB92a8tyvxU05w=
X-Google-Smtp-Source: AGHT+IFxNfgU8oPaYRzJj1u4rvYk68TNUJmEtwws96JJ2Kle3hRuTZ3+rlI6K997wz4j6/FpkNicSw==
X-Received: by 2002:a5d:6da1:0:b0:385:f631:612 with SMTP id
 ffacd0b85a97d-38a221ea944mr3331975f8f.17.1734711357773; 
 Fri, 20 Dec 2024 08:15:57 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a8d3dsm4329112f8f.94.2024.12.20.08.15.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:15:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/59] hvf: arm: Ignore writes to CNTP_CTL_EL0
Date: Fri, 20 Dec 2024 17:14:52 +0100
Message-ID: <20241220161551.89317-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Alexander Graf <graf@amazon.com>

MacOS unconditionally disables interrupts of the physical timer on boot
and then continues to use the virtual one. We don't really want to support
a full physical timer emulation, so let's just ignore those writes.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20230830161425.91946-5-graf@amazon.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ca7ea92774a..d75e504dcda 100644
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
2.47.1


