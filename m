Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F408C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYHz-00049E-7I; Fri, 08 Mar 2024 06:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYHv-00048j-1a; Fri, 08 Mar 2024 06:21:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1riYHs-0003uW-OY; Fri, 08 Mar 2024 06:21:18 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 428Av6vA013751; Fri, 8 Mar 2024 11:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=WPkj1PVXi0RjGloiC7Z0uBvgWd0olsz1JZukqX3J9N8=;
 b=B33inSi6rrhmy7sl4aJXbFtvc6l9OHsp8KHi2ko3rxxACpJ+ZvPLrkIwhMSZdWpl3b0F
 /q3VUPYCDFjrghjqkNCIGsWMUieU294pq2AFdJZdx1Vtk4hjhFn4yuXrBntF+0pk3QGE
 smA7Muk2b9/wnQXhn2qiilSBMNVGcIYLkaBIt5UQBs7vhaFpU/DPKit7mY7ZxL7P15Ye
 0qbBVpgbb8/NW7z+9q/lUA85Fl77FSC6IBg7oskhQ93Jugwqa9+J6qqfyUVvBFJoahNb
 UNcAXBda3CzjSjz4SyCkNqBQB2OIKqYqX9SMFh1UU/RaKVrTlWrpIKfFZ1cGwGKPznoO UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ce0c2a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:31 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428Av9XU013799;
 Fri, 8 Mar 2024 11:20:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr1ce0c1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 428A84GK024193; Fri, 8 Mar 2024 11:20:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wpjwsqag8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:20:29 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 428BKNrI34668934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2024 11:20:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F6F82004E;
 Fri,  8 Mar 2024 11:20:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4B8D2004D;
 Fri,  8 Mar 2024 11:20:20 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.171.30.1]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2024 11:20:20 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clg@kaod.org, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v5 00/14] Nested PAPR API (KVM on PowerVM)
Date: Fri,  8 Mar 2024 16:49:26 +0530
Message-Id: <20240308111940.1617660-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XqSMu_6038jg5w5bpivPhe9S5P1TC-9G
X-Proofpoint-ORIG-GUID: 80hWjbDeT4zs6OuvJth-Jat1KrpNlnuX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080089
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

There is an existing Nested-HV API to enable nested guests on powernv
machines. However, that is not supported on pseries/PowerVM LPARs.
This patch series implements required hcall interfaces to enable nested
guests with KVM on PowerVM.
Unlike Nested-HV, with this API, entire L2 state is retained by L0
during guest entry/exit and uses pre-defined Guest State Buffer (GSB)
format to communicate guest state between L1 and L2 via L0.

L0 here refers to the phyp/PowerVM, or launching a Qemu TCG L0 with the
newly introduced option cap-nested-papr=true.
L1 refers to the LPAR host on PowerVM or Linux booted on Qemu TCG with
above mentioned option cap-nested-papr=true.
L2 refers to nested guest running on top of L1 using KVM.
No SW changes needed for Qemu running in L1 Linux as well as L2 Kernel.

Linux Kernel side support is already merged upstream:
---
commit 19d31c5f115754c369c0995df47479c384757f82
Author: Jordan Niethe <jniethe5@gmail.com>
Date:   Thu Sep 14 13:05:59 2023 +1000

    KVM: PPC: Add support for nestedv2 guests
---
For more details, documentation can be referred in either of patch
series.

There are scripts available to assist in setting up an environment for
testing nested guests at https://github.com/iamjpn/kvm-powervm-test

A tree with this series is available at:
https://github.com/planetharsh/qemu/tree/upstream-0305-v5

Thanks to Michael Neuling, Shivaprasad Bhat, Amit Machhiwal, Kautuk
Consul, Vaibhav Jain and Jordan Niethe.

Changelog:
v5: addressed review comments from Nick on v4
v4: https://lore.kernel.org/qemu-devel/20240220083609.748325-1-harshpb@linux.ibm.com/
v3: https://lore.kernel.org/qemu-devel/20240118052438.1475437-1-harshpb@linux.ibm.com/
v2: https://lore.kernel.org/qemu-devel/20231012104951.194876-1-harshpb@linux.ibm.com/
v1: https://lore.kernel.org/qemu-devel/20230906043333.448244-1-harshpb@linux.ibm.com/

Harsh Prateek Bora (14):
  spapr: nested: register nested-hv api hcalls only for cap-nested-hv
  spapr: nested: move nested part of spapr_get_pate into spapr_nested.c
  spapr: nested: Introduce SpaprMachineStateNested to store related
    info.
  spapr: nested: keep nested-hv related code restricted to its API.
  spapr: nested: Document Nested PAPR API
  spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES hcalls.
  spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls.
  spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
  spapr: nested: Extend nested_ppc_state for nested PAPR API
  spapr: nested: Initialize the GSB elements lookup table.
  spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.
  spapr: nested: Use correct source for parttbl info for nested PAPR
    API.
  spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
  spapr: nested: Introduce cap-nested-papr for Nested PAPR API

 docs/devel/nested-papr.txt    |  119 +++
 include/hw/ppc/spapr.h        |   27 +-
 include/hw/ppc/spapr_nested.h |  428 ++++++++-
 target/ppc/cpu.h              |    4 +
 hw/ppc/ppc.c                  |   10 +
 hw/ppc/spapr.c                |   35 +-
 hw/ppc/spapr_caps.c           |   62 ++
 hw/ppc/spapr_hcall.c          |   24 +-
 hw/ppc/spapr_nested.c         | 1550 ++++++++++++++++++++++++++++++++-
 9 files changed, 2204 insertions(+), 55 deletions(-)
 create mode 100644 docs/devel/nested-papr.txt

-- 
2.39.3


