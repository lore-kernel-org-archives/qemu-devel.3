Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF74ECA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umFUN-0003xf-QP; Wed, 13 Aug 2025 13:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUI-0003we-LK; Wed, 13 Aug 2025 13:42:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUG-0006Zk-F4; Wed, 13 Aug 2025 13:42:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DCI7ax011380;
 Wed, 13 Aug 2025 17:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=YyvUOIRykNHVykrmlLSSB/p1FGJ3sKLzq7Df8woU/
 lo=; b=HY4vw1mkTscDRttOpvAYvDB1h33UMUW1dTRl2ddAUnaLN4vtdRPekX1M1
 4zSTUcsLLQNg9A3GI/5SqtJA6VpNDxDuSw9N9aBqpm/DHN5MIoYKU4j1R4g1t+Vt
 WQ9DuFPZQTnIcnuXVTkQK/YTECd4s+3zPcmMUVtguh00LQGm+ulM8r8tP2HS37Hb
 viSO1Z5Eg6kcrKU9NzHwMHaS1egfPgjXtWQZo10+mLs7FHcMM2y4Als2bxDlvzZa
 oFe5RajVPTaOvBwJ/o93vXV0UMQmniLHEHhBxcozZqEbZuLT17WmOyLsDPfXGXl5
 jU2CQkzZvwaX7qjacUpdOQ0koL3qw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2d5xu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DGxfC0017588;
 Wed, 13 Aug 2025 17:41:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3r3hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57DHfras5374656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 17:41:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3630F5805C;
 Wed, 13 Aug 2025 17:41:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A591B58065;
 Wed, 13 Aug 2025 17:41:52 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.61])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Aug 2025 17:41:52 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, alifm@linux.ibm.com
Subject: [PATCH v1 0/4] Error recovery for zPCI passthrough devices
Date: Wed, 13 Aug 2025 10:41:47 -0700
Message-ID: <20250813174152.1238-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX9k9DCLztDt95
 LBYOjqLhW+jUPgOkFB33i0sRK3UfNQ4i+Vlwo+VJ33eR/GLRc5Yw6SIbEHtqcJn+tNZLAxxKpdv
 5sK4Ug+sC+jifSYLwVNzDCoKdbAUGOt8xBYl7r4V8irGWItdcbt1R6OX147DzTg/Id5RSz7MwwP
 z2TM4pTQLQCDDWRwC1b5Jn8OeDuTWPjwfo3logQdhHVc2b16YIT4Q45cqQGRrn09Pq5JUPhs7f1
 KtnQVxwySPh/rFE7IQDiTTsaNQb8OwSgw6xmKhZsInL4meMtZ4EY/DubAn3oRVOmZGE/UvIl2tl
 8S+gzkYaP/8rOuhql5NbfMkdwbpxqLMeT2JVPvMkon/7cXiaoJDDdOLLPelEhikigHmHHCTAOHV
 c55sGk4g
X-Proofpoint-GUID: zyFVwo05i_Gbd7qZRcuTnuyQmQyyXv88
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689cce63 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=teYI-SuHLMPDejC4iewA:9
X-Proofpoint-ORIG-GUID: zyFVwo05i_Gbd7qZRcuTnuyQmQyyXv88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

This patch series introduces support for error recovery for passthrough
PCI devices on System Z (s390x). This is the user space component for the Linux
kernel patches [1]. For QEMU on eventfd notification for PCI error from vfio-pci
driver we call the vfio error handler. We can use an architecture specific error
handler to override the default vfio error handler. 

For s390x specific error handler, we retrieve the architecture specific PCI error
information and inject the information into the guest. Once the guest receives
the error information, the guest drivers will drive the error recovery.
Typically recovery involves a device reset which translate to CLP
disable/enable cycle for the device.

I would appreciate some feedback on this patch series to understand if
such an approach is acceptable.

Thanks
Farhan

[1] https://lore.kernel.org/linux-s390/20250813170821.1115-1-alifm@linux.ibm.com/T/#m7c763e718501a2bbd77f0356f8845b77545d61e1

Farhan Ali (4):
  [NOTFORMERGE] linux-headers: Update for zpci vfio device
  vfio/pci: Add an architecture specific error handler
  s390x/pci: Add PCI error handling for vfio pci devices
  s390x/pci: Reset a device in error state

 hw/s390x/s390-pci-bus.c          | 12 +++++
 hw/s390x/s390-pci-vfio.c         | 88 ++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                    |  5 ++
 hw/vfio/pci.h                    |  1 +
 include/hw/s390x/s390-pci-bus.h  |  1 +
 include/hw/s390x/s390-pci-vfio.h |  4 ++
 linux-headers/linux/vfio.h       |  2 +
 linux-headers/linux/vfio_zdev.h  |  5 ++
 8 files changed, 118 insertions(+)

-- 
2.43.0


