Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D947C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIw4-0006yc-LI; Tue, 06 Feb 2024 05:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIw3-0006xt-3Q
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIw1-0003GP-Fu
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pYJ3aaiSLgzPt2lN2pk4fFmaJwdxRaFlbrLsXg2o9BQ=;
 b=R/xgE3SbmlcOzgub3zU5zX3zgkk3MlDCd0VTfUpGWoPyV10ggyph7QfH9x/4p17WceCGfT
 Qp2s3nTLBr4bR/w7dVdJWv3nV8SQ/zJffc/B9BFTRhSIP8v5afTVd+abp8OVmuusQbzHed
 Sz163Hc32esJETLEHUVWdDcP4srV7Qo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-sPvofmW8OkC9tk_PbtxGbg-1; Tue, 06 Feb 2024 05:44:11 -0500
X-MC-Unique: sPvofmW8OkC9tk_PbtxGbg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C044E862DC0;
 Tue,  6 Feb 2024 10:44:10 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD96B492BF0;
 Tue,  6 Feb 2024 10:44:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 12/12] meson: Link with libinotify on FreeBSD
Date: Tue,  6 Feb 2024 11:43:47 +0100
Message-ID: <20240206104347.238825-13-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
References: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

make vm-build-freebsd fails with:

    ld: error: undefined symbol: inotify_init1
    >>> referenced by filemonitor-inotify.c:183 (../src/util/filemonitor-inotify.c:183)
    >>>               util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive libqemuutil.a

On FreeBSD the inotify functions are defined in libinotify.so. Add it
to the dependencies.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240206002344.12372-5-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build      | 23 +++++++++++++++++++----
 util/meson.build |  6 +++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index b5d6dc94a8..e5d6f2d057 100644
--- a/meson.build
+++ b/meson.build
@@ -2384,6 +2384,22 @@ else
 endif
 config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
 
+have_inotify_init = cc.has_header_symbol('sys/inotify.h', 'inotify_init')
+have_inotify_init1 = cc.has_header_symbol('sys/inotify.h', 'inotify_init1')
+inotify = not_found
+if (have_inotify_init or have_inotify_init1) and host_os == 'freebsd'
+  # libinotify-kqueue
+  inotify = cc.find_library('inotify')
+  if have_inotify_init
+    have_inotify_init = inotify.found()
+  endif
+  if have_inotify_init1
+    have_inotify_init1 = inotify.found()
+  endif
+endif
+config_host_data.set('CONFIG_INOTIFY', have_inotify_init)
+config_host_data.set('CONFIG_INOTIFY1', have_inotify_init1)
+
 # has_header_symbol
 config_host_data.set('CONFIG_BLKZONED',
                      cc.has_header_symbol('linux/blkzoned.h', 'BLKOPENZONE'))
@@ -2400,10 +2416,6 @@ config_host_data.set('CONFIG_FIEMAP',
 config_host_data.set('CONFIG_GETRANDOM',
                      cc.has_function('getrandom') and
                      cc.has_header_symbol('sys/random.h', 'GRND_NONBLOCK'))
-config_host_data.set('CONFIG_INOTIFY',
-                     cc.has_header_symbol('sys/inotify.h', 'inotify_init'))
-config_host_data.set('CONFIG_INOTIFY1',
-                     cc.has_header_symbol('sys/inotify.h', 'inotify_init1'))
 config_host_data.set('CONFIG_PRCTL_PR_SET_TIMERSLACK',
                      cc.has_header_symbol('sys/prctl.h', 'PR_SET_TIMERSLACK'))
 config_host_data.set('CONFIG_RTNETLINK',
@@ -4407,6 +4419,9 @@ summary_info += {'libudev':           libudev}
 summary_info += {'FUSE lseek':        fuse_lseek.found()}
 summary_info += {'selinux':           selinux}
 summary_info += {'libdw':             libdw}
+if host_os == 'freebsd'
+  summary_info += {'libinotify-kqueue': inotify}
+endif
 summary(summary_info, bool_yn: true, section: 'Dependencies')
 
 if host_arch == 'unknown'
diff --git a/util/meson.build b/util/meson.build
index af3bf5692d..0ef9886be0 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -104,7 +104,11 @@ if have_block
   util_ss.add(files('throttle.c'))
   util_ss.add(files('timed-average.c'))
   if config_host_data.get('CONFIG_INOTIFY1')
-    util_ss.add(files('filemonitor-inotify.c'))
+    freebsd_dep = []
+    if host_os == 'freebsd'
+      freebsd_dep = inotify
+    endif
+    util_ss.add(files('filemonitor-inotify.c'), freebsd_dep)
   else
     util_ss.add(files('filemonitor-stub.c'))
   endif
-- 
2.43.0


