Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35B9C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDhe-0000a1-Mo; Wed, 28 May 2025 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDhV-0000H7-9n
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDhR-0007QT-Vj
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syN9efIB0hNvD8iCymDl24Tj7OZV+bCEsnzxf8NWRq8=;
 b=ITmfqU2hqIk7mIBxbyEdYWfeHIztR+qjcoX+pO6ZbefGPHwjirAMBbw8i6YNypwaVCajEk
 vzUlmva9RpMQCnaudjnzLtwjVozLNy4O22Gj+cvDv8vBOc/cD8zYOad6kmCP63QyF06eWJ
 xcYF1X/uprPzr7JLPEDM0rT8ZtBnL8s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-29m2Hoe8PBSBrOA6R8DIyA-1; Wed,
 28 May 2025 06:06:45 -0400
X-MC-Unique: 29m2Hoe8PBSBrOA6R8DIyA-1
X-Mimecast-MFC-AGG-ID: 29m2Hoe8PBSBrOA6R8DIyA_1748426805
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F37C41800446; Wed, 28 May 2025 10:06:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C775180049D; Wed, 28 May 2025 10:06:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 27/27] tests/unit/test-util-sockets: fix mem-leak on error
 object
Date: Wed, 28 May 2025 12:05:07 +0200
Message-ID: <20250528100507.313906-28-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>

The test fails with --enable-asan as the error struct is never freed.
In the case where the test expects a success but it fails, let's also
report the error for debugging (it will be freed internally).

Fixes 316e8ee8d6 ("util/qemu-sockets: Refactor inet_parse() to use QemuOpts")

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Message-ID: <518d94c7db20060b2a086cf55ee9bffab992a907.1748280011.git.matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-util-sockets.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 8492f4d68f2..ee66d727c38 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -341,8 +341,12 @@ static void inet_parse_test_helper(const char *str,
     int rc = inet_parse(&addr, str, &error);
 
     if (success) {
+        if (error) {
+            error_report_err(error);
+        }
         g_assert_cmpint(rc, ==, 0);
     } else {
+        error_free(error);
         g_assert_cmpint(rc, <, 0);
     }
     if (exp_addr != NULL) {
-- 
2.49.0


