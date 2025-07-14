Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9727C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHan-0003Dd-Ge; Mon, 14 Jul 2025 07:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6Q-0007BA-QH
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6O-0003TY-UC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QHvlWL83L2yf+5AX4UtVjgNoCLqyCVDOO6MmbVr1kOM=;
 b=Z0o+FD0XlTn6C+caNstw46KXnA5NIokoCk+kLhRV6GuD7p//FwkYZZIGS5W2+wBpxFHD/Q
 xy1X8DAUqnVLeu48OVNwzOXjEsn/SexfWUS5IcLy9BHzjgQURDhZCz5BgFyZtsbJ2pzgHl
 hTLWVJ0JVxhEvZXUYaE2cA8jJpiVTfU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-YiW6FwPxMHKP99knZO_qvw-1; Mon,
 14 Jul 2025 07:12:05 -0400
X-MC-Unique: YiW6FwPxMHKP99knZO_qvw-1
X-Mimecast-MFC-AGG-ID: YiW6FwPxMHKP99knZO_qvw_1752491524
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DBA01956095; Mon, 14 Jul 2025 11:12:04 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 448B518046C6; Mon, 14 Jul 2025 11:12:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PULL 13/13] tpm: "qemu -tpmdev help" should return success
Date: Mon, 14 Jul 2025 15:10:36 +0400
Message-ID: <20250714111039.4150419-14-marcandre.lureau@redhat.com>
In-Reply-To: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Like other "-foo help" CLI, the qemu process should return 0 for
"-tpmdev help".

While touching this, switch to is_help_option() utility function as
suggested by Peter Maydell.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250707101412.2055581-1-marcandre.lureau@redhat.com>
---
 system/tpm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/system/tpm.c b/system/tpm.c
index 8df0f6e72b..903b29c043 100644
--- a/system/tpm.c
+++ b/system/tpm.c
@@ -21,6 +21,7 @@
 #include "system/tpm.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
+#include "qemu/help_option.h"
 
 static QLIST_HEAD(, TPMBackend) tpm_backends =
     QLIST_HEAD_INITIALIZER(tpm_backends);
@@ -179,9 +180,9 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
 {
     QemuOpts *opts;
 
-    if (!strcmp(optstr, "help")) {
+    if (is_help_option(optstr)) {
         tpm_display_backend_drivers();
-        return -1;
+        exit(EXIT_SUCCESS);
     }
     opts = qemu_opts_parse_noisily(opts_list, optstr, true);
     if (!opts) {
-- 
2.50.0


