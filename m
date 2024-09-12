Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CC4EEE258
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 20:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqQY-0001pZ-Ky; Thu, 12 Sep 2024 16:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1soqQW-0001o9-20; Thu, 12 Sep 2024 16:28:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1soqQT-0004sX-TX; Thu, 12 Sep 2024 16:28:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CJ3sNQ000999;
 Thu, 12 Sep 2024 20:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:subject:from:to:cc:date:in-reply-to:references
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 QCCSn16lkIB9HVLh+uZOX/tuuIkFmvwEnn7cR6XK/6E=; b=pq/qoYQ5dJsi7jL+
 GGizvMOimCTxFiS4hHroAlsNCGoSM88t03t4aNGbVeJAOFppNJohTYG6Xw4Jo4sU
 4lOgVnYG6ktGtc50LUgtVZb/B4wIr/ILTr5UJXxWnTlCteX0MlwPaudn8H5uWRGL
 2jjMpXd8Oi4TefN3oAaQSlgZXxDYsIJi38RhJBHyPi7NzOW54ks6Yg/5kNVPWDFC
 sdeJugt2sjzyMFMW0WdLXLrZJ2pALaefZ/adYLeiB8LlOYrhrqyIstWsczAwvOPz
 NB+2B4DkAAuo6D0vWu19CAgP6q76IeNBTGc9gNYOODtKon6IC5PGGuiik6deD6Ul
 oCrsQw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefywqr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:28:22 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKRada007576;
 Thu, 12 Sep 2024 20:28:22 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefywqr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:28:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CHik3A003155;
 Thu, 12 Sep 2024 20:28:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15uacgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:28:21 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKSKRl33620644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:28:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96C2D58053;
 Thu, 12 Sep 2024 20:28:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 322EF5805F;
 Thu, 12 Sep 2024 20:28:19 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.112.103]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:28:19 +0000 (GMT)
Message-ID: <49bc14c031dd2d1f8a1df54a3b4d7b0aec84976e.camel@linux.ibm.com>
Subject: Re: [PATCH v1 01/14] s390x/s390-virtio-ccw: don't crash on weird
 RAM sizes
From: Eric Farman <farman@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Date: Thu, 12 Sep 2024 16:28:18 -0400
In-Reply-To: <20240910175809.2135596-2-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <20240910175809.2135596-2-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iPZ5pGSu3FkjUfRiAhYCy1T2858WJ2G_
X-Proofpoint-ORIG-GUID: VnEr1AjRkxqrPDAOuPLbjMeifeX5cYgz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 2024-09-10 at 19:57 +0200, David Hildenbrand wrote:
> KVM is not happy when starting a VM with weird RAM sizes:
>=20
>   # qemu-system-s390x --enable-kvm --nographic -m 1234K
>   qemu-system-s390x: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGI=
ON
>     failed, slot=3D0, start=3D0x0, size=3D0x244000: Invalid argument
>   kvm_set_phys_mem: error registering slot: Invalid argument
>   Aborted (core dumped)
>=20
> Let's handle that in a better way by rejecting such weird RAM sizes
> right from the start:
>=20
>   # qemu-system-s390x --enable-kvm --nographic -m 1234K
>   qemu-system-s390x: ram size must be multiples of 1 MiB
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

TIL. Thanks David!

Reviewed-by: Eric Farman <farman@linux.ibm.com>

