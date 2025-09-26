Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE3CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23e9-0007GU-6T; Fri, 26 Sep 2025 04:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23dT-0006xU-13; Fri, 26 Sep 2025 04:17:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23dG-0001rL-Ed; Fri, 26 Sep 2025 04:16:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 72A0C157D75;
 Fri, 26 Sep 2025 11:10:34 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 83B19290C59;
 Fri, 26 Sep 2025 11:10:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 45/60] multiboot: Fix the split lock
Date: Fri, 26 Sep 2025 11:10:13 +0300
Message-ID: <20250926081031.2214971-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250808035027.2194673-1-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 4c8f69b94839f72314c69902312068d0b9b05a34)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/pc-bios/multiboot_dma.bin b/pc-bios/multiboot_dma.bin
index c0e2c3102a..e6d0c97093 100644
Binary files a/pc-bios/multiboot_dma.bin and b/pc-bios/multiboot_dma.bin differ
diff --git a/pc-bios/optionrom/multiboot.S b/pc-bios/optionrom/multiboot.S
index 181a4b03a3..c95e35c9cb 100644
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
2.47.3


