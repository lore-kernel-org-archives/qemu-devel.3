Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76A4D42BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtJy-0004u7-Td; Tue, 12 Nov 2024 11:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtEA-0001uM-RR; Tue, 12 Nov 2024 10:54:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE9-00014m-9D; Tue, 12 Nov 2024 10:54:50 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACFDPwx027302;
 Tue, 12 Nov 2024 15:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=UbQzkk6yX/miXkBk9rfY/spsUf+OqCta72267Ki8N
 l0=; b=m0w+/di+ZbsV52lFkwKHlpYoUulVQtWaWSN2vZeRO9bQ0r1S6iJRgHVed
 0K0yYW6bvI+q+JpmDJlFTEb5lX0qSQilvSZbjjD2hIiMuq3yvYy7wyZswak76lTe
 E8lH140IjohmA4pXmLTJcoirDeyk6PSShi6D2TYAbY3Dml+VpzYMibqESzxaR3Ed
 Bu/sVMooFCKOoMKbXimYzgN4Ll2iSngAE2ybiKUgP7PFS5CgB8yFv3E0x8eOJF/T
 MEe3m/YlALUrYeJRbd6oU3sNG251tmCD2oeChRAeeHC4b8wuveTsoCzoRiK+Gj0Y
 WZi+AZzajdMoq5sQpBy8u6wtVBDxQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v9020cg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEraNl008392;
 Tue, 12 Nov 2024 15:54:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjeyjyuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsZib58589444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F25920049;
 Tue, 12 Nov 2024 15:54:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E35A120040;
 Tue, 12 Nov 2024 15:54:34 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:34 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 00/14] KVM: s390: CPU model for gen17
Date: Tue, 12 Nov 2024 16:54:05 +0100
Message-ID: <20241112155420.42042-1-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 386r9VnGpZe0EBxHR0JfI8MqU7ijQchs
X-Proofpoint-GUID: 386r9VnGpZe0EBxHR0JfI8MqU7ijQchs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 11:00:38 -0500
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

Introducing the gen17 CPU model with feature indications
comprising of:

* Concurrent-function facility with subcodes
* More vector extensions
* Ineffective-nonconstrained-transaction facility
* Even more msa crypto extensions
* Additional PLO subfunctions


For reference, see also the kernel part:
https://lore.kernel.org/kvm/20241107152319.77816-1-brueckner@linux.ibm.com/T/#me506dc2ca538aee3cfc13620a48bdb686c459ab0

Feedback and review is always welcome.  Thanks a lot!

Kind regards,
Hendrik


Hendrik Brueckner (14):
  s390x/cpumodel: add msa10 subfunctions
  s390x/cpumodel: add msa11 subfunctions
  s390x/cpumodel: add msa12 changes
  s390x/cpumodel: add msa13 subfunctions
  s390x/cpumodel: Add ptff Query Time-Stamp Event (QTSE) support
  s390x/cpumodel: add Concurrent-functions facility support
  s390x/cpumodel: add Vector Enhancements facility 3
  s390x/cpumodel: add Miscellaneous-Instruction-Extensions Facility 4
  s390x/cpumodel: add Vector-Packed-Decimal-Enhancement facility 3
  s390x/cpumodel: add Ineffective-nonconstrained-transaction facility
  s390x/cpumodel: Add Sequential-Instruction-Fetching facility
  s390x/cpumodel: correct PLO feature wording
  s390x/cpumodel: Add PLO-extension facility
  s390x/cpumodel: gen17 model

 linux-headers/asm-s390/kvm.h        |   3 +-
 target/s390x/cpu_features.c         |   9 ++
 target/s390x/cpu_features.h         |   1 +
 target/s390x/cpu_features_def.h.inc |  94 ++++++++++++++-
 target/s390x/cpu_models.c           |  61 ++++++++++
 target/s390x/gen-features.c         | 174 ++++++++++++++++++++++++++++
 target/s390x/kvm/kvm.c              |   6 +
 7 files changed, 341 insertions(+), 7 deletions(-)

-- 
2.43.5


