Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85865E77180
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 20:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKNo1-0002JL-5c; Sun, 08 Dec 2024 15:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKNny-0002HE-B6
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 15:23:02 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKNnw-000869-Mf
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 15:23:02 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa62f1d2b21so523818166b.1
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733689379; x=1734294179;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbiG06Qj2eVtNM1RZ8Zpr4IJcnCvDLdL2ENhuYJnNHE=;
 b=guKZBafbZn0TLuVeqf76YbNFwhpgNI5HUWpsKsBZcYR9RDegtqz/ModZZ5cihS5cvH
 23ogYT3Lf7Sz4zgFjyMS83ut1rliJi6Rd/t3yZ3N0ophHihgNBNCp60vDHjXnTW7qMpI
 +4f0CvnQeTaxXcKR1P3EB/VH/tocmleDZFH7owwKPpxBjS4FS3StJtFKDn/oDBorNdMX
 AvKw45oTSu6QJMElW9+/tDwNuS9jW09Y8TaDSvv/cxv3E+/twZaw888BCbLCZJM3Uq5D
 S2dzaFoFgIiWdf19WycPAgJ7tTwNKcTuV03KjgdZM7lm9efGbjrdAgo+Q1uH5OAaFH8R
 vUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733689379; x=1734294179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbiG06Qj2eVtNM1RZ8Zpr4IJcnCvDLdL2ENhuYJnNHE=;
 b=K50R+s4zJVL9/noCi/a7dIC4e8sSY0PCy2wgmxrW+OFaxlW6gsB1+YM+oqit2/f0DA
 7V7/X663HmUDM88UG9XD3CVjt1DbwCU4zKLQ6YYwhsxvNNsz/ip8yd4dVNLJN7b1hBFW
 RyvN7bngzr0Zyyb6bBZyPxBzE25GIcS7sugw/COesHSgDRBNyJ0nLLO6OypTs6iVwKKl
 LKbok8XW6L7sZY7r/I/dDPsEOSPxLeYGT+Cca103U/wgSW0D8XCD6g8yzZ1eS+9gT4i1
 72Y6h1RnOu3E+oDByH7v5CXLMTOQUjKbyfbDg8JfL26qv2wmodZoeBhpYihj78uiyXq6
 nPtg==
X-Gm-Message-State: AOJu0YxUC9PU83hDEHdXRwAlaifjGIn4FLUdXzC8XDI3YvNqLeI4m7CE
 nxICz7KjqTcU2Is8QAA+an0T7MhMJTGpORr+GAtHb7y5Md8xnU5rAILjXGCsT1OYJPoDA/mR1pY
 tKEzO
X-Gm-Gg: ASbGnctjG2vy6Wvwwe5Vad3yJM/OarFAU+ZfNwXpOLIAAvRuQPdwj+rui2QtaAglOIK
 D07yZC7UAVIMY67FPyeowK4D3WvhlEwTaZFasRkZMogFqJOAsjMxWwcjyREp++HpMbbaCUQYFBo
 95RU57o+ST5+ju8Q4Qbabt+SMJmlYADEdq+autvEaSk5L0PzKKWWKetqB8/uCEkDAkOzEgEciC7
 rZ5xBmQg5nEGNRv7XCoWOWSwlE9PzMwyBd4GDLDu96o/YnoAyz11mRnx5TOCTRATuskU/INAmYB
 6qLp/BZdkm+biWJzpTBdPPl2GA==
X-Google-Smtp-Source: AGHT+IEd/RneVGd0XG6VOIQbVbyIrqEsn8EM4SEAG0TsrTKHyaZmxpROh4o73/aZS8BWnmCbPjE2Ug==
X-Received: by 2002:a17:906:3cb2:b0:aa6:538e:a311 with SMTP id
 a640c23a62f3a-aa6538ea57dmr605554866b.18.1733689379002; 
 Sun, 08 Dec 2024 12:22:59 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa625e4eee4sm585759266b.26.2024.12.08.12.22.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Dec 2024 12:22:58 -0800 (PST)
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
Date: Sun,  8 Dec 2024 21:22:31 +0100
Message-Id: <20241208202238.68873-9-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241208202238.68873-1-phil@philjordan.eu>
References: <20241208202238.68873-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::633;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x633.google.com
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


