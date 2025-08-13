Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AEFCA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umFUY-00044x-LE; Wed, 13 Aug 2025 13:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUR-00040A-Cb; Wed, 13 Aug 2025 13:42:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUM-0006Zn-Gz; Wed, 13 Aug 2025 13:42:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DAxhTh011153;
 Wed, 13 Aug 2025 17:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TKzUtNPDDvgGMPcPv
 RNrysDoMV7wwMADifmN9SZ0t1A=; b=CgxgqIZuWfxpOyC/6o5MHd+kKgMn5X67G
 g3mIzlelZwbnhA4NKQhqgwB8Y6ghLO4VGN0/taSZEmKg1AfoPHSfkBBaCXTjWo1u
 TLF46Umzxol/ebatJ3ykfjzjmuGZ5/uSDB2Xz8OKwpoJK2PIHw5YDoAjT7EiJYO+
 67A3pqoRV5lxr7fm1IlAYni6bICkP/697IkGDO7MYycDT1939HaUi3MtVx3CWPE7
 E9mPQFLrmqzxh2zDh8KwKvwD1Mt2JSjfUJmuS/ldJnPuRLrUsWMNl7L8gNVs4M3m
 1MMdFaUqJ+r778W39lnTK0qTpycHquvyhk1aoeFJ29OQzcWGNszbQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2d5xu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DF7bgU010656;
 Wed, 13 Aug 2025 17:41:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnurmyx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57DHfr9529426374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 17:41:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE7CA5805C;
 Wed, 13 Aug 2025 17:41:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 510D85805A;
 Wed, 13 Aug 2025 17:41:53 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.61])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Aug 2025 17:41:53 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, alifm@linux.ibm.com
Subject: [PATCH v1 1/4] [NOTFORMERGE] linux-headers: Update for zpci vfio
 device
Date: Wed, 13 Aug 2025 10:41:48 -0700
Message-ID: <20250813174152.1238-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813174152.1238-1-alifm@linux.ibm.com>
References: <20250813174152.1238-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX0H230/AsJJNQ
 AJKaFwaa6jIL48lA8obcASMQji1pmrKEdQm3I7IStDZ9XWLJdwWLAkjrQuCx4xDBru1zCTecMTX
 VpCPhHBRDhjF2Ety5S6uZa3vpX7pN3Sf+IVdXT+gFR1PPGyWaS8jf6pO8v3GmcqMiy4ukllkx/k
 xPvD/k3Y3iQhITRap+aH53sti+ZuL8xdlwuVcyKAOdfAYODNuUui/uJWBs/RTo3dvesjkwnKiNp
 Tvwy8acryK3jt1TVXW7JmIq5PAOaXF6julLOprGu1ID1qvhW9NDhgTC7z++j5/qRfGhNmZ4IQvI
 HyKhTdGb/vxqXVVOBgLtoIaul6tF6T6mEXKJPtFkoS9deUOk8GaHMPEjonP32PB9UcRZWt2eDTx
 gOsmzwTG
X-Proofpoint-GUID: BfEA3lXq-TrETmeSJHgPNgToPgoKVRrS
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689cce63 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=w0j_Q2mzfpb_jSiM1AsA:9
X-Proofpoint-ORIG-GUID: BfEA3lXq-TrETmeSJHgPNgToPgoKVRrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 linux-headers/linux/vfio.h      | 2 ++
 linux-headers/linux/vfio_zdev.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 79bf8c0cc5..a437169bce 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -369,6 +369,8 @@ struct vfio_region_info_cap_type {
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
 
+#define VFIO_REGION_SUBTYPE_IBM_ZPCI_ERROR_REGION (2)
+
 /* sub-types for VFIO_REGION_TYPE_GFX */
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
index 77f2aff1f2..bcd06f334a 100644
--- a/linux-headers/linux/vfio_zdev.h
+++ b/linux-headers/linux/vfio_zdev.h
@@ -82,4 +82,9 @@ struct vfio_device_info_cap_zpci_pfip {
 	__u8 pfip[];
 };
 
+struct vfio_device_zpci_err_region {
+	__u16 pec;
+	int pending_errors;
+};
+
 #endif
-- 
2.43.0


