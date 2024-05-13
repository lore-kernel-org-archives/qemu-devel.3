Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6E2C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Spy-0004Tj-96; Mon, 13 May 2024 06:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6Spw-0004Ta-Jk
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:23:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6Spu-0008PB-Tw
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715595793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utHiwLh5oAXIe3YFqA9WJIV3CNnvHE2fsUepRznam10=;
 b=J+g1rRYhMK+T5jdDuokg0k1443u6SO5HPVxtud77rAjwCD6DCSjwOhDVj/6GJtcq9tZqrb
 3BsI8Z1rwIC83M0lJyTWbvCV+oIZW3zHj6AT6ujcfmuXispdmMG1HeOo7hHwUdRde7SoNf
 QV/HFki6nz/lcZkpAKlU7BtLzIjFHV8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-U4s_37TPOiaGvMWmtuOQgQ-1; Mon, 13 May 2024 06:23:09 -0400
X-MC-Unique: U4s_37TPOiaGvMWmtuOQgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6459680021D;
 Mon, 13 May 2024 10:23:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E51E540C6CB6;
 Mon, 13 May 2024 10:23:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/4] tests/lcitool: Remove g++ from the containers (except for
 the MinGW one)
Date: Mon, 13 May 2024 12:22:50 +0200
Message-ID: <20240513102252.48884-3-thuth@redhat.com>
In-Reply-To: <20240513102252.48884-1-thuth@redhat.com>
References: <20240513102252.48884-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We don't need C++ for the normal QEMU builds anymore, so installing
g++ in each and every container seems to be a waste of time and disk
space. The only container that still needs it is the Fedora MinGW
container that builds the only remaining C++ code in ./qga/vss-win32/
and we can install it here with an extra RUN statement instead.

This way we can also add the mingw-w64-tools package quite easily
which contains the x86_64-w64-mingw32-widl program that is required
for compiling the vss code of the guest agent (it was missing before
this change, so the VSS code was actually never compiled in the CI).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/projects/qemu.yml |  1 -
 tests/lcitool/refresh           | 10 ++++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 9173d1e36e..b63b6bd850 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -22,7 +22,6 @@ packages:
  - findutils
  - flex
  - fuse3
- - g++
  - gcc
  - gcc-native
  - gcovr
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 24a735a3f2..dda07ddcd1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -109,6 +109,11 @@ debian12_extras = [
     "ENV QEMU_CONFIGURE_OPTS --enable-netmap\n"
 ]
 
+fedora_mingw_extras = [ "\n"
+    "RUN nosync dnf install -y mingw64-gcc-c++ mingw-w64-tools && \\\n"
+    "  ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-c++ && \\\n"
+    "  ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/x86_64-w64-mingw32-g++\n\n"
+]
 
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS --cross-prefix=%s\n" % (prefix)
@@ -193,8 +198,9 @@ try:
 
     generate_dockerfile("fedora-win64-cross", "fedora-38",
                         cross="mingw64",
-                        trailer=cross_build("x86_64-w64-mingw32-",
-                                            "x86_64-softmmu"))
+                        trailer="".join(fedora_mingw_extras)
+                                + cross_build("x86_64-w64-mingw32-",
+                                              "x86_64-softmmu"))
 
     #
     # Cirrus packages lists for GitLab
-- 
2.45.0


