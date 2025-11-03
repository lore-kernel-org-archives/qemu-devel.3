Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E261CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFulH-0005Gz-M7; Mon, 03 Nov 2025 08:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFulG-0005Fx-7Q
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFul5-0004Mt-FP
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNT92Ugjgpz70btOkgeBKep056c5nqReEHCF/b1wFx4=;
 b=CeUblGrIyUOG+1rEVpKmz85440YrDJvvBzuDpxyVg5A8qG1tFarTGDU7SdnDb8hQFVfJBm
 it9WfqQjI1OrE38JXQaFkTP16bRVhyUIyK+XZrwcfhu+TQSBJo2fddWKT+fmEPVgtHGFtR
 plztubJkiwB9cUVrJYfdx6hvh/ADyy0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-8d4p3hUKONynDrrtXrXigA-1; Mon,
 03 Nov 2025 08:37:54 -0500
X-MC-Unique: 8d4p3hUKONynDrrtXrXigA-1
X-Mimecast-MFC-AGG-ID: 8d4p3hUKONynDrrtXrXigA_1762177073
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F01F195608F; Mon,  3 Nov 2025 13:37:53 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6AFA1800451; Mon,  3 Nov 2025 13:37:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PULL 02/32] tests/qtest: Use exit-with-parent=on in qtest invocations
Date: Mon,  3 Nov 2025 13:36:56 +0000
Message-ID: <20251103133727.423041-3-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard W.M. Jones <rjones@redhat.com>

Previously libqtest.c set PR_SET_PDEATHSIG (or the equivalent on
FreeBSD) after forking the qemu subprocess.  However we can get the
same behaviour now by using the new -run-with exit-with-parent=on
flag, on platforms that support it.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 933d085869..622464e365 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -33,6 +33,7 @@
 #include "qemu/accel.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
+#include "qemu/exit-with-parent.h"
 #include "qemu/sockets.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
@@ -433,24 +434,6 @@ static QTestState *qtest_spawn_qemu(const char *qemu_bin, const char *args,
 #ifndef _WIN32
     pid = fork();
     if (pid == 0) {
-#ifdef __linux__
-        /*
-         * Although we register a ABRT handler to kill off QEMU
-         * when g_assert() triggers, we want an extra safety
-         * net. The QEMU process might be non-functional and
-         * thus not have responded to SIGTERM. The test script
-         * might also have crashed with SEGV, in which case the
-         * cleanup handlers won't ever run.
-         *
-         * This PR_SET_PDEATHSIG setup will ensure any remaining
-         * QEMU will get terminated with SIGKILL in these cases.
-         */
-        prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
-#endif /* __linux__ */
-#ifdef __FreeBSD__
-        int sig = SIGKILL;
-        procctl(P_PID, getpid(), PROC_PDEATHSIG_CTL, &sig);
-#endif /* __FreeBSD__ */
         execlp("/bin/sh", "sh", "-c", command->str, NULL);
         exit(1);
     }
@@ -482,12 +465,15 @@ gchar *qtest_qemu_args(const char *extra_args)
                       "-display none "
                       "-audio none "
                       "%s"
+                      "%s"
                       " -accel qtest",
 
                       tracearg,
                       socket_path,
                       getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
                       qmp_socket_path,
+                      can_exit_with_parent() ?
+                      "-run-with exit-with-parent=on " : "",
                       extra_args ?: "");
 
     return args;
-- 
2.51.1


