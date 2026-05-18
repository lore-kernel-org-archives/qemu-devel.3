Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0CCCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwPV-0003gK-P0; Mon, 18 May 2026 07:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wOwPU-0003e6-SB
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wOwPT-0002LI-Da
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779104722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BeP7MqfAFIImF5aeolAeS2ZR22BLSSc3zOo7u4TV5aM=;
 b=IRkhcfIJiu1W4wRPHz+493jeo4esUJ4FxvpfDQEZ/KPAWD818sEP8Nrj2MSPti9WlPABpO
 p2L0m107A2jIJSSp+1FJslEPeRJeMHlMSdbn6A0e/qYG+W15J2QQ0gyJTy/+NeFDkqsIDD
 HPe1micImQStwsSBhMROB7swGm9DwwE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-y1Kl0RImM8K2TNdEGYwAbA-1; Mon,
 18 May 2026 07:45:19 -0400
X-MC-Unique: y1Kl0RImM8K2TNdEGYwAbA-1
X-Mimecast-MFC-AGG-ID: y1Kl0RImM8K2TNdEGYwAbA_1779104718
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C61E618005B4; Mon, 18 May 2026 11:45:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp
 (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C07681800370; Mon, 18 May 2026 11:45:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, f.ebner@proxmox.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] system/vl: Free allocate memory for pid file name in case
 realpath() failed
Date: Mon, 18 May 2026 13:45:14 +0200
Message-ID: <20260518114514.684401-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

In case realpath() fails, the code returns early in the function
qemu_maybe_daemonize(), without freeing the allocated memory. Add
a g_free() here to fix it.
And while we're at it, also free the memory in the qemu_unlink_pidfile()
function - it's not that important since QEMU is going to terminate anyway,
but some malloc sanitizers might still complain if we don't free it.

Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Free memory in qemu_unlink_pidfile(), too

 system/vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index d2f4044e5d8..a31b7f87230 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1633,6 +1633,8 @@ static void qemu_unlink_pidfile(Notifier *n, void *data)
 
     upn = DO_UPCAST(struct UnlinkPidfileNotifier, notifier, n);
     unlink(upn->pid_file_realpath);
+    g_free(upn->pid_file_realpath);
+    upn->pid_file_realpath = NULL;
 }
 
 static const QEMUOption *lookup_opt(int argc, char **argv,
@@ -2670,6 +2672,7 @@ static void qemu_maybe_daemonize(const char *pid_file)
                 warn_report("not removing PID file on exit: cannot resolve PID "
                             "file path: %s: %s", pid_file, strerror(errno));
             }
+            g_free(pid_file_realpath);
             return;
         }
 
-- 
2.54.0


