Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783DDC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Wfu-00041o-I7; Thu, 16 May 2024 04:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7Wfq-0003s4-IB
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7Wfn-0003gb-Vi
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715848870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VClN+k+OoKcDTIm4PWHEZ8Elhihvm9ZrnaHsM/9HySs=;
 b=AiEkNb8WhsaBzC7hayWX6QYK3f5kTMuxHQxoTKakBkGWpwFzQeIos6/rTAYgtWeyVYKBNp
 Q8TQFFEkCaL8QJMkCW7gKwenallVTTlqA8VCKzhlYAbuGzbGf2oTbUhThpwRGVuJzKo1Cv
 8rfFA76NFoDHbeH4O9zxMaDiNMtciyU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-_SOp4RSsMs65TCsMCDIpxw-1; Thu,
 16 May 2024 04:41:06 -0400
X-MC-Unique: _SOp4RSsMs65TCsMCDIpxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7F6E1C00501;
 Thu, 16 May 2024 08:41:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FB352026D68;
 Thu, 16 May 2024 08:41:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/5] tests/lcitool: Remove g++ from the containers (except
 for the MinGW one)
Date: Thu, 16 May 2024 10:40:57 +0200
Message-ID: <20240516084059.511463-4-thuth@redhat.com>
In-Reply-To: <20240516084059.511463-1-thuth@redhat.com>
References: <20240516084059.511463-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

We don't need C++ for the normal QEMU builds anymore, so installing
g++ in each and every container seems to be a waste of time and disk
space. The only container that still needs it is the Fedora MinGW
container that builds the only remaining C++ code in ./qga/vss-win32/
and we can install it there with an extra project yml file instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/projects/qemu-minimal.yml       | 1 -
 tests/lcitool/projects/qemu-win-installer.yml | 4 ++++
 tests/lcitool/projects/qemu.yml               | 1 -
 tests/lcitool/refresh                         | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 tests/lcitool/projects/qemu-win-installer.yml

diff --git a/tests/lcitool/projects/qemu-minimal.yml b/tests/lcitool/projects/qemu-minimal.yml
index d44737dc1d..6bc232a1c3 100644
--- a/tests/lcitool/projects/qemu-minimal.yml
+++ b/tests/lcitool/projects/qemu-minimal.yml
@@ -7,7 +7,6 @@ packages:
  - ccache
  - findutils
  - flex
- - g++
  - gcc
  - gcc-native
  - glib2
diff --git a/tests/lcitool/projects/qemu-win-installer.yml b/tests/lcitool/projects/qemu-win-installer.yml
new file mode 100644
index 0000000000..86aa22297c
--- /dev/null
+++ b/tests/lcitool/projects/qemu-win-installer.yml
@@ -0,0 +1,4 @@
+# Additional packages that are required to build the code in qga/vss-win32/
+---
+packages:
+ - g++
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
index 174818d9c9..789acefb75 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -192,6 +192,7 @@ try:
                                             "s390x-softmmu,s390x-linux-user"))
 
     generate_dockerfile("fedora-win64-cross", "fedora-38",
+                        project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
                                             "x86_64-softmmu"))
-- 
2.45.0


