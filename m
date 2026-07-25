Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89038C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnaMK-0007Wc-Ps; Sat, 25 Jul 2026 07:16:00 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7858dbb36710edbb9697286a925e170effd9e879@kylie.crudebyte.com>)
 id 1wnaLu-0007UB-Mj; Sat, 25 Jul 2026 07:15:39 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7858dbb36710edbb9697286a925e170effd9e879@kylie.crudebyte.com>)
 id 1wnaLt-0006QN-AV; Sat, 25 Jul 2026 07:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:References:In-Reply-To:Message-ID:Content-ID:
 Content-Description; bh=ocN9gDF8tOmwWU30iewV33ObeDD+0wz46l7gqvW+7uw=; b=LzFYH
 1hCIuuXloM/eL9W0zCl9h/nAvcJDrWDA+pjtNf4D4Wrh54EhvhRLohv2QkeLB3+Piiy1StHS/IK+s
 wtIxVsMuKXl5B/Zw2ADmU3d5rs/7pBb65C/aSyDJ+ghVBuc4RbxDH+vqF4ZGgcb9gbIE+J4V1TkTu
 QlaQQBS1o7GCCx4E5S398OYyAVoHIAyZwe9GbYve5xrO+Dr2OU+deD3nS1zWXHFi6kFgSdqglblCU
 p/bjGAZacAZfIp0aFprDSwePhnXrT2UXUeYIc8BT8ZlV+B6vFXUHrMH6QAqKRLGAaZOKMK60tsoXE
 RM1kYRuLksxOHGpdzm3VygXkleX2gy+2DFbHfTOZHhnv5OQDTvj/Xm42mmUXVj91Tj6NjMQGTojTu
 gXBZ4+pVJ4Mm/QcPRubRikg5vI211/ETjR/0UzV0AQGuyaiYL6tjpODiBo8oy1Uax2xhdBpPSzogG
 5bohydPPhH18xwUsI1r23hnSsUHsAHYemxIrzjabqK4F9KU7HNramZXVw87dHCCl2kXfYod0OYLuk
 jIyo+UVlqUs7UBionmuZTdZa73xL+JvbvSlJCRwESzfZHv1xESPrpofoU8QVf1Z/OMKLg1Fd+mzFs
 xj7xuejyHX1bBuqWYNuhvjQp4gia55YW7IfxVidn8FgqDdtERsJ9kRZ+zVngeo=;
Message-ID: <7858dbb36710edbb9697286a925e170effd9e879.1784977523.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1784977523.git.qemu_oss@crudebyte.com>
References: <cover.1784977523.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 25 Jul 2026 13:05:24 +0200
Subject: [PULL 1/5] tests/9p: prevent potential error in do_local_xattr_limit()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>,
    Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>,
    Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7858dbb36710edbb9697286a925e170effd9e879@kylie.crudebyte.com;
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
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/E1wfg2F-001Sfn-Rr@kylie.crudebyte.com
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


