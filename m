Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BABC98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vJ-00007U-Bd; Tue, 22 Sep 2026 16:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tt-00081k-Jy; Tue, 22 Sep 2026 16:15:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tr-0007fs-Ao; Tue, 22 Sep 2026 16:15:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7Nqm3447412; Tue, 22 Sep 2026 20:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=rSD/N+0aF/+pV1sSz
 ti4NYglqvruBGeICmLxp/1KjrQ=; b=RCi3+u3apv6yXtSFAlz5zkKOxWJ4kxpj4
 2vWxZBNvD8r52nsE/gMn4RkoXxMGTG0mW0EFxvFod7NqYFqRyAO0r24LMdGzdwLI
 6AV198nWKMojWcAHNZY/KEiv201PB1x2QY5iLf8NXLdrSJoAEN8bB52D1VIqj8pb
 wPuVkbF9nd9RL+T7q895SBJgLBdm8HG3XJcPydEOpJoC22xXlTPM4mV3EnTsk6Mm
 +VWqsdyygmQIJlAzLuOCy6SROWJdr00TltK37fnokSe8Gr0zY+kLGjeJcHd/fW6y
 HZdUcuq/qvw9iGUsLs4fvkllJdqPXGeVucQ6lNl6xOaJPC8P8/yVQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qsh6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHiHo3198696; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjuba3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFR6h47776108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0A2A20063;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F69C2004F;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 6EAD0161633; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 8/9] s390x/css: Use datastream pointer for checking no-data
 CCWs
Date: Tue, 22 Sep 2026 22:15:24 +0200
Message-ID: <20260922201526.2383047-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ieVtyfM_BMBOnWqHfrqvh8pgcpkWyFPk
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=8cHL7K5PRkdKNGgrHUUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX5b2STzotAgd/
 sTfwYFytV3uf8dk8OA2tOGHnM2mPUatSzMPjHt5VHoqU4FedYR1l3u0q0xfwNkm/wdu9C5xDKiE
 JxrB4dHNMMHkhZMpuVnTVsB6M1b5YSk=
X-Proofpoint-GUID: ieVtyfM_BMBOnWqHfrqvh8pgcpkWyFPk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX9ZtBXD43jWQj
 2gzlFomZL/GBX0nQ84BHyfwghwC1WZCssSGtnDYeEWl2g9zwYAJg8D4At+AnilrDhSDsz4NJefv
 pIO9IAstzcJ0keeXlr/2ne8OdofSQsPW4kc6P0C59TulePUOPGAmdxVUriMvrYOZT8B8s5HJEfj
 JjmgHTpvPDAJxysA+PlsDmu0LoSbN/Q23qNSQPhQVKJ9pCi+zHU6J/1doPZ2MqGeUCBgzE4ftu1
 6QZKbyGwQJUAR9OQPjD7+iIHTvguaO9zGqAAY6bC9cVlfDD5psejsZ/jY84ZYX+pJDn8m0+DAwK
 VMj/6aVfNyR1uijmdLLbMkVLTkKmqa4TqIaefGqCAZJ2Jxa2uHcanKLuG3apsAT6tpqYKrwa+wQ
 pegujA/hM7Uv+JBMeNKVGUpbuED9eMIiDyaB/RNFo8qDLGxbMgW2X5JJRWWLm/JcQE/81zD6MFi
 H/DN0wcFVZWdhzIl+2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220293
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
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/css.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 9da9128d88..65341c68c3 100644
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
@@ -1103,6 +1096,20 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr=
 ccw_addr,
     }
     sch->last_cmd =3D ccw;
     sch->last_cmd_valid =3D true;
+
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
     if (ret =3D=3D 0) {
         if (ccw.flags & CCW_FLAG_CC) {
             sch->channel_prog +=3D 8;
--=20
2.53.0


