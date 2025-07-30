Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA70C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 06:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh0Ed-0004zY-Hu; Wed, 30 Jul 2025 02:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1uh0Cx-0003mr-CT
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:22:36 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1uh0Cu-0001VL-OG
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:22:34 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1753856548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkKS9kEhx+BPNlZYrIgZFq4YlUevKofbCnljE8OrG/s=;
 b=VYmL2/Fy3b4xjlhmjwripvsKNgY5zf9innZxJKPn4ZzFc/SqYPo8KSOZJQ8OjXqflUNyKY
 jgPFV0pN0/MnReThToVbPu+g0WQujVv5iztvqYkE30PhbjDMn2xmLCt2KwdEvwElI6oMdX
 oE7kjQg62JUz2jfzl+1gWRW+rba6P+c=
To: jcmvbkbc@gmail.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH v2] target/xtensa: Replace malloc() with g_strdup_printf()
Date: Wed, 30 Jul 2025 09:21:43 +0300
Message-Id: <20250730062142.1665980-1-frolov@swemel.ru>
In-Reply-To: <CAMo8BfJw_EUUuGT0qVwhfgEi_tLzSmrOdwAip1E08XNZ4XF=6Q@mail.gmail.com>
References: <CAMo8BfJw_EUUuGT0qVwhfgEi_tLzSmrOdwAip1E08XNZ4XF=6Q@mail.gmail.com>
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

v2: Also replaced strdup() with g_strdup()

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 target/xtensa/translate.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 34ae2f4e16..4faa5ae213 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -112,17 +112,12 @@ void xtensa_collect_sr_names(const XtensaConfig *config)
 
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
-                *pname = strdup(name);
+                *pname = g_strdup(name);
             }
         }
     }
-- 
2.34.1


