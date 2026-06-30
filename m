Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076C4C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWIa-0006mN-UA; Tue, 30 Jun 2026 07:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1weWIZ-0006l5-45; Tue, 30 Jun 2026 07:06:39 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1weWIW-0006fl-V7; Tue, 30 Jun 2026 07:06:38 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1782817589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mu/6c4wHi0G+xUgAT0FheR4+3MXs1+siSzfgrImct0M=;
 b=DvoU/wMacPuYltPYGQqryQU5AAakLooMjsuiRyqaO41RLPCFqbhzBtIXHbRlFIqiUzblSP
 MudPydm/6D6bcXX5H3PzJn7G7Wq4mXWdwWpCdR8af4lDFqKZ4QnTYx/hJ7pIAfv/mvYrsj
 U4ollXLq5rRJpHwwCWhRy1Hyks+oc54=
To: marcandre.lureau@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH v2] utils/module: fix memleak in module_load()
Date: Tue, 30 Jun 2026 14:06:02 +0300
Message-Id: <20260630110601.736019-1-frolov@swemel.ru>
In-Reply-To: <CAJ+F1C+cS7c=Mc2GAn-WQ-XmCPU-hQM4JuDFsEkS87q0yTdrNg@mail.gmail.com>
References: <CAJ+F1C+cS7c=Mc2GAn-WQ-XmCPU-hQM4JuDFsEkS87q0yTdrNg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Memory for version_dir, allocated by g_strdup, is not freed

Found by Linux Verification Center (linuxtesting.org) with SVACE.

v1: fix with g_free()
v2: fix with g_autofree

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 util/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 09dc43f51e..8f8e6994f1 100644
--- a/util/module.c
+++ b/util/module.c
@@ -203,7 +203,7 @@ int module_load(const char *prefix, const char *name, Error **errp)
 {
     int rv = -1;
 #ifdef CONFIG_MODULE_UPGRADES
-    char *version_dir;
+    g_autofree char *version_dir = NULL;
 #endif
     const char *search_dir;
     char *dirs[5];
-- 
2.34.1


