Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEB910ED67F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68WA-0006kw-GC; Fri, 27 Mar 2026 10:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w68Vw-0006jQ-OT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:50:23 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w68Vr-0005U0-AU
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:50:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so20261925e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774623013; x=1775227813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R+HW13UG3MLKGMw2KjovNJw38Kv1EGF+VIWRguG2wFE=;
 b=rcynbq2WZME1G2pqlX5PrsAuknudV8jFiumzjv/531/4R0STiLgMJrVCJWrI1RJqLw
 Jwu6iuKDts72pnGIFwJbi4cqnVej5ldu5+1e7Jvj3uoj4+S76fEa/q1ZNRv3WFmUn4mE
 XGlKgEZCcFm4eZcjTJz7FAaIkWrwa8X4GqSV3iNkpwbKfwSQGbEEl+l0K/BCdVwnpEhD
 7PrfGPdli6afZLr+/w8I4wsa+WFl3+rQJmaGivM9ul+rTsnT6aCn0l9Bo64wI63LJiz3
 NCPLGmxU6xQz/cVT6sFkXnsnEjZE/unt6l2v4FKZskESkUlGGRIUz7Jst0W3vxI7tbEq
 7XZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774623013; x=1775227813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+HW13UG3MLKGMw2KjovNJw38Kv1EGF+VIWRguG2wFE=;
 b=F1lzzZcGtx3g3AcihSZH8GtcQ9iV2v0DQsW8LyqVVhnx8rCcwJny0uwdztVeDLh2Nz
 2YJGxro5lcFPmOaLL12VoGfFsPVEN3DRs6OqSQFGdgM+afEvTNMFHIUAPDyWH+N4Qwrb
 sEBYctwAOv9NHU321BiqlQb6ktOsvIly1oMxR3ueImGWlLM1beaEwaw8+RkyGALpSNKP
 GuxheXtDP76p32EiWljuAU2+xbVNbUvfsc1TQyiUTXr3jNtXGmO8uzeOd4Y22Mxdc3SY
 nphrYC8stvVvbHmK9+0ArmguMdNi7wfBlc5oy8vXcLOuteABAkKenhAVxAk49p8s/0ck
 kEKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0/iFMBWzKZp44pwsH7tUiswng8AY6INNur3UQK7yaw+rtDt15pAZ8Pvuarr70NNCFYwqNYTkWt63k@nongnu.org
X-Gm-Message-State: AOJu0Yw2LpEMg3W/KXhLTcNXkt+Qk0bJRiZhOBoA6jIRlycaAeeaq8/E
 9aA6cvwBywJVHF5F1f3U8E3IKHAAluyRfcEkVH452ciPo7SELpFSEaw2OKB0KqqhDuM=
X-Gm-Gg: ATEYQzwj/45ufdYDjmFwweNPCn5/7ytyaqrO/u6znZsEu2Pg5+SBLEm4fXpnqJ3OzGJ
 JpgBgndcm5m51FjWGwBhx/CnIL62tP5AOYZwmIHABdhVtx1fQAY55n0dDJEm20QYm1i8x6EQcK/
 Wy8OO12AiWLldN65m99jziHA5WPPRZ53m14ARNNFcrDTOfGKxYXOiF3xIaLOVmPez5PKvHySWvK
 ugbi6hJzsN8N4EOplcL+Tm8mMqo+sGfl4YuX1Vh7ixfGkMzVLITNsGOfjuoankg8hbkrdU4uyYc
 9jqDeFxUr/C//IFf6yQ4+6P4yRUnq6Jn8fPl2VNe/aFN9XQE3gJVx0zBgtymFuvx6/0OrDeNSfZ
 bBpQ6DpVGm9Zy+tVHVALCautrr4vXohapaw1v/EdL+rrIBIdc/2yb5ri7HBPr06Tkc6u2J9ZLjR
 LRb324rXSYAIMCsy9EKIarmnkSzSaYZgrSw89OxF4gQ6VnDO5R+rmDastievL+RGoSxXVvbgiXJ
 iF81TUBHnoe2ceBHNvYELzw+bpvf4iaFJwd6vHOTA==
X-Received: by 2002:a05:600c:792:b0:485:4f11:aabc with SMTP id
 5b1f17b1804b1-48722bf80d6mr46936765e9.15.1774623013401; 
 Fri, 27 Mar 2026 07:50:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf1c4sm15509537f8f.23.2026.03.27.07.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 07:50:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH] hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode option
 values
Date: Fri, 27 Mar 2026 14:50:12 +0000
Message-ID: <20260327145012.907264-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In zynq_set_boot_mode() where we parse the string the user has set
the boot-mode option to, we use strncasecmp(str, "qspi", 4) and so
on.  This is wrong, because it means that we will ignore any trailing
junk on the end of the option string, and handle
 -machine boot-mode=sdXYZZY
the same as
 -machine boot-mode=sd

In the documentation we say:
 Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.
and that's obviously what we meant to implement.

The correct tool for this job is a simple strcasecmp operation.
Switch to that.

We use the g_ascii_strcasecmp() rather than plain strcasecmp()
because we're comparing ASCII strings here and don't want the
potentially locale-specific behaviour that strcasecmp() implies (and
we're trying to standardize on the glib function for this kind of
string comparison).

Fixes: 7df3747c92d13 ("hw/arm/xilinx_zynq: Add boot-mode property")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Kostiantyn: I sent this patch out while it was on my mind, but
don't worry about conflicts with your series -- assuming your
patchset goes in first I'll fix this one up later.
---
 hw/arm/xilinx_zynq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index d43f36b718..9dcded9219 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
     ZynqMachineState *m = ZYNQ_MACHINE(obj);
     uint8_t mode = 0;
 
-    if (!strncasecmp(str, "qspi", 4)) {
+    if (!g_ascii_strcasecmp(str, "qspi")) {
         mode = 1;
-    } else if (!strncasecmp(str, "sd", 2)) {
+    } else if (!g_ascii_strcasecmp(str, "sd")) {
         mode = 5;
-    } else if (!strncasecmp(str, "nor", 3)) {
+    } else if (!g_ascii_strcasecmp(str, "nor")) {
         mode = 2;
-    } else if (!strncasecmp(str, "jtag", 4)) {
+    } else if (!g_ascii_strcasecmp(str, "jtag")) {
         mode = 0;
     } else {
         error_setg(errp, "%s boot mode not supported", str);
-- 
2.43.0


