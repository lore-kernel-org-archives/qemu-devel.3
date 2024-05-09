Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C89AC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 19:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s59E2-0008AX-DD; Thu, 09 May 2024 15:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1s59Dr-00087l-Lw; Thu, 09 May 2024 15:14:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1s59Do-0003lD-Qj; Thu, 09 May 2024 15:14:30 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 449J29t1001876; Thu, 9 May 2024 19:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : from : to : cc
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=qzCEGxxoE4Gk0vI6CCISnG8LnPo3AA24mRp9PWFkId8=;
 b=lcXfa1j0f80xKzPF4XpK6lRto9B3DwzOKZBLGDXFosHZdL9mK0jTNKqQY1LjMUXWpePf
 hECB3IrcrVbLZgPodouW7gT2p8O4lsFIhSGkpqvpVvPOU0Dh01qHU3yWAZW2udYu1tpF
 W9eUqWPYaXdl49cnHS2W4GU2EqOLisOvdAj0ZaKJvwnV75T5OoVeCQ28jVGIJX3mU62e
 U1Un8UJr+umO3477z0l58uo81SZtdFU67ZzS/7/XB1Bsf1zoQ5aWFaIJm9aulHamwNpE
 heZw/4ceyiQdVqHh7TRI7TijyAIW9yDcBYKFiKgTMxX390Rnfe0lJUOa2zlwcEZ3Nt7y 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y13qar3ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 May 2024 19:14:12 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 449JECZm020391;
 Thu, 9 May 2024 19:14:12 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y13qar3e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 May 2024 19:14:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 449IRIjE017553; Thu, 9 May 2024 19:14:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xysht4n48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 May 2024 19:14:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 449JE5A732571978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 May 2024 19:14:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEC302004D;
 Thu,  9 May 2024 19:14:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39ADB2004E;
 Thu,  9 May 2024 19:14:04 +0000 (GMT)
Received: from ltcd48-lp2.aus.stglabs.ibm.com (unknown [9.3.101.175])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 May 2024 19:14:04 +0000 (GMT)
Subject: [PATCH] vfio: container: Fix missing allocation of VFIOSpaprContainer
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, sbhat@linux.ibm.com,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 zhenzhong.duan@intel.com, qemu-devel@nongnu.org
Date: Thu, 09 May 2024 14:14:03 -0500
Message-ID: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fgSpq5bt5fkOMJaPnKs284KTsghczeOQ
X-Proofpoint-ORIG-GUID: hgEqH-KO2_KD-IgDvAsKAaAG6jMYEohE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_10,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405090135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The commit 6ad359ec29 "(vfio/spapr: Move prereg_listener into
spapr container)" began to use the newly introduced VFIOSpaprContainer
structure.

After several refactors, today the container_of(container,
VFIOSpaprContainer, ABC) is used when VFIOSpaprContainer is actually
not allocated. On PPC64 systems, this dereference is leading to corruption
showing up as glibc malloc assertion during guest start when using vfio.

Patch adds the missing allocation while also making the structure movement
to vfio common header file.

Fixes: 6ad359ec29 "(vfio/spapr: Move prereg_listener into spapr container)"
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/vfio/container.c           |    6 ++++--
 hw/vfio/spapr.c               |    6 ------
 include/hw/vfio/vfio-common.h |    6 ++++++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 77bdec276e..ecaf5786d9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -539,6 +539,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 {
     VFIOContainer *container;
     VFIOContainerBase *bcontainer;
+    VFIOSpaprContainer *scontainer;
     int ret, fd;
     VFIOAddressSpace *space;

@@ -611,7 +612,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto close_fd_exit;
     }

-    container = g_malloc0(sizeof(*container));
+    scontainer = g_malloc0(sizeof(*scontainer));
+    container = &scontainer->container;
     container->fd = fd;
     bcontainer = &container->bcontainer;

@@ -675,7 +677,7 @@ unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);

 free_container_exit:
-    g_free(container);
+    g_free(scontainer);

 close_fd_exit:
     close(fd);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 0d949bb728..78d218b7e7 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -24,12 +24,6 @@
 #include "qapi/error.h"
 #include "trace.h"

-typedef struct VFIOSpaprContainer {
-    VFIOContainer container;
-    MemoryListener prereg_listener;
-    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
-} VFIOSpaprContainer;
-
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
     if (memory_region_is_iommu(section->mr)) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9da6c08ef..010fa68ac6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -82,6 +82,12 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;

+typedef struct VFIOSpaprContainer {
+    VFIOContainer container;
+    MemoryListener prereg_listener;
+    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
+} VFIOSpaprContainer;
+
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;



