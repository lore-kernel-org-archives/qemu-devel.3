Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0EEC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1Aj-0005bY-4q; Tue, 25 Feb 2025 15:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1Ad-0005aD-Dl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1Ab-00042s-3z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740513883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09Q4SCA56WU4G3UVK6qh0APYbJ3LaCJefw+PR4qAjwg=;
 b=RvnSWPwcZrr6ZnHbjEkV8neVs+xB8MZRvixpc8Y9DCvE8oPNoygjEWjt4MjOeMzhdoA5nT
 /e7NkghuOzEy3QZpp8WILHAFAnvse/YzWu6NlQKI5XkzhGz2LDmLuGvgOa9wAMp0ibsjgj
 nD9bPKYEw8Sdiq8qhZO1UmHMoF0xOi8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-ROEKn9LYNXKBhgVf1szp5w-1; Tue,
 25 Feb 2025 15:04:40 -0500
X-MC-Unique: ROEKn9LYNXKBhgVf1szp5w-1
X-Mimecast-MFC-AGG-ID: ROEKn9LYNXKBhgVf1szp5w_1740513879
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2D3A180087A; Tue, 25 Feb 2025 20:04:37 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77A0A1800378; Tue, 25 Feb 2025 20:04:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] docs/about/deprecated: auto-generate a note for versioned
 machine types
Date: Tue, 25 Feb 2025 20:04:21 +0000
Message-ID: <20250225200423.2350471-3-berrange@redhat.com>
In-Reply-To: <20250225200423.2350471-1-berrange@redhat.com>
References: <20250225200423.2350471-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We deprecate versioned machine types on a fixed schedule. This allows us
to auto-generate a paragraph in the deprecated.rst document that always
has accurate version info.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 docs/conf.py              | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index abadf8de27..da2b1b48ca 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -269,6 +269,13 @@ Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 System emulator machines
 ------------------------
 
+Versioned machine types (aarch64, arm, i386, m68k, ppc, ppc64, s390x, x86_64)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+In accordance with our versioned machine type deprecation policy, all machine
+types with version |VER_MACHINE_DEPRECATION_VERSION|, or older, have been
+deprecated.
+
 Arm ``virt`` machine ``dtb-kaslr-seed`` property (since 7.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/conf.py b/docs/conf.py
index 31bb9a3789..421ece1024 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -110,6 +110,27 @@
     else:
         version = release = "unknown version"
 
+bits = version.split(".")
+
+major = int(bits[0])
+minor = int(bits[1])
+micro = int(bits[2])
+
+# Check for a dev snapshot, so we can adjust to next
+# predicted release version.
+#
+# This assumes we do 3 releases per year, so must bump
+# major if minor == 2
+if micro >= 50:
+    micro = 0
+    if minor == 2:
+        major += 1
+        minor = 0
+    else:
+        minor += 1
+
+ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)
+
 # The language for content autogenerated by Sphinx. Refer to documentation
 # for a list of supported languages.
 #
@@ -138,7 +159,17 @@
 # environment variable is not set is for the benefit of readthedocs
 # style document building; our Makefile always sets the variable.
 confdir = os.getenv('CONFDIR', "/etc/qemu")
-rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
+
+vars = {
+    "CONFDIR": confdir,
+    "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
+}
+
+rst_epilog = "".join([
+    ".. |" + key + "| replace:: ``" + vars[key] + "``\n"
+    for key in vars.keys()
+])
+
 # We slurp in the defs.rst.inc and literally include it into rst_epilog,
 # because Sphinx's include:: directive doesn't work with absolute paths
 # and there isn't any one single relative path that will work for all
-- 
2.47.1


