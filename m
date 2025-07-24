Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502F5C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesqa-0008HS-4S; Thu, 24 Jul 2025 06:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqV-0008EZ-6v; Thu, 24 Jul 2025 06:06:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uesqS-0006cG-P4; Thu, 24 Jul 2025 06:06:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O2cnAD021858;
 Thu, 24 Jul 2025 10:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=2WH4DXpyx3CG2cvsUZrSxDp3Ac3c
 rA8j3jPl43IArrk=; b=Rr0wbtGiRIp4kDxj2GVxMtppF6jk+knC8TrfH7RPVzNa
 2rc5RMY3sksjY5jJ6fjpyuFRbtM5m2r3M0DbeJQjy4GRo/bGM3O39d+e2cuwGpNn
 h1m3exGNCik3nnSgdtMl8tMnBPn9Hre7gJP4YnwLjhp4+5Ma0fb9PO3eXml3d3VJ
 6G6c57gnbn84oO3rDapNXZY/MpA87GexcjS+XixZuDp5jmKNU1FKlsmC2siZzBxy
 2cokj4rX2kluMthfWWIXZzproTWHf2x/26eoaTwx+ye6cCKZ9ebYj3pbmLIFZAVK
 luA00jxGdF2hGlD/oe2WsWaoQ4Sel5B5eE4hiZPgow==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbhyfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56OA4xxZ020273;
 Thu, 24 Jul 2025 10:06:33 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffbhyfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6h4TC024964;
 Thu, 24 Jul 2025 10:06:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptv6rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 10:06:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56OA6S2r57082350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 10:06:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DC2C2007A;
 Thu, 24 Jul 2025 10:06:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EB872007B;
 Thu, 24 Jul 2025 10:06:26 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 10:06:26 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v2 0/5] MAINTAINERS updates for ppc/spapr/pnv/xive
Date: Thu, 24 Jul 2025 15:36:14 +0530
Message-ID: <20250724100623.3071131-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5K_C0Ew7fKFABLQ3NcmTi3LPi3gMngZc
X-Authority-Analysis: v=2.4 cv=De8XqutW c=1 sm=1 tr=0 ts=688205a9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10
 a=UmFCVzT0ErLeyuHn1OIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _oyRRMJAOXYJj6c7QbTqSGqA8SDKp8Gv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA2NyBTYWx0ZWRfX0FwU5Fga3vJT
 oKat3C7EKQExKOSYwlOXYwipz2TT6jizl28wNVTSfb99BUVTbDYDj0olc612F/ws6XFPToapF4k
 CZmbOfVq0lpY0ySSpmc5NlLnB1AWENxvu+lwNIb9WaZDm8cwA8A6x0rDsJ26udK3ZPUUd7uVz0p
 /PQ3YnChEAG5X9zfq/c5ADjFHJDiYIOboU9RrA24D/ZkBVDkCxX6tY8b9dR81xuuhOJzQEj7POw
 ErXXn0QT0FnNKgt+bsb30iMyGBfWnB2YLUKupz14IUXrK4MXagGDui50VjBMA2C+Lbyz2bzL5uI
 gAXJo4ZeTeNK8XKOHm5gdJixh42//6RPBp9U2WjHTbgFtYcGxKCoTjm8nI3Uoru7Z4j5AvtQ+Mg
 v7sJcuOMPvdUV2fQyiF1Dwt2wxy7ISxIT/xV+olb8YlONAK/v/HOb+IwyeuktsSvis07Jq81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=554
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some of us at IBM have been actively working/contributing in
ppc/spapr/pnv/xive and would like to step up to help with
reviews and co-maintainer activities. I have also included proposal
patches from Chinmay and Aditya in this patchset which had already
been posted to list earlier to request for merge.

Thanks
Harsh

Changelog:
v2: Added my S-o-b as suggested by Philippe, Cedric
v1: Initial patchset

Aditya Gupta (1):
  MAINTAINERS: Add myself as a reviewer of PowerNV emulation

Chinmay Rath (1):
  MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs

Gautam Menghani (1):
  MAINTAINERS: Add myself as a reviewer for XIVE

Harsh Prateek Bora (2):
  MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr
  MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.43.5


