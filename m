Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CB4C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 04:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukEGy-0001f5-6v; Fri, 08 Aug 2025 00:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ukEGv-0001SZ-1o
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 00:00:01 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ukEGr-0007rN-8z
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 00:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754625598; x=1786161598;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=H0oj78qMARfoPCMsvV/I2EmpS1UbBd3NDK4oaELIIhc=;
 b=cbpp8zp2EBXfy9TJM7wRtAmHuAvYAL3XZyf8tjuApNsrWdpK142VVX70
 aXItPlidE54n7dJiw76I2JjGQenCFK13ennqoHE/uEyuuCJVcM05GVuLL
 iwpIWzd05stKpkACR0Zb4vAkblj9iQUDwijb3kxG+EXqva0sPcvvOfFbF
 F70Jqt3dwVpnWFZWCO2S9q7HeJXb5Jx/r3ludLqOXvb42OTh4nL8cJxRD
 2IMk6/dfdRnZ+LxgYJNdGNC2AaKcZ/SqfdoQ/3lxn0p+fhxVFF2l1IUn6
 /QSOqTubIGGdz1FVmRfeiHUT2xeltEV2qulAzJpy3xp3bfs2viq6jQ81g g==;
X-CSE-ConnectionGUID: 0dYCEeE4QbWYnhM8qNskRg==
X-CSE-MsgGUID: N034E+kZRWK3QBr859ee+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67241039"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67241039"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 20:59:49 -0700
X-CSE-ConnectionGUID: uwm4WDHzQoyOKSrrW7UDOw==
X-CSE-MsgGUID: JOemxBgrSKeE/ZaY0dCpMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="202394866"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa001.jf.intel.com with ESMTP; 07 Aug 2025 20:59:47 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chenyi Qiang <chenyi.qiang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH] multiboot: Fix the split lock
Date: Fri,  8 Aug 2025 11:50:27 +0800
Message-ID: <20250808035027.2194673-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

While running the kvm-unit-tests on Intel platforms with "split lock
disable" feature, every test triggers a kernel warning of

  x86/split lock detection: #AC: qemu-system-x86_64/373232 took a split_lock trap at address: 0x1e3

Hack KVM by exiting to QEMU on split lock #AC, we get

KVM: exception 17 exit (error code 0x0)
EAX=00000001 EBX=00000000 ECX=00000014 EDX=0001fb80
ESI=00000000 EDI=000000a8 EBP=00000000 ESP=00006f10
EIP=000001e3 EFL=00010002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0900 00009000 0000ffff 00009300 DPL=0 DS16 [-WA]
CS =c000 000c0000 0000ffff 00009b00 DPL=0 CS16 [-RA]
SS =0000 00000000 0000ffff 00009300 DPL=0 DS16 [-WA]
DS =c000 000c0000 0000ffff 00009300 DPL=0 DS16 [-WA]
FS =0950 00009500 0000ffff 00009300 DPL=0 DS16 [-WA]
GS =06f2 00006f20 0000ffff 00009300 DPL=0 DS16 [-WA]
LDT=0000 00000000 0000ffff 00008200 DPL=0 LDT
TR =0000 00000000 0000ffff 00008b00 DPL=0 TSS32-busy
GDT=     000c02b4 00000027
IDT=     00000000 000003ff
CR0=00000011 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=89 16 08 00 65 66 0f 01 16 06 00 66 b8 01 00 00 00 0f 22 c0 <65> 66 ff 2e 00 00 b8 10 00 00 00 8e d0 8e d8 8e c0 8e e0 8e e8 66 b8 08 00 66 ba 10 05 66

And it matches with what disassembled from multiboo_dma.bin:

 #objdump -b binary -m i386 -D pc-bios/multiboot_dma.bin

  1d1:   08 00                   or     %al,(%eax)
  1d3:   65 66 0f 01 16          lgdtw  %gs:(%esi)
  1d8:   06                      push   %es
  1d9:   00 66 b8                add    %ah,-0x48(%esi)
  1dc:   01 00                   add    %eax,(%eax)
  1de:   00 00                   add    %al,(%eax)
  1e0:   0f 22 c0                mov    %eax,%cr0
> 1e3:   65 66 ff 2e             ljmpw  *%gs:(%esi)
  1e7:   00 00                   add    %al,(%eax)
  1e9:   b8 10 00 00 00          mov    $0x10,%eax
  1ee:   8e d0                   mov    %eax,%ss
  1f0:   8e d8                   mov    %eax,%ds
  1f2:   8e c0                   mov    %eax,%es
  1f4:   8e e0                   mov    %eax,%fs
  1f6:   8e e8                   mov    %eax,%gs
  1f8:   66 b8 08 00             mov    $0x8,%ax
  1fc:   66 ba 10 05             mov    $0x510,%dx

We can see that the instruction at 0x1e3 is a far jmp through the GDT.
However, the GDT is not 8 byte aligned, the base is 0xc02b4.

Intel processors follow the LOCK semantics to set the accessed flag of the
segment descriptor when loading a segment descriptor. If the the segment
descriptor crosses two cache line, it causes split lock.

Fix it by aligning the GDT on 8 bytes, so that segment descriptor cannot
span two cache lines.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 pc-bios/multiboot_dma.bin     | Bin 1024 -> 1024 bytes
 pc-bios/optionrom/multiboot.S |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/multiboot_dma.bin b/pc-bios/multiboot_dma.bin
index c0e2c3102a3358207c61d3ae113524fb6007abc3..e6d0c97093b4fc11bc87fd58cbe6e577c2841cd0 100644
GIT binary patch
delta 42
zcmV+_0M-A12!IHXDg)*M>ya%_3*Z7}i5><3W{V!;v4=GRlehvV0l2f@0vrJWTRMsk
AMgRZ+

delta 46
zcmV+}0MY+|2!IHXDg)vI=aDT>3)})_i5><3W{V!)v4=GRlfVKZ0kpH@0vrL85Ca4O
EZ**7=_y7O^

diff --git a/pc-bios/optionrom/multiboot.S b/pc-bios/optionrom/multiboot.S
index 181a4b03a3f2..c95e35c9cb62 100644
--- a/pc-bios/optionrom/multiboot.S
+++ b/pc-bios/optionrom/multiboot.S
@@ -208,7 +208,7 @@ ljmp2:
 prot_jump:	.long prot_mode
 		.short 8
 
-.align 4, 0
+.align 8, 0
 gdt:
 	/* 0x00 */
 .byte	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
-- 
2.43.0


