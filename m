Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686C8CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 09:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6n2b-0005rF-SM; Thu, 09 Oct 2025 05:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2Z-0005qL-5J; Thu, 09 Oct 2025 05:34:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v6n2O-0001hq-Oq; Thu, 09 Oct 2025 05:34:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59967VsB031169;
 Thu, 9 Oct 2025 09:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=zuW07I+yx18N6MVfeO+4GGoSMWOq
 0FE4C3ArMXZaGmY=; b=mt5/Rf4HM4rSRpnJ4WJjY3G48n8OOGHsGDjUqjNp/g0S
 OH/euZmg/YNIzWO8O4VE+tc5i1aBczqsvtrHBL5620zb+jhl6x7JkkF+4bVYnag6
 oUUq5saLvTKknc7HH68D3qq2OE58JND5VBR5eGq91yXgwoszeBRquE3Q0rDisFRe
 aR8HU26pr/+86tDPLXTMeOUQQyQ7C8SrJkxG9+QJUfJWSFjFg9HRKeHrH/8MNZ6N
 W1Ddv8k1ffNeh6aq2S4ObUeN1Ey4E6oX1kH0qShOE3PMkbJ3lQZwMUM/hhR12i/c
 +ayQeVv2AEybJ5SwWYWvYVXfk8tCTNKjGReDj0M1EA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81kugb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5999LHV8027599;
 Thu, 9 Oct 2025 09:34:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81kug7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998Ev3B026053;
 Thu, 9 Oct 2025 09:34:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamksbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Oct 2025 09:34:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5999Y5Jk26280274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Oct 2025 09:34:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C66DB20084;
 Thu,  9 Oct 2025 09:34:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9BCA20082;
 Thu,  9 Oct 2025 09:34:04 +0000 (GMT)
Received: from ltcfuji9aw-lp7.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Oct 2025 09:34:04 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, philmd@linaro.org
Cc: npiggin@gmail.com
Subject: [PATCH v2 0/5] ppc/spapr: remove deprecated machines till pseries-4.2
Date: Thu,  9 Oct 2025 14:40:52 -0400
Message-ID: <20251009184057.19973-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OOfuQRGycExLZVJhPq_-GjXKrIXPdzGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5/RMUe+EMZ8T
 xeuzpcrm6xYWWfYLnrlhE/xNyUm+S8VJZCVMYEg1mtsIwD3JE6GVlJChYcq+6wY+K0qyd9C9d6Z
 sXr2N87AhCm06yEQBrsgmKFicMhAt74hAcROfaxrVsh2nrFc/lx5dWZAiB9NF7jvbOMFN0qdfR2
 LprkYHx85pkRD39eaNq+wrn7YdujFFDcbnyEhpJ1MXMnt9/ZMmbiFy+oxItaT9vTQVHQ8CElglG
 bS47FoIoXtK3ccGnQsc2H2mas7qFd5Z4TzhYtffKkoVbh0HoRztcs0LR7+UtS10j91T3FxsgIhr
 2CxIvVhiwSX2c3uJq/AFw9pmwKcGOSf4m8btvFdShRSAZLbrWOz4DkYEtNKAn9W73lt1wlCf2JY
 U+UkEOWVgYZAXfr/3BtX9ZerNs3xCg==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e78191 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8
 a=SEs2kGhiNhXlQSMHockA:9 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: guyF3SxWMjg1hMsoYovMM4LLjLyF8iQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

pseries-3.x and 4.x had been deprecated and due for removal now.
Removing the legacy machine specific logic in respective patches.

v2: included pseries 4.1 and 4.2 due for removal now
v1: inital patches to remove 3.0 till 4.0
    <20250507052048.90559-1-harshpb@linux.ibm.com>

Harsh Prateek Bora (5):
  ppc/spapr: remove deprecated machine pseries-3.0
  ppc/spapr: remove deprecated machine pseries-3.1
  ppc/spapr: remove deprecated machine pseries-4.0
  ppc/spapr: remove deprecated machine pseries-4.1
  ppc/spapr: remove deprecated machine pseries-4.2

 include/hw/ppc/spapr.h     |   8 --
 include/hw/ppc/spapr_irq.h |   1 -
 hw/ppc/spapr.c             | 182 ++-----------------------------------
 hw/ppc/spapr_caps.c        |  12 +--
 hw/ppc/spapr_events.c      |   8 --
 hw/ppc/spapr_hcall.c       |   5 -
 hw/ppc/spapr_irq.c         |  16 +---
 hw/ppc/spapr_pci.c         |  32 +------
 hw/ppc/spapr_vio.c         |   9 --
 9 files changed, 14 insertions(+), 259 deletions(-)

-- 
2.51.0


