Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD961CD3423
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 14:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJAub-0004jn-Rr; Sat, 02 May 2026 10:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wJAu2-0004gu-RE; Sat, 02 May 2026 10:01:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wJAty-0007XG-Gn; Sat, 02 May 2026 10:01:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 642DlT2F3118223; Sat, 2 May 2026 14:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=I1hsOJZQR2XGOk7WI
 H8LLfPojJ5cB30a2SQsOUbn0oU=; b=B5/hIXYRIrRTAbaCOBNdaM47VUUXmu6U5
 9+driFADe+ZVQUM81Zjb0tAcz8hJLdua8rXjtpslZqKtnQ0oKIu2luFIsSoJuG1e
 Zw6Zyth0IPVjMvyAhzrz9Adg+/LeutGrLhiplKYxzy2AmpkeH0hPGsRSIbz9zSPY
 vxJJ1LhfNSa8rmcaKZKaSnHzGgecAkRx6JDGrgGqhr1sUDWR+WcgNHkWt2bC4gX1
 V95fEERpBnZCRXQX2iI4B2hN0vynh3BP0QXthnBNrHYfFxvVQeSsLvlXYx1/TlWn
 CCr2+zyZHF2W8s6aBPSYvoHJmiTkxYX2zTjuXvj4xO2ZnqzZAF4Rw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x494ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 May 2026 14:00:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642Dshhx023830;
 Sat, 2 May 2026 14:00:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dw9hd1ay0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 May 2026 14:00:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 642E0tpb15925758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 2 May 2026 14:00:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0707C20043;
 Sat,  2 May 2026 14:00:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F77220040;
 Sat,  2 May 2026 14:00:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.28])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  2 May 2026 14:00:52 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/ppc/spapr: Do not fallback to raw mode when KVM
 rejects compat
Date: Sat,  2 May 2026 19:30:19 +0530
Message-ID: <20260502140021.69712-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260502140021.69712-1-amachhiw@linux.ibm.com>
References: <20260502140021.69712-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDEzNiBTYWx0ZWRfX3lnf4UuAQzZr
 88Zxu1CDrVJJc8rAVJNp5LhD2ddv+cQgbEiJQgCslYzoXSyF5GnSOYQluJiT4LRMkWSTrvMOcOD
 qWKWtvz5Y+SFbAhBFTSvfuSzmmjINswW5zmh9stcjr62HYqlnsCcOBKfqld9wSatXUst7bZSmUP
 q+ywFudsudGvxr0GQapkTxiXDldD8wuH6RlCafaCF/islu7NF/pe6aOM/Pu/gFJ4vhxoyCwy9qX
 LLZ+AsATWwejTiZD3nu3GL+/KGkFco9CtSwcNPj9un2uXqosQYg3KP1O3BmTUwXYwiGqNahqjRm
 fzt8drG2b9H4omznfz5HRZK8ZJKDRrnIrxbfk4RAKBLOieWK1mVO5oLfYMR5X/kPvfHLMADLPvO
 CGRysTSMAo9/XWTSYQEpgAQxPEOUAcJYepqC5wWpS43rmDL/N9SGZMd27lvRx45HmeAS0EICEMK
 3UxuWVdfvPKx6XfYl7Q==
X-Proofpoint-ORIG-GUID: uUi8ylP4Z510A5kW9Q4PHNb7NCl6diaF
X-Proofpoint-GUID: 1ml0mEtvr53PGUzCKLaAPe_puiHAYX2B
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69f6039b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=i5GS84888sUNcPDMq4UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605020136
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

During H_CLIENT_ARCHITECTURE_SUPPORT, QEMU attempts to set the requested
CPU compatibility mode via ppc_set_compat_all(). If this fails, the
existing code may fall back to raw mode when supported by the guest.

The current logic treats all failures uniformly and tried to fall back
to raw mode whenever possible. As a result, errors from KVM (e.g.
kvmppc_set_compat() returning -EINVAL) are silently masked, making
debugging difficult and allowing the guest to proceed with an
unsupported or incompatible configuration.

When running with KVM, such failures indicate that the requested
compatibility level is not supported by the host. Do not fallback in
this case; instead, report the error and fail the CAS negotiation.

This makes the failure visible to the user and ensures that invalid
compatibility requests are rejected early rather than being hidden by
fallback behavior. For example, the following error is now reported:

  qemu-system-ppc64: Unable to set CPU compatibility mode in KVM: Invalid argument

Fixes: cc7b35b169e9 ("spapr: fallback to raw mode if best compat mode cannot be set during CAS")
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 032805a8d0db..de2ea6f5e579 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1204,6 +1204,15 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
         Error *local_err = NULL;
 
         if (ppc_set_compat_all(cas_pvr, &local_err) < 0) {
+            /*
+             * If KVM rejected the compat mode, do not fallback. This indicates
+             * the host cannot support the requested level.
+             */
+            if (kvm_enabled()) {
+                error_report_err(local_err);
+                return H_HARDWARE;
+            }
+
             /* We fail to set compat mode (likely because running with KVM PR),
              * but maybe we can fallback to raw mode if the guest supports it.
              */
-- 
2.50.1 (Apple Git-155)


