Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1047DCD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 20:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIu4U-0000ZN-Qg; Fri, 01 May 2026 16:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu4R-0000YN-SD; Fri, 01 May 2026 16:02:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wIu4Q-0001Au-CD; Fri, 01 May 2026 16:02:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64197Xb81317126; Fri, 1 May 2026 20:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2IaD55tpATj/ZVnph
 n8buKRjOnzNdJxxssi+olLWHzw=; b=CUE516T7ZQklu//l6WdrkQ5unqhOEHYEd
 7wn0HXdl3fIMYbswL4pcj2JkMQSoRviyh8I1Fr75S/H1aoS3lWyDwYdNvStE+aZ0
 3F48+YKWbe4N8299KrvW1qYoFWX8Ka51zjdOjrgQFn3V5mVsMHhKybCA9MkEfpop
 5pmOSQwTeEvwt6AuzB+KwIp4hABiFMnuSssD+yrrBk0g11/2GC6ge06LSsiIHwSq
 JKXa9iT8+/ywhThV3RChrGt61nBRuGrxT+zoZJIxOm6DHFY1GAg2J3vaXcHIQBci
 2nRgFvccG4rpxsPxStcX+c+suNj4Tgr7KSK4a2YkYbiCYhiMMhlvg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1k4cq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:02:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641Jrnrd000693;
 Fri, 1 May 2026 20:02:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5grt8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 20:02:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641K2YgS32571910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 20:02:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E41D58043;
 Fri,  1 May 2026 20:02:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2C4358055;
 Fri,  1 May 2026 20:02:32 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.25])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 20:02:32 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: oelghoul@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com, clg@redhat.com
Subject: [RFC PATCH v1 1/5] [do-not-merge] linux-headers: Add definitions for
 VFIO zPCI FMB passthrough
Date: Fri,  1 May 2026 16:00:22 -0400
Message-ID: <20260501200026.22784-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260501200026.22784-1-oelghoul@linux.ibm.com>
References: <20260501200026.22784-1-oelghoul@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfX6X3WidarEm5T
 wfQKfQF7K/DEgeMJGBoWdvlDx2TTGgxRv7qBYb+SFUeI7yJO3jKgBi2KQ0EVVRv0P4ouB3kOlfY
 SkI+7qwKHuxlZyUprOKbFvrateskNvhXKZozScRC9x4g3JR3P3E9n9ghcc99tydhSp/Ilt1jTCa
 bdhtG9pk0DeO0JVWevPzIMCeDmV3sZmJ7W3Z+30GlETj/VwZ6QcgMD0xPneAfELpNruxTzDTL8d
 COeEOHdMorXZqXXgJOgPXHVru1H0jqA00ROQ8xXjN9qYGbIzcFHS5kGSyYvKu2iR4wcBQ0mP0ay
 0GiiKx1k2ItKOxRq3lR/JzdECQv7ebtR8aN++C+J/7K8S9YH2E3EssGNPZhLD0qaCUZS4K8nps7
 o6LklKvjhxfyVITq+ZPF90Y2XfHvOQ11lJSUJVL2yBhhuk2zeZ8Ttn4+epOfrC2iQAN1gpJQf8D
 sDHVI/lisoyM5g1OzOQ==
X-Proofpoint-GUID: PsLjcL_buIwjBmG76iIIBuieJbZmTb_v
X-Proofpoint-ORIG-GUID: PsLjcL_buIwjBmG76iIIBuieJbZmTb_v
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f506dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=05gaV3nvTOrdMBspcBoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010195
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

This is a temporary patch intended for testing purposes only. It defines
the new VFIO device feature for FMB passthrough on zPCI.

Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 linux-headers/linux/vfio.h | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 720edfee7a..ee5f8a2276 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1506,6 +1506,49 @@ struct vfio_device_feature_dma_buf {
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };
 
+/**
+ * Upon VFIO_DEVICE_FEATURE_GET, provide FMB passthrough for VFIO zPCI devices.
+ * 
+ * Upon VFIO_DEVICE_FEATURE_SET, only the flags field is read while the
+ * remainder of the structure is ignored. This allows the driver to enable or
+ * disable the FMB while also leaving reserved bits for future flag expansion.
+ * All reserved fields should be zero for future compatibility.
+ */
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB 13
+#define VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED	0x1
+
+struct vfio_device_feature_zpci_fmb {
+	__u64 flags;
+	__u32 format:	8;
+	__u32 fmt_ind:	24;
+	__u32 samples;
+	__u64 last_update;
+	__u64 ld_ops;
+	__u64 st_ops;
+	__u64 stb_ops;
+	__u64 rpcit_ops;
+	union {
+		struct {
+			__u64 dma_rbytes;
+			__u64 dma_wbytes;
+		} fmt0;
+		struct {
+			__u64 rx_bytes;
+			__u64 rx_packets;
+			__u64 tx_bytes;
+			__u64 tx_packets;
+		} fmt1;
+		struct {
+			__u64 consumed_work_units;
+			__u64 max_work_units;
+		} fmt2;
+		struct {
+			__u64 tx_bytes;
+		} fmt3;
+	};
+	__u64 reserved[16];
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.52.0


