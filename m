Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9115C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJk-0007f7-4u; Wed, 16 Sep 2026 16:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJN-0007Zh-Ki; Wed, 16 Sep 2026 16:32:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJK-00030g-OU; Wed, 16 Sep 2026 16:32:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1Yjs045805; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NZa919vWQHK3YK5Ri
 dDPcIbHU1J72f0rAp1tG4Iv7Tk=; b=EeYmOn70vIej6loOEzufIXZu1yHUf6bgh
 ZzCpc0BneAOjXtsiEd0PrRNS35U5qO79B3Nr8lb1Idgcjxjcdyq4pdP275jypbm8
 qgmymKZ6JZmphUtHDnN3afJ6H1RDLttZfQAhe3Slqm7wtEBROJjso1pjHQOrPhn2
 0AxJOxR3QrFMedRrHmBONqjVzyQGgGVV88LrMOz4iwjkVAQUgu5qXx4xnSa7dnkC
 K7l4TTUPjZGkvPf30W4VXIEzJ3MUnJbWS1A5zLDzpXGoIjiWZt49smAwFrBTNbSN
 eehcI72NTUqvpHpMZAATPnEIW6DKLYnOfd5HsJ0ZddX0cxuas0D6Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv6enb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GJ2B7l1713033; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf0cqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWkSi30802310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B841A2004B;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9706120043;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 7D5EC16123B; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 3/9] virtio-ccw: Fix rc check in read configuration path
Date: Wed, 16 Sep 2026 22:32:35 +0200
Message-ID: <20260916203242.2509787-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX46CXC2sx45LY
 dYeSR5KjoPnztebGZU7gAjz+pvFgg5gkJVzl1/V7abwU+8+ldVdCrcM+fmxvqr6Wxjv3mjSnmq5
 7xRxsYM09J9ipoB8EWMp0zAKRzqZxnM=
X-Proofpoint-ORIG-GUID: v1vNHxSErJTHwPJH8VSwfoM-4Z4SrKZD
X-Proofpoint-GUID: v1vNHxSErJTHwPJH8VSwfoM-4Z4SrKZD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfXyOs8NAYaCB9l
 GfYqS7y6clzdIyCSdBpF8JDSrP5nxaa+0lneiik71JLHHVnFyTRl/XOlUiLURCCAQKKlsNdoref
 eO6BW150NfBuHfLJw3lKeA31XVCl+feGUXm4CCngvcTk6osQUqhxy8ujWqUWKg2CVC4QdUsnZu/
 qc6y9WIBoL3GGF3H+K2ysUcjcv0WGASy36g+HyYJ8QhqY8IWD2w+kYLjdSyQkqeeHPbPaQ18Et5
 0GBMJMEJzz7YbDZf+TC3SwIRo4pBX1D3Rd3gBku/Tr8IVTSHVo8MaTzUs39FuvDuT7a1Z4Bbqlg
 hLP2O5Dgd54XQBWzi77AS7Rzb7bSUtcvBhamqZeT4661ENBrNp76hxoXx1UQtpc0l2CT8F6zn0o
 9SU8IAwnY/fYVVAJQKlVBil0AJHaBwYNuRtqhqjrNV0zSrhfrb+CMpK0/EVKMZor7xchsiDDP4Z
 ZNiGb2KapX+bbHv3mbg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=uiMiztMkydEs4ieJCJEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160285
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

Both the read and write config paths use wrappers around cds->op_handler,
depending on the direction the I/O is flowing. But they expect opposite
values in the returned variable to indicate success.

Fix this by unifying those checks, where CCW_CMD_READ_CONF needs to
see !ret as success. The end result is some erroneous data in the
SCSW response data, but the overall success/failure is correct.

Cc: qemu-stable@nongnu.org
Fixes: d895d25ae2 ("s390x: css: report errors from ccw_dstream_read/write=
")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/virtio-ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d700db405b..4622c5d46d 100644
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


