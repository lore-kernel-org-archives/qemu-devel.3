Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C8AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfg2O-0000HZ-5p; Fri, 03 Jul 2026 11:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d6b574cdf4e54ff8a09597962e24ad93f49fbe63@kylie.crudebyte.com>)
 id 1wfg2L-0000Gd-UO; Fri, 03 Jul 2026 11:42:42 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d6b574cdf4e54ff8a09597962e24ad93f49fbe63@kylie.crudebyte.com>)
 id 1wfg2K-0006JP-Gi; Fri, 03 Jul 2026 11:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=NnOvdRSiuet1q5N7DIxEuo5GXtmoQ3X/Bii1/D5YOj4=; b=E8TgH
 A+tazWCXrdlY7ez/hNWkyBc+xC4v/LHcUY6+wjHAzV2YVhELmliy6YKN/Is4vMXNJPmvuRqrAjoyr
 Tz9FESsYK/4Y8EqHrlc2rEyLdpeHNuBzyZv7V/Gy4WL/2G3ZbgL7YAgY8rVC/fiKwQgbso11waTZL
 CM1AlWsl0x6MphiCaByEYzRARCpPr68qtiL+4AaTazzSf247ABrnMqasbQxSjbvp+7wrDDRH7XfjS
 sipqFu+IKGKNQGq2m2Lg5IZ73nUfqiIyFr+dqhVlISAGa9+xb5u89sfTb0DYtDBEoF5pv+LXHlFo9
 KS4iI7Xk0MrlM7sBrk3ld27tADg5x0KtBBx6n6YSjBt7/QX3CCjry5AAc+19+APeQBQFyWnOX2wKO
 yPeqwUk0uiFyrNW4UTJb9GgQBEJcHjrh99x69iCHLaKmplbvPIzB03F3HgLZPvhvVAA2OIFzjQDRj
 148M+8POFPXyGVh47ZtZ59QMXWHwtOUWYGzYtwz7fkZu8dlucT511pfX/nrcYaakq2g7ZIuMY0VcX
 f6MyrqfdJ7g/79DwuCu4BDlvkAV+E0YXSwdMQR4/LvZ+G63KDbdbA0z2FuCVznnEvAQ2pj302AkKV
 UlfcZU+O8iammIv5Rh8NQqldfloRUs8lXmAn/QQh8RB/J44U9a+eFkOHb519oQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 3 Jul 2026 17:38:10 +0200
Subject: [PATCH] tests/9p: prevent potential error in do_local_xattr_limit()
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Message-Id: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d6b574cdf4e54ff8a09597962e24ad93f49fbe63@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The local fs backend driver tests require that a dummy file is
created on the host side before running the xattr limit tests,
otherwise the test will fail because the file is expected to exist.

The original call of g_file_set_contents() didn't check its
return value, which might cause subsequent test checks to fail,
making it harder to identify the root cause.

Fix this by simply wrapping the call into a g_assert().

Fixes: 04a62cdfe873 ("tests/9p: add 3 xattr FID limit test cases (local fs driver)")
CID: 1660926
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index cfd3c02da4..692a0e8e3f 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -402,7 +402,7 @@ static void do_local_xattr_limit(QVirtio9P *v9p, int max_xattr)
     /*
      * this file must be created for the test to work with the 'local' fs driver
      */
-    g_file_set_contents(test_file, "", 0, NULL);
+    g_assert(g_file_set_contents(test_file, "", 0, NULL));
 
     /* the actual test code shared with the 'synth' fs driver tests */
     do_xattr_limit(v9p, max_xattr, false);
-- 
2.47.3


