Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ACDC982EA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9IF2-0003VV-42; Wed, 23 Sep 2026 04:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x9IF0-0003V3-6h; Wed, 23 Sep 2026 04:22:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1x9IEy-0005Nj-MR; Wed, 23 Sep 2026 04:22:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N77iPD2760053; Wed, 23 Sep 2026 08:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=tYBTEgJ5T4risgcYcFRHQ8rikvgXn1Xzb3gm+FvAM
 Qs=; b=f8xw/KJiKF61Hu6Wbfdl+cSbCdxijFp89nYwgznvxX17HxbrlD/SbhApB
 aLfKNsqcrlDV7dhgfhaN+QsqkM5AcxWsPqEeq2tngUV209B3wAeiYTcUUJTRhbL+
 zr9i7CBfgGjBrYp5A/BLYB/jBdQe9OrrcdGuE8MY/qKrlL1EXdMnoj5rkbW8P9Xi
 pyYhHqaMIl0Xa/uaDoj6JZI7dlpsYhxSEJ2Je7/V8+aNqNGi3sKiuRbFwwqrkKRy
 +eJWD7wDeo5yOl94GVaMlXL7NC0JmaFCtxJk2EZanJ3oVzSw2vqgSsxpzHVlokXg
 ydyTCEs4sqoAjAFQ+fxWPOjlwHnlg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv9mn1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 08:22:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8IJhr2891889; Wed, 23 Sep 2026 08:22:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkfy8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 08:22:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68N8LuG443057622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 08:21:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16BF52004B;
 Wed, 23 Sep 2026 08:21:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E67D720040;
 Wed, 23 Sep 2026 08:21:55 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 08:21:55 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, philmd@oss.qualcomm.com, borntraeger@de.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, david@kernel.org,
 iii@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH] s390x: Extend comment about PV cpu load state
Date: Wed, 23 Sep 2026 08:20:59 +0000
Message-ID: <20260923082146.62803-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PwugtYXaj783u5E7C6WDejGoNYXBPFyi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX6CyYNSaEncAn
 zX9Y+CyvjmMKNMvbTvqRVLmfJNhPoPK1hkfeg/3Yj4VAp5HdVPGxxmI9zbrAN5M+HFip0xedoQT
 H6cC10IeGGZFSH42jClcPj5ZlT0RgmU=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab38c2a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=048ODbPAkeD3U4YIF1sA:9
X-Proofpoint-GUID: PwugtYXaj783u5E7C6WDejGoNYXBPFyi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMSBTYWx0ZWRfX79SKtXi/0i0L
 PGpr4GfJQiQ98CsTtvM1h2kQ4LRhhCv7p4OEBcKBm7udLPGPE33t33XdfXMF8ck6A2UO26Es1ow
 Gkj2+gTm/ZXaKi+/cDJpkhcjkDkL0PIVKCwi8aVc+morShwLq6jnnfTHkBqzcEKSIu9iLMogto4
 GGx1IVbrTKs8LchV1RGWcgLtEAWT+Zl5NvF41YDcfUtg0bObcPQCV2D9pbyo+EvPYDQYMMs14LG
 WFfHnCqhxaZjkbZJPmXg9oJ1wuRXKlhbRJ4nAPGeoDTZLVSEUY9XWFM/2cgiSOF6dEeAfsv57dW
 yq64NPL8mY0cruqz0ttihWTDeHzh6rbcXhASUPbrOg7TPmQRSRwr2xQVhPwE1B8m5mWSkfeFaKb
 PSZlXRDWKk4NVm+1Rz46gd6FRQ/F6oeZ90p3uY+KqRVdFubSFiiexOqc23HJB8pGpqLW+NgC3DX
 Vyn1RejpE2S/pltKPDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230031
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
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

When implementing PV in KVM we chose to add the cpu load state to the
mp state solely to have a way to keep the UV happy. The UV requires us
to set that state before running the boot cpu since entering that
state sets the initial PSW.

Since entering that state in KVM only sets off the UV call which
causes the initial PSW load and does not set the KVM tracking to
operating, we need a second set mp state to reach operating state.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/cpu-system.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index cc9685221a..5bd8b8d837 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -73,8 +73,12 @@ static void s390_cpu_load_normal(CPUState *s)
         cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
     } else {
         /*
-         * Firmware requires us to set the load state before we set
-         * the cpu to operating on protected guests.
+         * Firmware/UV requires us to set the load state before we run
+         * the cpu on (re)boots. The UV load includes operating so the
+         * second set state isn't really needed but KVM doesn't update
+         * its internal state to operating on load. So we have to set
+         * operating again. The UV doesn't mind that since it's
+         * effectively a NOP.
          */
         s390_cpu_set_state(S390_CPU_STATE_LOAD, cpu);
     }
-- 
2.53.0


