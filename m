Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4E0C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx6l-0001DX-4L; Sun, 03 Mar 2024 20:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6j-0001Cj-7g
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6b-0002De-Fe
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Crwhp+L/Y2kx6IfY/lBSTl6+qMBWTiwjHq63n8HYRLQ=;
 b=gsTCvfH7ukZenT4mZe9JlLf5O9ta9UInxFW9KsXoUgvTkabxkyfyaQ4Bpe+bysDGzEoWLW
 8Su2HZld2wgd3cVgbwVfTx+TgjG6S7C9qH22f1LydefJE4NTtiCuc6aN0Vue/vcyf6o0Q/
 KQ0OHhFZAxlxq5/xbIJkHkotFmeVMsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-j3UoXz61MV2TP-zy0DrwaA-1; Sun, 03 Mar 2024 20:26:56 -0500
X-MC-Unique: j3UoXz61MV2TP-zy0DrwaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE2208820C8;
 Mon,  4 Mar 2024 01:26:55 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3CE240C6EBA;
 Mon,  4 Mar 2024 01:26:51 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bryan Zhang <bryan.zhang@BYTEDANCE.COM>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PULL 03/27] tests/migration: Set compression level in migration tests
Date: Mon,  4 Mar 2024 09:26:10 +0800
Message-ID: <20240304012634.95520-4-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bryan Zhang <bryan.zhang@BYTEDANCE.COM>

Adds calls to set compression level for `zstd` and `zlib` migration
tests, just to make sure that the calls work.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Link: https://lore.kernel.org/r/20240301035901.4006936-3-bryan.zhang@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 83512bce85..8c35f3457b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2664,6 +2664,13 @@ static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
 {
+    /*
+     * Overloading this test to also check that set_parameter does not error.
+     * This is also done in the tests for the other compression methods.
+     */
+    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
+    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
+
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
 }
 
@@ -2672,6 +2679,9 @@ static void *
 test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
                                             QTestState *to)
 {
+    migrate_set_parameter_int(from, "multifd-zstd-level", 2);
+    migrate_set_parameter_int(to, "multifd-zstd-level", 2);
+
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
 }
 #endif /* CONFIG_ZSTD */
-- 
2.44.0


