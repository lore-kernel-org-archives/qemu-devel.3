Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A434C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nAD-0005pb-PB; Fri, 03 May 2024 03:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s2nAA-0005ia-47; Fri, 03 May 2024 03:16:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s2nA1-0000ZG-KO; Fri, 03 May 2024 03:16:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6AD2063BB8;
 Fri,  3 May 2024 10:16:52 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8ACCAC5911;
 Fri,  3 May 2024 10:16:41 +0300 (MSK)
Received: (nullmailer pid 841122 invoked by uid 1000);
 Fri, 03 May 2024 07:16:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] Re-enable riscv64-debian-cross-container (debian riscv64
 is finally usable again!)
Date: Fri,  3 May 2024 10:16:34 +0300
Message-Id: <20240503071634.841103-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Revert "gitlab-ci: Disable the riscv64-debian-cross-container by default"
This reverts commit f51f90c65ed7706c3c4f7a889ce3d6b7ab75ef6a.

riscv64 in debian has been non-functioning for almost a year, after the
architecture has been promoted to release architecture and all binary
packages started to be re-built, making the port not multi-arch-co-installable
for a long time (in debian, multi-arch packages must be of the same version,
but when a package is rebuilt on one architecture it gets a version bump too).
Later on, debiah had a long time64_t transition which made sid unusable for
quite some time too.  Both such events happens in debian very rarely (like,
once in 10 years or so - for example, previous big transition like that was
libc5 => libc6 transition).  Now both of these are finished (where qemu is
concerned anyway).

Hopefully debian unstable wont be very unstable.  At the very least it is
better to have sporadic CI failures here than no riscv64 coverage at all.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
v2: drop a TODO comment which turned out to be confused, replacing it
 with the description why debian riscv64 were unusable.

 .gitlab-ci.d/container-cross.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index e3103940a0..dbffed3f21 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -77,7 +77,6 @@ riscv64-debian-cross-container:
   allow_failure: true
   variables:
     NAME: debian-riscv64-cross
-    QEMU_JOB_OPTIONAL: 1
 
 s390x-debian-cross-container:
   extends: .container_job_template
-- 
2.39.2


