Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D238C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwm79-0004Ab-DG; Wed, 19 Aug 2026 15:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwm75-00046Y-T9; Wed, 19 Aug 2026 15:38:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wwm72-0007Ga-6w; Wed, 19 Aug 2026 15:38:14 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JI1iei4100354; Wed, 19 Aug 2026 19:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=agDHD3TcIDva3hlVi2cgpqz6YqC1EWpaRWbFOcRS4
 Hw=; b=HxKqBpbX6mOZngXmk+uqFs22cdq+9ZQW2lmUwCpAdLnAVKjWSHsYK1E8M
 G2DjMkNpno5yEhnGzeZcRvL4D6viEKnIzWIHwGy/Y/i+fB+Jczt8JV8YUsNZvqjR
 BQZMPYFlfBiUdraqZTnTacqlgPt4sUopPxZo94WM6/pmMI3Ba94e+hwOaNd9IH4z
 4i+EVaP3DIDArJJrErk8/jjYQf9LbMZ34XPAgTzrkqo+3ME4jSq5UyISh3S51hWZ
 XiOC7O214m6FxGL8F2+MHmevMLhEHyJ3svqJCBITI/sDnXbgR8Z6ELYJaOEDZqSn
 nRj+WoaxeaMncVuYVmX6eeJgnGCew==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu45qvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 19:38:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JJQLDB026971;
 Wed, 19 Aug 2026 19:38:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekakxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 19:38:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67JJc29X40042848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2026 19:38:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C90A220043;
 Wed, 19 Aug 2026 19:38:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A14420040;
 Wed, 19 Aug 2026 19:38:00 +0000 (GMT)
Received: from shivang.com (unknown [9.39.17.34])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Aug 2026 19:37:59 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, harshpb@linux.ibm.com,
 hbathini@linux.ibm.com, mahesh@linux.ibm.com, npiggin@gmail.com,
 rathc@linux.ibm.com, sourabhjain@linux.ibm.com, vaibhav@linux.ibm.com
Subject: [PATCH v3 0/2] MAINTAINERS: reorg PowerPC RAS code for better
 maintainability
Date: Thu, 20 Aug 2026 01:07:53 +0530
Message-ID: <20260819193757.1072909-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfX7ynr2aKFLOpD
 X6RR/ks4rDmGHZpkGurSrObDyJcg7/NeqzA0+OK9bXLs5w7QBqfIVxldEbK04F4VWCFQtuD5ThJ
 t0Rb8UxWwipaem7cXcb88LPfWWHZGKQ=
X-Proofpoint-GUID: GKQEEeWTHAe1t2tDDmqGfF9LUNzWKKG6
X-Proofpoint-ORIG-GUID: kJbDafxDCaDGmVYWEorIkts20AXLVGmb
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a860620 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=m7TCnJEzk1zFhV0Gf4kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfXyNvyTJaE7Gs1
 PiAqzLSRN+EVCyHvsSAI+uHoFKpV8/XJeuHdyzJB/i6d/nGFxsCpds0Pi2XcYlI/C+Ckq2oE+1A
 Yi1j0fVBLvJshlLXG9JkfICXPucDHVLtvY1FyIrttLXOJtdVGJX7WLI5GCgzTLsFz1IETiv3ZjW
 BbDD5i/YqBQvzcMKhFrXyiobkjGatW76GzLOfG2oA11jMNwNV1qfx9Caoit7I+L67oI5H7A1Lgk
 zmALT68Ow+Sw0yGH8kgfaS2Up5m04SAVznMGVpFo9/uR8S+HadbkQWlKTUkmzNIIJ48rcZJjHHP
 PmXSTzXCa7nKzTNrl9312bVm42kMyDugu3xfwPO0pakIEtrfnfhuArvVZ5FFMKiOGEoObHkM70f
 1ADpXHiKnIg2Ysr5xo5zURSvuG9ObuEUPJt0oIb2rdKBAGarJGm9ozSLu0daktQMokXm+kXyWMR
 pBzwSwkCD23qnxcx33g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190151
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Combining Fadump and MPIPL entries under PowerPC RAS section. Additionally
adding myself as a reviewer, to help share the review workload.

--
ChangeLog:

v3:
  Adding spapr_rtas.c file. As rtas_ras.c file is no longer there.
  
v2: https://lore.kernel.org/all/20260818171541.903431-1-shivangu@linux.ibm.com/
  Dropping the rtas_ras.c file refactor, as suggested by vaibhav.

v1: https://lore.kernel.org/all/20260714164745.573141-1-shivangu@linux.ibm.com/

--
Shivang Upadhyay (2):
  MAINTAINERS: add dedicated PowerPC RAS section
  MAINTAINERS: add self as reviewer for PowerPC RAS

 MAINTAINERS | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

-- 
2.54.0


