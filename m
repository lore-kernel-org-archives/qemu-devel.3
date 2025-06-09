Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C19C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 21:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOk12-0008W5-NE; Mon, 09 Jun 2025 17:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk10-0008VH-H4; Mon, 09 Jun 2025 17:26:46 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1uOk0y-0007cv-JE; Mon, 09 Jun 2025 17:26:46 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:722f:0:640:94d5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6EE5160D1F;
 Tue, 10 Jun 2025 00:26:39 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown
 [2a02:6bf:8080:771::1:29])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VQpuLN5FZuQ0-3pEjaOjQ; Tue, 10 Jun 2025 00:26:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1749504398;
 bh=5VDdX1+CXoGoDVkamcHLdIIp3cFcyu/I2JX/RxOyNtM=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=J1VygFyaHZ8dnz3P1U63BV7EqEkVTlI/xbScVABcmpSxLNWuS4TGouGKE5Gr8jGnj
 J+30ihi6HfFhx9mfcqa8KGw8nLSf1e6vHQWst8nXT6zSyGnNpKoFGkimzW5PQQIWgw
 FnF1rbylR3wkOk/vGPzf3uQxCwa7nksxOJp1g2so=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 1/3] softmmu/runstate: add a way to detect force shutdowns
Date: Tue, 10 Jun 2025 00:25:45 +0300
Message-Id: <20250609212547.2859224-2-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
References: <20250609212547.2859224-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

This can be useful for devices that might take too long to shut down
gracefully, but may have a way to shutdown quickly otherwise if needed
or explicitly requested by a force shutdown.

For now we only consider SIGTERM or the QMP quit() command a force
shutdown, since those bypass the guest entirely and are equivalent to
pulling the power plug.

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 include/system/runstate.h |  1 +
 system/runstate.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index fdd5c4a517..b406a3960e 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -107,6 +107,7 @@ void qemu_system_vmstop_request(RunState reason);
 void qemu_system_vmstop_request_prepare(void);
 bool qemu_vmstop_requested(RunState *r);
 ShutdownCause qemu_shutdown_requested_get(void);
+bool qemu_force_shutdown_requested(void);
 ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
diff --git a/system/runstate.c b/system/runstate.c
index 38900c935a..e18eb8cb0c 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -437,6 +437,7 @@ static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
 static int shutdown_exit_code = EXIT_SUCCESS;
 static int shutdown_signal;
+static bool force_shutdown;
 static pid_t shutdown_pid;
 static int powerdown_requested;
 static int debug_requested;
@@ -457,6 +458,11 @@ ShutdownCause qemu_shutdown_requested_get(void)
     return shutdown_requested;
 }
 
+bool qemu_force_shutdown_requested(void)
+{
+    return force_shutdown;
+}
+
 ShutdownCause qemu_reset_requested_get(void)
 {
     return reset_requested;
@@ -805,6 +811,7 @@ void qemu_system_killed(int signal, pid_t pid)
      * we are in a signal handler.
      */
     shutdown_requested = SHUTDOWN_CAUSE_HOST_SIGNAL;
+    force_shutdown = true;
     qemu_notify_event();
 }
 
@@ -820,6 +827,9 @@ void qemu_system_shutdown_request(ShutdownCause reason)
     trace_qemu_system_shutdown_request(reason);
     replay_shutdown_request(reason);
     shutdown_requested = reason;
+    if (reason == SHUTDOWN_CAUSE_HOST_QMP_QUIT) {
+        force_shutdown = true;
+    }
     qemu_notify_event();
 }
 
-- 
2.34.1


