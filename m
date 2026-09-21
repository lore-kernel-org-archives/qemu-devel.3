Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60063C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izP-0005RA-LV; Mon, 21 Sep 2026 14:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz7-0005HY-62; Mon, 21 Sep 2026 14:43:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-0005zg-AY; Mon, 21 Sep 2026 14:43:23 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8ZMo703687; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gkFHQs6f6BI16EPtg
 VpUEdzh3zzbxQU7m60Xqv88VL8=; b=GdvamwXKpjmL/hlXMbfFgc7MTbce3HMtN
 5xipvABdrdDVgcNJsGhpk3vGPROMpyU1dlybELA66+P4Zif8fQ6iSIYAVtSFU1Pf
 BjbRObkgVuMWQkXg9vctjqDBDcG7KOcpy0I/pjaDOQ92QuOSotV+2VN4uuwQcmvm
 zuBGJiz+U90Bs2PnQu/wHvQnTmXm54yM6dLTTf9qVDcrrIbyMCmbocVFTHausOc1
 Iw/4J72E6ymy9vPGKjYSuNH20BglodPhXdPkM8PgEBzjkP7H/OLxnwjoZTu1FCcM
 WaMz5NqupgxsmmebOcp6T8mqt2A5VlUF2BeebeYTCeyS2xmstV/Og==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq9ypp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHk5B167161; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk96ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9Xl50266542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAE1920049;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD9562004E;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 7654D162436; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 8/9] s390x/css: Use datastream pointer for checking no-data
 CCWs
Date: Mon, 21 Sep 2026 20:43:04 +0200
Message-ID: <20260921184305.3791311-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=8cHL7K5PRkdKNGgrHUUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX3U4Pb86MSScx
 Kis3zWn4fS8dsB3aCEw7APz9opFDvQlERujm73AT87UWO3FAL+FWXO4KCU1LNE0VIlHQA1FZooS
 VSiN2J3gYl/p7EpUAaveLr21cnMZekZVCRjL5JNrjhfPcxy/n5MCfODfd/atXOcJxi+hvDAeOFc
 6t3vo+R50vMFilA8+GSb0WqzU2ylWiKbReojQOwi5jHuaGmZe/wADupgXoQeN0G15WJ/Or8ThHG
 q+nllOO2wfaofkv5+PlmdxiZoAm8mDPsxZf4xzptzq7C22MG2+gC3hWW8AgVcYm04dISnq1JqO2
 0N/TqfOuTm1JNyQ2TsmZPWFavztcRjYBGSc6qpqXbULqn4QpuTtEHo03OFupSvC6ZcBqB3J8EfY
 9+j6BCvFy1LjAMAy7Lh1QGCZ3WzxWu56i9To1kvXXGjbEq6u5p1ENH+xfLs9oHUyeLcJ1gwB2Ac
 6sPgicPOpcNxbxPwLkQ==
X-Proofpoint-ORIG-GUID: YSAGFj11t21mmM_6Gas0B3CncbAgqeL_
X-Proofpoint-GUID: YSAGFj11t21mmM_6Gas0B3CncbAgqeL_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX7n0vcXgQwidD
 o5vyVuHVWbAmZHwbowpvEI6IBeX9PLrYb5a7/6eWwE0NkFKB31J2P7bhg/ZFPO1/PDjN8qcFoq0
 Hbl+sj3PhjB8KA189oMlOjdjMFGOOc4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

The channel subsystem will reject channel programs that incorporate
256 CCWs without a data transfer, but the existing check to account
for this only does so for CCWs with a data address of zero. Other
valid CCWs that wouldn't transfer data are not accounted for.

Rather than re-inventing the wheel, use the output of the datastream
at the end of the entire CCW parsing tree to indicate whether data
was moved or not.

Cc: qemu-stable@nongnu.org
Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 9da9128d88..10bebdcb1a 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1016,13 +1016,6 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr=
 ccw_addr,
=20
     check_len =3D !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG=
_DC));
=20
-    if (!ccw.cda) {
-        if (sch->ccw_no_data_cnt =3D=3D 255) {
-            return -EINVAL;
-        }
-        sch->ccw_no_data_cnt++;
-    }
-
     /* Look at the command. */
     ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
     switch (ccw.cmd_code) {
@@ -1110,6 +1103,19 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr=
 ccw_addr,
         }
     }
=20
+    /*
+     * A CCW that transfers no data is allowed, but ensure an upper limi=
t
+     * is established to prevent long-running channel programs that don'=
t
+     * move actual data.
+     */
+    if (ret =3D=3D 0 && sch->cds.at_byte =3D=3D 0) {
+        if (sch->ccw_no_data_cnt =3D=3D 255) {
+            ret =3D -EINVAL;
+        } else {
+            sch->ccw_no_data_cnt++;
+        }
+    }
+
     return ret;
 }
=20
--=20
2.53.0


