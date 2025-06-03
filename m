Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5780DC5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMS8m-0002sr-CM; Tue, 03 Jun 2025 09:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uMS8j-0002qe-Da; Tue, 03 Jun 2025 09:57:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1uMS8f-0004LK-GA; Tue, 03 Jun 2025 09:57:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5537hRBt019408;
 Tue, 3 Jun 2025 13:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Ly37+xLTHGG7PXOj/Dssv64eOElI+lckZN26vFybQ
 Co=; b=Fg+moQxxRhmmXx42JYXCLh0EzXwuZTS7/8Ae8jnzlS83RGqytXnoFaaHv
 OQsPeAL8lyuKV/k3ht5l8Dtar2FVwjJ/2Z7JSzoDSwJ0hmzazCcoDPll8jerRwir
 wRpNQ/OfcYnUWGyeSA8ZSvidhEOdjaUu2v7bA2cMgFawZtr1TI90YDT4DA7MI2Za
 dIG5lDFSkQteOgwLw+Eqau09230UoJyWUGBSxhUI3AgZ9LylE9+KgcRwXPI04K54
 /0W4PJIIq3xeFefxAkiXYD+Ep51rOvezzSfoCGKIpOv/981WqEcFG18GMXD+LIWj
 OXQCks7w866jtbuS8YNZO0XG++cdw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geymutb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 13:57:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 553A81A6028479;
 Tue, 3 Jun 2025 13:57:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 470eakav82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Jun 2025 13:57:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 553Dv1ML25494240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Jun 2025 13:57:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2A072004E;
 Tue,  3 Jun 2025 13:57:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B05AA2004B;
 Tue,  3 Jun 2025 13:57:00 +0000 (GMT)
Received: from a46lp68.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Jun 2025 13:57:00 +0000 (GMT)
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Subject: [PATCH v5 0/3] Add SCLP event type CPI
Date: Tue,  3 Jun 2025 15:56:52 +0200
Message-ID: <20250603135655.595602-1-shalini@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wNdqqJdG_7q94gWocDv7sh_T2cp6BYh6
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=683eff31 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=f4h7crwb3-BDZkw7WFEA:9
X-Proofpoint-GUID: wNdqqJdG_7q94gWocDv7sh_T2cp6BYh6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDExNyBTYWx0ZWRfXyAlYRHlAUMgu
 q015Uf4wdXJI5EhzCiqMAhOXC2xsaKWnM5NcLhL2Ya2uRicRIPD27+R+LaAb5STKvxadxhNmbrp
 eBcsSn9C3Zwq/6K+I8g98QKleZjnJT0UIl+zowlYEqm0Lg4SklevTrQ84OIOxrnh7UROVhQbKGL
 oWasGwANYExyYJi4wvtksRIyyAIduegxSHyIbk558QGWAA/XoR+Ja0mE1Wcqw0m6y2733pepiN7
 CLFa2sqL0F5PKbFH2nZaPvfW5bv38LGYuvocb0JrmpF4h3/7VxaVoIHPZRQyUE7Cg30j7VcQbcb
 sSda6sLpxtvdzxC3cMV4cDI+WVPFhrofBI6SHNKzcMYtlKR2lkVmW/6k1kkESV/MrkZp5jZyDTZ
 2hPThdmJurhLG5Crr00DyL3Yer1kpgLnRMS6gwJUWtdWdUEu8Ox+wgdFDaof3GLAUbwiIb9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=974 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=shalini@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement the Service-Call Logical Processor (SCLP) event
type Control-Program Identification (CPI) in QEMU.

Changed since v4:
- Remove the object control-program-id and add the CPI attributes
  directly to the sclpcpi object
- Instantiate sclpcpi device from v10.1 instead of v10.0
- Other minor changes

Changed since v3:
- Add QOM object sclpcpi from ccw_init()
- Add SCLPEventCPI state to store the CPI data in the sclpcpi device
- Other minor changes

Changed since v2:
- Add SPDX license tag in the new file hw/s390x/sclpcpi.c
- Store the control-program Identification data in the sclpcpi device
- Update the description of CPI attributes
- Use ldq_be_p() intead of be64_to_cpu()
- Return the CPI attribute system-level as an integer in QMP
- Add compat handling for backward migration
- Other minor changes

Shalini Chellathurai Saroja (3):
  hw/s390x: add SCLP event type CPI
  hw/s390x: add Control-Program Identification to QOM
  hw/s390x: support migration of CPI data

 hw/s390x/event-facility.c          |   2 +
 hw/s390x/meson.build               |   1 +
 hw/s390x/s390-virtio-ccw.c         |  22 +++++
 hw/s390x/sclpcpi.c                 | 154 +++++++++++++++++++++++++++++
 include/hw/s390x/event-facility.h  |  17 ++++
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 qapi/machine.json                  |  58 +++++++++++
 7 files changed, 255 insertions(+)
 create mode 100644 hw/s390x/sclpcpi.c

-- 
2.49.0


