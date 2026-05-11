Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B9ECD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRcW-0006Ic-LF; Mon, 11 May 2026 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wintera@linux.ibm.com>)
 id 1wMR0n-0006YO-WC; Mon, 11 May 2026 09:49:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wintera@linux.ibm.com>)
 id 1wMR0m-0003nk-0N; Mon, 11 May 2026 09:49:33 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B7AHQq2780021; Mon, 11 May 2026 13:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=g2vwvtwOodnc0kYOAA/WbkJwarTtpLyRgnu/FsF+Z
 zs=; b=QME6DHNqqWxrJ61SOiqCADnjY8zDYmVbYX6t8WZttv6GK8BKI/LdEfe3Z
 GgR3ieigxGXDcv/cKMsyz3UJJaAek9BQSVbdctwsnxxrGuMCz3E78tktjgtRt+YT
 Xo3pvHkHbP3fQkhiZtJKD390DabygEx//KTfCX0NFAhCcFB89ZPE5xKqjiGLxMJE
 fbHUnJWHnh2S336vPBFxGHZ4Zcqfnz00GIwOUhp1YK6ZqSkToGd/AvggpvuVxbrE
 gp2iFjAEqNQ3IeSHBhdsoDh4DHhilWh+kErz8o/smiBXUgXw69vTL+CQmhfAkc9k
 sm4w9cdARlqYfHeabHLQYIL55nW6Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve70jqa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 13:49:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BDdY1k007665;
 Mon, 11 May 2026 13:49:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy585s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 13:49:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BDnIww13304096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 13:49:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 572202004B;
 Mon, 11 May 2026 13:49:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F086E20043;
 Mon, 11 May 2026 13:49:17 +0000 (GMT)
Received: from macbookpro.aag-de.ibm.com (unknown [9.52.217.250])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 13:49:17 +0000 (GMT)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Gautam Gala <ggala@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-s390x@nongnu.org,
 Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH] target/s390x: Make container ids in SysIB_15x 1-based
Date: Mon, 11 May 2026 15:49:09 +0200
Message-Id: <20260511134909.43802-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1MSBTYWx0ZWRfX4RmEbpJQ+SBW
 SroNvDg1q3/mVMehwyQ/Oj67glQox3NGlnHr06cJuWQUmHrS+W4snfAgjaBclI/0jmDIIgXX6NB
 g7WcfXeZUrkY4fy77zNfHByJHLkf5URdjexloh2M28JtI42VO5lJH5KP+a6jqwwxy7Y2cMzYuT8
 ZaopBohssPwq5nnmtMBEv4JtF+xk6XkIUI6NnNettkHH7F0dht2Iqi5bUTFlukC8/r4ul+T+eFS
 xKoLXZoTcFj2/T398kWFPcRgVWydgsmTuskQ9qa/4z0KrrpLKxt7AXFU6lyMqrcLQkAcSgrvUhG
 5Luqw2mtl22Uvky45NaRZLeMoef+NUMWnaXob6Jl3b4JzEfuCy81SUxryfi5nyJO2TB7+E1LD7R
 x/wBGyT0jlAfu2NZBXlDU5p9lluqM36XQjeYKaqe4pVm814AL5XUmfydkbBFkusfrq0s3mkulsY
 oOnkQ+mK/w3pik1zalg==
X-Proofpoint-GUID: 6Kwztrkm7jZ41G2agRk-9fcXJRZmx7yk
X-Proofpoint-ORIG-GUID: 6Kwztrkm7jZ41G2agRk-9fcXJRZmx7yk
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=6a01de64 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=q6vtooFActFUTKw_DCAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110151
Received-SPF: pass client-ip=148.163.156.1; envelope-from=wintera@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2026 10:28:30 -0400
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

The Container Id in a container-type TLE of SysIB_15x is defined as 8-bit
unsigned nonzero integer. Make stsi fc 15 emulation architecture compliant,
by starting the container ids at 1 for the lowest numbered container.

The qemu misbehaviour without this patch becomes obvious due to a recently
proposed kernel fix. Older linux kernels pass the container ids from stsi
fc15 unchanged to sysfs, i.e. starting at 1 on s390 hardware. This resulted
in off-by-one values when compared to the values from HMC. A Linux kernel
fix is being proposed to correct the sysfs topology ids by -1, so they
start at 0, e.g. when displayed by 'lscpu -ye'. In case a KVM guest with a
fixed kernel runs on a host with a qemu without this fix, this can result
in container ids erroneously being shown as 255.
Example (Fixed guest on unfixed qemu):
$ lscpu -ye
CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
  0    0    255  255    255    0 0:0:0         yes yes        vert-medium  0
  1    0    255  255      0    1 1:1:1         yes yes        vert-medium  1
After this fix:
$ lscpu -ye
CPU NODE DRAWER BOOK SOCKET CORE L1d:L1i:L2 ONLINE CONFIGURED POLARIZATION ADDRESS
  0    0      0    0      0    0 0:0:0         yes yes        vert-medium  0
  1    0      0    0      1    1 1:1:1         yes yes        vert-medium  1

Fixes: f4f54b582f ("target/s390x/cpu topology: handle STSI(15) and build the SYSIB")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 target/s390x/kvm/stsi-topology.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index 301d41b68d..afd00da0e6 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -90,9 +90,9 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
     int last_drawer = -1;
     int last_book = -1;
     int last_socket = -1;
-    int drawer_id = 0;
-    int book_id = 0;
-    int socket_id = 0;
+    int drawer_id = 1;
+    int book_id = 1;
+    int socket_id = 1;
     int n = sizeof(SysIB_151x);
 
     QTAILQ_FOREACH(entry, topology_list, next) {
@@ -103,12 +103,12 @@ static int stsi_topology_fill_sysib(S390TopologyList *topology_list,
         if (level > 3 && drawer_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
             p = fill_container(p, 3, drawer_id++);
-            book_id = 0;
+            book_id = 1;
         }
         if (level > 2 && book_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
             p = fill_container(p, 2, book_id++);
-            socket_id = 0;
+            socket_id = 1;
         }
         if (socket_change) {
             SYSIB_GUARD(n, sizeof(SYSIBContainerListEntry));
-- 
2.39.5 (Apple Git-154)


