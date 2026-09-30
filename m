Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012C9CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAe-0008Jv-CX; Wed, 30 Sep 2026 11:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAa-0008FC-P9; Wed, 30 Sep 2026 11:24:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAZ-00020c-0U; Wed, 30 Sep 2026 11:24:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5OU03203135; Wed, 30 Sep 2026 15:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UoHKLP5oxJW4VSNl4
 +5J3lb2itYIVN7QAlA9+JgmmcA=; b=j508yB72eOxhFvgoDQ7FU6c/bi+a+7btL
 f2RfCeA+BEOPfZt/ZBav3AMHV8J7aNcxHWmSZLyVKZFPehpuA83feUTIWViHXEfc
 XNmGs29rEi4VT4CO7uR+RA0StA3oghihY6PTPhEUkpsWMUpK+8m6Ll+3aMt0kj2Z
 B2Af3U49ja/eLftoMp/bSwDb7rsGQ920jiCQBnuZGvFZ2GOLm3jOgUnmuUe+oAT5
 myg5/8iHFt0idaKXi/akl7McNXZHgZHomBNMGDlrgJplPdihn8LLa4iQxxhizTk4
 n29Hq864+VIzxiXN9fpDNpvvF19xPF7gJo2XSvjiX5YZSwbAgDHzg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5dyjy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE353j3576945; Wed, 30 Sep 2026 15:24:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23m9kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFNfli30147296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:23:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 486315805E;
 Wed, 30 Sep 2026 15:24:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C56335805A;
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:25 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PULL 08/23] s390x/css: Use datastream pointer for checking no-data
 CCWs
Date: Wed, 30 Sep 2026 11:24:05 -0400
Message-ID: <20260930152420.1956230-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX1q/lq8Hg+EtR
 Jx9VIKQq2TZeRLixcAyJltdHzOhbIK+JwdiHbD2lGBv9b/4dyi6jZ8MGLbKjyjhBHYy7OdGQFi1
 V5WJGdXg71tL5V3UFSzwIZFlNjydNSk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX39NZKCR9kR9v
 jjgmeF5AwZhYEoBOChLbUIiupliqnFyjV48m2bJCwUsoQkKnn9Ib6oVxM+fzIIYAP4n+Xqn2+e0
 yFbQ0rzIHhKIV2oi4/QpLkX2oQX2FGGb0muHCGA3OyeCho/q51GhoQ8dIyOccthsT99xf7bHc8g
 VBgZKW+xPM1J52hjQtqqX+iafVGLyLs7STsBGLESNNNDGzLHGDl4ccs/LzaizejdUaftxuv15qp
 Umd2yDWLL4PyWsX2Sh+UM3XE1fWbNcm22MZtM9wC9NmWCSSVxnp78EkMTLevtZ9/hFXNSpCIbYq
 yFDhSjHK73TjEHkD7WDbigFchtteiQIPlBwJTIJ3UZ0MyfYYD2WtAHpsUZbUXWf883mYasPjRj0
 69f4jmnn5E5QSo3LvADNT6lTrGLMpmbD2t68/hzpLdyuSLtHUIbyFilc+pmOrs3DYz6Qb+4Xc/5
 Hpf7wH7/2fQxiP2CZfw==
X-Proofpoint-GUID: XacdnyMT8lH6tv5Nj8Pl1_Zb0Uz5WrVP
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd29ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=8cHL7K5PRkdKNGgrHUUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: XacdnyMT8lH6tv5Nj8Pl1_Zb0Uz5WrVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The channel subsystem will reject channel programs that incorporate
256 CCWs without a data transfer, but the existing check to account
for this only does so for CCWs with a data address of zero. Other
valid CCWs that wouldn't transfer data are not accounted for.

Rather than re-inventing the wheel, use the output of the datastream
at the end of the entire CCW parsing tree to indicate whether data
was moved or not.

Cc: qemu-stable@nongnu.org
Fixes: e8601dd5d0 ("s390x/css: catch ccw sequence errors")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-9-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 9da9128d88..65341c68c3 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1016,13 +1016,6 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
 
     check_len = !((ccw.flags & CCW_FLAG_SLI) && !(ccw.flags & CCW_FLAG_DC));
 
-    if (!ccw.cda) {
-        if (sch->ccw_no_data_cnt == 255) {
-            return -EINVAL;
-        }
-        sch->ccw_no_data_cnt++;
-    }
-
     /* Look at the command. */
     ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
     switch (ccw.cmd_code) {
@@ -1103,6 +1096,20 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
     }
     sch->last_cmd = ccw;
     sch->last_cmd_valid = true;
+
+    /*
+     * A CCW that transfers no data is allowed, but ensure an upper limit
+     * is established to prevent long-running channel programs that don't
+     * move actual data.
+     */
+    if (ret == 0 && sch->cds.at_byte == 0) {
+        if (sch->ccw_no_data_cnt == 255) {
+            ret = -EINVAL;
+        } else {
+            sch->ccw_no_data_cnt++;
+        }
+    }
+
     if (ret == 0) {
         if (ccw.flags & CCW_FLAG_CC) {
             sch->channel_prog += 8;
-- 
2.55.0


