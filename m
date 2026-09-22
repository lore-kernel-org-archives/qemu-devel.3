Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EBDC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Xk-0000Oz-Uk; Tue, 22 Sep 2026 16:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97Xb-0000JG-Aj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97XY-00046e-Fz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790110595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiuQzypKOo2UN4XSnEnDQmXYroFTjnqbNw1e7bjBSrs=;
 b=SDejb2cAdhMn6ZSTKBRAxrzAyEg3C0kWVSBEax/AMtgkGeDr/oDWO74JZJ4uCNRuheGnXo
 EsuysVlgis2ddoUR3MtQlvVOOLHkWQ8sPm1bSYxicwYruVkbET14JEP/tWTdg8OCtB0ZSK
 4S+rbjnlzhcQBjoRMS9i17pILaEVHZ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-8ByOnC5vP6WeKUPZWXEW7w-1; Tue,
 22 Sep 2026 16:56:31 -0400
X-MC-Unique: 8ByOnC5vP6WeKUPZWXEW7w-1
X-Mimecast-MFC-AGG-ID: 8ByOnC5vP6WeKUPZWXEW7w_1790110589
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AE8519560BB; Tue, 22 Sep 2026 20:56:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62ED21956086; Tue, 22 Sep 2026 20:56:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 4/8] qapi: convert simple intros for qga/qapi-schema.json
Date: Tue, 22 Sep 2026 16:56:01 -0400
Message-ID: <20260922205605.501602-5-jsnow@redhat.com>
In-Reply-To: <20260922205605.501602-1-jsnow@redhat.com>
References: <20260922205605.501602-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are all single-paragraph introductions immediately followed by a
non-plaintext section, so no new insertion point is created by this
conversion.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qga/qapi-schema.json | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 90110af5730..b592b14a011 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -205,9 +205,9 @@
 
 ##
 # @guest-shutdown:
-#
-# Initiate guest-activated shutdown.  Note: this is an asynchronous
-# shutdown request, with no guarantee of successful shutdown.
+#     Initiate guest-activated shutdown.  Note: this is an
+#     asynchronous shutdown request, with no guarantee of successful
+#     shutdown.
 #
 # @mode: "halt", "powerdown" (default), or "reboot"
 #
@@ -266,10 +266,10 @@
 
 ##
 # @guest-file-read:
-#
-# Read from an open file in the guest.  Data will be base64-encoded.
-# As this command is just for limited, ad-hoc debugging, such as log
-# file access, the number of bytes to read is limited to 48 MB.
+#     Read from an open file in the guest.  Data will be
+#     base64-encoded.  As this command is just for limited, ad-hoc
+#     debugging, such as log file access, the number of bytes to read
+#     is limited to 48 MB.
 #
 # @handle: filehandle returned by `guest-file-open`
 #
@@ -357,10 +357,9 @@
 
 ##
 # @guest-file-seek:
-#
-# Seek to a position in the file, as with fseek(), and return the
-# current file position afterward.  Also encapsulates ftell()'s
-# functionality, with offset=0 and whence=1.
+#     Seek to a position in the file, as with fseek(), and return the
+#     current file position afterward.  Also encapsulates ftell()'s
+#     functionality, with offset=0 and whence=1.
 #
 # @handle: filehandle returned by `guest-file-open`
 #
@@ -1254,10 +1253,9 @@
 
 ##
 # @guest-exec-status:
-#
-# Check status of process associated with PID retrieved via
-# `guest-exec`.  Reap the process and associated metadata if it has
-# exited.
+#     Check status of process associated with PID retrieved via
+#     `guest-exec`.  Reap the process and associated metadata if it
+#     has exited.
 #
 # @pid: pid returned from `guest-exec`
 #
@@ -1605,10 +1603,9 @@
 
 ##
 # @guest-ssh-remove-authorized-keys:
-#
-# Remove public keys from the user .ssh/authorized_keys on Unix
-# systems (not implemented for other systems).  It's not an error if
-# the key is already missing.
+#     Remove public keys from the user .ssh/authorized_keys on Unix
+#     systems (not implemented for other systems).  It's not an error
+#     if the key is already missing.
 #
 # @username: the user account to remove the authorized keys
 #
@@ -1838,9 +1835,8 @@
 
 ##
 # @GuestNetworkRoute:
-#
-# Route information.  Supported on Linux (since 9.1) and Windows
-# (since 11.0).
+#     Route information.  Supported on Linux (since 9.1) and Windows
+#     (since 11.0).
 #
 # @iface: The destination network or host's egress network interface
 #     in the routing table
-- 
2.55.0


