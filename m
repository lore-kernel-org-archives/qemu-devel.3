Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D7DC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:44:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izU-0005TX-W6; Mon, 21 Sep 2026 14:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz4-0005Gg-Tg; Mon, 21 Sep 2026 14:43:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-000604-6x; Mon, 21 Sep 2026 14:43:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8Cgj1860549; Mon, 21 Sep 2026 18:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qyRP9gix4X7Wva7VD
 C0mSmWL3CSHNCxNFONlLaz7Krw=; b=UbjBzbQTPg9NxY8pF2+cq3oR7HjPifGbO
 yOxWRf7oG4Y/HvSSXF/6SSH8IVMYPmzEPrDuyFtV76GrHucu/urkhzjF3mLhVr+w
 sBu7MaRHhFb03qtQNdJbfUEUuo/G0ohuvE+MfSr1PXiPIotCAVSBi+ElQg92rTbF
 umhAYCzlg/QBWg91WHNBif10OEdJ/+nm29toomVSHkB8//+x+xnYtwc8Z9i6X+ib
 /Vd4CpNhvEpzk5FjW2UIwrEnUOuSEDs2ZlBFwr5OwS064EtWg5NvXZv2636VBtmw
 h4RupIc+pfcEVB9a42kX1wWtmVQkGtilOUZZqzGx/eI5jPT807vlA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2a739-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHZpq1451448; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gpjfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9vO50266540
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F93E2004D;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 827C020049;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 6C617161DBB; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 3/9] virtio-ccw: Fix rc check in read configuration path
Date: Mon, 21 Sep 2026 20:42:59 +0200
Message-ID: <20260921184305.3791311-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NQEpCc6QAlEiBi3FCiOKEYNg4aI8m5O-
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=uiMiztMkydEs4ieJCJEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX5dtVnunbPT7I
 3bGzTy3E1ikFhFoHH/3r12up+jBTBxHPZxwlw6q/FXjoTq1/d34ZIy3Llm93ngWWgibqogN1oP7
 NF51UQlFIuYNO4lytiHY2ItEXZwbHtFeO/DLenYNJXjKTyYac0EHiwvCsAbc8zmJjrQFvspv4DU
 tYplcSQM6Vcl0YahnhLZjf4S7XATBuZJ8bMkwxn3drKiQaXvVOxpkAR/zdXWtPCO8Yfmjx09qFR
 lGFcD3DNNNf7EGWPk5SfRTcTy00P+R85QuRarJj/VyU85jptZICN18qcxY7QKvT4Eogc3sF0oMw
 P6Hutf0sCvL3AvSxNI4lbHZ3BGejUhkjcCtGqan1to01anW5k9CDErdP+r5Dhekobeb/7gmoFIp
 75UHQftB6eF+edikYmLm1X2llEfX2Cb30xh+DZ74wHPvt2NDEDKujuS7FK34OnckMBHYMoPqYMK
 HXHyJka9ItaozW63Q6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX0wZ0420Ddcxh
 0dH6IJMJT2ztACKjw4cS4tOREklEG03uuJwP7mjoKEn3AlEc9XkLvoUVpL2iQ/LGpqyTIvmRqhQ
 suPSwGPdHzRZRRgfjjZ7zfeNrOo4mfs=
X-Proofpoint-GUID: NQEpCc6QAlEiBi3FCiOKEYNg4aI8m5O-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
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

Both the read and write config paths use wrappers around cds->op_handler,
depending on the direction the I/O is flowing. But they expect opposite
values in the returned variable to indicate success.

Fix this by unifying those checks, where CCW_CMD_READ_CONF needs to
see !ret as success. The end result is some erroneous data in the
SCSW response data, but the overall success/failure is correct.

Cc: qemu-stable@nongnu.org
Fixes: d895d25ae2 ("s390x: css: report errors from ccw_dstream_read/write=
")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index f46f936150..11441e56c1 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -475,7 +475,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         } else {
             virtio_bus_get_vdev_config(&dev->bus, vdev->config);
             ret =3D ccw_dstream_write_buf(&sch->cds, vdev->config, len);
-            if (ret) {
+            if (!ret) {
                 sch->curr_status.scsw.count =3D ccw.count - len;
             }
         }
--=20
2.53.0


