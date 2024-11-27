Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF015D6ACE4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 15:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGJcp-0001yG-5W; Wed, 27 Nov 2024 10:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGJcF-0000ox-HG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 10:06:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGJc9-0008GO-Oo
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 10:06:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so36132195e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 07:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732719957; x=1733324757;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHwSaHBvDOuggNzApud1KzwY/aX4UN5MIxFwz/8i6yU=;
 b=F9FP6Y8stHxnJe4qGsCeTTwNuH4xMwE6hM0qPoeOFtsajPRvxHsSbJ2asnBwph9s+d
 dpa50Is6XlVOBrDqQ+h7xlIZXcayueVBJbuYDTKit20zrw0VQZEXHUTRR6oDgsEV5Q6U
 kEEJ6VTq0RaIYk+Mw1odB7G/UoOSWyqnIG81Vya9MDsNH/1Fj8fz2LyKCtF+b4b54JtG
 P+DlS+2H7nhNROoTx6vi/w2+MO1xuDfiMHgsDbloNxx8XdsMssW8aBJvg56QHmJ5g60Q
 gRLEgAVrXGuLkf8LWgyrRUtJvvIc6qM0aRvgz0PacP3BMLfHisDT/hw2DpFbewQmcp4n
 ZEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732719957; x=1733324757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHwSaHBvDOuggNzApud1KzwY/aX4UN5MIxFwz/8i6yU=;
 b=DPw4usNmBQ1c+yKx06bd2x/l1pylcMBsAMjUSIfYUA9howw97ddqk0Yl9z3zrFCH9y
 fGu3ytpAPzKMnrAfNhfX3T6n1NtGaY/7jZXMp7la4Ghc2EoQHNgFNjbHgLBQtt7LUSHj
 +Fo8ajbyPpkjJWvw7jTOW8DfEsoQCgVTyLPz/HQxoEoKRNomZV2OsduqQRL1x88QQrF+
 f3sh7PyA+jcoDlqBqUTRBCsshbpn41nzSyY5kiPwcqSOkACCe1vc3dgwhQ0do1U+e05p
 DDwKAm024xY84mHhZbvtXZ/IFMKgSe1LEzNdI+zZk0qKoMJH19FOSYQ8eM+6OBpEugSQ
 XbBg==
X-Gm-Message-State: AOJu0YyR47ldsGa8yVxsSTRYjaYKd5aJBnqkfOdaWZOxAbwNqeCXYT0L
 B747INhTm1NRE0Dh37U2Srw1aZGkx3SI6lkN+zhVGyFvlTR2n6z9d/u9RsiN0/LL7IBGPuTjrUC
 O9A==
X-Gm-Gg: ASbGncul35gKz97ZLJD5ZruXSVT0vqju1zRJ1MJH7lcsboigD/3V+SbA/5Ed7Nsch0S
 5IJqHfZByGHgDlOZiJCaAS8LAK3zo+vnFQGZhHF4r5C2UKkzDU3zbO9dTvyiVCtfMQJZAhexgS4
 B5LrS0qKMrfLSbPNgnpKX20is09PIzOtr7Nps8mPVQ+6sNqHj25D08YQkP+JRlnmpsc3OTHYSVW
 TJuDwu0AW+2ItvntK1vIcmcBqAOt154WaBfjkqa5BHMqjBOZkwPv1kSKz5SRt+jjCt01m9IQ5+h
 vHziITaGdVf2CTY+IM3duwb1mg==
X-Google-Smtp-Source: AGHT+IEpTUCfIu2/vfRcXXbfxiMnmLWIvRV5OvDGHOKh7IJK1zQzvdZwwpIYUSyHi+CaRDwwrVO98A==
X-Received: by 2002:a05:600c:3590:b0:431:5f8c:ccb9 with SMTP id
 5b1f17b1804b1-434a9dcf254mr39924575e9.17.1732719949435; 
 Wed, 27 Nov 2024 07:05:49 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e256esm23339155e9.32.2024.11.27.07.05.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 07:05:45 -0800 (PST)
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
Subject: [PATCH v11 08/15] hvf: arm: Ignore writes to CNTP_CTL_EL0
Date: Wed, 27 Nov 2024 16:02:42 +0100
Message-Id: <20241127150249.50767-9-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241127150249.50767-1-phil@philjordan.eu>
References: <20241127150249.50767-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32d;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32d.google.com
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


