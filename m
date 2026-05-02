Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9E3CD3424
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2026 14:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJAub-0004jG-N7; Sat, 02 May 2026 10:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wJAtn-0004fq-8X; Sat, 02 May 2026 10:00:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wJAtj-0007Nq-PD; Sat, 02 May 2026 10:00:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 642Bh44K3369056; Sat, 2 May 2026 14:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+KEF0RGGlu0z1YHcRdhnUWsGv9q1vdeLnOVUKCbc2
 A4=; b=EDjx8Ed/oLRMPJba62a64l9DnKtYDM3ca5Bpfo58Ap5NqV38qCy30o7aj
 vhiU8y7dNa96VEQS8RBOpAHB1JugTpFma07EMKCdRswreeC1QmV1728WS5utzLSJ
 5yZ3ZbuT3bx1+o/s3E2xgGpmFoZiMK8+c1Xh7zLXDZRw4WvF8w09QD9nK6eUDhuJ
 HF4BN+LmW0cH9S4AvTOU3jZhmUoNoQlhCuTq7Zu+wUVfkitj3ZPG3yZhGFq1gfKm
 xeX6clp8R9ordc1Og72ynAT423pCfe+h32MsQI3rMyAIEYlbBIkxA5zbkh7bOJ5B
 7kcVZr10xN+9N6UWqqbArpk/CgMQQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w613p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 May 2026 14:00:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 642DsZ4h012905;
 Sat, 2 May 2026 14:00:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dw9fs9bdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 May 2026 14:00:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 642E0eDw43516300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 2 May 2026 14:00:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C27920040;
 Sat,  2 May 2026 14:00:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06ADB20043;
 Sat,  2 May 2026 14:00:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.223.28])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  2 May 2026 14:00:36 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v2 0/3] ppc/kvm: Handle CPU compatibility mode correctly for
 nested guests
Date: Sat,  2 May 2026 19:30:18 +0530
Message-ID: <20260502140021.69712-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f6038d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=M_kZukdR289U2EYsLHYA:9
X-Proofpoint-ORIG-GUID: BhrSuD8qIEGPipBkZCAPlPXoqQ4K48C6
X-Proofpoint-GUID: frMv7xi41FMWDl_9MxokzL5EH7i_Rv3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAyMDEzNiBTYWx0ZWRfXzbQTG886JqAt
 TnltEK12QTxHHkBGNmlG91TyhbVpDlsJoSKfLiIxZhM9J119z38oWPs1W2cmCW0pQCYU927ylql
 dcO6LVl/pNFm+GRqb3QwBRxMBjRqVy9Ku+wCnS/hnIj1IjsLlH/i7GhyCf0B44NCqqsaFXpT+Sw
 wuS7ceRi3VfT91rQ0B2bYPrtuSfgk/N6C/UQhRVVGIxkKTAimxaXO6EA5FRYaWMi3VSRLhsActW
 OqxuRcCo0rqTjFUlXHpIvSiKwxwmzi3i+smY/h0SHp14opYIODs+WKO7sTgZHW8T0BfY71dIgUW
 djm4T0MQ6GjvFCdh5hrjqNFIs5oF+UUYXqUX17zteTPSO1+DRPeNsR5OwRkSpVa552Q2mmvgSgX
 fLLmTO8d1ZURgnwPzc7TLAV5eiBeZ8m7HTZIgerydSB3K7lGf95VlwfyNUOg55xDkyJxL+Nb8D7
 li2CXh00tVhuxpxt5oQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-02_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605020136
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On POWER systems, newer processor generations can operate in compatibility
modes corresponding to earlier generations (e.g., a Power11 system running
in Power10 compatibility mode). In such cases, the effective CPU level
exposed to guests differs from the physical processor generation.

This creates issues for nested virtualization. When booting a nested KVM
guest, QEMU may derive the CPU model from the raw hardware PVR and attempt
to configure the guest accordingly. However, the host is constrained by the
compatibility level negotiated with the hypervisor, and requests exceeding
that level are rejected by KVM, leading to guest boot failures such as:

  KVM-NESTEDv2: couldn't set guest wide elements

This series addresses the issue in two ways:

1. Do not silently fall back to raw mode when KVM rejects a requested
   compatibility level during CAS. Instead, propagate the error so invalid
   configurations are visible and fail early.

2. Query the effective CPU compatibility modes supported by the host via
   KVM and use this information to select an appropriate CPU model for
   nested guests.

With these changes, QEMU avoids masking KVM errors and ensures that nested
guests are configured with CPU models consistent with the host
compatibility mode, allowing them to boot correctly.

Patch summary:
  [1/3] hw/ppc/spapr: Do not fallback to raw mode when KVM rejects compat
  [2/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
  [3/3] target/ppc/kvm: Use host compatibility mode for nested guests

Changes in v2:
- Patch 3: Guard compatibility mode code with #if defined(TARGET_PPC64)
  to fix compilation for ppc32 targets. The POWER9/10/11 PVR constants
  are only defined for 64-bit builds, and compatibility modes are only
  relevant for 64-bit systems.

Tested on:
  - Power11 pSeries LPAR in Power10 compatibility mode
  - Power10 PowerNV and QEMU PowerNV 11 TCG L0 host

CI test results: https://gitlab.com/amachhiw/qemu/-/pipelines/2494987253

Note: Patch 2 is marked DO_NOT_MERGE as it contains linux-headers updates
that will be synced separately once the corresponding kernel patches are
merged.

The corresponding Linux patches have been posted [1]

[1] https://lore.kernel.org/all/20260430054906.94431-1-amachhiw@linux.ibm.com/

Amit Machhiwal (3):
  hw/ppc/spapr: Do not fallback to raw mode when KVM rejects compat
  [DO_NOT_MERGE] linux-headers: Add uapi header changes
  target/ppc/kvm: Use host compatibility mode for nested guests

 hw/ppc/spapr_hcall.c            |  9 ++++++
 linux-headers/asm-powerpc/kvm.h |  7 ++++
 linux-headers/linux/kvm.h       |  3 ++
 target/ppc/kvm.c                | 57 +++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)


base-commit: 3d626609ccae61a2e552bccd59c7a0931bab8261
-- 
2.50.1 (Apple Git-155)


