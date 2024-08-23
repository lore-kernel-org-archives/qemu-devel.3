Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A67C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 14:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shV61-0002xq-S1; Fri, 23 Aug 2024 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1shV57-00021z-5W; Fri, 23 Aug 2024 10:16:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1shV55-0004Hn-5Z; Fri, 23 Aug 2024 10:16:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F106787EC4;
 Fri, 23 Aug 2024 17:14:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9EA8B12B0F7;
 Fri, 23 Aug 2024 17:15:42 +0300 (MSK)
Received: (nullmailer pid 1411621 invoked by uid 1000);
 Fri, 23 Aug 2024 14:15:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/3] system/vl.c: Print machine name, not "(null)",
 for unknown machine types
Date: Fri, 23 Aug 2024 17:15:41 +0300
Message-Id: <20240823141542.1411594-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823141542.1411594-1-mjt@tls.msk.ru>
References: <20240823141542.1411594-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 412d294ffdc we tried to improve the error message printed when
the machine type is unknown, but we used the wrong variable, resulting in:

$ ./build/x86/qemu-system-aarch64 -M bang
qemu-system-aarch64: unsupported machine type: "(null)"
Use -machine help to list supported machines

Use the right variable, so we produce more helpful output:

$ ./build/x86/qemu-system-aarch64 -M bang
qemu-system-aarch64: unsupported machine type: "bang"
Use -machine help to list supported machines

Note that we must move the qdict_del() to below the error_setg(),
because machine_type points into the value of that qdict entry,
and deleting it will make the pointer invalid.

Cc: qemu-stable@nongnu.org
Fixes: 412d294ffdc ("vl.c: select_machine(): add selected machine type to error message")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 system/vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 41d53d2456..01b8b8e77a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1679,10 +1679,10 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
 
     if (machine_type) {
         machine_class = find_machine(machine_type, machines);
-        qdict_del(qdict, "type");
         if (!machine_class) {
-            error_setg(errp, "unsupported machine type: \"%s\"", optarg);
+            error_setg(errp, "unsupported machine type: \"%s\"", machine_type);
         }
+        qdict_del(qdict, "type");
     } else {
         machine_class = find_default_machine(machines);
         if (!machine_class) {
-- 
2.39.2


