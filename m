Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA12C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 05:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wenQi-0005E6-FS; Wed, 01 Jul 2026 01:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wenQd-0005DD-TT; Wed, 01 Jul 2026 01:24:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wenQc-0006rF-4G; Wed, 01 Jul 2026 01:24:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6613ITPq3867661; Wed, 1 Jul 2026 05:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=djYiciTOY1LazIZfV
 u0lv7Rc+0cP6IKZ+ziP+ett4Mk=; b=e9aA8VtGGBJgZzsRCdafPHEo3fHztzWrS
 xMersYXruaV2ENuj9u2/fQK65s4LrNLd0yLn9NqKjfALgAnZA8F3rZxCFvUk5Ceo
 DiI+OnNv1HoH2WzglhlCXkHlesTMVaQSM2xi825siFcU92t9m9IM9rJrVzjEleqe
 rRaMQtGCzFT3rp0TqeYThTE9hC3Ar7u1RkrJc9GeYR8uEGXsFJ2NsebmhkB1xT9f
 QbSf/gkBVe9WZzY4i0NHP1F3ZgrpDmpUApBnFJRNC32EFwKD6xh4I3OBUN4ujb56
 +uIKPZ5pXX0+nSTFwCScIc3dzQPl9Ezn4cYj3Im1UR7+QaqxMp0eA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5tp7c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 05:24:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6615JgdV022029;
 Wed, 1 Jul 2026 05:24:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhdpyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 05:24:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6615NwXf46530840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 05:23:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BD7E20049;
 Wed,  1 Jul 2026 05:23:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C343320040;
 Wed,  1 Jul 2026 05:23:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.190])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 05:23:55 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
Date: Wed,  1 Jul 2026 10:53:39 +0530
Message-ID: <20260701052341.62289-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701052341.62289-1-amachhiw@linux.ibm.com>
References: <20260701052341.62289-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfXwXecdgsGa3O6
 3DqwVEwiQANjp66JzdVowjaY44kVKVkHj6EdLtH/OCeAjxIUlMN6Kg4hYdt9qgRnpkqop58ih7b
 wi1VyiKIICodbFsO0W14ToMlGj4rjDWYVoFTJhcmGTqO4b77Lsl+1EUbtuDTJx9dVbU16/fphG5
 opcYH7QhEUo4rpxZRaw+4UpXdNeZzqRUFj6+oW3OzlDu6v1o7Ku86uIVeBi6DrnfuZB9cPUH85L
 ul6HpRGMw+V2x/QyvEaYQZaEZtYSNitP6+tmrpQu/D/p/6XryydutSC19txbbiDObRyiCoTh+Sd
 BE/2oQTdyDgoXbcbY/xPJ6AlDLkigsiyTCXII3TAjpiJDCU7/WZh6LrKXjtNM6yvdXV701mZXl9
 0TeXwfE+Z0WvbIynQO6yPsNrZZOkyaIW3XzLKMZtmHb9ze/36Y5A1Q/Nr/coWF4VqUiSdJcUlT1
 J/ERZ1KrAXspN2GXq3g==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44a474 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=MBz6HKjOuQBNVPZFXNsA:9
X-Proofpoint-ORIG-GUID: 5Ba5R1ss5CozZLULh-WMhnNbrwg79i-9
X-Proofpoint-GUID: WpVQtmguszroi2JYXzDnhFy6wc7SAEJu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA1MiBTYWx0ZWRfX/Ys7dZlLsZcq
 KgDmM+JLKlGahbA/OGEivt0g/dJAUKSOhRpJ07INUNB3lT94q8Hli5LZGZQsvJoxy5CdHbUI+R/
 3zgbUg4fHRtcqw7ljOhmnt0QhHidGyc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010052
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

This is a temporary patch intended for review and testing purposes only.
It syncs the QEMU linux-headers with the kernel v5 changes that introduce
the KVM_PPC_GET_COMPAT_CAPS ioctl for querying host CPU compatibility
capabilities. The struct kvm_ppc_compat_caps places 'size' as the first
field as required by copy_struct_from/to_user() versioning, with
KVM_PPC_COMPAT_CAPS_SIZE_VER0 (24) defined as the frozen version-floor
constant. The capability number is KVM_CAP_PPC_COMPAT_CAPS (250) and
the ioctl is defined as _IO so the ioctl number remains stable if the
struct grows in future versions. Capability bit definitions for POWER9,
POWER10, and POWER11 compatibility modes are also included.

The actual header sync will be done via scripts/update-linux-headers.sh
once the kernel changes [1] are merged upstream.

[1] https://lore.kernel.org/all/20260628083352.118b631-1-amachhiw@linux.ibm.com/

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v4:
- Changed ioctl definition from _IOWR to _IO to match kernel v5.
- The ioctl number must remain stable if the struct grows; the size
  field is read first by the kernel via get_user() before any
  copy_struct_from_user() call.

 linux-headers/asm-powerpc/kvm.h | 20 ++++++++++++++++++++
 linux-headers/linux/kvm.h       |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f521..e42c86481320 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,26 @@ struct kvm_ppc_cpu_char {
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
+
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 50e87ed72c20..6aa70b8d2e61 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -985,6 +985,8 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1329,6 +1331,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xe4)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.50.1 (Apple Git-155)


