Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167FFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepZw-00041S-SN; Thu, 24 Jul 2025 02:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZO-0003uD-2m; Thu, 24 Jul 2025 02:36:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZL-0007NL-Jh; Thu, 24 Jul 2025 02:36:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O0tios027953;
 Thu, 24 Jul 2025 06:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=4JviaNvwUuBGpbis1k7x70DEDrka
 JWuTesIQCCoiW1Y=; b=YxcoJEphEu1rJLuCn0mvk4YwYTCI7l2UdJF1zI+4VdGd
 zOTy2l6hADLIltqkMy2XHnGvdMP0+eSY6sSgjfziTI9yQDjQsypK1PY0yWhyibGh
 402sAbEWS68W37i+o/G8nb0M3pUN0z3/9GISctoyksIqIiiig/YYGaRGFyuoOw1T
 /bRlyeqhlEL2jD7yotCwiJlSIb04Affc+DCESPe52SvOFPK01E040zyvYiZ3+2MD
 ADiJa9H/SbNsIIzhrmG2umPmJVpUv1tvJq4KK4qUtFkdKEuHZugNchSljxVa+dDK
 NCJPN6j21z3i1ikbKEBzoo3aR3dfTNs992w0Z3jzYw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5ryn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56O6T4xJ008865;
 Thu, 24 Jul 2025 06:36:38 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5rymm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6IO0r025306;
 Thu, 24 Jul 2025 06:36:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptuesh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:36 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O6aXs755640358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 06:36:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46A7520049;
 Thu, 24 Jul 2025 06:36:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 662CD20040;
 Thu, 24 Jul 2025 06:36:31 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 06:36:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
Subject: [PATCH 0/5] MAINTAINERS updates for ppc/spapr/pnv/xive
Date: Thu, 24 Jul 2025 12:06:05 +0530
Message-ID: <20250724063623.3038984-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0MCBTYWx0ZWRfX6JMF1K37VVhE
 Cjjc+AvqXzHi4NH2G4Rv9HIsTxmtYBOvlgnQ6TgokKcKvuh+uVWB6c1u3q9orUmyRXVCQ29JZZn
 DnH4mTxzIk4eRQ/yHq4Kf6rQLe4NT4QJpWncDfnYVWhFRalVEAAbAtG+VCHEnhx+3Bpnr9I4VUA
 2LVPp84Zp/Vw47rT3HIxZnMP8+qrXEGZLlcmCR8d/qkvUhOLt1EWYd+1yNbrVpLfRvLSP/qRKMr
 WRtz1s20dawQX8Jrq9g1b1vZw0ZSooe7lom6/gLuyIvQ+DCYT6wfRch+7yoeTqfWFts/V/0ELE4
 dKq4qSrTe46qiCsVXf+49IrbDhCl5VzjPaCtJSASL0G0MZUuE3wh4MUFTh0fujGZv/YSiXjUG9G
 FygDPmliQuU5lYADoJQuZEjBRrpmCjOz+t+th6X5kDDkzn1p29SpjVucQmfBm4ehjB0a8fPS
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=6881d476 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10
 a=UmFCVzT0ErLeyuHn1OIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 672y2ggcWOIY1bcHmaX5xKqlpvlhqSMA
X-Proofpoint-ORIG-GUID: Mq1iE_Lr4imKFO2T-ueSSQ7SJWfj16sU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=448 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


