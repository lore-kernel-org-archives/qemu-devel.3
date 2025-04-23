Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574B1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 08:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7VAi-0000t5-H6; Wed, 23 Apr 2025 04:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAd-0000pZ-Gd; Wed, 23 Apr 2025 04:09:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1u7VAb-0006kg-12; Wed, 23 Apr 2025 04:09:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6fjbb007098;
 Wed, 23 Apr 2025 08:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JkSqkirxZtqwpMLly
 FWcEWPfWxc+rz+ds/80NLD8cOk=; b=ESqPQR0FgQX62gnjX0msiKXFYJ/tWamza
 T4HUVmxIJwkplI+psdxdgdkwsm1stXQLa8BTNkDlpoeYhz8ICuEz5XKTQwTx1LbV
 xlTOHyS9qJuZlcQJK8EV7CCdw/UPhDFiN5ErTQMPsSn/tTdWaWUNhiqDky2hhwkc
 YKTWVd4v1w3GrghLrF9MS1idxpW+9sQPdFXvp36HZR10CdFq/ddtUmaUkla/sk4I
 yp4j8LNtrpIWwUZ5IWQjIFvFFlvc0WZgrWS60ffEv1EUP43/91/pvYrUXatfudLb
 g4liI+/8/K8YOZWRZv5kE4m72pgqDdh0EjB6kx6wxnoZ/7v1qo1+A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466psnsa5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6T9Cs008557;
 Wed, 23 Apr 2025 08:09:20 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfxj3jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 08:09:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53N89JVY32244468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 08:09:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CFCC58061;
 Wed, 23 Apr 2025 08:09:19 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E090E5803F;
 Wed, 23 Apr 2025 08:09:17 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.152.108.100])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Apr 2025 08:09:17 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Steffen Eiden <seiden@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH v5 1/3] target/s390x: Introduce constant when checking if PV
 header couldn't be decrypted
Date: Wed, 23 Apr 2025 10:09:13 +0200
Message-ID: <20250423080915.1048123-2-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423080915.1048123-1-ggala@linux.ibm.com>
References: <20250423080915.1048123-1-ggala@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JRlyPInWhPsMQmIdhSQjY22WAFMBx8yF
X-Authority-Analysis: v=2.4 cv=BIezrEQG c=1 sm=1 tr=0 ts=6808a030 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=iZ54oBYeXFZcgQDtmRkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NCBTYWx0ZWRfX2Or0XLUxVcRF
 8Q/bD4n5A2fSP+pBDUuxy/jLCBg7HS5uZYu6FVYi/bI5xEEaU0UD1Ds3y+PeULIhuqDEtcCtj/a
 EICKuhXrsUMHr4/uSA5VaRTz4NS7/ZeNoq2+2onNBucmgriL+Mer/ADcT2O69CnNhY1scx06Ac1
 tQlO3qo1FHpWXk8p4eN08WAnNuf0xdhOSGUWhzCxbWtMmW3+71J0VYBTCB+fbLGTYf+epkiwHyq
 Eqa2WAs710sGR5M0GRyb3uoUTwsyzyWm0gBwi+SIgFHkx7MUX3/0HiO09KssysLeKQsOUwjewd1
 1w1dNS4D2Q7JBDcLVwg6o6oStZbdCchp+LuxbesCnYX1oY+jcVcyOPZKTxrRRpQVnAr7NRdn3t8
 fzl4VOv8PrSc8IUdBtQNbP2iP+4oGgNMtgHcBuGrVnWne7/1+466U0ZwyAmnPDTKYwOiOuje
X-Proofpoint-ORIG-GUID: JRlyPInWhPsMQmIdhSQjY22WAFMBx8yF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=797 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ggala@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Introduce a named constant when checking the Set Secure Configuration parameters
UV call return code for the case where no valid host key was found and therefore
the PV header couldn't be decrypted (0x108).

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 target/s390x/kvm/pv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index b191a4a68a..c1edb860d8 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -147,6 +147,7 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
     return true;
 }
 
+#define UV_RC_SSC_INVAL_HOSTKEY    0x0108
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
 {
     int ret, pvrc;
@@ -158,7 +159,7 @@ int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
     ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
     if (ret) {
         error_setg(errp, "Failed to set secure execution parameters");
-        if (pvrc == 0x108) {
+        if (pvrc == UV_RC_SSC_INVAL_HOSTKEY) {
             error_append_hint(errp, "Please check whether the image is "
                                     "correctly encrypted for this host\n");
         }
-- 
2.49.0


