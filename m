Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9BAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi78n-0001Qp-Kv; Fri, 10 Jul 2026 05:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wi78m-0001QH-2L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:03:24 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wi78k-0004Pf-E2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:03:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 3030BC0A9C;
 Fri, 10 Jul 2026 12:03:21 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:167::1:39])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id K3H7hF0XHGk0-P2KjQKS3; Fri, 10 Jul 2026 12:03:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783674200;
 bh=y5HOw/pRURtCSTPSTYg91kd3kw+Qf97rHi8QYCK4Xwo=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=buTHyWNO0F92p9cFUNXd2tYtDMLrS3gCkB+bAc5ULwFXBcRln5P2rXfwjuqpdfM+x
 fR4QwzdI1R6cQvzKX3O3+larj8+C5fkVGl5c/xxCsWO7PT5QKbnIEKOLGxvLpUlPEU
 FWsJC0tbktFWrZyFYgqqX8NV9C1hXa1EiJHK01sI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: th.huth+qemu@posteo.eu
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@mailo.com,
 ganeshredcobra@gmail.com, vsementsov@yandex-team.ru
Subject: [PATCH] tests/functional: fix querying available machines
Date: Fri, 10 Jul 2026 12:03:17 +0300
Message-ID: <20260710090317.498350-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Aliases are not handled, and that's why tests used them
are skipped, like this:

    PYTHONPATH=python:tests/functional \
    QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
    MESON_BUILD_ROOT=$PWD/build \
    ./build/pyvenv/bin/python3 tests/functional/x86_64/test_hotplug_blk.py

TAP version 13
ok 1 test_hotplug_blk.HotPlugBlk.test # SKIP no support for machine q35
1..1

Fixes: 0e7aa78b0bee50 ("tests/functional: use QMP to query available machines")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/qemu_test/testcase.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index 4912a47a464..e4179d165c0 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -325,9 +325,12 @@ def set_machine(self, machinename):
                 resp = tmp_vm.qmp('query-machines')
 
                 machines = resp.get('return', [])
-                cls._machines = [
-                    m.get('name') for m in machines if 'name' in m
-                ]
+                cls._machines = []
+                for m in machines:
+                    if 'name' in m:
+                        cls._machines.append(m['name'])
+                    if 'alias' in m:
+                        cls._machines.append(m['alias'])
 
             finally:
                 try:
-- 
2.43.0


