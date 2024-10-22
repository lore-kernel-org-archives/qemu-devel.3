Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F52ED2C552
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FG4-0002kn-5u; Tue, 22 Oct 2024 09:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <szedani@linux.ibm.com>)
 id 1t3FFn-0002hX-Fv; Tue, 22 Oct 2024 09:48:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <szedani@linux.ibm.com>)
 id 1t3FFk-0001cJ-OV; Tue, 22 Oct 2024 09:48:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HAhA018174;
 Tue, 22 Oct 2024 13:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5ETLuzk+XuOdnICcZ4tq21VMRxXgcKaAgxt4XdZmf
 kA=; b=CMhlFZ+KSZyMpze3uyweFxMCo/gr1RYqCksyxLD7DU5NH1u1dcyoVx3Pb
 gZE1c1fPsfb5/HVnSTPy0dwf10VlJzj3JhS84nzt5iuOlx797v7uucMh4a9SO2V4
 HK/Vfq5FBlH+4usGDqJxJ2/P8i7OLYKU8NyXwIcJclmgam1ijde2Js+Wtxqw7hFN
 kC0msxxDyyADpD1h6LMGF4g+ZvuFjFxtn9K8jkcUuiw+72qQolW42KYK2qscLrYt
 dZe1EWWTSeGh+EkyIvrU5byENUkmJUNZxb361+gQIyRWHrxnwKXPCN8ZE6AY4lf5
 RlJnXJhVZ64obxD/MJY34UnU5BvNA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5gcpvuc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 13:48:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MCm6Qg026491;
 Tue, 22 Oct 2024 13:48:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cq3sbmn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 13:48:45 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49MDmfTV43974948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Oct 2024 13:48:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB85820040;
 Tue, 22 Oct 2024 13:48:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2628620043;
 Tue, 22 Oct 2024 13:48:40 +0000 (GMT)
Received: from li-68760b29-fd7c-4017-a34c-fc5cee828441.fritz.box (unknown
 [9.171.57.120]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Oct 2024 13:48:39 +0000 (GMT)
From: Dani Szebenyi <szedani@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: Dani Szebenyi <szedani@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tcg/ppc/tcg-target.c.inc: Fix tcg_out_rlw_rc
Date: Tue, 22 Oct 2024 15:34:39 +0200
Message-ID: <20241022133535.69351-2-szedani@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OU02dCmcexpgym-C4G3pdB579K3rS-o8
X-Proofpoint-ORIG-GUID: OU02dCmcexpgym-C4G3pdB579K3rS-o8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=593 clxscore=1011 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220087
Received-SPF: pass client-ip=148.163.156.1; envelope-from=szedani@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The previous message I sent was corrupted, sending again.

The TCG IR sequence:
mov_i32 tmp97,$0xc4240000                dead: 1  pref=0xffffffff
mov_i32 tmp98,$0x0                       pref=0xffffffff
rotr_i32 tmp97,tmp97,tmp98               dead: 1 2  pref=0xffffffff

was translated to `slwi	r15, r14, 0` instead of `slwi	r14, r14, 0` due to SH field overflow.

SH field is 5 bits, and tcg_out_rlw is called in some situations with `32-n`, when `n` is 0 it results in an overflow to RA field.

This commit prevents overflow of that field and adds debug assertions for the other fields

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Dani Szebenyi <szedani@linux.ibm.com>
---
 tcg/ppc/tcg-target.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 223f079524..9a11c26fd3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -911,7 +911,9 @@ static void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
 static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
                            int sh, int mb, int me, bool rc)
 {
-    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me) | rc);
+    tcg_debug_assert((mb & 0x1f) == mb);
+    tcg_debug_assert((me & 0x1f) == me);
+    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh & 0x1f) | MB(mb) | ME(me) | rc);
 }
 
 static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
-- 
2.47.0


