Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6AFE95396
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 12:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbiX-000359-Nb; Wed, 04 Feb 2026 07:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vnbiT-0002xB-TF; Wed, 04 Feb 2026 07:10:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1vnbiS-0006RL-4A; Wed, 04 Feb 2026 07:10:41 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 614AG4XY027849;
 Wed, 4 Feb 2026 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HOJ7ow0oEvswzLEZy
 G8gZwLQJQ1ov+TKF9192Y24jMU=; b=QVL3J7U8KRIxpfnKRnBO/We5HqEXoae32
 ndv4uNlZ0fb7y6MpPtJzhTrMRalO7QrRnS7O9j9vL24gdDoqODGPsM6/GbrbiMmY
 mPijyQG9daXTVw7aJx1hm97YTnsOuTReTKJR6mDjJNDb8BEGHw6vzFrrUya+v3gC
 fDQ0jtMKbPHQx6UtUpUVMMaSr1VmgAEOqXV/3osJgyyGDkGXF7NbqYI3yjbdJtae
 ra1DcNgZHbbStU3V8uDYRVCSIFZsYKEqHlxp0xF/+4iCsr17u7jjmskwlvF6xHzv
 fHkCrKJ7Ef9XZJFoaDZ0TnfKa1FvS3jNPFP7GrHlYhZaR/0WMbMwA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cw7469-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 12:10:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6148in0E006033;
 Wed, 4 Feb 2026 12:10:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1x9jcv7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 12:10:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 614CAThp46596474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Feb 2026 12:10:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C09CA20043;
 Wed,  4 Feb 2026 12:10:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C34520040;
 Wed,  4 Feb 2026 12:10:29 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.140.180])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Feb 2026 12:10:29 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 3/5] fpu: Restrict parts_round_to_int_normal to target
 precision
Date: Wed,  4 Feb 2026 13:07:46 +0100
Message-ID: <20260204121026.645382-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204121026.645382-1-iii@linux.ibm.com>
References: <20260204121026.645382-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MCBTYWx0ZWRfX4Kk81EPq6ptk
 aTYD0u98puCPxDPIkuRaGWN2pRT+HdDmimWspQSrVAJKsUt0pKIu1mh/eX+xukQetuSkCxBGDxf
 s+3VhrOWdd9ueHE8YYMb43PFU8pLmZrgIFa9k29xRCWfCNrdX7OJgISJngt/ZIcL5Cq9xcirDlv
 tFuyZAxjcIsss+39SLYu02huHzBi6+pAucHIB7r5SooY6LqEAi5otLjT9I5RgZxcANuna/eHabx
 ahUbTbiD78dl6osJuZxjf/O4kTQjtIFhEdrrI1wwQFiTc7l+P6UI8yBgC5bEbvOTnIf6vOrWz5c
 KEKrlPUm5//ANqQCOXBr+oTf85Jf8PX6JA8Sk7iBJDOuugC5S9NjsTTnPLXNWOhgiTKOszA/gyy
 nz/d8M9gMRVbeJ5bN8rENHeJpbrcMNpnsBmAd1QzNX0GV3jlOFk6XUqzGy5MBTfHlbipB83BanE
 QXWp6ec2D33IHe3pvvw==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=69833738 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=Y7_wFDRbBJZQL2pu5q4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: anOE4F1ScDoaJJyA7_KlgIw0X-1NRJdj
X-Proofpoint-GUID: anOE4F1ScDoaJJyA7_KlgIw0X-1NRJdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602040090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently parts_round_to_int_normal() assumes that its input has just
been unpacked and therefore doesn't expect non-zero fraction bits past
target precision.

The upcoming DIVIDE TO INTEGER use cases needs it to support
calculations on intermediate values that utilize all fraction bits,
while at the same time restricting the result's precision to frac_size.

Delete the "All integral" check, because even though really large
values are always integer, their low fraction bits still need to be
truncated. For the same reason, make sure rnd_mask covers at least
fraction bits past target precision.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 fpu/softfloat-parts.c.inc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5e0438fc0b7..93ed59626e5 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1118,11 +1118,6 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         return true;
     }
 
-    if (a->exp >= frac_size) {
-        /* All integral */
-        return false;
-    }
-
     if (N > 64 && a->exp < N - 64) {
         /*
          * Rounding is not in the low word -- shift lsb to bit 2,
@@ -1133,7 +1128,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
         frac_lsb = 1 << 2;
     } else {
         shift_adj = 0;
-        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> (a->exp & 63);
+        frac_lsb = DECOMPOSED_IMPLICIT_BIT >> MIN(a->exp, frac_size);
     }
 
     frac_lsbm1 = frac_lsb >> 1;
-- 
2.52.0


