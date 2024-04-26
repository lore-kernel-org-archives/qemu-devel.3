Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B37C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 16:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0OMi-00040b-H0; Fri, 26 Apr 2024 12:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0OMg-0003zW-3r
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0OMe-0006Iv-Dl
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714148635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UVz90FZD6s5k9ZbpKe6NsR6WnIgP4JdWBhqIElSpQtA=;
 b=h/UBOc4MVBsvVY64btNZ/D4hId1OtzzJpktAXvPDejQjdKEz1d14uwY31p9tVVR4vd1rXx
 UTdSaY/h2uA6trlITJk+2BHAZWWj0Un59oF2EeQtLWaw/nhupxuy7uZ08HmDnJToR+i442
 eHtjRDN0KlNlzQHB1sTLrgEx7u9oWu4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-FYseHGGyNt-lhL6GfGtfng-1; Fri,
 26 Apr 2024 12:23:52 -0400
X-MC-Unique: FYseHGGyNt-lhL6GfGtfng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D8211C0515D;
 Fri, 26 Apr 2024 16:23:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFAA71121306;
 Fri, 26 Apr 2024 16:23:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] qga: Re-enable the qga-ssh-test when running without fuzzing
Date: Fri, 26 Apr 2024 18:23:48 +0200
Message-ID: <20240426162348.684143-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

According to the comment in qga/meson.build, the test got disabled
since there were problems with the fuzzing job. But instead of
disabling this test completely, we should still be fine running
it when fuzzing is disabled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/qga/meson.build b/qga/meson.build
index 1c3d2a3d1b..46c1d83d7f 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -181,12 +181,11 @@ test_env = environment()
 test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
 test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
-# disable qga-ssh-test for now. glib's G_TEST_OPTION_ISOLATE_DIRS triggers
+# disable qga-ssh-test with fuzzing: glib's G_TEST_OPTION_ISOLATE_DIRS triggers
 # the leak detector in build-oss-fuzz Gitlab CI test. we should re-enable
 # this when an alternative is implemented or when the underlying glib
 # issue is identified/fix
-#if host_os != 'windows'
-if false
+if host_os != 'windows' and not get_option('fuzzing')
   srcs = [files('commands-posix-ssh.c')]
   i = 0
   foreach output: qga_qapi_outputs
-- 
2.44.0


