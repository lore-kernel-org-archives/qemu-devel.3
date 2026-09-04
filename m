Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137CEC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJN-0006C1-J2; Fri, 04 Sep 2026 08:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJB-00067c-Ug
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ9-0006ot-8z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso8325745e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525973; x=1789130773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KY0Q2xm8DPInuYXHS9vmUOmfWFRXKvavX05e4v+n548=;
 b=TP2xZxmnXRpItcj0UyPdQWXCRPARvn8bc4YlH+qdkldmgh8GprIwaeMH2FD5Sd8X2W
 8enQ2Zh2Jc5+qekRyI7Gnx3hvw1iyHDwTZ6O1mtVgdDCN1RDxJQ4xq05iwG5sSgSwKrr
 65eAUqRO2Odhdiynw/DJi2YRN+d3NXPjmfBoWILWww0EI0t1cgp1FAv6eusBn1eSxLo1
 BGhiT1GIahfdCKS4Q4DzaU20g0wKUIyqHjin4PCx5TDvNLDEdNI703m9fG66UXVO4XDE
 phD3Bvaf9tmzhH04JVUPbCDc63Eokp+TXtQ+G4ANtOAesGWdNOC0daNReVQubiwPHV7O
 lX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525973; x=1789130773;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KY0Q2xm8DPInuYXHS9vmUOmfWFRXKvavX05e4v+n548=;
 b=eYwQiF0lseasHJFZC/8qPE5rAEo66EDWiD/qOn1U+DlD/TUl34mcD7bwmmr8RkySdP
 vWbBh2b/6f3C++4RJ85bJAwNN0IZySyLNcPL/CzW5n7GEMaK0pPe2bsUk+r/Git4BjbP
 cvV9zCovJ9FS9GHPRind/Fht7kMjC0vW93uJXZr2re/fzyj7ujr0eoZmb+ieVUl6bZ9q
 l4rynMh46UPwrGke6FAVxKNMdeUR63ebhIc2GAvPOEKjakDx12jH2pkmCCKdCjqcMmZ6
 A2FoDlAyen/Dy4sdAdKqP+cFTlP9C4nKG/egc6sKJ95LKgD7t387aOxfHZNk1IK4iG4B
 ohyw==
X-Gm-Message-State: AFuF++lVublgRdv1jpS1YrpU9J1gX5Y5Zkq/6zFFCIWvxf9kog5f8Sxa
 hgBlz7G3yh/+enddzoCMFW3WgAUp/j/1QR9i1gbhqCNxHUAwc1xZVf2VH1ENDLPYCm9FCelN2sd
 DHJ+Y05k=
X-Gm-Gg: AYBFou3gcKemEHpgT4C8kzJjuO9zDnJvUiavaxCQ3TAdl8Ha49csC53Vjn7+4n1W/PA
 cyQiBaqmOhgHmPzKRCLFxGXeiMjclG/FEU3N+gP1xFHzbm7uf8uE7upKGdc7/G05szfStJpJoDw
 BVWfDwbe9RINYoVyPf+zONyI4LUY6fVx+NyR+wBWM0BV7RbnPu4Y5JEfxxTn+P6VE069wKXt/uQ
 UVZzKUK2bavJCMkISZRlW905Nok81X/UUDj5Z++PRMxUaGoTFbyEhRTx1IOuizLs1BfRGAKeuyM
 VpwrJwLzRJ0dC3HUbUh4COX91ik6ktAtoKLtM52jrb+PIQIN4S1u5PZ68YMxMqUb0OUeN1HNZNo
 CmHtFrulC8UvD89E6Gt5L9u2fjdE/iKe0irJNmBz+Sx1iThw8emcHVRuSB6mN6QU3nyFyV/KRud
 bkuzvPacH7JWerBvn5sfG2MgA1CjtGID3HiflaXDLxULH4OivhixAZNiT07g7wfxK6s7qwsnE=
X-Received: by 2002:a05:600c:190b:b0:49c:fa21:e743 with SMTP id
 5b1f17b1804b1-49cfa21e92amr38781305e9.25.1788525973436; 
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm2433746f8f.3.2026.09.04.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 12DAB61351;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 007/105] tests/tcg/meson.build: introduce test_name
Date: Fri,  4 Sep 2026 13:44:21 +0100
Message-ID: <20260904124604.2207440-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We add possibility to duplicate a test for a given src. This allows to
declare several tests that still share the same executable, thus saving
space and compile time.

A side note to mention that meson perfectly supports declaring several
tests with the same name. However, we prevent that to force dev to
clarify what is the intent of each individual test.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-8-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 697b826a382..ae7ec998f63 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -12,6 +12,7 @@ tcg_tests = {}
 #       {
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
+#           'test_name': ['provide an alternative test name'],
 #         }
 #       },
 #       ...
@@ -21,8 +22,9 @@ tcg_tests = {}
 #
 # Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
-# is guaranteed to be unique also.
-# Default name is derived from src if 'exe_name' is omitted.
+# is guaranteed to be unique also. Several tests for the same executable can
+# declared using 'test_name'.
+# Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -52,7 +54,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name']
+        allowed = ['exe_name', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -67,8 +69,13 @@ foreach target, plan: tcg_tests
         exe_name = setup['exe_name']
       endif
 
-      exe_name = target + '-' + exe_name
       test_name = exe_name
+      if 'test_name' in setup
+        test_name = setup['test_name']
+      endif
+
+      exe_name = target + '-' + exe_name
+      test_name = target + '-' + test_name
 
       if test_name in added_tests
         error('test ' + test_name + ' was already added: ' +
-- 
2.47.3


