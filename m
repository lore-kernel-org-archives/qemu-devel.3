Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4311FC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 10:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTJnY-0004mt-94; Fri, 26 Jan 2024 05:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTJn2-0004Zn-CD; Fri, 26 Jan 2024 05:50:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTJn0-00069U-9U; Fri, 26 Jan 2024 05:50:27 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40QAXCUv022066; Fri, 26 Jan 2024 10:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=M2vVOC3azFYi92MJqjrRP6gCv2KW7i9Frh/LBjpf+ik=;
 b=IHS1wbmx6aVefaqqa2xUOz2l5jEhqG0ylnyMKssIBtpCbKeUlJmEolbsFBkFyGYo4vGV
 GLY7SpdsR3VKia/OUOM/iXArXY18g/0U7lATHNdFsFAzIgZdlj2Tbs3IXe39jQCUcsse
 5s1WkH7gKiaCTbGpuCTZWX/kPuIx4oWr6PndWkDfEct6yCHtpEbrRVF3X9SoGuFEi7y/
 wxz4ahhSJYTAwKPagwG+10HanWDTiuOfRKYxIpXJ72Pfh2/xGAUhwp5CdCzPH8L6DXgm
 o9KpYho7kUTQUFMaqlgsOgO/aNRzcH0UDTasxpmtMAaGUAu0lLYpzuT7GMRrjiy/VIWw ug== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vvb32rbbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 10:50:02 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40QAZ7wb028621;
 Fri, 26 Jan 2024 10:50:01 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vvb32rbb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 10:50:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40QA2sw6026876; Fri, 26 Jan 2024 10:50:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgttj8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 10:50:00 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40QAnxc234996546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jan 2024 10:50:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC66158053;
 Fri, 26 Jan 2024 10:49:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB60958043;
 Fri, 26 Jan 2024 10:49:58 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jan 2024 10:49:58 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v12 00/11] Introduce model for IBM's FSI
Date: Fri, 26 Jan 2024 04:49:45 -0600
Message-Id: <20240126104956.74126-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z9l8x0xst3QNlL8Y5rBjxtsCoHBHGa-d
X-Proofpoint-ORIG-GUID: l0Gaekwu2do358YToTkBPSolXQurZdgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=290
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401260078
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

Please review the patch-set version 12.
I have incorporated review comments from Cedric.
v12:
  - Minor changes.
  - Added reviewed by tags.

Ninad Palsule (11):
  hw/fsi: Introduce IBM's Local bus
  hw/fsi: Introduce IBM's scratchpad device
  hw/fsi: Introduce IBM's FSI Bus
  hw/fsi: Introduce IBM's fsi-slave model
  hw/fsi: Introduce IBM's cfam
  hw/fsi: Introduce IBM's FSI master
  hw/fsi: Aspeed APB2OPB & On-chip peripheral bus
  hw/arm: Hook up FSI module in AST2600
  hw/fsi: Added qtest
  hw/fsi: Added FSI documentation
  hw/fsi: Update MAINTAINER list

 MAINTAINERS                     |   9 +
 docs/specs/fsi.rst              | 126 ++++++++++++
 docs/specs/index.rst            |   1 +
 meson.build                     |   1 +
 hw/fsi/trace.h                  |   1 +
 include/hw/arm/aspeed_soc.h     |   4 +
 include/hw/fsi/aspeed_apb2opb.h |  46 +++++
 include/hw/fsi/cfam.h           |  34 ++++
 include/hw/fsi/fsi-master.h     |  32 ++++
 include/hw/fsi/fsi.h            |  37 ++++
 include/hw/fsi/lbus.h           |  43 +++++
 hw/arm/aspeed_ast2600.c         |  19 ++
 hw/fsi/aspeed_apb2opb.c         | 329 ++++++++++++++++++++++++++++++++
 hw/fsi/cfam.c                   | 168 ++++++++++++++++
 hw/fsi/fsi-master.c             | 170 +++++++++++++++++
 hw/fsi/fsi.c                    | 102 ++++++++++
 hw/fsi/lbus.c                   | 117 ++++++++++++
 tests/qtest/aspeed-fsi-test.c   | 205 ++++++++++++++++++++
 hw/Kconfig                      |   1 +
 hw/arm/Kconfig                  |   1 +
 hw/fsi/Kconfig                  |   7 +
 hw/fsi/meson.build              |   2 +
 hw/fsi/trace-events             |  13 ++
 hw/meson.build                  |   1 +
 tests/qtest/meson.build         |   1 +
 25 files changed, 1470 insertions(+)
 create mode 100644 docs/specs/fsi.rst
 create mode 100644 hw/fsi/trace.h
 create mode 100644 include/hw/fsi/aspeed_apb2opb.h
 create mode 100644 include/hw/fsi/cfam.h
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 include/hw/fsi/fsi.h
 create mode 100644 include/hw/fsi/lbus.h
 create mode 100644 hw/fsi/aspeed_apb2opb.c
 create mode 100644 hw/fsi/cfam.c
 create mode 100644 hw/fsi/fsi-master.c
 create mode 100644 hw/fsi/fsi.c
 create mode 100644 hw/fsi/lbus.c
 create mode 100644 tests/qtest/aspeed-fsi-test.c
 create mode 100644 hw/fsi/Kconfig
 create mode 100644 hw/fsi/meson.build
 create mode 100644 hw/fsi/trace-events

-- 
2.39.2


