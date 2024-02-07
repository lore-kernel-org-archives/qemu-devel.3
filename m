Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89056C48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 00:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXWCg-0008Dp-VL; Tue, 06 Feb 2024 19:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXWCf-0008Dh-O7
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 19:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXWCe-0004Io-6r
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 19:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707267255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6bygG5MqsdkEzafdedmTWbkEPyzVL0XpLrJcticfMWY=;
 b=TT+b29G7ODtVfzP0fWLKL25V1+t1zbUhJwDU/uW7J/M4MlRZQwwaX3soBo4aWqohOxJ85o
 IdXFS8niCW8IsMcczMJuzaP1boqn6/ciW9WdVKLEqMLVub2l0zrkhmcEwvtsC8wc+L+oLu
 mVHCoT6e6VFzqN+iRcUJmxwvdnQsHYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-4RGJDakTNyG8OAr1nVCzaA-1; Tue, 06 Feb 2024 19:54:13 -0500
X-MC-Unique: 4RGJDakTNyG8OAr1nVCzaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C81683722D;
 Wed,  7 Feb 2024 00:54:13 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08E5A1121312;
 Wed,  7 Feb 2024 00:54:09 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2 1/3] tests/migration-test: Stick with gicv3 in aarch64 test
Date: Wed,  7 Feb 2024 08:54:01 +0800
Message-ID: <20240207005403.242235-2-peterx@redhat.com>
In-Reply-To: <20240207005403.242235-1-peterx@redhat.com>
References: <20240207005403.242235-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Xu <peterx@redhat.com>

Recently we introduced cross-binary migration test.  It's always wanted
that migration-test uses stable guest ABI for both QEMU binaries in this
case, so that both QEMU binaries will be compatible on the migration
stream with the cmdline specified.

Switch to a static gic version "3" rather than using version "max", so that
GIC should be stable now across any future QEMU binaries for migration-test.

Here the version can actually be anything as long as the ABI is stable.  We
choose "3" because it's the majority of what we already use in QEMU while
still new enough: "git grep gic-version=3" shows 6 hit, while version 4 has
no direct user yet besides "max".

Note that even with this change, aarch64 won't be able to work yet with
migration cross binary test, but then the only missing piece will be the
stable CPU model.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7675519cfa..8a5bb1752e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -819,7 +819,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
         machine_alias = "virt";
-        machine_opts = "gic-version=max";
+        machine_opts = "gic-version=3";
         arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
-- 
2.43.0


