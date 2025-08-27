Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203F8CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB10-0005iz-TF; Wed, 27 Aug 2025 03:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0s-0005gm-DT
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0k-00023A-IQ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qTOfoHYFxa4N97Q5OB9kbIjUnEX52KkH3iXHkAsVcJY=;
 b=CQ7Lv5ueFKRC/snyfLSPK564Ugo6i8XSx3XM340mv8vqBc9w29ztDeqZnve8x+cyBAenSh
 zU0Fmvyrpw9CoBsMvdSzMFeKrLTr0a6elJWDhgKv2Ri/7O6IXqAEfdw1aNeeSY3EV6sLhf
 H/J3Rvn2hE1v1oneM3pzVFk9salVxSo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-hqbrgj6HMrGvJUbVYeplCA-1; Wed,
 27 Aug 2025 03:55:55 -0400
X-MC-Unique: hqbrgj6HMrGvJUbVYeplCA-1
X-Mimecast-MFC-AGG-ID: hqbrgj6HMrGvJUbVYeplCA_1756281354
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B199019541AF; Wed, 27 Aug 2025 07:55:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDEE01955F24; Wed, 27 Aug 2025 07:55:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/31] tests/functional: Move microblaze tests into
 architecture specific folder
Date: Wed, 27 Aug 2025 09:54:28 +0200
Message-ID: <20250827075443.559712-19-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Thomas Huth <thuth@redhat.com>

The tests/functional folder has become quite crowded, thus move the
microblaze tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-14-thuth@redhat.com>
---
 MAINTAINERS                                           |  2 +-
 tests/functional/meson.build                          | 11 ++---------
 tests/functional/microblaze/meson.build               |  6 ++++++
 .../test_replay.py}                                   |  0
 .../test_s3adsp1800.py}                               |  0
 tests/functional/microblazeel/meson.build             |  5 +++++
 .../test_s3adsp1800.py}                               |  2 +-
 7 files changed, 15 insertions(+), 11 deletions(-)
 create mode 100644 tests/functional/microblaze/meson.build
 rename tests/functional/{test_microblaze_replay.py => microblaze/test_replay.py} (100%)
 rename tests/functional/{test_microblaze_s3adsp1800.py => microblaze/test_s3adsp1800.py} (100%)
 create mode 100644 tests/functional/microblazeel/meson.build
 rename tests/functional/{test_microblazeel_s3adsp1800.py => microblazeel/test_s3adsp1800.py} (92%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e188de813fb..b6a835777bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1370,7 +1370,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_s3adsp1800_mmu.c
 F: include/hw/char/xilinx_uartlite.h
-F: tests/functional/test_microblaze*.py
+F: tests/functional/microblaze*/test_s3adsp1800.py
 
 petalogix_ml605
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d32dd4a371f..fee68056145 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -17,6 +17,8 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('microblaze')
+subdir('microblazeel')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -82,15 +84,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_microblaze_system_thorough = [
-  'microblaze_replay',
-  'microblaze_s3adsp1800'
-]
-
-tests_microblazeel_system_thorough = [
-  'microblazeel_s3adsp1800'
-]
-
 tests_mips_system_thorough = [
   'mips_malta',
   'mips_replay',
diff --git a/tests/functional/microblaze/meson.build b/tests/functional/microblaze/meson.build
new file mode 100644
index 00000000000..8069ca9be60
--- /dev/null
+++ b/tests/functional/microblaze/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_microblaze_system_thorough = [
+  'replay',
+  's3adsp1800'
+]
diff --git a/tests/functional/test_microblaze_replay.py b/tests/functional/microblaze/test_replay.py
similarity index 100%
rename from tests/functional/test_microblaze_replay.py
rename to tests/functional/microblaze/test_replay.py
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/microblaze/test_s3adsp1800.py
similarity index 100%
rename from tests/functional/test_microblaze_s3adsp1800.py
rename to tests/functional/microblaze/test_s3adsp1800.py
diff --git a/tests/functional/microblazeel/meson.build b/tests/functional/microblazeel/meson.build
new file mode 100644
index 00000000000..27619dc5a9a
--- /dev/null
+++ b/tests/functional/microblazeel/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_microblazeel_system_thorough = [
+  's3adsp1800'
+]
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/microblazeel/test_s3adsp1800.py
similarity index 92%
rename from tests/functional/test_microblazeel_s3adsp1800.py
rename to tests/functional/microblazeel/test_s3adsp1800.py
index 915902d48bd..75ce8856ed1 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/microblazeel/test_s3adsp1800.py
@@ -7,7 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from test_microblaze_s3adsp1800 import MicroblazeMachine
+from microblaze.test_s3adsp1800 import MicroblazeMachine
 
 
 class MicroblazeLittleEndianMachine(MicroblazeMachine):
-- 
2.50.1


