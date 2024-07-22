Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5231EC3DA70
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn48-0002kQ-7Q; Mon, 22 Jul 2024 03:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3t-0001SD-KD
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3r-0006Xy-2E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDm+bALEuRyr/I6SUsJtjqWPSF0aymjvBOySRpCpJs8=;
 b=S7G2scZnohl6jHqmmLONbFZN88aNpQIyw890B+WPZjtcNw90ldixdTOv1fqxx2fWxuDYxl
 ts01tGcUE8hC7ujHhf39h7IPQZ/7msYj8Za6yejBPYVIEEjLJ4kOQQs0iHAw82ZKh/nGJg
 EuWtEEA2kta+MBSvrfrUL6CSOedF9F4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-4nsZ5ngKMpyDclfZtx8Y6A-1; Mon,
 22 Jul 2024 03:02:11 -0400
X-MC-Unique: 4nsZ5ngKMpyDclfZtx8Y6A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFBB518EB1B5; Mon, 22 Jul 2024 07:02:04 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B05E6191C5C5; Mon, 22 Jul 2024 07:01:51 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 12/25] qga: conditionalize schema for commands only supported
 on Windows
Date: Mon, 22 Jul 2024 10:01:09 +0300
Message-ID: <20240722070122.27615-13-kkostiuk@redhat.com>
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-13-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
2.45.2


