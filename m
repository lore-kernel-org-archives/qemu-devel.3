Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8B2C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 13:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUYE-0006KK-Ty; Tue, 04 Jun 2024 09:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUYB-0006G9-KR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEUY9-00030I-JR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 09:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z94RVWGhmgprFDgNWzzyY8A22XFBTDl+EjlYBNvlIWo=;
 b=M3crU2Es9kL/6nUNhhDZQEpCGIYVDIffnBB65ehn1DE+kvpWAYD8xMM3VxczGjokZCU2CC
 dJnF/hkBpkKR5iaotwMxs19iyKKBrvgDXo8J8MOULMy7NFmiKLCyS/tdLK8EMYqvdZrLO0
 ygHdCg8ooJTZSqOAjV1/gv/8/LCAvbQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-3kBlEO4_MEqj1fHoDQK4Cg-1; Tue, 04 Jun 2024 09:50:02 -0400
X-MC-Unique: 3kBlEO4_MEqj1fHoDQK4Cg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE6AB8007BB;
 Tue,  4 Jun 2024 13:50:01 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 802F3C15C4A;
 Tue,  4 Jun 2024 13:49:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 11/20] qga: conditionalize schema for commands requiring
 linux/win32
Date: Tue,  4 Jun 2024 14:49:24 +0100
Message-ID: <20240604134933.220112-12-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-1-berrange@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

Some commands were blocked based on CONFIG_FSFREEZE, but their
impl had nothing todo with CONFIG_FSFREEZE, and were instead
either Linux-only, or Win+Linux-only.

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the stats and fsinfo commands on
platforms that can't support them.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-bsd.c   | 24 -----------------------
 qga/commands-posix.c | 30 ++---------------------------
 qga/qapi-schema.json | 45 +++++++++++++++++++++++++++-----------------
 3 files changed, 30 insertions(+), 69 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 17bddda1cf..9ce48af311 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -149,30 +149,6 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
     }
     return ret;
 }
-
-GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
 #endif /* CONFIG_FSFREEZE */
 
 #ifdef HAVE_GETIFADDRS
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 09d08ee2ca..838dc3cf98 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1146,12 +1146,6 @@ error:
 
 #if !defined(CONFIG_FSFREEZE)
 
-GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
 GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
 {
     error_setg(errp, QERR_UNSUPPORTED);
@@ -1181,25 +1175,6 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     return 0;
 }
-
-GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
-GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-
 #endif /* CONFIG_FSFREEZE */
 
 #if !defined(CONFIG_FSTRIM)
@@ -1217,10 +1192,9 @@ GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 #if !defined(CONFIG_FSFREEZE)
     {
         const char *list[] = {
-            "guest-get-fsinfo", "guest-fsfreeze-status",
+            "guest-fsfreeze-status",
             "guest-fsfreeze-freeze", "guest-fsfreeze-freeze-list",
-            "guest-fsfreeze-thaw", "guest-get-fsinfo",
-            "guest-get-disks", NULL};
+            "guest-fsfreeze-thaw", NULL};
         char **p = (char **)list;
 
         while (*p) {
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c37c904aae..700c5baa5a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -869,7 +869,8 @@
 { 'enum': 'GuestDiskBusType',
   'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
             'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi',
-            'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ] }
+            'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 
 ##
@@ -887,7 +888,8 @@
 ##
 { 'struct': 'GuestPCIAddress',
   'data': {'domain': 'int', 'bus': 'int',
-           'slot': 'int', 'function': 'int'} }
+           'slot': 'int', 'function': 'int'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestCCWAddress:
@@ -906,7 +908,8 @@
   'data': {'cssid': 'int',
            'ssid': 'int',
            'subchno': 'int',
-           'devno': 'int'} }
+           'devno': 'int'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestDiskAddress:
@@ -935,7 +938,8 @@
            'bus-type': 'GuestDiskBusType',
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str',
-           '*ccw-address': 'GuestCCWAddress'} }
+           '*ccw-address': 'GuestCCWAddress'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestNVMeSmart:
@@ -972,7 +976,8 @@
            'media-errors-lo': 'uint64',
            'media-errors-hi': 'uint64',
            'number-of-error-log-entries-lo': 'uint64',
-           'number-of-error-log-entries-hi': 'uint64' } }
+           'number-of-error-log-entries-hi': 'uint64' },
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestDiskSmart:
@@ -986,7 +991,8 @@
 { 'union': 'GuestDiskSmart',
   'base': { 'type': 'GuestDiskBusType' },
   'discriminator': 'type',
-  'data': { 'nvme': 'GuestNVMeSmart' } }
+  'data': { 'nvme': 'GuestNVMeSmart' },
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestDiskInfo:
@@ -1011,7 +1017,8 @@
 { 'struct': 'GuestDiskInfo',
   'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
            '*address': 'GuestDiskAddress', '*alias': 'str',
-           '*smart': 'GuestDiskSmart'} }
+           '*smart': 'GuestDiskSmart'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @guest-get-disks:
@@ -1024,7 +1031,8 @@
 # Since: 5.2
 ##
 { 'command': 'guest-get-disks',
-  'returns': ['GuestDiskInfo'] }
+  'returns': ['GuestDiskInfo'],
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestFilesystemInfo:
@@ -1050,7 +1058,8 @@
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
-           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']} }
+           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @guest-get-fsinfo:
@@ -1063,7 +1072,8 @@
 # Since: 2.2
 ##
 { 'command': 'guest-get-fsinfo',
-  'returns': ['GuestFilesystemInfo'] }
+  'returns': ['GuestFilesystemInfo'],
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @guest-set-user-password:
@@ -1703,7 +1713,8 @@
            '*ios-pgr': 'uint64',
            '*total-ticks': 'uint64',
            '*weight-ticks': 'uint64'
-           } }
+           },
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestDiskStatsInfo:
@@ -1721,7 +1732,7 @@
            'major': 'uint64',
            'minor': 'uint64',
            'stats': 'GuestDiskStats' },
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @guest-get-diskstats:
@@ -1734,7 +1745,7 @@
 ##
 { 'command': 'guest-get-diskstats',
   'returns': ['GuestDiskStatsInfo'],
-  'if': 'CONFIG_POSIX'
+  'if': 'CONFIG_LINUX'
 }
 
 ##
@@ -1748,7 +1759,7 @@
 ##
 { 'enum': 'GuestCpuStatsType',
   'data': [ 'linux' ],
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 
 ##
@@ -1794,7 +1805,7 @@
            '*guest': 'uint64',
            '*guestnice': 'uint64'
            },
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @GuestCpuStats:
@@ -1809,7 +1820,7 @@
   'base': { 'type': 'GuestCpuStatsType' },
   'discriminator': 'type',
   'data': { 'linux': 'GuestLinuxCpuStats' },
-  'if': 'CONFIG_POSIX' }
+  'if': 'CONFIG_LINUX' }
 
 ##
 # @guest-get-cpustats:
@@ -1822,5 +1833,5 @@
 ##
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats'],
-  'if': 'CONFIG_POSIX'
+  'if': 'CONFIG_LINUX'
 }
-- 
2.45.1


