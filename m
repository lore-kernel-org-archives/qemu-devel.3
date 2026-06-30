Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B8AC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weUri-0004yI-Ou; Tue, 30 Jun 2026 05:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1weUrh-0004xm-65; Tue, 30 Jun 2026 05:34:49 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1weUre-0007BB-So; Tue, 30 Jun 2026 05:34:48 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1782812077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jKUOB+29h3MqQZBzry6645csOoH2JVGA8jgaVk4cgi8=;
 b=KZ09fUhgx1hoTJ1IOpgm6GVAhCHWavK8MuEZWNtnpaArPHDEPEQUI4spnLlyAPsoEDPfe1
 7Nr4IDhCS5LuUSknicxxrO23ITFuEQQTfpmHYPJXDnknvUeQ3wZuOrsxMjcfLakAa2vEFo
 j1yPox56hD5po5VAv2JB0Wnhr/cewqE=
To: marcandre.lureau@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] utils/module: fix memleak in module_load()
Date: Tue, 30 Jun 2026 12:33:04 +0300
Message-Id: <20260630093302.688700-1-frolov@swemel.ru>
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

Memmory for version_dir, allocated by g_strdup, is not freed

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 util/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/module.c b/util/module.c
index 09dc43f51e..dbca6bc8be 100644
--- a/util/module.c
+++ b/util/module.c
@@ -243,6 +243,7 @@ int module_load(const char *prefix, const char *name, Error **errp)
                              G_CSET_A_2_Z G_CSET_a_2_z G_CSET_DIGITS "+-.~",
                              '_');
     dirs[n_dirs++] = g_strdup_printf("/var/run/qemu/%s", version_dir);
+    g_free(version_dir);
 #endif
     assert(n_dirs <= ARRAY_SIZE(dirs));
 
-- 
2.34.1


