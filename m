Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AE8C3601A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqZ0t-0001c5-M7; Tue, 17 Sep 2024 10:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZ0Y-0001Lo-R1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:16:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqZ0W-0008Eo-RT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:16:46 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so3708271f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726582603; x=1727187403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1NnvH7SlCYrHC/C7NDRiVbBrF7ua2JwUFU1F5xbgsX8=;
 b=ZvPwlkUeK3Ka26t6CgECg55rG8759Jq16YPgd9sneoW1wZ+LqCImM4ATEVXUYYaG7C
 La6OsUe6GM6TbTpXZJ9jR6BqYBGYBDaTv2aZzJDA30nz6dr/qgz45fI938svBshIvwfU
 uoMOsjsx69bSAjrl+bAwibedcjPblSOHPyHWeJj1Scpt74n+YzhVhj0zeNSRa2rmPNak
 QZVDDhaYtapEL5QmFB9I6p9gtVJxqGocjA3YbEVvbdfMLmtsNyMMp8shZga7mt2LCNTb
 myZe8/dtCMUxqBoY2ZJQIvNtEp5cTEwWPedJzKiluSGze5rWV4JyZzPZFAhse9sURVJW
 Tyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726582603; x=1727187403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1NnvH7SlCYrHC/C7NDRiVbBrF7ua2JwUFU1F5xbgsX8=;
 b=R3Js2KeOgd2k/Z1hSORxE+ClVsVFl5b/qDAtNHdix7W9csHxAOmE1VLQURtU2u1dkI
 hiyOyKg0N6pVQwhbaB3QFzhX1HGV1IcUD/YMor0GQS5FDtdzj+WZZmvC0Nbei/9GIFxv
 atdYBskrU4Dtn2EVEhJQGRqFiQY0ILwk+wowY70XJeqzwfnLN2C9djHsMKLhJBW+lCzS
 rsAO3boETx4qXz7qEOz8FmQZS6ch0YiHX5agXeVEfhNkbjyaGqCNqiQyhXHdF8SS9sCw
 fFP60TLOXIOiXNFyHdl9vvH8LEujkcJkUoT+h0GksnJ/68EyKreV2AoXZuALhkw8EOUM
 vcKQ==
X-Gm-Message-State: AOJu0YwJoaSKv6pO/Oebl9qOfUnz5bhtUqAQFf+6Px5piR7/E8pQOUpx
 oBF9tuU+gNdlugdlxypHixhcFcItj+Ts+7UfsntbtCoim7Xtus81dduIRn0rsoq8UNaor/lpAgF
 8
X-Google-Smtp-Source: AGHT+IHcF4KY7aVL5nwTHBXJHzy540jlkOqVExbViaeCBJPW6VuKQKafve6qnc+f+Jfd3i1Trc8r/A==
X-Received: by 2002:a5d:4dc2:0:b0:371:87d4:8f12 with SMTP id
 ffacd0b85a97d-378c2cfc857mr9936964f8f.17.1726582602556; 
 Tue, 17 Sep 2024 07:16:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e72e4c5esm9746366f8f.2.2024.09.17.07.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 07:16:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tests/fp: Make mul and div tests have a longer timeout
Date: Tue, 17 Sep 2024 15:16:41 +0100
Message-Id: <20240917141641.2836265-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

At the moment we run all fp-test tests except for the muladd ones
with the default meson test timeout of 30s. This is plenty for
most of the test cases, but for multiplication and division we
can sometimes hit the timeout if the CI runner is going slow.

Add support to meson.build for a way to override the timeout on
a per test basis, and use it to set the timeout to 60s for
fp-test-rem, fp-test-div and fp-test-mul. We can use this new
generic mechanism also to set the timeout for mulAdd rather
than hardcoding it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
On my local system these tests finish in less than 5 seconds
each, but on the cross-i686-system CI job they can take 5 or 6
times as long. Example:
https://gitlab.com/qemu-project/qemu/-/jobs/7844908223
---
 tests/fp/meson.build | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 114b4b483ea..9059a247521 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -7,6 +7,16 @@ if host_os == 'windows'
   subdir_done()
 endif
 
+# By default tests run with the usual 30s timeout; particularly
+# slow tests can have that overridden here. The keys here are
+# the testnames without their fp-test- prefix.
+slow_fp_tests = {
+  'rem': 60,
+  'div': 60,
+  'mul': 60,
+  'mulAdd': 180,
+}
+
 sfcflags = [
   # softfloat defines
   '-DSOFTFLOAT_ROUND_ODD',
@@ -109,6 +119,7 @@ fptest_rounding_args = ['-r', 'all']
 foreach k, v : softfloat_conv_tests
   test('fp-test-' + k, fptest,
        args: fptest_args + fptest_rounding_args + v.split(),
+       timeout: slow_fp_tests.get(k, 30),
        suite: ['softfloat', 'softfloat-conv'])
 endforeach
 
@@ -116,6 +127,7 @@ foreach k, v : softfloat_tests
   test('fp-test-' + k, fptest,
        args: fptest_args + fptest_rounding_args +
              ['f16_' + k, 'f32_' + k, 'f64_' + k, 'f128_' + k, 'extF80_' + k],
+       timeout: slow_fp_tests.get(k, 30),
        suite: ['softfloat', 'softfloat-' + v])
 endforeach
 
@@ -124,7 +136,8 @@ test('fp-test-mulAdd', fptest,
      # no fptest_rounding_args
      args: fptest_args +
            ['f16_mulAdd', 'f32_mulAdd', 'f64_mulAdd', 'f128_mulAdd'],
-     suite: ['softfloat-slow', 'softfloat-ops-slow', 'slow'], timeout: 180)
+     timeout: slow_fp_tests.get('mulAdd', 30),
+     suite: ['softfloat-slow', 'softfloat-ops-slow', 'slow'])
 
 executable(
   'fp-bench',
@@ -140,4 +153,5 @@ fptestlog2 = executable(
   c_args: fpcflags,
 )
 test('fp-test-log2', fptestlog2,
+     timeout: slow_fp_tests.get('log2', 30),
      suite: ['softfloat', 'softfloat-ops'])
-- 
2.34.1


