Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B28AC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVr-00025k-KZ; Fri, 05 Jul 2024 04:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVB-00007N-Fx
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:13 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV2-0003Ey-DR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:08 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77cc44f8aaso23791666b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168859; x=1720773659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbY/YLKB1TZRfCc9s0GoHFiRyDVXIqfIbqhNhcwYuuo=;
 b=UNbMzYxdP2TF5GnSGX6Mf3SoaOdrV0kV4fQKOCRLqXq7c3nmgdCMzvU16JIHaZg40u
 2vmevTiM2I/F2Ug8EZ0oYM/1MYecsdRmS4pyfFUawtevNW5vYvNXTg+FGXBIYtEvhvg6
 oZJ2E/cbEtXRotV+tPZDcw2JsBNmpDhlhMxjFUAacqA+BDRBWTBi/X5kq4XR0Lnq2lAi
 ryZgUnV/e9fPwOQV45+iBeMQxytcN7xApEo5abtvcBnXcgEwWwMwcWNmDBDyLJtPqK8j
 M1C8JjFeIw040kkD/QwAI/PJD+82EE5FlaQr8YY1nPUoIknsPoE/14hyR9GGWucWZLCH
 aLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168859; x=1720773659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbY/YLKB1TZRfCc9s0GoHFiRyDVXIqfIbqhNhcwYuuo=;
 b=wkbDuQFmIx2U+DkJyWSpsndRq+0OZwc2mRkMApzb4mtA1jpGs/Bgm2yV/07zmfnoTm
 8dIKevXS05tx6l7W8cpVp4cNcusbmfobVdtf1EFNd6uyVDtM1eamNAksKkYWighUvXxp
 z7Hp6dcR3AwjCG3HY5Gv0mX8bLBCo2it4fqhttz8xWuk8QYPM5X6ec3dSKu+FetRdAcL
 UBts9HNldsFPtTbbXRSgSHipoRs7hBaiRQiSX6vZwXQJwuX8HEcdNsM/kSI+LvVRWLZB
 hFqkI3OAvoI2s6CohFlmzlUSYeWOsccI7aFOawjLEB6+FHlrwq8sscBW/4Dbg9S8pKDc
 AAZA==
X-Gm-Message-State: AOJu0YyhgpvXylRwJYGQC/C79t1619LIBmXHuz2Lg7N2yqkvnRXdLzJF
 PDdAnOJNdCiiImB8sgU4lF7OdatRKMhulLl+aSyG+5SJE6G9yanWYKv9bSki4ko=
X-Google-Smtp-Source: AGHT+IG5VwnWQZSOVHvQmdd+dCZuesnCXzuT/qM29WMvZywm4jL9nk/0ArH5UmJTKz6fmOhz6K5tww==
X-Received: by 2002:a05:6402:1906:b0:57c:7c44:74df with SMTP id
 4fb4d7f45d1cf-58e5b898d5cmr3663938a12.29.1720168858443; 
 Fri, 05 Jul 2024 01:40:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58fb3ee74f6sm487375a12.68.2024.07.05.01.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4B0E620FD;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 12/40] tests/tcg/aarch64: Add -fno-integrated-as for sme
Date: Fri,  5 Jul 2024 09:40:19 +0100
Message-Id: <20240705084047.857176-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The only use of SME is inline assembly.  Both gcc and clang only
support SME with very recent releases; by deferring detection to
the assembler we get better test coverage.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-8-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 11ccde5579..ad1774c2ce 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -20,6 +20,7 @@ run-fcvt: fcvt
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
+	    fnia=`$(call cc-test,-fno-integrated-as) && echo -fno-integrated-as`; \
 	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
 	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
@@ -27,7 +28,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
-- 
2.39.2


