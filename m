Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7F5D6007E
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 09:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDKEJ-0002Jn-QE; Tue, 19 Nov 2024 04:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tDKEI-0002JU-AG; Tue, 19 Nov 2024 04:09:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tDKEG-0007Xe-G8; Tue, 19 Nov 2024 04:09:02 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIL32Vr001271;
 Tue, 19 Nov 2024 09:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=9Y+pKTngvCEbsX6fkP72SW6YYOTBTO3Ktp9uJJ/Ox
 ZI=; b=r68lELd5pguEtqmTVIq+6zlb1ycr1IyHkftTZdEg/LQVsNkhdryXUrytd
 vGHS2XBJOzm5RxJgFGzofUuYzSaApQAk7la7B3wuTnA3OC490Nmw4wOncMSAg8Dg
 /3Foh/Cpqen0QsCM51qmdzvnbuuExHPtQK1Yp95taD79srUWttdSvVAWiyRBYrdh
 0gNtq7w0mHbsMcK9bw7ceYyA/rCKFSI/n9tYicWzdyIFmHxMTyqqU9TILL2HKoin
 RDA2CVQLWfX2CA0g6WdQwt99QRDzE+rCTuwYoEZxzcfjiHQRPIEZR8ZWkoktcVUF
 McH7M/j9kIfV3buhaXsgsnO+BcFOg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xjw7y4pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2024 09:08:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AJ97KoD023850;
 Tue, 19 Nov 2024 09:08:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xjw7y4p4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2024 09:08:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ8GtQa000576;
 Tue, 19 Nov 2024 09:08:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77kwf4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Nov 2024 09:08:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AJ98rlQ17891820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2024 09:08:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83B082004B;
 Tue, 19 Nov 2024 09:08:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1A9520043;
 Tue, 19 Nov 2024 09:08:52 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2024 09:08:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, anushree.mathur@linux.vnet.ibm.com
Subject: [PATCH] ppc/spapr: fix drc index mismatch for partially enabled vcpus
Date: Tue, 19 Nov 2024 14:38:49 +0530
Message-ID: <20241119090849.1335829-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wHJRj-YrR3zJxMWZ6CnJao3pOY7vAZoz
X-Proofpoint-ORIG-GUID: Myhx52lwl2QGyE3ZOY1IxW0tQC9-Lhei
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411190064
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

In case when vcpus are explicitly enabled/disabled in a non-consecutive
order within a libvirt xml, it results in a drc index mismatch during
vcpu hotplug later because the existing logic uses vcpu id to derive the
corresponding drc index which is not correct. Use env->core_index to
derive a vcpu's drc index as appropriate to fix this issue.

For ex, for the given libvirt xml config:
  <vcpus>
    <vcpu id='0' enabled='yes' hotpluggable='no'/>
    <vcpu id='1' enabled='yes' hotpluggable='yes'/>
    <vcpu id='2' enabled='no' hotpluggable='yes'/>
    <vcpu id='3' enabled='yes' hotpluggable='yes'/>
    <vcpu id='4' enabled='no' hotpluggable='yes'/>
    <vcpu id='5' enabled='yes' hotpluggable='yes'/>
    <vcpu id='6' enabled='no' hotpluggable='yes'/>
    <vcpu id='7' enabled='no' hotpluggable='yes'/>
  </vcpus>

We see below error on guest console with "virsh setvcpus <domain> 5" :

pseries-hotplug-cpu: CPU with drc index 10000002 already exists

This patch fixes the issue by using correct drc index for explicitly
enabled vcpus during init.

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c56..0d4efaa0c0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -701,7 +701,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
     uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
     int i;
 
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, env->core_index);
     if (drc) {
         drc_index = spapr_drc_index(drc);
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
-- 
2.45.2


