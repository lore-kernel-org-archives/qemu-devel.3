Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838E8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4M3F-0001HP-61; Mon, 14 Apr 2025 11:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u4M3D-0001Gd-J3; Mon, 14 Apr 2025 11:48:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u4M3B-0002FY-R8; Mon, 14 Apr 2025 11:48:47 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAf227012967;
 Mon, 14 Apr 2025 15:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q9dWrfpPOxjk1cec4
 q+kp6SXOsX3cigOBnJZC2HCBmk=; b=VrKDSczJjL2YzxSN1jai0x4akgGrnOg9U
 VO5YsvSRhhYB+EbAs5Nc/TuFlCz4U7IniMxRmmBbumBn6LZxcrbpR9y7aSQKBB/l
 m0OIM2eZVnscZjHQLEZgz5xWVfIFEUv5jN5vRf2SjgiE6GiqaGBHhp/BoKMigngW
 wwfkG4jDSYbsXkA+MmS9nkmI1HEJBMQrsGRGlGX4qP16OVOUDOqfEU0yVz5EW7/C
 4lb1+pu5byx77iRAuxE6zcJpdepJjPjWIev0odjl0ZobMy5Cn4TpTBtSHYAXFt2J
 WXE8yMrIFOGRnWG6UK+y2aNeGJEaUxLjDEc0S3X5ol8fT6iTWI7hw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4610tp9eyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 15:48:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EDpdQo010435;
 Mon, 14 Apr 2025 15:48:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjxm8u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Apr 2025 15:48:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53EFmfF420906730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 15:48:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A92755805E;
 Mon, 14 Apr 2025 15:48:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FBD658051;
 Mon, 14 Apr 2025 15:48:40 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Apr 2025 15:48:40 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, seiden@linux.ibm.com
Subject: [PATCH v2 1/3] target/s390x: Introduce constant when checking if PV
 header couldn't be decrypted
Date: Mon, 14 Apr 2025 17:48:36 +0200
Message-ID: <20250414154838.556265-2-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414154838.556265-1-ggala@linux.ibm.com>
References: <20250414154838.556265-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -u9ptHJswRhyOhSV4_ACblxhfnCPp4qB
X-Proofpoint-ORIG-GUID: -u9ptHJswRhyOhSV4_ACblxhfnCPp4qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=829 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ggala@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Introduce a named constant when checking the Set Secure Configuration parameters
UV call return code for the case where no valid host key was found and therefore
the PV header couldn't be decrypted (0x108).

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 target/s390x/kvm/pv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index b191a4a68a..3a0a971f0b 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -147,6 +147,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
     return true;
 }
 
+#define DIAG_308_UV_RC_INVAL_HOSTKEY    0x0108
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
 {
     int ret, pvrc;
@@ -158,7 +159,7 @@ int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
     ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
     if (ret) {
         error_setg(errp, "Failed to set secure execution parameters");
-        if (pvrc == 0x108) {
+        if (pvrc == DIAG_308_UV_RC_INVAL_HOSTKEY) {
             error_append_hint(errp, "Please check whether the image is "
                                     "correctly encrypted for this host\n");
         }
-- 
2.49.0


