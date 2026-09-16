Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DC7C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJf-0007dN-Dw; Wed, 16 Sep 2026 16:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJM-0007ZU-92; Wed, 16 Sep 2026 16:32:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJK-00030f-7v; Wed, 16 Sep 2026 16:32:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1bYJ045876; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7p49WBkosdier2VoILShwSGHHeVRJYi/bsttEESp+
 oI=; b=tg6TFAdydVfUX9IOlCkzlcDvU5QtrhiQUpTggIM/tg8nNwXGZ/FvWc1r1
 e54Y9VkchBh6qhLKB/ZF+QfDQPVv6HnHScJMqD2I9waD+mo2DsCI1lCO0ZFbVNME
 wNz/secEpbNsu4hA7mQH8QCMDr7us6AZfUdzm3eh+V895jxsdYVu7yZcDD65IWA2
 hTuly4CsLCVAEnYOrK2/hez816WVvBfyBj1qvHu1QRi9Hf4wqysr/1A7y7G+tMDr
 jRg04e0DQT69/mhliB9LcPWSqrhndgLaG5ZgKXySo3lHM3E3czyEuEhZmOd6hlXQ
 EaG/NOmi6KPvELtp8k8EmnVzCleqA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv6end-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIwL5L1663520; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089r9rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWktC52953526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE56320043;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F50420040;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 77187160578; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 0/9] s390x: even more hardening fixes
Date: Wed, 16 Sep 2026 22:32:32 +0200
Message-ID: <20260916203242.2509787-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX4VVGwlK07QZZ
 iTxSCmaHlLH990Oa+f/yv4v712FPZL5QAJyn+1L3ObXF3KTILDB8z5gRL8vuqtAlQBjBQOjWQ6U
 /ca7X0StNDay2J8WJkCP6ahijkdhRAs=
X-Proofpoint-ORIG-GUID: CP7Wq0tCGEsilFjn2mru5r2tHh2JB80Q
X-Proofpoint-GUID: CP7Wq0tCGEsilFjn2mru5r2tHh2JB80Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX4Oq8JiLQOhL6
 RipQOxAlrvZDyxzIVdSKLW7RbmCAa6OIbNGLw3eRHfhwD4p6h0Jrwxobyz/J2pbuDGAlKSrwdsm
 oFfWVHdgBLhdvcWlGjH8C0d2yFbfwyl1lEmnIHshwsXlA4zmVAa1a8QqgNPJigJzRR0uChBdtbz
 YCDMlotI7t04z6RITFtDyfLE6KyfmD83Om+rxExLa0wOOkQ1i2l1AcFCr9rEkdRoTzl/aurTgar
 t4goznfSxLIIYG5PS1FuMgGu6wE3th/YgR+c0eJSfxpr/mjzwur/RU6V9ngNBbPi0O/KCl47tnY
 0GOlvad5AP/4voCLI8CVnitEzYYa9sAJUMx4rXoq8uxijTmwaPKzPa0wA0NorZ/9h5o/XTngEyE
 /RxjU4KOXeYXzA25Lklbs/XFqxNiQCjuDfHFVy+Mru1pTVpoLpKc3In91c6au84hyjJCDNdwCZu
 yeVj5G61MdG7DKEI6lA==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=aYHA4yjAF_iC5wDHXzwA:9
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

Hi Christian, Matt,

Here's a small pile of additional hardening fixes for consideration.

Took a stab at what should be cc'd to stable vs what shouldn't be,
but open to other opinions.

Eric Farman (9):
  virtio-ccw: Limit ISC to MAX_ISC
  virtio-ccw: Do not overwrite existing indicators
  virtio-ccw: Fix rc check in read configuration path
  vfio/ap: Clear error object pointer after non-fatal errors
  vfio/ccw: Clear error object pointer after non-fatal errors
  hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
  hw/intc/s390x: Fix check after g_try_realloc
  s390x/css: Expand check against no-data-count CCWs
  s390x/sclp: Reject short headers in PV case

 hw/intc/s390_flic_kvm.c |  4 ++--
 hw/s390x/css.c          | 11 +++++++++--
 hw/s390x/sclp.c         |  6 ++++++
 hw/s390x/virtio-ccw.c   | 20 ++++++++++++++++++--
 hw/vfio/ap.c            |  4 ++++
 hw/vfio/ccw.c           |  2 ++
 6 files changed, 41 insertions(+), 6 deletions(-)

--=20
2.53.0


