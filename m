Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B84C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3v2-0008CQ-QT; Thu, 08 May 2025 12:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3uz-0008Bk-IF
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3ux-0007fC-6o
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746720974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpQjF3fu57+/BPd5uhocDEKBwd3L0AMAbd+JuHdLGpQ=;
 b=aEMyA1qAQMvFvesvGuugaYUrQi7hW6EqKSyr0YzVbsSsb/+n9mHomOVmypnMkDaxnWgX9m
 OkuFL7kl0r36X3itf+xUq9XTkKNg6HVBZcSgVkgPlU2mZkuL+ngpkAyqRErKlfWS2oBfMK
 k2UcCVNG9GUgZE1r7fWx7U5jGJD83d8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618--k1_qA7ZPjyykkWva8K6Cg-1; Thu,
 08 May 2025 12:16:12 -0400
X-MC-Unique: -k1_qA7ZPjyykkWva8K6Cg-1
X-Mimecast-MFC-AGG-ID: -k1_qA7ZPjyykkWva8K6Cg_1746720971
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 025ED1801A18; Thu,  8 May 2025 16:16:11 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E8D6180049D; Thu,  8 May 2025 16:16:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/6] docs/about/removed-features: auto-generate a note for
 versioned machine types
Date: Thu,  8 May 2025 17:15:35 +0100
Message-ID: <20250508161536.865866-6-berrange@redhat.com>
In-Reply-To: <20250508161536.865866-1-berrange@redhat.com>
References: <20250508161536.865866-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/about/removed-features.rst | 10 ++++++----
 docs/conf.py                    |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 790a5e481c..063284d4f8 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -981,10 +981,12 @@ from Linux in 2021, and is not supported anymore by QEMU either.
 System emulator machines
 ------------------------
 
-Note: Versioned machine types that have been introduced in a QEMU version
-that has initially been released more than 6 years before are considered
-obsolete and will be removed without further notice in this document.
-Please use newer machine types instead.
+Versioned machine types (aarch64, arm, i386, m68k, ppc64, s390x, x86_64)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+In accordance with our versioned machine type deprecation policy, all machine
+types with version |VER_MACHINE_DELETION_VERSION|, or older, have been
+removed.
 
 ``s390-virtio`` (removed in 2.6)
 ''''''''''''''''''''''''''''''''
diff --git a/docs/conf.py b/docs/conf.py
index 60dcf2a541..248ff8cf5d 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -137,6 +137,7 @@
         minor += 1
 
 ver_machine_deprecation_version = "%d.%d.0" % (major - 3, minor)
+ver_machine_deletion_version = "%d.%d.0" % (major - 6, minor)
 
 # The language for content autogenerated by Sphinx. Refer to documentation
 # for a list of supported languages.
@@ -170,6 +171,7 @@
 vars = {
     "CONFDIR": confdir,
     "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
+    "VER_MACHINE_DELETION_VERSION": ver_machine_deletion_version,
 }
 
 rst_epilog = "".join([
-- 
2.49.0


