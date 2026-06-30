Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D06C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVoM-0002bU-Pa; Tue, 30 Jun 2026 06:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weVoL-0002at-1N; Tue, 30 Jun 2026 06:35:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weVoJ-0001zi-Eu; Tue, 30 Jun 2026 06:35:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U9muX01843018; Tue, 30 Jun 2026 10:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xC16TKR3EaGzAaWHs
 p6lmafNtXWvPDGlysq0rCnwMpY=; b=bvKLNRZxZ6OIAG2sg1il6OYajzvuWEBDi
 L9PVU7tJM38wvH/o0cbZiGxWKri8zHjLbY9aLPcxQShkKOgWGVtl5ekjOVEWx355
 /Q/1W5u1UqScHY10XXmSSH89pSqUG76sXsYKFmtA3fuXDryDuimKqiA/l6IiMEXp
 UfxZTjFy8zmu1N0+4ytbWdaQuXIlLVyJdd2+2owJ1Usbj96B16b0c3KeQLTyh6oV
 t7Lf0pYoF7aOmjYo9y7ccoqBA/ds7Ohhv3dqdQHFqkhkkBSfnUSJKoFpgP6JpUgV
 36B43Y8Y9L+ZqI9zHcer0T7OCH7MF3/nUAKYYNdypFhgQ5m+7cESQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfx4ng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:35:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UAYa1R024031;
 Tue, 30 Jun 2026 10:35:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruq9vjq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 10:35:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UAZGjm30474926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 10:35:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 517A62004B;
 Tue, 30 Jun 2026 10:35:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5F0F20040;
 Tue, 30 Jun 2026 10:35:13 +0000 (GMT)
Received: from shivang.bl1-in.ibm.com (unknown [9.123.12.247])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 10:35:13 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v3 1/2] ppc/pnv: avoid regenerating DTB if external DTB is
 present
Date: Tue, 30 Jun 2026 16:05:07 +0530
Message-ID: <20260630103508.254000-2-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630103508.254000-1-shivangu@linux.ibm.com>
References: <20260630103508.254000-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a439be9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6hYU8IMl6WZeLP_gbRQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX2jBrKt54n6g4
 s0E0eqElZwgUAg0e7b0ToyCSjpyDAd3+Y0cSoEs4NTyZ6cCveQbr5hALUahTZciTHEF5F2bDZi0
 7Z5jXL3K+KWNSKgASGMkc1LIjY85GKo=
X-Proofpoint-GUID: JZVpy9shFBdTNl9rKcNC_Y1zfhZfVC4V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5MyBTYWx0ZWRfX14iwS0Qt8GKE
 ynTatpqURA9goLdVVISkHoVbO9XVAvKtLhWNWCwtgMrZPxA8HVZJMVVPQ5Q0udq5dsLyUAxtmlz
 vHK3UM5AnhkHBnlFncwL0gLba9kDUBO8qMeDT8scImvdw8qZkWLsqEZOW26uAh/i+X3GlfQCZn6
 zA52CWzn8rxe5Q7Up0RCo35+Ezs1hwKOrithUkeYbsElqeescMOrsEZXIL17gIfw8fzjbZzfMud
 Zh+IFRqj0+UXvQSzDI+aqZP9GD5s0gOlUgJdGT4UsAPNAvOEaryrnBEqw9kRt+iOT7PSReowslS
 G7TR4CUUt/W1ioBZnHOMDbKG57zXn+iC+OGQXxsHwj8bVN5dhN3/X8RduCQ6ACWyHfV/w0FnbhK
 T5epSPqEPU5H/bTTpsMzke2gIoz/RqxykUUd8ybK2IHTVDSubMdMXBXSBWJgBi67z7A8geSUPYf
 sbjErKqwl7Iwh3OPRmg==
X-Proofpoint-ORIG-GUID: QBtHkLY_vaCjSncPNnHsZXGQ2ahslbvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300093
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Currently externally provided dtb is overwritten in `pnv_reset`.
Fix this by only creating dtb if not provided from `-dtb`.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/pnv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 62812f22f8..afb6019b10 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -803,9 +803,13 @@ static void pnv_reset(MachineState *machine, ResetType type)
         mpipl_write_succeeded = do_mpipl_write(pnv);
     }
 
-    /* Regenerate device tree */
-    fdt = pnv_dt_create(machine);
-    _FDT((fdt_pack(fdt)));
+    /* Only create new dt if not provided in -dtb */
+    if (!machine->dtb) {
+        fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(fdt)));
+    } else {
+        fdt = machine->fdt;
+    }
 
     /*
      * If it's a MPIPL boot, add the "mpipl-boot" property, and reset the
-- 
2.54.0


