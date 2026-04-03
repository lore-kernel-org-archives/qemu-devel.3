Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7CAD730A3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 05:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8XEG-0004D8-8b; Fri, 03 Apr 2026 01:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8XEE-0004CW-IT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 01:37:58 -0400
Received: from qs-2001g-snip4-11.eps.apple.com ([57.103.87.73]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8XEC-00088I-OL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 01:37:58 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 0D536180012B; Fri, 03 Apr 2026 05:37:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775194675; x=1777786675;
 bh=ReO+rvoPX723ct/q7fzalu9vaTfJ/QfGTz/Mxd6q+FA=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=PjltpKyZ7Zng1S5k9ASBRaM5QQO1NbQGAeFINg6G++HKdLefYa5PThOk1x81edx6TdKmCCV149Dydphx21T28zYF0H7UaxBMM9V7wNZ7ooHQLdbxrnp3UPXt0UkfhqYzGZrtFU/WKOomfxez3CtT1EL6bu+7mRUUFzgJn6iNWUHH1cR7UvAwLKg2wt624x7fABZGUMOAJ9WIMEO5qeCD9dw7Q9N0oJwmr4fsHrhe/aLsZAlYhpysXDns2UcH+w+jL9l1xPu4SZBpBvYXm+Y+ZYQnTRImGoqn1vhzexIJjtmoHPMgcqT83Nx5w8SBRC/ogpLGgJ+tWkUHVlH3TUIpfg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 2B11E1800101; Fri, 03 Apr 2026 05:37:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v4 0/7] whpx: i386: x2apic emulation for kernel-irqchip=off,
 feature probing
Date: Fri,  3 Apr 2026 07:37:41 +0200
Message-ID: <20260403053748.78831-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Q74wh_MSVTdr0Vp0zwFJsF-KiiKmLcnJ
X-Authority-Info-Out: v=2.4 cv=JJA2csKb c=1 sm=1 tr=0 ts=69cf5231
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=U-mDERgiERHxp3lFF3YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q74wh_MSVTdr0Vp0zwFJsF-KiiKmLcnJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA0NyBTYWx0ZWRfX43FjF4OOhiT4
 65zJxwKuglRHlxqrCk9lY0QriB/626R4AqG4S2GHIwWds8puZnQGzqe7ssItPsaZ6UgVzWx7Bky
 XknExmWdHSAX5liM/MQYr057O7wIqehqgN172+H9rIXPqAJk7WzplkcIGwoVKq3qlnSLktWNToT
 UxscqFmOyUy1dNQYr+OlB3oF2ILtRj7JARhCXlJjfgw44lbQMpElCaIwyqrlBIRMjviVI+IherN
 qGL+QkHpatp4md5TOkGGgNiINALNI7hbRiklDcXlzlKM0HHyLxE0FAEHmHwqWq8kVHif1uMm8vb
 6VtUSSmJ/7/97z/ojenoUaNelnb7ISP9BgQxZqBtVwRVWqlv3R8LsxuuswQs+U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=583
 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1030 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604030047
Received-SPF: pass client-ip=57.103.87.73;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

"whpx: i386: disable TbFlushHypercalls for emulated LAPIC" is a
bugfix, and "target/i386: emulate: include name of unhandled instruction"
is a debugging aid.

"whpx: i386: x2apic emulation" makes things slightly better for Windows
10 users. But I strongly recommend *not* relying on it when possible and
using kernel-irqchip=on instead. On Windows 10 however that's more murky
because PIC interrupt injection is broken (interrupts don't wake the vCPU
from HLT) in that case.

"whpx: i386: wire up feature probing" is yet another commit adding a code path
not used on Windows 10. It'll tell the user today which CPU features they set
are incompatible with the hardware but it does not sync that to the CPUID view
that the guest has.

And then another commit to enable x2apic emulation by default even for
kernel-irqchip=off + re-introducing provided by QEMU enlightenments in a more
functional form to signal that the x2apic can be used. I'm not aware of the
actual vmware freq leaf being used though.

"whpx: x2apic emulation for kernel-irqchip=off follow-up" is rolled into this series.

"whpx: i386: reintroduce enlightenments for Windows 10" is a bugfix to make
x2APIC work as intended on Windows 10 without emulating an IOMMU.

And then at the end but dependent on this series, CPUID intercepts finally...
However that's only supported starting from Windows 11/Server 2022.

Some performance (or lack thereof...) numbers:

On a Ryzen 7 8700GE with a Windows 10 VM running with KVM in nested virt, with
kernel-irqchip=off for the virt Alpine Linux x86_64 ISO (3.23.3) with -smp cores=2,
boot times as reported through dmesg:

- QEMU 10.2: 83 seconds
- QEMU 10.2 with a single core: 18.1 seconds
- as of this series, x2apic forced off: 29 seconds
- as of this series, out of the box: 18 seconds
- and with 1 core instead of two: 12.6 seconds

And with this series on a Windows 11 VM on the same hardware:
- kernel-irqchip=on: 6.5 seconds
- kernel-irqchip=on, x2apic forced off: 7.6 seconds
- kernel-irqchip=off: 8.3 seconds
- hyperv=off,kernel-irqchip=off: 7.6 seconds... which is faster,
so the absence of enlightenment support on Windows 10 doesn't explain things...

With kernel-irqchip=on on Windows 10, when booting with SeaBIOS, it gets stuck in
syslinux due to PIC interrupt injection being broken there. That can be counted
as an infinite boot time (?).

checkpatch false positives:

ERROR: spaces required around that '*' (ctx:WxV)
+         UINT32 Ecx, WHV_CPUID_OUTPUT *CpuidOutput))

Not a multiplication but a pointer reference.

ERROR: space prohibited after that '&' (ctx:ExW)
+                    & CPUID_7_0_EDX_CET_IBT) {
                     ^

ERROR: space prohibited after that '&' (ctx:ExW)
+                    & CPUID_7_0_ECX_CET_SHSTK) {
                     ^

Because it's multiline.

Changes in v4:

- Ugh for a revision sent quickly, unbreaking the arm64 build...
- and making checkpatch happier to some extent

Changes in v3:

- Fixing CPUID intercepts so that QEMU CPU models work fine now, instead
of the partial intercept that was present in QEMU 10.2
- cleanups

Changes in v2:

- GCC warned when a variable name was re-used within a different (but overlapping)
scope in the same function. It also warned with a -Werror=maybe-uninitialized for
the MSR write case. Address those
- make the in-KVM enlightenments path available on Windows 11 too when -M hyperv=off.

Mohamed Mediouni (7):
  target/i386: emulate: include name of unhandled instruction
  whpx: i386: x2apic emulation
  whpx: i386: wire up feature probing
  whpx: i386: disable TbFlushHypercalls for emulated LAPIC
  whpx: i386: enable x2apic by default for user-mode LAPIC
  whpx: i386: reintroduce enlightenments for Windows 10
  whpx: i386: introduce proper cpuid support

 accel/whpx/whpx-common.c       |   2 +
 include/system/whpx-internal.h |  10 ++
 target/arm/whpx/whpx-all.c     |   1 +
 target/i386/cpu.c              |  25 +++
 target/i386/emulate/x86_emu.c  |   4 +-
 target/i386/whpx/whpx-all.c    | 295 ++++++++++++++++++++++++++++++++-
 target/i386/whpx/whpx-i386.h   |   4 +
 7 files changed, 331 insertions(+), 10 deletions(-)
 create mode 100644 target/i386/whpx/whpx-i386.h

-- 
2.50.1 (Apple Git-155)


