Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD445C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 15:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzwJ-00052d-Ja; Thu, 25 Jul 2024 10:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sWzwH-00051A-Rx; Thu, 25 Jul 2024 10:59:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sWzwF-00031I-Qu; Thu, 25 Jul 2024 10:59:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fd66cddd07so8988245ad.2; 
 Thu, 25 Jul 2024 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721919565; x=1722524365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WibykQ2s3kswHkCopNCd9xHLBGIQxNKkwInVYnt+io4=;
 b=ivtQaMzDOIEK7HF1wnEOe65YAZsftV4cUGNuhIR4Yo0Gwrxg90a/L1F0FQvZxCpnLU
 VTYOQ7mUIF26sKfPmsEIEi68tQigeAMUsmcKgqS8cjVAOaTzrCsasrgJf0A2wnBNB2RU
 bIKPUwpUKFo6O/fmil9MEQmdq1tMdx/wu3N+wgnnNPtj3mQFtND27qszCjhx2QzkDkBa
 m4o7kwucHYGhJjwa/G0cSz4qoFc5ndKF+02YeDTEqyoNXQ2CTpNAIYtJ94N6TgWjVYgv
 NwL7NWsXjScMgUUSsnEzIk05eTO6zvTPYAAEm4RVz3FfnSQIp51+x7DOaYs/6cQPz8cP
 ccUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721919565; x=1722524365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WibykQ2s3kswHkCopNCd9xHLBGIQxNKkwInVYnt+io4=;
 b=qL/XKqAETE1RkKvGWBkNp1TsOA1LFCJzyxi3GkKmPJC3tab/hbyJ8GQvfAO8GZbyFa
 6oUcEvtF/3vxsHfnSimyLkYWU784qn/NZAgLjG38DWJ5TRy4hFy9nhfen/SE3H0viV9T
 KugtCzRJiRvaS9wkdQm7jBsKlz+Xra6IgiLEMDLuKqQcUGAQp4h4yT4vAyxav7ryAt7C
 H0bD5DAvPgUNfVZJlTkvlCPo5jFDeed+o7LwBSCojpbLmNrbLMDz+eN6IV89eUpfeYHq
 1tlsLKjfXryYoAcC4noC6YvSursNwGrEH74o6vqqmAvEOcH/ar1LABlFPrit2jjq7u1L
 olZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAyzZCcaRZlSL+WxFSsX70WheTCzNuhz/H1ZGsSTwous2cSniWiFhdHCTPBIvqD2UTED1OXBtcFTKGoRyWNHXoFWyz
X-Gm-Message-State: AOJu0YytPcWbjuBDEiPxDe62naIjoH7Id9Z9/04flqh8rNU58ac/0EGy
 QDGEa1RtHr093HtNZkc51LRPjNUSMbJ5h6IfSWlklccLWhzY7/2aWs7xfA==
X-Google-Smtp-Source: AGHT+IEcSHIIKQ/CZ8OO519By0jSx/CIBj7TqM5/3DKiqtsB4IKkC1X/wndth4DI4knHkpnbSfu5lw==
X-Received: by 2002:a17:902:d2cc:b0:1f7:21fd:aba3 with SMTP id
 d9443c01a7336-1fed38a9b24mr36036145ad.34.1721919564644; 
 Thu, 25 Jul 2024 07:59:24 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee4d16sm15208295ad.146.2024.07.25.07.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 07:59:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/tcg: Skip failing ppc64 multi-threaded tests in CI
Date: Fri, 26 Jul 2024 00:59:03 +1000
Message-ID: <20240725145904.421456-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
clang-user job with an assertion failure in glibc that seems to
indicate corruption:

  signals: allocatestack.c:223: allocate_stack:
    Assertion `powerof2 (pagesize_m1 + 1)' failed.

Disable these tests on CI for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
gcc compiled host does work in CI, though I don't know if there is a
simple way to test for that in the makefile. clang compiled crash does
not reproduce on my local system / compiler, so progress in debugging
this has been slow.

Thanks,
Nick
---
 tests/tcg/ppc64/Makefile.target | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 8c3e4e4038..d57f9338b4 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -11,6 +11,21 @@ config-cc.mak: Makefile
 
 -include config-cc.mak
 
+ifneq ($(GITLAB_CI),)
+# When multi-thread tests are run under the clang-user in CI, it causes crashes
+# in glibc, so disable for now.
+# signals: allocatestack.c:223: allocate_stack: Assertion `powerof2 (pagesize_m1 + 1)' failed.
+run-signals: signals
+	$(call skip-test, $<, "Broken on Gitlab CI for clang-user")
+run-plugin-signals-with-%:
+	$(call skip-test, $<, "Broken on Gitlab CI for clang-user")
+
+run-threadcount: threadcount
+	$(call skip-test, $<, "Broken on Gitlab CI for clang-user")
+run-plugin-threadcount-with-%:
+	$(call skip-test, $<, "Broken on Gitlab CI for clang-user")
+endif
+
 ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
 PPC64_TESTS=bcdsub non_signalling_xscv
 endif
-- 
2.45.2


