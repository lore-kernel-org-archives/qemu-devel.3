Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35BAE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjoX-0007x8-Ps; Fri, 20 Dec 2024 15:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tOjoV-0007uZ-1P; Fri, 20 Dec 2024 15:41:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1tOjoT-000349-IF; Fri, 20 Dec 2024 15:41:34 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKHj4aV002404;
 Fri, 20 Dec 2024 20:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=tpmvnK
 KF0e7hew/w74IzdBntG8ciTgIeTTAKpuDrGtE=; b=ULTwY2+Wx6TTwYszZtqPUL
 S0/nmMEWT03rOHpAZvj7JBcqQnd6XmheH+GHh4f19XxKbRiOK9nA4xrX4eBoQNk3
 VgdfZJDSO8GpXegmnA0tTCc0mKp1gq65WyLfPaLIRWin2DAvqDmEaDqoWAGz9gLl
 ElA9a6/nwTcO+fGdYR3zqFJajlrPehw+vpvB52TzOToiit44d+UuoqI8RcheK/Xl
 Kw0emm/hIPaqAMDupr0qvK16e+KohMzMI1GhGAWLnf6T/5lz5XbmpDnqpdStqh8a
 lPnwvKVHZcHs8SGWTl4y26KfQqHajlK7BeWciGTetMooXWuK/h5bTIqW7NkirOLw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43n4s2ub5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 20:41:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKIA5rX005564;
 Fri, 20 Dec 2024 20:41:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbnkx87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Dec 2024 20:41:30 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BKKfTTO52167124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 20:41:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EC8758055;
 Fri, 20 Dec 2024 20:41:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A73565805B;
 Fri, 20 Dec 2024 20:41:27 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.67.81.112]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Dec 2024 20:41:27 +0000 (GMT)
Message-ID: <b9cb87b0a9596325fca731f7928044d411c64353.camel@linux.ibm.com>
Subject: Re: [PATCH 54/71] hw/s390x: Constify all Property
From: Eric Farman <farman@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "open list:S390 3270 device" <qemu-s390x@nongnu.org>
Date: Fri, 20 Dec 2024 15:41:26 -0500
In-Reply-To: <20241213190750.2513964-59-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-59-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yt4YzctWU9Om7dy8gJTnksFwfPgMouWV
X-Proofpoint-GUID: Yt4YzctWU9Om7dy8gJTnksFwfPgMouWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxlogscore=629 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.129, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 2024-12-13 at 13:07 -0600, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/s390x/3270-ccw.c           | 2 +-
>  hw/s390x/ccw-device.c         | 2 +-
>  hw/s390x/css-bridge.c         | 2 +-
>  hw/s390x/ipl.c                | 2 +-
>  hw/s390x/s390-pci-bus.c       | 2 +-
>  hw/s390x/s390-skeys.c         | 2 +-
>  hw/s390x/s390-stattrib.c      | 2 +-
>  hw/s390x/vhost-scsi-ccw.c     | 2 +-
>  hw/s390x/vhost-user-fs-ccw.c  | 2 +-
>  hw/s390x/vhost-vsock-ccw.c    | 2 +-
>  hw/s390x/virtio-ccw-9p.c      | 2 +-
>  hw/s390x/virtio-ccw-balloon.c | 2 +-
>  hw/s390x/virtio-ccw-blk.c     | 2 +-
>  hw/s390x/virtio-ccw-crypto.c  | 2 +-
>  hw/s390x/virtio-ccw-gpu.c     | 2 +-
>  hw/s390x/virtio-ccw-input.c   | 2 +-
>  hw/s390x/virtio-ccw-net.c     | 2 +-
>  hw/s390x/virtio-ccw-rng.c     | 2 +-
>  hw/s390x/virtio-ccw-scsi.c    | 2 +-
>  hw/s390x/virtio-ccw-serial.c  | 2 +-
>  20 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

