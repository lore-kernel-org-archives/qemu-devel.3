Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA5FC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsUD-0003H0-Ey; Fri, 01 Aug 2025 12:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrS2-000341-Kq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrS0-0002hg-Vv
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkBO2nsj/6LfUP1W8Cw1w1Pq0gLVnuyIUDtJHfg8odw=;
 b=gdDpclCqwT/m/FJ2Y/X7nuYXsNdUKSwJmuQLhxD8sfbu1XigQCZ+H8Va90fkyvM7KsRrAa
 i0l4az3V4Ey+msroeykB1OkEkoKtguR79Z7yt27matGl19xfi9xZtQ5D4JwqWsvSPLIFpj
 7Q/ncKEbcnziRjZONNRBOW8kNK7qvUo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-EqgXv-MLO--KZBl0TiLqBA-1; Fri,
 01 Aug 2025 11:13:34 -0400
X-MC-Unique: EqgXv-MLO--KZBl0TiLqBA-1
X-Mimecast-MFC-AGG-ID: EqgXv-MLO--KZBl0TiLqBA_1754061213
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBFFB195D020; Fri,  1 Aug 2025 15:13:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFB401800B77; Fri,  1 Aug 2025 15:13:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/24] tests/functional: Move loongarch64 tests into
 architecture specific folder
Date: Fri,  1 Aug 2025 17:12:36 +0200
Message-ID: <20250801151251.751368-12-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
loongarch64 tests into a target-specific subfolder.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                                  | 2 +-
 tests/functional/loongarch64/meson.build                     | 5 +++++
 .../{test_loongarch64_virt.py => loongarch64/test_virt.py}   | 0
 tests/functional/meson.build                                 | 5 +----
 4 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 tests/functional/loongarch64/meson.build
 rename tests/functional/{test_loongarch64_virt.py => loongarch64/test_virt.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index db89dd830b4..2065e73e155 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -257,7 +257,7 @@ M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
 F: tests/tcg/loongarch64/
-F: tests/functional/test_loongarch64_virt.py
+F: tests/functional/loongarch64/test_virt.py
 
 M68K TCG CPUs
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/tests/functional/loongarch64/meson.build b/tests/functional/loongarch64/meson.build
new file mode 100644
index 00000000000..d1687176a3d
--- /dev/null
+++ b/tests/functional/loongarch64/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_loongarch64_system_thorough = [
+  'virt',
+]
diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/loongarch64/test_virt.py
similarity index 100%
rename from tests/functional/test_loongarch64_virt.py
rename to tests/functional/loongarch64/test_virt.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c72b17df1dd..22b46ab34a2 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,6 +15,7 @@ subdir('arm')
 subdir('avr')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -80,10 +81,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_loongarch64_system_thorough = [
-  'loongarch64_virt',
-]
-
 tests_m68k_system_thorough = [
   'm68k_mcf5208evb',
   'm68k_nextcube',
-- 
2.50.1


