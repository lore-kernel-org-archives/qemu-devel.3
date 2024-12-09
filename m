Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE48BE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 19:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKjRs-0004eO-Lw; Mon, 09 Dec 2024 14:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKjRq-0004bj-6I; Mon, 09 Dec 2024 14:29:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tKjRo-0004Dd-4V; Mon, 09 Dec 2024 14:29:37 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HMaWR015339;
 Mon, 9 Dec 2024 19:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=a0f2yl+M33fCGC+mGaDEssw/u55tbXBtfvJx/KNvg
 gY=; b=tJNaRSzseuH1KI4rdA0olNHaHiMPJd2BKuAAwTk6X+OT9JXvFT04WbEq4
 w0pR29Te+8dB1QcJOzNrQEB6qsuuKdppK2ZW3UjSIA/mHGTMJ84J9doT8DnzMjoB
 wvF1ik71kPKKiCKNegnyQXKXFv1OVY134FQS6ypIU6TK4sU5HRaRflmeip17tz6o
 KQXnfkLLWTwcfmPK0HtNb3w9+8JTbgnSBicOb8zcNEZVvWnchYM3HHGcqtMOIvni
 nS6aNTNdC/Out5hPq8eYcwvltBLIBKFxGoKSz75am4N8mrv6tb8/EtbU2GCwoBHg
 JdoTJ8tciLTUNv0uHfI4WQdJHZ8tQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38k6an-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 19:29:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HUnTP032734;
 Mon, 9 Dec 2024 19:29:30 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps8a9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 19:29:30 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9JTTTl32375450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 19:29:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EFA258056;
 Mon,  9 Dec 2024 19:29:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A1CF58052;
 Mon,  9 Dec 2024 19:29:28 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.107.222]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2024 19:29:28 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clegoate@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 0/2] s390x/pci: relax I/O address translation requirement
Date: Mon,  9 Dec 2024 14:29:25 -0500
Message-ID: <20241209192927.107503-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ksSbGe9IfUStOrdgt1br_x1ze_9MYoBo
X-Proofpoint-ORIG-GUID: ksSbGe9IfUStOrdgt1br_x1ze_9MYoBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=612
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090151
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

This series introduces the concept of the relaxed translation requirement
for s390x guests in order to allow bypass of the guest IOMMU for more
efficient PCI passthrough.

With this series, QEMU can indicate to the guest that an IOMMU is not
strictly required for a zPCI device.  This would subsequently allow a
guest linux to use iommu.passthrough=1 and bypass their guest IOMMU for
PCI devices.

When this occurs, QEMU will note the behavior via an intercepted MPCIFC
instruction and will fill the host iommu with mappings of the entire
guest address space in response.

There is a kernel series [1] that adds the relevant behavior needed to
exploit this new feature from within a s390x linux guest.

[1]: https://lore.kernel.org/linux-s390/20241209192403.107090-1-mjrosato@linux.ibm.com/

Matthew Rosato (2):
  s390x/pci: add support for guests that request direct mapping
  s390x/pci: indicate QEMU supports relaxed translation for passthrough

 hw/s390x/s390-pci-bus.c         | 23 ++++++++++++++++++
 hw/s390x/s390-pci-inst.c        | 42 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-vfio.c        |  4 +++-
 include/hw/s390x/s390-pci-bus.h |  2 ++
 include/hw/s390x/s390-pci-clp.h |  1 +
 5 files changed, 69 insertions(+), 3 deletions(-)

-- 
2.47.0


