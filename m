Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB138CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZS8z-0005RY-57; Tue, 16 Jun 2026 07:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wZS8w-0005Qo-MQ; Tue, 16 Jun 2026 07:39:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wZS8u-0003o6-M4; Tue, 16 Jun 2026 07:39:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GAIEYm1245243; Tue, 16 Jun 2026 11:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gF4FZbd41karEQranhi3zTBL8R2wyHDt82Gl+bnMp
 xE=; b=YlWmJK9JJmGTVk9NDYxeRiK7oVOoK13BXQLAPvuBi86h816eq1u40CMkM
 ++XUGro2Z7h9zO4j5SJTpSQsegzhK9lCfbVJTpgabCfo5Ww7fOR5A84TerePLR4e
 y+3b7VwjTwB0Nx0PNEt6S5oe9VgOsGBaQIAh7dg5Z42p7hpRMOO5JGJdEg7ldzxW
 2g0pKQesUwhu/2UsR1PzQF7YNPxzjIBv7RU8LelsK2hTqoU5m5Citv7Xs/h1GcbV
 2Xnjq217XzsLaeLP79e7SQ4C+sXiBk6AgXApeN1O8hJm9M3EI1gAvJjQIsH9pTru
 C8DKKsA+SdY+Cp2O896FO+dW/L9dg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nnaeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 11:39:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GBYfR0023843;
 Tue, 16 Jun 2026 11:39:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y2uu6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 11:39:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65GBdZcb45023584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jun 2026 11:39:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B296820049;
 Tue, 16 Jun 2026 11:39:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B30D20040;
 Tue, 16 Jun 2026 11:39:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jun 2026 11:39:32 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] ppc/kvm: Handle CPU compatibility mode correctly for
 nested guests
Date: Tue, 16 Jun 2026 17:09:12 +0530
Message-ID: <20260616113915.25589-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a3135fc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=BDyKQ084SN5RfditTJYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX0DPe2YovrOfP
 1Y/vm8/z5gtVlak7RZGl3wnKVygwzOH/TaLeibRt4AYDsVby9AY1+SEfzkWEqBcbMTbuSvzY4+x
 SoFkZxHkjBYtJPD8eXjIC2Ltud3ZoAbLXKyeq4ZdTfF628F/c3WdgAZjktXY4J74JKKtt+EwEEJ
 spGibE9e3Jxj/NKDeszzCeKabMfsQdhq6oNzVjvVbP2Gt5TJTsU61RpjponU2tcrDaOB2UoIDC/
 PhO+Je5NpAT15oEXFy6Q2PoKlTWBt4lzuN/0z/OjHUuyhKuJm5cOLt2ahojxwPp8ghEBQfbC0MS
 9jIK/DUMX5kAcd/19w/OsBgJXDSmCR7S1yu2W1rp10BvgqU9OsY26JRbMr1GlWDv+Tqapi1YTi1
 3pYc4wWUSp269ft4gC5ypw+rrhfF5mK4KP6JIBcggQ6Hy0trhMZ1BkFMpcoaYyoP6FrLt2WswIm
 /Ts8j5pl9kjA5uc9OSA==
X-Proofpoint-GUID: _KKL4wSChTbrAUr3-sWu8tnF957OUqCn
X-Proofpoint-ORIG-GUID: yOJzn4V7pt2ln_fcprWQyT_RWarao7uX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX9nOZqNevxlEq
 0ldkUTNFzFJja5rz0kKWV5SQwWIlWAvWQltLtkBB36aHF8CukDPMPYcfUOs03B8iyBsQKldWHcL
 o7O8dj1LSdE0TUOSM9M9DOjY/GPHUdM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160115
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

This series addresses the issue by preventing fallback to raw mode when the
host itself is booted in a compatibility mode, and by querying the effective
CPU compatibility modes supported by the host via KVM. The implementation
includes size field validation for ABI compatibility between QEMU and the
kernel. With these changes, QEMU ensures that nested guests are configured
with CPU models consistent with the host compatibility mode, allowing them
to boot correctly.

Patch summary:
  [1/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
  [2/3] target/ppc/kvm: Add support for querying host compatibility mode
  [3/3] target/ppc/kvm: Use host compatibility mode for nested guests

Changes in v3 (based on review from Vaibhav):
- Patch 1: Moved compatibility mode check from do_client_architecture_support()
  to cas_check_pvr(). Instead of error handling when KVM rejects compat mode,
  now prevents raw mode fallback when host is booted in compatibility mode.
  This ensures guests cannot exceed the host's compatibility level.

- Patch 2: Added size field to kvm_ppc_compat_caps structure for ABI
  versioning. Changed flags field from __u32 to __u64. Added capability bit
  definitions (KVM_PPC_COMPAT_CAP_POWER9/10/11) and KVM_PPC_COMPAT_BITMASK.

- Patch 3: Added size field initialization and validation in
  kvmppc_get_compat_caps() to ensure ABI compatibility between QEMU and
  kernel. Changed from H_GUEST_CAP_* constants to KVM_PPC_COMPAT_CAP_*
  constants. Added capability masking with KVM_PPC_COMPAT_BITMASK.

- Dropped Tested-by from Anushree due to code changes in v3.

Changes in v2:
- Patch 3: Guard compatibility mode code with #if defined(TARGET_PPC64)
  to fix compilation for ppc32 targets. The POWER9/10/11 PVR constants
  are only defined for 64-bit builds, and compatibility modes are only
  relevant for 64-bit systems.

Testing (with kernel v4 patches):

KVM APIv1 Testing
=================
  On P10 PowerNV machine (L0)
  ---------------------------
    - P10 L1 KVM guest -> works
      - P10 nested L2 KVM guest -> works
      - P9 compat nested L2 KVM guest -> works
    - P9 compat L1 KVM guest -> works
      - P9 nested L2 KVM guest -> works
  
  On Powernv11 TCG Guest (L0)
  ---------------------------
    - P11 L1 KVM guest -> works
      - P11 L2 KVM guest -> works
    - P10 compat L1 KVM guest -> works
      - P10 L2 KVM guest -> works
    - P9  compat L1 KVM guest -> works
      - P9 L2 KVM guest -> works

KVM APIv2 Testing
=================
  On P11 PowerVM LPAR (L1)
  ------------------------
    - P11 L2 KVM guest -> works
    - P10 compat L2 KVM guest -> works
  
  On P11 LPAR in P10 compat (L1)
  ------------------------------
    - P10 (host compat) L2 KVM guest -> works

  On P10 PowerVM LPAR (L1)
  ------------------------
    - P10 L2 KVM guest -> works

CI test results: https://gitlab.com/amachhiw/qemu/-/pipelines/2604638350

Note: Patch 1 is marked DO_NOT_MERGE as it contains linux-headers updates
that will be synced separately once the corresponding kernel patches are
merged.

v2: https://lore.kernel.org/all/20260502140021.69712-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430061333.37905-1-amachhiw@linux.ibm.com/

The corresponding Linux kernel patches (v4) are being posted concurrently.

Previous kernel patch versions:
v3: https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
v2: https://lore.kernel.org/all/20260513100755.83215-1-amachhiw@linux.ibm.com/
v1: https://lore.kernel.org/all/20260430054906.94431-1-amachhiw@linux.ibm.com/

Amit Machhiwal (3):
  linux-headers: Add uapi header changes
  target/ppc/kvm: Add support for querying host compatibility mode
  target/ppc/kvm: Use host compatibility mode for nested guests

 hw/ppc/spapr_hcall.c            | 14 +++++++
 linux-headers/asm-powerpc/kvm.h | 18 ++++++++
 linux-headers/linux/kvm.h       |  3 ++
 target/ppc/kvm.c                | 74 +++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h            | 16 +++++++
 5 files changed, 125 insertions(+)


base-commit: 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e
-- 
2.50.1 (Apple Git-155)


