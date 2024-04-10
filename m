Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFC1CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSNP-0003LJ-FI; Wed, 10 Apr 2024 03:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSN0-0002hk-N9; Wed, 10 Apr 2024 03:27:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSMw-0004ro-DR; Wed, 10 Apr 2024 03:27:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2637B5D6A3;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C00F5B02E3;
 Wed, 10 Apr 2024 10:23:07 +0300 (MSK)
Received: (nullmailer pid 4191802 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
Subject: [Stable-8.2.3 51/87] docs/conf.py: Remove usage of distutils
Date: Wed, 10 Apr 2024 10:22:24 +0300
Message-Id: <20240410072303.4191455-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The macOS jobs in our CI recently started failing, complaining that
the distutils module is not available anymore. And indeed, according to
https://peps.python.org/pep-0632/ it's been deprecated since a while
and now likely got removed in recent Python versions.

Fortunately, we only use it for a version check via LooseVersion here
which we don't really need anymore - according to Repology.org, these
are the versions of sphinx-rtd-theme that are currently used by the
various distros:

 centos_stream_8: 0.3.1
 centos_stream_9: 0.5.1
 fedora_38: 1.1.1
 fedora_39: 1.2.2
 freebsd: 1.0.0
 haikuports_master: 1.2.1
 openbsd: 1.2.2
 opensuse_leap_15_5: 0.5.1
 pkgsrc_current: 2.0.0
 debian_11: 0.5.1
 debian_12: 1.2.0
 ubuntu_20_04: 0.4.3
 ubuntu_22_04: 1.0.0
 ubuntu_24_04: 2.0.0

So except for CentOS 8, all distros are using a newer version of
sphinx-rtd-theme, and for CentOS 8 we don't support compiling with
the Sphinx of the distro anymore anyway, since it's based on the
Python 3.6 interpreter there. For compiling on CentOS 8, you have
to use the alternative Python 3.8 interpreter which comes without
Sphinx, so that needs the Sphinx installed via pip in the venv
instead, and that is using a newer version, too, according to our
pythondeps.toml file.

Thus we can simply drop the version check now to get rid of the
distutils dependency here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Message-id: 20240304130403.129543-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit eb844330bd36ebdd4959053da08069d1e5d49119)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/conf.py b/docs/conf.py
index e84a95e71c..1b2afa241c 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -29,7 +29,6 @@
 import os
 import sys
 import sphinx
-from distutils.version import LooseVersion
 from sphinx.errors import ConfigError
 
 # The per-manual conf.py will set qemu_docdir for a single-manual build;
@@ -165,11 +164,10 @@
 # Theme options are theme-specific and customize the look and feel of a theme
 # further.  For a list of options available for each theme, see the
 # documentation.
-if LooseVersion(sphinx_rtd_theme.__version__) >= LooseVersion("0.4.3"):
-    html_theme_options = {
-        "style_nav_header_background": "#802400",
-        "navigation_with_keys": True,
-    }
+html_theme_options = {
+    "style_nav_header_background": "#802400",
+    "navigation_with_keys": True,
+}
 
 html_logo = os.path.join(qemu_docdir, "../ui/icons/qemu_128x128.png")
 
-- 
2.39.2


