Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25001C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCSN-0007Zr-3Q; Wed, 12 Aug 2026 13:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuCSI-0007Yu-Rn; Wed, 12 Aug 2026 13:09:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wuCSF-0007Fa-Go; Wed, 12 Aug 2026 13:09:30 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1ZUC3994359; Wed, 12 Aug 2026 17:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bKGQvy3K/R/OLvNJq
 73qPfskEnjdT256gSdKXG2HIwk=; b=FQ/j0q8Im18kYVJXIc1fpcYMLRDjvoD1f
 mZy1C7bBdcPWL+ENhXNxp4RcMeWKT1J9SJMal2S8JG+LFeQvlcO9BHW2n30jTWvz
 UPuppYw5ZmzCIxj+2AnBVOGfqI4T5y5XcxR6RfWHEhHelsRkTMJxS4IG1BhoZziT
 EnieAoZyHjdm6TJDRtuVQXqpXya0B0ik6CE0Acd0P3h8XzITQzs7dSnSWq6pMuUC
 0r8vu1I3IqsQE9We9XX4NZkR7eHOuEihm7TslQ94Ujd4TGjAecnnHP9FxQlpTbCV
 kNyiV4nOZCkqZiV2IvrI8Q2TULl3aBqRptotxseUZz8cBCXleFvag==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32ubv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:09:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGuoVt006518;
 Wed, 12 Aug 2026 17:09:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6vw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:09:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CH9DDk12845354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:09:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BAAE20043;
 Wed, 12 Aug 2026 17:09:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0EDD2004D;
 Wed, 12 Aug 2026 17:09:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.117])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:09:10 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v6 1/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
Date: Wed, 12 Aug 2026 22:38:52 +0530
Message-ID: <20260812170854.58709-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812170854.58709-1-amachhiw@linux.ibm.com>
References: <20260812170854.58709-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ca8be cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=MBz6HKjOuQBNVPZFXNsA:9
X-Proofpoint-GUID: HX299jUwSAbbP0ZEeBDz9GvT5WlG0-jY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXxEbXiZrmYaUW
 2ycUBPx5EcLW+rEWTUX151iFE5jCQwBFWwG/r8ACPGbKoAg3lyNvGF+0jbB5ayqbcIYcxAjXumf
 /TaGjIOhlQychok2fyG+hBEGj5r+sYghWmxsjdLjYaFmQfhfoGB0MzB9DBw5SFUmIT8jx2PSGHY
 7HMCo6JcTFH5GKPuuDNC39MCYf+9rUukPggHEWRbvcIpLSrJa9p5OaNkO3RzKGzMA9g+GivAgD7
 8GSk7ONePp+Zz8O80jzjgQ7FcqAjmgOwkeMswfoxQD9h2qRrf0zfATYETvLPSpqgzZ4wzdsqgv7
 OzalXQ3LMrlpvr57ETZUaO741HhIWK6UH1OhiDjDHaz4Qq42o8KO4xhOtAxjEM1RdLXkQ8BTtR1
 iVij8H8C0rCTWF2QrGqnNRlHxxmTtHfuaitbPPeMyYuA4QefHLWD9nMYGRwahSbO24nrDBSB8QG
 s+UaziENhVtXgmORJ1w==
X-Proofpoint-ORIG-GUID: 3Tuc2kv3Z26UeQlcl1VOfo2fbaWuYnWW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX8PNlPXgIKlja
 JsSvJYY9RXkw0DHLYbQb+8JJzRYb/hVHu4SEcRxWBuQPUDKSjzMl97X5e8eUdKOkFxmcg3KoUkG
 Mo3X4nYAXDXyq9+CUbbtq43JQDGa84w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

This is a temporary patch intended for review and testing purposes only.
It syncs the QEMU linux-headers with the kernel v9 changes that introduce
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

[1] https://lore.kernel.org/all/20260808161148.66673-1-amachhiw@linux.ibm.com/

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
No changes in this version.

 linux-headers/asm-powerpc/kvm.h | 19 +++++++++++++++++++
 linux-headers/linux/kvm.h       |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f521..2c229fe0562c 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,25 @@ struct kvm_ppc_cpu_char {
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
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index dd52e2a65bfd..aea4ab5c6953 100644
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
2.50.1 (Apple Git-155)


