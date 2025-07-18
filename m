Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010FDC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uclBP-0004aJ-6M; Fri, 18 Jul 2025 09:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uclBM-0004X5-Og
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uclBK-00045N-9I
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752845477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mJznBc4LyHw9waGHXIVuhEmA6x0JI1XLV4RQY1csEPk=;
 b=dcdEXMDnSvtHU54VT64cB5t1FISNENgTsAi8bNIUCrKV0sh4zdlBkFFg2IxLl8NvTZBi8i
 iEX7Rz2dw1/o0QFCF2cpB8+Vz3RzJsB59HfpN5O8p/mCSI8qN9+xtvyA0xJ0GYv9y56lmO
 3i7BgpuKpDJVlO+NVhfW6ysIn40Jx4w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-R6PH1S52O9C_Fmbg2j7p3w-1; Fri,
 18 Jul 2025 09:31:16 -0400
X-MC-Unique: R6PH1S52O9C_Fmbg2j7p3w-1
X-Mimecast-MFC-AGG-ID: R6PH1S52O9C_Fmbg2j7p3w_1752845475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 221B9195FDD9; Fri, 18 Jul 2025 13:31:15 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7769D1801723; Fri, 18 Jul 2025 13:31:12 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] net/passt: Fix build failure due to missing GIO dependency
Date: Fri, 18 Jul 2025 15:31:10 +0200
Message-ID: <20250718133110.1510978-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The passt networking backend uses functions from the GIO library,
such as g_subprocess_launcher_new(), to manage its daemon process.
So, building with passt enabled requires GIO to be available.

If we enable passt and disable gio the build fails during linkage with
undefined reference errors:

  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
  net/passt.c:250: undefined reference to `g_subprocess_launcher_new'
  /usr/bin/ld: net/passt.c:251: undefined reference to `g_subprocess_launcher_take_fd'
  /usr/bin/ld: net/passt.c:253: undefined reference to `g_subprocess_launcher_spawnv'
  /usr/bin/ld: net/passt.c:256: undefined reference to `g_object_unref'
  /usr/bin/ld: net/passt.c:263: undefined reference to `g_subprocess_wait'
  /usr/bin/ld: net/passt.c:268: undefined reference to `g_subprocess_get_if_exited'
  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `glib_autoptr_clear_GSubprocess':
  /usr/include/glib-2.0/gio/gio-autocleanups.h:132: undefined reference to `g_object_unref'
  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
  net/passt.c:269: undefined reference to `g_subprocess_get_exit_status'

Fix this by adding an explicit weson dependency on GIO for the passt
option.
The existing dependency on linux is kept because passt is only available
on this OS.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index c2bc3eeedce9..5842dd026a6f 100644
--- a/meson.build
+++ b/meson.build
@@ -1287,6 +1287,7 @@ endif
 
 enable_passt = get_option('passt') \
   .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
+  .require(gio.found(), error_message: 'passt requires gio') \
   .allowed()
 
 vde = not_found
-- 
2.49.0


