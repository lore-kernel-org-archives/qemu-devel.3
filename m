Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67F3CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYup-0003wq-9V; Fri, 19 Jun 2026 09:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYun-0003um-HQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:45 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYuj-0003PC-Te
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:45 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c07a6527453so239835966b.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874340; x=1782479140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SE+r4wGFd7f55RWtkYqXbt9/MkUiYQSeM/Vm+Litt3k=;
 b=NpNxy9in3sEultNtVNsnxkYIhnoxAyCUM3Z7k1EyyNUzfuh3pbakoca+0b+smB+Pwh
 mfmOPEd/myxbmQfm7Jljw5QftLNqjJ2/IhJgikefcTc7LbXCQiGMfurXh8FIjZamflmK
 O8lK8rWOHyxh97t0ogXyOBNMleezN8pBJEDEyHwfBT/nqFmuyveJAyiJyXTyd2YhT0/7
 DlLGQAVpPODWd2L/j2cN3KJ+I/rWh6cty04HXIYvQtgct5f6Rmeb+PX8he2tMYxPCoKL
 p4pCzNQYZrO7PPWpg2Z7ZOUf+9aAGIOOjwLTAC8+1emNHv2Xc2kdpBuhlYq+qnKFApKu
 6QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874340; x=1782479140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SE+r4wGFd7f55RWtkYqXbt9/MkUiYQSeM/Vm+Litt3k=;
 b=gNPixfuoZDmdD/vkCNkvr0GzbCgpJoeT9DeBAWkYSRxajnc5h1XkXccnl029bQt5LS
 oBCUn4iYbjmKhLpXH59OW5nwUEg+t4V+DwX0pQsJREMHoZJRTczYkfgssxltIDXYfYXp
 MT80n14pngs9gr6W4sNhqy/mVc8lZq7uDVKhroLTUrspBm1ddYNm2C9gN6PhBfK3GyBK
 5i6/0S354SluJskTo//KkKLOEW0VR+Ibfc1N0Pelm4/UmsyHLMIUCRjnS1z+O1zPSZek
 /8MQgtk8J9kHbSmzpI6UnoMTCAVOkbFsqYbWrrgZipTgA3NP05PgGVGVNFFlDKaoflB1
 FLAw==
X-Gm-Message-State: AOJu0Yw1nPa8KEX29UydamDQI6r4TAGsaZ9nSvaZBQRhF/1Fl39QnYDD
 A8R/3muWdOsyFGOeLvLnBHv1bufYQ0VM5KiK27ZgrGhD/wC4WWSp6jriqzDrbSaHh0U=
X-Gm-Gg: AfdE7cn/UItnaqOvELc19SDjB5e5QdBYQCAKPxmEz2jM3kbjR7zfZm8mMN2FFq0cnYU
 eKjFsgHCzlAtrbmcY5RyaN1cxRoXpdKA8gM+vRxRIunUrPYDuk/4Pjjn4tUSnREW884zxUsdzvO
 PTIPMCXEgiO90s0Taphv0lJP/H2vrh44cKFJ7q+a0RhEYkC1us7h/K1xfr0eMHHv+uJtR1awnOW
 skGl37Eotgckd52EXBDMLYu8t6yA3aA/8C/5BV+5vn/mycTjUxFjMPRS6+ZN+bi+TQfJYgtxvCh
 MOoxKzpp3NQzh4QuFZtypc07lUrsXJbZ/MNL++wspJ+7GDG8KCJmonZ+pDJ9p5tkobKlreWtfKR
 y5ai6elu8q2erdzTFCFcGTVGOevjt74mU9K6qemfiomG9v9UZaYYI8D3F1QZMQ2hRc6qHdbWZ7A
 dEQ+Ecit3sKeZbWo65NkxMeYg=
X-Received: by 2002:a17:907:94c2:b0:c05:84b7:550d with SMTP id
 a640c23a62f3a-c097ceba8f0mr182145466b.43.1781874340116; 
 Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a253sm8064924f8f.23.2026.06.19.06.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1FC85F94E;
 Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v8 4/7] target/arm: ensure we create the wxft_timer for all
 modes
Date: Fri, 19 Jun 2026 14:05:33 +0100
Message-ID: <20260619130537.820184-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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
v8
  - new commit
---
 target/arm/cpu.h | 2 +-
 target/arm/cpu.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

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
index 597e0626e7f..61945b6e6cc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2269,7 +2269,14 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
-    if (tcg_enabled() && cpu_isar_feature(aa64_wfxt, cpu)) {
+    /*
+     * We use the wfxt_timer for timeouts and event stream so we
+     * enable from V6K up. There is no event stream on M-profile.
+     */
+    if (tcg_enabled() &&
+        (arm_feature(env, ARM_FEATURE_V6K) ||
+         arm_feature(env, ARM_FEATURE_V7) ||
+         arm_feature(env, ARM_FEATURE_V8))) {
         cpu->wfxt_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                        arm_wfxt_timer_cb, cpu);
     }
-- 
2.47.3


