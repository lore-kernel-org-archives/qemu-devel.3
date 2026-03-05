Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5DBEEF305
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy1pD-0000i1-Te; Thu, 05 Mar 2026 01:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vy1pC-0000ho-5s; Thu, 05 Mar 2026 01:04:42 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vy1p9-0000Mx-Qb; Thu, 05 Mar 2026 01:04:41 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id B8CB48081A;
 Thu, 05 Mar 2026 09:04:32 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b90::1:c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id V4iEYE0AveA0-3qDzCfcI; Thu, 05 Mar 2026 09:04:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1772690672;
 bh=oVhnXNBCIx4wu5yUIm9cUEV1V4p2U1hBf2c1Qi+uK9M=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=feLPHhJVDW3uONPSgUTyYijXOIDxXj9vjb4DehFghBqMGwLrP4P9Q9Kn9ioFMtaGx
 BwEqlE4J4ADTAFtFVg8+Ti3H8ndlwGQsli2BY/rKrhDrsVtwD6PHBRXlhCITgRZPB2
 IGGG4GC/XLW6BLlDILw9KNcYBoFMLaAaG//8Ow5Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] target/i386: fix NULL pointer dereference in legacy-cache=off
 handling
Date: Thu,  5 Mar 2026 11:04:31 +0500
Message-Id: <20260305060431.30347-1-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
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

The check that xcc->model is not NULL occurs after it is dereferenced
inside x86_cpu_get_versioned_cache_info(), so something like
`-cpu host,legacy-cache=off` leads to a segfault rather than an error.
This patch fixes that.

Fixes: cca0a000d06f897411a8a ("target/i386: allow versioned CPUs to specify new cache_info")
Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 target/i386/cpu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 01b64940b1..00645e1149 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10023,8 +10023,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     /* Cache information initialization */
     if (!cpu->legacy_cache) {
-        const CPUCaches *cache_info =
-            x86_cpu_get_versioned_cache_info(cpu, xcc->model);
+        const CPUCaches *cache_info = xcc->model
+            ? x86_cpu_get_versioned_cache_info(cpu, xcc->model)
+            : NULL;
 
         if (!xcc->model || !cache_info) {
             g_autofree char *name = x86_cpu_class_get_model_name(xcc);
-- 
2.34.1


