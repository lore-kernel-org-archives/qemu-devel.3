Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E34F31E28
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAq91-0008Ms-UK; Thu, 09 Apr 2026 10:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wAq8y-0008MC-1P; Thu, 09 Apr 2026 10:14:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wAq8w-0000hP-9o; Thu, 09 Apr 2026 10:14:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639CB9RU2299314; Thu, 9 Apr 2026 14:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=XmwhI/+bp6xBgcb26bOsoNEpsyBXRkoa4vCt/Mxc5
 X4=; b=Dn8s4aUIzlTU67YYhAWWTmGa8Oy3p5AFp+EYfnBP8WZhzizKy0ARvHq9A
 K4vIKHQl3NzPW0k4OmgbGhYRKq6zL6KmL7kPFerb5/9Az1fiaNc/eTkpeKi9rv4N
 bpC0cUasEQt169NIxT5xQpeGuSJfEk9Fdhy1CQoyRkOxcyUgLF6i/H5jiAlKY8hN
 Q1Gb+lfON/NUJlSIl1Nq1xEIb58eAPRrj+VXHGV+lnSL0XxuGRzeUufBO4glJTV6
 6H6UrnqwFPcuV9K5wTH6wrGwNZQwx02lwhzdYkbsWVcFcgqY+qFg4PauWD3gp6D1
 N+Ukkm3SuQLbOSgo7HqApE3xcx47g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g4g6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 14:13:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 639Cx1PU013878;
 Thu, 9 Apr 2026 14:13:58 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4bvyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 14:13:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 639EDv6w29295196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Apr 2026 14:13:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E0C858056;
 Thu,  9 Apr 2026 14:13:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB40B58052;
 Thu,  9 Apr 2026 14:13:56 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown
 [9.61.93.104]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Apr 2026 14:13:56 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, clg@redhat.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, alex@shazbot.org, cohuck@redhat.com,
 Anthony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 0/2] Enable live migration of vfio-ap devices
Date: Thu,  9 Apr 2026 10:13:43 -0400
Message-ID: <20260409141352.997844-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d7b427 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=D19gQVrFAAAA:8 a=s1Sn9qFGmzIT4Zlq7skA:9
 a=W4TVW4IDbPiebHqcZpNg:22
X-Proofpoint-ORIG-GUID: qTMOa3XC8jTXLtnEfKi1UZOekzfHxBOF
X-Proofpoint-GUID: qTMOa3XC8jTXLtnEfKi1UZOekzfHxBOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEyNiBTYWx0ZWRfXyFyTFsFS+dvv
 nE7t+pQwsIgOQ22AIqdTbVI32PX9sTzIoM3PpMLgYqDnObF+ruiKtwGdXneLOd7fXqr8880c8r2
 H06eyFJy90gJ3mNDsGGMHDb25MlT4XIdKlH/Q7aOOZ3TYFzVFvhSO5vKI20D19uuHP/vShADXHr
 XwVmLYwa88vMkLUrSvk6IJyapX3ce185FTVV4A9LJcbnEw4r8Fp3XOONxXhTJ0ZhoLF523+O0oi
 dvnPp9NQm1QRqYTcmgPH7aKFqvzXTRHcepl83uGdFVs3/AUPxU05Xhme/ebtmN5D0DWprcxQYR5
 oK4JIFEss8fB3MneqrdPYvJKcf+SqmSh4yG6pFNMzE3f8UwuvINSLYC7yYjd6V8+YcBevwZ6wST
 KZGyfMgCgJ4QnPkEBkCGaG6svWmBUmJjJn50rXphXQln5q9vP2f5Dm1qWF8jyQbIl4mmcgN+20p
 af/7DC0Ve+DpbvP0rmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090126
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

This patch series enables live guest migration for s390 guests using
AP (Adjunct Processor) crypto devices passed through via the VFIO
framework.

The s390 AP architecture provides cryptographic coprocessor and accelerator
functions to guests. The vfio_ap device driver allows these AP devices to
be passed through to KVM guests, giving them access to the cryptographic 
capabilities of CEXxS crypto cards.

Previously, guests using vfio-ap devices could not be migrated because the
device was marked as unmigratable. This series implements the necessary
QEMU-side support to enable migration by:

* Removing the migration blocker and adding proper VMState infrastructure
* Implementing the VFIO migration callbacks that coordinate with the kernel
  vfio_ap driver to save and restore device state

The actual AP device state (queue configurations, crypto adapter
assignments, etc.) is managed entirely by the kernel vfio_ap driver and
transferred via the VFIO migration protocol. QEMU's role is to coordinate
the migration process and ensure proper sequencing of state transfers.

This implementation follows the standard VFIO migration framework used by
other VFIO device types (GPUs, network adapters, etc.) and integrates
cleanly with QEMU's existing migration infrastructure.

Dependencies:
------------
* Requires corresponding kernel patches that implement the VFIO migration
  protocol in the vfio_ap driver
    - see kernel patch series at https://lkml.org/lkml/2026/4/7/1991
* Kernel must support VFIO_DEVICE_FEATURE_MIGRATION for vfio-ap devices

Anthony  Krowiak (1):
  hw/vfio/ap: Callbacks for migration of guests with pass-through access
    to AP devices

Anthony Krowiak (1):
  hw/vfio/ap: Extend vfio device state description to facilitate live
    migration

 hw/vfio/ap.c | 60 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 11 deletions(-)

-- 
2.52.0


