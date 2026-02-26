Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396D2FC5903
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVuv-00086A-FQ; Thu, 26 Feb 2026 02:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vvVut-00080r-49
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:36:11 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vvVuq-0002KT-SJ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:36:10 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4AAE1C01EF;
 Thu, 26 Feb 2026 10:36:03 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:119::1:2a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2acfNH0AwSw0-oLHsyiWN; Thu, 26 Feb 2026 10:36:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772091362;
 bh=psix6Xr6MG+z++Jt65LGFK1obb11/0Km4LD48l/iAlM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=WbSghCk9npMavcelojbWZLDnHRJro2plO3ZsPKVRTX60b7ENACZMeLhINbYlLqc6v
 QDMgnfd5u0Z0DMMcwmWfimEcJkm+kkbHjifG7+XyRCkBx2B4/5dANzY9nGh+Y5rZ2I
 p2xFLrZ5auqwmIh/+E9bDO7pPlfNP8EAMEVz92oQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: pbonzini@redhat.com
Cc: berrange@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC PATCH] system: make all FDs coming from -add-fd blocking
Date: Thu, 26 Feb 2026 10:35:57 +0300
Message-ID: <20260226073600.1553667-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We already do that for any FD, coming from qio-channel
(except when QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING is set,
see qio_channel_handle_fds()), and therefore for all FDs coming
from qmp add-fd command.

Let -add-fd option behave the same way.

This fixes at least several places, where code is unprepared
to non-blocking FDs:

- util/oslib-posix.c: qemu_write_pidfile()

Uses qemu_write_full(), unprepared to non-blocking.

- hw/uefi/var-service-json.c: uefi_vars_json_init()

Use write() and don't handle EAGAIN: unprepared for non-blocking.

- dump/dump.c: qmp_dump_guest_memory()

Use qemu_write_full() - unprepared

- chardev/char.c: logfd

Use qemu_write_full() - unprepared

- block/file-posix.c: raw_co_create()

May use write() and not handle EAGAIN during raw_regular_truncate() -
unprepared.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Hi all.

That's as an answer to Daniel's comment at

  Re: [PATCH v3 1/3] char: qemu_chr_write_log() use qemu_write_full()
  https://lore.kernel.org/qemu-devel/aZ8csNV0DAHxK7uh@redhat.com/

Marked as RFC, because that may be considered a breaking change, I'm
not sure should we care about it here.

If the patch is OK, and we want it, add

  Suggested-by: Daniel P. Berrangé <berrange@redhat.com>

tag.

 system/vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 3e341142a0c..edfdd4051f1 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -622,6 +622,10 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
         return -1;
     }
 
+    if (!qemu_set_blocking(dupfd, true, errp)) {
+        return -1;
+    }
+
     /* add the duplicate fd, and optionally the opaque string, to the fd set */
     fdinfo = monitor_fdset_add_fd(dupfd, true, fdset_id, fd_opaque,
                                   &error_abort);
-- 
2.52.0


