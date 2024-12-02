Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D18BD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6XG-0007JI-2p; Mon, 02 Dec 2024 08:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6M4-00086H-8T
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Lw-0005qq-L8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:42 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DFJ6t015023;
 Mon, 2 Dec 2024 13:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=yzUhmGyI6Anp6d6IumCZHkZ+5KaNq+VjA3ZSwUCd4Ng=; b=
 f1xhTTu5OJE/KnQH1S2JZbUbKQtg86EjJjqsei1FMzfLTbkgwFjnbSPw46cdTsGG
 d+JuQckUX8hP4G8EGO24riW/6n1FexawSVOKzuGsrh4DjY0vWn6o1u0KBV73FWhr
 eWff3zX25qkymG8hl2QtVYr9dbcPvt+sccf1zLZbSagz+qawO4d9/xzp+7AsvYUs
 cqJMeRfhVFhdadnoqo7Cz1oA0XVPfKJ0GNxyFN8nKDFBma63zGEs7kXAoHRJupge
 /pRAzZleIRpuJjCnNf8oq4px/Xzlesd+NW8M2HFiefimHrxWP47MWhkNBrJxMwZL
 MP8JkeSpIH3SmhVirI0+kw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smab035-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2CLJXA032060; Mon, 2 Dec 2024 13:20:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCFB032806;
 Mon, 2 Dec 2024 13:20:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-20; Mon, 02 Dec 2024 13:20:27 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 19/19] migration: cpr-transfer documentation
Date: Mon,  2 Dec 2024 05:20:11 -0800
Message-Id: <1733145611-62315-20-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-ORIG-GUID: rXQ__ndRcHuDRg6fFJyNdMC1lmIuwDf1
X-Proofpoint-GUID: rXQ__ndRcHuDRg6fFJyNdMC1lmIuwDf1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 docs/devel/migration/CPR.rst | 176 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 63c3647..a8a57c0 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
 VM is migrated to a new QEMU instance on the same host.  It is
 intended for use when the goal is to update host software components
 that run the VM, such as QEMU or even the host kernel.  At this time,
-cpr-reboot is the only available mode.
+the cpr-reboot and cpr-transfer modes are available.
 
 Because QEMU is restarted on the same host, with access to the same
 local devices, CPR is allowed in certain cases where normal migration
@@ -53,7 +53,7 @@ RAM is copied to the migration URI.
 Outgoing:
   * Set the migration mode parameter to ``cpr-reboot``.
   * Set the ``x-ignore-shared`` capability if desired.
-  * Issue the ``migrate`` command.  It is recommended the the URI be a
+  * Issue the ``migrate`` command.  It is recommended the URI be a
     ``file`` type, but one can use other types such as ``exec``,
     provided the command captures all the data from the outgoing side,
     and provides all the data to the incoming side.
@@ -145,3 +145,175 @@ Caveats
 
 cpr-reboot mode may not be used with postcopy, background-snapshot,
 or COLO.
+
+cpr-transfer mode
+-----------------
+
+This mode allows the user to transfer a guest to a new QEMU instance
+on the same host with minimal guest pause time, by preserving guest
+RAM in place, albeit with new virtual addresses in new QEMU.
+
+The user starts new QEMU on the same host as old QEMU, with the
+same arguments as old QEMU, plus the ``-incoming option``.  The user
+issues the migrate command to old QEMU, which stops the VM, saves
+state to the migration channels, and enters the postmigrate state.
+Execution resumes in new QEMU.
+
+This mode requires a second migration channel type "cpr" in the
+channel arguments on the outgoing side.  The channel must be a type,
+such as unix socket, that supports SCM_RIGHTS.  However, the cpr
+channel cannot be added to the list of channels for a migrate-incoming
+command, because it must be read before new QEMU opens a monitor.
+Instead, the user passes the channel as a second -incoming
+command-line argument to new QEMU using JSON syntax.
+
+Usage
+^^^^^
+
+Memory backend objects must have the ``share=on`` attribute.
+
+The VM must be started with the ``-machine aux-ram-share=on``
+option.  This causes implicit RAM blocks (those not described by
+a memory-backend object) to be allocated by mmap'ing a memfd.
+Examples include VGA and ROM.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-transfer``.
+  * Issue the ``migrate`` command, containing a main channel and
+    a cpr channel.
+
+Incoming:
+  * Start new QEMU with two ``-incoming`` options.
+  * If the VM was running when the outgoing ``migrate`` command was
+    issued, then QEMU automatically resumes VM execution.
+
+Caveats
+^^^^^^^
+
+cpr-transfer mode may not be used with postcopy, background-snapshot,
+or COLO.
+
+memory-backend-epc is not supported.
+
+The main incoming migration channel cannot be a file type.
+
+If the main incoming migration channel is a tcp type, then the port
+cannot be 0 (meaning dynamically choose a port).
+
+When using ``-incoming defer``, you must issue the migrate command to
+old QEMU before issuing any monitor commands to new QEMU, because new
+QEMU blocks waiting to read from the cpr channel before starting its
+monitor, and old QEMU does not write to the channel until the migrate
+command is issued.  However, new QEMU does not open and read the
+main migration channel until you issue the migrate incoming command.
+
+Example 1: incoming channel
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In these examples, we simply restart the same version of QEMU, but
+in a real scenario one would start new QEMU on the incoming side.
+Note that new QEMU does not print the monitor prompt until old QEMU
+has issued the migrate command.  The outgoing side uses QMP because
+HMP cannot specify a CPR channel.  Some QMP responses are omitted for
+brevity.
+
+::
+
+  Outgoing:                             Incoming:
+
+  # qemu-kvm -qmp stdio
+  -object memory-backend-file,id=ram0,size=4G,
+  mem-path=/dev/shm/ram0,share=on -m 4G
+  -machine aux-ram-share=on
+  ...
+                                        # qemu-kvm -monitor stdio
+                                        -incoming tcp:0:44444
+                                        -incoming '{"channel-type": "cpr",
+                                          "addr": { "transport": "socket",
+                                          "type": "unix", "path": "cpr.sock"}}'
+                                        ...
+  {"execute":"qmp_capabilities"}
+
+  {"execute": "query-status"}
+  {"return": {"status": "running",
+              "running": true}}
+
+  {"execute":"migrate-set-parameters",
+   "arguments":{"mode":"cpr-transfer"}}
+
+  {"execute": "migrate", "arguments": { "channels": [
+    {"channel-type": "main",
+     "addr": { "transport": "socket", "type": "inet",
+               "host": "0", "port": "44444" }},
+    {"channel-type": "cpr",
+     "addr": { "transport": "socket", "type": "unix",
+               "path": "cpr.sock" }}]}}
+
+                                        QEMU 10.0.50 monitor
+                                        (qemu) info status
+                                        VM status: running
+
+  {"execute": "query-status"}
+  {"return": {"status": "postmigrate",
+              "running": false}}
+
+Example 2: incoming defer
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+This example uses ``-incoming defer`` to hot plug a device before
+accepting the main migration channel.  Again note you must issue the
+migrate command to old QEMU before you can issue any monitor
+commands to new QEMU.
+
+
+::
+
+  Outgoing:                             Incoming:
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-file,id=ram0,size=4G,
+  mem-path=/dev/shm/ram0,share=on -m 4G
+  -machine aux-ram-share=on
+  ...
+                                        # qemu-kvm -monitor stdio
+                                        -incoming defer
+                                        -incoming '{"channel-type": "cpr",
+                                          "addr": { "transport": "socket",
+                                          "type": "unix", "path": "cpr.sock"}}'
+                                        ...
+  {"execute":"qmp_capabilities"}
+
+  {"execute": "device_add",
+   "arguments": {"driver": "pcie-root-port"}}
+
+  {"execute":"migrate-set-parameters",
+   "arguments":{"mode":"cpr-transfer"}}
+
+  {"execute": "migrate", "arguments": { "channels": [
+    {"channel-type": "main",
+     "addr": { "transport": "socket", "type": "inet",
+               "host": "0", "port": "44444" }},
+    {"channel-type": "cpr",
+     "addr": { "transport": "socket", "type": "unix",
+               "path": "cpr.sock" }}]}}
+
+                                        QEMU 10.0.50 monitor
+                                        (qemu) info status
+                                        VM status: paused (inmigrate)
+                                        (qemu) device_add pcie-root-port
+                                        (qemu) migrate_incoming tcp:0:44444
+                                        (qemu) info status
+                                        VM status: running
+
+  {"execute": "query-status"}
+  {"return": {"status": "postmigrate",
+              "running": false}}
+
+Futures
+^^^^^^^
+
+cpr-transfer mode is based on a capability to transfer open file
+descriptors from old to new QEMU.  In the future, descriptors for
+vfio, iommufd, vhost, and char devices could be transferred,
+preserving those devices and their kernel state without interruption,
+even if they do not explicitly support live migration.
-- 
1.8.3.1


