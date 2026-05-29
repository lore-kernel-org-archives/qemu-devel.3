Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1510ACD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxD-00023o-Bb; Fri, 29 May 2026 01:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwa-0001qZ-Dy
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwY-00024g-K5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so85497765e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033177; x=1780637977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFmtvDiQiB2D//EgcSN2N6h31MpGS3T5lK6oKAQ8KTE=;
 b=kIuV/s7Xw8QpWrH2n6muI7Efc8Ot6Ab3HM1azVsVLh3GtIPxgOAr3zeEohYLNoZzVX
 pdx2cLgapSxX8XGhSVPJZ9+foHwXNQhQO2fP0lYnSLIxK/zIZmJOYfkPCirVZKYvjNBJ
 rrNsTYAICpFrairAySdTl/6l4r6+ZQxmIflIC2w7Cq9Cj6RpRLg39pIw3cHFn4yvB46l
 8LGksM9BWriAhiwwGOoebslSwcCZ7xShSSmuZt7VE2rfSY77ZvpEIwSfvucwQ7/kSWwE
 8ymTM0U4F8vnJPMigfVCGbhAUIXv1ER6FfoOcVrgKmSiXRVyql1NScwbHiZL/5sUC6RZ
 fvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033177; x=1780637977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nFmtvDiQiB2D//EgcSN2N6h31MpGS3T5lK6oKAQ8KTE=;
 b=W3W+vCQHdWmM/d+fsxlB5xJT87CMHmW4jpcdwUAd6d6kIqz+xz+jqOEXwoLhaklbis
 z8pHSHlLPtkBy01cSp886RHrHSyQBBkcpLEoZtEAGaYHC3IZ/bLrmff9kKNhHMuoltmf
 7r1++Y5JjXlYr56Jbh5OfwQJkz+z9ddWVDN+bDr5lm5tFWjM4q/qEKNffDZcxIbmCwgQ
 P2DaEuq41sTC/YaqNQVNBtgu3Ax1MHEWPZEyZgtKXpS1Zmi0d1QYnPgVTz9zZNSihVUb
 rW3av7KsuQ6RvftbwRusAfxtcfveqZzIEOCZtEd4GRIYNTks4Qg80EyWYB1Ba+Y/thuC
 GXJA==
X-Gm-Message-State: AOJu0YxAww2eSbbL8amxLr27P1EMc/9wBWoyRt6uTUd//iALVmeN7et3
 n2HvSJA9AyL12aOwdsWiVJPyPWJdFisWrG/4dS9VppIOJn5RBJ1a0TtidsYMNLebNqk=
X-Gm-Gg: Acq92OFYLdRPHiFQvIb42erpN/gYl5GoL4aTzkRZyRn71yrGWXDAYES6PeMGEYTKesZ
 R9xuEmCTZo6cKobzo7/pIy75wIFXjSAha94VGW/DtuJLfLfvQGKSFFFnVDgPTKvMZlk9u/FIqX2
 /JNS+y39jwAZQGAO7IOIPvJa14LdR0RSuxj1+AwfZMduMA0ZVrVKP7QjVvbRbYvyhAz20XaZs4s
 K8SNRgfqeS8UkSPPNslViCKkq52GqaIljPVhOSyc3VPoV/NTcvyiiABb7EV7gKR2KpMhQz/sjNn
 qHGlTqLO8cFM6+Nh30WdlpSBg627K5XvULqCbRaKLKAjv2x5p6sQPAMJb03aS26YdaYfM11i/wm
 4f7YUnTEblk/Gj41bQm/fBOX46jizMB2gFxdUtYNKPWWg+7wP5/DOSXEpPezjYA9UKZss+80qWZ
 LwPgAacPZR+IZVOcpJcx+UgNyazku0N+3luQ==
X-Received: by 2002:a05:600c:45c4:b0:490:4f91:5519 with SMTP id
 5b1f17b1804b1-4909c0d673amr22339475e9.18.1780033176894; 
 Thu, 28 May 2026 22:39:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cabfd6esm21161595e9.15.2026.05.28.22.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3398D602BD;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 03/13] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
Date: Fri, 29 May 2026 06:39:21 +0100
Message-ID: <20260529053931.283970-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Explicitly set the appropriate QEMU binary as a dependency so we can
ensure they get built. This is especially important for MacOS which
otherwise only builds the unsigned binaries on a normal "make all"
run.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260526110243.470002-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3b1af78ca1e..494d0109f26 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -58,6 +58,12 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
 $(foreach TARGET,$(TCG_TESTS_TARGETS), \
         $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
 
+# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
+get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
+
+$(foreach TARGET,$(TCG_TESTS_TARGETS), \
+        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
+
 .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
 $(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
 	$(call quiet-command, \
-- 
2.47.3


