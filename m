Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1658C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6NM-0002UP-7R; Fri, 10 Jul 2026 04:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wi6NJ-0002Tz-7D; Fri, 10 Jul 2026 04:14:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wi6NH-0002m8-8f; Fri, 10 Jul 2026 04:14:20 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A7mIck463349; Fri, 10 Jul 2026 08:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Ftl6dCsCYBFCfbAAwJuHFZIJKAhQc46Ndy87INLxK
 +g=; b=RjpHRkN6RMj0xAthDgfcs0DlXXR//aMqAKdcJZJQ3vAfvekDOxpkhcV6e
 UB9PxXME4+hfE2elXp2wxfxvRQ+5FEtCGPcPuP/winfDiSp8hURp2rPhGs6WwfB2
 yk1gvRdPUtdRA0bNrZ+TmpwPZPgEQBELUMAet33W06+aK010M1z5CedsTayr4JiR
 BsTE0mgmRMc8mQ1+fAvEy7ZVKm2STcT0Y/ohMmpYLZTIRKkDUmrsp+8/aSyFdzTm
 0yDZ1lXejJDSlf/4PXkL1orrCSz0eCxJ6s652lmaprUCvdkXWiYWky7v6WTFH5Ls
 HPVWjiXOxvd4rgwXw9mPAh75oECRA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0ayks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 08:14:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A84bbY030115;
 Fri, 10 Jul 2026 08:14:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwh99y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 08:14:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66A8EAFv23724388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 08:14:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2DFE20043;
 Fri, 10 Jul 2026 08:14:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1474A2004B;
 Fri, 10 Jul 2026 08:14:08 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 08:14:07 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, harshpb@linux.ibm.com,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH] docs: Update qmp scripts path
Date: Fri, 10 Jul 2026 13:44:02 +0530
Message-ID: <20260710081402.93045-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a50a9d7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=0Xz6S3jdke2Nq1A_s-sA:9
X-Proofpoint-GUID: W5UGbR6WSrchgrisCxTq7jcWEZ1LlQUE
X-Proofpoint-ORIG-GUID: W5UGbR6WSrchgrisCxTq7jcWEZ1LlQUE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX74saZSMn1Bdk
 fbao34fiVFgmM6qv3kdBmcV4NiGJebd7KXshjFHVavtI41YZA6VFGlNKGIBHBuJ4xHZbE2rKf+O
 ALoQ7Az0a/S1nPvv5ggbDbaNAcZQc48=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfXxR4bFpe+ENzs
 D7POEFZrE3N6UqRVmJP4Hj5Y04H+bWNifQwRXpSpcVHicHnSQUiGGSGBZgzITYWmeLZ5OLNmtDI
 RZcLyslXcd8ueffm2s5nyHuhnVRR0FpMB3iDqqIssMyoDUlYCgGGia4adUE/iORofWqdY7Y/dEQ
 qudj/AFLbiV6KVJ1/Yx8HhQ0Ow8EGxsH2APj7gp9+OldameHn9EuloY4sVdXOoRhprhU9HHKDX9
 eYwSHPu0nEPsZnXe+fi8wR1NdeLgCxBfMSMRUpszZJpKPzn/LSTTkdtqfujJIxQeZOvr0QnUbwy
 oZkooOGMwysGMf8LWVa7xplFWfXA3Po/NRWzTOD+8KPOZyZ6YzaadAcDna/6PM0U8u0faMH6Mvv
 /3eB75EcePJyNyl0BuaBybWE7sgvtnHzASXgDrak2njj89V1BEchM1jjGQOiLIYVJEXiMoSX/Ld
 mvH9WjWjABCmqThvakg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100074
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Qmp scripts are essentially removed from scripts directory as per commit
b08e111b1e1 ("scripts: nudge users to use 'run' script for scripts that
import qemu.qmp"). Scripts essentially redirect to run build/run script.
Reflecting the same changes on docs.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 docs/devel/build-system.rst            |  2 +-
 docs/interop/live-block-operations.rst | 10 +++++-----
 docs/system/arm/cpu-features.rst       |  5 +++--
 docs/system/devices/usb.rst            |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 71331e64ac..052eac7c51 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -521,7 +521,7 @@ Built by configure:
   before running the requested command. Pass the command to run as
   args, for example::
 
-    $ ./build/run ./script/qmp/qmp-shell-wrap qemu-system-x86_64
+    $ ./build/run qmp-shell-wrap qemu-system-x86_64
 
   will use the ``python3`` binary and site-packages from the local
   venv to run ``qmp-shell-wrap`` and spawn the QEMU emulator from
diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index 6b549ede7c..f8beb66275 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -152,12 +152,12 @@ of QEMU 2.9, accept ``node-name`` parameter) when performing various
 block operations.
 
 To interact with the QEMU instance launched above, we will use the
-``qmp-shell`` utility (located at: ``qemu/scripts/qmp``, as part of the
-QEMU source directory), which takes key-value pairs for QMP commands.
-Invoke it as below (which will also print out the complete raw JSON
-syntax for reference -- examples in the following sections)::
+``qmp-shell`` utility (available via the ``run`` script in the build
+directory after running configure), which takes key-value pairs for QMP
+commands.  Invoke it as below (which will also print out the complete raw
+JSON syntax for reference -- examples in the following sections)::
 
-    $ ./qmp-shell -v -p /tmp/qmp-sock
+    $ $builddir/run qmp-shell -v -p /tmp/qmp-sock
     (QEMU)
 
 .. note::
diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 10b0eff27e..c56f5fe208 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -36,8 +36,9 @@ CPU Feature Probing
 
 Determining which CPU features are available and functional for a given
 CPU type is possible with the ``query-cpu-model-expansion`` QMP command.
-Below are some examples where ``scripts/qmp/qmp-shell`` (see the top comment
-block in the script for usage) is used to issue the QMP commands.
+Below are some examples where ``qmp-shell`` (available via
+``$builddir/run qmp-shell`` after running configure) is used to issue the
+QMP commands.
 
 1. Determine which CPU features are available for the ``max`` CPU type
    (Note, we started QEMU with qemu-system-aarch64, so ``max`` is
diff --git a/docs/system/devices/usb.rst b/docs/system/devices/usb.rst
index dc694d23c2..7e2a303f41 100644
--- a/docs/system/devices/usb.rst
+++ b/docs/system/devices/usb.rst
@@ -258,7 +258,7 @@ device visible to the guest. The workflow looks like this:
 #. ``device-add usb-bot,id=foo``
 #. ``device-add scsi-{hd,cd},bus=foo.0,lun=0``
 #. optionally add more devices (luns 1 ... 15)
-#. ``scripts/qmp/qom-set foo.attached = true``
+#. ``$builddir/run qom-set foo.attached = true``
 
 .. _host_005fusb_005fdevices:
 
-- 
2.54.0


