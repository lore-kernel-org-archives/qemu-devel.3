Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50924C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6MzD-0000TX-KN; Tue, 15 Sep 2026 02:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1x6MzC-0000T8-23
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:49:46 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1x6MzA-0003yK-LS
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 02:49:45 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4hkXgh26dSz8PbS;
 Tue, 15 Sep 2026 02:49:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=tbXRKZUzA9S1VKs/qJ4uRJ0qKqE0TWHc4lb5tFj9BhQ=; b=PSeT
 0Nf6njZ3q+BWgXE4UQLqMVLfuVY8EYlfynIB+fqXM0bVoCLErNTIOovMagnr86+w
 IhDNveIO/oqcAdcoSG+SJiccR5GNhaewfrdImLT9N8HrXjMwxX+jmsVVCE35ZEqe
 dWxTE9sXb5NgSXUEhdHYGsu/eBtx5/4N8NQW4Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=SzIBf9YaSmscI/auv3pGc2esOMiOE7vMN7RK+h7nDzlLzC1E/59O7
 vA4mlKubVIZ8VThKkmq0FaZ0cZWHHl5ptFwlR+BzxkqOHG3i7GLmBK83vK1ypKW6
 Ow3aYrYZHgumMGBu5Gpj4nnTyH6a3ayb7ikxNdeaItBhWuiG10t6ok=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:73f1:f873:95ea:a09a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4hkXgh012mz8PbR;
 Tue, 15 Sep 2026 02:49:35 -0400 (EDT)
Date: Tue, 15 Sep 2026 02:49:34 -0400
From: Brad Smith <brad@comstyle.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr_ Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang_" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] util/cutils: Use getexecpath() on OpenBSD for
 qemu_init_exec_dir()
Message-ID: <aqjqfifkq8gi0w4Z@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

util/cutils: Use getexecpath() on OpenBSD for qemu_init_exec_dir()

OpenBSD has introduced a function getexecpath() to be
able to retrieve the executable name and path.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 meson.build   | 8 ++++++++
 util/cutils.c | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/meson.build b/meson.build
index cfac634cf1..0e07138b0c 100644
--- a/meson.build
+++ b/meson.build
@@ -3034,6 +3034,14 @@ config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(osdep_prefix + '''
     return hwcap;
   }'''))
 
+config_host_data.set('CONFIG_GETEXECPATH', cc.links(osdep_prefix + '''
+  #include <limits.h>
+  #include <unistd.h>
+  int main(void) {
+    char buf[PATH_MAX];
+    getexecpath(buf, sizeof(buf));
+  }'''))
+
 config_host_data.set('CONFIG_USBFS', have_linux_user and cc.compiles('''
   #include <linux/usbdevice_fs.h>
 
diff --git a/util/cutils.c b/util/cutils.c
index 91ddadfd15..b5d1d13e24 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1091,6 +1091,12 @@ void qemu_init_exec_dir(const char *argv0)
             p = buf;
         }
     }
+#elif defined(__OpenBSD__) && defined(CONFIG_GETEXECPATH)
+    {
+        if (getexecpath(buf, sizeof(buf)) == 0) {
+            p = buf;
+        }
+    }
 #elif defined(__APPLE__)
     {
         char fpath[PATH_MAX];
-- 
2.55.0


