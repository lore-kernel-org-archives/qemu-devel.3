Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE299C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 10:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfxjq-0002h1-FI; Sat, 04 Jul 2026 06:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wfxjo-0002gV-1H; Sat, 04 Jul 2026 06:36:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wfxjl-0003Gd-RY; Sat, 04 Jul 2026 06:36:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6646mPx7899930; Sat, 4 Jul 2026 10:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=doOlLDcWR45OWvoeoSLjx0ooto1InKsVLiSj4py8T
 x4=; b=odveNEIcyKECW5oLSdmyrPet9kFsXtC5Z6+SqjAv48d6YNv1hQrTBFGNA
 6++uoYwX5cLBJ7Nkg//Y2h6XdWDwI/OTbV+oyeLXt0dqryXdSCGR4O5fZklhrWPY
 ZaVUp8eQbKdxULMZRnHUfVDkuKnRaZTlzvLz6yBIbi/fuFHXJSOTuLZhXeuxs3dn
 VQ9pfq6ng63R1RnodSrjnsiFToFjlMonbW//jutYnPOJFeQa9XBFM/BnpbwPEYcV
 lVyXngQ1m7kdPjDgNJK4e1a9H+iVMIgTYaEKkKNu08rSOjDrsLQvVfK4/asy06B9
 VyAqi3VoofLbVIu7VtSZ/G8Ztaeyg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3921e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 10:36:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664AYhMq028375;
 Sat, 4 Jul 2026 10:36:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gv762-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 10:36:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664AaWnn53018960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 10:36:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E88B2004B;
 Sat,  4 Jul 2026 10:36:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6691020040;
 Sat,  4 Jul 2026 10:36:29 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.212.207])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 10:36:29 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, sbhat@linux.ibm.com, gautam@linux.ibm.com,
 Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 0/2] ppc/spapr: refactor cpu hotplug related code
Date: Sat,  4 Jul 2026 16:06:12 +0530
Message-ID: <20260704103617.632929-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a48e235 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8
 a=9iOzChbbh04o1osCLikA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDEwMiBTYWx0ZWRfX0PsEVbfBeqs6
 nsTkIlexfnc3idNGmXehkVJGCEJVVW2xYmWfNlt//FF1Ye7nmdeCfYmY3E4WBas/uubD7mEg/pU
 XJLorSuOCXd/0WsfOBD2p55WzuOHVhI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDEwMiBTYWx0ZWRfX3YVhCcE43EEp
 6cNg/3UrKMiC1tJWMataxllBKLgEqCxFZINWS26UtnmFiAFwtY5ufTltsUlm3jA5ltqzJFBV+Bn
 UFyPvM4LtmNDEiFPV6gjbSH1BC5TL+K7iaPPcebwcFbnFDMTiBC2rvIHAGMEJX4Ovf/UjwcahmA
 VeZx5arOrSrFpYt5bEam40LOMgTEue0Oh+yX/tH8jLd56nli9MV725OydD8aWVMEXHEICqLS5sk
 PZgv1Ze0viyrcqGvUYiKFRWD1YqG7Ac70bfOmVfhgfBmyq2aAbqRniw+amumzXDAszgcigX/3Ym
 oeXK9E+lKueHCWG61xzsYEce8quIASwDyzfOErKW5vXZmlw80FV6OH+iylovuYlk1OYECQMQ5t8
 jK2cuHZx6wIeAXHaU3lPP/zVA20MKXIu6+V58q7VgVXInrHpuGPe+PpoK4Z0mcLiUyJNQpBxwqr
 wU4HylJOgyM4x5oSa8A==
X-Proofpoint-ORIG-GUID: wKhsWysah0Ngg_Vs-UMSgg39HYy17R27
X-Proofpoint-GUID: 49CrLxbCkiqMIpKWosJqxlzg7tOcYflQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040102
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

In the past we have seen issues related to cpu hotplug which are
observed in certain rare case scenarios and not always easy to
investigate and debug [1]. Recently we merged a fix for specific cpu
hotplug scenario which observed along with kdump operations [2].

Additionally, spapr.c has grown to over 5000 lines which also contains
CPU hotplug related code which accounts for nearly 1000 of those lines
yet is conceptually self-contained and independent of the rest of the
machine model.

Extract the cpu hotplug related code into a new compilation unit,
spapr_cpu_hotplug.c, with a matching header.

Also, adding myself as reviewer for PPC KVM CPUs to help share the
review work.

[1] https://lore.kernel.org/all/0732de44-964c-4e0f-b4fd-dcc631ba70fa@linux.ibm.com/
[2] https://gitlab.com/qemu-project/qemu/-/commit/a1c2dfee4f0229bc59bd3ca20af8de1b5543973d

Vishal Chourasia (2):
  ppc/spapr: refactor cpu hotplug code to separate file
  MAINTAINERS: add self as reviewer for PPC KVM CPUs

 MAINTAINERS                        |   4 +
 hw/ppc/meson.build                 |   1 +
 hw/ppc/spapr.c                     | 903 +-------------------------
 hw/ppc/spapr_cpu_hotplug.c         | 984 +++++++++++++++++++++++++++++
 include/hw/ppc/spapr_cpu_hotplug.h |  74 +++
 5 files changed, 1064 insertions(+), 902 deletions(-)
 create mode 100644 hw/ppc/spapr_cpu_hotplug.c
 create mode 100644 include/hw/ppc/spapr_cpu_hotplug.h

-- 
2.54.0


