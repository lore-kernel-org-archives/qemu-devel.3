Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51807CAC58F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLNV-00039S-0q; Sat, 13 Sep 2025 04:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMz-0001oD-Jb
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMv-0005I6-1S
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RYT4EV24HdySf7n68KFr07DQnEMbY9GA58BqcX1V4k=;
 b=VoPNM/Bz51nn9ytw08d7CZ2NUceP7oOAz9qPLOidhWgdiAS78YmVO59EM1HJr3SbHh4tim
 X1eEF2RxOk74n9m7K7v4ogsgmYpVmRIcye3HPVEEESL3WZegGxEZcIo7IlisP7fW5q2YJV
 7DPG6pcUpRf7DF8ditorN2BkQspU4xs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-ogphgreuPrCtrVYq3qOOEg-1; Sat, 13 Sep 2025 04:12:21 -0400
X-MC-Unique: ogphgreuPrCtrVYq3qOOEg-1
X-Mimecast-MFC-AGG-ID: ogphgreuPrCtrVYq3qOOEg_1757751141
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e75fcdddbdso1295768f8f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751140; x=1758355940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/RYT4EV24HdySf7n68KFr07DQnEMbY9GA58BqcX1V4k=;
 b=tNRC91q3OQB6GDLuwRWGMq8nswFFNBR148r30HwhP9VcmTvP9T69bGtHkfnwmJlOJ9
 MPZKtrIbZqQcLzAt0GPLvPh3EuBYgheZiQjIkfpVkvR1bdx/6E7+59GaYDrgCibc1Go6
 QY/odsrlCEX0xovaSmVm1x63p+Hq9I5MkBMAcfK1RFT85LsJCQ3iY5f5AWLvWoKVewlh
 CWdxYggZvLjfyDd/2DcODaD/aSEvlmOENGOqo6BNvFfqU9FR04VILkxZgCVepesbxrD1
 A97qlZO13fvdLnhQf7jOeChLek6JKwtJZInZ9vGppbfuOlI6eMgMFJzuCFUgN3WdL9Bu
 Pavg==
X-Gm-Message-State: AOJu0YyfFKuM5/tyJNe1+meltyLwQSR3r578Vq7Hv1rslpVHPRXbNBcS
 HxiFVYwBs63JW2PcqiucCU7ra7FwTN42cPWAFyskSAnEktxKd/Xg5oCNcvVzi64ZDT4oj3UahJZ
 NSSViL+UOTxPqe8yqV47pVsyooYgg7EqOqM86D/hN1A2+w8PROLN1lHZRh0hyKnTwGKKZStRs06
 BZBe/qT64uakAzOfS0aOpwiT+JhNTQ7qG+u/fHOzMM
X-Gm-Gg: ASbGncsjKAKLEiIQ5AYVWJ9rtEgWN3LdykVm7MV3ayOGJDf7QWDN5o6V0zQQKo1787m
 DQ9t8QltXBusQlwfhyvj28hJyEk4+BiA/FABWlzM9CFSTFyrJ45pXqPGrgVKjXqNh7vXUw2HsiP
 MggSNvvd7pU/YS/N9jb1ce16duEXZaCkXz9avyBlFWefxukhfXUTDlz8BnVFAncHwoWOQza+/Di
 Fg/RbdeVqy0LYwbGaENpHJMesExOrK9vfRAxbKh7YNW7MyPn2Uh7mNCUS9ZAkEgmnLDu6B8M3RQ
 O/HP6m5oDldKRpDuP90V62qKvwUcCxespAyZ9kyx0Al1z9PvvRK1ZZBsuJycAQNBvqG4C90YAjX
 6pPBYOETqYeaOa/ryPKE5T2MjDRgsR2+jgThw7lZfObk=
X-Received: by 2002:a05:6000:2c07:b0:3e7:441e:ca19 with SMTP id
 ffacd0b85a97d-3e7659e20c9mr5003908f8f.43.1757751139732; 
 Sat, 13 Sep 2025 01:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVUi8JUn8NNJp0NVBiBC9SiXcumRjOPqS/uwhfPsQtN7bv1Iu690oMO7/h8JeJlnRR87TVFA==
X-Received: by 2002:a05:6000:2c07:b0:3e7:441e:ca19 with SMTP id
 ffacd0b85a97d-3e7659e20c9mr5003884f8f.43.1757751139261; 
 Sat, 13 Sep 2025 01:12:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607d822fsm9525783f8f.53.2025.09.13.01.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:12:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 56/61] multiboot: Fix the split lock
Date: Sat, 13 Sep 2025 10:09:37 +0200
Message-ID: <20250913080943.11710-57-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 pc-bios/multiboot_dma.bin     | Bin 1024 -> 1024 bytes
 pc-bios/optionrom/multiboot.S |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/multiboot_dma.bin b/pc-bios/multiboot_dma.bin
index c0e2c3102a3358207c61d3ae113524fb6007abc3..e6d0c97093b4fc11bc87fd58cbe6e577c2841cd0 100644
GIT binary patch
delta 42
ycmZqRXyBNj#r%xv^+a8N?gvb%opNjpY29*<Hny8GP2Rzz#<*kieI^-3#%KUKiVj8q

delta 46
zcmZqRXyBNj#r%lr`9xiR?mJAWopNjpY29-7Hny8GO+LV+#JFYiV<s8K$pXwQjQId`
CSPu9A

diff --git a/pc-bios/optionrom/multiboot.S b/pc-bios/optionrom/multiboot.S
index 181a4b03a3f..c95e35c9cb6 100644
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
2.51.0


