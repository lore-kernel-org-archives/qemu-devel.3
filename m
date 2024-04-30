Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD63C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgs-0001BQ-6N; Tue, 30 Apr 2024 03:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgp-00013f-64
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgi-0008Qk-Uo
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzmButXz+sBDibCDdMHuvj80UwLwW64bHhmg5e9RJMY=;
 b=AAwXac7FNyfzEHbdVeOOAMc/CBu005tFNtK0m5V9liTAgAD+2/kldvQ7h3SFK9DJNWbCJz
 pA1Riq7uEUKLRuuizw0RQzB5bSO8uRyfr0MrvDpL/0BFC2oh/XDYHB69mw0CNgT+Y6ROB3
 U2CHM/JYtKGf14Zv1TqHBH3iyM5pxrw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-yOsZnpaOPou1cASFHjCTwg-1; Tue, 30 Apr 2024 03:14:02 -0400
X-MC-Unique: yOsZnpaOPou1cASFHjCTwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C17CA182ED64;
 Tue, 30 Apr 2024 07:14:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6313340C6CC0;
 Tue, 30 Apr 2024 07:14:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 11/19] qga: Re-enable the qga-ssh-test when running without
 fuzzing
Date: Tue, 30 Apr 2024 09:13:32 +0200
Message-ID: <20240430071340.413305-12-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

Message-ID: <20240426162348.684143-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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


