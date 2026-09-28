Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCCDCA5FA9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHsy-0004s6-NG; Mon, 28 Sep 2026 16:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsw-0004rj-Hs; Mon, 28 Sep 2026 16:23:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsu-0001J6-Kg; Mon, 28 Sep 2026 16:23:38 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI5TaY4187765; Mon, 28 Sep 2026 20:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=s5gEfrprg0KGonsbQC9YfRywdfRPgAYb+6mYddaLh
 jM=; b=OGne5GjzFzpwtqQgU+7Mjf6XGp4cbhUyU9nWiS8J7b1ixuWsgWkSH6tyE
 jd9sQawgMVcLpq0Yw6WgBHz50YRiZEb4XJa4oAzGNqjX9sPAm/yMqXt//Gmynsqs
 ZxmCPt2Fl/s3ze+kXJZhaTsGiSWzAiwjmgL3ydtHCAvBIqoCFN2EcmsSfizTjdWS
 1mD5EgX3eTNkQt/5SsmBJ/TOP1VxLnhrKPiC0UVulnAHFvGI82X4WI19e1aB8hiV
 p1ofeA+R5xqmdb+Ngi7LANwZhxsWdaSEVNFq2vBRmB4T5iuWYCT2LfEagkAK+UgG
 rkyEmNPVxpmJ9L0cfQTNYYb5GnKPA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr3m0r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2Xv1483928; Mon, 28 Sep 2026 20:23:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw6xrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SKNRDt7602888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 20:23:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 768015804E;
 Mon, 28 Sep 2026 20:23:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44A0A5803F;
 Mon, 28 Sep 2026 20:23:26 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 20:23:26 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 0/3] s390x/pci: some translation fixes
Date: Mon, 28 Sep 2026 16:23:22 -0400
Message-ID: <20260928202325.309353-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX/3TF8wKrJou2
 fqcEHvnwUXYNk9W41Uxx4R/5CCXC13G2Zl0Lcd37IpawCUsGTGKQko0DhpNJC4SCNF37MTQ4ZlV
 hrcbbmzgKH7bc1nk2yTBMKcJ9xRJY/74g9SzEogporv5/K/HRBg8rXQBrutlKa9pZbvHzmCO+VU
 5OSLvoPuyfYPOKman0Lg6TR0h4UeDsc/MgWCY5m4nnCdrqoiHaJrDaqWjvU8LW0aRuPDMSOmbd9
 UZ/mojMIojTYccvQVxyBbjMZtun+oCjNgSfiYCNPlfJSsHIl+Xoaa2yjGVuj+vB1tvVYm1VRQEe
 RBs+lkNC26Ogua/Tb4ojNgN1Qq1uLbgmxefUY3IYfbr65XOd6YefMTf/HcgQlgu68FUUZYvQU3f
 juXceGkUmHTLaK/06pTgD8Q1W0/FHw014DEvkZstL9cMhJ4MLsGQWyav+E4mgSGfmdJOmvzpDdx
 jwFym/CNwQStW7WGyVA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abaccc1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=XbGThKhIVj4Z1Gef3_UA:9
X-Proofpoint-ORIG-GUID: Nj_yp2h6Fc4VGa8TvJ2IZDJ3FOpjU-Vu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfXw4h2G5dEDsX2
 rt3SGjMlrvGwY8y0+XD+vzLI5XzdlKlYq/5bpr7+G/fLSkSFMxrHRzHzTvAgKJxFy+lTdhid7kn
 eylomqXq/nzNmDia4RoZREf2zITxDPg=
X-Proofpoint-GUID: Nj_yp2h6Fc4VGa8TvJ2IZDJ3FOpjU-Vu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280080
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

While reviewing Konstantin's migration series, a few edge cases have
been identified in the existing code.  Let's tighten them up first.

Matthew Rosato (3):
  s390x/pci: Fix frame stepping in rpcit_service_call()
  s390x/pci: Use qemu_log_mask() for guest-triggered errors in
    reg_ioat()
  s390x/pci: Reject apertures beyond IOAT capacity in translation mode

 hw/s390x/s390-pci-inst.c        | 24 +++++++++++++++++++++---
 include/hw/s390x/s390-pci-bus.h |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.55.0


