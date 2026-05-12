Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7F7CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuJS-0007Gx-8r; Tue, 12 May 2026 17:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJA-0006vc-PK; Tue, 12 May 2026 17:06:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJ8-0001M9-J4; Tue, 12 May 2026 17:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=0RIkifSIde5La7mt0eIJIbcUrv4hLCtOK3PGMs8A3bQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kD0lW4WbGkkOVidjzbuEQzqys993F5prvkSu8ryBcsfBs6FMxTtvpI3u6mUj1X9ta
 8v90h88tMojAjgJduuM3J5snTSHFOY2hX14wCquR1Zr2Cu9rF1MrffSBdLeQqtyvZo
 eL2aH2kA4oOUa6AnoZ7VJTOM6ZRP7KWlwy+Mj/U9+fKf2ZqM4ixERBIqdFJUrYoLUu
 z7Jdgqy3t8frqEOajEPs4j4+SpBuS8yZxUdVFDDANC+wrWztsGeZiG6O+0vyngp9oB
 MPzhh929Y/b0EW7r+OVr9AjZTacUgBZQMwuw3/CE9eyfSgtBn5LCqc6knGoMJggOqm
 U6YICMt9l+2Pg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3111D1AA343;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3CF3F3ABCB4;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sergei Heifetz <heifetz@yandex-team.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 007/117] target/i386: fix NULL pointer dereference in
 legacy-cache=off handling
Date: Tue, 12 May 2026 23:53:09 +0300
Message-ID: <20260512205503.361097-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Sergei Heifetz <heifetz@yandex-team.com>

The check that xcc->model is not NULL occurs after it is dereferenced
inside x86_cpu_get_versioned_cache_info(), so something like
`-cpu host,legacy-cache=off` leads to a segfault rather than an error.
This patch fixes that.

Fixes: cca0a000d06f897411a8a ("target/i386: allow versioned CPUs to specify new cache_info")
Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
[Mjt: simplify the following condition too]
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 2741d2cc39033929485b50792a85b5c794b1c903)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 78308a82a0..fca6238f55 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9481,10 +9481,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* Cache information initialization */
     if (!cpu->legacy_cache) {
-        const CPUCaches *cache_info =
-            x86_cpu_get_versioned_cache_info(cpu, xcc->model);
+        const CPUCaches *cache_info = xcc->model
+            ? x86_cpu_get_versioned_cache_info(cpu, xcc->model)
+            : NULL;
 
-        if (!xcc->model || !cache_info) {
+        if (!cache_info) {
             g_autofree char *name = x86_cpu_class_get_model_name(xcc);
             error_setg(errp,
                        "CPU model '%s' doesn't support legacy-cache=off", name);
-- 
2.47.3


