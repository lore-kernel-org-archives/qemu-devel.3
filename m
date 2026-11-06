Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32C2606D808
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xz7nSgTI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPInZ-00059U-RJ; Fri, 06 Nov 2026 07:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPInR-00057u-Df
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPInP-0006TV-6P
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtuxcqsDUd/e1mWvdb0co1wOr+Ge2UyLuy3MN4YTGAU=;
 b=Xz7nSgTIZ2GCiK0UU/Q+ed4XpnVsQi3a34RSV6Xtzlg5K7gnAL5tWe/TQWSpa3BAQ8L08E
 Xtz7SLscFsirpjywLj5W7EdueUYrxN/pt3s1MwFDeiCOE/6SpN32jPQ2NXM1mBFVjnP3Ne
 IpX2rYllvMme6qjNQrLCpCHrBL/hv5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-iyvnrOXKNiSp8NnhQia2_g-1; Fri,
 06 Nov 2026 07:11:47 -0500
X-MC-Unique: iyvnrOXKNiSp8NnhQia2_g-1
X-Mimecast-MFC-AGG-ID: iyvnrOXKNiSp8NnhQia2_g_1793967106
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46EEE1800591; Fri,  6 Nov 2026 12:11:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB4881956089; Fri,  6 Nov 2026 12:11:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 65F1621E692D; Fri, 06 Nov 2026 13:11:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/6] qapi: Consistently use x.y with since
Date: Fri,  6 Nov 2026 13:11:38 +0100
Message-ID: <20261106121143.3771978-2-armbru@redhat.com>
In-Reply-To: <20261106121143.3771978-1-armbru@redhat.com>
References: <20261106121143.3771978-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

docs/devel/qapi-code-gen.rst documents "Since: x.y.z" and "(since
x.y.z)", but we almost always use just x.y.  Makes sense, because .z
is exclusively for stable branches, where we generally don't mess with
QAPI schemas.

Adjust the doc and the exceptions to the ruling practice.  Do not
touch versions prior to 3.0.0, because .z was not for stable branches
back then.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261103073311.3501327-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 4 ++--
 docs/interop/firmware.json   | 4 ++--
 qapi/accelerator.json        | 6 +++---
 qapi/crypto.json             | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index fc3a1dd6d8..31afcb7805 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1001,7 +1001,7 @@ indented like this::
 .. FIXME union branches should be described, too.
 
 Extensions added after the definition was first released carry a
-"(since x.y.z)" comment.
+"(since x.y)" comment.
 
 The feature descriptions must be preceded by a blank line and then a
 line "Features:", like this::
@@ -1034,7 +1034,7 @@ detailing a relevant error condition.  For example::
  #     - If @device does not exist, DeviceNotFound
  #     - Any other error returns a GenericError.
 
-A "Since: x.y.z" tagged section lists the release that introduced the
+A "Since: x.y" tagged section lists the release that introduced the
 definition.
 
 "TODO" sections are not rendered (they are for developers, not users of
diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 1efd32c631..c8bf0ef1a1 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -283,7 +283,7 @@
 #     and can be shared between multiple guests.  No NVRAM template
 #     will be specified.
 #
-# Since: 7.0.0
+# Since: 7.0
 ##
 { 'enum': 'FirmwareFlashMode',
   'data': [ 'split', 'combined', 'stateless' ] }
@@ -296,7 +296,7 @@
 #
 # @mode: Describes how the firmware build handles code versus variable
 #     storage.  If not present, it must be treated as if it was
-#     configured with value @split.  Since: 7.0.0
+#     configured with value @split.  (Since: 7.0)
 #
 # @executable: Identifies the firmware executable.  The @mode
 #     indicates whether there will be an associated NVRAM template
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index efc0fa8141..e422fc7ee6 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -78,7 +78,7 @@
 #
 # @xen: Xen
 #
-# Since: 10.2.0
+# Since: 10.2
 ##
 { 'enum': 'Accelerator', 'data': ['hvf', 'kvm', 'mshv', 'nvmm', 'qtest', 'tcg', 'whpx', 'xen'] }
 
@@ -91,7 +91,7 @@
 # @present: the list of accelerators that are built into this
 #     executable
 #
-# Since: 10.2.0
+# Since: 10.2
 ##
 { 'struct': 'AcceleratorInfo', 'data': {'enabled': 'Accelerator', 'present': ['Accelerator']} }
 
@@ -101,7 +101,7 @@
 #
 # Returns: @AcceleratorInfo
 #
-# Since: 10.2.0
+# Since: 10.2
 #
 # .. qmp-example::
 #
diff --git a/qapi/crypto.json b/qapi/crypto.json
index a8d753d360..0fd1af1b68 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -57,7 +57,7 @@
 #
 # @ripemd160: RIPEMD-160.  (since 2.7)
 #
-# @sm3: SM3.  (since 9.2.0)
+# @sm3: SM3.  (since 9.2)
 #
 # Since: 2.6
 ##
-- 
2.55.0


