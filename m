Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C70DC61DB8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 11:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNrLu-00044k-E6; Sat, 07 Jun 2025 07:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uNrLq-00044M-8Q; Sat, 07 Jun 2025 07:04:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uNrLo-0002JE-Dr; Sat, 07 Jun 2025 07:04:38 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55780s4E015967;
 Sat, 7 Jun 2025 11:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=0W1RZ1c37T4y+iJXv1FTEDhQaUL1
 DyreZHdjCiSz4CE=; b=GuJeAV0qKnMCq4qL2U1s4TX07N+ZKILFgKERN4+Uw1Gf
 IbsLN2YnQUUUxFCaEc0bVOoficj8JSl3JAKAXm8RxdxJK4BO3gUzfJHNcU942+Na
 wPisYh19XjyIZse3ZpXLdq+RtKIWHyPpkXUc9P/lgo/ntBsCos9FUWsHTL1RiQIy
 p0NTve7ARzBEUT+BeXeraQptkXLYWU6NQc+b7qNbUgkcrlGApUEqWiDVINpZBOaf
 IhxhJek/4+svzTo4lOp4MibyC+lgP9H5C6/v6jc2qXT3nAl+6ZBB3PbfiPGE4XcD
 HsNqMEoYn9KCc9eOZnjMFqrjbzQxmnfStt6Py/my1g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hhdgdfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:04:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 557B35pU004087;
 Sat, 7 Jun 2025 11:04:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hhdgdfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:04:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 557AmJLH024904;
 Sat, 7 Jun 2025 11:04:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmwh63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Jun 2025 11:04:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 557B4PSj23003454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Jun 2025 11:04:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D691020049;
 Sat,  7 Jun 2025 11:04:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E6E120040;
 Sat,  7 Jun 2025 11:04:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.13]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  7 Jun 2025 11:04:23 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v7 0/2] Deprecate Power8E and Power8NVL
Date: Sat,  7 Jun 2025 16:34:10 +0530
Message-ID: <20250607110412.2342511-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DLGP4zNb c=1 sm=1 tr=0 ts=68441cbf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=31Clpgyuveq3k6-D5LcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IHMfhmLRtucw7v_TRIrQ-ByPyjHmuZ8B
X-Proofpoint-ORIG-GUID: sdpAjNTiIsvlyR-FQHBq8XOfb3kUwz1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA3NyBTYWx0ZWRfX02RS8mIdbFu8
 NYuabyZg2/qXJZPGA93TSYXsjrwJ14LsnyKNypuKZP09a+i0M9VEyqljYWU9UO2YtdIrkA3rZO2
 NXRjBK6VbTunuielY04+XlOnsHndhbNLKbQ766xdFqRRAkUmCb/rRkdXhpCUYPkOYThqjnVf/+M
 bp5S9GEsGrfGY6jznPfFE2eSE4NLhnYBvuNp0s1wOqSSm97TW7y33J5kmyAbMlt5A5jqwy1jUIv
 Jav1xFVODVuyQACM7d89yCanhsy/lpDwzqdptE93cRJJjR1TbQGeGfhmTM2jOUUDXraRpRB828U
 eVrHVfZeZpDNzSdxJ4IgJiI1drXkoP+504iowJMLo6WC1UqWnQ90Bp20zALvtP5TU/6489gGRyH
 SLdD3yuwkuA4H0oXCxloWDxnyCGA0A1Zz/X4zNnI62s+qUWv8li6ISgxbmnP6qRhTeA34PCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506070077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Note: No changes, only change compared to v6 is rebased to upstream

Power8E and Power8NVL are not maintained, and not useful to qemu, and
upstream skiboot also has removed support till Power8 DD1.
Power8NVL CPU doesn't boot since skiboot v7.0, or following skiboot commit
to be exact:

    commit c5424f683ee3 ("Remove support for POWER8 DD1")

No direct way to deprecate the pnv chips, a field like deprecation_note
could be added, but felt not needed as the chip will only get used if
the user requests corresponding 8E / 8NVL CPU, which will print
deprecation warning.

Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
which will throw the deprecation warning. So just deprecating CPUs should
be enough.

Changelog
=========
v7:
  + rebased to upstream
v6:
  + change qemu version from 10.0 to 10.1 in doc
v5 (https://lore.kernel.org/qemu-devel/20250422043843.26115-1-adityag@linux.ibm.com/):
  + split into 2 patches, defining macro, and deprecating 8e & 8nvl
v4 (https://lore.kernel.org/qemu-devel/20250330211012.2932258-1-adityag@linux.ibm.com/):
  + remove unnecessary 'if'
v3:
  + add 'deprecation_note' argument to the POWERPC_DEPRECATED_CPU macro
v2:
  + add mention to docs/about/deprecated.rst
  + add '(deprecated)' in output of qemu-system-ppc64 --cpu help

Base Commit: 96215036f47403438c7c7869b7cd419bd7a11f82

Aditya Gupta (2):
  target/ppc: Introduce macro for deprecating PowerPC CPUs
  target/ppc: Deprecate Power8E and Power8NVL

 docs/about/deprecated.rst |  9 +++++++++
 target/ppc/cpu-models.c   | 20 +++++++++++++++-----
 target/ppc/cpu_init.c     |  7 ++++++-
 3 files changed, 30 insertions(+), 6 deletions(-)

-- 
2.49.0


