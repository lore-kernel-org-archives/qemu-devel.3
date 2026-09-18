Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19F9C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWn-0006VP-EQ; Fri, 18 Sep 2026 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWC-0005nM-Q8
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:51 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWB-0007qs-8q
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:48 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so5361545e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741486; x=1790346286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jj3J/kq8IdeZG8tbT+Qxq2YKCC9zfZ6KfN+WX4p5lYs=;
 b=I71F0Nu4f4hs0ZyOzg6p2geS+IhbJut1MIKVauGcSViBWXTeu+LNSRkSB0iMXpCVM5
 hM54zJTsuwpmoVXUVxXGR1z7G7VDF2cCbsUzVT1hWC731GF9/8bl6tmBVwCmXFe2pWRj
 AsgZGZhDnW9UnqOZExlvPbUqlGnYB6Hz/ss/9XMUV/cjfaNxvAVbng5OCiN1N75u/CjE
 ouuC/YWH+KKEB6hPyN3yuCnQiDFnmFis9nN9UxZOzBrOn5NnCX5BwxscBKkeAjMXgjU2
 buxd2u0UsdXU7yArh5KaUX+0JHem9aAYuqzviv9ykVxuaX/iqtEk1pFQ4aIHpfQ+JBOn
 1W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741486; x=1790346286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jj3J/kq8IdeZG8tbT+Qxq2YKCC9zfZ6KfN+WX4p5lYs=;
 b=RQMTI9A4gAsAqTEk1ccEDc41Hr63dU5WeVxlZeTkMZEIUwWVn5WmpNkplmUGbIi4lV
 B6qKT/uk3D4KZ4LouDNHhPzJG/WrvtmmXi34KGtc2s7OEMRi+uDpT7O1DCDFJBGfRH0S
 oa2cuhqzHEVkra9W7BumotZ8t4PkJXDRqBXTZ5Xk4CGK/JD9VgKjvlHhm1HLfrasQKso
 qJUFvtjyt5LmDYM78FYanm/6l8knHHvU9FkySAncc+n5Sh3LA4O6mlOZ8Glvs/PMK0Rm
 HenJJEKQ3cUmb9wRBEj1U5lmhLwrnIQh/BdM4xS1R1qUYN3n7pJKnNH/1Ac055EH2uyz
 Sz+w==
X-Gm-Message-State: AFuF++m63Ke9ye+L//W22OIysr4BEE6iD0O5qlYQsiAeN++LpudQ3Ln5
 QUYsPYcYUR+SdSDHC0tBzBS4dqjoT9SPfGMAgzs/qkR2mL0O3DgLNg7JACCPy2hRrFo=
X-Gm-Gg: AYBFou2LbH/lGNfrJxksJnq1OUpO30KvSHRA/7ff+8OkPAE3qZfgDy+61PxCMTW7MN1
 4i+m+2GPm71g1ZqjjSo7/JaHiotUKbbSlwIAEA7Zm/Fu518b49EHQ6WPh3sv73MwJ7Jz6ouSJgn
 acB82fBy1Aeb7WXRhhZwD8W4a+jMaTnMdd0uVSHW+EsexeU3a0HncZHyabNJLDcZFdaL+TulLo/
 6zQc/tQlsVvrqbLIc0x8rO/TsG/USKa7p7yU2x94nPY5zDEuWYJQws03HBTkhJmcRCNE9N04VjE
 fofaCvfPLYJmVme6GEXoJ1qSe7CqJblQiUp1aTWdfUXn6sruvj9oorKEPTB5UHZ4zPrIuWWQ3TM
 NONE80PU5VLllHyZTuuB7s/AVH2UTvs6ERVHIfo57iyeMBjVycQ3syeAfiy6Bx/j9Psk4QNwQSC
 NuG0KP5GyhyYUKyhWtO1UKYvOLkA5nURdZAZM+TNUI5gm2RHW+EnQ69HW68Y/vCpWW52wUdkBiS
 Jfjs+HyDg==
X-Received: by 2002:a05:600c:5020:b0:49d:726:cc9f with SMTP id
 5b1f17b1804b1-49fc56716f3mr6615075e9.5.1789741485711; 
 Fri, 18 Sep 2026 07:24:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc56aab7csm43854575e9.1.2026.09.18.07.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 892555FC28;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/17] tests/tcg: don't define tests when missing compilers
Date: Fri, 18 Sep 2026 15:24:20 +0100
Message-ID: <20260918142429.336497-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Skip defining the tests if we don't have a compiler to build them.
Otherwise we add a bunch of noise to the reported results. We still do
report when we skip because the compiler doesn't have the features we
need to build.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260917165602.3405537-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 814f2f8cd8c..5819fdf0bf3 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -499,10 +499,14 @@ foreach target, plan: tcg_tests
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
       endif
 
-      test(test_name, env, args: cmd,
-           depends: test_depends,
-           timeout: 120,
-           suite: ['tcg', 'tcg-' + target])
+      # Do not add a skipped test when compiler is missing,
+      # though we still check all tests are correctly defined.
+      if has_cc
+        test(test_name, env, args: cmd,
+             depends: test_depends,
+             timeout: 120,
+             suite: ['tcg', 'tcg-' + target])
+      endif
       added_tests += {test_name: true}
     endforeach
   endforeach
-- 
2.47.3


