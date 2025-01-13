Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C256AE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKuO-0005pt-BD; Mon, 13 Jan 2025 08:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKte-0005Yb-F2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:28 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtY-0007g8-Sn
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43618283dedso41304825e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776459; x=1737381259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oqyhWes69m00SZN/2xllFZp3O+O8+KCDov0tG3Qz9ME=;
 b=Mza69ORfZHBaqtQfZOSrF+7DMjyrxnZWQbrlsMdYrDefFzCTH/qkvr/+36cxXaZbTh
 upfOsjx5gFSfhs9Pb86QTSVCxZnBGikGJyi4FZKwfZZj2cB50+35YKtlrig1txWwuswi
 ewq6UeJPzZ6BddmYON1dV7/R1vzfvJ7ZX5spKFJ3MnWeaLQMEEl91zg6sd/lF2fjYc9G
 KTkXf9A/J609icHlmOom9KiCuKxvF6tyuKdZ4ZedUcf9n5wwfzU7lsX2dPsJucffQtbq
 yCHOw67brMOjmfqSX+I2QPazZy2qJIct3ahTvCRElKBk713UazZQY/ec5b9cm/LADGIv
 angQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776459; x=1737381259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqyhWes69m00SZN/2xllFZp3O+O8+KCDov0tG3Qz9ME=;
 b=lqm7QM+yckCAtN5k6olvSr/KzreRK9TITXWSvEhW1DZVGb6/aGfInHP3g9LwVBCvfo
 Dhy+aMDq8fuDddM6ui4uxx6rks56VJCzk0CsXq3XuS3pmUq08hDcFR3XDo57tNKrQ3xv
 N86EzRh8Mf1JmMEVJSFmiEwSzTiywuVMLCYIWO6vXOIGBxaoggRVVvFKOY6sUMZWQlJZ
 3aviNbdbVJf/VwcfCI3+Oc/VZdOYlgsvUxXOm6He6g2cM2cGD5uMbb530TADfkVjaj9N
 MvAeHSTqjEKWnG0mREsx2Lq4sREJn9tp7+Ds3XguENyjD4jni1BaQft/ptjLM0QS5uU2
 FoDA==
X-Gm-Message-State: AOJu0YxucZJlJ9GGMkpJGKquZnMp620AUn4ZlQC5PKHDWZ+rSSCHSutC
 3DP4uRzo14Y/cE7UQeQhWBvI4It2TWC5v0JkEpMtebs+8GPivSrEmON2wr1i113k9SAy+rk4qTT
 J
X-Gm-Gg: ASbGncv3elWZBAftvISqjHVukXJxP5LKf286kdQ1IFmEEowNEPNXpqa4gc9VobVv6Ny
 0qJbOZc9Pw16++O5oLCTS0xEmvmauGhfXBUkPoa0liXS6g3Unzdgr8WQI1su6BKihtxekZhrLDf
 dk1Ih1vU4doDxdZAfb0TR/MMTt9qziXocMsOZgk5RAfYoZKgl6UWUPMKrYCwCw3JuWpYIQUhSJ6
 cd9XDdJKCUIwes/PcJhQa2pwS9qv18vNUxFFNETA1cZyTANbd1ms/p5vNBaxk8=
X-Google-Smtp-Source: AGHT+IHEaAeuG7LsAHFOlvF7V35hr7jyK1X/JWAKGSPBpp3bCFzRozlwfkPQiVMi2ud61TLA7hZa9A==
X-Received: by 2002:a05:600c:4511:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-436e271d428mr206952565e9.30.1736776459205; 
 Mon, 13 Jan 2025 05:54:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] tests/tcg/aarch64: force qarma5 for pauth-3 test
Date: Mon, 13 Jan 2025 13:54:06 +0000
Message-Id: <20250113135408.3164401-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
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

The pauth-3 test explicitly tests that a computation of the
pointer-authentication produces the expected result.  This means that
it must be run with the QARMA5 algorithm.

Explicitly set the pauth algorithm when running this test, so that it
doesn't break when we change the default algorithm the 'max' CPU
uses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index d08d9b01ded..9c52475b7ae 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -91,6 +91,9 @@ EXTRA_RUNS+=run-memory-replay
 
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
+# This test explicitly checks the output of the pauth operation so we
+# must force the use of the QARMA5 algorithm for it.
+run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
 else
 pauth-3:
 	$(call skip-test, "BUILD of $@", "missing compiler support")
-- 
2.34.1


