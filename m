Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DE9CD6E56
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFm7-0007zM-I1; Thu, 05 Sep 2024 12:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFm4-0007r5-K2
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:56:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFm2-00055P-93
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:56:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bb6d3e260so8815795e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725555357; x=1726160157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7FHPmOQWKyZgNpvo90Rwc4wX0dTz+RaJ8RO/pqd3yM=;
 b=EojgtlxHSM4Lkm51niss8SJ2IRUCkAnVqTlzTpvE83cUZ3SKL22jzOQ5yq8xvWlV63
 YtMgdzbFwqaYmfIFUT2/YB7oa+bD+mH7bZlsiEdpcW2e1Jx2vVhY0E+PVBRpO8x7IkB1
 dfgz8WPohhrBQHgrI+ZNSjS7ruGk0aB1BDMeg2Bn80BnDYtlwtnTq2xrzWtLHxr8QXC3
 tk+VPDuruFxWfJx77MeWe3h+IXtioeNHlqWXZDvFwekcxsNPwcUNAtOCqlN140p11GL3
 NMPi02ICCksVp+grG/pYKyKg2/Ae5eYnaf8Wo5LjtBXloEc2wPrU8iIO4RTZAsFZ4GwB
 7mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725555357; x=1726160157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7FHPmOQWKyZgNpvo90Rwc4wX0dTz+RaJ8RO/pqd3yM=;
 b=kghZEd2lV7DwSXk4s5FIP4CAlEXdx+ciuV7Xho27Wl/lyNa2mGXy/KCt214xJ5JB42
 pkwwl2Nof4evWmLf6NoplgG6d77pixnJp92SA++YfZvfvU5dQEHEnutgYUUEjcVOX+UK
 xUgDbChhWMZZLJsJT6K9dR8CVCFSn9GJewL1ZUDGV2B5JNXZMrSeP1quueQWIH+Dds11
 tpQeEOLDqRa2YAmAnbdQKFtyL60bVI/gxPN4vR/B7EWK7RwneckFaOD0YDSy37K3TvZN
 lw3YMphQ6R+nvG1+od6YhuqB2B8NB/dYupunqURScCMrgAMz3jjCvVB4ek1K7GGD55s7
 IXwQ==
X-Gm-Message-State: AOJu0YzO8xn7wCooXyol3zf3xUtqiuStAxjfHhb8r9lQ0KrfA3OIu6iJ
 J+bmtJvODb6EcTCd+D6eCNYr4HwBiGS6zkJJh+/XSoVZ74XqpBJ93XpXrSJ4xczqb0Dj4oirRcZ
 j
X-Google-Smtp-Source: AGHT+IFqSIoDShQw+aHJY3AhLkPZ1ZS6Ams0m/8qg1iAM163Jfskoj5W6V/fhSJVpaMt/fWmccQf1A==
X-Received: by 2002:a05:600c:34c6:b0:426:6921:e3e5 with SMTP id
 5b1f17b1804b1-42bdc64e47fmr130888515e9.24.1725555356697; 
 Thu, 05 Sep 2024 09:55:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbd1eee1bsm206914925e9.9.2024.09.05.09.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 09:55:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/2] tests/qtest: Bump timeout on ahci-test
Date: Thu,  5 Sep 2024 17:55:54 +0100
Message-Id: <20240905165554.320577-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905165554.320577-1-peter.maydell@linaro.org>
References: <20240905165554.320577-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On my OpenBSD VM test system, the ahci-test sometimes hits its 60 second
timeout. It has 75 subtests and allowing at least two seconds per
subtest seems reasonable. Bump it to 150s.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2f0d3ef0809..fc852f3d8ba 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,4 +1,5 @@
 slow_qtests = {
+  'ahci-test': 150,
   'aspeed_smc-test': 360,
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
-- 
2.34.1


