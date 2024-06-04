Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6833C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9q-0006mW-PR; Tue, 04 Jun 2024 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9p-0006jn-4T
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:33:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9n-0001Jq-Ic
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoKurEtuVM1m6D7a7OV1LnPY9CvW0j2OIm2Cocy4AOk=;
 b=hvOJZOSxqWNuSRcwVcHzBywNDZPM2RxePSIs2Gfw5wFyy234Hioxzs20YGNKIjKfh8DfVz
 z2ncSQxfRdMC3HcCJ2wFXsjNJIfzhJt2KTYF4lLuQQkFsQOMsfvZOqs+DIzNJnyFk9WDaV
 DdAVpegD6xiZ5bzECAk3y5PBs6DMugk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-gVG-jyPONnO3l5eOCdZZlg-1; Tue,
 04 Jun 2024 11:32:57 -0400
X-MC-Unique: gVG-jyPONnO3l5eOCdZZlg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B28813801F4A;
 Tue,  4 Jun 2024 15:32:56 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE261492BD8;
 Tue,  4 Jun 2024 15:32:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 11/14] qga: mark guest-file-* commands with 'unrestricted' flag
Date: Tue,  4 Jun 2024 16:32:39 +0100
Message-ID: <20240604153242.251334-12-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This blocks use of all the 'guest-file-*' commands unless the QGA is run
with the --unrestricted command line argument.

These commands allow the host admin to read and write arbitrary guest
files and so directly compromise the guest OS.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/qapi-schema.json | 48 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index de7c1de0b7..2f80d89536 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -283,11 +283,17 @@
 #
 # Returns: Guest file handle
 #
+# Features:
+#
+# @unrestricted: not permitted if agent disables unrestricted
+#                resource access mode
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-open',
   'data':    { 'path': 'str', '*mode': 'str' },
-  'returns': 'int' }
+  'returns': 'int',
+  'features': [ 'unrestricted' ] }
 
 ##
 # @guest-file-close:
@@ -296,10 +302,16 @@
 #
 # @handle: filehandle returned by guest-file-open
 #
+# Features:
+#
+# @unrestricted: not permitted if agent disables unrestricted
+#                resource access mode
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-close',
-  'data': { 'handle': 'int' } }
+  'data': { 'handle': 'int' },
+  'features': [ 'unrestricted' ] }
 
 ##
 # @GuestFileRead:
@@ -332,11 +344,17 @@
 #
 # Returns: @GuestFileRead
 #
+# Features:
+#
+# @unrestricted: not permitted if agent disables unrestricted
+#                resource access mode
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-read',
   'data':    { 'handle': 'int', '*count': 'int' },
-  'returns': 'GuestFileRead' }
+  'returns': 'GuestFileRead',
+  'features': [ 'unrestricted' ] }
 
 ##
 # @GuestFileWrite:
@@ -367,11 +385,17 @@
 #
 # Returns: @GuestFileWrite
 #
+# Features:
+#
+# @unrestricted: not permitted if agent disables unrestricted
+#                resource access mode
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-write',
   'data':    { 'handle': 'int', 'buf-b64': 'str', '*count': 'int' },
-  'returns': 'GuestFileWrite' }
+  'returns': 'GuestFileWrite',
+  'features': [ 'unrestricted' ] }
 
 
 ##
@@ -434,12 +458,18 @@
 #
 # Returns: @GuestFileSeek
 #
+# Features:
+#
+# @unrestricted: not permitted if agent disables unrestricted
+#                resource access mode
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-seek',
   'data':    { 'handle': 'int', 'offset': 'int',
                'whence': 'GuestFileWhence' },
-  'returns': 'GuestFileSeek' }
+  'returns': 'GuestFileSeek',
+  'features': [ 'unrestricted' ] }
 
 ##
 # @guest-file-flush:
@@ -448,10 +478,16 @@
 #
 # @handle: filehandle returned by guest-file-open
 #
+# Features:
+#
+# @unrestricted: not permitted if agent disables unrestricted
+#                resource access mode
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-file-flush',
-  'data': { 'handle': 'int' } }
+  'data': { 'handle': 'int' },
+  'features': [ 'unrestricted' ] }
 
 ##
 # @GuestFsfreezeStatus:
-- 
2.45.1


