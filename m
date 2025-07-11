Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0730C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaA9f-0001U9-Iw; Fri, 11 Jul 2025 05:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA9D-0000ub-MW
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uaA9A-00079R-QO
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752226461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ouBFunqiWGw+H66woYSQ7t3SshxQYeatQT4/h3zzcxE=;
 b=Z8xuask+d49e5TtoSRmmCKlfICD6jXCBxnOao9S/yLfFKqAgqqIA5qIu0sKbqU/IKPjiTw
 c8Jqk8erttfx+UkuE4dKFT+HbOCNgdsmB+HB/33sfpKQup3HsfsYZURiXiGmRXD9XHVjF6
 NyaqIgrausKhpptLqoDY8xzGoU6x+BA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-z3_d9HfOPo6X8_3MAg2KzA-1; Fri,
 11 Jul 2025 05:34:20 -0400
X-MC-Unique: z3_d9HfOPo6X8_3MAg2KzA-1
X-Mimecast-MFC-AGG-ID: z3_d9HfOPo6X8_3MAg2KzA_1752226460
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97297180120B
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 09:34:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C765195607A; Fri, 11 Jul 2025 09:34:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 11/15] tests/functional: Add dependency to the keymap_targets
Date: Fri, 11 Jul 2025 11:33:36 +0200
Message-ID: <20250711093340.608485-12-thuth@redhat.com>
In-Reply-To: <20250711093340.608485-1-thuth@redhat.com>
References: <20250711093340.608485-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

When doing a "configure" in a an empty build directory, followed by
a "make check" without a normal build in between, the vnc functional
test currently fails since the keymaps have not been built yet.
Thus add a dependency to the keymap_targets here to make sure that
the keymaps are built before running the functional tests.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250701104827.363904-1-thuth@redhat.com>
---
 tests/functional/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 1ae5f02fb37..ae5c52d79fe 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -374,7 +374,7 @@ foreach speed : ['quick', 'thorough']
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
     endif
 
-    test_deps = roms
+    test_deps = [roms, keymap_targets]
     test_env = environment()
     if have_tools
       test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() / 'qemu-img')
-- 
2.50.0


