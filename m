Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94917C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umFUU-00042B-Dg; Wed, 13 Aug 2025 13:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUJ-0003wu-I5; Wed, 13 Aug 2025 13:42:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUC-0006Zr-VC; Wed, 13 Aug 2025 13:42:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DCZwjf015923;
 Wed, 13 Aug 2025 17:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uB2bTzkXppJViLbSD
 8t1yaWti4gnWnEsF4ElFDnBaaY=; b=BnWq3GebsYkUAbOaW4nK5/JK4PYPdxeOn
 f5ajI9eJcEmjWYGyPuZMmOYYWRLLuTJAv+4blq7U34Mm4GL0vazrKL0Z8xEsZ/AH
 YQXO4sRwEpQONtv2opEGeCrtfQ+3uEZesSGmL7A+jdh6pSSjqDdA1EfOo34D2QKE
 znt73LpV3Dp2VBWWH3ucDMVGdSU0IuH67Q9qI2joTwJOudS0erZLLL7SK8VJbFt2
 BEhMCo7ib53iF310N6NAkG2dNDlI7YL/rhpAYwI8gU/F2dxQHgoX6ZbBMS31epLU
 o8PT2Tuj0Dd1NNiaY0/Zk6FaUh6QjPNYvlxCx9uvAGKFvkeGaZdMQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14nvwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFhZvv026275;
 Wed, 13 Aug 2025 17:41:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh218jnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57DHfs6A10749140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 17:41:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90BA458051;
 Wed, 13 Aug 2025 17:41:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 046165805A;
 Wed, 13 Aug 2025 17:41:54 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.61])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Aug 2025 17:41:53 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, alifm@linux.ibm.com
Subject: [PATCH v1 2/4] vfio/pci: Add an architecture specific error handler
Date: Wed, 13 Aug 2025 10:41:49 -0700
Message-ID: <20250813174152.1238-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813174152.1238-1-alifm@linux.ibm.com>
References: <20250813174152.1238-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AHhBhLTjLY30DkQBelJZgqk90t6uyXrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX4J+jn/TgNV77
 8pDYLsA3wxYDO4lvTi787pUzTBZN+hNsOnKRTg+fdj4cMbMFO7Bfh9EVNFgcloO+d+kNOovR4cF
 gdPZwhHIbL186AFnK3oU9TD53KMzOfdCLt6g48YP+6MZUlqPA6PqiV0etD5KufuNlmP40Iz4FvE
 /qghHhH3zvfwXDh2yc5cw+La9sX8j3hPOHr+qU3iGB5bj+KqDbIseIAFNIk4yq1rcHP5E3eF5FS
 rX6K7T/AyxFJKKHtztl7jN9juyfVhFN2KPfmA1Ed+xbykN121U7Edq0kEOawmCZOqI6Hc/DEyd/
 b7swa1uOdxUQ1tVIUaxB89XCgp8hRAagpeRquvS8imyaDeU+Bn2lLF+WI118H/T+FEpDkU/8hwT
 SEX7JQL7
X-Proofpoint-GUID: AHhBhLTjLY30DkQBelJZgqk90t6uyXrr
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689cce65 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=9EM4svpYijrQoNaXIWkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Provide a architecture specific error handling callback,
that can be used by platforms to handle PCI errors for
passthrough devices.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/vfio/pci.c | 5 +++++
 hw/vfio/pci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 07257d0fa0..3c71d19306 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3026,6 +3026,11 @@ static void vfio_err_notifier_handler(void *opaque)
         return;
     }
 
+    if (vdev->arch_err_handler) {
+        vdev->arch_err_handler(vdev);
+        return;
+    }
+
     /*
      * TBD. Retrieve the error details and decide what action
      * needs to be taken. One of the actions could be to pass
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 810a842f4a..45d4405e47 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -145,6 +145,7 @@ struct VFIOPCIDevice {
     EventNotifier err_notifier;
     EventNotifier req_notifier;
     int (*resetfn)(struct VFIOPCIDevice *);
+    void (*arch_err_handler)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
     uint32_t sub_vendor_id;
-- 
2.43.0


