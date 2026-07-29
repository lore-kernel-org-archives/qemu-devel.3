Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B1FC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp0dp-00058E-0v; Wed, 29 Jul 2026 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dn-00057G-N7
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:55 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp0dj-0007ki-TP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 05:31:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 46540C0A30;
 Wed, 29 Jul 2026 12:31:49 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id kVacraKWFGk0-uDo1mEko; Wed, 29 Jul 2026 12:31:48 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785317508;
 bh=A4ebB8HLDseDR8vfsLUWnp1Ldex+8n1ox5y/Vnz21xI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Kmeal9Z52ZyP/6uO1oASs/MV+sBFfXZwftaKAITkfTPh7dpCX7jKw+PuDtNoS4ynu
 NvNEKtehMYpWOZK+hg7VWJbHJj09Bvx5/YXpCeaV54OhcH2+0gpjYiKPFfaOteOXd5
 4gWse1QztV/wz9nT2jQ1XuIcXYG3YTXcw6SRTroY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 1/5] python/qemu/machine: add possibility to postpone qmp
 connect
Date: Wed, 29 Jul 2026 12:31:41 +0300
Message-ID: <20260729093146.1893719-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
References: <20260729093146.1893719-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

This is need to test cpr-transfer migration, as on started
target QMP is not available until we call "migrate" on
source.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 python/qemu/machine/machine.py | 53 ++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index bfb59d4c0bf..00154b8591f 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -449,17 +449,17 @@ def _post_shutdown(self) -> None:
         self._user_killed = False
         self._launched = False
 
-    def launch(self) -> None:
+    def launch(self, do_start_process=True, do_qmp_connect=True) -> None:
         """
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
         """
 
-        if self._launched:
+        if self._launched and do_start_process:
             raise QEMUMachineError('VM already launched')
 
         try:
-            self._launch()
+            self._launch(do_start_process, do_qmp_connect)
         except BaseException as exc:
             # We may have launched the process but it may
             # have exited before we could connect via QMP.
@@ -482,31 +482,34 @@ def launch(self) -> None:
             # that exception. However, we still want to clean up.
             raise
 
-    def _launch(self) -> None:
+    def _launch(self, do_start_process=True, do_qmp_connect=True) -> None:
         """
         Launch the VM and establish a QMP connection
         """
-        self._pre_launch()
-        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
-        # Log a simplified, developer-runnable command:
-        # Exclude harness-managed infrastructure args (harness_args)
-        # and wrapper.
-        debug_cmd = [self._binary]
-        debug_cmd.extend(self._console_args(interactive=True))
-        debug_cmd.extend(self._base_args)
-        debug_cmd.extend(self._args)
-        LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
-
-        # Cleaning up of this subprocess is guaranteed by _do_shutdown.
-        # pylint: disable=consider-using-with
-        self._popen = subprocess.Popen(self._qemu_full_args,
-                                       stdin=subprocess.DEVNULL,
-                                       stdout=self._qemu_log_file,
-                                       stderr=subprocess.STDOUT,
-                                       shell=False,
-                                       close_fds=False)
-        self._launched = True
-        self._post_launch()
+        if do_start_process:
+            self._pre_launch()
+            LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
+            # Log a simplified, developer-runnable command:
+            # Exclude harness-managed infrastructure args (harness_args)
+            # and wrapper.
+            debug_cmd = [self._binary]
+            debug_cmd.extend(self._console_args(interactive=True))
+            debug_cmd.extend(self._base_args)
+            debug_cmd.extend(self._args)
+            LOG.debug('Developer-runnable command: %r', ' '.join(debug_cmd))
+
+            # Cleaning up of this subprocess is guaranteed by _do_shutdown.
+            # pylint: disable=consider-using-with
+            self._popen = subprocess.Popen(self._qemu_full_args,
+                                           stdin=subprocess.DEVNULL,
+                                           stdout=self._qemu_log_file,
+                                           stderr=subprocess.STDOUT,
+                                           shell=False,
+                                           close_fds=False)
+            self._launched = True
+
+        if do_qmp_connect:
+            self._post_launch()
 
     def _close_qmp_connection(self) -> None:
         """
-- 
2.43.0


