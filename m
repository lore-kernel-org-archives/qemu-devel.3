Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38317CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 06:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDdfO-0005P5-IW; Tue, 28 Oct 2025 02:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDdfG-0005Nl-K5
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:58:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDdfE-0007m6-Dn
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 02:58:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S58VA9015746;
 Tue, 28 Oct 2025 06:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=fgKnxY3+ROcW67MNh+burGNbiMtT4B4rTWDwLbIab
 B4=; b=ccishbw4NUN6k+KiLktLOnjO9jy2h7sYh2E0PymEkcyHXBMmU80yCINW7
 ztFGqz+5rhZ8dvDYnQNZD8jl7XhCeYJi6My6ymZd3ngBAn5++kZy/VjS8/R2E6db
 p8RmnlT7YqZcpr1PjeMrkzjeep0I8791U0GijwpU050aiOjNfk96oN6t+aWpRVaz
 ARSACl2fs1toLbW/9QZ+bTp07n2C3jrkiq5+EUbvKEQUaH/y+g7YOPPDe0v3yDuh
 1l2jnJn85giSXSXpauCYw7/Qbgj3bQ2dWumRe3xpsticIXxbDTMtLpNODSgmpecO
 kDMcSdCg3migIebsTa93NZs+kpzwQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p992ewu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 06:58:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S4knvi006852;
 Tue, 28 Oct 2025 06:58:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk1161a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 06:58:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59S6wTW331850758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Oct 2025 06:58:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 593C520043;
 Tue, 28 Oct 2025 06:58:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 974AA20040;
 Tue, 28 Oct 2025 06:58:27 +0000 (GMT)
Received: from shivang.com (unknown [9.39.28.67])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Oct 2025 06:58:27 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 shivangu@linux.ibm.com, sourabhjain@linux.ibm.com
Subject: [PATCH 1/2] hw/ppc: Fix missing return on allocation failure
Date: Tue, 28 Oct 2025 12:28:14 +0530
Message-ID: <20251028065815.84156-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=6900699a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=ebZVwKzJ5QttRmoVdyAA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: oZqcWuS4TeNFGRKiIm-qzeeDloR7UxKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX6mmmHmnCdJ0U
 PVeXTyLefZqVUeWpNV4576aWPpbQQAKJofjNQPmt+fLIFHhX9SsWsnxetVOR2pm/zpW9NH535/Y
 3JUIIfzk2SKvpEXPrjcZgYVNe5LzoSzhqXjHgmlllcsL13ueGNdR5P/AKPzwx53n3L1xvmasczv
 2T6faebdGnNH9e6oe0396uPmK2M6SHuqQdIBiq+Hx2snxoXt8JWgbkbxx4Ue4Dq2kfYvMd1axn2
 5n5pAl6t+VmP4A+PBspHCv4HIGAn3CqqVjwUiBO5hJANZ/H1C8ykGmvoQhw2k70/r72tcQY2jY+
 MknjehvvMuAoJ3O8WpTBav6TPuo8Et3DHpru25G29o5mHyVDtm+6ujhGHR9cAGCbpxRyDzyK1ek
 c3oOf3LhmsgjZoIhHEV/q1HFesgPkQ==
X-Proofpoint-ORIG-GUID: oZqcWuS4TeNFGRKiIm-qzeeDloR7UxKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Fixes coverity (CID 1642026)

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com/
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/spapr_fadump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_fadump.c b/hw/ppc/spapr_fadump.c
index fa3aeac94c..883a60cdcf 100644
--- a/hw/ppc/spapr_fadump.c
+++ b/hw/ppc/spapr_fadump.c
@@ -234,6 +234,7 @@ static bool do_preserve_region(FadumpSection *region)
         qemu_log_mask(LOG_GUEST_ERROR,
             "FADump: Failed allocating memory (size: %zu) for copying"
             " reserved memory regions\n", FADUMP_CHUNK_SIZE);
+        return false;
     }
 
     num_chunks = ceil((src_len * 1.0f) / FADUMP_CHUNK_SIZE);
-- 
2.51.0


