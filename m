Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADF9D729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH2s8-0008Vn-Kl; Fri, 29 Nov 2024 10:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH2s6-0008TX-7b
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:25:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tH2s3-00028f-Oi
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:25:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434aabd688fso12871305e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732893926; x=1733498726;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHwSaHBvDOuggNzApud1KzwY/aX4UN5MIxFwz/8i6yU=;
 b=sz7IXKOf4qbaka7VtUr5BbQbqy1J95T5KL+If0g/F6GavobJCiooi6cQLHALBhNv22
 e7iAGMgF54nbZ1lfyPimK4avEPYEeoFEZZ6f7D/mKDsgx5BnKItxnmLsvELKFzsKbbGd
 S1AdfnBhShZ9HtHLL5b33v94Fh2I5m9riv+CY1nWqmbZuzd6Kp6k3ZGrvuDABMebesty
 xhgcTrFPPBohLh8+XzpQAo6KSUGhySiBFhvpDRvoOP2Z6Jlo4F9weAcC+uViSdch+Qsx
 F6q0oPsX6LBkL+Or9O2+tV/NylCB88t9lB4WpQPe0GAyb6g80IvC56SYf9oL0HPAtySw
 KTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732893926; x=1733498726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHwSaHBvDOuggNzApud1KzwY/aX4UN5MIxFwz/8i6yU=;
 b=lLVp1StU6Fv1khwT3JFPD/Cps0o/9r3TCgpi8TP/zLx0qXLwNPxBVn6mjSF/cZd1Q4
 XVV6RR7RRBZJbBDC26dLNs6KSunVCYCKYAjLchRen06opQUipFkuhmkk2ipNUWGRB5Uf
 thEvpgrz2krBYEFqP92r0E/QtgIkgvlPWQJmnI3AfxjkpRdc+QemygVW8Rcme8wlttol
 /63mIA2WMiZHeVf6FwALvRLMmey8/zVzuLcZZmX2+G9pspIMI6TthQ8mTofPSDI4kO8o
 r2C5bVM4hwWPq05Iwrybh+qTz5B32UAW0eZLc1dJAQ5TAX7Z9UHfZeetNq29KH5ADSIV
 Pe6w==
X-Gm-Message-State: AOJu0YyBnyA9HhsG8KRIt9O7dE50it3/31ahG364evYw3rpTML/F9bvt
 R1xDxIuu4zhxJ0yoQrBR67K+IJBhybe+mqJYQr3s6rFrjO6gwOdaQ3ATYE0KQzN+Mh7WYzQSl9q
 UwA==
X-Gm-Gg: ASbGncsbO38WjPDGr4ZTcoZ/lnG8efIXKwvbg8C4FkyeQ1Ra0dFiy2etdvaDqquzGzt
 TtnM14oUAGQfDA0YnMGa97LJSlh2IEeINHYvUjnMrQs8OcoK25AQ5flOIo3hHicN4YPe0KhrkJB
 3RmrmcSS/tqfnqnOtnQcQG7tY8m2Djh1Mea8/I6xLrKgK034iKxVJgZaZOMMRuKmo9Iu0bzYQ5Y
 izZhhLo/R+znQpG609Agz3VGjY4JqA+p4/7ilWpkCHhG6bUWyUCkAHdIMxV+enUOjKvNEy0sthu
 ho2I3ADhK7d1H80SejH484XJZQ==
X-Google-Smtp-Source: AGHT+IGPZB64TXzI0cJ2Z/7CAI3nKpCPQzJKhu1GhGMD2rZt2uPoCexLBLMukrYFHdQpYH/W6xvjdg==
X-Received: by 2002:a05:6000:4402:b0:382:5088:936a with SMTP id
 ffacd0b85a97d-385c6ec029amr7790725f8f.28.1732893925958; 
 Fri, 29 Nov 2024 07:25:25 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd2db2dsm4685119f8f.14.2024.11.29.07.25.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 Nov 2024 07:25:25 -0800 (PST)
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
Subject: [PATCH v12 08/15] hvf: arm: Ignore writes to CNTP_CTL_EL0
Date: Fri, 29 Nov 2024 16:24:59 +0100
Message-Id: <20241129152506.59390-9-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241129152506.59390-1-phil@philjordan.eu>
References: <20241129152506.59390-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::335;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x335.google.com
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


