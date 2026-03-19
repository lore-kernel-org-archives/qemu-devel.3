Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA40107528B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w39zm-0004G4-UK; Thu, 19 Mar 2026 05:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1w39zk-0004FR-5C; Thu, 19 Mar 2026 05:48:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ggala@linux.ibm.com>)
 id 1w39ze-0000qD-Jb; Thu, 19 Mar 2026 05:48:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J01Mfl1374065; Thu, 19 Mar 2026 09:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Rluje6chA2npxbemdnviGNEqdugyLj0SszUkomNuZ
 wc=; b=qB973cqfPzY0Q69XJOBr8Cl+9a1hPCYzreKuDzyKfAC3vcfk/uyLrLa4q
 zqBrvIuPMAWzmESJ+Ok0Eool8eq8gKVjDNZUeSjGvmvabd1P2/A99MZ5pAA1uiSv
 Y46CY3agO/gq2zskxsqGEpHnKNxtfmm93DFD90uJSNnTzH/Y03d8SFlWSi5o2wWY
 tt3WMGAJTgWGQygvoz1Q+hd1ul9+0p0wwyAXc8LYtEkXL08xlfVauH/cughmSKd/
 vQiGUD9/94KQ0k+mEysM45rkesbf/StZj+UZNAxNSBqEbSUfAqYE4ZZNe9cJx2jW
 yphL437ASQz+LNbW32FPh12E4vzsQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64xc6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 09:48:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J9eb8j032343;
 Thu, 19 Mar 2026 09:48:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7k1qrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 09:48:38 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62J9mbwP27919002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2026 09:48:37 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6741058055;
 Thu, 19 Mar 2026 09:48:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D79758043;
 Thu, 19 Mar 2026 09:48:36 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2026 09:48:36 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: S390 CPU topology: Change maintainer
Date: Thu, 19 Mar 2026 10:48:35 +0100
Message-ID: <20260319094835.80329-1-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XEsXMGvxGgheRZPQq5TBpwbj5de8M8ZV
X-Proofpoint-GUID: XEsXMGvxGgheRZPQq5TBpwbj5de8M8ZV
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bbc677 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=SfxrH7SkzMIKDkb5ygcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NyBTYWx0ZWRfX9C5TozPpL4IJ
 toMq77lZ3xx6p6XS1CMODhwxCIO/42920oDQHFQfLiYdKDhPGBo8ebkW+mhhp8rbJ6qt/lW+nzJ
 qe/Sl0oBBHnfQ1Sy23In/RjKR/rLztXcnrVyKNH4nIpCxrIGVCJWhfVmWCsnXqM6gN/65ktT2qH
 KN7G8m/nrHFTXwg/QMeTWuVTxUrbogjNJqSWxnmxWmY/e0MLQSIYL2GFxrphlbrVhg+rxj93NZI
 PFoqb0k1X4/lS698CdFJNjgA4/KOSCWacvdi3lIHqqBhRL5MpkDdUgjQ8byab5eyaH/hftjvSDn
 2WVX8MZEZeU0G6F2n+0Xn5HUbpHPLVkt1X19Qv7itnGcYcEDfnsZ1GYJbGo2kLM544B5hdeHTCO
 ga0ptQBaH6aMj2yyF7mkP+fv6FkKa8bQgL9LAHxGPmddAVyIBQuP2TGlunhSF1SPLxqyEedVVVe
 rY+y1CQjN6veBYhW5GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ggala@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace Nina with me as the maintainer for s390 CPU topology.

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f2759138..f977a41757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1916,7 +1916,7 @@ F: hw/s390x/sclp*.c
 L: qemu-s390x@nongnu.org
 
 S390 CPU topology
-M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
+M: Gautam Gala <ggala@linux.ibm.com>
 S: Supported
 F: include/hw/s390x/cpu-topology.h
 F: hw/s390x/cpu-topology.c
-- 
2.47.3


