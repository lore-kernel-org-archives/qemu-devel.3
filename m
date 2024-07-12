Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCCCC3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGIB-0007KN-IH; Fri, 12 Jul 2024 09:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHj-0004fm-12
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHa-00040Z-SI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9hjSTgqO3TPO5hRUa5ZpFZcoNmez3TFLbRU8bn+RmeQ=;
 b=VzkLHz1cITWmG2/oXM8kNYqc7KgMWw1KkmaC6IWQZ2tSPlcddnNli3CezRYx7TVxmsZxA2
 CzqewUB0LeXbA6hysQFf1ZwmIy8cPJ9+PWA9WtyzUyKHrXTaZUbkLDsVF7xKhrCWPdeF+P
 cfcqCaKdgUPOSv2Om49APJtVpfTVnRA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-zfWAQiupMWacgrz3Anxraw-1; Fri,
 12 Jul 2024 09:25:47 -0400
X-MC-Unique: zfWAQiupMWacgrz3Anxraw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2DCC196CDEF; Fri, 12 Jul 2024 13:25:46 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFD6D1955E70; Fri, 12 Jul 2024 13:25:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v3 12/22] qga: conditionalize schema for commands only
 supported on Windows
Date: Fri, 12 Jul 2024 14:24:49 +0100
Message-ID: <20240712132459.3974109-13-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-1-berrange@redhat.com>
References: <20240712132459.3974109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the commands on non-Windows.

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
---
 qga/commands-posix.c |  9 ---------
 qga/qapi-schema.json | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 838dc3cf98..b7f96aa005 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1207,8 +1207,6 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
     blockedrpcs = g_list_append(blockedrpcs, g_strdup("guest-fstrim"));
 #endif
 
-    blockedrpcs = g_list_append(blockedrpcs, g_strdup("guest-get-devices"));
-
     return blockedrpcs;
 }
 
@@ -1419,13 +1417,6 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
     return info;
 }
 
-GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-
-    return NULL;
-}
-
 #ifndef HOST_NAME_MAX
 # ifdef _POSIX_HOST_NAME_MAX
 #  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 9bd5aa53bc..de3fc46d2e 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1527,7 +1527,8 @@
 # @pci: PCI device
 ##
 { 'enum': 'GuestDeviceType',
-  'data': [ 'pci' ] }
+  'data': [ 'pci' ],
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestDeviceIdPCI:
@@ -1539,7 +1540,8 @@
 # Since: 5.2
 ##
 { 'struct': 'GuestDeviceIdPCI',
-  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' } }
+  'data': { 'vendor-id': 'uint16', 'device-id': 'uint16' },
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestDeviceId:
@@ -1553,7 +1555,8 @@
 { 'union': 'GuestDeviceId',
   'base': { 'type': 'GuestDeviceType' },
   'discriminator': 'type',
-  'data': { 'pci': 'GuestDeviceIdPCI' } }
+  'data': { 'pci': 'GuestDeviceIdPCI' },
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestDeviceInfo:
@@ -1574,7 +1577,8 @@
       '*driver-date': 'int',
       '*driver-version': 'str',
       '*id': 'GuestDeviceId'
-  } }
+  },
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @guest-get-devices:
@@ -1586,7 +1590,8 @@
 # Since: 5.2
 ##
 { 'command': 'guest-get-devices',
-  'returns': ['GuestDeviceInfo'] }
+  'returns': ['GuestDeviceInfo'],
+  'if': 'CONFIG_WIN32' }
 
 ##
 # @GuestAuthorizedKeys:
-- 
2.45.1


