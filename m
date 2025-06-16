Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A437DC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6WS-00064g-BC; Mon, 16 Jun 2025 05:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uR6Vq-0005qf-Q8; Mon, 16 Jun 2025 05:52:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uR6Vo-0002Qc-Hb; Mon, 16 Jun 2025 05:52:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G1L3hk024164;
 Mon, 16 Jun 2025 09:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=2qkq6whAaxXj/jPcEIOqeF0LtM4eG6ksZGow2PTSV
 vg=; b=tfVB+Vsr6VM6pyDLpQgj/ZM0eWaPrGFdW/zwbSK0pdZyUs/BgzwIVQqIH
 brcNwRr1gzUdY4WdPQSMhh3QVLpCP6hNoA7P8Q23JFGD0qTSk/vl8wnh4Ud+IivF
 qcOa8EeZy2C2YfUi5b6zkAmh7a4qnrEQ8NgIj9p4qxZZFKeDj14xKRbWVEwxPEoM
 0ujhFaBRAsVI9D9ygDaABKHPpx9dZGM6DtOVqzV08/bU3SgraC6XcUhuFbYIklSR
 VCxF1G20ppYZPfn8ieyyvNvhOc5LkKgViUoVecDXANiNWM/Cdm9FmKuhs7TiZjL3
 ZL9b3cTdPTvdcCRqZMLZJyYQu2hCg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn10sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 09:52:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55G9qFjv018260;
 Mon, 16 Jun 2025 09:52:15 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn10sw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 09:52:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7XTYM010817;
 Mon, 16 Jun 2025 09:52:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 479kdt5qvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 09:52:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55G9qDGE31195832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 09:52:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C0DA2004B;
 Mon, 16 Jun 2025 09:52:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BDD620043;
 Mon, 16 Jun 2025 09:52:12 +0000 (GMT)
Received: from ltcblue8v9-lp2.aus.stglabs.ibm.com (unknown [9.40.192.95])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Jun 2025 09:52:12 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH] ppc/spapr: remove dead logic for non-existent machine type
Date: Mon, 16 Jun 2025 05:52:08 -0400
Message-ID: <20250616095208.241834-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2MCBTYWx0ZWRfXz6AqugU3zR6j
 /qkiSyEz3iawgJr0BfoUddu4UQt1BzaEq9+m4QKPu6xvqPZkkIkTDu40B3+hKAWWm3XJZcOyk8X
 cen6Y3OlHhgdIrxmI6s2KdseFDenjNWXWfW8U1rtrG/5FSfRRPyi3WI2o6cdxe6aMkDvF5hjRZ0
 ff+gg4+TIjqrU7WXl0UYFMnb3kcMS/+Pux+BOH7koGP0pn5tUkCPZluOuOTd/unABiThaoQ0GVr
 07gfqXbpB24Kb3fOjnoBI/7vjNztcZnvPE3Pa+FRFpU7tZIzfI41M0nFjoOJ2TbpfB1FbgoTbgE
 xLqIYufTZ4fnmd28//LXNc4oMYK47ps8tIKA9pm+OxaSPZtzgB7irVBzT4/63Y8AYSw43gDcNcq
 b3+1cBWomYAkIihGhVqkRsDw96DwPjFRdE4sEH9unvJIqL4DXDCD1LMMl1xmgRfagz5U/EsE
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=684fe950 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8 a=LKRhd8M__PCHzWEdhwkA:9
X-Proofpoint-ORIG-GUID: h4Tf03T96SgNU7m6WXrpLD7vMHTjmCS_
X-Proofpoint-GUID: uEXtdg01mDpstt8Bw2TlbPGrXGYo2cf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=861 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

This logic was kept here to support pseries-2.12 and older machine type
to enable them to calculate supported page size. Since the support for
such older machine types is already removed, this becomes dead code and
hence removed.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_caps.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index d643591e25..0d62c11195 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -901,19 +901,6 @@ static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
         caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     }
 
-    /* This is for pseries-2.12 and older */
-    if (smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] == 0) {
-        uint8_t mps;
-
-        if (kvmppc_hpt_needs_host_contiguous_pages()) {
-            mps = ctz64(qemu_minrampagesize());
-        } else {
-            mps = 34; /* allow everything up to 16GiB, i.e. everything */
-        }
-
-        caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = mps;
-    }
-
     return caps;
 }
 
-- 
2.49.0


