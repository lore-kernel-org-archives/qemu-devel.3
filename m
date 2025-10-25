Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDC5CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChax-0003M0-OI; Sat, 25 Oct 2025 12:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vChau-0003EH-Bp
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:58:20 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vChas-0000oZ-38
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:58:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BE56AC00DC;
 Sat, 25 Oct 2025 19:58:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:538::1:38])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BwdGg31Lu4Y0-4eWh2IVz; Sat, 25 Oct 2025 19:58:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761411493;
 bh=9pw7XN5TTTagie8RWW2BM3lql/1J+DLvQ46WEhT3sTU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=g6qA5Tm7w7o0tedrxHuZ9SwiLlPJno/58zmfDh2UgqJhzFw4eytz3V/artyInoJg3
 horgW2SkFH0kOOo9i8xOlwMC4Dnpe+oxKlPgDyBq0gQYPgpdeqjVL+TF4JuMG6107z
 RSL6joGkB6eQI97QPsXwwYEke0Yt5AJ/TORrXSR8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: thuth@redhat.com
Cc: philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru
Subject: [PATCH 1/2] tests/functional/.../testcase.py: better socketdir cleanup
Date: Sat, 25 Oct 2025 19:58:03 +0300
Message-ID: <20251025165809.930670-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251025165809.930670-1-vsementsov@yandex-team.ru>
References: <20251025165809.930670-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

TemporaryDirectory prefer explicit call to .cleanup() (or
use context manager). Otherwise it may produce a warning like:

   /usr/lib/python3.10/tempfile.py:1008: \
     ResourceWarning: Implicitly cleaning up \
     <TemporaryDirectory '/tmp/qemu_func_test_sock_4esmf5ba'>

Currently, the only test using socket_dir() is
tests/functional/x86_64/test_vfio_user_client.py, and it does
print this warning, at least with python 3.10.12. With this commit,
the warning disappears.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/qemu_test/testcase.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 2c0abde395..a122acb560 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -233,7 +233,7 @@ def tearDown(self):
         if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
             shutil.rmtree(self.workdir)
         if self.socketdir is not None:
-            shutil.rmtree(self.socketdir.name)
+            self.socketdir.cleanup()
             self.socketdir = None
         self.machinelog.removeHandler(self._log_fh)
         self.log.removeHandler(self._log_fh)
-- 
2.48.1


