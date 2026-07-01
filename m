Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B12C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1tr-0005ff-44; Wed, 01 Jul 2026 16:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tm-0005LP-6k; Wed, 01 Jul 2026 16:51:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1tk-0004WC-JV; Wed, 01 Jul 2026 16:51:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GnQAl1296349; Wed, 1 Jul 2026 20:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JbxLzSL2g7Atg+2SD
 csJiJbzAuuwSlleV+K3OwKPTCw=; b=HM2n2gHkT8+82qJh9LvfSiQrFF5ntw9bC
 YG2i8Ruo80uZqiUcnPeBoVsgFZEgKYzCdw4gmdq3gM7tMPmblfwiYAQHITPFfrYk
 Oi+sD+yfwdiAavE5k/5g1VlpL583UYxhMgV2pJGuCd0x/9oo07dlnIFfCQsEe7xU
 gGqOpQGWG03pWb2cfFQrhFP9JR0PD1/zeQsjJ7f7UYzYtyjkCEHpNI92jzxA2mOx
 uG/29LyRaNWO7EhGbGdpk90QgnrYwdWCkko1g+V82BVAnkhJvqMzrFyav9RZmQHm
 yEEhIfEXH2ie+4W8h2wpMoywSWbP6Mqc5iw3yxWNGJjYPVvf+/BcQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjxafd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:51:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661KnbSP006913;
 Wed, 1 Jul 2026 20:51:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhh0w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:51:04 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661Kp3QW33030804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:51:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80AC25804E;
 Wed,  1 Jul 2026 20:51:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6DCB5803F;
 Wed,  1 Jul 2026 20:51:00 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:51:00 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 32/35] s390x/ipl: re-apply secure boot flags on DIAG 308
 reboot
Date: Wed,  1 Jul 2026 16:49:18 -0400
Message-ID: <20260701204922.1320349-33-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX+J153HIX0NRA
 KhDs/Q8k5DIBHJT179BHzZ12kT7nJHVClqRIXTwt3u39zaiNpQNLEkgH7J8HdzpJCqdQq7SKGMF
 x/7n/q9Cfo3Y7mipQWycQ7o9kAMhFBGDnRa0a5dLWm/jU/wKxXFL3NxIEpfmtjc9UwF8rK+gy5k
 ToTMWy6AUmz1FIDbw0qGidmSJ3VNjYZw/v/CF/E9jgv2Bxx97yuZ3LYjZJ6YF0fCKJ+32BsPUto
 zNjkAG6yHCFvfhl0KkV9XgHtkKD4FehNgZNjMmm/cArieKW5HXB5B92Qei2RA3O4Vfq7zrKgz7i
 JrKTI7kZMZe7zoWaLBKUNuvMcx/fMBYCYFBH7Ds7u/Z5E6GQM1+7Sv9ALvH4IeCjQjyPLkGJOn5
 iouSCZZZTggO9wlb43ZtJ7SCxstVuwN5fHclPNT1BccBusdBCAbcZXpst30akihk3BAvz93vDxb
 UX+Ut8yt1OVIsHsxTuA==
X-Proofpoint-GUID: T_7Wxynw_3QI7AFqRZEQKyrJ3UxebIXX
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a457db9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GJyF48k09KdBxdLS7nQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX6duhhcGt1RSo
 dFjIGzBRXNOFlY1UaIVMOEq6vHUlgpbCy07RXlaDEKijWLo1q9d5efcrUrdZ+Kp7pgCMmEKGY/+
 BvHB5rzg3WRZKnDzodJAjsiQFzbqIzU=
X-Proofpoint-ORIG-GUID: T_7Wxynw_3QI7AFqRZEQKyrJ3UxebIXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

The Linux kernel does not preserve hdr_flags in the IPLB across a
reboot, causing secure IPL flags to be lost on re-IPL.

Set secure IPL flasg from s390_ipl_update_diag308() to restore the
flags from the current machine configuration.  Device validation is
skipped here as it was already enforced during initial boot.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index f4e01b6918..f970b34126 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -737,6 +737,14 @@ void s390_ipl_update_diag308(IplParameterBlock *iplb)
     } else {
         ipl->iplb = *iplb;
         ipl->iplb_valid = true;
+
+        /*
+         * The kernel does not preserve secure boot flags across a reboot.
+         * Re-apply them here based on the current machine configuration.
+         */
+        s390_set_secure_boot_flags(&ipl->iplb,
+                                   s390_secure_boot_enabled(),
+                                   s390_has_certificate());
     }
 
     update_machine_ipl_properties(iplb);
-- 
2.54.0


