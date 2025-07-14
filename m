Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A8AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLME-0000Az-33; Mon, 14 Jul 2025 11:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKBA-00082y-Fi; Mon, 14 Jul 2025 10:29:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKB6-0002fX-PQ; Mon, 14 Jul 2025 10:29:16 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z6Mj001418;
 Mon, 14 Jul 2025 14:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=/BQ6Qh9d
 d3FZ1GJKNmJzfulWSbyqVBUZbdrWC/LzFdA=; b=dnkO0OZXJE1jCEcCpwWQFSBC
 MVWcd8LA54gxBXGnyZlinwAlQV4N4L0srGj7xIP8mHTxUMDZYt/bJRWzNzOL6IUd
 O4+1M0Du7Xgk6Paucy/ymXMCmZgdhQNwJTC2vLT9VTjqgasnS6C0ZwWc+4G8w77f
 ZZrC6ooXq+9w4zTU28H/+zUPPe5+enKq6qyqukGWgzuBzPcc+OGqVktquT4Lddor
 jg4NhYCXmaWzuuApLoPfOlWGXZyM7GXtx5fBIEwVAuFcqr422bpwVxz30aRxi/zn
 iI8yVY9g8TCb2S2Bn2aCh2qMvoZf+65E44KvhMMgenVMyifMVwiIVGmDjabXVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv844-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EC2sw6010929; Mon, 14 Jul 2025 14:27:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58kgps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EERLK2040396;
 Mon, 14 Jul 2025 14:27:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58kgnu-1; Mon, 14 Jul 2025 14:27:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/2] preserve pending interrupts during cpr on arm
Date: Mon, 14 Jul 2025 07:27:17 -0700
Message-Id: <1752503239-222714-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=975 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Proofpoint-ORIG-GUID: a-aymWXdw_L0pz5puZeeN0l9H1LivGML
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687513cb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=7eQ_Oyjg6oxsgWg1zkYA:9 a=ZXulRonScM0A:10 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: a-aymWXdw_L0pz5puZeeN0l9H1LivGML
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NSBTYWx0ZWRfXwvIDxWYC1GOc
 XEixOVcLFSl1X00o8sGY3p0ema23mlXGw9xwzZa0w828B9yE0H+wimpp3hWkH/rvmrOE22Z87MK
 ROVlQuxiQbbO7tssHKaJXSytg2F8cKIJrsT6S59Afr/WFi8Sif6vjwz89a79nyI1IXZzHr1UMjh
 N4Jb+ErnFHney6dVhDw++anZMA08BY36RyepEDlIdWAfTpbjVIPFq3H/pETT/rwfw9kLJA0o85K
 fYPoH0Aa0R6rH3WOGgpEyX8byZmJKRBJuMQzRh9jUXTS8K0LdCTISovNlVF+C92/uGtJOXIgXS6
 EZ4+Tqdq4S+bVBtrJTs2pUzK7sK4PUBbW+xlwP/TaO7QKvp5fwZ73xAXe8LZXxKKFYacaHv5ksh
 4ozpqDSa0aQ0YqXHnFAiBtVahLca8nP2gQDjnSbA3AHeIetD1S4KmlNQRDWi/sgbPXVjziaG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Close a race condition that causes cpr-transfer to lose VFIO
interrupts on ARM.  See commit messages for details.

Steve Sistare (2):
  hw/intc/arm_gicv3_kvm: subroutine for save pending
  hw/intc/arm_gicv3_kvm: preserve pending interrupts during cpr

 hw/intc/arm_gicv3_kvm.c            | 40 ++++++++++++++++++++++--------
 include/hw/intc/arm_gicv3_common.h |  3 +++
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.39.3


