Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F27FD44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8d-0005tx-Av; Tue, 19 Nov 2024 09:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8b-0005qI-7t
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:29 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8Z-0006Cv-Og
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:28 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53da5a27771so3897616e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026206; x=1732631006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AGiVDYi9O6WZWdbRqNxBFFuEiOPsRuegrKV304JLi/k=;
 b=ODE8uFxcgYfNWH+Mc+y6tESMr2Pbmb4LHD2yEomBDPBrDGF1Jxar6nUhw0E4CRSzFc
 H86tbAB9AgiR03c99M77avdk+ZGjx4VyrsLOZPLSKix0SRzaRxpA6VCgrLR51kqecFO9
 +D9Q4NamntnX/7i8av6s27FNsKzY8Zzqzrp/g/1KS8jCxKPS8sXI1/6dX/XTtRod1Uz+
 IuGO7IIsFpE00U1TbBQHYs2fa08s16kZWdPN89JKs3UcYLex/npbygxddXAXmcBj38w+
 aib51TZP66WR0mCBV5RpedWfng2Hr8+IMPRsKESzEL2FU5Gc0bdIiHYZnvmp7kJUNMHF
 43VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026206; x=1732631006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGiVDYi9O6WZWdbRqNxBFFuEiOPsRuegrKV304JLi/k=;
 b=MxMveghrlVwd34GEFRy4Z/gKJ2r/CpVIr1Uno1WTNc+UgEN4LaZSz5Ng4VruICcZ6U
 SqVGfo5w4/GQjRXRzBkqj4DhdjqqNL2/WUfqcGE74dM37td2xbKUa7fLdlnVR12A/s6p
 oAszxShxg/wJLpWM8zBGaVbt5OWKoJViAtYRhO+lHYUbTCSDh0gDnpzd21BQyDwsPB9a
 LhUmRaXFCm8eYf0aMrxEdsv98aendfcmcXLZZ21Y6g7Vx3UewSKQ2/VHGvoNJojrz6XW
 rjRbQEDCoyPBD0eh4oRkr9L8gEhNTb7wLBNhSJEWrr1YGrDky2Wei4hgP7mH0X+OxFUp
 uKeA==
X-Gm-Message-State: AOJu0Yx7JYeXxpteH+N4TyWm6F4RQzrSnTwiFi18bOda+oww8Z8cnxSM
 5yDm1ynG6kO9qcvDYhamGaJi6fauxECC8kVi8+rvkBd9CUVvUQhqQC9CRwAETDm5BGVnrdobrQD
 f
X-Google-Smtp-Source: AGHT+IFQqsnPfp71jGwPWzAfIL7OWX0uYYPTw5ESl2PEQwl4RVwk3fb3FMJOs/ZKq7TL3fA9CL4UeQ==
X-Received: by 2002:a05:6512:3a8a:b0:53d:a283:f290 with SMTP id
 2adb3069b0e04-53dab2a65d6mr7777331e87.31.1732026205883; 
 Tue, 19 Nov 2024 06:23:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] tests/qtest/cmsdk-apb-watchdog-test: Don't abort on
 assertion failure
Date: Tue, 19 Nov 2024 14:23:12 +0000
Message-Id: <20241119142321.1853732-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Roque Arcudia Hernandez <roqueh@google.com>

Currently the watchdog test has a behavior in which the first test
assertion that fails will make the test abort making it impossible to
see the result of other tests:

 # ERROR:../tests/qtest/cmsdk-apb-watchdog-test.c:87:test_watchdog:
 assertion failed ...
 Bail out!
 Aborted

Changing the behavior in order to let the test finish other tests and
report the ones that pass and fail:

 # ERROR:../tests/qtest/cmsdk-apb-watchdog-test.c:101:test_watchdog:
 assertion failed ...
 not ok 1 /arm/cmsdk-apb-watchdog/watchdog

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Message-id: 20241115160328.1650269-5-roqueh@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/cmsdk-apb-watchdog-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index bdf6cfa2566..fe535a553cc 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -164,6 +164,7 @@ int main(int argc, char **argv)
     int r;
 
     g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
 
     if (qtest_has_machine(machine_info[MACHINE_LM3S811EVB].machine)) {
         qtest_add_data_func("/cmsdk-apb-watchdog/watchdog",
-- 
2.34.1


