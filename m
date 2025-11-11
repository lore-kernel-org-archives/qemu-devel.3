Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603BDCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 06:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIhje-0001ky-2o; Tue, 11 Nov 2025 01:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vIhjc-0001fd-1G
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:20:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vIhjY-0001Ud-2g
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:20:07 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB3cpps025436;
 Tue, 11 Nov 2025 06:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=xd4Hthn9sMbr+itpmFOzNHpgavLzS
 qTDEvV1i4oGWVY=; b=kxbk8XiyZFeTYNrK9hVsjGLmnpvDXftXvVjLAh42ao1ea
 6mQUXMbB9DoTug9cIdaty/2Ib213KX0YMpOC0GnoXsmHLYXx0IWUvicmKE2RjqEQ
 5s7C6jXs7McDl/QeMLnwDL5qDiifczgWEgjZXy+VdpNylQOkoTsUDFcLiAAEEkxS
 VNMyVEwwoVIiMgUN8uHSQekP2sEosOYIdh7pqKOoSJzn1lSfitdGyizZnY1WqLVB
 zIBTEmdwI62pnXhQY7QKzcahJBdMNn/1Evq4poR4kjsIW1+eVBdd4qFGYfW0oZ5B
 qjyFTRzXGzaoy//aB+ztzo1IDMCy701YQr9t409cw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abrpb8mjy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:19:53 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AB68PAq007603; Tue, 11 Nov 2025 06:19:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4a9va9mk8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:19:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AB6C6qh029277;
 Tue, 11 Nov 2025 06:19:51 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4a9va9mk84-1; Tue, 11 Nov 2025 06:19:51 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
Subject: [PATCH v7 0/9] target/i386/kvm/pmu: PMU Enhancement,
 Bugfix and Cleanup
Date: Mon, 10 Nov 2025 22:14:49 -0800
Message-ID: <20251111061532.36702-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110047
X-Proofpoint-GUID: Nobb7F94eErhj2oI-YPMDL9ImnqcarAl
X-Proofpoint-ORIG-GUID: Nobb7F94eErhj2oI-YPMDL9ImnqcarAl
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=6912d58a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NMLfzRoFxyNNWpThmMoA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4OSBTYWx0ZWRfX8KzGJXshM75+
 vbeQCxV1YqfHYRprbwcKElCaQpzI5L7ctm0jHKHSk9wSXWui/dyzv/bP8qcc5s9if+Nu+qqBp6j
 HGrc0hGLMT4xbX0BD5yFGKqh3GMcm6jBXIJK6RMH952GSPS/+6t8yujx9+NWH9cWkhk9xMt8WTQ
 j9FxncZaLbob6lUI87GppuoBvdtT2XfHns+/YWtlmI3Y+G8xKI4f+MgRrAea0+ltgUul9/ibsQF
 OP1ObO1gftgQztbWjxE1ZbdruS3xpXk+WEv7LeDp0BE/4t5pYAEVXumQ0UsopBrExwFltc2I6IN
 93GHhJpz1TAa1Uz8yQEHg0/dCzmKuaK/fRR9YymoxR9eqNnsN+FxcAAIDbPwCSRw/V8O2Xw2RKz
 xz2XxWyXwYt0htZjaFThgF207WJ0mg==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
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

This patchset addresses four bugs related to AMD PMU virtualization.

1. The PerfMonV2 is still available if PERCORE if disabled via
"-cpu host,-perfctr-core".

2. The VM 'cpuid' command still returns PERFCORE although "-pmu" is
configured.

3. The third issue is that using "-cpu host,-pmu" does not disable AMD PMU
virtualization. When using "-cpu EPYC" or "-cpu host,-pmu", AMD PMU
virtualization remains enabled. On the VM's Linux side, you might still
see:

[    0.510611] Performance Events: Fam17h+ core perfctr, AMD PMU driver.

instead of:

[    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
[    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled

To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
when "-pmu" is configured.

4. The fourth issue is that unreclaimed performance events (after a QEMU
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


Dongli Zhang (9):
  target/i386: disable PerfMonV2 when PERFCORE unavailable
  target/i386: disable PERFCORE when "-pmu" is configured
  target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu" is configured
  target/i386/kvm: extract unrelated code out of kvm_x86_build_cpuid()
  target/i386/kvm: rename architectural PMU variables
  target/i386/kvm: query kvm.enable_pmu parameter
  target/i386/kvm: reset AMD PMU registers during VM reset
  target/i386/kvm: support perfmon-v2 for reset
  target/i386/kvm: don't stop Intel PMU counters

 target/i386/cpu.c     |   8 +
 target/i386/cpu.h     |  16 ++
 target/i386/kvm/kvm.c | 355 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 332 insertions(+), 47 deletions(-)

branch: remotes/origin/staging
base-commit: 593aee5df98b4a862ff8841a57ea3dbf22131a5f

Thank you very much!

Dongli Zhang


