Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1439CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gvk-0000Vu-L5; Mon, 22 Sep 2025 09:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvi-0000U5-1u
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v0gvX-0001vS-Ry
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:50:09 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NUbs030944;
 Mon, 22 Sep 2025 13:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=ktPqRcThKWBXTYTM1qYbZx9/j5hYFaBSqo8yG1rfiYw=; b=
 S1yDOLbXT9gU9lGTDBCvF3+ykUwBHAm+4R+akqgJEtnIQo9Aqs7AssyMdAV+YKIB
 DUtAKBpsqZVQqYfJY099nNPAOddrDbLJYt/zUSV5jsaF5ENCuGxu2K7EzoBRdxfg
 4CjYluqpaKYwB5SH8Vg4hggmFfGU/4G2PCM7RHZQ2LzCz73pwBrctD+lHnO61AGM
 VijaD1kRKmQw8qbpfaWnaRAvAE5BaJKJVmTPf+e8lax7lU75dd+L0IJQvgc9LkgZ
 2RnYNSgPUy3O68tPI6L95JbeAahp7Tcow9rkWQiMEYP7NmS9qfz8zmeOICwSXXPw
 9vtj7z9yzfQXekAQHsFTDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad2gn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58MCK1VJ034265; Mon, 22 Sep 2025 13:49:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6nhand4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Sep 2025 13:49:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58MDnlWP004351;
 Mon, 22 Sep 2025 13:49:57 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 49a6nhan6x-8; Mon, 22 Sep 2025 13:49:57 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 7/8] migration: cpr-exec docs
Date: Mon, 22 Sep 2025 06:49:44 -0700
Message-Id: <1758548985-354793-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220135
X-Proofpoint-ORIG-GUID: h9j0JwcsiRchurismf0oy5UAStcbPwLV
X-Proofpoint-GUID: h9j0JwcsiRchurismf0oy5UAStcbPwLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX623HsbeDWy3I
 Mkzcoi6bws83enM86qRphLLXh7tc2tQ+NBwSg65RzVlVgS7X+U+WXEzp7cl6okeX4gVYIabNmEW
 Xbw+4X5GVQhw5npip42gIyUojikkaBgNrlcMQlcGM7diwlUBxSP5mg1N32Mf+EcKNrv1LwVCphx
 iEvEDWp6rYAZK413MXBx+4RTCeKR7mE7bz4K/OmPzqo2fs1ra5CbV4FSgSGwizvkPdVKlL/U4DH
 W7TGa16W91ShSFl3VsWiWBuGL2RmPrdFdz8pqKnHOrWfydcZqEA+Ab1xY3S4Q/8m33orT0cwVjm
 Cdq8VYJBcScsDiyi6cf5WvmTbIl1PoRSm6vnl6X8LkqAbLVQMdiZEvF/J5r1276LR5RU6/omcUq
 ZI3uSIOXZhegH5qnGn2mV/u4Q6RCPg==
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d15406 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=Ierz01wVG17__kDJZf8A:9 cc=ntf
 awl=host:13614
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update developer documentation for cpr-exec mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/CPR.rst | 106 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 0a0fd4f..77fdbdd 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
 VM is migrated to a new QEMU instance on the same host.  It is
 intended for use when the goal is to update host software components
 that run the VM, such as QEMU or even the host kernel.  At this time,
-the cpr-reboot and cpr-transfer modes are available.
+the cpr-reboot, cpr-transfer, and cpr-exec modes are available.
 
 Because QEMU is restarted on the same host, with access to the same
 local devices, CPR is allowed in certain cases where normal migration
@@ -324,3 +324,107 @@ descriptors from old to new QEMU.  In the future, descriptors for
 vhost, and char devices could be transferred,
 preserving those devices and their kernel state without interruption,
 even if they do not explicitly support live migration.
+
+cpr-exec mode
+-------------
+
+In this mode, QEMU stops the VM, writes VM state to the migration
+URI, and directly exec's a new version of QEMU on the same host,
+replacing the original process while retaining its PID.  Guest RAM is
+preserved in place, albeit with new virtual addresses.  The user
+completes the migration by specifying the ``-incoming`` option, and
+by issuing the ``migrate-incoming`` command if necessary; see details
+below.
+
+This mode supports VFIO/IOMMUFD devices by preserving device
+descriptors and hence kernel state across the exec, even for devices
+that do not support live migration.
+
+Because the old and new QEMU instances are not active concurrently,
+the URI cannot be a type that streams data from one instance to the
+other.
+
+Usage
+^^^^^
+
+Arguments for the new QEMU process are taken from the
+@cpr-exec-command parameter.  The first argument should be the
+path of a new QEMU binary, or a prefix command that exec's the
+new QEMU binary, and the arguments should include the ''-incoming''
+option.
+
+Memory backend objects must have the ``share=on`` attribute.
+The VM must be started with the ``-machine aux-ram-share=on`` option.
+
+Outgoing:
+  * Set the migration mode parameter to ``cpr-exec``.
+  * Set the ``cpr-exec-command`` parameter.
+  * Issue the ``migrate`` command.  It is recommended that the URI be
+    a ``file`` type, but one can use other types such as ``exec``,
+    provided the command captures all the data from the outgoing side,
+    and provides all the data to the incoming side.
+
+Incoming:
+  * You do not need to explicitly start new QEMU.  It is started as
+    a side effect of the migrate command above.
+  * If the VM was running when the outgoing ``migrate`` command was
+    issued, then QEMU automatically resumes VM execution.
+
+Example 1: incoming URI
+^^^^^^^^^^^^^^^^^^^^^^^
+
+In these examples, we simply restart the same version of QEMU, but in
+a real scenario one would set a new QEMU binary path in
+cpr-exec-command.
+
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-memfd,id=ram0,size=4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+
+  QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-exec
+  (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
+  (qemu) migrate -d file:vm.state
+  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+
+Example 2: incoming defer
+^^^^^^^^^^^^^^^^^^^^^^^^^
+::
+
+  # qemu-kvm -monitor stdio
+  -object memory-backend-memfd,id=ram0,size=4G
+  -machine memory-backend=ram0
+  -machine aux-ram-share=on
+  ...
+
+  QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  VM status: running
+  (qemu) migrate_set_parameter mode cpr-exec
+  (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming defer
+  (qemu) migrate -d file:vm.state
+  (qemu) QEMU 10.2.50 monitor - type 'help' for more information
+  (qemu) info status
+  status: paused (inmigrate)
+  (qemu) migrate_incoming file:vm.state
+  (qemu) info status
+  VM status: running
+
+Caveats
+^^^^^^^
+
+cpr-exec mode may not be used with postcopy, background-snapshot,
+or COLO.
+
+cpr-exec mode requires permission to use the exec system call, which
+is denied by certain sandbox options, such as spawn.
+
+The guest pause time increases for large guest RAM backed by small pages.
-- 
1.8.3.1


