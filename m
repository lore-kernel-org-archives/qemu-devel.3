Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D59CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkT-00066C-GY; Wed, 30 Sep 2026 06:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriw-0001XC-7b
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBril-0006oq-6D
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9SfM+F33aegDiM7mM7xKKo0/dpEnSTem75et+wCWPM=;
 b=HNqFaNgb1nx0qgbqjV4x2zjHXIehqyoK2zOHgmj2XUi6HA5WDSZ7e9VAZb7vgNgPFmyxtk
 Zks7KgNPVRdHnNt7z/Ar/jkPdAdWrV7ZEiYsXr2sCdBtC9Teb0L0UAAs4pmbBggyPupddK
 dKfanrTLerB8sy2O07lMcrT3GpeTKmw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-f8II59E6PV69rhV_LUq-FA-1; Wed,
 30 Sep 2026 06:39:28 -0400
X-MC-Unique: f8II59E6PV69rhV_LUq-FA-1
X-Mimecast-MFC-AGG-ID: f8II59E6PV69rhV_LUq-FA_1790764768
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F1EE1964CE1; Wed, 30 Sep 2026 10:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D388C768; Wed, 30 Sep 2026 10:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 156F321E6572; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 091/105] qapi: convert simple intros for qga/qapi-schema.json
Date: Wed, 30 Sep 2026 12:38:56 +0200
Message-ID: <20260930103910.3934848-92-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

These are all single-paragraph introductions immediately followed by a
non-plaintext section, so no new insertion point is created by this
conversion.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260922205605.501602-5-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 90110af573..b592b14a01 100644
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


