Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A97CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKtG-00038g-I8; Wed, 24 Jun 2026 06:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsm-0002aE-MI
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsg-0007h2-LD
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:30:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so10706045e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782297053; x=1782901853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jjZZZ37o2qWFDzuAadl19N3XteHI/O+LzeoigkNZWL0=;
 b=ShLh1ARe67mf4Bc7UPdj4RAwlE5XfGGZOAaNIM9NrWTN7ebcDPQ3qi9bSMphPIXkzO
 tuVBNrFJNtaZ9OweEqdPppP03bWow9AJXgPAb8nRbqKMRIgCd4p1a4+nGmbudXwD20S/
 KYXdEuk3HlE531b0iaRSv+SACyV7FyVtTX7QLtm8MwUxR/+LMB0p3C3ITyqiz7udn7r/
 WH3jifwG2xhxcAaO1tzOQnSOmxBY6C48iZDkLkzcOljRvySP7ME4kaj3aTUf9jc1ecfq
 cRzrby4K4RYxQ1YHYmqMWVisQc/BUrPk7KDp9iCP5KL7/bmscKIcTQs/ba4ub7xk56n4
 mK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297053; x=1782901853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jjZZZ37o2qWFDzuAadl19N3XteHI/O+LzeoigkNZWL0=;
 b=GXLHwbggPAHf8laEAoS/IwPPFUK/Rn0eMf3djG7aoA1jOFuB20xI4jd4EI+xdK9vR6
 ReWPOlSLu4taUTh+C/eeW2UWpHdE3VbY7F6mExaEJJ1T/zVU3tC59cHuduvwsbYf91KZ
 w/TJGUx3bbtVV6LbeBW2GdqolA6BKXdYk7xlm2nzSURfQTXm74fKaX1Ydfuv0UgHeX7E
 JQOgSSYmf6FpdPDGG6BoXo6ZiSN6GQEzEpXWrp0p7/dKlPjYRTGhHhKbLtSuzvxSC3hb
 U+Ry/cPGnOOxRCvZwgLmde0MJFI9CqtrNN6cxvCJXysGso0bH/pSd1Di7TS3pZH/QFgV
 k8PA==
X-Gm-Message-State: AOJu0YwgrEXlLtRpkIspHNhTubSnqeq1EoorXsZF2KjYbgg25KgK2ejh
 YeyiX+T1VUMbOQKU7CLIlC8IOodpdxIuIyKXg7PX6I428ZRSzodhqhNB5U+K5kzz+vk=
X-Gm-Gg: AfdE7cknHrJ++QnwkPz12f0n0c3BGgyqlb73fzZ1DzMYfA6GT+1eOSS8nQvf9YUGr5t
 mjfUwClRZO5/g4aDmFaauQRBFQlI55OOnUV9M6wGbQtke3GFk76EWl1sVHwJr/MAH3mf06vBJ6w
 162JfJ30vpE7KVSxML9YmQ3eD75AHsXEdLArmhc3t2k4hcpVCFZTIxOuYHuWt4rb995Jgx2M5yM
 PF/vjbkPVn1OSv3+DHDFubK0uZsmZ9BJgtRiKov98qhxKVcJDmtGp1adw7vTBqgi0py6hwNbFwe
 sUSYwTaH0eK796dqlrLrmdx44/ce+2tJFBF0AC/3i1vUVCi4/aGlLfjcXEImTKMB83GAI94VCdG
 gpGsyeLQpXrIfxD0i/gpp7f8k4XvE/fOg0+d6oHoIgrlr1tz23Vm7NbJa4FRrs07bXVbRJKQXwG
 f1FJpu/XwyDMTJRNRkwNu280Q=
X-Received: by 2002:a05:600c:138e:b0:48f:d612:3c59 with SMTP id
 5b1f17b1804b1-492608473c9mr39793925e9.9.1782297052531; 
 Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm360072245e9.9.2026.06.24.03.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 189955F9D4;
 Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v9 4/7] target/arm: ensure we create the wxft_timer for all
 modes
Date: Wed, 24 Jun 2026 11:30:46 +0100
Message-ID: <20260624103049.884930-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We don't want to just use it for timeouts as we will calculate which
will comes first. Remove the wxft feature test in favour of the
broader architecture checks.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v9
  - we only need to check ARM_FEATURE_V6K as V7 and V8 imply it thanks
  to arm_cpu_propagate_feature_implications
v8
  - new commit
---
 target/arm/cpu.h | 2 +-
 target/arm/cpu.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 31a5567c951..8aa7437a397 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -966,7 +966,7 @@ struct ArchCPU {
      * pmu_op_finish() - it does not need other handling during migration
      */
     QEMUTimer *pmu_timer;
-    /* Timer used for WFxT timeouts */
+    /* Timer used for WFxT timeouts OR event stream events */
     QEMUTimer *wfxt_timer;
 
     /* GPIO outputs for generic timer */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 597e0626e7f..4b49f8c43ec 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2269,7 +2269,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
+    /*
+     * We use the wfxt_timer for timeouts and event stream so we
+     * enable from V6K up. There is no event stream on M-profile.
+     */
+    if (tcg_enabled() && arm_feature(env, ARM_FEATURE_V6K)) {
         cpu->wfxt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                        arm_wfxt_timer_cb, cpu);
     }
-- 
2.47.3


