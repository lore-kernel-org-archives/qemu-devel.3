Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E323C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 04:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmlRw-00050C-3d; Thu, 23 Jul 2026 00:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlRU-0004qm-WA
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wmlRS-0004yK-B2
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 00:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784782433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8pqXrIvr/yRTQ3rsO16r+lqlJjBRU1uvUFq6p7chi8=;
 b=hpmKaK99oEAaWNwzsim00n/qPwvcvzDHQbI6jvQFYrm58J4D1g+R6ZBsCwR3LuJhkWEgvj
 oQMTxidpWMpKESqyB7TxFNiuG3X/Txr0e9dw+4yFGFU+c2mhZ+YzUuKlOF78zQdJntt4cb
 Mea5dp1z15l5Ja87tiLz9dls+jZOjN4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-lplzGk48Ne-oI1ZVlthRcg-1; Thu,
 23 Jul 2026 00:53:48 -0400
X-MC-Unique: lplzGk48Ne-oI1ZVlthRcg-1
X-Mimecast-MFC-AGG-ID: lplzGk48Ne-oI1ZVlthRcg_1784782425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 910711955DC2; Thu, 23 Jul 2026 04:53:45 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC9F918002B4; Thu, 23 Jul 2026 04:53:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alex Williamson <alex@shazbot.org>, zhenwei pi <zhenwei.pi@linux.dev>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 linux-cxl@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 33/44] qapi: convert trivial intro sections for misc.json
Date: Thu, 23 Jul 2026 00:47:54 -0400
Message-ID: <20260723044805.527643-34-jsnow@redhat.com>
In-Reply-To: <20260723044805.527643-1-jsnow@redhat.com>
References: <20260723044805.527643-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=jsnow@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/misc.json | 74 ++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 47 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f6..b3c2a1421f3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -44,8 +44,7 @@
 
 ##
 # @NameInfo:
-#
-# Guest name information.
+#     Guest name information.
 #
 # @name: The name of the guest
 #
@@ -55,8 +54,7 @@
 
 ##
 # @query-name:
-#
-# Return the name information of a guest.
+#     Return the name information of a guest.
 #
 # Since: 0.14
 #
@@ -69,8 +67,7 @@
 
 ##
 # @IOThreadInfo:
-#
-# Information about an iothread
+#     Information about an iothread
 #
 # @id: the identifier of the iothread
 #
@@ -137,8 +134,7 @@
 
 ##
 # @stop:
-#
-# Stop guest VM execution.
+#     Stop guest VM execution.
 #
 # Since: 0.14
 #
@@ -159,8 +155,7 @@
 
 ##
 # @cont:
-#
-# Resume guest VM execution.
+#     Resume guest VM execution.
 #
 # Since: 0.14
 #
@@ -208,8 +203,7 @@
 
 ##
 # @human-monitor-command:
-#
-# Execute a command on the human monitor and return the output.
+#     Execute a command on the human monitor and return the output.
 #
 # @command-line: the command to execute in the human monitor
 #
@@ -251,8 +245,7 @@
 
 ##
 # @getfd:
-#
-# Receive a file descriptor via SCM rights and assign it a name
+#     Receive a file descriptor via SCM rights and assign it a name
 #
 # @fdname: file descriptor name
 #
@@ -273,11 +266,10 @@
 
 ##
 # @get-win32-socket:
-#
-# Add a socket that was duplicated to QEMU process with
-# WSADuplicateSocketW() via WSASocket() & WSAPROTOCOL_INFOW structure
-# and assign it a name (the SOCKET is associated with a CRT file
-# descriptor)
+#     Add a socket that was duplicated to QEMU process with
+#     WSADuplicateSocketW() via WSASocket() & WSAPROTOCOL_INFOW
+#     structure and assign it a name (the SOCKET is associated with a
+#     CRT file descriptor)
 #
 # @info: the WSAPROTOCOL_INFOW structure (encoded in base64)
 #
@@ -301,8 +293,7 @@
 
 ##
 # @closefd:
-#
-# Close a file descriptor previously passed via SCM rights
+#     Close a file descriptor previously passed via SCM rights
 #
 # @fdname: file descriptor name
 #
@@ -317,8 +308,7 @@
 
 ##
 # @AddfdInfo:
-#
-# Information about a file descriptor that was added to an fd set.
+#     Information about a file descriptor that was added to an fd set.
 #
 # @fdset-id: The ID of the fd set that @fd was added to.
 #
@@ -331,8 +321,8 @@
 
 ##
 # @add-fd:
-#
-# Add a file descriptor, that was passed via SCM rights, to an fd set.
+#     Add a file descriptor, that was passed via SCM rights, to an fd
+#     set.
 #
 # @fdset-id: The ID of the fd set to add the file descriptor to.
 #
@@ -361,8 +351,7 @@
 
 ##
 # @remove-fd:
-#
-# Remove a file descriptor from an fd set.
+#     Remove a file descriptor from an fd set.
 #
 # @fdset-id: The ID of the fd set that the file descriptor belongs to.
 #
@@ -387,8 +376,7 @@
 
 ##
 # @FdsetFdInfo:
-#
-# Information about a file descriptor that belongs to an fd set.
+#     Information about a file descriptor that belongs to an fd set.
 #
 # @fd: The file descriptor value.
 #
@@ -401,8 +389,7 @@
 
 ##
 # @FdsetInfo:
-#
-# Information about an fd set.
+#     Information about an fd set.
 #
 # @fdset-id: The ID of the fd set.
 #
@@ -415,8 +402,7 @@
 
 ##
 # @query-fdsets:
-#
-# Return information describing all fd sets.
+#     Return information describing all fd sets.
 #
 # Since: 1.2
 #
@@ -457,8 +443,7 @@
 
 ##
 # @CommandLineParameterType:
-#
-# Possible types for an option parameter.
+#     Possible types for an option parameter.
 #
 # @string: accepts a character string
 #
@@ -476,8 +461,7 @@
 
 ##
 # @CommandLineParameterInfo:
-#
-# Details about a single parameter of a command line option.
+#     Details about a single parameter of a command line option.
 #
 # @name: parameter name
 #
@@ -497,9 +481,8 @@
 
 ##
 # @CommandLineOptionInfo:
-#
-# Details about a command line option, including its list of parameter
-# details
+#     Details about a command line option, including its list of
+#     parameter details
 #
 # @option: option name
 #
@@ -512,8 +495,7 @@
 
 ##
 # @query-command-line-options:
-#
-# Query command line option schema.
+#     Query command line option schema.
 #
 # @option: option name
 #
@@ -552,8 +534,7 @@
 
 ##
 # @RTC_CHANGE:
-#
-# Emitted when the guest changes the RTC time.
+#     Emitted when the guest changes the RTC time.
 #
 # @offset: offset in seconds between base RTC clock (as specified by
 #     -rtc base), and new RTC clock value
@@ -577,9 +558,8 @@
 
 ##
 # @VFU_CLIENT_HANGUP:
-#
-# Emitted when the client of a TYPE_VFIO_USER_SERVER closes the
-# communication channel
+#     Emitted when the client of a TYPE_VFIO_USER_SERVER closes the
+#     communication channel
 #
 # @vfu-id: ID of the TYPE_VFIO_USER_SERVER object.  It is the last
 #     component of @vfu-qom-path referenced below
-- 
2.55.0


