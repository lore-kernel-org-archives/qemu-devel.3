Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2B9ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snec4-00062R-2s; Mon, 09 Sep 2024 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snec2-0005yv-7B
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:39:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snec0-0007Xp-EP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:39:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so3973471f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725889163; x=1726493963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AU7vtFer+ddtm7rm6mso4okZVpTjJWSEa61a5z951yQ=;
 b=EkfJr7k55H5NJta5k5Re4HwM3rrPyrkNy46lvvxHXLfs+XqAERNLUj8+3J39RIGDnY
 9MJkTPr+xh7TihHRjCtlnFj2igq7x1VbNtukZCrOSGj0h+Nv7FOojKo8yeuLupltVozs
 C9SR5uFOnHx2kcz4ysgb6rw77O8tszwpGT1RBz/AI+Pnk+EdUmUroSbeYqk3XZt88IrF
 7Zbti/ZGXWYH0Lon5EhkcA7XcivzRkf1JwtuLi90rPXiAcBN5V6KfqnrDhBPRDqVySF/
 JSx5qEAufYj0Lw9riNYQI5ga3OCFZFUWM3w2OMnM8MtymhE6BOnmvqW0lPQAbkUlIAYE
 rrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889163; x=1726493963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AU7vtFer+ddtm7rm6mso4okZVpTjJWSEa61a5z951yQ=;
 b=ELjnK569u4vi9NSTb0MJsSkYQIaIcJW39zyFhE6FoS4K3pH/EmwS7bnOUV+Y3kn/Eq
 yQo7h5ZRKQD9px4FwNp1VapdHi0WdP7CVgZ5S0eD2fY6EOrUT1yU1mYWJ3H2GdFc+d/w
 2JVoDoGEZvitqv7zZz7PzyH7j9Q4OSFNCSRgkfLWygMniDDfeLa+8lCkSEX9PbV6Byk9
 K/AtCGAYihNpCxF9+OjBkPf+obh2kB/zM5h041lgr8wuMJiW3BdfMey9xDt9meD9t7u6
 MllYlc2W62uWwH5Juu1AYlrbqAGWhs5PVj3YfX68dgpMRJ6ziDgsIiigoWySEVJU3xPW
 MbLw==
X-Gm-Message-State: AOJu0Ywyiiyy3yBRIYF61+EEzweKeduUNoWq9GbHhXGkzfbflwuw84nH
 OHfxNV7d2EiltRPVTHt9WGwy1GRmJOEzst6hVa2CvPTvXksPSRQP7mFuojR25o5IczOo758KVnf
 i
X-Google-Smtp-Source: AGHT+IHx32pOChWitWMFbD4+oHE3nBEgssDH6BlSz4sSMBLfKjIPHE9OZ/LnsvmQHqgfNwwfQtEJBg==
X-Received: by 2002:adf:ef43:0:b0:374:d07a:c136 with SMTP id
 ffacd0b85a97d-378922d62bamr5819837f8f.36.1725889162522; 
 Mon, 09 Sep 2024 06:39:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564af1asm6057945f8f.18.2024.09.09.06.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:39:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH] tests/qtest: Don't parallelize migration-test
Date: Mon,  9 Sep 2024 14:39:21 +0100
Message-Id: <20240909133921.1141067-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

The migration-test is a long-running test whose subtests all launch
at least two QEMU processes.  This means that if for example the host
has 4 CPUs then 'make check' defaults to a parallelism of 5, and if
we launch 5 migration-tests in parallel then we will be running 10
QEMU instances on a 4 CPU system.  If the system is not very fast
then the test can spuriously time out because the different tests are
all stealing CPU from each other.  This seems to particularly be a
problem on our S390 CI job and the cross-i686-tci CI job.

Force meson to run migration-test non-parallel, so there is never any
other test running at the same time as it.  This will slow down
overall test execution time somewhat, but hopefully make our CI less
flaky.

The downside is that because each migration-test instance runs for
between 2 and 5 minutes and we run it for five architectures this
significantly increases the runtime.  For an all-architectures build
on my local machine 'make check -j8' goes from

 real    8m19.127s
 user    31m47.534s
 sys     19m42.650s

to

 real    20m31.218s
 user    32m48.712s
 sys     19m52.133s

more than doubling the wallclock runtime.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Also, looking at these figures we spend a *lot* of our overall
'make check' time on migration-test. Do we really need to do
that much for every architecture?

It's unfortunate that meson doesn't let us say "parallel is
OK, but not very parallel". One other approach would be
to have mtest2make say "run tests at half the parallelism that
-jN suggests, rather than at that parallelism", I guess...
---
 tests/qtest/meson.build | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fc852f3d8ba..dbf2b8e2be1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -17,6 +17,21 @@ slow_qtests = {
   'vmgenid-test': 610,
 }
 
+# Tests which override the default of "can run in parallel".
+# Don't use this to work around test bugs which prevent parallelism.
+# Do document why we need to make a particular test serialized.
+# Do be sparing with use of this: tests listed here will not be
+# run in parallel with any other test, not merely not with other
+# instances of themselves.
+#
+# The migration-test's subtests will each kick off two QEMU processes,
+# so allowing multiple migration-tests in parallel can overload the
+# host system and result in intermittent timeouts. So we only want to
+# run one migration-test at once.a
+qtests_parallelism = {
+  'migration-test': false,
+}
+
 qtests_generic = [
   'cdrom-test',
   'device-introspect-test',
@@ -411,6 +426,7 @@ foreach dir : target_dirs
          protocol: 'tap',
          timeout: slow_qtests.get(test, 60),
          priority: slow_qtests.get(test, 60),
+         is_parallel: qtests_parallelism.get(test, true),
          suite: ['qtest', 'qtest-' + target_base])
   endforeach
 endforeach
-- 
2.34.1


