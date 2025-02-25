Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5725C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1Al-0005cG-CQ; Tue, 25 Feb 2025 15:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1Aj-0005be-4F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1Ah-00044H-Br
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740513890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbWYwuuEo6QMVGG1kQEVu8+M4OY6+twe4pe7paFTaw0=;
 b=FbTmjThDEhhnM3sFO6OOuj/zAMIzuqgQIxBqiEKKBk3Ar8Rk8YlezUxZQFlnZM2IwAkIXt
 6u+3tk0/yQvIaF4tsxnXBKK0dUYf8nP+JIcF9k51LQbfrDWO287eKLAhB0WZb5QsFoKTli
 YzgMY1umgqyVeahleki+rq7/YB0NMic=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-9oEe9F7NMIezuixGdij_Pg-1; Tue,
 25 Feb 2025 15:04:43 -0500
X-MC-Unique: 9oEe9F7NMIezuixGdij_Pg-1
X-Mimecast-MFC-AGG-ID: 9oEe9F7NMIezuixGdij_Pg_1740513882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7B2A19039C1; Tue, 25 Feb 2025 20:04:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E0021800359; Tue, 25 Feb 2025 20:04:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/4] docs/about/removed-features: auto-generate a note for
 versioned machine types
Date: Tue, 25 Feb 2025 20:04:22 +0000
Message-ID: <20250225200423.2350471-4-berrange@redhat.com>
In-Reply-To: <20250225200423.2350471-1-berrange@redhat.com>
References: <20250225200423.2350471-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

We remove versioned machine types on a fixed schedule. This allows us
to auto-generate a paragraph in the removed-features.rst document that
always has accurate version info.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/about/removed-features.rst | 10 ++++++----
 docs/conf.py                    |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 156c0c253c..c120d9ff4f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -972,10 +972,12 @@ from Linux in 2021, and is not supported anymore by QEMU either.
 System emulator machines
 ------------------------
 
-Note: Versioned machine types that have been introduced in a QEMU version
-that has initially been released more than 6 years before are considered
-obsolete and will be removed without further notice in this document.
-Please use newer machine types instead.
+Versioned machine types (aarch64, arm, i386, m68k, ppc, ppc64, s390x, x86_64)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+In accordance with our versioned machine type deprecation policy, all machine
+types with version |VER_MACHINE_DELETION_VERSION|, or older, have been
+removed.
 
 ``s390-virtio`` (removed in 2.6)
 ''''''''''''''''''''''''''''''''
diff --git a/docs/conf.py b/docs/conf.py
index 421ece1024..8b567787ce 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -130,6 +130,7 @@
         minor += 1
 
 ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)
+ver_machine_deletion_version = "%d.%d.%d" % (major - 6, minor, micro)
 
 # The language for content autogenerated by Sphinx. Refer to documentation
 # for a list of supported languages.
@@ -163,6 +164,7 @@
 vars = {
     "CONFDIR": confdir,
     "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
+    "VER_MACHINE_DELETION_VERSION": ver_machine_deletion_version,
 }
 
 rst_epilog = "".join([
-- 
2.47.1


