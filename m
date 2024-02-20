Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF932C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLc8-0002x6-Q6; Tue, 20 Feb 2024 03:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLc6-0002wD-TT; Tue, 20 Feb 2024 03:36:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rcLc3-0004zX-9b; Tue, 20 Feb 2024 03:36:30 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8Z9HX018055; Tue, 20 Feb 2024 08:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=t2jLY1FONlHzmVHk6RZD2J6VOtbfJqqkgGj+pTAzSZY=;
 b=FLk1Rpna+LOjJj+YP2VjhukXHl+TZhXFybLTS/tktAfxdiPpSzlEW60L2PS1mYwHZONL
 z+PjuJkpcCcZg6q8IOT/rCQOUTzRlaNLtBcYApIHrWKAhYFIja33usc6y/Fi4V7HOJG2
 DoKzpvyo59f4a+XDXfoNDUfz598Vuz8s0DEk8UG/0VJOF7YXVc2o3fCM8iAQn88KO2zK
 MMTC2+dOOg+2ZncoU3P7rETCZWYP+nTPJJyntiktLprZ9VgDyiDCX6A+4rTdbVni+BWy
 2t0jGbmChXfBxHua3s1tCFmeaTPUhu3OUP5YmXCps+wi5+tx9oJ5DrANO/fMkpyiTzqi Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcrk9r8yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:20 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41K8TGkO025049;
 Tue, 20 Feb 2024 08:36:20 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcrk9r8ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K7PYaV014339; Tue, 20 Feb 2024 08:36:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u2edyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Feb 2024 08:36:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41K8aDN722086220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 08:36:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E0720043;
 Tue, 20 Feb 2024 08:36:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E121320040;
 Tue, 20 Feb 2024 08:36:11 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Feb 2024 08:36:11 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, mikey@neuling.org, amachhiw@linux.vnet.ibm.com,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com, danielhb413@gmail.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 00/15] Nested PAPR API (KVM on PowerVM)
Date: Tue, 20 Feb 2024 14:05:54 +0530
Message-Id: <20240220083609.748325-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cwoO1KVuKc2xLTImEfl2exbsG2nPdlpz
X-Proofpoint-ORIG-GUID: 006mLDkFbTFZlNPeWU1fPYa7m8viMbIN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=950
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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
https://github.com/planetharsh/qemu/tree/upstream-0219-v4

Thanks to Michael Neuling, Shivaprasad Bhat, Amit Machhiwal, Kautuk
Consul, Vaibhav Jain and Jordan Niethe.

Changelog:
v4: added hcall unreg helper to allow hcall re-registrations in caps apply.
v3: https://lore.kernel.org/qemu-devel/20240118052438.1475437-1-harshpb@linux.ibm.com/
v2: https://lore.kernel.org/qemu-devel/20231012104951.194876-1-harshpb@linux.ibm.com/
v1: https://lore.kernel.org/qemu-devel/20230906043333.448244-1-harshpb@linux.ibm.com/

Amit Machhiwal (1):
  spapr: nested: Set the PCR when logical PVR is set

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

 docs/devel/nested-papr.txt    |  514 +++++++++++
 include/hw/ppc/spapr.h        |   26 +-
 include/hw/ppc/spapr_nested.h |  430 ++++++++-
 target/ppc/cpu.h              |    4 +
 hw/ppc/ppc.c                  |   10 +
 hw/ppc/spapr.c                |   35 +-
 hw/ppc/spapr_caps.c           |   59 ++
 hw/ppc/spapr_hcall.c          |   24 +-
 hw/ppc/spapr_nested.c         | 1552 ++++++++++++++++++++++++++++++++-
 9 files changed, 2599 insertions(+), 55 deletions(-)
 create mode 100644 docs/devel/nested-papr.txt

-- 
2.39.3


