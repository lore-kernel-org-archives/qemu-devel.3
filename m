Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76691CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHwP-0000zc-TA; Thu, 05 Sep 2024 15:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwO-0000ue-JQ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwN-0000Lt-7Q
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725563686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VP6t64O2EZM3EQ4i4deqU37R5Si/b9BDIEtl9t/WZm8=;
 b=PLaaurql41nBqQjmB7jlO1rLJ28HOTdofUfYjf0HMxz8IzH9Iza6sl9PhgrMNKSkcU6YQY
 IjIS1Ib7oc0hhnsR+TGvJKY/3HZxXmBUUis4MQnkT7LUgaqSmdXnqQ0+epFASde7z9ClBt
 ngjM+AdlPY5URSD9OoDqeWuaP93GfRg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-NoOI3yQmMWeDi8ikYYHpTA-1; Thu,
 05 Sep 2024 15:14:42 -0400
X-MC-Unique: NoOI3yQmMWeDi8ikYYHpTA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A94119560B4; Thu,  5 Sep 2024 19:14:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B05C61956048; Thu,  5 Sep 2024 19:14:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] tests/qtest/migration: Add a check for the availability
 of the "pc" machine
Date: Thu,  5 Sep 2024 21:14:27 +0200
Message-ID: <20240905191434.694440-2-thuth@redhat.com>
In-Reply-To: <20240905191434.694440-1-thuth@redhat.com>
References: <20240905191434.694440-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The test_vcpu_dirty_limit is the only test that does not check for the
availability of the machine before starting the test, so it fails when
QEMU has been configured with --without-default-devices. Add a check for
the "pc" machine type to fix it.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 6c06100d91..8fee18dfbe 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -4026,8 +4026,10 @@ int main(int argc, char **argv)
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
-        migration_test_add("/migration/vcpu_dirty_limit",
-                           test_vcpu_dirty_limit);
+        if (qtest_has_machine("pc")) {
+            migration_test_add("/migration/vcpu_dirty_limit",
+                               test_vcpu_dirty_limit);
+        }
     }
 
     ret = g_test_run();
-- 
2.46.0


