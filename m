Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2283FCA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEwDi-0000wD-Vf; Thu, 08 Oct 2026 18:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xEwCV-0000s3-GP; Thu, 08 Oct 2026 18:03:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xEwCT-0006CF-Qm; Thu, 08 Oct 2026 18:02:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5Oq3636173; Thu, 8 Oct 2026 22:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=lu/nMzN8zlMetl7tvY6DCtneAx9q9oHyOnTJebEJI
 48=; b=ScBYmHOm4OYgKlS9ESIW8y7zaIag/W0klWeSOWrTv+YCSU/WSwtOj8pFP
 QeqhZ9cspl/S7mjGUhPIEgoxZkQvA0o/WxmFrAxCzzfQeqmD+cQhRCJ+/mdmvcXa
 nVBlZne6kj0fSeC8yvJEaFMo1Y4lST+8gAhF+bbzd1ZIKYvUqxx+3rhQ0dWQ7P2m
 1QjyJRfdQIqIcY9hjDBTgYN0UY7YiEhCfbNsIgq5xoU5+srFoa9CIyUIsbH+sXNF
 T+v/Vl5NTebkgDacEm3w1IlZfk0p48c1eDolr27t82zKFcrk/AGDY0PuqSK8L9CU
 QCcCI49sb3DeZJeYsYSSp5dZ1dg3A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw6vmy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 22:02:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2Xqj4079100; Thu, 8 Oct 2026 22:02:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsngcts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 22:02:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698M2V3Y33817300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 22:02:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64CE958052;
 Thu,  8 Oct 2026 22:02:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6104C58045;
 Thu,  8 Oct 2026 22:02:30 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.122.67]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 22:02:30 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1 0/2] s390: mark features that depend on deprecated features
 as deprecated
Date: Thu,  8 Oct 2026 17:59:54 -0400
Message-ID: <20261008215956.164881-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: asqkA2YS3sIQYT3eMI12ITZ2ypCc5bxt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NiBTYWx0ZWRfXy4LJQbVjzAdD
 RSPgwExy2LwLFiJReaAlVXppjc0+uGvbpFiTUnknXj62vTGuM0yFYqUezdojd7AqukNfeznJyoZ
 sAI4ZREf0wsydrqRhptgqhN0NZD4mlCrgZywV1IcPCSrwijSb1+EDGTbhz5p5CNS9PeD5lp2SoM
 rJIoKyEUGcOCsjC25gTNhRb74fxVOEPHp4cxNcdForWMplE3DuPeXNpsnOlFYJ3agiKAJdomKZS
 BR/eANliqYB4ZHqFkbEY4xa1YEXQfg8fmK+fnD/ecaPy2bOsZQDjGtAQj2AlTq7jHQEjw1EZcVB
 d+ldOue+1/c81nLCKWaW1YOHxRYUjWIuUPCol0+BU2JPeh0CIvAqHgpXNf0EQux+vKr1YiWi/SX
 8KaoYh2EgtcZZ0b8fUsNVVy7zEXl2aw+F48J2VgqwcTH/er2xdWynIO7NGu0APZVxkQMC5LQ0/q
 izm58hKk0zI29Mi7/HQ==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac812f9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=Yii7PyyUOqtlikobaqoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NiBTYWx0ZWRfXx1ZicKgLMcK2
 XxxewFdwt33CsLu38aeV25+1rPkMuY3PvRE82XBofeUPiEkHVpc64ttxbUBXHSMzq8IW6PIfTVd
 j4/h0xN0yOaB/YDXC0AYg2oF8Mpk0W4=
X-Proofpoint-ORIG-GUID: asqkA2YS3sIQYT3eMI12ITZ2ypCc5bxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

When the CPU model deprecated-features work was completed in QEMU, features that
have a dependency on a deprecated feature were not themselves marked deprecated.
This patch series corrects that oversight.

Specifically, ineff_nc_tx depends on te, which has been deprecated. When a user
starts a VM with deprecated features disabled, QEMU currently emits:

    warning: 'ineff_nc_tx' requires 'te'

In most cases this is only a warning, but it can also cause the VM to fail to
start entirely. One observed instance is virt-install aborting due to this warning.

With these patches, query-cpu-model-expansion includes ineff_nc_tx in the
deprecated-props array alongside the other deprecated features:

{
  "return": {
    "deprecated-props": [
      "ineff_nc_tx",
      "bpb",
      "te",
      "cte",
      "csske"
    ],
    "model": {
      "name": "gen17a-base",
      "props": { ... }
    }
  }
}

libvirt uses this response to determine which features to disable when the
deprecated_features=on|off attribute is set. With these patches, ineff_nc_tx
will be disabled along with the other deprecated features. The result can be
verified with virsh domcapabilities:

$ virsh domcapabilities --disable-deprecated-features \
    --xpath "/domainCapabilities/cpu/mode[@name='host-model']/feature[@policy='disable']"
<feature policy="disable" name="bpb"/>
<feature policy="disable" name="csske"/>
<feature policy="disable" name="cte"/>
<feature policy="disable" name="ineff_nc_tx"/>
<feature policy="disable" name="te"/>

Collin L. Walling (2):
  target/s390x: externalize feat dependency array
  target/s390x: mark feats dependent on deprecated feats as deprecated

 target/s390x/cpu_features.c | 137 +++++++++++++++++++++++++++++++++++-
 target/s390x/cpu_features.h |   4 ++
 target/s390x/cpu_models.c   | 133 ++--------------------------------
 3 files changed, 145 insertions(+), 129 deletions(-)

-- 
2.55.0


