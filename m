Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384BFCA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuWqK-0001hw-9L; Fri, 05 Sep 2025 09:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWqG-0001gI-KU
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:51:04 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWq5-0006Xa-03
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:51:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 31FF3C1094;
 Fri, 05 Sep 2025 16:50:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id foiXcl3Gh8c0-ItYgjn4o; Fri, 05 Sep 2025 16:50:46 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757080246;
 bh=xzcdYCb73x3t/fdZEEKsSgOBm4tobZHvOXDAvGXSlv0=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=ouDFlx2Wa2zxYjQtwKTRzMjMjRYdZyl9fOhacMz9TdGZGGSQzPo855d8E4MHCG0LR
 RP7WUbQnOpubVGEvyUUSB+iYkl2SnQNrxRtfFQur2K8U65wYSaSIxbxFnVnSoda0kb
 zz1AfFrnWh7i5S8jeGF/zLoJ5aMa/EJzeXjtSE2M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v3 7/9] tests/functional: exec_command_and_wait_for_pattern:
 add vm arg
Date: Fri,  5 Sep 2025 16:50:37 +0300
Message-ID: <20250905135039.2202924-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Allow to specify non default vm for the command.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/cmd.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index dc5f422b77..28b36a3a54 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -172,7 +172,8 @@ def exec_command(test, command):
     _console_interaction(test, None, None, command + '\r')
 
 def exec_command_and_wait_for_pattern(test, command,
-                                      success_message, failure_message=None):
+                                      success_message, failure_message=None,
+                                      vm=None):
     """
     Send a command to a console (appending CRLF characters), then wait
     for success_message to appear on the console, while logging the.
@@ -184,9 +185,11 @@ def exec_command_and_wait_for_pattern(test, command,
     :param command: the command to send
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
+    :param vm: the VM to use (defaults to test.vm if None)
     """
     assert success_message
-    _console_interaction(test, success_message, failure_message, command + '\r')
+    _console_interaction(test, success_message, failure_message, command + '\r',
+                         vm=vm)
 
 def get_qemu_img(test):
     test.log.debug('Looking for and selecting a qemu-img binary')
-- 
2.48.1


