Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024FEC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiGa-0007yj-CB; Tue, 29 Jul 2025 07:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1ugiG5-0007ab-U7
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:12:41 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1ugiG2-0001Ch-3j
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:12:37 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1753787546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=edsxOrqqYmpU8NByxdSolBv/sKb7nScwnimoebbFkfQ=;
 b=C/I787wv7V7pduEtFZPQ72Ase0OPJ3C1gPmwlofwn+a9KYLl1/7BwwsRiytDMrlTB6kE85
 /o/DxeiX1nUdRAUiJut0RQDI0zscsbfczdOqbHiPfWYiNK+9zvX5EP5F+vakQSwqaCe8nH
 Hk834ShhDJZHa50ezHqrBd64flzgT2s=
To: jcmvbkbc@gmail.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] target/xtensa: Replace malloc() with g_strdup_printf()
Date: Tue, 29 Jul 2025 14:11:44 +0300
Message-Id: <20250729111143.1011889-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

malloc() return value is used without a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 target/xtensa/translate.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 34ae2f4e16..42ef8d3eb9 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -112,13 +112,8 @@ void xtensa_collect_sr_names(const XtensaConfig *config)
 
             if (*pname) {
                 if (strstr(*pname, name) == NULL) {
-                    char *new_name =
-                        malloc(strlen(*pname) + strlen(name) + 2);
-
-                    strcpy(new_name, *pname);
-                    strcat(new_name, "/");
-                    strcat(new_name, name);
-                    free(*pname);
+                    char *new_name = g_strdup_printf("%s/%s", *pname, name);
+                    g_free(*pname);
                     *pname = new_name;
                 }
             } else {
-- 
2.34.1


