Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540B8E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7SL-00056r-Cn; Fri, 13 Dec 2024 10:19:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7Rg-0004TA-Bj
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:13 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tM7Rb-000596-6I
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:19:11 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso3857755a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734103132; x=1734707932;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbiG06Qj2eVtNM1RZ8Zpr4IJcnCvDLdL2ENhuYJnNHE=;
 b=Mg/48fs7F5xz9lLSIsD7ur3qb5fJt+LVbDjCqR450zyt+5+xCZwAwqy72LY8/MGdmx
 nYS3kyldjBoum04UNsDV9dM8Pt+XAJP6b4TkcwSNgNTk9PDKyCxTCfo3h8jbyubvv0K9
 tfCa+TFI1Dpg9sSilvRH2PPpRWqdhXFQCMf/Pxq7MLYMVljL8lGLF5NOLv3XhqP6QZiw
 FyvP3cyPgX2zjkqCoxS0zcgYsCW36zFQCVB+MkSKxR1Zt2Xh9LdZMqSEoWziXC7yeQIf
 5KLTK/qT2vKLQAYVi/hY446QDxeBwFfBwvqkK4v+XPd8B3SFtBxU4w1dsCcj8PihMQvn
 aDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734103132; x=1734707932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbiG06Qj2eVtNM1RZ8Zpr4IJcnCvDLdL2ENhuYJnNHE=;
 b=Ng0G4Ho2dLF5vIKFfsniOpxRWgoLEf/NHW688pIKT7gTzbYxER/5Ve67eaxTjBdWRx
 4XEo37Jap3hPY02KFp7jPWC0hFmaG7V/yMTp1NkvTeoYk9lPWC2cwzGdTUljHux9jQlG
 blX8MwutNyQoN8L58LQfcJEJmaZchludBswpRB4iBEz63uGEWMmAUYdWCO6jAZezrkLt
 tvp0eZWVBBmP6llymc8k7KJPeyu+RJ8t+sHTE7L0oL0UiUn7kVYVa5TP41iN2+lloqjV
 u46A3ONNHw4Qjphz1dAzR8Uh4EtIJNC3z80mMah+QfXeMnjJtXSn26pk5ZFo1K3QwBbG
 2iYQ==
X-Gm-Message-State: AOJu0Yz9IqwQLVy/sWqNzi09V3ieFjazp9ktG4ZgyctRHZ185JpkFHrr
 h0sAdfH3cIUnA9arbmA2dyKcqtWBKpg86PJCKis0sdfAhD5pqRaAIXacFrTA3DRIr+oZnISopqs
 o5A==
X-Gm-Gg: ASbGnct3R7AKdGHG2EfJztF9Ab13/qDYtLNAPTmnm+2a8prJr8caMJ6HsjutRTlAEvV
 FWshJ3NXD/DtvVlCbec1THHAZeK01nCRSu+mUBjUppe1kvAKA/rgVoT+7A8rI1eKfJOoKyWjvuJ
 fg2HUZstb4/4pbFEko6p9e77x6urvQIJ1SRBwKwftH/fhBBrXkbqUB0YEzLUjGbYT16HpJGT/Rr
 VXQPMgr9Dl6HRbfLiUFfA6P2D3MlSt1zWCSiUy6CbLUXVF60JYwdY7b9JpXFLMp3ApPhp0dfyaP
 aTfCJIlzNNZOriTwfcQqF4vwRlN37NJt
X-Google-Smtp-Source: AGHT+IG5bvJo7d8pkfatjbIVYQhMywy7MKrXn/q3FV5D1M66jmhBDg4HL8AFRo+DCOuQKlTU79yJOg==
X-Received: by 2002:a17:907:a08a:b0:aa6:8bb4:503d with SMTP id
 a640c23a62f3a-aab778c9cc3mr328990866b.2.1734103132294; 
 Fri, 13 Dec 2024 07:18:52 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab8dd35b19sm29284166b.33.2024.12.13.07.18.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 07:18:51 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Subject: [PATCH v13 08/15] hvf: arm: Ignore writes to CNTP_CTL_EL0
Date: Fri, 13 Dec 2024 16:17:58 +0100
Message-Id: <20241213151821.65748-9-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213151821.65748-1-phil@philjordan.eu>
References: <20241213151821.65748-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52f;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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
2.39.5 (Apple Git-154)


