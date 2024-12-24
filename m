Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F276E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7bX-0003X1-GU; Tue, 24 Dec 2024 11:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bK-0003Ke-JO
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bH-0003ER-Ug
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:42 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfdUB017780;
 Tue, 24 Dec 2024 16:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=vw2xpykwEzrlZ3Wydg5Rxsf/Tba8R6HAn62ms0H1iLE=; b=
 jzoIH07fhPzW6DUNEm4hlSg1qqvHX84dYVFhHUl6W3kZEaqXzPFSkbj/cuPJ+BRH
 0sFXO15l9XHZEMY6CPkfuyucXaoZihIJxRryn/9tHKyQ4AlIWh/x5Y+AzsGFSRHq
 xb7GVq6AyyidrXOxuszcBd29WE9PGa+UpZDtDXU+Pyj8xQivlCuX114waImhT3w2
 uODPxKYS+IArAxH9h/HVt6hD9NUQ4/Q8YjkKBJXm24rIvQ/fuM0KiExF/4MAXYyV
 +9zeNpKVOqHs8yLAY6xVqkOiVQGv5cDwPROK99cNBB1xF9CEhPDg5qzHtuZ0DZgO
 AL3P6b8Ta6jGtVAvK91TsA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq9ycg1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOGG6Re022588; Tue, 24 Dec 2024 16:17:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:25 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9Y2021973;
 Tue, 24 Dec 2024 16:17:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-24; Tue, 24 Dec 2024 16:17:24 +0000
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
Subject: [PATCH V5 23/23] migration: cpr-transfer documentation
Date: Tue, 24 Dec 2024 08:17:08 -0800
Message-Id: <1735057028-308595-24-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-GUID: KhQpA_05SNT1hCDGtLonehhn7COh1g5P
X-Proofpoint-ORIG-GUID: KhQpA_05SNT1hCDGtLonehhn7COh1g5P
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 docs/devel/migration/CPR.rst | 182 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 180 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 63c3647..9b51611 100644
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
@@ -145,3 +145,181 @@ Caveats
 
 cpr-reboot mode may not be used with postcopy, background-snapshot,
 or COLO.
+
+cpr-transfer mode
+-----------------
+
+This mode allows the user to transfer a guest to a new QEMU instance
+on the same host with minimal guest pause time, by preserving guest
+RAM in place, albeit with new virtual addresses in new QEMU.  Devices
+and their pinned memory pages will also be preserved in a future QEMU
+release.
+
+The user starts new QEMU on the same host as old QEMU, with command-
+line arguments to create the same machine, plus the ``-incoming``
+option for the main migration channel, like normal live migration.
+In addition, the user adds a second -incoming option with channel
+type ``cpr``.  The CPR channel address must be a type, such as unix
+socket, that supports SCM_RIGHTS.
+
+To initiate CPR, the user issues a migrate command to old QEMU,
+adding a second migration channel of type ``cpr`` in the channels
+argument.  Old QEMU stops the VM, saves state to the migration
+channels, and enters the postmigrate state.  Execution resumes in
+new QEMU.
+
+New QEMU reads the CPR channel before opening a monitor, hence
+the CPR channel cannot be specified in the list of channels for a
+migrate-incoming command.  It may only be specified on the command
+line.
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
+The main incoming migration channel address cannot be a file type.
+
+If the main incoming channel address is a tcp type, then the port
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


