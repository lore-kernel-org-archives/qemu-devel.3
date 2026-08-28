Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3AAC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpkY-00055F-S7; Fri, 28 Aug 2026 02:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkW-00054m-WE
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpkU-0000dL-OJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:07:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S23Upb516476
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2zhfYelESrOpmAcce
 kms+Z7GdJwQ4nw2pu5dHMID0T4=; b=Nwx3mDDf6z3dXiRzlcvz9mlMGXlmSr8cS
 Q03mfHGCM2aBQYbXLiS9kJ+Zm/9T1obfSX6tM5evTliUI6d6cecUo56Xz/5Oxl+m
 s0sRqsR6KoUjtF79T7PkKlECrZV3Pvvnnh6ngiVhvETl8Q0vkKYLI/vdqeG065I9
 rZCwDxUCHzBQkr3e6h+Nakra/2j3px5gPMYEyf3Sv0AYwmbvL0fuBBBSjWahiJ1k
 3DKimLzdzLmAMzFl+Uf05PgsQmB1UnH1z42xiITfQTgbuG21dNRmCx+dRuprDwl7
 4TC9PFORSyZOIbX1Jd1RkGmjbFJsLpKGgx2RWGit2NP0PqZEdcYuA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jadkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uNuZ003691
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhmjw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:07:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S67SrW44957960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:07:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4B8420043;
 Fri, 28 Aug 2026 06:07:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DC8C20040;
 Fri, 28 Aug 2026 06:07:27 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:07:27 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 01/41] linux-headers: Update to include KVM_CAP_PPC_COMPAT_CAPS
Date: Fri, 28 Aug 2026 11:36:36 +0530
Message-ID: <20260828060716.91672-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX/hhCouW2KxMW
 XWRw5e3KZ1kJbNxWDa2k4JwTJef7++MCeGJ8yEigz9UeYAGRoxjg9dLOPX0fzTwnK/4Y5zlm2ZE
 BBlUNV7TfUTe5AF5QGp5Ig4xwGkGjoc=
X-Proofpoint-GUID: SRTpNQhbna1EWBivtwACpq-m9Kcjk_2C
X-Proofpoint-ORIG-GUID: SRTpNQhbna1EWBivtwACpq-m9Kcjk_2C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX6a2KypfIA6nZ
 mvLLPisZtU9BuotlQ3OtAKNy430dgekWbNchTU5q5v+dDCXe8U36aacVkPoZ+klxb8B9T1Rge6M
 QSKXGvnIKvVvXqTYl5HtumuHssULrPJSXMw4o8zev3cyeOffSMfFKFI9z4MlfZIwNFXywhsXnYI
 XLXhLuesWnFlAWH0tyin3OSHF3zkytGNLcRcfRuklZwj3uivWOLwMz9r1x6rm5kvkgNZbsoLkT6
 OrJHtfPKjLuHiXy3Xdlxo4V3Xm1EMnFLJkej0RlevsfJ1523iDYIRtELEFM2N45A4N9OrL1jgn1
 Wg0GnbxCiirlZ75yI8168miIQx/X+/YiQhfjEXSUrshsQjP1/JUdvVlqB7cKg8xTvrSIS8c7My1
 8b7gMCPGFB6qI5LlSjs2eKSoDVWZd9hBt5Ow6qBULDLP4X/2n6M4Ev18ao58m5djW+EYv+8c3e/
 UgnGnAlC+/V0nu0n1bw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a9125a5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FAdeBzD3L_d8WbVtQBUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

Sync linux headers from Linux kernel commit 1200d84f4c0a
("Merge tag 'powerpc-7.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux").

This picks up the new KVM_CAP_PPC_COMPAT_CAPS capability for powerpc,
which introduces:
- struct kvm_ppc_compat_caps: reports processor compatibility modes
  supported by the host (POWER9, POWER10, POWER11)
- KVM_PPC_GET_COMPAT_CAPS ioctl (KVMIO 0xb8)
- KVM_CAP_PPC_COMPAT_CAPS (cap #250) in linux/kvm.h

The sync is needed to get the corresponding Qemu series[1] merged.

[1]: https://lore.kernel.org/all/20260812170854.58709-1-amachhiw@linux.ibm.com/

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260819045924.11732-1-amachhiw@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/standard-headers/linux/const.h  |  4 ++--
 linux-headers/asm-arm64/unistd_64.h     |  1 +
 linux-headers/asm-generic/unistd.h      |  6 +++++-
 linux-headers/asm-loongarch/unistd_64.h |  1 +
 linux-headers/asm-mips/unistd_n32.h     |  1 +
 linux-headers/asm-mips/unistd_n64.h     |  1 +
 linux-headers/asm-mips/unistd_o32.h     |  1 +
 linux-headers/asm-powerpc/kvm.h         | 18 ++++++++++++++++++
 linux-headers/asm-powerpc/unistd_32.h   |  1 +
 linux-headers/asm-powerpc/unistd_64.h   |  1 +
 linux-headers/asm-riscv/unistd_32.h     |  1 +
 linux-headers/asm-riscv/unistd_64.h     |  1 +
 linux-headers/asm-s390/unistd_64.h      |  1 +
 linux-headers/asm-x86/unistd_32.h       |  1 +
 linux-headers/asm-x86/unistd_64.h       |  1 +
 linux-headers/asm-x86/unistd_x32.h      |  1 +
 linux-headers/linux/const.h             |  4 ++--
 linux-headers/linux/kvm.h               |  3 +++
 18 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/standard-headers/linux/const.h b/include/standard-headers/linux/const.h
index c6a9d0c983..92635cec4a 100644
--- a/include/standard-headers/linux/const.h
+++ b/include/standard-headers/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing __asm__ support
  *
diff --git a/linux-headers/asm-arm64/unistd_64.h b/linux-headers/asm-arm64/unistd_64.h
index 70b3754a42..4329a2ad54 100644
--- a/linux-headers/asm-arm64/unistd_64.h
+++ b/linux-headers/asm-arm64/unistd_64.h
@@ -328,6 +328,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-generic/unistd.h b/linux-headers/asm-generic/unistd.h
index a627acc8fb..5b7e77a7c7 100644
--- a/linux-headers/asm-generic/unistd.h
+++ b/linux-headers/asm-generic/unistd.h
@@ -863,8 +863,12 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+/* fs/open.c */
+#define __NR_fchroot 472
+__SYSCALL(__NR_fchroot, sys_fchroot)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
diff --git a/linux-headers/asm-loongarch/unistd_64.h b/linux-headers/asm-loongarch/unistd_64.h
index 3a29d86e1d..b525f2d7b8 100644
--- a/linux-headers/asm-loongarch/unistd_64.h
+++ b/linux-headers/asm-loongarch/unistd_64.h
@@ -325,6 +325,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-mips/unistd_n32.h b/linux-headers/asm-mips/unistd_n32.h
index 5fa1ee0cb4..f883da76c9 100644
--- a/linux-headers/asm-mips/unistd_n32.h
+++ b/linux-headers/asm-mips/unistd_n32.h
@@ -400,5 +400,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_N32_H */
diff --git a/linux-headers/asm-mips/unistd_n64.h b/linux-headers/asm-mips/unistd_n64.h
index e1f873d83a..59837eb866 100644
--- a/linux-headers/asm-mips/unistd_n64.h
+++ b/linux-headers/asm-mips/unistd_n64.h
@@ -376,5 +376,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_N64_H */
diff --git a/linux-headers/asm-mips/unistd_o32.h b/linux-headers/asm-mips/unistd_o32.h
index 8207e9ca4f..485872076e 100644
--- a/linux-headers/asm-mips/unistd_o32.h
+++ b/linux-headers/asm-mips/unistd_o32.h
@@ -446,5 +446,6 @@
 #define __NR_file_setattr (__NR_Linux + 469)
 #define __NR_listns (__NR_Linux + 470)
 #define __NR_rseq_slice_yield (__NR_Linux + 471)
+#define __NR_fchroot (__NR_Linux + 472)
 
 #endif /* _ASM_UNISTD_O32_H */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f5..913a64b901 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,24 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	size;			/* Size of this structure */
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
+
+/*
+ * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
+ * These bits indicate which processor compatibility modes are supported.
+ */
+#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
+#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
+#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
+#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
+					 KVM_PPC_COMPAT_CAP_POWER10 | \
+					 KVM_PPC_COMPAT_CAP_POWER11)
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/asm-powerpc/unistd_32.h b/linux-headers/asm-powerpc/unistd_32.h
index 1f63360120..2677c54903 100644
--- a/linux-headers/asm-powerpc/unistd_32.h
+++ b/linux-headers/asm-powerpc/unistd_32.h
@@ -453,6 +453,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-powerpc/unistd_64.h b/linux-headers/asm-powerpc/unistd_64.h
index 87439c53c1..6fc19ccccd 100644
--- a/linux-headers/asm-powerpc/unistd_64.h
+++ b/linux-headers/asm-powerpc/unistd_64.h
@@ -425,6 +425,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-riscv/unistd_32.h b/linux-headers/asm-riscv/unistd_32.h
index 828f3c2b9d..1039bdc6cf 100644
--- a/linux-headers/asm-riscv/unistd_32.h
+++ b/linux-headers/asm-riscv/unistd_32.h
@@ -319,6 +319,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-riscv/unistd_64.h b/linux-headers/asm-riscv/unistd_64.h
index 8fa59835a3..72040a5498 100644
--- a/linux-headers/asm-riscv/unistd_64.h
+++ b/linux-headers/asm-riscv/unistd_64.h
@@ -329,6 +329,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-s390/unistd_64.h b/linux-headers/asm-s390/unistd_64.h
index 01f674c1bc..3d3747e3ca 100644
--- a/linux-headers/asm-s390/unistd_64.h
+++ b/linux-headers/asm-s390/unistd_64.h
@@ -391,6 +391,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_32.h b/linux-headers/asm-x86/unistd_32.h
index e945468829..7f298247f8 100644
--- a/linux-headers/asm-x86/unistd_32.h
+++ b/linux-headers/asm-x86/unistd_32.h
@@ -462,6 +462,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_32_H */
diff --git a/linux-headers/asm-x86/unistd_64.h b/linux-headers/asm-x86/unistd_64.h
index 3c49b00ed1..fbddeb4bc3 100644
--- a/linux-headers/asm-x86/unistd_64.h
+++ b/linux-headers/asm-x86/unistd_64.h
@@ -386,6 +386,7 @@
 #define __NR_file_setattr 469
 #define __NR_listns 470
 #define __NR_rseq_slice_yield 471
+#define __NR_fchroot 472
 
 
 #endif /* _ASM_UNISTD_64_H */
diff --git a/linux-headers/asm-x86/unistd_x32.h b/linux-headers/asm-x86/unistd_x32.h
index bd2af9ad08..629770ed4b 100644
--- a/linux-headers/asm-x86/unistd_x32.h
+++ b/linux-headers/asm-x86/unistd_x32.h
@@ -339,6 +339,7 @@
 #define __NR_file_setattr (__X32_SYSCALL_BIT + 469)
 #define __NR_listns (__X32_SYSCALL_BIT + 470)
 #define __NR_rseq_slice_yield (__X32_SYSCALL_BIT + 471)
+#define __NR_fchroot (__X32_SYSCALL_BIT + 472)
 #define __NR_rt_sigaction (__X32_SYSCALL_BIT + 512)
 #define __NR_rt_sigreturn (__X32_SYSCALL_BIT + 513)
 #define __NR_ioctl (__X32_SYSCALL_BIT + 514)
diff --git a/linux-headers/linux/const.h b/linux-headers/linux/const.h
index c6a9d0c983..92635cec4a 100644
--- a/linux-headers/linux/const.h
+++ b/linux-headers/linux/const.h
@@ -13,7 +13,7 @@
  * leave it unchanged in asm.
  */
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
 #else
@@ -28,7 +28,7 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * Missing __asm__ support
  *
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index dd52e2a65b..aea4ab5c69 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -986,6 +986,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1330,6 +1331,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.52.0


