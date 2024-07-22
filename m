Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05436C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVn47-0002Vo-3n; Mon, 22 Jul 2024 03:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3s-0001S8-CM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sVn3n-0006Xd-Ti
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721631729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGBUTi+kEzU/5R5vJJYayJk8oJTN0dkMbx5vlt8m6pI=;
 b=FORWrLGjbNHmlm482ZmXlQgr0Gx7967a73IXbukovymzgvWTkFZLaQ0jTNVjQzywh8MtaO
 Z+Fj1J0lUMJd8Ea/Y6c0/4ZMzCJKu+3XveG/YwmgdxNqDkX2hWCoFxH4K3gXtSVe3btM0p
 Lkk2UibhJtfbG2v4Cr6SQjRPJFirvDc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-HolEwKP9NDK-vJOirmycfg-1; Mon,
 22 Jul 2024 03:02:05 -0400
X-MC-Unique: HolEwKP9NDK-vJOirmycfg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCC4B1955D55; Mon, 22 Jul 2024 07:02:04 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.252])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 428921944A9A; Mon, 22 Jul 2024 07:01:50 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 11/25] qga: conditionalize schema for commands requiring
 linux/win32
Date: Mon, 22 Jul 2024 10:01:08 +0300
Message-ID: <20240722070122.27615-12-kkostiuk@redhat.com>
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

Some commands were blocked based on CONFIG_FSFREEZE, but their
impl had nothing todo with CONFIG_FSFREEZE, and were instead
either Linux-only, or Win+Linux-only.

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the stats and fsinfo commands on
platforms that can't support them.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-12-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
index 79ed4f0e21..9bd5aa53bc 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -870,7 +870,8 @@
 { 'enum': 'GuestDiskBusType',
   'data': [ 'ide', 'fdc', 'scsi', 'virtio', 'xen', 'usb', 'uml', 'sata',
             'sd', 'unknown', 'ieee1394', 'ssa', 'fibre', 'raid', 'iscsi',
-            'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ] }
+            'sas', 'mmc', 'virtual', 'file-backed-virtual', 'nvme' ],
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 
 ##
@@ -888,7 +889,8 @@
 ##
 { 'struct': 'GuestPCIAddress',
   'data': {'domain': 'int', 'bus': 'int',
-           'slot': 'int', 'function': 'int'} }
+           'slot': 'int', 'function': 'int'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestCCWAddress:
@@ -907,7 +909,8 @@
   'data': {'cssid': 'int',
            'ssid': 'int',
            'subchno': 'int',
-           'devno': 'int'} }
+           'devno': 'int'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestDiskAddress:
@@ -936,7 +939,8 @@
            'bus-type': 'GuestDiskBusType',
            'bus': 'int', 'target': 'int', 'unit': 'int',
            '*serial': 'str', '*dev': 'str',
-           '*ccw-address': 'GuestCCWAddress'} }
+           '*ccw-address': 'GuestCCWAddress'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestNVMeSmart:
@@ -973,7 +977,8 @@
            'media-errors-lo': 'uint64',
            'media-errors-hi': 'uint64',
            'number-of-error-log-entries-lo': 'uint64',
-           'number-of-error-log-entries-hi': 'uint64' } }
+           'number-of-error-log-entries-hi': 'uint64' },
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestDiskSmart:
@@ -987,7 +992,8 @@
 { 'union': 'GuestDiskSmart',
   'base': { 'type': 'GuestDiskBusType' },
   'discriminator': 'type',
-  'data': { 'nvme': 'GuestNVMeSmart' } }
+  'data': { 'nvme': 'GuestNVMeSmart' },
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestDiskInfo:
@@ -1012,7 +1018,8 @@
 { 'struct': 'GuestDiskInfo',
   'data': {'name': 'str', 'partition': 'bool', '*dependencies': ['str'],
            '*address': 'GuestDiskAddress', '*alias': 'str',
-           '*smart': 'GuestDiskSmart'} }
+           '*smart': 'GuestDiskSmart'},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @guest-get-disks:
@@ -1025,7 +1032,8 @@
 # Since: 5.2
 ##
 { 'command': 'guest-get-disks',
-  'returns': ['GuestDiskInfo'] }
+  'returns': ['GuestDiskInfo'],
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @GuestFilesystemInfo:
@@ -1051,7 +1059,8 @@
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
-           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']} }
+           '*total-bytes-privileged': 'uint64', 'disk': ['GuestDiskAddress']},
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX' ] } }
 
 ##
 # @guest-get-fsinfo:
@@ -1064,7 +1073,8 @@
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
2.45.2


