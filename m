Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB2C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapK-00046b-SL; Tue, 02 Jul 2024 06:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapH-00045G-FW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapF-00073o-GA
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7A/I+wCPgV2xnskxgg6ZJcwzn6CrSqHFr9xSr85Rrzo=;
 b=UwL6CgWqCgNM+t2M10RrAH5je+RR1qI0RLKvhm/lOQyrvSa9Ac27MOD9jiswq037/qdLgR
 2MX+HE3MkmN9vVkLxsBpS3TjUnPqYHto7juiR4kPsEWRQ8vXmpN1X/g06I8hJCJ7T76IKC
 Txka4e+OuIOliRHLftcAXvbb78uHeEg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-A0Uryo9MOGCJcionAjqbeQ-1; Tue,
 02 Jul 2024 06:33:21 -0400
X-MC-Unique: A0Uryo9MOGCJcionAjqbeQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00C86195609D; Tue,  2 Jul 2024 10:33:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3470419560AA; Tue,  2 Jul 2024 10:33:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 02/12] tests/qtest/migration-test: enable on s390x with TCG
Date: Tue,  2 Jul 2024 12:33:00 +0200
Message-ID: <20240702103310.347201-3-thuth@redhat.com>
In-Reply-To: <20240702103310.347201-1-thuth@redhat.com>
References: <20240702103310.347201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

s390x with TCG is more stable now. Enable it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20240525131241.378473-3-npiggin@gmail.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
[thuth: Added "with TCG" to the commit message]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 571fc1334c..70b606b888 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3823,16 +3823,6 @@ int main(int argc, char **argv)
                        test_vmstate_checker_script);
 #endif
 
-    /*
-     * On s390x with TCG, migration is observed to hang due to the 'pending'
-     * state of the flic interrupt controller not being migrated or
-     * reconstructed post-migration. Disable it until the problem is resolved.
-     */
-    if (g_str_equal(arch, "s390x") && !has_kvm) {
-        g_test_message("Skipping tests: s390x host with KVM is required");
-        goto test_add_done;
-    }
-
     if (is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
                            test_precopy_unix_suspend_live);
@@ -4036,8 +4026,6 @@ int main(int argc, char **argv)
                            test_vcpu_dirty_limit);
     }
 
-test_add_done:
-
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
2.45.2


