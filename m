Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A837C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn47-0002gv-Vq; Mon, 22 Jul 2024 03:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3x-0001Vk-5H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3v-0006f4-GL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6930HjNXGIGQwkzxIJB4ZGOGymfGeefbFiY2GAp2X8Y=;
 b=LA4EwhDl0qJeB1n2l8TiLfNKKqi0jjWKyQ/NhQ8S5v/Zkbbf27qf+D+5rW1WKS6Fh7JUGr
 GdxvOFxCnpg8ZawNbRcv2NqtHV1CARg+5h5iJsSL7Ywon1QTtxMZFWr/dQF7uAJ/6RtjR9
 7yG9jP/HjSKa8+I9qixItgbZD5S5M3Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-E0bBM7IDMCeGLYuUb8hkpw-1; Mon,
 22 Jul 2024 03:02:18 -0400
X-MC-Unique: E0bBM7IDMCeGLYuUb8hkpw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9078D189B033; Mon, 22 Jul 2024 07:02:11 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 882ED196BC8B; Mon, 22 Jul 2024 07:02:08 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 15/25] qga: conditionalize schema for commands requiring libudev
Date: Mon, 22 Jul 2024 10:01:12 +0300
Message-ID: <20240722070122.27615-16-kkostiuk@redhat.com>
In-Reply-To: <20240722070122.27615-1-kkostiuk@redhat.com>
References: <20240722070122.27615-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the schema to fully
exclude generation of the filesystem trimming commands on POSIX
platforms lacking required APIs.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-16-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 8 --------
 qga/qapi-schema.json | 8 ++++----
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 73b13fbaf6..89bdcded01 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -1049,14 +1049,6 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
     return ret;
 }
 
-#else
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
 #endif
 
 /* Return a list of the disk device(s)' info which @mount lies on */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 21c65d1806..cf1ad42519 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -986,7 +986,7 @@
            'media-errors-hi': 'uint64',
            'number-of-error-log-entries-lo': 'uint64',
            'number-of-error-log-entries-hi': 'uint64' },
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @GuestDiskSmart:
@@ -1001,7 +1001,7 @@
   'base': { 'type': 'GuestDiskBusType' },
   'discriminator': 'type',
   'data': { 'nvme': 'GuestNVMeSmart' },
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @GuestDiskInfo:
@@ -1027,7 +1027,7 @@
   'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
            '*address': 'GuestDiskAddress', '*alias': 'str',
            '*smart': 'GuestDiskSmart'},
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @guest-get-disks:
@@ -1041,7 +1041,7 @@
 ##
 { 'command': 'guest-get-disks',
   'returns': ['GuestDiskInfo'],
-  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LIBUDEV' ] } }
 
 ##
 # @GuestFilesystemInfo:
-- 
2.45.2


