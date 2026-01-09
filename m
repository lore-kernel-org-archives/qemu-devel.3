Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049F3D232ED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7X4-0006sh-TF; Fri, 09 Jan 2026 03:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1ve7Wz-0006bU-9j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:07:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1ve7Ww-0006qu-I9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:07:36 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6095kN362246565; Fri, 9 Jan 2026 08:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=3/VWmsn2aeu3eFtRo6wfM3XGV4gci
 2/hgCjZZ3xgC4s=; b=ZUc/mAYRmzLZt6xcM/qtmvYbE/CDm4XOXNm8o1gRuX0DA
 v0oAd2TE4Xm6qcDmJVH2KJzrWoTekiYnGqQe0GIMrO2b01zqvsHGKc0qlPxonp6s
 P7RjFE+Ni6+ZQOIk9kpDH6TYDxsHDJddK1cW5HnnfH0cb5s360ALJBSn0cGZEO2i
 dQndSDZTqt+VqIrWULV+AP+QEumuRn/Oe/N0J54FtDJoxmexyDI5bH1nkv+lYosd
 5/GeR5D7n3+wtzUuSpYDswHFoiuQ0omd0KL1xgViZwvzCMem6Cn7WhZLljn27kDl
 qIcHnADfBoVaNdw3VLy0b60FAN9sXmtUChzwozxCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjutt83y5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jan 2026 08:07:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 6097GqhQ026350; Fri, 9 Jan 2026 08:07:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4besjpcbka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jan 2026 08:07:21 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60987KrN009653;
 Fri, 9 Jan 2026 08:07:20 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4besjpcbj1-1; Fri, 09 Jan 2026 08:07:20 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, zide.chen@intel.com
Subject: [PATCH v9 0/5] target/i386/kvm/pmu: PMU Enhancement,
 Bugfix and Cleanup
Date: Thu,  8 Jan 2026 23:53:55 -0800
Message-ID: <20260109075508.113097-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090056
X-Proofpoint-GUID: 2F064qVsY7aVD_H-Y4LS4OUvbQmrl3Nu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1NiBTYWx0ZWRfX6QUDp4X7Ozve
 gbIdK4erssNBPCazdm3A/I7uyeG9cgmw6CNizu948SC8iqdxO3uD2N1S81Zl493hbzaKHg1s6vT
 t/hoU/J9L6dhBWVBN3YwrXkU8fd03OYsZ5AYbdfD8lZMXXHSMmrdfHy8mY2u2b15b4iyQiNB+dG
 VOLeQR0Q6jA8OnYy26ICoADgH14k2YF0EGqWH0byNsyw2ZiDsvaTK7Jl7Yubs2DAZej0bSZq3/I
 etNytgiGMNgDV75MB5xz1qKMwcLaIWhKvcrtulV9JKzkuiD+ek642dErHVRJY20JBNm4a+kjaCM
 YdNlo92F+1cY5A7ZMck4J0C8iDc63DYz6WO1N5BNzd81kMt8PJorin7GZIuFksVL5nqM1UxN5Hu
 f4948g3WJB1epZmQ2LN6LXEbgqhbonCQV/0rjnzD6CVCm3Ksj1OvL8Ir6GjHbrkUndEgnEYB3ZE
 /w7ev1zD42XwWEuI4k7WVQ3cx5CFBHZURnQR6IMw=
X-Authority-Analysis: v=2.4 cv=O5c0fR9W c=1 sm=1 tr=0 ts=6960b73a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=AW06eDNZEpMqNRz8TqYA:9 cc=ntf awl=host:12110
X-Proofpoint-ORIG-GUID: 2F064qVsY7aVD_H-Y4LS4OUvbQmrl3Nu
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

[PATCH v9 0/5] target/i386/kvm/pmu: PMU Enhancement, Bugfix and Cleanup

This patchset addresses two bugs related to AMD PMU virtualization.

1. The third issue is that using "-cpu host,-pmu" does not disable AMD PMU
virtualization. When using "-cpu EPYC" or "-cpu host,-pmu", AMD PMU
virtualization remains enabled. On the VM's Linux side, you might still
see:

[    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.

instead of:

[    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
[    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled

To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
when "-pmu" is configured.

2. The fourth issue is that unreclaimed performance events (after a QEMU
system_reset) in KVM may cause random, unwanted, or unknown NMIs to be
injected into the VM.

The AMD PMU registers are not reset during QEMU system_reset.

(1) If the VM is reset (e.g., via QEMU system_reset or VM kdump/kexec) while
running "perf top", the PMU registers are not disabled properly.

(2) Despite x86_cpu_reset() resetting many registers to zero, kvm_put_msrs()
does not handle AMD PMU registers, causing some PMU events to remain
enabled in KVM.

(3) The KVM kvm_pmc_speculative_in_use() function consistently returns true,
preventing the reclamation of these events. Consequently, the
kvm_pmc->perf_event remains active.

(4) After a reboot, the VM kernel may report the following error:

[    0.092011] Performance Events: Fam17h+ core perfctr, Broken BIOS detected, complain to your hardware vendor.
[    0.092023] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR c0010200 is 530076)

(5) In the worst case, the active kvm_pmc->perf_event may inject unknown
NMIs randomly into the VM kernel:

[...] Uhhuh. NMI received for unknown reason 30 on CPU 0.

To resolve these issues, we propose resetting AMD PMU registers during the
VM reset process


Changed since v1:
  - Use feature_dependencies for CPUID_EXT3_PERFCORE and
    CPUID_8000_0022_EAX_PERFMON_V2.
  - Remove CPUID_EXT3_PERFCORE when !cpu->enable_pmu.
  - Pick kvm_arch_pre_create_vcpu() patch from Xiaoyao Li.
  - Use "-pmu" but not a global "pmu-cap-disabled" for KVM_PMU_CAP_DISABLE.
  - Also use sysfs kvm.enable_pmu=N to determine if PMU is supported.
  - Some changes to PMU register limit calculation.
Changed since v2:
  - Change has_pmu_cap to pmu_cap.
  - Use cpuid_find_entry() instead of cpu_x86_cpuid().
  - Rework the code flow of PATCH 07 related to kvm.enable_pmu=N following
    Zhao's suggestion.
  - Use object_property_get_int() to get CPU family.
  - Add support to Zhaoxin.
Changed since v3:
  - Re-base on top of Zhao's queued patch.
  - Use host_cpu_vendor_fms() from Zhao's patch.
  - Pick new version of kvm_arch_pre_create_vcpu() patch from Xiaoyao.
  - Re-split the cases into enable_pmu and !enable_pmu, following Zhao's
    suggestion.
  - Check AMD directly makes the "compat" rule clear.
  - Some changes on commit message and comment.
  - Bring back global static variable 'kvm_pmu_disabled' read from
    /sys/module/kvm/parameters/enable_pmu.
Changed since v4:
  - Re-base on top of most recent mainline QEMU.
  - Add more Reviewed-by.
  - All patches are reviewed.
Changed since v5:
  - Re-base on top of most recent mainline QEMU.
  - Remove patch "kvm: Introduce kvm_arch_pre_create_vcpu()" as it is
    already merged.
  - To resolve conflicts in new [PATCH v6 3/9] , move the PMU related code
    before the call site of is_tdx_vm().
Changed since v6:
  - Re-base on top of most recent mainline QEMU (staging branch).
  - Add more Reviewed-by from Dapeng and Sandipan.
Changed since v7:
https://lore.kernel.org/qemu-devel/20251111061532.36702-1-dongli.zhang@oracle.com/
  - Re-base on top of most recent mainline QEMU (staging branch).
  - Remove PATCH 1 & 2 from the v6 patchset. Zhao may work on them in
    another patchset.
Changed since v8:
https://lore.kernel.org/qemu-devel/20251230074354.88958-1-dongli.zhang@oracle.com/
  - Remove "PATCH v8 4/7" which introduces 'kvm_pmu_disabled' based on
    "/sys/module/kvm/parameters/enable_pmu", as suggested by Zide.
  - Remove the usage of 'kvm_pmu_disabled' ("PATCH v9 4/5").
  - Remove Reviewed-by from Zhao Liu, Sandipan Das and Dapeng Mi from
    "PATCH v9 4/5", because there is change to remove the usage of
    'kvm_pmu_disabled'.
  - Remove "PATCH v8 7/7" as suggested by Zide. Leave it as TODO.

Dongli Zhang (5):
  target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
  target/i386/kvm: extract unrelated code out of kvm_x86_build_cpuid()
  target/i386/kvm: rename architectural PMU variables
  target/i386/kvm: reset AMD PMU registers during VM reset
  target/i386/kvm: support perfmon-v2 for reset

 target/i386/cpu.h     |  16 +++
 target/i386/kvm/kvm.c | 314 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 291 insertions(+), 39 deletions(-)

branch: remotes/origin/staging
base-commit: 146dcea03e276a47404c2cc03ea753fd681c9567

Thank you very much!

Dongli Zhang


